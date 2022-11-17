Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F462E9E3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 00:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiKQXxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiKQXxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 18:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4D532F7
        for <linux-arch@vger.kernel.org>; Thu, 17 Nov 2022 15:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668729157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ9h0bt6Jo+9fCE5vQcx0pDwFY9OuShej95BgGTToEE=;
        b=gnKqSiLTqAqyiFiRnMkXMYO1JQrcNQ8KlUR89DC3roQP3rZoYDVTbeDJqLGKkM0ph+Yl5X
        ipWyoup+u/obRPpJipFVaYHt6OJlcaP5NO/ccAOUBxQW9trIJILNdDqxprQh2KapmBj9k0
        cB/REaX2rm6Vca4m1lxZCyPEOAoAaU8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-KWOLNxNFMUKFB1U8qqTgmA-1; Thu, 17 Nov 2022 18:52:33 -0500
X-MC-Unique: KWOLNxNFMUKFB1U8qqTgmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A72D1C0CE68;
        Thu, 17 Nov 2022 23:52:32 +0000 (UTC)
Received: from [10.22.16.250] (unknown [10.22.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD8A42222;
        Thu, 17 Nov 2022 23:52:31 +0000 (UTC)
Message-ID: <eba841a8-d61a-b404-9e92-d310a0f805f6@redhat.com>
Date:   Thu, 17 Nov 2022 18:52:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Syzkaller found a bug: KASAN: null-ptr-deref Write in
 prepare_to_wait
Content-Language: en-US
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>
References: <DM6PR07MB50680D00B48D4ED3C151A2A7AB069@DM6PR07MB5068.namprd07.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <DM6PR07MB50680D00B48D4ED3C151A2A7AB069@DM6PR07MB5068.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/17/22 17:17, Sanan Hasanov wrote:
> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocalizer.
>
> Kernel branch: linux-next 5.11.0+ (HEAD detached at 8310b77b48c5)
>
> config file and c reproducer are attached.
>
> Thank you!
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> BUG: KASAN: null-ptr-deref in atomic_try_cmpxchg_acquire include/asm-generic/atomic-instrumented.h:705 [inline]
> BUG: KASAN: null-ptr-deref in queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
> BUG: KASAN: null-ptr-deref in do_raw_spin_lock_flags include/linux/spinlock.h:195 [inline]
> BUG: KASAN: null-ptr-deref in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:119 [inline]
> BUG: KASAN: null-ptr-deref in _raw_spin_lock_irqsave+0x6c/0xd0 kernel/locking/spinlock.c:159
> Write of size 4 at addr 0000000000000010 by task syz-executor.3/1879
>
> CPU: 1 PID: 1879 Comm: syz-executor.3 Not tainted 5.11.0+ #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0xb0/0xf3 lib/dump_stack.c:120
>   __kasan_report mm/kasan/report.c:400 [inline]
>   kasan_report.cold+0x10c/0x10e mm/kasan/report.c:413
>   check_memory_region_inline mm/kasan/generic.c:179 [inline]
>   check_memory_region+0x17c/0x1e0 mm/kasan/generic.c:185
>   instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>   atomic_try_cmpxchg_acquire include/asm-generic/atomic-instrumented.h:705 [inline]
>   queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
>   do_raw_spin_lock_flags include/linux/spinlock.h:195 [inline]
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:119 [inline]
>   _raw_spin_lock_irqsave+0x6c/0xd0 kernel/locking/spinlock.c:159
>   prepare_to_wait+0x79/0x3c0 kernel/sched/wait.c:259
>   io_uring_cancel_files fs/io_uring.c:9014 [inline]
>   io_uring_cancel_task_requests+0x986/0xfa0 fs/io_uring.c:9054
>   io_uring_flush+0x311/0x470 fs/io_uring.c:9236
>   filp_close+0xad/0x150 fs/open.c:1286
>   close_files fs/file.c:403 [inline]
>   put_files_struct fs/file.c:418 [inline]
>   put_files_struct+0x193/0x280 fs/file.c:415
>   exit_files+0xa4/0xd0 fs/file.c:435
>   do_exit+0xa35/0x27d0 kernel/exit.c:820
>   do_group_exit+0xee/0x310 kernel/exit.c:922
>   get_signal+0x3b5/0x1a60 kernel/signal.c:2773
>   arch_do_signal_or_restart+0x2eb/0x18e0 arch/x86/kernel/signal.c:811
>   handle_signal_work kernel/entry/common.c:147 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>   exit_to_user_mode_prepare+0xba/0x130 kernel/entry/common.c:208
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
>   syscall_exit_to_user_mode+0x1d/0x40 kernel/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f06219f6dcd
> Code: Unable to access opcode bytes at RIP 0x7f06219f6da3.
> RSP: 002b:00007f0620b66c98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f0621b23f80 RCX: 00007f06219f6dcd
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f0621b23f88
> RBP: 00007f0621b23f88 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0621b23f8c
> R13: 00007ffcf7101edf R14: 00007ffcf7102080 R15: 00007f0620b66d80
> ==================================================================
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP KASAN NOPTI

According to this kernel splat, the spinlock address is at 0x10.

253 void
254 prepare_to_wait(struct wait_queue_head *wq_head, struct 
wait_queue_entry *wq_entry, int state)
255 {
256         unsigned long flags;
257
258         wq_entry->flags &= ~WQ_FLAG_EXCLUSIVE;
259         spin_lock_irqsave(&wq_head->lock, flags);
260         if (list_empty(&wq_entry->entry))
261                 __add_wait_queue(wq_head, wq_entry);
262         set_current_state(state);
263         spin_unlock_irqrestore(&wq_head->lock, flags);
264 }
265 EXPORT_SYMBOL(prepare_to_wait);

The first element of wait_queue_head structure is a spinlock. That means 
wq_head has a value of 0x10 too. Since it is called by 
io_uring_cancel_files(), I think the bug is in the io_uring code as it 
passed the wrong value to prepare_to_wait(). I didn't try to go further 
as I am not that familiar with the io_uring code.

Cheers,
Longman

