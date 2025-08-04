Return-Path: <linux-arch+bounces-13055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A70B1A87B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 19:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD62189E696
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A28B7C2;
	Mon,  4 Aug 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQT4A0HX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFC28B7C8;
	Mon,  4 Aug 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327712; cv=none; b=O+LBmYOwjj9aSYvnOZTYb9I9orkJ3EH45nBAVsJD8O7FeikOIbgw00AJGc8WnWdZ0PDE/5DwOUzE9AjLIUFtuO5OP0CR3yfypl7CUU7w8e1TDLH2fkkUfWg7Dnq7KxUxVArLDduxeq6dWcYwNGLZsw21zvUQVimqRcz4wZy12R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327712; c=relaxed/simple;
	bh=BSv3IA5IuUJhTBGL3xkgYTrQYKCsOpXUGxp4B+QDShQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBA55IBiITPf/AMu87R4ToESOJiXDhPDT4y321e/t/MUk13vEq03Acz5p4QcqR9qYg4f8C6oRu/bJ7rcXi5g2Li8XLHDwrRbII33Re3JiQj2mSFNLhfq/OW2XRhyqHCzXtEwfNN5dlhnhe3IE1YH+GXmb1FmunTDEf4+Z7OLCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQT4A0HX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so4270019f8f.1;
        Mon, 04 Aug 2025 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754327709; x=1754932509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ES2rPSb96ZRcMua/upicMCXBbX2m2hK2sP3TCwY9yY=;
        b=aQT4A0HX7Yhe1QBPudZ9z6uA6g2ztMghILxkwoHdJl/54YUKpZojtXTC5I/wtjJtGU
         eY9Ng8t4fmknUy8U+h2UWX7bQtS3zIjC+Yo9QQ8V4Xxn5VPov2dksZyHAsOvFVR28Vdp
         T6M0Gtm/svrAPvVXR+Wl5IXMfnTlGThNgzUsVE6HxDNIdDQN7QWh7pb+2VFp1aQ4PiJV
         pnpNYEhVD73HjIVAv028uFTbyECOiM3zuk8JyC85r3JesH82ANcfW1xHJ8are/0jPF5w
         IZ0T1iP+C1ZMDC0nAiXpwAPjaMXWHXmZkF+Vikjwy8Q37mWcYaGKD/nxIOlReFwjy+jZ
         LCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327709; x=1754932509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ES2rPSb96ZRcMua/upicMCXBbX2m2hK2sP3TCwY9yY=;
        b=omukHCyz4xk1ks8H13qLBn7ty/jKr0Qo//WUnOv+IH8ywflJDK8vHXMjkEHpzSp/BF
         XYF7OzrZkfMFfemMeeQ75KYwXV3FFboBmUfa9SqGKPm9sRz/dDrUUkItGKxrgt+Vd0My
         EbuJrj5jFRaiUsiZk9/k6+V3/+qaNowhEZY8ZbELEeRPcXXU68Jt018wseY6Ne4IW1km
         YxioMr9YgJcHv6niUqtej7pZYnYsjeCLpOA/UhLffkrDewhgeRnylW2jJv9GAxr7SB83
         o3t8n5tge4dqUegmOu8WmbvRsPtbTNESMp47n0HVJi3hNcmM1m+Z3sZXEmS/fxUtpkCz
         tU/w==
X-Forwarded-Encrypted: i=1; AJvYcCU0m7XEwmuCDoco97peZpaqHf8G5a6dj/nD45RzpcvVLr5iX+/y6oXD9l1g5xFBk1NEXt5z96sDFkWo4a54@vger.kernel.org, AJvYcCU6wiwswe/SFszy5DPELgnWKrKtB7q2CsPrXO76c2e/g2TSM+Bt44NFBCkVEDs6USigNmlNDbQhBiXtDQ==@vger.kernel.org, AJvYcCU9y181hioliuSVTVDHkSCzk+rOAGKmgTIjfzNqyYjMyFxEiEtIWWotj9xbDd+uW1eq6HwBd4uxdZSkFw==@vger.kernel.org, AJvYcCUStDhvxK4Ig3Zm45fMmtK48iWAXscbPgi0CFUWkSmYSHFcdEt121iaHPDOuWLv7BfwVvZo0lA9acKGZci3jI0=@vger.kernel.org, AJvYcCUvVPI+QtAGnF/VhH+UN2EyVYmKrKJyPMXyXhL2qw8EzZyhGmhQrNIBvN82s9evm67KYWuoK2vxfQufwH65@vger.kernel.org, AJvYcCVOB0e69P8qEcTCa+sOUdny+p7bBvU+zMpUou2pdzjOM+4nn+qD9LJZq+Kw1WDBtxfgcBXgF703j50DBg==@vger.kernel.org, AJvYcCVjOp7T1phVp4iwX9aX8kpnoNKba4Uz5HGFZhtslYbU7tqveRprbPJjNvbz9Ek34GDgAOzEk4UJHJVgKg==@vger.kernel.org, AJvYcCVuvw/MDrysBxm5oJt0KoUVDTLYdwpEMtftMbiKBRruzLh93bk47bdyD15hItTG0lxISGtUY+wcSgE=@vger.kernel.org, AJvYcCXZLc/13w3/DRkSo/3Cr/rOyzjtVgTUM7QWo/pEdJGfLUwmUvat9vNRlhR7PXl0wWHT/qYsCaXV+PDte7Hurg==@vger.kernel.org, AJvYcCXsxJ06
 5lm171omKaw2tRnEnd0I1onVVA+hqPv0IELRu4wix2qjo2x6x2Mop1fHb3/1AfyDzHvPlIYl6w==@vger.kernel.org, AJvYcCXtdfsqaQ+FpAnFhCE/bJ0qXeS2fQSxIYgBURCzFwCzTWD4psiO4sj9XGvRPG9abLiecxyPGi2nU5AKrw0gJMNC@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwWwpzuZb+B9KHJnVGuPuywheglaAXnJiAQdDdxu343INxFyz
	FF6WY7/o+GOHKT6aTQ2RYk8Ko3Z1ii30jahS9Ki4nGla1CdpVcv3cnJ/
X-Gm-Gg: ASbGncsU+6cT5FumNdZ0u2Z7MwadyQVEjX2tEPse7/jHRPgAcL/iRcCgYWH4zTjh3Tt
	2Viy9sFxr50sNXNYUuEovZqvXZNQMra+51IimSlUMFvRCuwfhtS9jprgr7hEiZXujOE//1uUI+r
	C+364z1WxDXI1sR2zVtBc8ILj9vM50hqtYWOfQPjAa7DwVKiN9Vk1sj7bj6zucr5lkUTGQIGx9W
	TDp7pqtzNFF947djSNLCS5hmQ2+w8Ou15hPhx7ArEzVYHCAAKddgVI8yg+ic0izYbhZnxEOBEm8
	57Hcuhkk24bvUfEFjCxmW81Us4q+CCq4Axxld6+FZjtO+Rcr7GEjSs33eWCrycqfGUPwLFHep4P
	eoywWp64SmfLkMO0v0Nb7gakdEE0ZdMNomPjNzQNNXtJC3Ih7EAXinQBdlpvrWA==
X-Google-Smtp-Source: AGHT+IEpNawQWUPhZIXoNWLCtN2+qaXCsKArzNXCXzW1yE3i7/WUxeM9GsxIUXvlWMi666W2l82q6Q==
X-Received: by 2002:a05:6000:40c9:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3b8d94cf20dmr7323692f8f.53.1754327708754;
        Mon, 04 Aug 2025 10:15:08 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm16051546f8f.61.2025.08.04.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 10:15:07 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:15:06 +0100
From: Stafford Horne <shorne@gmail.com>
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
Subject: Re: [PATCH 10/17] openrisc: Add __attribute_const__ to ffs()-family
 implementations
Message-ID: <aJDqmoUNhwWeAlpa@antec>
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-10-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804164417.1612371-10-kees@kernel.org>

On Mon, Aug 04, 2025 at 09:44:06AM -0700, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> Add missing __attribute_const__ annotations to OpenRISC's implementations of
> ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
> functions that always return the same result for the same input with no
> side effects, making them eligible for compiler optimization.
> 
> Build tested ARCH=openrisc defconfig with GCC or1k-linux 15.1.0.

THis looks ok to me.

> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/include/asm/bitops/__ffs.h | 2 +-
>  arch/openrisc/include/asm/bitops/__fls.h | 2 +-
>  arch/openrisc/include/asm/bitops/ffs.h   | 2 +-
>  arch/openrisc/include/asm/bitops/fls.h   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/bitops/__ffs.h b/arch/openrisc/include/asm/bitops/__ffs.h
> index 1e224b616fdf..4827b66530b2 100644
> --- a/arch/openrisc/include/asm/bitops/__ffs.h
> +++ b/arch/openrisc/include/asm/bitops/__ffs.h
> @@ -11,7 +11,7 @@
>  
>  #ifdef CONFIG_OPENRISC_HAVE_INST_FF1
>  
> -static inline unsigned long __ffs(unsigned long x)
> +static inline __attribute_const__ unsigned long __ffs(unsigned long x)
>  {
>  	int ret;
>  
> diff --git a/arch/openrisc/include/asm/bitops/__fls.h b/arch/openrisc/include/asm/bitops/__fls.h
> index 9658446ad141..637cc76fe4b7 100644
> --- a/arch/openrisc/include/asm/bitops/__fls.h
> +++ b/arch/openrisc/include/asm/bitops/__fls.h
> @@ -11,7 +11,7 @@
>  
>  #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
>  
> -static inline unsigned long __fls(unsigned long x)
> +static inline __attribute_const__ unsigned long __fls(unsigned long x)
>  {
>  	int ret;
>  
> diff --git a/arch/openrisc/include/asm/bitops/ffs.h b/arch/openrisc/include/asm/bitops/ffs.h
> index b4c835d6bc84..536a60ab9cc3 100644
> --- a/arch/openrisc/include/asm/bitops/ffs.h
> +++ b/arch/openrisc/include/asm/bitops/ffs.h
> @@ -10,7 +10,7 @@
>  
>  #ifdef CONFIG_OPENRISC_HAVE_INST_FF1
>  
> -static inline int ffs(int x)
> +static inline __attribute_const__ int ffs(int x)
>  {
>  	int ret;
>  
> diff --git a/arch/openrisc/include/asm/bitops/fls.h b/arch/openrisc/include/asm/bitops/fls.h
> index 6b77f6556fb9..77da7639bb3e 100644
> --- a/arch/openrisc/include/asm/bitops/fls.h
> +++ b/arch/openrisc/include/asm/bitops/fls.h
> @@ -11,7 +11,7 @@
>  
>  #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
>  
> -static inline int fls(unsigned int x)
> +static inline __attribute_const__ int fls(unsigned int x)
>  {
>  	int ret;
>  
> -- 
> 2.34.1
> 
> 

