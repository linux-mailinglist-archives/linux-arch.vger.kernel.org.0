Return-Path: <linux-arch+bounces-429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287F7F646C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0623328188F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08C3D99A;
	Thu, 23 Nov 2023 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B42231F
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 16:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D2C433CB;
	Thu, 23 Nov 2023 16:55:33 +0000 (UTC)
Date: Thu, 23 Nov 2023 16:55:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: will@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
	arnd@arndb.de, mark.rutland@arm.com, broonie@kernel.org,
	keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	patches@amperecomputing.com
Subject: Re: [PATCH v3] arm64: irq: set the correct node for VMAP stack
Message-ID: <ZV-EA46rBJ9WK4UH@arm.com>
References: <ZVZO55IjQSbzWnfG@arm.com>
 <20231118160205.3923-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118160205.3923-1-shijie@os.amperecomputing.com>

On Sun, Nov 19, 2023 at 12:02:05AM +0800, Huang Shijie wrote:
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

I don't think we need this change, let's make the arm64
init_irq_stacks() an __init function instead.

> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> index 1a3ad6d29833..16073111bffc 100644
> --- a/include/asm-generic/numa.h
> +++ b/include/asm-generic/numa.h
> @@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
>  void __init numa_set_distance(int from, int to, int distance);
>  void __init numa_free_distance(void);
>  void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> +int early_cpu_to_node(int cpu);

And add __init here.

With these changes:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Happy to take this patch through the arm64 tree if I get an ack from
Greg or Rafael on the drivers/* change.

