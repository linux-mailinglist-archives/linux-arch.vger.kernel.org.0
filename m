Return-Path: <linux-arch+bounces-436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC17F730A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5A6B213F1
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D961EB5C;
	Fri, 24 Nov 2023 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD191EB54
	for <linux-arch@vger.kernel.org>; Fri, 24 Nov 2023 11:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85693C433C9;
	Fri, 24 Nov 2023 11:47:40 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:47:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: will@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
	arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] arm64: irq: set the correct node for VMAP stack
Message-ID: <ZWCNWkYCjMU4-Ef2@arm.com>
References: <ZV-EA46rBJ9WK4UH@arm.com>
 <20231124031513.81548-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124031513.81548-1-shijie@os.amperecomputing.com>

On Fri, Nov 24, 2023 at 11:15:13AM +0800, Huang Shijie wrote:
> In current code, init_irq_stacks() will call cpu_to_node().
> The cpu_to_node() depends on percpu "numa_node" which is initialized in:
>      arch_call_rest_init() --> rest_init() -- kernel_init()
> 	--> kernel_init_freeable() --> smp_prepare_cpus()
> 
> But init_irq_stacks() is called in init_IRQ() which is before
> arch_call_rest_init().
> 
> So in init_irq_stacks(), the cpu_to_node() does not work, it
> always return 0. In NUMA, it makes the node 1 cpu accesses the IRQ stack which
> is in the node 0.
> 
> This patch fixes it by:
>   1.) export the early_cpu_to_node(), and use it in the init_irq_stacks().
>   2.) change init_irq_stacks() to __init function.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>  
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v3 --> v4:
> 	1.) keep early_cpu_to_node() as __init function.
> 	2.) change init_irq_stacks() to __init function.
> 
> ---
>  arch/arm64/kernel/irq.c    | 5 +++--
>  drivers/base/arch_numa.c   | 2 +-
>  include/asm-generic/numa.h | 2 ++
>  3 files changed, 6 insertions(+), 3 deletions(-)

Greg, Rafael - any objections to taking this patch through the arm64
tree?

-- 
Catalin

