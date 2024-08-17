Return-Path: <linux-arch+bounces-6281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3222955833
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F117CB21A4B
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532314EC4E;
	Sat, 17 Aug 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDFIRZ2S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4A1474BC;
	Sat, 17 Aug 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903067; cv=none; b=BPv7Gn4FyBqddHubkL7EaFKrsPOtLCIPcQy+wK04rLfjR6UccEU7u+TPRBSIGUJcasXH1sq6+hhpxqe9xEqtF2EAxPbPeiKn3yOZnsiPC1LA9MeZoZMKGeYraSN7S7B0fxqVkqz7WWlw3ClLsU/b6bvGf/czYgaR143mEZd3e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903067; c=relaxed/simple;
	bh=B+dg8mEku4e9WU1YVPcK6sBwx30Oa/RLX/fhQkJ69Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myhZ8bRyZEOHF6nSB6ajPLdiNlaZiKVquEpDJVFRVkkSkklAalZF2bAVCVXioZHH6x/Nrzfumy3A3KX8Man4JgyRb6nxCUEhjrqbR0IJhQiWdgNnLztandDNqeb8Pa97uFpd7yERrZ9tszdlWJ4oitimgBFNtn25c1Tw+6Lw4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDFIRZ2S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b45d23a2daso6949227b3.3;
        Sat, 17 Aug 2024 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723903065; x=1724507865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9sE7j0E8FwLyVJZ3f0Dy0iecLRuL6/ufNZIU9u0uAW0=;
        b=BDFIRZ2S1iStwRGFJAuIgthF41QWTB4q5k8wFnoO4tyz4Hvo2KSFJoIUxmKxct6anO
         CMGym/dYdoU8sygDqkHaa8QIF5Qo36CMIXHs2p5+NbrThwCAJNX4SGWOkM8e9Q4dxlbw
         o7AH1MSbZlk3bNwrP0XwMN07fTHz1G5CtOF9f9NUkEvGMNIDroyIJlG7UJ6HYJ7qZJe5
         20PxGxdO5PqeQQm+h0DiPzEaE3nuwsxuX7y9ZPHBgU/bMGKGmzNqJikXZ0ixDZJ2CM1n
         VjfhdI8Ra7LNat0cQmhSia010w4+fcnt/FFfJctLnc5VbHoqKDCLfDBErlhrIFf51Pte
         lyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723903065; x=1724507865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sE7j0E8FwLyVJZ3f0Dy0iecLRuL6/ufNZIU9u0uAW0=;
        b=HSkbi9S3p15NTaW1nxA4Ty32TlxLWk0ZDDQUzETBsxo/OV9/q+ZzVn+siRaT45y11I
         VChzlvIlDW3i1J4vUblaCvctCief/owjbEbwOU/rqh8cHCNqcVSzQ41Pgh0SpNjwZ/aE
         ySgfrkE65kaxAR4p4i/7HNa8LpKmFM9MXiThGQtx0rwp7SMqKDVu6L16oeVHDrEDjDyH
         swrrwsmAEkm1DgASP+1Dg32HAjp/3DWK300GMMulKQTeLRpAvOJ2GxQ0GwI2AxzAV+gG
         IZDhmNI+7ghJkU8qqtbZQEypPcrtZDwkGNjHU/MvtcqKsX6p2elXvbm1DljRKzlAJeWS
         BYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjKdhHld2t4Wqkb0l9uKu1k/OlHED4WToLT2x1eTASj0FE3Q1aY71X283p2SpXmPtIuDrPnqZTJx+w2Q2t7wLEMTZ8gcC83QJYAQ==
X-Gm-Message-State: AOJu0Ywnyhje3eQ6Qt4EBNZlNImJ+fKexqpMyTcoGB+tWnyO7CCtUSRs
	VE/v+u9qeOoKu69mx1oExqLpSjVQVBS0+mZCI8CDuUbq6GA5rlJ1NEZy/uY0
X-Google-Smtp-Source: AGHT+IGf/gIor41ZqpJYORdhkNSlK+7hC6xTUzWPBPj5U9BjALQpn9R9onLFc8njqjM7dwr2DTSpRA==
X-Received: by 2002:a05:690c:c8c:b0:6ad:91df:8fad with SMTP id 00721157ae682-6b1bbe307fbmr72784837b3.26.1723903064615;
        Sat, 17 Aug 2024 06:57:44 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99506c9fsm9807987b3.29.2024.08.17.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 06:57:43 -0700 (PDT)
Date: Sat, 17 Aug 2024 06:57:42 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
Message-ID: <ZsCsVkkK-ElBf_dZ@yury-ThinkPad>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
 <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>

On Fri, Aug 16, 2024 at 11:58:04AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/1/24 12:46, Anshuman Khandual wrote:
> > This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
> > and __int128 data types. These macros will be used in providing support for
> > generating 128 bit masks.
> > 
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Arnd Bergmann <arnd@arndb.de>>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/bits.h       | 13 +++++++++++++
> >  include/uapi/linux/bits.h  |  3 +++
> >  include/uapi/linux/const.h | 15 +++++++++++++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 0eb24d21aac2..bf99feb5570e 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -36,4 +36,17 @@
> >  #define GENMASK_ULL(h, l) \
> >  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> >  
> > +/*
> > + * Missing asm support
> > + *
> > + * __GENMASK_U128() depends on _BIT128() which would not work
> > + * in the asm code, as it shifts an 'unsigned __init128' data
> > + * type instead of direct representation of 128 bit constants
> > + * such as long and unsigned long. The fundamental problem is
> > + * that a 128 bit constant will get silently truncated by the
> > + * gcc compiler.
> > + */
> > +#define GENMASK_U128(h, l) \
> > +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> > +
> >  #endif	/* __LINUX_BITS_H */
> > diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> > index 3c2a101986a3..4d4b7b08003c 100644
> > --- a/include/uapi/linux/bits.h
> > +++ b/include/uapi/linux/bits.h
> > @@ -12,4 +12,7 @@
> >          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> >           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> >  
> > +#define __GENMASK_U128(h, l) \
> > +	((_BIT128((h) + 1)) - (_BIT128(l)))
> > +
> >  #endif /* _UAPI_LINUX_BITS_H */
> > diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> > index a429381e7ca5..5be12e8f8f9c 100644
> > --- a/include/uapi/linux/const.h
> > +++ b/include/uapi/linux/const.h
> > @@ -28,6 +28,21 @@
> >  #define _BITUL(x)	(_UL(1) << (x))
> >  #define _BITULL(x)	(_ULL(1) << (x))
> >  
> > +/*
> > + * Missing asm support
> > + *
> > + * __BIT128() would not work in the asm code, as it shifts an
> > + * 'unsigned __init128' data type as direct representation of
> > + * 128 bit constants is not supported in the gcc compiler, as
> > + * they get silently truncated.
> > + *
> > + * TODO: Please revisit this implementation when gcc compiler
> > + * starts representing 128 bit constants directly like long
> > + * and unsigned long etc. Subsequently drop the comment for
> > + * GENMASK_U128() which would then start supporting asm code.
> > + */
> > +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> > +
> >  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
> >  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> >  
> 
> Hello Yuri/Arnd,
> 
> This proposed GENMASK_U128(h, l) warns during build when the higher end
> bit is 127 (which in itself is a valid input).
> 
> ./include/uapi/linux/const.h:45:44: warning: left shift count >= width of type [-Wshift-count-overflow]
>    45 | #define _BIT128(x) ((unsigned __int128)(1) << (x))
>       |                                            ^~
> ./include/asm-generic/bug.h:123:25: note: in definition of macro ‘WARN_ON’
>   123 |  int __ret_warn_on = !!(condition);    \
>       |                         ^~~~~~~~~
> ./include/uapi/linux/bits.h:16:4: note: in expansion of macro ‘_BIT128’
>    16 |  ((_BIT128((h) + 1)) - (_BIT128(l)))
>       |    ^~~~~~~
> ./include/linux/bits.h:51:31: note: in expansion of macro ‘__GENMASK_U128’
>    51 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>       |                               ^~~~~~~~~~~~~~
> 
> This is caused by ((unsigned __int128)(1) << (128)) which is generated
> via (h + 1) element in __GENMASK_U128().
> 
> #define _BIT128(x)	((unsigned __int128)(1) << (x))
> #define __GENMASK_U128(h, l) \
> 	((_BIT128((h) + 1)) - (_BIT128(l)))
> 
> Adding some extra tests in lib/test_bits.c exposes this build problem,
> although it does not fail these new tests.
> 
> [    1.719221]     # Subtest: bits-test
> [    1.719291]     # module: test_bits
> [    1.720522]     ok 1 genmask_test
> [    1.721570]     ok 2 genmask_ull_test
> [    1.722668]     ok 3 genmask_u128_test
> [    1.723760]     ok 4 genmask_input_check_test
> [    1.723909] # bits-test: pass:4 fail:0 skip:0 total:4
> [    1.724101] ok 1 bits-test
> 
> diff --git a/lib/test_bits.c b/lib/test_bits.c
> index d3d858b24e02..7a972edc7122 100644
> --- a/lib/test_bits.c
> +++ b/lib/test_bits.c
> @@ -49,6 +49,8 @@ static void genmask_u128_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
>         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
>         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
> +       KUNIT_EXPECT_EQ(test, 0x0000000000000003ULL, GENMASK_U128(127, 126) >> 126);
> +       KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(127, 127) >> 127);
> 
> The most significant bit in the generate mask can be added separately
> , thus voiding that extra shift. The following patch solves the build
> problem.
> 
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 4d4b7b08003c..4e50f635c6d9 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -13,6 +13,6 @@
>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>  
>  #define __GENMASK_U128(h, l) \
> -       ((_BIT128((h) + 1)) - (_BIT128(l)))
> +       (((_BIT128(h)) - (_BIT128(l))) | (_BIT128(h)))

Can you send v3 with the fix? I will drop this series from bitmap-for-next
meanwhile.

Can you also extend the test for more? I'd like to check for example
the (127, 0) range. Also, can you please check both HI and LO parts 
the mask?

For the v3, please share the link to the following series that
actually uses new API.

Thanks,
Yury

