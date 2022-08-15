Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B7592DD9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiHOLFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiHOLFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 07:05:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCE25EAD;
        Mon, 15 Aug 2022 04:04:59 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M5rv70xxRz1M8wb;
        Mon, 15 Aug 2022 19:01:39 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 19:04:57 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 19:04:57 +0800
Message-ID: <1b8cfda9-8a33-91af-dee1-a0586a11adf1@huawei.com>
Date:   Mon, 15 Aug 2022 19:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86/unwind/orc: Add 'unwind_debug' cmdline option
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
CC:     <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <ardb@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>
References: <20220815105808.17385-1-chenzhongjin@huawei.com>
 <20220815105808.17385-2-chenzhongjin@huawei.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220815105808.17385-2-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I accidentally attached this with my patch.

Please ignore this one.


Thanks,

Chen

On 2022/8/15 18:58, Chen Zhongjin wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Sometimes the one-line ORC unwinder warnings aren't very helpful.  Add a
> new 'unwind_debug' cmdline option which will dump the full stack
> contents of the current task when an error condition is encountered.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> ---
>   .../admin-guide/kernel-parameters.txt         |  6 +++
>   arch/x86/kernel/unwind_orc.c                  | 46 +++++++++++++++++++
>   2 files changed, 52 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cc3ea8febc62..85d48f6052fd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6317,6 +6317,12 @@
>   	unknown_nmi_panic
>   			[X86] Cause panic on unknown NMI.
>   
> +	unwind_debug	[X86-64]
> +			Enable unwinder debug output.  This can be
> +			useful for debugging certain unwinder error
> +			conditions, including corrupt stacks and
> +			bad/missing unwinder metadata.
> +
>   	usbcore.authorized_default=
>   			[USB] Default USB device authorization:
>   			(default -1 = authorized except for wireless USB,
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 38185aedf7d1..c539ca39e9f4 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -13,8 +13,13 @@
>   
>   #define orc_warn_current(args...)					\
>   ({									\
> +	static bool dumped_before;
>   	if (state->task == current && !state->error)			\
>   		orc_warn(args);						\
> +		if (unwind_debug && !dumped_before)			\
> +			unwind_dump(state);				\
> +		dumped_before = true;					\
> +	}								\
>   })
>   
>   extern int __start_orc_unwind_ip[];
> @@ -23,8 +28,49 @@ extern struct orc_entry __start_orc_unwind[];
>   extern struct orc_entry __stop_orc_unwind[];
>   
>   static bool orc_init __ro_after_init;
> +static bool unwind_debug __ro_after_init;
>   static unsigned int lookup_num_blocks __ro_after_init;
>   
> +static int __init unwind_debug_cmdline(char *str)
> +{
> +	unwind_debug = true;
> +
> +	return 0;
> +}
> +early_param("unwind_debug", unwind_debug_cmdline);
> +
> +static void unwind_dump(struct unwind_state *state)
> +{
> +	static bool dumped_before;
> +	unsigned long word, *sp;
> +	struct stack_info stack_info = {0};
> +	unsigned long visit_mask = 0;
> +
> +	if (dumped_before)
> +		return;
> +
> +	dumped_before = true;
> +
> +	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
> +			state->stack_info.type, state->stack_info.next_sp,
> +			state->stack_mask, state->graph_idx);
> +
> +	for (sp = __builtin_frame_address(0); sp;
> +	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> +		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
> +			break;
> +
> +		for (; sp < stack_info.end; sp++) {
> +
> +			word = READ_ONCE_NOCHECK(*sp);
> +
> +			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG/4,
> +					(unsigned long)sp, BITS_PER_LONG/4,
> +					word, (void *)word);
> +		}
> +	}
> +}
> +
>   static inline unsigned long orc_ip(const int *ip)
>   {
>   	return (unsigned long)ip + *ip;

