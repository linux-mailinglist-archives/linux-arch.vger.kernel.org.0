Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB532168721
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgBUS7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 13:59:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58466 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgBUS7F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 13:59:05 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5DVv-00GWI0-6m; Fri, 21 Feb 2020 18:59:03 +0000
Date:   Fri, 21 Feb 2020 18:59:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] regset ->get() API
Message-ID: <20200221185903.GA3929948@ZenIV.linux.org.uk>
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
 <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
 <20200220232929.GU23230@ZenIV.linux.org.uk>
 <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
 <20200221033016.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221033016.GV23230@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 03:30:16AM +0000, Al Viro wrote:

> Alternatively, we could introduce a new method, with one-by-one
> conversion to it.  Hmm...
> 	int (*get2)(struct task_struct *target,
> 		    const struct user_regset *regset,
> 		    struct membuf to);
> returning -E... on error and amount left unfilled on success, perhaps?
> That seems to generate decent code and is pretty easy on the instances,
> especially if membuf_write() et.al. are made to return to->left...

Arrrrghhh...  sparc is interesting.  For one thing, GETREGS64 uses
a format different from coredump (or GETREGSET) - instead of
	G0..G7, O0..O7, L0..L7, I0..I7, TSTATE, TPC, TNPC, (u64)Y
it's
	G1..G7, O0..O7, TSTATE, TPC, TNPC, (u64)Y
with interesting comment about Y being mishandled.  Achieved by
a couple of copy_regset_to_user() with non-zero offset ;-/

GETREGS is also different from coredump/GETREGSET - instead of
	G0..G7, O0..O7, L0..L7, I0..I7, PSR, PC, nPC, Y, 0 (WIM), 0 (TBR)
it's
	PSR, PC, nPC, Y, G1..G7, O0..O7
Again, a couple of copy_regset_to_user(), but there's an additional
twist - GETREGSET of 32bit task on sparc64 will use access_process_vm()
when trying to fetch L0..L7/I0..I7 of other task, using copy_from_user()
only when the target is equal to current.  For sparc32 this is not
true - it's always copy_from_user() there, so the values it reports
for those registers have nothing to do with the target process.  That
part smells like a bug; by the time GETREGSET had been introduced
sparc32 was not getting much attention, GETREGS worked just fine
(not reporting L*/I* anyway) and for coredump it was accessing the
caller's memory.  Not sure if anyone cares at that point...

The situation with floating point is similar.  FWIW, considering how
compact those ->get2() instances become, I wonder if we should just
go for
static int getregs_get(struct task_struct *target,
                         const struct user_regset *regset,
                         struct membuf to)
{
        const struct pt_regs *regs = task_pt_regs(target);
        int i;

        if (target == current)
                flushw_user();

        membuf_store(&to, (u32)tstate_to_psr(regs->tstate));
        membuf_store(&to, (u32)(regs->tpc));
        membuf_store(&to, (u32)(regs->tnpc));
        membuf_store(&to, (u32)(regs->y));
        for (i = 1; i < 16; i++)
                membuf_store(&to, (u32)regs->u_regs[i]);
        return to.left;
}

static int getfpregs_get(struct task_struct *target,
                        const struct user_regset *regset,
                        struct membuf to)
{
	struct thread_info *t = task_thread_info(target);

        if (target == current)
                save_and_clear_fpu();

        membuf_write(&to, t->fpregs, 32 * sizeof(u32));
        if (t->fpsaved[0] & FPRS_FEF)
                membuf_store(&to, (u32)t->xfsr[0]);
        else
                membuf_zero(&to, sizeof(u32));
        return membuf_zero(&to, 35 * sizeof(u32));
}

and slap together a couple of struct user_regset refering to those,
so that PTRACE_GETREGS/PTRACE_GETFPREGS would just use solitary
copy_regset_to_user() calls on those, rather than trying to
paste them out of several calls on the normal regsets...

FWIW, they do shrink nicely - compare e.g.
static int fpregs64_get(struct task_struct *target,
                        const struct user_regset *regset,
                        struct membuf to)
{
        const unsigned long *fpregs = task_thread_info(target)->fpregs;
        unsigned long fprs;

        if (target == current)
                save_and_clear_fpu();

        fprs = task_thread_info(target)->fpsaved[0];

        if (fprs & FPRS_DL)
                membuf_write(&to, fpregs, 16 * sizeof(u64));
        else
                membuf_zero(&to, 16 * sizeof(u64));
        if (fprs & FPRS_DU)
                membuf_write(&to, fpregs + 16, 16 * sizeof(u64));
        else
                membuf_zero(&to, 16 * sizeof(u64));
        if (fprs & FPRS_FEF) {
                membuf_store(&to, task_thread_info(target)->xfsr[0]);
                membuf_store(&to, task_thread_info(target)->gsr[0]);
        } else {
                membuf_zero(&to, 2 * sizeof(u64));
        }
        return membuf_store(&to, fprs);
}
with the same function in mainline arch/sparc/kernel/ptrace_64.c...
