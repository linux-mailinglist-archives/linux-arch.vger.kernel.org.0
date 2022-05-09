Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67243520624
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiEIUvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEIUuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 16:50:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF62A806E;
        Mon,  9 May 2022 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652129219; x=1683665219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jbmRRAK1+9iuNq9gvTRqy808MT+o1jWfeNuuaPxV6G8=;
  b=jWM4UlNkKnzwLo6kH8JQosvbJrDfuP16LInSS7rkQZpGhhrEyxJ1kQva
   yWRgWrY8oUOigbFbXMrGUBWbtMwB8WHwJBO54CtTS3Ym+uIpxCJDmokk4
   apqBuwb9zT8EfKYQIZiBvbPWf90gHigOBlXP1fRLd7XgpVfj+LFVnt6wQ
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 May 2022 13:46:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:46:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 13:46:57 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 13:46:56 -0700
Date:   Mon, 9 May 2022 16:46:54 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] fork: Make init and umh ordinary tasks
Message-ID: <20220509204654.GA200@qian>
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
 <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
 <87a6czifo7.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx>
 <877d7zk1cf.ffs@tglx>
 <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx>
 <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 06, 2022 at 09:11:36AM -0500, Eric W. Biederman wrote:
> 
> In commit 40966e316f86 ("kthread: Ensure struct kthread is present for
> all kthreads") caused init and the user mode helper threads that call
> kernel_execve to have struct kthread allocated for them.
> 
> I believe my first patch in this series is enough to fix the bug
> and is simple enough and obvious enough to be backportable.
> 
> The rest of the changes pass struct kernel_clone_args to clean things
> up and cause the code to make sense.
> 
> There is one rough spot in this change.  In the init process before the
> user space init process is exec'd there is a lot going on.  I have found
> when async_schedule_domain is low on memory or has more than 32K callers
> executing do_populate_rootfs will now run in a user space thread making
> flush_delayed_fput meaningless, and __fput_sync is unusable.  I solved
> this as I did in usermode_driver.c with an added explicit task_work_run.
> I point this out as I have seen some talk about making flushing file
> handles more explicit.

Reverting the last 3 commits of the series fixed a boot crash.

1b2552cbdbe0 fork: Stop allowing kthreads to call execve
753550eb0ce1 fork: Explicitly set PF_KTHREAD
68d85f0a33b0 init: Deal with the init process being a user mode process

 BUG: KASAN: null-ptr-deref in task_nr_scan_windows.isra.0
 arch_atomic_long_read at ./include/linux/atomic/atomic-long.h:29
 (inlined by) atomic_long_read at ./include/linux/atomic/atomic-instrumented.h:1266
 (inlined by) get_mm_counter at ./include/linux/mm.h:1996
 (inlined by) get_mm_rss at ./include/linux/mm.h:2049
 (inlined by) task_nr_scan_windows at kernel/sched/fair.c:1123
 Read of size 8 at addr 00000000000003d0 by task swapper/0/1

 CPU: 72 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc6-next-20220509-dirty #29
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_report
  kasan_report
  kasan_check_range
  __kasan_check_read
  task_nr_scan_windows.isra.0
  task_scan_start
  task_scan_min at /home/user/linux/kernel/sched/fair.c:1144
  (inlined by) task_scan_start at /home/user/linux/kernel/sched/fair.c:1150
  task_tick_fair
  task_tick_numa at /home/user/linux/kernel/sched/fair.c:2944
  (inlined by) task_tick_fair at /home/user/linux/kernel/sched/fair.c:11186
  scheduler_tick
  update_process_times
  tick_periodic
  tick_handle_periodic
  arch_timer_handler_phys
  handle_percpu_devid_irq
  generic_handle_domain_irq
  gic_handle_irq
  call_on_irq_stack
  do_interrupt_handler
  el1_interrupt
  el1h_64_irq_handler
  el1h_64_irq
  split_page
  make_alloc_exact
  alloc_pages_exact_nid
  init_section_page_ext
  page_ext_init
  kernel_init_freeable
  kernel_init
  ret_from_fork
 ==================================================================
 Disabling lock debugging due to kernel taint
 Unable to handle kernel paging request at virtual address dfff80000000007a
 KASAN: null-ptr-deref in range [0x00000000000003d0-0x00000000000003d7]
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 [dfff80000000007a] address between user and kernel address ranges
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 72 PID: 1 Comm: swapper/0 Tainted: G    B             5.18.0-rc6-next-20220509-dirty #29
 pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : task_nr_scan_windows.isra.0
 lr : task_nr_scan_windows.isra.0
 sp : ffff800008487cb0
 x29: ffff800008487cb0 x28: ffff07ff89728040 x27: 000000003bc47ee0
 x26: ffff08367f088980 x25: 1fffe0fff12e525f x24: ffff07ff897292f8
 x23: ffff07ff89728040 x22: 1fffe0fff12e5262 x21: 0000000000010000
 x20: 00000000000003d0 x19: 0000000000000000 x18: ffffdd41783f7d1c
 x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
 x14: 3d3d3d3d3d3d3d3d x13: 746e696174206c65 x12: ffff7ba82f3b98b5
 x11: 1ffffba82f3b98b4 x10: ffff7ba82f3b98b4 x9 : dfff800000000000
 x8 : ffffdd4179dcc5a7 x7 : 0000000000000001 x6 : ffff7ba82f3b98b4
 x5 : ffffdd4179dcc5a0 x4 : ffff7ba82f3b98b5 x3 : ffffdd4171de2b14
 x2 : 0000000000000001 x1 : 000000000000007a x0 : dfff800000000000
 Call trace:
  task_nr_scan_windows.isra.0
  task_scan_start
  task_tick_fair
  scheduler_tick
  update_process_times
  tick_periodic
  tick_handle_periodic
  arch_timer_handler_phys
  handle_percpu_devid_irq
  generic_handle_domain_irq
  gic_handle_irq
  call_on_irq_stack
  do_interrupt_handler
  el1_interrupt
  el1h_64_irq_handler
  el1h_64_irq
  split_page
  make_alloc_exact
  alloc_pages_exact_nid
  init_section_page_ext
  page_ext_init
  kernel_init_freeable
  kernel_init
  ret_from_fork
 Code: d343fe81 d2d00000 f2fbffe0 53185eb5 (38e06820)
