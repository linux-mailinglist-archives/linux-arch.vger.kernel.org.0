Return-Path: <linux-arch+bounces-233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A47EE5CC
	for <lists+linux-arch@lfdr.de>; Thu, 16 Nov 2023 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F5A1C2094B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Nov 2023 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1B2E636;
	Thu, 16 Nov 2023 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F548CFD
	for <linux-arch@vger.kernel.org>; Thu, 16 Nov 2023 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC63C433C8;
	Thu, 16 Nov 2023 17:18:33 +0000 (UTC)
Date: Thu, 16 Nov 2023 17:18:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: will@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
	arnd@arndb.de, mark.rutland@arm.com, broonie@kernel.org,
	keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	patches@amperecomputing.com
Subject: Re: [PATCH] arm64: irq: set the correct node for VMAP stack
Message-ID: <ZVZO55IjQSbzWnfG@arm.com>
References: <20231114091643.59530-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114091643.59530-1-shijie@os.amperecomputing.com>

On Tue, Nov 14, 2023 at 05:16:43PM +0800, Huang Shijie wrote:
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 6ad5c6ef5329..e62d3cb3f74c 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -57,7 +57,7 @@ static void init_irq_stacks(void)
>  	unsigned long *p;
>  
>  	for_each_possible_cpu(cpu) {
> -		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
> +		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
>  		per_cpu(irq_stack_ptr, cpu) = p;
>  	}
>  }

This looks alright to me, I don't have a better suggestion. The generic
code already has the cpu_to_node_map[] array populated by
early_map_cpu_to_node(), so let's reuse it.

> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index eaa31e567d1e..90519d981471 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>  unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
>  EXPORT_SYMBOL(__per_cpu_offset);
>  
> -static int __init early_cpu_to_node(int cpu)
> +int early_cpu_to_node(int cpu)
>  {
>  	return cpu_to_node_map[cpu];
>  }
> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> index 1a3ad6d29833..fc8a9bd6a444 100644
> --- a/include/asm-generic/numa.h
> +++ b/include/asm-generic/numa.h
> @@ -38,6 +38,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid);
>  void numa_store_cpu_info(unsigned int cpu);
>  void numa_add_cpu(unsigned int cpu);
>  void numa_remove_cpu(unsigned int cpu);
> +int early_cpu_to_node(int cpu);

Here I'd move this just below early_map_cpu_to_node() and, for
completeness, also add the dummy static inline for the !NUMA case.

-- 
Catalin

