Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A68589854
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiHDH1t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Aug 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiHDH1s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2022 03:27:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430D22B05;
        Thu,  4 Aug 2022 00:27:46 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lz0br4pGXz19G3M;
        Thu,  4 Aug 2022 15:24:40 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 15:27:44 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 15:27:43 +0800
Message-ID: <5ee1dfb5-fa70-d412-43c2-3e90ee057eec@huawei.com>
Date:   Thu, 4 Aug 2022 15:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] Revert "x86/unwind/orc: Don't skip the first frame for
 inactive tasks"
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-arch@vger.kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <mbenes@suse.cz>
References: <20220727031506.59322-1-chenzhongjin@huawei.com>
 <20220804045518.bfhe3rxhpkxzn4hk@treble>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220804045518.bfhe3rxhpkxzn4hk@treble>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2022/8/4 12:55, Josh Poimboeuf wrote:
> On Wed, Jul 27, 2022 at 11:15:06AM +0800, Chen Zhongjin wrote:
>> This reverts commit f1d9a2abff66aa8156fbc1493abed468db63ea48.
>>
>> When CONFIG_GCOV_PROFILE_ALL is enabled, show_stack() and related
>> functions (e.g. dump_stack) will break for x86 ORC unwinder.
>>
>> Call Trace:
>>   <TASK>
>>   ? dump_stack_lvl+0x83/0xb7
>>   ? schedule+0x1/0x190
>>   ? dump_stack+0x13/0x1f
>>   ? handler_pre0+0x3f/0x53 [kp_unwind]
>>   ...
>>
>> show_trace_log_lvl() searches text address on stack to validate
>> whether unwind results are reliable. The code:
> Hi,
>
> Thanks for the patch.  The change itself makes sense, though I'm having
> trouble recreating the bug described in the patch description.
>
> I enabled CONFIG_GCOV_PROFILE_ALL and did 'echo l >
> /proc/sysrq-trigger', but I got a valid stack trace:
>
>    # echo l > /proc/sysrq-trigger
>    [  343.916728] sysrq: Show backtrace of all active CPUs
>    [  343.917459] NMI backtrace for cpu 2
>    [  343.917884] CPU: 2 PID: 1007 Comm: bash Not tainted 5.19.0-rc8+ #68
>    [  343.918562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
>    [  343.919534] Call Trace:
>    [  343.919904]  <TASK>
>    [  343.920226]  dump_stack_lvl+0xcc/0x11b
>    [  343.920742]  dump_stack+0x17/0x24
>    [  343.921199]  nmi_cpu_backtrace.cold+0xb5/0x10d
>    [  343.921795]  ? lapic_can_unplug_cpu+0xa0/0xa0
>    [  343.922375]  nmi_trigger_cpumask_backtrace+0x171/0x200
>    [  343.923053]  arch_trigger_cpumask_backtrace+0x21/0x30
>    [  343.923599]  sysrq_handle_showallcpus+0x1f/0x30
>    [  343.924104]  __handle_sysrq.cold+0x81/0x234
>    [  343.924576]  write_sysrq_trigger+0x6a/0x90
>    [  343.925098]  proc_reg_write+0x99/0x120
>    [  343.925587]  vfs_write+0x16c/0x350
>    [  343.926093]  ksys_write+0x8c/0x180
>    [  343.926597]  __x64_sys_write+0x21/0x30
>    [  343.927144]  do_syscall_64+0x76/0x100
>    [  343.927676]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>    [  343.928343] RIP: 0033:0x7f555e8f7b50
>    [  343.928822] Code: 73 01 c3 48 8b 0d 38 83 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 79 db 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e e3 01 00 48 89 04 24
>    [  343.930801] RSP: 002b:00007ffdd20d0978 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>    [  343.931761] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f555e8f7b50
>    [  343.932551] RDX: 0000000000000002 RSI: 000055ff471bfe20 RDI: 0000000000000001
>    [  343.933347] RBP: 000055ff471bfe20 R08: 00007f555ebc2740 R09: 00007f555f80f700
>    [  343.934155] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000002
>    [  343.934962] R13: 0000000000000001 R14: 00007f555ebc15e0 R15: 00007f555ebbd3c0
>    [  343.935798]  </TASK>
>    [  343.936341] Sending NMI from CPU 2 to CPUs 0-1,3:
>    [  343.937163] NMI backtrace for cpu 3
>    [  343.937167] CPU: 3 PID: 600 Comm: systemd-journal Not tainted 5.19.0-rc8+ #68
>
> Was this with an upstream kernel?  Can you share the config and
> toolchain versions?
Hi,

My kernel is upstream and config is defconfig with only 
CONFIG_GCOV_PROFILE_ALL=y then make menuconfig.

CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"

And I got:

[   29.745728] NMI backtrace for cpu 1
[   29.745728] CPU: 1 PID: 135 Comm: sh Not tainted 
5.19.0-02858-ge2b542100719 #58
[   29.745728] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.15.0-0-g2dd4b9b3f8404
[   29.745728] Call Trace:
[   29.745728]  <TASK>
[   29.745728]  ? dump_stack_lvl+0x72/0xa1
[   29.745728]  ? dump_stack+0x13/0x1f
[   29.745728]  ? nmi_cpu_backtrace+0x19f/0x1d0
[   29.745728]  ? lapic_can_unplug_cpu+0xf0/0xf0
[   29.745728]  ? nmi_trigger_cpumask_backtrace+0x15e/0x210
[   29.745728]  ? arch_trigger_cpumask_backtrace+0x18/0x30
[   29.745728]  ? sysrq_handle_showallcpus+0x16/0x30
[   29.745728]  ? __handle_sysrq+0xc4/0x250
[   29.745728]  ? write_sysrq_trigger+0x46/0x60
[   29.745728]  ? proc_reg_write+0xbc/0x120
[   29.745728]  ? preempt_count_add+0x8e/0x130
[   29.745728]  ? vfs_write+0xfe/0x460
[   29.745728]  ? ksys_write+0xdc/0x170
[   29.745728]  ? fpregs_assert_state_consistent+0x2d/0x90
[   29.745728]  ? __x64_sys_write+0x19/0x30
[   29.745728]  ? do_syscall_64+0x3a/0x90
[   29.745728]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   29.745728]  </TASK>


It also happened with CONFIG_CC_VERSION_TEXT="gcc-8 (Ubuntu 
8.4.0-1ubuntu1~18.04) 8.4.0".

I believe disassemble show_stack in vmlinux and if we have:

     push   %rbp

     mov    %rsp,%rbp

     ... (no regs pushed to stack)

     callq  <show_trace_log_lvl>

This can be reproduced.

Your stacktrace looks just as normal as the one in my commit message 
(show_stack is optimized out).


Best,

Chen



