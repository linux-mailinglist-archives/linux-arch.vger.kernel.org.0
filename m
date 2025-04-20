Return-Path: <linux-arch+bounces-11475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0808A949B5
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 23:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AF03AE79A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95819F40A;
	Sun, 20 Apr 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V14kX5gV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81862111;
	Sun, 20 Apr 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185349; cv=none; b=LZ/z+cMt1mArgO52Ncwm6fYV6n/rS4MCBkVyetWXnaIxVZ5i/jCaWJwSKL6XcsncCSXkKSomRk8keTKKIel+veTArpFzIkLT20fTj6Vea2niF0xIaoL2twTPzhxcG5+CzjJstAxgmxTDrpfHDtEji1fBrZ+QYiBj+DGat2IbPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185349; c=relaxed/simple;
	bh=o3lK09+otg6DgvlTkRd0uEq2A+YS26/sGwIIKbHBcag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrp8cGu1xqtyphUvMQu2kkbWT9wTYfmang4Pk/1xJaSzBuYD/T9yxWNfUJzIFXueC6HvFg5G8Ab6DkRfrUlTindzZhYcDN2Xh6IMtpzkP0vSus0HflLk+B7YCGOjk+oGnM+JzJCWF807ZfHrNCGp2qYCMFwJ18uH2qE8Jx8B9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V14kX5gV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E842BC4CEE2;
	Sun, 20 Apr 2025 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745185348;
	bh=o3lK09+otg6DgvlTkRd0uEq2A+YS26/sGwIIKbHBcag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V14kX5gVKJQ4TKr1kjqcj4uB/vdwkcoBtAzqAd6oYHr/0UFPi5Xb4XNt2bgobpadx
	 fHLW4TYVRN58fg+nvS5iX8RxLw4WD2uHHLtRHXM8Fdzq0zf/m9Jea3Dw9SN4//RZic
	 ATxeSy8c398InEkzqu0EoYWWLNR9+5n7gOY+jzhg+foAWNabfgvGsLuAiv1wAU1p5q
	 gEJO9Hc83boZUsPd9mdUX74gegIaxXpsyScNdEd5NPpa5d0+pAveQwe+GXHrNRv35O
	 JZfCuQ5QtXX/qaeCAd7eOiMQFvnuGssZ557aDkUuMoDftndQ6sqUI8SdS8WUi74F4v
	 27V1otuThl43w==
Date: Sun, 20 Apr 2025 14:42:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 05/13] crypto: arm - move library functions to
 arch/arm/lib/crypto/
Message-ID: <20250420214226.GA14633@sol.localdomain>
References: <20250420192609.295075-1-ebiggers@kernel.org>
 <20250420192609.295075-6-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420192609.295075-6-ebiggers@kernel.org>

On Sun, Apr 20, 2025 at 12:26:01PM -0700, Eric Biggers wrote:
> diff --git a/arch/arm/lib/crypto/Makefile b/arch/arm/lib/crypto/Makefile
> new file mode 100644
> index 0000000000000..dbdf376e25336
> --- /dev/null
> +++ b/arch/arm/lib/crypto/Makefile
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_CRYPTO_BLAKE2S_ARM) += libblake2s-arm.o
> +libblake2s-arm-y:= blake2s-core.o blake2s-glue.o
> +
> +obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
> +chacha-neon-y := chacha-scalar-core.o chacha-glue.o
> +chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
> +
> +obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
> +poly1305-arm-y := poly1305-core.o poly1305-glue.o
> +
> +quiet_cmd_perl = PERL    $@
> +      cmd_perl = $(PERL) $(<) > $(@)
> +
> +$(obj)/%-core.S: $(src)/%-armv4.pl
> +	$(call cmd,perl)
> +
> +clean-files += poly1305-core.S
> +
> +# massage the perlasm code a bit so we only get the NEON routine if we need it
> +poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
> +poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
> +AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)

As noticed by kernel test robot
(https://lore.kernel.org/oe-kbuild-all/202504210545.llc4JaKQ-lkp@intel.com), I
forgot to include the following line here:

    aflags-thumb2-$(CONFIG_THUMB2_KERNEL) := -U__thumb2__ -D__thumb2__=1

