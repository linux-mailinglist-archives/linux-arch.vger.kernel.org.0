Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456245BF95C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIUIfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiIUIe5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 04:34:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C92346216;
        Wed, 21 Sep 2022 01:34:54 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXWnH3N6hzMn6D;
        Wed, 21 Sep 2022 16:30:11 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:34:53 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 16:34:52 +0800
Message-ID: <afa17bdd-2d11-4015-6e2a-7a39db931d09@huawei.com>
Date:   Wed, 21 Sep 2022 16:34:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Content-Language: en-US
To:     <guoren@kernel.org>, <arnd@arndb.de>, <palmer@rivosinc.com>,
        <tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
        <conor.dooley@microchip.com>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <mark.rutland@arm.com>,
        <zouyipeng@huawei.com>, <bigeasy@linutronix.de>,
        <David.Laight@aculab.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-9-guoren@kernel.org>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220918155246.1203293-9-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2022/9/18 23:52, guoren@kernel.org wrote:
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 5f49517cd3a2..426529b84db0 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -332,6 +332,33 @@ ENTRY(ret_from_kernel_thread)
>   	tail syscall_exit_to_user_mode
>   ENDPROC(ret_from_kernel_thread)
>   
> +#ifdef CONFIG_IRQ_STACKS
> +ENTRY(call_on_stack)
> +	/* Create a frame record to save our ra and fp */
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	ra, (sp)
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	fp, (sp)
> +
> +	/* Save sp in fp */
> +	move	fp, sp
> +
> +	/* Move to the new stack and call the function there */
> +	li	a3, IRQ_STACK_SIZE
> +	add	sp, a1, a3
> +	jalr	a2
> +
> +	/*
> +	 * Restore sp from prev fp, and fp, ra from the frame
> +	 */
> +	move	sp, fp
> +	REG_L	fp, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +	REG_L	ra, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +	ret
> +ENDPROC(call_on_stack)
> +#endif

Seems my compiler (riscv64-linux-gnu-gcc 8.4.0, cross compiling from 
x86) cannot recognize the register `fp`.

After I changed it to `s0` this can pass compiling.


Seems there is nowhere else using `fp`, can this just using `s0` instead?

Best,

Chen

