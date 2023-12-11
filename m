Return-Path: <linux-arch+bounces-882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4384C80CAC9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17DF281F1F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C5D3E477;
	Mon, 11 Dec 2023 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIX+Piq0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A83D96A;
	Mon, 11 Dec 2023 13:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D26C433C7;
	Mon, 11 Dec 2023 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702300894;
	bh=pdOjaPV9Jsg2+hufBUTJoin1FtJ4JLo5gH1YiEsQ8lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIX+Piq0oQQdGn8TD0Edg+vyONGxOr1LGqK2bq6Dsi6ovtOvnWpT/rIpQOFhBlA3b
	 RD+M0Y9olHV8bbTdPocbTzZZmSuQtM3wSgOKRufOCXeKAdrG2YkwpRzI1hwx19gfpd
	 R8J7br7NfDKSsDo3Ubfz/IzHwRPxRpH0UZXsDmakCZQtxs8yx3CHcht0dAUUySZ72W
	 7ezqAlqh/1/ULVq4w52iqG1vo6pwpmtsxVWD0ybb3R5KpAvHOys51oI1D1oLC2d49W
	 kbq2skXfspeTVUkdhvgV61N5n4rZQ8glL+SZEddbiQ/dbTg34ryLGY2yDr7oygKcuA
	 WwZRQbf9JcgXw==
Date: Mon, 11 Dec 2023 13:21:27 +0000
From: Will Deacon <will@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/21] arm64: convert to arch_cpu_is_hotpluggable()
Message-ID: <20231211132127.GD25681@willie-the-truck>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3g-00Cszg-PP@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r5R3g-00Cszg-PP@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 21, 2023 at 01:44:56PM +0000, Russell King (Oracle) wrote:
> Convert arm64 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm64/kernel/setup.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 165bd2c0dd5a..42c690bb2d60 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -402,13 +402,9 @@ static inline bool cpu_can_disable(unsigned int cpu)
>  	return false;
>  }
>  
> -int arch_register_cpu(int num)
> +bool arch_cpu_is_hotpluggable(int num)
>  {
> -	struct cpu *cpu = &per_cpu(cpu_devices, num);
> -
> -	cpu->hotpluggable = cpu_can_disable(num);
> -
> -	return register_cpu(cpu, num);
> +	return cpu_can_disable(num);
>  }
>  
>  static void dump_kernel_offset(void)

Acked-by: Will Deacon <will@kernel.org>

Will

