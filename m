Return-Path: <linux-arch+bounces-5736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD294246C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 04:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF841C21156
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 02:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DCDDD2;
	Wed, 31 Jul 2024 02:08:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688FD51C;
	Wed, 31 Jul 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391681; cv=none; b=d6GGTRwPfx4cpy1jRnx6pksINXJ/K0EsjRXotUeY12qwPYE35pCu+76ZQqwevYCth5AkK8Tq/sJAo/pbRhjEVAn9j7s27Qdeaq5hz6Z07wbCl1pZmPHZ49iNds/OkPtuho9s6b8OnFmCHztU8LlcRj6Z3FPJCaUh7WqPVWY1ldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391681; c=relaxed/simple;
	bh=35PjJBOStJHfs3CcqH4NT7m0IULmwTL7mQZn2DspvVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C39Jxo0lKG1yecG5bbWs+EU8zwOymCv+MPMu2TpwNBZV2l6rPn3RsWHsJAtYcxW8VoVsomqhPilXx4bJTySwwfS90xh1U+M6MaszmGEQBPBE6WQEOrnEdgTOPwrT8eQZsQ0rN20vJF6625ds/dUfUYy62aess+1gcsgrsD4ycW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYb6j31hJzgYQB;
	Wed, 31 Jul 2024 10:06:05 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B79F31400DD;
	Wed, 31 Jul 2024 10:07:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 10:07:54 +0800
Message-ID: <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
Date: Wed, 31 Jul 2024 10:07:53 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
Content-Language: en-US
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<vincent.whitchurch@axis.com>, <bhe@redhat.com>, <nico@fluxnic.net>,
	<ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240620090028.729373-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Gentle ping.

On 2024/6/20 17:00, Jinjie Ruan wrote:
> Enable support for PREEMPT_DYNAMIC on arm32, allowing the preemption model
> to be chosen at boot time.
> 
> Similar to arm64, arm32 does not yet use the generic entry code, we must
> define our own `sk_dynamic_irqentry_exit_cond_resched`, which will be
> enabled/disabled by the common code in kernel/sched/core.c.
> 
> And arm32 use generic preempt.h, so declare
> `sk_dynamic_irqentry_exit_cond_resched` if the arch do not use generic
> entry. Other architectures which use generic preempt.h but not use generic
> entry can benefit from it.
> 
> Test ok with the below cmdline parameters on Qemu versatilepb board:
> 	`preempt=none`
> 	`preempt=voluntary`
> 	`preempt=full`
> 
> Update preempt mode with debugfs interface on above Qemu board is also
> tested ok:
> 	# cd /sys/kernel/debug/sched
> 	# echo none > preempt
> 	# echo voluntary > preempt
> 	# echo full > preempt
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm/Kconfig                 |  1 +
>  arch/arm/include/asm/exception.h |  2 ++
>  arch/arm/kernel/Makefile         |  2 +-
>  arch/arm/kernel/common.c         | 13 +++++++++++++
>  arch/arm/kernel/entry-armv.S     |  7 ++++++-
>  include/asm-generic/preempt.h    |  5 +++++
>  6 files changed, 28 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/kernel/common.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 036381c5d42f..843f320dde7f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -124,6 +124,7 @@ config ARM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_PREEMPT_DYNAMIC_KEY
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RSEQ
> diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
> index 3c82975d46db..ac96b76b394e 100644
> --- a/arch/arm/include/asm/exception.h
> +++ b/arch/arm/include/asm/exception.h
> @@ -12,4 +12,6 @@
>  
>  #define __exception_irq_entry	__irq_entry
>  
> +bool need_irq_preemption(void);
> +
>  #endif /* __ASM_ARM_EXCEPTION_H */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 89a77e3f51d2..58acd62dc5e9 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -17,7 +17,7 @@ CFLAGS_REMOVE_return_address.o = -pg
>  
>  # Object file lists.
>  
> -obj-y		:= elf.o entry-common.o irq.o opcodes.o \
> +obj-y		:= common.o elf.o entry-common.o irq.o opcodes.o \
>  		   process.o ptrace.o reboot.o io.o \
>  		   setup.o signal.o sigreturn_codes.o \
>  		   stacktrace.o sys_arm.o time.o traps.o
> diff --git a/arch/arm/kernel/common.c b/arch/arm/kernel/common.c
> new file mode 100644
> index 000000000000..52b0abcae07e
> --- /dev/null
> +++ b/arch/arm/kernel/common.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/jump_label.h>
> +#include <asm/exception.h>
> +
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +
> +bool need_irq_preemption(void)
> +{
> +	return static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched);
> +}
> +#endif
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 6150a716828c..571e86433833 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -221,6 +221,11 @@ __irq_svc:
>  	irq_handler from_user=0
>  
>  #ifdef CONFIG_PREEMPTION
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +	bl	need_irq_preemption
> +	cmp	r0, #0
> +	beq	2f
> +#endif
>  	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
>  	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
>  	teq	r8, #0				@ if preempt count != 0
> @@ -228,7 +233,7 @@ __irq_svc:
>  	tst	r0, #_TIF_NEED_RESCHED
>  	blne	svc_preempt
>  #endif
> -
> +2:
>  	svc_exit r5, irq = 1			@ return from exception
>   UNWIND(.fnend		)
>  ENDPROC(__irq_svc)
> diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
> index 51f8f3881523..2db7a3e86303 100644
> --- a/include/asm-generic/preempt.h
> +++ b/include/asm-generic/preempt.h
> @@ -2,6 +2,7 @@
>  #ifndef __ASM_PREEMPT_H
>  #define __ASM_PREEMPT_H
>  
> +#include <linux/jump_label.h>
>  #include <linux/thread_info.h>
>  
>  #define PREEMPT_ENABLED	(0)
> @@ -89,6 +90,10 @@ void dynamic_preempt_schedule_notrace(void);
>  #define __preempt_schedule()		dynamic_preempt_schedule()
>  #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
>  
> +#ifndef CONFIG_GENERIC_ENTRY
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#endif
> +
>  #else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
>  
>  #define __preempt_schedule() preempt_schedule()

