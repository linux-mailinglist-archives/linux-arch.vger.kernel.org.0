Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715845F8919
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 05:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJIDOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Oct 2022 23:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIDOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Oct 2022 23:14:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF5733A19;
        Sat,  8 Oct 2022 20:14:13 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MlRq91v7vzmV6H;
        Sun,  9 Oct 2022 11:09:41 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 11:14:06 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 9 Oct
 2022 11:14:05 +0800
Message-ID: <a3d754f7-5dde-4adc-205a-c4c380a30372@huawei.com>
Date:   Sun, 9 Oct 2022 11:14:05 +0800
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
 <5ee1dfb5-fa70-d412-43c2-3e90ee057eec@huawei.com>
 <20220804220623.a2s7ucblryudm63m@treble>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220804220623.a2s7ucblryudm63m@treble>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Josh,

On 2022/8/5 6:06, Josh Poimboeuf wrote:
> On Thu, Aug 04, 2022 at 03:27:39PM +0800, Chen Zhongjin wrote:
>> I believe disassemble show_stack in vmlinux and if we have:
>>
>>      push   %rbp
>>
>>      mov    %rsp,%rbp
>>
>>      ... (no regs pushed to stack)
>>
>>      callq  <show_trace_log_lvl>
>>
>> This can be reproduced.
> Weird, that's what I have.  This is GCC 12.1.
>
> ffffffff81056de0 <show_stack>:
> ffffffff81056de0:	e8 0b 43 05 00       	call   ffffffff810ab0f0 <__fentry__>
> ffffffff81056de5:	55                   	push   %rbp
> ffffffff81056de6:	48 83 05 b2 0f c9 02 01 	addq   $0x1,0x2c90fb2(%rip)        # ffffffff83ce7da0 <__gcov0.show_stack>
> ffffffff81056dee:	48 89 e5             	mov    %rsp,%rbp
> ffffffff81056df1:	48 85 ff             	test   %rdi,%rdi
> ffffffff81056df4:	74 41                	je     ffffffff81056e37 <show_stack+0x57>
> ffffffff81056df6:	48 85 f6             	test   %rsi,%rsi
> ffffffff81056df9:	0f 85 c2 24 15 01    	jne    ffffffff821a92c1 <show_stack.cold+0xd>
> ffffffff81056dff:	65 48 8b 04 25 c0 bd 01 00 	mov    %gs:0x1bdc0,%rax
> ffffffff81056e08:	48 39 c7             	cmp    %rax,%rdi
> ffffffff81056e0b:	0f 85 a3 24 15 01    	jne    ffffffff821a92b4 <show_stack.cold>
> ffffffff81056e11:	48 83 05 af 0f c9 02 01 	addq   $0x1,0x2c90faf(%rip)        # ffffffff83ce7dc8 <__gcov0.show_stack+0x28>
> ffffffff81056e19:	48 89 ee             	mov    %rbp,%rsi
> ffffffff81056e1c:	48 89 d1             	mov    %rdx,%rcx
> ffffffff81056e1f:	48 89 f2             	mov    %rsi,%rdx
> ffffffff81056e22:	31 f6                	xor    %esi,%esi
> ffffffff81056e24:	e8 8e 20 15 01       	call   ffffffff821a8eb7 <show_trace_log_lvl>
> ffffffff81056e29:	48 83 05 9f 0f c9 02 01 	addq   $0x1,0x2c90f9f(%rip)        # ffffffff83ce7dd0 <__gcov0.show_stack+0x30>
> ffffffff81056e31:	5d                   	pop    %rbp
> ffffffff81056e32:	e9 49 b2 5a 01       	jmp    ffffffff82602080 <__x86_return_thunk>
> ffffffff81056e37:	48 83 05 69 0f c9 02 01 	addq   $0x1,0x2c90f69(%rip)        # ffffffff83ce7da8 <__gcov0.show_stack+0x8>
> ffffffff81056e3f:	65 48 8b 3c 25 c0 bd 01 00 	mov    %gs:0x1bdc0,%rdi
> ffffffff81056e48:	eb ac                	jmp    ffffffff81056df6 <show_stack+0x16>
> ffffffff81056e4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

This problem still exist on my machine:

CONFIG: defconfig + CONFIG_GCOV_PROFILE_ALL

GCC: gcc 7.5.0 & 12.1.0

TRIGGER:

# echo l > /proc/sysrq-trigger

[  173.156737]  <TASK>
[  173.156737]  ? dump_stack_lvl+0x79/0xaf
[  173.156737]  ? dump_stack+0x13/0x1f
[  173.156737]  ? nmi_cpu_backtrace.cold+0x97/0xef
[  173.156737]  ? lapic_can_unplug_cpu+0x90/0x90
[  173.156737]  ? nmi_trigger_cpumask_backtrace+0x15d/0x1e0
[  173.156737]  ? arch_trigger_cpumask_backtrace+0x18/0x30
[  173.156737]  ? sysrq_handle_showallcpus+0x16/0x30
[  173.156737]  ? __handle_sysrq.cold+0x51/0x1ae
[  173.156737]  ? write_sysrq_trigger+0x2f/0x60
[  173.156737]  ? proc_reg_write+0x90/0x110
[  173.156737]  ? vfs_write+0x12a/0x5b0
[  173.156737]  ? handle_mm_fault+0x158/0x340
[  173.156737]  ? ksys_write+0x76/0x170
[  173.156737]  ? __x64_sys_write+0x18/0x30
[  173.156737]  ? do_syscall_64+0x6e/0x100
[  173.156737]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  173.156737]  </TASK>

DEBUG CODE:

With your test code and unwind_debug = 1

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a80ac029bab5..c9d7e6f69e22 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -750,17 +750,24 @@ void __unwind_start(struct unwind_state *state, 
struct task_struct *task,
          * to start unwinding at.  Skip ahead until we reach it.
          */

+orc_warn_current("skipping frames: ");
         /* When starting from regs, skip the regs frame: */
         if (regs) {
                 unwind_next_frame(state);
                 return;
         }
+pr_info("[%pS] %lx\nsp: %lx\nfirst_frame: %lx",
+               (void *)state->ip, state->ip, state->sp,
+               (unsigned long)first_frame);

         /* Otherwise, skip ahead to the user-specified starting frame: */
         while (!unwind_done(state) &&
                (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
                         state->sp < (unsigned long)first_frame))
                 unwind_next_frame(state);
+pr_info("[%pS] %lx\nsp: %lx\nfirst_frame: %lx",
+               (void *)state->ip, state->ip, state->sp,
+               (unsigned long)first_frame);

         return;

DEBUG LOG:

[  173.156737] unwind stack type:1 next_sp:0000000000000000 mask:0x2 
graph_idx:0
[  173.156737] ffffad5d419b3c50: ffffad5d419b3d78 (0xffffad5d419b3d78)
[  173.156737] ffffad5d419b3c58: ffffffffb9490905 
(__unwind_start+0x175/0x220)
[  173.156737] ffffad5d419b3c60: ffffad5d419b3d78 (0xffffad5d419b3d78)
[  173.156737] ffffad5d419b3c68: ffffad5d419b3d68 (0xffffad5d419b3d68)
[  173.156737] ffffad5d419b3c70: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3c78: ffff9c6a02d16580 (0xffff9c6a02d16580)
[  173.156737] ffffad5d419b3c80: ffffffffba69e5fb 
(show_trace_log_lvl+0xc9/0x3fb)
[  173.156737] ffffad5d419b3c88: ffff9c6a3ec9b520 (0xffff9c6a3ec9b520)
[  173.156737] ffffad5d419b3c90: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3c98: ffffffffb953aa17 
(__wake_up_klogd+0xa7/0x100)
[  173.156737] ffffad5d419b3ca0: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3ca8: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3cb0: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3cb8: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3cc0: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3cc8: 0000000000000001 (0x1)
[  173.156737] ffffad5d419b3cd0: ffffad5d419b0000 (0xffffad5d419b0000)
[  173.156737] ffffad5d419b3cd8: ffffad5d419b4000 (0xffffad5d419b4000)
[  173.156737] ffffad5d419b3ce0: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3ce8: 0000000000000002 (0x2)
[  173.156737] ffffad5d419b3cf0: ffff9c6a02d16580 (0xffff9c6a02d16580)
[  173.156737] ffffad5d419b3cf8: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d00: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d08: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d10: ffffad5d419b3c60 (0xffffad5d419b3c60)
[  173.156737] ffffad5d419b3d18: ffffad5d419b3d78 (0xffffad5d419b3d78)
[  173.156737] ffffad5d419b3d20: ffffffffb949097d 
(__unwind_start+0x1ed/0x220)
[  173.156737] ffffad5d419b3d28: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d30: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d38: a4641208047dd200 (0xa4641208047dd200)
[  173.156737] ffffad5d419b3d40: ffffffffbb2829a3 
(msr_save_dmi_table+0x53e9a3/0x544c20)
[  173.156737] ffffad5d419b3d48: 0000000000000000 (0x0)
[  173.156737] ffffad5d419b3d50: 0000000000000001 (0x1)
[  173.156737] ffffad5d419b3d58: 0000000000000001 (0x1)
[  173.156737] ffffad5d419b3d60: ffff9c6a019e0800 (0xffff9c6a019e0800)
[  173.156737] ffffad5d419b3d68: ffffad5d419b3d78 (0xffffad5d419b3d78)
[  173.156737] ffffad5d419b3d70: ffffffffb943d9e4 (show_stack+0x44/0x70)
[  173.156737] ffffad5d419b3d78: 0000000000000002 (0x2)
[  173.156737] ffffad5d419b3d80: ffffffffba6c4628 (dump_stack_lvl+0x79/0xaf)
[  173.156737] ffffad5d419b3d88: 0000000000000202 (0x202)
[  173.156737] ffffad5d419b3d90: 0000000000000001 (0x1)
[  173.156737] ffffad5d419b3d98: ffffffffba6c4671 (dump_stack+0x13/0x1f)
... ...

[  173.156737] [__unwind_start+0x1ed/0x220] ffffffffb949097d
[  173.156737] sp: ffffad5d419b3c60
[  173.156737] first_frame: ffffad5d419b3d78
[  173.156737] [show_stack+0x44/0x70] ffffffffb943d9e4
[  173.156737] sp: ffffad5d419b3d78
[  173.156737] first_frame: ffffad5d419b3d78


As I said in commit log, problem is caused because we got *state->sp == 
first_frame* at the end of __unwind_start().

Could you please try this debug code on your machine and have a look if 
this happened ?

Thanks for your time!


Best,

Chen

