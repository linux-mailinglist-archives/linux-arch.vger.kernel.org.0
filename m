Return-Path: <linux-arch+bounces-2681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE085FD83
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47881B21D33
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E714E2EC;
	Thu, 22 Feb 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYhswNZw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EF14E2C9;
	Thu, 22 Feb 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617862; cv=none; b=VImALA2JUEjpyPwap+OsXOJJh/Quly2Cr74y2UAvcb9hhuwsF1DIeZGFYLiOZsNxAq3w4dj3x1aDyxblCYhtpse7WF4wE0zU9ZgB/c+vECBhvO8SA6hR8AbxA2rCfAkmCP2YfDSSPyG2DrVUozAcovuxUnmO/4Al7ykSZtfoYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617862; c=relaxed/simple;
	bh=tx5AnOPaHZjR9nwJDGCDrP/Ld3W/I7cUJf4jLuRUobg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE5liI++z2F2JpgjrHPZIb5Jle97X2dXyH01q3VHAwuveYBj3vsrqx2pGHfWK/GlR5tLbPav1JGI8cu8Bw6UWZheknUv43CauACvlfaIa6U2qDr1X58iqaiLXVER9m3ggZgVYsRghwysucQvsqgKbmAQArAF9QnfIJ/n2dmspNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYhswNZw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7232dcb3eso49545775ad.2;
        Thu, 22 Feb 2024 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617860; x=1709222660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCcVLelkerZ/rfS+OB1Df5D3kOgx+DV+QELs8JDtIG4=;
        b=QYhswNZwv/rCkF9W5/YjxHyJ+VRuxoVSYmxCCLQuqLxuV/eixtzD5SzFINbjEjmr60
         6dGd7KUOUlRVTyOYO8Ke8H9h/1z+P3YCCKZebRg5Olnj1gwDUpzOk8YPF20cJZ79v8ba
         YpQ3knP7tYMuTFpx6WC4OATmPsFlxFXJ2aVNvmyi7WrvLRaAtR2cqg46y3RO/favvmoP
         DtHMpdyd4ecvyxDVt5YpXxX3uo5gHaII9Z8YuZuBIwoxacfHE9XiJpLZPM8gQHMlOXMa
         QEtGo9VAJez0xdBTBmkTRv8XcIN10SCdi63WHBOJ4Ua1F7mPHF9vfrGsYwTh4PoIkmKe
         w01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617860; x=1709222660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCcVLelkerZ/rfS+OB1Df5D3kOgx+DV+QELs8JDtIG4=;
        b=Czi1sssMEf8/Q+vQC4iP4WEKDK3lozfV7Pl9mkw4lsuS9zXL6NTqQoWWq509MaB5C4
         ReqapDAg0ZIgREngoQpvSGpBK7pRe+BglE1yaING8ZjsA2eBPKHnpVQ2Mufw9CfhgAz5
         DN++fxi8rqIHV8DjQUTUAOxHRMHVa2Ql4VXOGcGKCKiP5xXLwqDcT3rPtyKssu70f80k
         0u2ZS9thgNXKkjpVELL9hCqkU+NDrCkzYAw0kw5iyy1Q3j7st/kZNQV/UKSowkgkLK7c
         6ekv140Z2O/JwTw7l3mv2HMWpDOW7JpbXq+FRD7myLf0Y3uV5UUCag1Pt05VwJp/+/Ee
         ZCxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjoUFFJ+piZYQcR8xhtmgejwzeGd7YR2tcXcEkGz8TLcShVT8uxlY9lRHXiYj1QIzsdf1jbXF3UD183s4ASemFsnapDnJwT48t3olg5fKDXedFr3UaWfkwWK9Xu65HpJVrurw5PmE8+7FQdpydoFfFokwxh7OcYqrAOcdsYUYA9S2WtM0g/w==
X-Gm-Message-State: AOJu0YwTQh6mQe9u2zqutL80065rA3m8xP81uu5IeXozo6nsQv9ZrthK
	YGUplPnZ/1YKkm4TNfA91vHPGfWiserot0T01NNsAGZFYYXqXWm7
X-Google-Smtp-Source: AGHT+IGJdyeUbV3A+evMrI6PMjno1ReQ6CIcLH3hdNrN5VATyN7MK04L9SBiPR5aXEGBTE725uolMA==
X-Received: by 2002:a17:902:d489:b0:1dc:1e7c:cd3 with SMTP id c9-20020a170902d48900b001dc1e7c0cd3mr8918913plg.47.1708617858899;
        Thu, 22 Feb 2024 08:04:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001db4b3769f6sm10025000plg.280.2024.02.22.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:04:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Feb 2024 08:04:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] asm-generic headers: Allow csum_partial arch override
Message-ID: <212db8ca-c01c-4cb0-b794-50931338afb9@roeck-us.net>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
 <20240221-parisc_use_generic_checksum-v1-1-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-1-ad34d895fd1b@rivosinc.com>

On Wed, Feb 21, 2024 at 06:37:11PM -0800, Charlie Jenkins wrote:
> Arches can have more a efficient implementation of csum_partial.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/asm-generic/checksum.h | 2 ++
>  lib/checksum.c                 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
> index ad928cce268b..3309830ba2cb 100644
> --- a/include/asm-generic/checksum.h
> +++ b/include/asm-generic/checksum.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bitops.h>
>  
> +#ifndef csum_partial
>  /*
>   * computes the checksum of a memory block at buff, length len,
>   * and adds in "sum" (32-bit)
> @@ -17,6 +18,7 @@
>   * it's best to have buff aligned on a 32-bit boundary
>   */
>  extern __wsum csum_partial(const void *buff, int len, __wsum sum);
> +#endif
>  
>  #ifndef ip_fast_csum
>  /*
> diff --git a/lib/checksum.c b/lib/checksum.c
> index 6860d6b05a17..c115a9ac71d9 100644
> --- a/lib/checksum.c
> +++ b/lib/checksum.c
> @@ -110,6 +110,7 @@ __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  EXPORT_SYMBOL(ip_fast_csum);
>  #endif
>  
> +#ifndef csum_partial
>  /*
>   * computes the checksum of a memory block at buff, length len,
>   * and adds in "sum" (32-bit)
> @@ -134,6 +135,7 @@ __wsum csum_partial(const void *buff, int len, __wsum wsum)
>  	return (__force __wsum)result;
>  }
>  EXPORT_SYMBOL(csum_partial);
> +#endif
>  
>  /*
>   * this routine is used for miscellaneous IP-like checksums, mainly
> 
> -- 
> 2.34.1
> 

