Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E27597D9F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 06:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiHREin (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiHREim (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 00:38:42 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455862CCA4;
        Wed, 17 Aug 2022 21:38:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VMZPVz8_1660797509;
Received: from 192.168.1.120(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VMZPVz8_1660797509)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 12:38:31 +0800
Message-ID: <5b7b3f1c-637c-37bf-9a32-244eb62d543d@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 12:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/2] riscv: kexec: Disable all interrupts in kexec
 crash path
To:     guoren@kernel.org, palmer@dabbelt.com, heiko@sntech.de,
        conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will.deacon@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20220817161258.748836-1-guoren@kernel.org>
 <20220817161258.748836-2-guoren@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20220817161258.748836-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is ok for me

Reviewed-by: Xianting Tian <xianting.tian@linux.alibaba.com>

在 2022/8/18 上午12:12, guoren@kernel.org 写道:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> If a crash happens on cpu3 and all interrupts are binding on cpu0, the
> bad irq routing will cause a crash kernel which can't receive any irq.
> Because crash kernel won't clean up all harts' PLIC enable bits in
> enable registers. This patch is similar to 9141a003a491 ("ARM: 7316/1:
> kexec: EOI active and mask all interrupts in kexec crash path") and
> 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()"), and
> PowerPC also has the same mechanism.
>
> Fixes: fba8a8674f68 ("RISC-V: Add kexec support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Nick Kossifidis <mick@ics.forth.gr>
> ---
>   arch/riscv/kernel/machine_kexec.c | 35 +++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index ee79e6839b86..db41c676e5a2 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -15,6 +15,8 @@
>   #include <linux/compiler.h>	/* For unreachable() */
>   #include <linux/cpu.h>		/* For cpu_down() */
>   #include <linux/reboot.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>   
>   /*
>    * kexec_image_info - Print received image details
> @@ -154,6 +156,37 @@ void crash_smp_send_stop(void)
>   	cpus_stopped = 1;
>   }
>   
> +static void machine_kexec_mask_interrupts(void)
> +{
> +	unsigned int i;
> +	struct irq_desc *desc;
> +
> +	for_each_irq_desc(i, desc) {
> +		struct irq_chip *chip;
> +		int ret;
> +
> +		chip = irq_desc_get_chip(desc);
> +		if (!chip)
> +			continue;
> +
> +		/*
> +		 * First try to remove the active state. If this
> +		 * fails, try to EOI the interrupt.
> +		 */
> +		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> +
> +		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
> +		    chip->irq_eoi)
> +			chip->irq_eoi(&desc->irq_data);
> +
> +		if (chip->irq_mask)
> +			chip->irq_mask(&desc->irq_data);
> +
> +		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
> +			chip->irq_disable(&desc->irq_data);
> +	}
> +}
> +
>   /*
>    * machine_crash_shutdown - Prepare to kexec after a kernel crash
>    *
> @@ -169,6 +202,8 @@ machine_crash_shutdown(struct pt_regs *regs)
>   	crash_smp_send_stop();
>   
>   	crash_save_cpu(regs, smp_processor_id());
> +	machine_kexec_mask_interrupts();
> +
>   	pr_info("Starting crashdump kernel...\n");
>   }
>   
