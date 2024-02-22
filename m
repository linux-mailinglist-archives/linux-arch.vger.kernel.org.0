Return-Path: <linux-arch+bounces-2682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270185FD8A
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C758283802
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE56150986;
	Thu, 22 Feb 2024 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzv2zbgY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A114E2EC;
	Thu, 22 Feb 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617870; cv=none; b=Zok+GCm3uaD8OZysqS/ap4oWnC90lfTfb6/cREECAYddZM/HuOAZ3E213tTLwe6vTjwfl+73ngcwisRliS6WtAoyqeOS7bbmXykrFOg++UT97YTHjvvsIHXt2otYJBo4v600PtfbNzlWxLDisuSaV3oNlHsjM+SpI8NXAfVgVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617870; c=relaxed/simple;
	bh=P42TGDqNMaruT+fPW7RuapqiiWQ3asGq5OrEFjudad4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9vPnMMwIusoGSzsSqjAjRFrFg4fYc6EWlsiVNrFZEfe9ynHsaZ4piMW4Y6t1/XkgSko4FX46sSD22Ex5GZEGruiTBo1pNhPMh3jwTEAEpyagRn75vbXvmRPURye6TmULqeak7pFf1gMOVsDd9IcW0jTuPWg5G7Wj+sD3enqdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzv2zbgY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so2975166b3a.3;
        Thu, 22 Feb 2024 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617868; x=1709222668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2wZuvLUzB5Xua90WdGXe0WBeqHgCvMlx7+R6zIRuFc=;
        b=Tzv2zbgYycGTwH/UQmxdCV/cYwsYj0dkMCUqK+wH4FUeCdSt2w0bNomEZYNkDiLTkl
         muNszid5SGf8OxpesRJRtojPX54kC+soQJqK9C0CyxWBhMJ25UI3oDgDWjj+XuTDkBJ9
         EcmUDzMZCd7VtVExufioUmL5bKeodgj+knBRDzwbLa5cy3GNZnv35+tAtDoFtDbdBOvv
         myQSFmCUG5wGHnly0Tp5FUPFvXwjsFAkg64LomBcDjb1PsJna4/qUXfxm1mYD8imCi8w
         WNy+TUVcdv1PpF5Yrq/RDrTf/GivsqwB3e4WL4QSUcXON5Fk/41porGkTbEJ5VovTsQL
         /dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617868; x=1709222668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2wZuvLUzB5Xua90WdGXe0WBeqHgCvMlx7+R6zIRuFc=;
        b=AgtUEE4QeS5EldvZpi50LT6QQ33KTZxLo9kTXTOMxab16XvW8oHCUDLTg0kSH4+j49
         RSIJf2gEcBa9Gy45gcER9tYbVV3i20NF+q/cPudbtlXGEnVVYOJU4OX61uRZj10sIftC
         BuwTKS7QHHBYtfpj/MniHglIaoDcpkYt3zXTBPWLxtiUhLpKJQF6YL5kO/PEepm94dzp
         0CHb6NmmJOkxayFtyYKtcAxK2ky/qFOyHXISmZ6qWeLIrFFh6wkVTLWLuAuohhybKcWj
         TXgrC2RcGh1F5I1lKTYzdsePhmt8L0i7AYOuMIh4X3V1DkcJxcQmHWEyrnfKP1F2MVqr
         tjfA==
X-Forwarded-Encrypted: i=1; AJvYcCUzwlXsINqCgZlzsO7p9gd3KEljS0K9IPnfyeeN4cSOljQVdnGUeecf91EqnYeZO9upiCewbHAo+AcEROC7mPObPG36/iUolDZT1u4ZrA8HphRCvOi+6/xg1xZ0W8Rg6REt6DT0ASTn2etrqG0vgqDhX5UWLvJMvGK8CZCKNPRMUx5qYJ2KgA==
X-Gm-Message-State: AOJu0YwwHQAh54ZJYnRs8i0q3nXFwgF/7Cku12uPKc6poHJphsDtZgHA
	zQ8o/Up4Xrjubawk3kJS03qtjB10AzYglE1H+cFqol+zvh1G4agp
X-Google-Smtp-Source: AGHT+IFBJklfrmfWsNk9Zx3owdvhwzqUMmVPAwpM0bP01dIqsN8oHERt6/Te9gpGsniCrhGBngqMqQ==
X-Received: by 2002:a05:6a00:b54:b0:6e4:8ea9:5e5c with SMTP id p20-20020a056a000b5400b006e48ea95e5cmr6634801pfo.27.1708617868390;
        Thu, 22 Feb 2024 08:04:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lo20-20020a056a003d1400b006e4c4b7e6f5sm2199600pfb.208.2024.02.22.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:04:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Feb 2024 08:04:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] parisc: checksum: Use generic implementations
Message-ID: <e7bb76ae-285d-4840-ba58-c3fc5c5af6ec@roeck-us.net>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
 <20240221-parisc_use_generic_checksum-v1-2-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-2-ad34d895fd1b@rivosinc.com>

On Wed, Feb 21, 2024 at 06:37:12PM -0800, Charlie Jenkins wrote:
> The generic implementations of the checksum functions
> csum_tcpudp_nofold, csum_fold, and ip_compute_csum are either identical
> or perform better than the parisc ones, so use the generic
> implementations instead.
> 
> In order to use the generic implementations of checksum functions,
> do_csum can no longer be static.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/parisc/Kconfig                |  3 +++
>  arch/parisc/include/asm/checksum.h | 42 ++++++++------------------------------
>  arch/parisc/lib/checksum.c         |  2 +-
>  3 files changed, 13 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index d14ccc948a29..1638deb23287 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -122,6 +122,9 @@ config GENERIC_BUG
>  config GENERIC_BUG_RELATIVE_POINTERS
>  	bool
>  
> +config GENERIC_CSUM
> +	def_bool y
> +
>  config GENERIC_HWEIGHT
>  	bool
>  	default y
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
> index 3c43baca7b39..c7847a08ef7c 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -17,6 +17,7 @@
>   * it's best to have buff aligned on a 32-bit boundary
>   */
>  extern __wsum csum_partial(const void *, int, __wsum);
> +#define csum_partial csum_partial
>  
>  /*
>   *	Optimized for IP headers, which always checksum on 4 octet boundaries.
> @@ -57,20 +58,8 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  	return (__force __sum16)sum;
>  }
>  
> -/*
> - *	Fold a partial checksum
> - */
> -static inline __sum16 csum_fold(__wsum csum)
> -{
> -	u32 sum = (__force u32)csum;
> -	/* add the swapped two 16-bit halves of sum,
> -	   a possible carry from adding the two 16-bit halves,
> -	   will carry from the lower half into the upper half,
> -	   giving us the correct sum in the upper half. */
> -	sum += (sum << 16) + (sum >> 16);
> -	return (__force __sum16)(~sum >> 16);
> -}
> - 
> +#define ip_fast_csum ip_fast_csum
> +
>  static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
>  					__u32 len, __u8 proto,
>  					__wsum sum)
> @@ -85,28 +74,15 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
>  	return sum;
>  }
>  
> -/*
> - * computes the checksum of the TCP/UDP pseudo-header
> - * returns a 16-bit checksum, already complemented
> - */
> -static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
> -					__u32 len, __u8 proto,
> -					__wsum sum)
> -{
> -	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
> -}
> -
> -/*
> - * this routine is used for miscellaneous IP-like checksums, mainly
> - * in icmp.c
> - */
> -static inline __sum16 ip_compute_csum(const void *buf, int len)
> -{
> -	 return csum_fold (csum_partial(buf, len, 0));
> -}
> +#define csum_tcpudp_nofold csum_tcpudp_nofold
>  
> +extern unsigned int do_csum(const unsigned char *buff, int len);
> +#define do_csum do_csum
>  
>  #define _HAVE_ARCH_IPV6_CSUM
> +
> +#include <asm-generic/checksum.h>
> +
>  static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  					  const struct in6_addr *daddr,
>  					  __u32 len, __u8 proto,
> diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
> index 4818f3db84a5..05f5ca4b2f96 100644
> --- a/arch/parisc/lib/checksum.c
> +++ b/arch/parisc/lib/checksum.c
> @@ -34,7 +34,7 @@ static inline unsigned short from32to16(unsigned int x)
>  	return (unsigned short)x;
>  }
>  
> -static inline unsigned int do_csum(const unsigned char * buff, int len)
> +unsigned int do_csum(const unsigned char *buff, int len)
>  {
>  	int odd, count;
>  	unsigned int result = 0;
> 
> -- 
> 2.34.1
> 

