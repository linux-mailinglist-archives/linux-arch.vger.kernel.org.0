Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429720E4BB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgF2V21 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D84C033C06;
        Mon, 29 Jun 2020 11:23:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyRZ-002DlU-QS; Mon, 29 Jun 2020 18:23:50 +0000
Date:   Mon, 29 Jun 2020 19:23:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [RFC][PATCHSET] regset ->get() rework
Message-ID: <20200629182349.GA2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are several problems with regset API:

	regsets' methods are too generic, clumsy as hell and the inline helpers
intended to hide most of the headache have very inconvenient calling conventions.
For starters, ->get() (the method used to fetch a part of regset)
	* can have both userland and kernel destination (gets two pointers, one of
them being NULL)
	* can (theoretically) be called to fetch _any_ part of regset - possibly
starting in the middle of the damn thing.  There are very few (and very irregular)
users of that, er, feature.  Moreover, all of them know which ->get() instance they
are going to hit and quite a few ->get() instances outright say that they rely
upon nobody calling them that way.  Even more instances say nothing and still rely
upon the same.  And even the instances that *are* called that way rely upon the
knowledge of the specific offsets that might be requested.  "Brittle" doesn't
begin to describe that; it also makes the instances that attempt to handle arbitrary
offsets convoluted for no good reason.  And all the irregular callers are easily dealt
with without playing with that.
	* the helpers attempt to be too flexible and end up being too inconvenient.
They try to allow writing the pieces of data out of order - pwrite(2) rather than
write(2), if you will.  And their calling conventions are worse than those of
pwrite(2)...  It's also an attractive nuisance - if you end up having skipped
some range of offsets, there's no way for the caller to know.  Out of all
the instances only one tried to make use of those non-sequential writes - and
fucked up in process.
	* instances have to deal with the possibility of uaccess failures halfway
through.  Again, it complicates the logics for no good reason.
	* instances have no way to report how much data would they like to produce;
as the result, an additional method (->get_size()) had been invented (with only
one instance).  And handling of that thing in PTRACE_GETREGSET is broken - it's
*not* reported to the caller and there's no direct way to tell that the end of
userland buffer is left unmodified.

	Life would be much simpler if we replaced ->get() with something that
1) always writes to kernel space.
2) always writes sequentially, starting from offset 0 and up to given (bounded)
size.
3) returns an error or the amount of space left in the buffer.

	Turns out it's not that hard to do.  Callers that want the data to
go to userland can bloody well do copy_to_user() themselves.  Non-sequential
stores are simply not there anymore - not since the x86 bug got fixed last cycle.
 Callers that want non-zero starting offsets are very few and are essentially
trying to paste pieces of regset together, possibly with some parts
skipped/in different order/with different alignments/etc.  Those are easily
dealt with by providing a separate regset with the desired contents.  There are
4 locations where specific ->get() instances are called directly and 3 locations
that call ->get() instances via method.  Let's take them in order:

	[ia64] access_uarea() contains direct calls of fpregs_get() and gpregs_get().
Destination is a kernel buffer, the subset being accessed is a word at varying offset
in the corresponding regset.  That needs careful teasing apart; it's better to have
access_uarea() use the lower-level helpers instead of calling [gf]pregs_[gs]et() there.
Doable with some massage.

	[sh] dump_fpu() calls (sh) fpregs_get(); destination is a kernel buffer,
the entire regset contents gets written out.  Used by ELF_FDPIC coredumps;
ELF coredumps on sh are _not_ reaching that code.  We need to switch ELF_FDPIC
coredumps to the same machinery ELF coredumps use; then this will become dead
code.  However, as far as ->get() API change is concerned, that call is nothing
irregular - we write the entire regset out to a kernel buffer.  So we can leave
the removal of that code until we deal with ELF_FDPIC and for now just keep in
mind that this instance of ->get2() is called directly.  Just change the
arguments to match the new calling conventions and that's it.

	[x86] dump_fpu() calls (x86) fpregs_get().  That one is very simple to deal
with, seeing that the only caller used to be aout coredump support, which got (finally)
removed last year.  Dead code, IOW...

	[ELF] a couple of callers in fill_thread_core_info().  That's what ELF coredumps
normally use; destination is a kernel buffer, the entire regset gets written out.

	Finally, there's copy_regset_to_user().  That's the only place where we
ask ->get() to write to userland and it can bloody well allocate a kernel buffer,
let ->get() fill it and then do copy_to_user() of the entire thing.  That function
is used by handlers of various ptrace(2) commands (the most generic one is
PTRACE_GETREGSET).  Almost all callers ask to write a range starting at the
beginning of regset (and most of those ask to write the entire regset out);
However, there are few exceptions:

	[arm64] compat_ptrace_read_user() uses copy_regset_to_user() to fetch the
value of given register and write it to userland.  Pointless kludge, since it's
much easier to do what native arm does - supply a trivial function that returns
given register of given process and copy the result to userland, same way as we
do in other cases of compat_ptrace_read_user().

	[sparc] PTRACE_GETREGS and PTRACE_GETFPREGS cobble the layout they
want out of pieces of regsets.  It's much easier to provide a regset producing
just the layout they want and use it instead of the generic ones.

	IOW, we can regularize the callers with a bit of preliminary work,
then convert to new method with better calling conventions.  The following
series attempts to do that; it can be found in 
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.regset
(and in the followups to this posting).  Based at 5.8-rc1, there are
5 short branches with preparations (#regset.{base,x86,sparc,arm64,ia64})
merged together and followed by the bulk of the series.

	Patch overviews follow:

#regset.base:
01/41) helpers for regset ->get() replacement
	We start with providing wrappers for ->get() that have saner calling
conventions than ->get() itself.  That is,
	* they always copy to kernel buffer
	* they are given the upper limit on the amount to copy and return the
amount actually copied or -E... on error.  If regset has less than the amount
required, it writes as much as it can.
	One of those wrappers copies into preexisting buffer, another allocates
and writes there (allocation size is bounded by the size limit and by the
amount regset is expected to have; user asking for half a gigabyte worth of
register contents won't trigger half a gigabyte allocation).
	Those wrappers live in (newly added) kernel/regset.c; none of them
is going to be called on sufficiently hot codepath to warrant inlining.
Initially we can't convert all callers of ->get() to those.  ELF coredump
callers can be immediately converted, but ptrace ones need more preparations.

Now we regularize the callers.  That's done on per-architecture basis:

#regset.x86
02/41) x86: copy_fpstate_to_sigframe(): have fpregs_soft_get() use kernel buffer
03/41) x86: kill dump_fpu()
	On x86 we have two irregularities: there's a part of an instance of ->get()
(helper with the identical calling conventions, that is) that gets directly called
with userland destination.  It's _not_ a fast path - we need FPU emulation to be used
in order to hit it, and at that point extra copying of 108 bytes is noise by any
definition.  Fuck it; call that ->get() instance with local variable as destination,
then copy_to_user().
	Another direct call of an instance is in dead code (dump_fpu(), not used
since the removal of aout coredumps).  That one simply gets removed.

NB: calling conventions of copy_fpstate_to_sigframe() are silly.  If you look
at the call chains, anything negative ends up with force_sigsegv(); 0 or any
positive qualifies as success.  IOW, it really returns just one bit of information,
while creating an impression that we somehow are reporting details.  We are, after
all, trying to save the userland state while entering a signal handler; whom
could we possibly return an error to?  copy_fpstate_to_sigframe(), along with
__setup_rt_frame(), etc. ought to return bool.

#regset.ia64:
04/41) [ia64] sanitize elf_access_gpreg()
05/41) [ia64] teach elf_access_reg() to handle the missing range (r16..r31)
06/41) [ia64] regularize do_gpregs_[gs]et()
07/41) [ia64] access_uarea(): stop bothering with gpregs_[gs]et()
08/41) [ia64] access_uarea(): don't bother with fpregs_[gs]et()

	The problem here is that access_uarea() (the guts of PTRAGE_POKEUSR/
PTRACE_PEEKUSR) contains direct calls of ->get() (and ->set()) instances,
for accessing single registers.  They already have a function for doing
pretty much that - access_elf_reg() (almost - it doesn't handle r16..r31,
but that's trivial to do, simplifying the logics in callers).

	gpregs_get() and gpregs_set() arrange for stack unwinder to collect
the information of where the user callee-saved registers have ended up
spilled on kernel stack.  Then they start calling access_elf_reg(), with
bloody awful switches that remap the offsets in regset to register numbers.
access_uarea(), in turn, remaps _its_ offsets into regset ones and calls
gpregs_get()/gpregs_set().

	A lot of extra complexity comes from gpregs_get() trying to bunch
the copyouts together - it puts the values of several registers into an
array, then copies them out all at once.

	In that branch:
* clean elf_access_breg() up, get rid of the switch in the damn thing.
* teach elf_access_reg() to handle the missing range of registers (r16..r31)
* regularize the after-unwind part of gpregs_get()/gpregs_set() - with
elf_access_reg() becoming able to handle that range, the bunching logics in
those become much simpler.
* switch access_uarea() to calling elf_access_reg() directly, eliminating
the calls of gpregs_get()/gpregs_set() in there.
* same for floating point registers, only there we used to call different
->get()/->set() instances.

	One note on access_uarea(): it never returns positive and its
callers choose between using "not zero" and "negative" pretty much
at random.

#regset.sparc
09/41) sparc64: switch genregs32_get() to use of get_from_target()
10/41) sparc32: get rid of odd callers of copy_regset_to_user()
11/41) sparc64: get rid of odd callers of copy_regset_to_user()
12/41) sparc32: get rid of odd callers of copy_regset_from_user()
13/41) sparc64: get rid of odd callers of copy_regset_from_user()

	First patch in the series is a  cleanup in one of the ->get()
instances (open-coded reading the target's memory, rather than using
the helper already in the same file).  That's right next to the place
that will need modifications in ->get() conversion later, so splitting
that into a separate commit makes the things easier to follow.
	Next several "paste pieces of regset together and copy them to
userland" are dealt with by adding new regsets, with ->get() instances
directly producing the layout wanted by those ptrace commands, so that
a single copy_regset_to_user() would do the right thing.  Incidentally,
that simplifies ->get() instances that used to be called by those ptrace
commands - now they are never called with non-zero offset.
	While not strictly necessary for this series, the same thing is
done to copy_regset_from_user() counterparts of those, so that all
pasting pieces of regsets together would be gone.
	NB: PTRAGE_GETREGS64 has a minor behaviour change - it used to
leave pregs->uregs[15] untouched, now it zeroes it.

#regset.arm64:
14/41) arm64: take fetching compat reg out of pt_regs into a new helper
15/41) arm64: get rid of copy_regset_to_user() in compat_ptrace_read_user()
16/41) arm64: sanitize compat_ptrace_write_user()

	arm64 compat handling of PTRACE_PEEKUSR/PTRACE_POKEUSR abuses
copy_regset_{to,from}_user().  All we want in those is access to
a single register; it's easier to lift the logics for fetching
a register out of compat_gpr_get() into a helper function, call
it in PTRACE_PEEKUSR handler and use put_user() to store its
return value; that's pretty much what the native arm ptrace does.
PTRACE_POKEUSR is, strictly speaking, unrelated to this series, but
it's too obscene to live - it has the value to store into given
register, so it does set_fs(KERNEL_DS) and calls copy_regset_from_user()
with the address of the local variable that contains the new value.
That's one hell of a way to copy a value into a field of pt_regs...

	At that point we are done with prep work.  The branches above
(#regset.{base,x86,ia64,sparc,arm64}) converge into #work.regset.

#work.regset
17/41) copy_regset_to_user(): do all copyout at once.
	By now callers of ->get() instances pass 0 as offset and
all but one (copy_regset_to_user()) have kernel-space destinations.
Convert that last caller to use of regset_get_alloc().

18/41) regset: new method and helpers for it
	This is the core of the series.  A replacement for ->get()
is introduced, hopefully with saner calling conventions.
	->get2() takes task+regset+buffer, returns the amount of
free space left in the buffer on success and -E... on error.
buffer is represented as struct membuf - a pair of (kernel) pointer
and amount of space left.  Note that buffer is passed by value -
that leads to better code generation, since the instances can
just keep the components in registers - stores to those don't need
to be visible to the caller.
	Primitives for writing to such:
		* membuf_write(buf, data, size)
		* membuf_zero(buf, size)
		* membuf_store(buf, value)
These are implemented as inlines (in case of membuf_store - a macro).
All writes are sequential; they become no-ops when there's no space
left.  Return value of all primitives is the amount of space left
after the operation, so they can be used as return values of ->get2().
    
Example of use:
// stores pt_regs of task + 64 bytes worth of zeroes + 32bit PID of task
int foo_get(struct task_struct *task, const struct regset *regset,
            struct membuf to)
{
	membuf_write(&to, task_pt_regs(task), sizeof(struct pt_regs));
	membuf_zero(&to, 64);
	return membuf_store(&to, (u32)task_tgid_vnr(task));
}

regset_get()/regset_get_alloc() taught to use that thing if present.
By the end of the series all users of ->get() will be converted;
then ->get() and ->get_size() can go.
	Note that unlike ->get() this thing always starts at offset 0
and, since it only writes to kernel buffer, can't fail on copyout.
It can, of course, fail for other reasons, but those tend to
be less numerous.
	The caller guarantees that the buffer size won't be bigger than
regset->n * regset->size.  That simplifies life for quite a few instances.


	Now we are going to convert architectures from ->get() to ->get2().

19/41) x86: switch to ->get2()
20/41) powerpc: switch to ->get2()
21/41) s390: switch to ->get2()
22/41) sparc: switch to ->get2()
23/41) mips: switch to ->get2()
24/41) arm64: switch to ->get2()
25/41) sh: convert to ->get2()
26/41) arm: switch to ->get2()
27/41) arc: switch to ->get2()
28/41) ia64: switch to ->get2()
29/41) c6x: switch to ->get2()
30/41) riscv: switch to ->get2()
31/41) openrisc: switch to ->get2()
32/41) h8300: switch to ->get2()
33/41) hexagon: switch to ->get2()
34/41) nios2: switch to ->get2()
35/41) nds32: switch to ->get2()
36/41) parisc: switch to ->get2()
37/41) xtensa: switch to ->get2()
38/41) csky: switch to ->get2()

With those done we have no ->get() instances left.  Moreover,
the only ->get_size() call is unreachable.  And no callers of
old helpers remain either.

39/41) regset: kill ->get()
40/41) regset(): kill ->get_size()
41/41) regset: kill user_regset_copyout{,_zero}()

	This is *not* all I have for regsets, but I'd rather keep
e.g. fdpic conversion to regsets as part of ELF coredump work.
This just deals with ->get().  Please, review and comment.

Diffstat:
 arch/arc/kernel/ptrace.c                    | 148 +++----
 arch/arm/kernel/ptrace.c                    |  52 +--
 arch/arm64/kernel/ptrace.c                  | 303 +++++---------
 arch/c6x/kernel/ptrace.c                    |  11 +-
 arch/csky/kernel/ptrace.c                   |  24 +-
 arch/h8300/kernel/ptrace.c                  |  17 +-
 arch/hexagon/kernel/ptrace.c                |  62 +--
 arch/ia64/kernel/ptrace.c                   | 396 +++++++------------
 arch/mips/kernel/ptrace.c                   | 204 +++-------
 arch/nds32/kernel/ptrace.c                  |   9 +-
 arch/nios2/kernel/ptrace.c                  |  51 +--
 arch/openrisc/kernel/ptrace.c               |  26 +-
 arch/parisc/kernel/ptrace.c                 |  84 +---
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  37 +-
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  44 +--
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   5 +-
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |  16 +-
 arch/powerpc/kernel/ptrace/ptrace-tm.c      | 152 +++----
 arch/powerpc/kernel/ptrace/ptrace-view.c    | 185 ++++-----
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  13 +-
 arch/riscv/kernel/ptrace.c                  |  33 +-
 arch/s390/kernel/ptrace.c                   | 199 +++-------
 arch/sh/kernel/process_32.c                 |   5 +-
 arch/sh/kernel/ptrace_32.c                  |  48 +--
 arch/sparc/kernel/ptrace_32.c               | 265 +++++++------
 arch/sparc/kernel/ptrace_64.c               | 591 ++++++++++++++--------------
 arch/x86/include/asm/fpu/internal.h         |   1 -
 arch/x86/include/asm/fpu/regset.h           |   4 +-
 arch/x86/include/asm/fpu/xstate.h           |   4 +-
 arch/x86/kernel/fpu/regset.c                |  55 +--
 arch/x86/kernel/fpu/signal.c                |  13 +-
 arch/x86/kernel/fpu/xstate.c                | 164 ++------
 arch/x86/kernel/ptrace.c                    |  75 ++--
 arch/x86/kernel/tls.c                       |  32 +-
 arch/x86/kernel/tls.h                       |   2 +-
 arch/x86/math-emu/fpu_entry.c               |  19 +-
 arch/xtensa/kernel/ptrace.c                 |  16 +-
 fs/binfmt_elf.c                             |  54 ++-
 include/linux/regset.h                      | 218 +++-------
 kernel/Makefile                             |   2 +-
 kernel/regset.c                             |  76 ++++
 41 files changed, 1368 insertions(+), 2347 deletions(-)
