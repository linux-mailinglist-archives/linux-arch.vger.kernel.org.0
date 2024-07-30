Return-Path: <linux-arch+bounces-5731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2B941F52
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED731C215E6
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A58187FE2;
	Tue, 30 Jul 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxblxc6X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494454648;
	Tue, 30 Jul 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363362; cv=none; b=aO+6gc+DcRYUcryDXxw/XkN/k8w1+CkMPTOJcjXGBkrDItYFerezpf+dAkLOpKAut+aT8d15kIf9KTmgDjYHeC0yyu88kC90PXYyNYKKXkYb/QFVTEzLmjLaiq+j2ZBICPW+GyNKMOcBCk6TaVS9L9cWUFLjO0iwDUnwIYibapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363362; c=relaxed/simple;
	bh=7Dt+EiDOIG9FTgUWs5mQwUm3EnLxmry8VZ4p/ANjCEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbcKDt84S788BcOTYlBJx0sAvZ3NiRSnZDctcfnzkO/slw7akeAMZ9Rn4EbE6ytJxoRQQSAJaLj82/ACsJE0p70hiVe2hmAoHVJCyKnLm+Mbab01Opy2Nbrqqu0iFuydXEVHtLUAZGgV9TyyhclP+XHf2s0KzWTYnX8cGGj9pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxblxc6X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so3468004b3a.3;
        Tue, 30 Jul 2024 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722363361; x=1722968161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3d05lVpk2PS8LF6saDvzv531mIV2sO6Z2VMgmPghOMA=;
        b=Gxblxc6XyoTAgCmq9hAg5iwNRhiCg9d7QtxsM+8TRutBwwbGsfOMdPU4AURAOdcam3
         Zb8i77vJpzAv0hOMvureC1yznobJued/QgrNxfuMuViPzw5HKNNkt/L85E3g+fgh27Tv
         ILcqWSJz/Z9ciC88DooazQssHHR6sDttu0S0/JrDwifk7ts9J6EU0U4IYkq3JsRn1IFQ
         rWmtx2Zzm8merw5Myev8CTLKboWvmvEI77cjfIp9PdAVd9fKknr0W+YkO/9QGdGs1rXB
         j+lGSHvd/66iYqylbr3piUQIwHJ9qtDI3RWFVXirN7VgyNtPUSKD2F4/GfzMymltbL6x
         ptag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363361; x=1722968161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d05lVpk2PS8LF6saDvzv531mIV2sO6Z2VMgmPghOMA=;
        b=V/1gH9s46gXiBy5SGJJJcVS7vSR8n1Ur3orWTO/CaZFqLTYa7N3IOijozZp29FQHIm
         QUgFDQR3XV6yJVesWOpWxJ+V5U9+KDA45MGziu6U8L0SzKmnzTtqlchrtagF7Z15pIcx
         xCSqcMR9xcSwhvxrsAYqnnNaZuJ7n59O00vb+S42VXUrl7g3OwIgcWgxPhAyK0FyVGYq
         4L/sxSfpcVMysgx5yLhHjdkh9i4mWjn1Vl4w7p4Uk5Mb+Z7W5LgnYhpevc6V1XaFQSli
         SN3xEOAjtok9zOh+knN1YE4eJw8qOGsK8y6rC2bn1F2nlvODyHAusmw3BGKpEi8ZrSSC
         cXtA==
X-Forwarded-Encrypted: i=1; AJvYcCXIb+8eoGzKl20W/QAHDFFhALYvy6AuZHxHPNhzIhqI7VScNGrUH3YQJslvUk38L+kyjtz8/3gNYqBdwqeY41PWR4aSfWD1IMnxrA==
X-Gm-Message-State: AOJu0YyZ3WjeAPgHuHLlsk4mOcQQ8a9e4Qnmh/ow5GcMOhQLa9EraOxM
	YPKeNsgGOMME59FY1TGtdwYzNC46wPsKM5nEyNqjAmW2RV77nDIl
X-Google-Smtp-Source: AGHT+IHb2fKz1aXKzt0sKcve3mazQq1tjUkBukTatORAeLSphnAmbrsZ1UhkMTNPJ61IK+qaEXbtLA==
X-Received: by 2002:a05:6a20:a111:b0:1c0:ee57:a9a3 with SMTP id adf61e73a8af0-1c4a13a354dmr11043975637.35.1722363360629;
        Tue, 30 Jul 2024 11:16:00 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead87d58asm8986339b3a.177.2024.07.30.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:15:59 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:15:57 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V2 1/2] uapi: Define GENMASK_U128
Message-ID: <Zqkt3byHNZQvCZiB@yury-ThinkPad>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725054808.286708-2-anshuman.khandual@arm.com>

On Thu, Jul 25, 2024 at 11:18:07AM +0530, Anshuman Khandual wrote:
> This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
> and __int128 data types. These macros will be used in providing support for
> generating 128 bit masks.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/bits.h                   | 2 ++
>  include/uapi/asm-generic/bitsperlong.h | 2 ++
>  include/uapi/linux/bits.h              | 3 +++
>  include/uapi/linux/const.h             | 1 +
>  4 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 0eb24d21aac2..0a174cce09d2 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -35,5 +35,7 @@
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>  #define GENMASK_ULL(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> +#define GENMASK_U128(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>  
>  #endif	/* __LINUX_BITS_H */
> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
> index fadb3f857f28..6275367b17bb 100644
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,6 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
>  
> +#define __BITS_PER_U128 128

Do we need such a macro for a fixed-width type? Even if we do, I'm not
sure that a header named bitsperlong.h is a good place to host it.

> +
>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 3c2a101986a3..4d4b7b08003c 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -12,4 +12,7 @@
>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>  
> +#define __GENMASK_U128(h, l) \
> +	((_BIT128((h) + 1)) - (_BIT128(l)))
> +
>  #endif /* _UAPI_LINUX_BITS_H */
> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index a429381e7ca5..a0211136dfd8 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -27,6 +27,7 @@
>  
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))
> +#define _BIT128(x)	((unsigned __int128)(1) << (x))

GENMASK() macros may be used in assembly code. This is not the case
for GENMASK_128 at this time, of course, but I think we'd introduce 
assembly glue at this point to simplify things in future. Can you
check the include/uapi/linux/const.h and add something like _U128()
in there?

>  
>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> -- 
> 2.30.2

