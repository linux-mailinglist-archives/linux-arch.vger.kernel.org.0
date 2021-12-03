Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5437467F1D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbhLCVMW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 16:12:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhLCVMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 16:12:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C461662B8E;
        Fri,  3 Dec 2021 21:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D79AC53FCB;
        Fri,  3 Dec 2021 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638565737;
        bh=BlTRvCdOzdAHgLT03YhsdUB2IyQJNEwbQ4P+5iYkKTE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ur99wvPABOPqzeGjz2Doyg7rgvFw/Y7v7zGc+pOIb5dCTfLBIKMG0NTijfXG0V6Pv
         img0MSBLke7jIIoZ9NfWc1wv2YbS06NtG0GmVnFrf0qOpSiHzbD7X7rKqMl+KE+lLV
         yvwwOLGZ1f4Qs9hDWGjPED4ENdi2F+OaBDLrVey8bEmIAqg3W/OfiLnVPfaVjh/hP9
         CN5vgcKaQ7gBWfBkdtS4UeP8QYTNxelHnpeP2kG1mrnN9qMlxe2hATX7gqJG8ukELp
         m+NSTPZgnM/Fe+j8k+Yn7R81z5iWSg/gaDp07URVsMck0vqao25NzhtSuwnazBW+lM
         6UYR5q7ShG9nA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB1665C1108; Fri,  3 Dec 2021 13:08:56 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:08:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 04/25] kcsan: Add core support for a subset of weak
 memory modeling
Message-ID: <20211203210856.GA712591@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-5-elver@google.com>
 <YanbzWyhR0LwdinE@elver.google.com>
 <20211203165020.GR641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203165020.GR641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 08:50:20AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 03, 2021 at 09:56:45AM +0100, Marco Elver wrote:
> > On Tue, Nov 30, 2021 at 12:44PM +0100, Marco Elver wrote:
> > [...]
> > > v3:
> > > * Remove kcsan_noinstr hackery, since we now try to avoid adding any
> > >   instrumentation to .noinstr.text in the first place.
> > [...]
> > 
> > I missed some cleanups after changes from v2 to v3 -- the below cleanup
> > is missing.
> > 
> > Full replacement patch attached.
> 
> I pulled this into -rcu with the other patches from your v3 post, thank
> you all!

A few quick tests located the following:

[    0.635383] INFO: trying to register non-static key.
[    0.635804] The code is fine but needs lockdep annotation, or maybe
[    0.636194] you didn't initialize this object before use?
[    0.636194] turning off the locking correctness validator.
[    0.636194] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1+ #3208
[    0.636194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    0.636194] Call Trace:
[    0.636194]  <TASK>
[    0.636194]  dump_stack_lvl+0x88/0xd8
[    0.636194]  dump_stack+0x15/0x1b
[    0.636194]  register_lock_class+0x6b3/0x840
[    0.636194]  ? __this_cpu_preempt_check+0x1d/0x30
[    0.636194]  __lock_acquire+0x81/0xee0
[    0.636194]  ? lock_is_held_type+0xf1/0x160
[    0.636194]  lock_acquire+0xce/0x230
[    0.636194]  ? test_barrier+0x490/0x14c7
[    0.636194]  ? lock_is_held_type+0xf1/0x160
[    0.636194]  ? test_barrier+0x490/0x14c7
[    0.636194]  _raw_spin_lock+0x36/0x50
[    0.636194]  ? test_barrier+0x490/0x14c7
[    0.636194]  ? kcsan_init+0xf/0x80
[    0.636194]  test_barrier+0x490/0x14c7
[    0.636194]  ? kcsan_debugfs_init+0x1f/0x1f
[    0.636194]  kcsan_selftest+0x47/0xa0
[    0.636194]  do_one_initcall+0x104/0x230
[    0.636194]  ? rcu_read_lock_sched_held+0x5b/0xc0
[    0.636194]  ? kernel_init+0x1c/0x200
[    0.636194]  do_initcall_level+0xa5/0xb6
[    0.636194]  do_initcalls+0x66/0x95
[    0.636194]  do_basic_setup+0x1d/0x23
[    0.636194]  kernel_init_freeable+0x254/0x2ed
[    0.636194]  ? rest_init+0x290/0x290
[    0.636194]  kernel_init+0x1c/0x200
[    0.636194]  ? rest_init+0x290/0x290
[    0.636194]  ret_from_fork+0x22/0x30
[    0.636194]  </TASK>

When running without the new patch series, this splat does not appear.

Do I need a toolchain upgrade?  I see the Clang 14.0 in the cover letter,
but that seems to apply only to non-x86 architectures.

$ clang-11 -v
Ubuntu clang version 11.1.0-++20210805102428+1fdec59bffc1-1~exp1~20210805203044.169

							Thanx, Paul
