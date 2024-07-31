Return-Path: <linux-arch+bounces-5785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97B94343B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DA21C21AB0
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295731B3F08;
	Wed, 31 Jul 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru429+M+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBC1B14E8;
	Wed, 31 Jul 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443927; cv=none; b=AHKE7G0M5nqRqZWen6skVPjufAZi1r8Y/s9xhJfPJv9BT1Xn0eTlZYUHg59YpJ1esej6xlv7U1M7N45Ip6BesUMdQ4qVA/gWy/f97E6PfJQrpnaRF1iufIiU1cEGm/i8SbwMkmohoHFEaubxSCpQeKnpdA0Zaem9GQSBn/uiXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443927; c=relaxed/simple;
	bh=Ax2M8eZolJ5AqIl+ZFAh4EOOJ/giVQYBxYUBY3D/57w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBZs4Xfw7WzQPbrqd2l9Yx5J8/vk60TU67PH7OAn6nTkCIyjClWQRUBDOLBHEp6vbx1VKDHCpb9O1YcPVMbtCoXt5SY2jR5E9zSWxkiqoEDzRXSppkMXhrazsXRkSvNaVMCS4XaX1mKtS2wnHLrFgqT9cSsgG4X8zeIX0ehjnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru429+M+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7163489149eso4257480a12.1;
        Wed, 31 Jul 2024 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722443925; x=1723048725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btG52vS5eF8c6WYn6xfMUyCfzZayQfXXcyfEYjYJiBI=;
        b=Ru429+M+WKuv99vc54Zcdzlapzpo+rVQyvNbT6d4pMZSLqx79HPBTbRxikDWswiQwA
         zSUZM4000MjQ2Ji5xUXpVmTjR61GlpeDOjnJHfnrW7QlB1eZHXMJrwZe3lPqtiDLBT9q
         VBdtV35lvZ42Q25PF5M5hVbXIrxLDg0Vkx3W2bC3IhA6KTrTt6gFdkDhcCXBj+Mm0Uod
         POErufkel6fQA0kRqxL0uBnvKDnpmTwFb7yXrMRQ8Bl+FwJYZQ2AJDYaTZIN8kiWrRh3
         7z5Y7/cfaoyHxCTmz9R4oJKwcOW+TEw7TiTrg9YrR8lwbEjN2kJTA44XJtcm4ZTQv84n
         1GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443925; x=1723048725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btG52vS5eF8c6WYn6xfMUyCfzZayQfXXcyfEYjYJiBI=;
        b=D0WGaOZwDWdRZG9sM1N/FXqUeLTGa9fiQ4NciwVcOHsFd/PQPBz5OgqZyKkG/RkHiQ
         ua4SElDQQNRn8JEbsE3MvbTYSu1M+QoSkuBfH3bT45aEqafxTUPTrR1T08lW4XL4YKKU
         vTfz8lqr8LDKuPt+KpaPG2LlGcRfXVeuSFGzYxSELhmv+V3P+dpdN8Hl9ii8uzVR5nax
         oAXMvWMLnI/Q0keaKIdDzKqyWd1co2nXFYzpegSy8nfL8LBCF4Do8YWw36Qs99WmAPrk
         RiP/YtiQo5xfeOFKiCla+I9yywK5wnW4tJq89B9XmAKBkpaHCHDmeIP/zXV5ClaRA3D4
         QuPg==
X-Forwarded-Encrypted: i=1; AJvYcCX+wbaJAlxgGS18CqlLGG2mcNsux6hPqQiryQpRHOMWO0dRDHzCh4KUoO5XwNWxIK/hCmwHE1GnCQDwXRNPEkO5ddYAEF5hacVAmA==
X-Gm-Message-State: AOJu0YwlOj0ArNaeSJUd9CUNg+TGmqT5p6oxnuDuAP5oKQUVTScmvezn
	mv894If/PBxlTKpeGZTOt1cElLbqWqwVACFST1EiysIuAUQLYUer
X-Google-Smtp-Source: AGHT+IEs+4Dn4uNxpriOCfxp/I79l74lDnaM1jv97vbGKORPOSXyawgVXyMyYPwdErDOvzrmZeAJwA==
X-Received: by 2002:a17:90b:b12:b0:2cd:40ef:4763 with SMTP id 98e67ed59e1d1-2cf7e1d4e55mr15791173a91.15.1722443924643;
        Wed, 31 Jul 2024 09:38:44 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4513ecsm1585679a91.20.2024.07.31.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:38:44 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:38:41 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V2 1/2] uapi: Define GENMASK_U128
Message-ID: <ZqpokVWg75iROgKH@yury-ThinkPad>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-2-anshuman.khandual@arm.com>
 <Zqkt3byHNZQvCZiB@yury-ThinkPad>
 <b1dd907d-d45b-4602-964e-70654094a315@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1dd907d-d45b-4602-964e-70654094a315@arm.com>

On Wed, Jul 31, 2024 at 09:14:54AM +0530, Anshuman Khandual wrote:
> 
> 
> On 7/30/24 23:45, Yury Norov wrote:
> > On Thu, Jul 25, 2024 at 11:18:07AM +0530, Anshuman Khandual wrote:
> >> This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
> >> and __int128 data types. These macros will be used in providing support for
> >> generating 128 bit masks.
> >>
> >> Cc: Yury Norov <yury.norov@gmail.com>
> >> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Cc: Arnd Bergmann <arnd@arndb.de>>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-arch@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  include/linux/bits.h                   | 2 ++
> >>  include/uapi/asm-generic/bitsperlong.h | 2 ++
> >>  include/uapi/linux/bits.h              | 3 +++
> >>  include/uapi/linux/const.h             | 1 +
> >>  4 files changed, 8 insertions(+)
> >>
> >> diff --git a/include/linux/bits.h b/include/linux/bits.h
> >> index 0eb24d21aac2..0a174cce09d2 100644
> >> --- a/include/linux/bits.h
> >> +++ b/include/linux/bits.h
> >> @@ -35,5 +35,7 @@
> >>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >>  #define GENMASK_ULL(h, l) \
> >>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> >> +#define GENMASK_U128(h, l) \
> >> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> >>  
> >>  #endif	/* __LINUX_BITS_H */
> >> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
> >> index fadb3f857f28..6275367b17bb 100644
> >> --- a/include/uapi/asm-generic/bitsperlong.h
> >> +++ b/include/uapi/asm-generic/bitsperlong.h
> >> @@ -28,4 +28,6 @@
> >>  #define __BITS_PER_LONG_LONG 64
> >>  #endif
> >>  
> >> +#define __BITS_PER_U128 128
> > 
> > Do we need such a macro for a fixed-width type? Even if we do, I'm not
> > sure that a header named bitsperlong.h is a good place to host it.
> 
> __BITS_PER_U128 is being used anymore, will drop it.
> 
> > 
> >> +
> >>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
> >> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> >> index 3c2a101986a3..4d4b7b08003c 100644
> >> --- a/include/uapi/linux/bits.h
> >> +++ b/include/uapi/linux/bits.h
> >> @@ -12,4 +12,7 @@
> >>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> >>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> >>  
> >> +#define __GENMASK_U128(h, l) \
> >> +	((_BIT128((h) + 1)) - (_BIT128(l)))
> >> +
> >>  #endif /* _UAPI_LINUX_BITS_H */
> >> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> >> index a429381e7ca5..a0211136dfd8 100644
> >> --- a/include/uapi/linux/const.h
> >> +++ b/include/uapi/linux/const.h
> >> @@ -27,6 +27,7 @@
> >>  
> >>  #define _BITUL(x)	(_UL(1) << (x))
> >>  #define _BITULL(x)	(_ULL(1) << (x))
> >> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> > 
> > GENMASK() macros may be used in assembly code. This is not the case
> > for GENMASK_128 at this time, of course, but I think we'd introduce 
> > assembly glue at this point to simplify things in future. Can you
> > check the include/uapi/linux/const.h and add something like _U128()
> > in there?
> 
> 
> https://lore.kernel.org/lkml/20240724103142.165693-1-anshuman.khandual@arm.com/
> 
> We had _U128() in the previous version V1 but as Arnd explained earlier
> gcc silently truncates the constant passed into that helper. So _U128()
> cannot take a real large 128 bit constant as the input.
> 
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -16,14 +16,17 @@
>  #ifdef __ASSEMBLY__
>  #define _AC(X,Y)	X
>  #define _AT(T,X)	X
> +#define _AC128(X)	X
>  #else
>  #define __AC(X,Y)	(X##Y)
>  #define _AC(X,Y)	__AC(X,Y)
>  #define _AT(T,X)	((T)(X))
> +#define _AC128(X)	((unsigned __int128)(X))
>  #endif
>  
>  #define _UL(x)		(_AC(x, UL))
>  #define _ULL(x)		(_AC(x, ULL))
> +#define _U128(x)	(_AC128(x))
>  
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))
> 
> AFAICS unsigned __int128 based constants can only be formed via shifting
> and merging operations involving two distinct user provided 64 bit parts.
> Probably something like the following
> 
> #define _AC128(h, l)	(((unsigned __int128)h << 64) | (unsigned __int128)l)
> #define _U128(h, l)	(_AC128(h, l))
> 
> But then carving out h and l components for the required 128 bit constant
> needs to be done manually and for assembly the shifting operations has to
> be platform specific. Hence just wondering if it is worth adding the macro
> _U128().

OK then, I see. So, is that a GCC bug or intentional behavior? Anyways,
can you put a comment on top of GENMASK_U128 and BIT128 that they wouldn't
work in asm code and why?

Thanks,
Yury

