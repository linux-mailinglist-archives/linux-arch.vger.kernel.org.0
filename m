Return-Path: <linux-arch+bounces-11444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B005A930C8
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0116EFB1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93892263C71;
	Fri, 18 Apr 2025 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S90kDL67"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0552101BD;
	Fri, 18 Apr 2025 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946928; cv=none; b=S3KnTAXw5l9AK8KwqD1jwM/tNhfcKPfnIG6TcOH7mTs/GMUd7MIQI6fa3bcg1yiF2A7dtxgqeSJ63MydzhScu4/syVvIZiqTKy4pZkY4OZfmpOSnQJDF3u5UTm+ljSOTitD9aHu7vvseTrsOkRpcGWtwlvNWKvDOMh9mV6tLGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946928; c=relaxed/simple;
	bh=paa/9NZKZKpdwfQILoGguW2nvATTkdoCMaZ8TYAofx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvJBVczevmBOR1RQqi8dyOKX2Tn3TWeC7Ulckhpp1lsBiM3IhDKOt4/4YE+UlDNQvkJ0i9MPzdB9W5cWNzV9vskcfS/KMvDoDACdUGD3bmCjhQ19MPHUYz6/b/w24t4Hp8iAMB+iy6VYIPPlktJ/7pxX1GVnflbjbHphJt8mDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S90kDL67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD9C4CEE2;
	Fri, 18 Apr 2025 03:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744946927;
	bh=paa/9NZKZKpdwfQILoGguW2nvATTkdoCMaZ8TYAofx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S90kDL67H31uSpEv4ZrQD4HD18zmryec0gLnj6+7QnaMN47KnnOiTpqryL9vUNJ0A
	 OOlF1S+mKh49+xCZJuOOZXg0mYOqjU0Q39rMBTaO7x4ZZ6rpyfpPUNEX8HBVkfOsLD
	 EY0RfFI9paylTf22uMjv+BqRmKRkmXOwmB9ECQuP3FNHB5Wy7t4nZwSuepETOw2lRW
	 Qz6m6UZdgJj7wiKuWat9qhSWie5OoLWjIimkGMx6zHjaxZh+mzrUBzik42/Ul41jJB
	 R4/dQdFwKtEZseJeVkLQbr6lQOpHAW5m/VQwglLYHWTuPTm5l0lXEg+EXy1tPH0mfa
	 VY0mvYrHgNZ8g==
Date: Thu, 17 Apr 2025 20:28:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <20250418032845.GA38960@quark.localdomain>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHCIL_sYIS_1JQH@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAHCIL_sYIS_1JQH@gondor.apana.org.au>

On Fri, Apr 18, 2025 at 11:08:16AM +0800, Herbert Xu wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 25ed6f1a7c7a..86fcce738887 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1753,5 +1753,7 @@ config ARCH_HIBERNATION_POSSIBLE
> >        bool
> >        depends on MMU
> >        default y if ARCH_SUSPEND_POSSIBLE
> > 
> > endmenu
> > +
> > +source "arch/arm/crypto/Kconfig"
> 
> ...
> 
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 9322e42e562d..cad71f32e1e3 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -1424,13 +1424,10 @@ endmenu
> > 
> > config CRYPTO_HASH_INFO
> >        bool
> > 
> > if !KMSAN # avoid false positives from assembly
> > -if ARM
> > -source "arch/arm/crypto/Kconfig"
> > -endif
> 
> So this removes the KMSAN check.  Is it still needed or not?
> 

Only x86 and s390 support KMSAN.

- Eric

