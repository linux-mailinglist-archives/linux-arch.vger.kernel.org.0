Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9658597D9C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbiHREjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiHREjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 00:39:04 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A46745E;
        Wed, 17 Aug 2022 21:39:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VMZAcHU_1660797537;
Received: from 192.168.1.120(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VMZAcHU_1660797537)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 12:38:58 +0800
Message-ID: <b66b9b63-5fdb-951b-439e-79b547b33d6a@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 12:38:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 2/2] riscv: kexec: Fixup crash_smp_send_stop with
 percpu crash_save_cpu
To:     guoren@kernel.org, palmer@dabbelt.com, heiko@sntech.de,
        conor.dooley@microchip.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20220817161258.748836-1-guoren@kernel.org>
 <20220817161258.748836-3-guoren@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20220817161258.748836-3-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
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
> Current crash_smp_send_stop is the same as the generic one in
> kernel/panic and misses crash_save_cpu in percpu. This patch is inspired
> by 78fd584cdec0 ("arm64: kdump: implement machine_crash_shutdown()")
> and adds the same mechanism for riscv.
>
> Fixes: ad943893d5f1 ("RISC-V: Fixup schedule out issue in machine_crash_shutdown()")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   arch/riscv/include/asm/smp.h      |  6 +++
>   arch/riscv/kernel/machine_kexec.c | 19 ++-----
>   arch/riscv/kernel/smp.c           | 89 ++++++++++++++++++++++++++++++-
>   3 files changed, 96 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index d3443be7eedc..8b40e15bea36 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -50,6 +50,12 @@ void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
>   /* Clear IPI for current CPU */
>   void riscv_clear_ipi(void);
>   
> +/* stop and save status for other CPUs */
> +void crash_smp_send_stop(void);
> +
> +/* Check other CPUs stop or not */
> +bool smp_crash_stop_failed(void);
> +
>   /* Secondary hart entry */
>   asmlinkage void smp_callin(void);
>   
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index db41c676e5a2..34c86d337448 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -140,22 +140,6 @@ void machine_shutdown(void)
>   #endif
>   }
>   
> -/* Override the weak function in kernel/panic.c */
> -void crash_smp_send_stop(void)
> -{
> -	static int cpus_stopped;
> -
> -	/*
> -	 * This function can be called twice in panic path, but obviously
> -	 * we execute this only once.
> -	 */
> -	if (cpus_stopped)
> -		return;
> -
> -	smp_send_stop();
> -	cpus_stopped = 1;
> -}
> -
>   static void machine_kexec_mask_interrupts(void)
>   {
>   	unsigned int i;
> @@ -230,6 +214,9 @@ machine_kexec(struct kimage *image)
>   	void *control_code_buffer = page_address(image->control_code_page);
>   	riscv_kexec_method kexec_method = NULL;
>   
> +	WARN(smp_crash_stop_failed(),
> +		"Some CPUs may be stale, kdump will be unreliable.\n");
> +
>   	if (image->type != KEXEC_TYPE_CRASH)
>   		kexec_method = control_code_buffer;
>   	else
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 760a64518c58..a75ad9c373cd 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -12,6 +12,7 @@
>   #include <linux/clockchips.h>
>   #include <linux/interrupt.h>
>   #include <linux/module.h>
> +#include <linux/kexec.h>
>   #include <linux/profile.h>
>   #include <linux/smp.h>
>   #include <linux/sched.h>
> @@ -27,6 +28,7 @@ enum ipi_message_type {
>   	IPI_RESCHEDULE,
>   	IPI_CALL_FUNC,
>   	IPI_CPU_STOP,
> +	IPI_CPU_CRASH_STOP,
>   	IPI_IRQ_WORK,
>   	IPI_TIMER,
>   	IPI_MAX
> @@ -71,6 +73,22 @@ static void ipi_stop(void)
>   		wait_for_interrupt();
>   }
>   
> +#ifdef CONFIG_KEXEC_CORE
> +static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
> +
> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> +{
> +	crash_save_cpu(regs, cpu);
> +
> +	atomic_dec(&waiting_for_crash_ipi);
> +
> +	local_irq_disable();
> +
> +	while(1)
> +		wait_for_interrupt();
> +}
> +#endif
> +
>   static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
>   
>   void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
> @@ -124,8 +142,9 @@ void arch_irq_work_raise(void)
>   
>   void handle_IPI(struct pt_regs *regs)
>   {
> -	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> -	unsigned long *stats = ipi_data[smp_processor_id()].stats;
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long *pending_ipis = &ipi_data[cpu].bits;
> +	unsigned long *stats = ipi_data[cpu].stats;
>   
>   	riscv_clear_ipi();
>   
> @@ -154,6 +173,13 @@ void handle_IPI(struct pt_regs *regs)
>   			ipi_stop();
>   		}
>   
> +		if (ops & (1 << IPI_CPU_CRASH_STOP)) {
> +#ifdef CONFIG_KEXEC_CORE
> +			ipi_cpu_crash_stop(cpu, get_irq_regs());
> +#endif
> +			unreachable();
> +		}
> +
>   		if (ops & (1 << IPI_IRQ_WORK)) {
>   			stats[IPI_IRQ_WORK]++;
>   			irq_work_run();
> @@ -176,6 +202,7 @@ static const char * const ipi_names[] = {
>   	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
>   	[IPI_CALL_FUNC]		= "Function call interrupts",
>   	[IPI_CPU_STOP]		= "CPU stop interrupts",
> +	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
>   	[IPI_IRQ_WORK]		= "IRQ work interrupts",
>   	[IPI_TIMER]		= "Timer broadcast interrupts",
>   };
> @@ -235,6 +262,64 @@ void smp_send_stop(void)
>   			   cpumask_pr_args(cpu_online_mask));
>   }
>   
> +#ifdef CONFIG_KEXEC_CORE
> +/*
> + * The number of CPUs online, not counting this CPU (which may not be
> + * fully online and so not counted in num_online_cpus()).
> + */
> +static inline unsigned int num_other_online_cpus(void)
> +{
> +	unsigned int this_cpu_online = cpu_online(smp_processor_id());
> +
> +	return num_online_cpus() - this_cpu_online;
> +}
> +
> +void crash_smp_send_stop(void)
> +{
> +	static int cpus_stopped;
> +	cpumask_t mask;
> +	unsigned long timeout;
> +
> +	/*
> +	 * This function can be called twice in panic path, but obviously
> +	 * we execute this only once.
> +	 */
> +	if (cpus_stopped)
> +		return;
> +
> +	cpus_stopped = 1;
> +
> +	/*
> +	 * If this cpu is the only one alive at this point in time, online or
> +	 * not, there are no stop messages to be sent around, so just back out.
> +	 */
> +	if (num_other_online_cpus() == 0)
> +		return;
> +
> +	cpumask_copy(&mask, cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), &mask);
> +
> +	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
> +
> +	pr_crit("SMP: stopping secondary CPUs\n");
> +	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
> +
> +	/* Wait up to one second for other CPUs to stop */
> +	timeout = USEC_PER_SEC;
> +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
> +		udelay(1);
> +
> +	if (atomic_read(&waiting_for_crash_ipi) > 0)
> +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
> +			cpumask_pr_args(&mask));
> +}
> +
> +bool smp_crash_stop_failed(void)
> +{
> +	return (atomic_read(&waiting_for_crash_ipi) > 0);
> +}
> +#endif
> +
>   void smp_send_reschedule(int cpu)
>   {
>   	send_ipi_single(cpu, IPI_RESCHEDULE);
