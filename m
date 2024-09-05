Return-Path: <linux-arch+bounces-7065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878996DC19
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 16:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087F528A789
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247024AEEA;
	Thu,  5 Sep 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2YOjheR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB741E521;
	Thu,  5 Sep 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547132; cv=none; b=C++PBvB53atCBbYz4CtHUDywqjbKfYwLcx941+F02z8MvICIFYWpPZbagG7HE3pSOEU1RqHshFSmoRtYmWF1yAM4Y76EiTBldK4NKv2JZEdxq685BU7htVdUlduETnQ+piQEJ2NOk37H4h0wGZCyOc+7jkXCTRySfXbXzagmGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547132; c=relaxed/simple;
	bh=vcauXydy8x37ftyhjB4duujVq1w/VunfLD6enxt17oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjNGqlGhHuK5H14XX5rfPfMOwGY4rpfoxGZkgBh0LM1upL1BqRtPIl3R1eVp/D/vCpP1RbJ9EfPmMoDA89IKoXJzMVjXhsBU0WoUKGO+6xyFMKO/G6B2uiscqczmTt9zD+Tvr3msHIYYqr++uu9tztnxgC6B1bKvbXfvrB2N9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2YOjheR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BEC4CEC3;
	Thu,  5 Sep 2024 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547131;
	bh=vcauXydy8x37ftyhjB4duujVq1w/VunfLD6enxt17oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2YOjheRb949eFSbuKXatjy28tUv9s5L8nDgQqSRsR17dQMJ+g7E7wkszTSL9zpl5
	 oTl+nCCqjPxADrqKB+bPsOJp/UizpTcTQqyTd4neL2n6RVQk53ty0mfWT3IcffRER8
	 qxl3ktDVdKrJxSUHAssEYPPLPdSs8hB7uPIcX5NLfG+9xH+Jky46UPdfRkFOp0J7QA
	 zFRdgQyb9nO6bY7FFOjUApbFIrskY566QAcadTzw5xJq7C15ti1B0iTPLFF6cXPPVw
	 UI8TeWIaEK+rE31kEj1fNKmr59fODTo5ayUwL9UzF2f++VtPFasU2RDc+NQEQ/AoMN
	 7ja30u6a9UiYw==
Date: Thu, 5 Sep 2024 09:38:50 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 14/15] kbuild: rename CONFIG_GENERIC_BUILTIN_DTB to
 CONFIG_BUILTIN_DTB
Message-ID: <20240905143850.GD1517132-robh@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
 <20240904234803.698424-15-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904234803.698424-15-masahiroy@kernel.org>

On Thu, Sep 05, 2024 at 08:47:50AM +0900, Masahiro Yamada wrote:
> Now that all architectures have migrated to the generic built-in
> DTB support, the GENERIC_ prefix is no longer necessary.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile                             | 2 +-
>  arch/arc/Kconfig                     | 2 +-
>  arch/loongarch/Kconfig               | 1 -
>  arch/microblaze/Kconfig              | 2 +-
>  arch/mips/Kconfig                    | 1 -
>  arch/nios2/platform/Kconfig.platform | 1 -
>  arch/openrisc/Kconfig                | 2 +-
>  arch/riscv/Kconfig                   | 1 -
>  arch/sh/Kconfig                      | 1 -
>  arch/xtensa/Kconfig                  | 2 +-
>  drivers/of/Kconfig                   | 2 +-
>  scripts/Makefile.vmlinux             | 2 +-
>  scripts/link-vmlinux.sh              | 2 +-
>  13 files changed, 8 insertions(+), 13 deletions(-)

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e1d3e5fb6fd2..70f169210b52 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -388,7 +388,6 @@ endchoice
>  config BUILTIN_DTB
>  	bool "Enable built-in dtb in kernel"
>  	depends on OF
> -	select GENERIC_BUILTIN_DTB
>  	help
>  	  Some existing systems do not provide a canonical device tree to
>  	  the kernel at boot time. Let's provide a device tree table in the

> diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
> index c75cadd92388..5f0cf551b5ca 100644
> --- a/arch/nios2/platform/Kconfig.platform
> +++ b/arch/nios2/platform/Kconfig.platform
> @@ -38,7 +38,6 @@ config NIOS2_DTB_PHYS_ADDR
>  config BUILTIN_DTB
>  	bool "Compile and link device tree into kernel image"
>  	depends on !COMPILE_TEST
> -	select GENERIC_BUILTIN_DTB

> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1110,7 +1110,6 @@ config RISCV_ISA_FALLBACK
>  config BUILTIN_DTB
>  	bool "Built-in device tree"
>  	depends on OF && NONPORTABLE

Humm, maybe this NONPORTABLE option could be common and used to 
accomplish what I want here...

> -	select GENERIC_BUILTIN_DTB

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 3b772378773f..b09019cd87d4 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -648,7 +648,6 @@ config BUILTIN_DTB
>  	bool "Use builtin DTB"
>  	default n
>  	depends on SH_DEVICE_TREE
> -	select GENERIC_BUILTIN_DTB

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 5142e7d7fef8..53a227ca3a3c 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -2,7 +2,7 @@
>  config DTC
>  	bool
>  
> -config GENERIC_BUILTIN_DTB
> +config BUILTIN_DTB
>  	bool

I'm confused. We can't have the same config option twice, can we?

Rob

