Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B396C586324
	for <lists+linux-arch@lfdr.de>; Mon,  1 Aug 2022 05:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiHADox (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 23:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiHADou (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 23:44:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFC25FF;
        Sun, 31 Jul 2022 20:44:48 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lx3mw00JHzWfth;
        Mon,  1 Aug 2022 11:40:47 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 11:44:46 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 11:44:45 +0800
Message-ID: <d229f862-97b5-c3fb-d73b-d9216a05daa0@huawei.com>
Date:   Mon, 1 Aug 2022 11:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] kprobes: Forbid probing on kprobe_insn_slot
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>
References: <20220727032058.60444-1-chenzhongjin@huawei.com>
 <20220801004854.9c2b36f38fe5ad19b2271196@kernel.org>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220801004854.9c2b36f38fe5ad19b2271196@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi,

On 2022/7/31 23:48, Masami Hiramatsu (Google) wrote:
> On Wed, 27 Jul 2022 11:20:58 +0800
> Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
>> Syzkaller reported a BUG on arm64:
>> Unrecoverable kprobe detected.
>> Dumping kprobe:
>> Name: (null)
>> Offset: 0
>> Address: 0xffffa00010019000
>> ------------[ cut here ]------------
>> kernel BUG at arch/arm64/kernel/probes/kprobes.c:235!
>> Internal error: Oops - BUG: 0 [#1] SMP
>> Modules linked in:
>> CPU: 1 PID: 31060 Comm: syz-executor.6 Not tainted 5.10.0 #11
>> ...
>> Call trace:
>>   reenter_kprobe arch/arm64/kernel/probes/kprobes.c:234 [inline]
>>   kprobe_handler+0x23c/0x26c arch/arm64/kernel/probes/kprobes.c:339
>>   kprobe_breakpoint_handler+0x24/0x34 arch/arm64/kernel/probes/kprobes.c:406
>>   call_break_hook+0xf4/0x13c arch/arm64/kernel/debug-monitors.c:322
>>   brk_handler+0x2c/0xa0 arch/arm64/kernel/debug-monitors.c:329
>>   do_debug_exception+0x140/0x230 arch/arm64/mm/fault.c:867
>>   el1_dbg+0x38/0x50 arch/arm64/kernel/entry-common.c:182
>>   el1_sync_handler+0xf4/0x150 arch/arm64/kernel/entry-common.c:219
>>   el1_sync+0x74/0x100 arch/arm64/kernel/entry.S:665
>>   0xffffa00010019000
>>   do_futex+0x2f4/0x370 kernel/futex.c:3735
>>   __do_sys_futex kernel/futex.c:3798 [inline]
>>   __se_sys_futex kernel/futex.c:3764 [inline]
>>   __arm64_sys_futex+0x168/0x3a0 kernel/futex.c:3764
>>   __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>>   invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
>>   el0_svc_common.constprop.0+0xf4/0x414 arch/arm64/kernel/syscall.c:155
>>   do_el0_svc+0x50/0x11c arch/arm64/kernel/syscall.c:217
>>   el0_svc+0x20/0x30 arch/arm64/kernel/entry-common.c:353
>>   el0_sync_handler+0xe4/0x1e0 arch/arm64/kernel/entry-common.c:369
>>   el0_sync+0x148/0x180 arch/arm64/kernel/entry.S:683
>> Code: 91018360 97ff1838 aa1703e0 97ff1fdf (d4210000)
>> ---[ end trace 767503e946e01b15 ]---
>>
>> Syzbot tried to porbe on a kprobe_insn_slot.
>>
>> kprobe will replace instruciton with a break and store the origin one
>> on kprobe_insn_slot. However these slots are not in .kprobes.text and
>> exported by perf_event_ksymbol so can be probed by perf interface.
>>
>> Probing these slots will triggers kprobe handler inside single step
>> process and for some architectures such as arm64 this will causes a
>> bug().
>>
>> These slots are kprobe process so they should not be probed anyway.
>> Add kprobe_insn_slot check when register_kprobe to forbid probing on
>> these slots.
> Oops, good catch!
>
> Previously this was not counted as text area, but now the kernel_text_address()
> returns true for these trampoline buffers.
>
> In this case, I think kprobes should be limited to probe only
> core_kernel_text and module_text.
> Can you use is_module_text_address() and core_kernel_text() instead?
> Below can allow kprobes probing on other trampolines like ftrace and
> bpf.
> Also, you may need this tag;
>
> Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")
>
> Thank you,

Thanks for review!

Please see next version here: https://lkml.org/lkml/2022/7/31/436

[PATCH v3] kprobes: Forbid probing on trampoline and bpf prog

>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   kernel/kprobes.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index f214f8c088ed..3e798b62db70 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1562,6 +1562,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>   	/* Ensure it is not in reserved area nor out of text */
>>   	if (!kernel_text_address((unsigned long) p->addr) ||
>>   	    within_kprobe_blacklist((unsigned long) p->addr) ||
>> +	    is_kprobe_insn_slot((unsigned long) p->addr) ||
>> +	    is_kprobe_optinsn_slot((unsigned long) p->addr) ||
>>   	    jump_label_text_reserved(p->addr, p->addr) ||
>>   	    static_call_text_reserved(p->addr, p->addr) ||
>>   	    find_bug((unsigned long)p->addr)) {
>> -- 
>> 2.17.1
>>
Best,

Chen


