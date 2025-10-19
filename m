Return-Path: <linux-arch+bounces-14192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C1BEDF32
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E9D4E2383
	for <lists+linux-arch@lfdr.de>; Sun, 19 Oct 2025 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C221A95D;
	Sun, 19 Oct 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl0KoSN2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2865178372;
	Sun, 19 Oct 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760856631; cv=none; b=K/78XNAKiDzDOooJcNp6Eu7AipUYBG1kPLI8N/p5Cza3u1FLaw2JLMT5Zo8BYIUgv2wrfJXIekPQJ4MKhqrHKYxeHu2n5PKjQi/v1gR9tQPp1p0HCXWMQh93jRWQwhafmjrxGk3HtW7t1K2WNNouBp355Vl+DkRC1mW8enY/ZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760856631; c=relaxed/simple;
	bh=EdgpjTa5vPTpdpYEzLk3B3e9bf5d6qYFWAfS+EwNqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiUeVLimD7Xq4wSNC3HT1XLtnTbynNPLVCwp5kXj5tnPfO2LiZS7Aq3Hwcs9tAOrM4NxzNwsFxaGc+bDR/nSuaoZCEWPzZS0KK5z/1IrC2OiPCslTQ4AtyUyXJrOlkgO0X0N3i/BwgXUfIqBbW8d97EvWjh0wtDx/lsiuCVDo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl0KoSN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F25C4CEE7;
	Sun, 19 Oct 2025 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760856630;
	bh=EdgpjTa5vPTpdpYEzLk3B3e9bf5d6qYFWAfS+EwNqnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl0KoSN24WldfEYSRSfu5lozmGJAVE9xioGE6C+PBBseYSuE/7hgf2KbKvxu1nAfq
	 +AnxTaK9VaE7xdn62r2Zk9oFnNMs7lSpecdggsfr9Z5mfbyraggVUnrWZwla30ASHd
	 TTQUKVBXbjDXmyKfOdXMojvKQKorenot/jpefXad8wpoUyJQ/gWBwcSUSTx6MlFUkq
	 O4BqR0RMnSAfMnvUpkN7wKJhQIsaUmfqwAekVS20NwyN/940rzzKb69Mu6Ni7vQrxn
	 4PzVEO7y+ixH5H5iambi/6vum/20jOqyGoZB3A2tTRPyBtt8DjbzWrov4g4xwvEbN2
	 ljhF5KLlm27vA==
Date: Sun, 19 Oct 2025 02:50:21 -0400
From: Guo Ren <guoren@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/17] csky: Add __attribute_const__ to ffs()-family
 implementations
Message-ID: <aPSKLRnWUAVSGQjF@gmail.com>
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804164417.1612371-3-kees@kernel.org>

On Mon, Aug 04, 2025 at 09:43:59AM -0700, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> Add missing __attribute_const__ annotations to C-SKY's implementations of
> ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
> functions that always return the same result for the same input with no
> side effects, making them eligible for compiler optimization.
LGTM.

Acked-by: Guo Ren <guoren@kernel.org>

> 
> Build tested ARCH=csky defconfig with GCC csky-linux 15.1.0.
> 
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  arch/csky/include/asm/bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
> index 72e1b2aa29a0..80d67eee6e86 100644
> --- a/arch/csky/include/asm/bitops.h
> +++ b/arch/csky/include/asm/bitops.h
> @@ -9,7 +9,7 @@
>  /*
>   * asm-generic/bitops/ffs.h
>   */
> -static inline int ffs(int x)
> +static inline __attribute_const__ int ffs(int x)
>  {
>  	if (!x)
>  		return 0;
> @@ -26,7 +26,7 @@ static inline int ffs(int x)
>  /*
>   * asm-generic/bitops/__ffs.h
>   */
> -static __always_inline unsigned long __ffs(unsigned long x)
> +static __always_inline __attribute_const__ unsigned long __ffs(unsigned long x)
>  {
>  	asm volatile (
>  		"brev %0\n"
> @@ -39,7 +39,7 @@ static __always_inline unsigned long __ffs(unsigned long x)
>  /*
>   * asm-generic/bitops/fls.h
>   */
> -static __always_inline int fls(unsigned int x)
> +static __always_inline __attribute_const__ int fls(unsigned int x)
>  {
>  	asm volatile(
>  		"ff1 %0\n"
> @@ -52,7 +52,7 @@ static __always_inline int fls(unsigned int x)
>  /*
>   * asm-generic/bitops/__fls.h
>   */
> -static __always_inline unsigned long __fls(unsigned long x)
> +static __always_inline __attribute_const__ unsigned long __fls(unsigned long x)
>  {
>  	return fls(x) - 1;
>  }
> -- 
> 2.34.1
> 
> 

