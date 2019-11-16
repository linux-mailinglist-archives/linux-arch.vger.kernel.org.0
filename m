Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA05CFF4BA
	for <lists+linux-arch@lfdr.de>; Sat, 16 Nov 2019 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKPS2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Nov 2019 13:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfKPS2x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Nov 2019 13:28:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33392068D;
        Sat, 16 Nov 2019 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573928932;
        bh=yL+ARVFynQ/8PR0l7R7gDPQdnwbyNLp4ladEfgFKluU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RHdQcc2+CgSpd14RWUll5sb+C8RdViQCFtKvgKQt8IZEx8EbB6t941wkIPdhv8xkh
         msWOZlB9d8H5MkZ7rca6A//lgKCCha/ShaCu+8DC6tsmj5GSCjvGVaEZvpVG22JDAd
         i7VDnyBtVNxNVBRbpiVCTVthDSw3EtcgQWpf/ADk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7ACD335227AD; Sat, 16 Nov 2019 10:28:51 -0800 (PST)
Date:   Sat, 16 Nov 2019 10:28:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v4 00/10] Add Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191116182851.GF2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191114195046.GP2865@paulmck-ThinkPad-P72>
 <20191114213303.GA237245@google.com>
 <20191114221559.GS2865@paulmck-ThinkPad-P72>
 <CANpmjNPxAOUAxXHd9tka5gCjR_rNKmBk+k5UzRsXT0a0CtNorw@mail.gmail.com>
 <20191115164159.GU2865@paulmck-ThinkPad-P72>
 <CANpmjNPy2RDBUhV-j-APzwYr-_x2V9QwgPTYZph36rCpEVqZSQ@mail.gmail.com>
 <20191115204321.GX2865@paulmck-ThinkPad-P72>
 <CANpmjNN0JCgEOC=AhKN7pH9OpmzbNB94mioP0FN9ueCQUfKzBQ@mail.gmail.com>
 <20191116153454.GC2865@paulmck-ThinkPad-P72>
 <CANpmjNM6NT3bA07h5L9HNMzFY83Nd-yZRzum9-ykd4pW58kNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM6NT3bA07h5L9HNMzFY83Nd-yZRzum9-ykd4pW58kNOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 16, 2019 at 07:09:21PM +0100, Marco Elver wrote:
> On Sat, 16 Nov 2019 at 16:34, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Nov 16, 2019 at 09:20:54AM +0100, Marco Elver wrote:
> > > On Fri, 15 Nov 2019 at 21:43, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Nov 15, 2019 at 06:14:46PM +0100, Marco Elver wrote:
> > > > > On Fri, 15 Nov 2019 at 17:42, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Nov 15, 2019 at 01:02:08PM +0100, Marco Elver wrote:
> > > > > > > On Thu, 14 Nov 2019 at 23:16, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Nov 14, 2019 at 10:33:03PM +0100, Marco Elver wrote:
> > > > > > > > > On Thu, 14 Nov 2019, Paul E. McKenney wrote:
> > > > > > > > >
> > > > > > > > > > On Thu, Nov 14, 2019 at 07:02:53PM +0100, Marco Elver wrote:
> > > > > > > > > > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > > > > > > > > > KCSAN is a sampling watchpoint-based *data race detector*. More details
> > > > > > > > > > > are included in **Documentation/dev-tools/kcsan.rst**. This patch-series
> > > > > > > > > > > only enables KCSAN for x86, but we expect adding support for other
> > > > > > > > > > > architectures is relatively straightforward (we are aware of
> > > > > > > > > > > experimental ARM64 and POWER support).
> > > > > > > > > > >
> > > > > > > > > > > To gather early feedback, we announced KCSAN back in September, and have
> > > > > > > > > > > integrated the feedback where possible:
> > > > > > > > > > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > > > > > > > > >
> > > > > > > > > > > The current list of known upstream fixes for data races found by KCSAN
> > > > > > > > > > > can be found here:
> > > > > > > > > > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > > > > > > > > >
> > > > > > > > > > > We want to point out and acknowledge the work surrounding the LKMM,
> > > > > > > > > > > including several articles that motivate why data races are dangerous
> > > > > > > > > > > [1, 2], justifying a data race detector such as KCSAN.
> > > > > > > > > > >
> > > > > > > > > > > [1] https://lwn.net/Articles/793253/
> > > > > > > > > > > [2] https://lwn.net/Articles/799218/
> > > > > > > > > >
> > > > > > > > > > I queued this and ran a quick rcutorture on it, which completed
> > > > > > > > > > successfully with quite a few reports.
> > > > > > > > >
> > > > > > > > > Great. Many thanks for queuing this in -rcu. And regarding merge window
> > > > > > > > > you mentioned, we're fine with your assumption to targeting the next
> > > > > > > > > (v5.6) merge window.
> > > > > > > > >
> > > > > > > > > I've just had a look at linux-next to check what a future rebase
> > > > > > > > > requires:
> > > > > > > > >
> > > > > > > > > - There is a change in lib/Kconfig.debug and moving KCSAN to the
> > > > > > > > >   "Generic Kernel Debugging Instruments" section seems appropriate.
> > > > > > > > > - bitops-instrumented.h was removed and split into 3 files, and needs
> > > > > > > > >   re-inserting the instrumentation into the right places.
> > > > > > > > >
> > > > > > > > > Otherwise there are no issues. Let me know what you recommend.
> > > > > > > >
> > > > > > > > Sounds good!
> > > > > > > >
> > > > > > > > I will be rebasing onto v5.5-rc1 shortly after it comes out.  My usual
> > > > > > > > approach is to fix any conflicts during that rebasing operation.
> > > > > > > > Does that make sense, or would you prefer to send me a rebased stack at
> > > > > > > > that point?  Either way is fine for me.
> > > > > > >
> > > > > > > That's fine with me, thanks!  To avoid too much additional churn on
> > > > > > > your end, I just replied to the bitops patch with a version that will
> > > > > > > apply with the change to bitops-instrumented infrastructure.
> > > > > >
> > > > > > My first thought was to replace 8/10 of the previous version of your
> > > > > > patch in -rcu (047ca266cfab "asm-generic, kcsan: Add KCSAN instrumentation
> > > > > > for bitops"), but this does not apply.  So I am guessing that I instead
> > > > > > do this substitution when a rebase onto -rc1..
> > > > > >
> > > > > > Except...
> > > > > >
> > > > > > > Also considering the merge window, we had a discussion and there are
> > > > > > > some arguments for targeting the v5.5 merge window:
> > > > > > > - we'd unblock ARM and POWER ports;
> > > > > > > - we'd unblock people wanting to use the data_race macro;
> > > > > > > - we'd unblock syzbot just tracking upstream;
> > > > > > > Unless there are strong reasons to not target v5.5, I leave it to you
> > > > > > > if you think it's appropriate.
> > > > > >
> > > > > > My normal process is to send the pull request shortly after -rc5 comes
> > > > > > out, but you do call out some benefits of getting it in sooner, so...
> > > > > >
> > > > > > What I will do is to rebase your series onto (say) -rc7, test it, and
> > > > > > see about an RFC pull request.
> > > > > >
> > > > > > One possible complication is the new 8/10 patch.  But maybe it will
> > > > > > apply against -rc7?
> > > > > >
> > > > > > Another possible complication is this:
> > > > > >
> > > > > > scripts/kconfig/conf  --syncconfig Kconfig
> > > > > > *
> > > > > > * Restart config...
> > > > > > *
> > > > > > *
> > > > > > * KCSAN: watchpoint-based dynamic data race detector
> > > > > > *
> > > > > > KCSAN: watchpoint-based dynamic data race detector (KCSAN) [N/y/?] (NEW)
> > > > > >
> > > > > > Might be OK in this case because it is quite obvious what it is doing.
> > > > > > (Avoiding pain from this is the reason that CONFIG_RCU_EXPERT exists.)
> > > > > >
> > > > > > But I will just mention this in the pull request.
> > > > > >
> > > > > > If there is a -rc8, there is of course a higher probability of making it
> > > > > > into the next merge window.
> > > > > >
> > > > > > Fair enough?
> > > > >
> > > > > Totally fine with that, sounds like a good plan, thanks!
> > > > >
> > > > > If it helps, in theory we can also drop and delay the bitops
> > > > > instrumentation patch until the new bitops instrumentation
> > > > > infrastructure is in 5.5-rc1. There won't be any false positives if
> > > > > this is missing, we might just miss a few data races until we have it.
> > > >
> > > > That sounds advisable for an attempt to hit this coming merge window.
> > > >
> > > > So just to make sure I understand, I drop 8/10 and keep the rest during
> > > > a rebase to 5.4-rc7, correct?
> > >
> > > Yes, that's right.
> >
> > Very good, I just now pushed a "kcsan" branch on -rcu, and am running
> > rcutorture, first without KCSAN enabled and then with it turned on.
> > If all that works out, I set my -next branch to that point and see what
> > -next testing and kbuild test robot think about it.  If all goes well,
> > an RFC pull request.
> >
> > Look OK?
> 
> Looks good to me, many thanks!

And I did get one failure on the KCSAN=n run for the TREE03 scenario,
but it does not appear to be your fault.  Looks like a race between a
swait_queue_head swake_up_one() invocation and one of the CPU hotplug
operations done late in system shutdown.  I have included the splat
below for your amusement.

Starting the KCSAN=y runs now.

							Thanx, Paul

------------------------------------------------------------------------

[  601.009355] reboot: Power down
[  601.010447] ------------[ cut here ]------------
[  601.011020] sched: Unexpected reschedule of offline CPU#1!
[  601.011639] WARNING: CPU: 7 PID: 0 at arch/x86/kernel/apic/ipi.c:67 native_smp_send_reschedule+0x2f/0x40
[  601.012692] Modules linked in:
[  601.013037] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.4.0-rc7+ #1497
[  601.013755] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[  601.014708] RIP: 0010:native_smp_send_reschedule+0x2f/0x40
[  601.015312] Code: 05 f6 62 5d 01 73 15 48 8b 05 cd ba 28 01 be fd 00 00 00 48 8b 40 30 e9 bf b0 db 00 89 fe 48 c7 c7 d0 df 5e a7 e8 01 20 02 00 <0f> 0b c3 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 48 8b 05 99 ba
[  601.017357] RSP: 0018:ffffa1afc020cee0 EFLAGS: 00010086
[  601.017942] RAX: 0000000000000000 RBX: ffff8d5c1ed24a54 RCX: 0000000000000005
[  601.018716] RDX: 0000000080000005 RSI: 0000000000000082 RDI: 00000000ffffffff
[  601.019500] RBP: 0000000000000000 R08: 0000000000000cd5 R09: 000000000000003d
[  601.020283] R10: ffff8d5c1f067f80 R11: 20666f20656c7564 R12: 0000000000000001
[  601.021074] R13: 0000000000027f40 R14: 0000000000000087 R15: ffff8d5c1ed23f00
[  601.021851] FS:  0000000000000000(0000) GS:ffff8d5c1f1c0000(0000) knlGS:0000000000000000
[  601.022731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  601.023360] CR2: 00000000ffffffff CR3: 000000001120a000 CR4: 00000000000006e0
[  601.024140] Call Trace:
[  601.024437]  <IRQ>
[  601.024671]  try_to_wake_up+0x2b3/0x650
[  601.025103]  swake_up_locked.part.6+0xe/0x30
[  601.025579]  swake_up_one+0x22/0x30
[  601.025968]  rcu_try_advance_all_cbs+0x71/0x80
[  601.026459]  rcu_cleanup_after_idle+0x28/0x40
[  601.026941]  rcu_irq_enter+0xfb/0x130
[  601.027347]  irq_enter+0x5/0x50
[  601.027704]  smp_reboot_interrupt+0x1a/0xb0
[  601.028175]  ? smp_apic_timer_interrupt+0xa1/0x180
[  601.028711]  reboot_interrupt+0xf/0x20
[  601.029134]  </IRQ>
[  601.029374] RIP: 0010:default_idle+0x1e/0x170
[  601.029853] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 53 e8 c5 c5 91 ff 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d e6 b4 54 00 fb f4 <e8> ad c5 91 ff 89 c5 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
[  601.031884] RSP: 0018:ffffa1afc00afec0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff07
[  601.032716] RAX: 0000000000000007 RBX: 0000000000000007 RCX: 0000000000000007
[  601.033498] RDX: 0000000000000001 RSI: 0000000000000087 RDI: ffffffffa769a760
[  601.034280] RBP: ffffffffa7a1c160 R08: 0000009a8e03a656 R09: 0000000000000001
[  601.035062] R10: 0000000000000400 R11: 00000000000001d8 R12: 0000000000000000
[  601.035842] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  601.036632]  do_idle+0x1a6/0x240
[  601.036996]  cpu_startup_entry+0x14/0x20
[  601.037433]  start_secondary+0x150/0x180
[  601.037869]  secondary_startup_64+0xa4/0xb0
[  601.038339] ---[ end trace e4c21199f3882c03 ]---
[  601.038991] acpi_power_off called
