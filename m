Return-Path: <linux-arch+bounces-13256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A1B32AE4
	for <lists+linux-arch@lfdr.de>; Sat, 23 Aug 2025 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B26AA0B73
	for <lists+linux-arch@lfdr.de>; Sat, 23 Aug 2025 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7F221D88;
	Sat, 23 Aug 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnaxQnNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmEtq2GM"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A032481DD;
	Sat, 23 Aug 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967151; cv=none; b=L4QHdwxzCcDcvpgc2i973AB0e+rI1u56GkP1hkLWYsOCVjCF/Z+Y/Gs6bn3ywlr8S/QTHPhrGnIF9k/lVrd0yfARRCQATDunSpjeE0ogkI3VKSQ1mme9IyZpQtbj7tg1tGRM16cIrHd+HyZ0vTz4je3p0pEFrxABY6tQa+gnwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967151; c=relaxed/simple;
	bh=cJCCorfERzRLf69ib7JL8tpz6iNSbsBXkFfObiouAzM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cv/6Jm9xuHR8CUuzk1ra1Luvxxa+z40dAy7I2km7z3eLTUoKxrVijYzGCbEG6gMalPVgSmiPJIhlL8FGpdiKMSQGY6agwU+W3N8UEVbSq1kYnSjQR6zrt7i6l2pnr+ZOS+goYwNvlAfkLbdQAAM5pS7GQhF9DJbInWtpWETvg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YnaxQnNj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmEtq2GM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161326.635281786@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=iYpsY6H5fJv+fsgVthgf7WA7ACFO7f9cZwt+padVv/o=;
	b=YnaxQnNjuSS83t64mzG0auK+uSiO3cnmlFDGE40sxarMe1H0sdhW1e8zmQtvudqTPcKCOS
	QNWfJV7dcssQlB3w7DL42KgVFrexzf0+IbCJL+73XumEYKREoACxKzqyWJsU7cOdV47aXF
	p+5KjOosEVHeuEhN5QqQjzF5dk+IuZZmCDiPtdSPpa/yAYsOMDdRM25xxZ00EtA7jBAYhe
	aIlYYIvB+1ypZCrBGsD++Jh/g8DjAvKlkCDzkrBV22MkZcQK3oFtL/+L12VczGAs2M6SvS
	JODV3EwVwQhFtDuOSoPxrSjoD3eTRxiUNvQbgElWpHJvCbphCG/oT+x/QE9hVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=iYpsY6H5fJv+fsgVthgf7WA7ACFO7f9cZwt+padVv/o=;
	b=SmEtq2GM3ULz1wyARI4ddsp4znflvvbACSX5hQT84WZ9bc2XZkdtQRVcHWn3pwDAHlVSSo
	QQYj2BijmZcZL4Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-arch@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonas Bonn <jonas@southpole.se>
Subject: [patch V2 00/37] rseq: Optimize exit to user space
Date: Sat, 23 Aug 2025 18:39:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

OA
This is a follow up on the initial series, which did a very basic attempt
to sanitize the RSEQ handling in the kernel:

   https://lore.kernel.org/all/20250813155941.014821755@linutronix.de

Further analysis turned up more than these initial problems:

  1) task::rseq_event_mask is a pointless bit-field despite the fact that
     the ABI flags it was meant to support have been deprecated and
     functionally disabled three years ago.

  2) task::rseq_event_mask is accumulating bits unless there is a critical
     section discovered in the user space rseq memory. This results in
     pointless invocations of the rseq user space exit handler even if
     there had nothing changed. As a matter of correctness these bits have
     to be clear when exiting to user space and therefore pristine when
     coming back into the kernel. Aside of correctness, this also avoids
     pointless evaluation of the user space memory, which is a performance
     benefit.

  3) The evaluation of critical sections does not differentiate between
     syscall and interrupt/exception exits. The current implementation
     silently tolerates and fixes up critical sections which invoked a
     syscall unless CONFIG_DEBUG_RSEQ is enabled.

     That's just wrong. If user space does that on a production kernel it
     can keep the pieces. The kernel is not there to proliferate mindless
     user space programming and letting everyone pay the performance
     penalty.

Additional findings:

  4) The decision to raise the work for exit is more than suboptimal.
     Basically every context switch does so if the task has rseq, which is
     nowadays likely as glibc makes use of it if available.

     The consequence is that a lot of exits have to process RSEQ just for
     nothing. The only reasons to do so are:

       the task was interrupted in user space and schedules

     or

       the CPU or MM CID changes in schedule() independent of the entry
       mode

     That reduces the invocation space obviously significantly.

  5) Signal handling does the RSEQ update unconditionally.

     That's wrong as the only reason to do so is when the task was
     interrupted in user space independent of a schedule event.

     The only important task in that case is to handle the critical section
     because after switching to the signal frame the original return IP is
     not longer available.

     The CPU/MM CID values do not need to be updated at that point as they
     can change again before the signal delivery goes out to user space.

     Again, if the task was in a critical section and issued a syscall then
     it can keep the pieces as that's a violation of the ABI contract.

  6) CPU and MM CID are updated unconditionally

     That's again a pointless exercise when they didn't change. Then the
     only action required is to check the critical section if and only if
     the entry came via an interrupt.

     That can obviously be avoided by caching the values written to user
     space and avoiding that path if they haven't changed

  7) The TIF_NOTIFY_RESUME mechanism is a horrorshow

     TIF_NOTIFY_RESUME is a multiplexing TIF bit and needs to invoke the
     world and some more. Depending on workloads this can be set by
     task_work, security, block and memory management. All unrelated to
     RSEQ and quite some of them are likely to cause a reschedule.
     But most of them are low frequency.

     So doing this work in the loop unconditionally is just waste. The
     correct point to do this is at the end of that loop once all other bits
     have been processed, because that's the point where the task is
     actually going out to user space.

  8) #7 caused another subtle work for nothing issue

     IO/URING and hypervisors invoke resume_user_mode_work() with a NULL
     pointer for pt_regs, which causes the RSEQ code to ignore the critical
     section check, but updating the CPU ID/ MM CID values unconditionally.

     For IO/URING this invocation is irrelevant because the IO workers can
     never go out to user space and therefore do not have RSEQ memory in
     the first place. So it's a non problem in the existing code as
     task::rseq is NULL in that case.

     Hypervisors are a different story. They need to drain task_work and
     other pending items, which are multiplexed by TIF_NOTIFY_RESUME,
     before entering guest mode.

     The invocation of resume_user_mode_work() clears TIF_NOTIFY_RESUME,
     which means if rseq would ignore that case then it could miss a CPU
     or MM CID update on the way back to user space.

     The handling of that is just a horrible and mindless hack as the event
     might be re-raised between the time the ioctl() enters guest mode and
     the actual exit to user space.

     So the obvious thing is to ignore the regs=NULL call and let the
     offending hypervisor calls check when returning from the ioctl()
     whether the event bit is set and re-raise the notification again.

  9) Code efficiency

     RSEQ aims to improve performance for user space, but it completely
     ignores the fact, that this needs to be implemented in a way which
     does not impact the performance of the kernel significantly.

     So far this did not pop up as just a few people used it, but that has
     changed because glibc started to use it widely.

     It's not so efficiOS^H^Hent as advertised:

     For a full kernel rebuild:

     	 exit to user:                  50106428
	 signal checks:                    24703
	 slowpath runs:                   943785 1.88%
	 id updates:                      968488 1.93%
	 cs checks:                       888768 1.77%
	   cs cleared:                      888768 100.00%
	   cs fixup:                             0 0.00%

     The cs_cleared/fixup numbers are relative to cs_checks, which means
     this does pointless clears even if it was clear already because that's
     what is the case with glibc. glibc is only interested in the CPU/MM
     CID values so far. And no, it's not only a store, it's the whole dance
     of spectre-v1 mitigation plus user access enable/disable.

     I really have to ask why all those people who are deeply caring about
     performance and have utilized this stuff for quite some time have not
     noticed what a performance sh*tshow this inflicts on the kernel.

     Seriously?

     Aside of that did anyone ever look at the resulting assembly code?

     While the user space counterpart is carefully crafted in hand written
     assembly for efficiency the kernel implementation is a complete and
     utter nightmare.

     C allows to implement very efficient code, but the fact that the
     compiler requires help from the programmer to turn it into actual
     efficient assembly is not a totally new finding.

     The absence of properly designed data structures, which allow to build
     efficient and comprehensible code, is amazing.

     Slapping random storage members into struct task_struct, implementing
     a conditional maze around them and then hoping that the compiler will
     create sensible code out of it, is wishful thinking at best.

     I completely understand that all the sanity checks and loops and hoops
     were required to get this actually working. But I'm seriously grumpy
     about the fact, that once the PoC code was shoved into the kernel, the
     'performance work' was completed and just the next fancy 'performance'
     features were piled on top of it.

     Once this is addressed the above picture changes completely:

          exit to user:                  50071399
	  signal checks:                      182
	  slowpath runs:                     8149 0.02%
	  fastpath runs:                   763366 1.52%
	  id updates:                       78419 0.16%
	  cs checks:                            0 0.00%
	  cs cleared:                           0
	  cs fixup:                             0

     And according to perf that very same kernel build consistently gets
     faster from:

           92.500894648 seconds time elapsed (upstream)

     to

           91.693778124 seconds time elapsed

     Not a lot but not in the noise either, i.e. >= 1%

     For a 1e9 gettid() loop this results in going from:

           49.782703878 seconds time elapsed (upstream)

     to

      	   49.327360851 seconds time elapsed

     Not a lot either, but consistently >=1% as the above.

     For actual rseq critical section usage this makes even more of a
     difference. Aside of avoiding pointless work in the kernel this does
     also not abort critical sections when not necessary, which improves
     user space performance too. The kernel selftests magically complete
     six seconds faster, which is again not a lot compared to a total run
     time of ~540s. But those tests are not really reflecting real work
     loads, they emphasize on stress testing the kernel implementation,
     which is perfectly fine. But still, the reduced amount of pointless
     kernel work is what makes the difference:

     Upstream:

	exit to user:                 736568321
	signal checks:                 62002182
	slowpath runs:                358362121 57.07%
	fastpath runs:                        0 0.00%
	id updates:                   358362129 57.07%
	cs checks:                    358362110 57.07%
	  cs cleared:                   347611246 97.01%
	  cs fixup:                      10750863  2.99%

     Upstream + simple obvious fixes:

	exit to user:                 736462043
	signal checks:                 61902154
	slowpath runs:                223394362 30.33%
	fastpath runs:                        0 0.00%
	id updates:                   285296516 38.74%
	cs checks:                    284430371 38.62%
	  cs cleared:                   277110571 97.43%
	  cs fixup:                       7319800  2.57%

     Fully patched:

        exit to user:                 736477630
	signal checks:                        0
	slowpath runs:                     1367 0.00%
	fastpath runs:                114230240 15.51%
	id updates:                   106498492 14.46%
	cs checks:                      7665511 1.04%
	  cs cleared:                     2092386 27.30%
	  cs fixup:                       5573118 72.70%

     Perf confirms:

       46,242,994,988,432      cycles
        8,390,996,405,969      instructions

           1949.923762000 seconds user
          16111.947776000 seconds sys

       versus:

       44,910,362,743,328      cycles		-3 %
        8,305,138,767,914      instructions     -1 %

           1985.342453000 seconds user		+2 %
          15653.639218000 seconds sys		-3 %

     Running the same with only looking at the kernel counts:

      1) Upstream:

         39,530,448,181,974      cycles:khH
          2,872,985,410,904      instructions:khH
            640,968,094,639      branches:khH

      2) Upstream + simple obvious fixes:
                                                            -> #1
         39,005,607,758,104      cycles:khH                 -1.5 %
          2,853,676,629,923      instructions:khH           -0.8 %
            635,538,256,875      branches:khH               -1.0 %

      3) Fully patched:
						   -> #2    -> #1
         38,786,867,052,870      cycles:khH        -0.6 %   -2.3 %
          2,784,773,121,491      instructions:khH  -2.5 %   -3.1 %
            618,677,047,160      branches:khH      -2.7 %   -3.6 %

     Looking at the kernel build that way:

      1) Upstream:

        474,191,665,063      cycles:khH
        164,176,072,767      instructions:khH
         33,037,122,843      branches:khH

      2) Upstream + simple obvious fixes:
                                                            -> #1
         473,423,488,450      cycles:khH 		    ~0.0 %          
         162,749,873,914      instructions:khH              -1.0 %
          32,264,397,605      branches:khH                  -2.5 %

      3) Fully patched:
                                                   -> #2    -> #1
         468,658,348,098      cycles:khH           -1.1 %   -1.2 %
         160,941,028,283      instructions:khH     -1.2 %   -2.0 %
          31,893,296,267      branches:khH         -1.5 %   -3.7 %

     That's pretty much in line with the 2-3% regressions observed by Jens.

     TBH, I absolutely do not care about the way how performance is
     evaluated in the entities who pushed for this, but I very much care
     about the general impact of this.

     It seems to me the performance evaluation by the $corp power users of
     RSEQ stopped at the point where a significant improvement in their
     user space was observed. It's interesting, that the resulting overhead
     in the kernel seems not that relevant for the overall performance
     evaluation. That's left to others to mop up.

     The tragedy of the commons in action.

TBH, what surprised me most when looking into this in detail, was the large
amount of low hanging fruit, which was sitting there in plain sight.

That said, this series addresses the overall problems by:

  1) Limiting the RSEQ work to the actual conditions where it is
     required. The full benefit is only available for architectures using
     the generic entry infrastructure. All others get at least the basic
     improvements.

  2) Re-implementing the whole user space handling based on proper data
     structures and by actually looking at the impact it creates in the
     fast path.

  3) Moving the actual handling of RSEQ out to the latest point in the exit
     path, where possible. This is fully inlined into the fast path to keep
     the impact confined.

     The initial attempt to make it completely independent of TIF bits and
     just handle it with a quick check unconditionally on exit to user
     space turned out to be not feasible. On workloads which are doing a
     lot of quick syscalls the extra four instructions add up
     significantly.

     So instead I ended up doing it at the end of the exit to user TIF
     work loop once when all other TIF bits have been processed. At this
     point interrupts are disabled and there is no way that the state
     can change before the task goes out to user space for real.

  Versus the limitations of #1 and #3:

   I wasted several days of my so copious time to figure out how to not
   break all the architectures, which still insist on benefiting from core
   code improvements by pulling everything and the world into their
   architecture specific hackery.

   It's more than five years now that the generic entry code infrastructure
   has been introduced for the very reason to lower the burden for core
   code developers and maintainers and to share the common functionality
   across the architecture zoo.

   Aside of the initial x86 move, which started this effort, there are only
   three architectures who actually made the effort to utilize this. Two of
   them were new ones, which were asked to use it right away.

   The only existing one, which converted over since then is S390 and I'm
   truly grateful that they improved the generic infrastructure in that
   process significantly.

   On ARM[64] there are at least serious efforts underway to move their
   code over.

   Does everybody else think that core code improvements come for free and
   the architecture specific hackery does not put any burden on others?

   Here is the hall of fame as far as RSEQ goes:

   	arch/mips/Kconfig:      select HAVE_RSEQ
	arch/openrisc/Kconfig:  select HAVE_RSEQ
	arch/powerpc/Kconfig:   select HAVE_RSEQ

   Two of them are barely maintained and shouldn't have RSEQ in the first
   place....

   While I was very forthcoming in the past to accomodate for that and went
   out of my way to enable stuff for everyone, but I'm drawing a line now.

   All extra improvements which are enabled by #1/#3 depend hard on the
   generic infrastructure.

   I know that it's quite some effort to move an architecture over, but
   it's a one time effort and investment into the future. This 'my
   architecture is special for no reason' mindset is not sustainable and
   just pushes the burden on others. There is zero justification for this.

   Not converging on common infrastructure is not only a burden for the
   core people, it's also a missed opportunity for the architectures to
   lower their own burden of chasing core improvements and implementing
   them each with a different set of bugs.

   This is not the first time this happens. There are enough other examples
   where it took ages to consolidate on common code. This just accumulates
   technical debt and needless complexity, which everyone suffers from.

   I have happily converted the four architectures, which use the generic
   entry code over, to utilize a shared generic TIF bit header so that
   adding the TIF_RSEQ bit becomes a two line change and all four get the
   benefit immediately. That was more consequent than just adding the bits
   for each of them and it makes further maintainence of core
   infrastructure simpler for all sides. See?


That said, as for the first version these patches have a pile of dependencies:

The series depends on the separately posted rseq bugfix:

   https://lore.kernel.org/lkml/87o6sj6z95.ffs@tglx/

and the uaccess generic helper series:

   https://lore.kernel.org/lkml/20250813150610.521355442@linutronix.de/

and a related futex fix in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

The combination of all of them and some other related fixes (rseq
selftests) are available here:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/base

For your convenience all of it is also available as a conglomerate from
git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

The diffstat looks large, but a lot of that is due to extensive comments
and the extra hackery to accommodate for random architecture code.

I did not yet come around to test this on anything else than x86. Help with
that would be truly appreciated.

Thanks,

	tglx

  "Additional problems are the offspring of poor solutions." - Mark Twain
	
---
 Documentation/admin-guide/kernel-parameters.txt |    4 
 arch/Kconfig                                    |    4 
 arch/loongarch/Kconfig                          |    1 
 arch/loongarch/include/asm/thread_info.h        |   76 +-
 arch/riscv/Kconfig                              |    1 
 arch/riscv/include/asm/thread_info.h            |   29 -
 arch/s390/Kconfig                               |    1 
 arch/s390/include/asm/thread_info.h             |   44 -
 arch/x86/Kconfig                                |    1 
 arch/x86/entry/syscall_32.c                     |    3 
 arch/x86/include/asm/thread_info.h              |   74 +-
 b/include/asm-generic/thread_info_tif.h         |   51 ++
 b/include/linux/rseq_entry.h                    |  601 +++++++++++++++++++++++
 b/include/linux/rseq_types.h                    |   72 ++
 drivers/hv/mshv_root_main.c                     |    2 
 fs/binfmt_elf.c                                 |    2 
 fs/exec.c                                       |    2 
 include/linux/entry-common.h                    |   38 -
 include/linux/irq-entry-common.h                |   68 ++
 include/linux/mm.h                              |   25 
 include/linux/resume_user_mode.h                |    2 
 include/linux/rseq.h                            |  216 +++++---
 include/linux/sched.h                           |   50 +
 include/linux/thread_info.h                     |    5 
 include/trace/events/rseq.h                     |    4 
 include/uapi/linux/rseq.h                       |   21 
 init/Kconfig                                    |   28 +
 kernel/entry/common.c                           |   37 -
 kernel/entry/syscall-common.c                   |    8 
 kernel/rseq.c                                   |  610 ++++++++++--------------
 kernel/sched/core.c                             |   10 
 kernel/sched/membarrier.c                       |    8 
 kernel/sched/sched.h                            |    5 
 virt/kvm/kvm_main.c                             |    3 
 34 files changed, 1406 insertions(+), 700 deletions(-)

