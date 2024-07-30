Return-Path: <linux-arch+bounces-5732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C0941F71
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 20:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583BB284A4E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917918A6A9;
	Tue, 30 Jul 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNGnDsgZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531F18A6C4;
	Tue, 30 Jul 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363640; cv=none; b=hoKF6kLlShp4KUhYlcPqtTJAqrm7smM6REu1M0R4BhTPZQXq/mkmZzXXS71W+kydGQ0zpQZvOOOudnmb5XO3eAhA08dkeL9WPEpnVaoEXT+xGg4iKW4xsnJZYoRbkFyYOPD6279dY7S/2ohfelZqmI2DDU26vDGfpNBu9d/UuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363640; c=relaxed/simple;
	bh=G8sVbBwZJnyPhfnH8dBskagamVDv8p4AWzth221C2Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFW1cLQ2Czdo9JWyN/ir4+Eqmqps0vh0Ql89GbXjyXd5Ixd4ATLzh2h2O8evjmNCeHM7GS96nJauL6pEdFL6sXpMuHVOUCxnV9cq4a7QuWG2B+9q1nNj/cup+3HHFAnFVYXcsxTv+vE7Dlb6fpKKdujCfi4LEQYY1GE78i/9a1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNGnDsgZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3326983b3a.1;
        Tue, 30 Jul 2024 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722363638; x=1722968438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evmrDuWTpAztCWJC+WfQy/HIbwzxhxVcOsF3DausHNg=;
        b=lNGnDsgZsfEbonMGadxCBfW17O28uSK50S1eQJYImCWSyDIiZ1E4+VqVkrVXFKFS6X
         34JNrKrn8BNWsQmVRigDC8Z+AG0X5XVeHTkJFWtcXwqURLdvXhGCYdq51wrhMaEFFlU2
         Lkv6sWdI9VL26Rd9FVPPYe+Uq//rhE0TeBoc0CrpINAbrX7RJNa6sHAOin/94UNPxZ9i
         gp4zeC1vrTXoR4lMPr3vXRVlgAPoLcYRmxEP6fgA1buF9tAqSOSCMgNoEeWi4wEHz8yC
         8i3rwlSr7UewWmV2cVebj/Af/4wBUfti84NpGChKGJgDvjO48cuth+1aCybw/NXFBJmm
         DQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363638; x=1722968438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evmrDuWTpAztCWJC+WfQy/HIbwzxhxVcOsF3DausHNg=;
        b=mBooUsoLYKf7W7W+zqsNGLQ+YZiwnAX8OJI+LuLR2eVRB4+BesH/l3Dy8D/Q0ugfPk
         uCZj5s5yeSv5tiDe6qmUo/PBX1TpEsh3a0i2G5IilcyHmZJi6cc+mUPlcNbC7nEsGTQb
         b3ONL/Xc3MiF2qdTOPpdMMAO/w+74VpUPV/x1n6ltwWdaLRRsdjIoePYViBpXfxG1K6T
         ZWeJZ7vkw3Tl/ARHXf2ABe61gS9wI9BEP1Xw0v6TLQZfEUEPPWfxLncDvya/lC/yRBAm
         HFE4yZhghtaVxPhYL2hUldXmPbUfF/Ttpf3Lst/Cz2UvHOcXo5V1cxzpraJwpzQ8TmDX
         VOXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ05JClB9OYmBDQDDQEJjjarzRA+A6z8vAGs+TIZiUqUNDDm43Li2OydK/8XN3c2SxJEOgsD4H39NQLQL7oUTwbpkXheyQarWFrw==
X-Gm-Message-State: AOJu0YzOQOkRN2b3nPViDD+aKZXrxfl/hV2mcr/DAr3Ncj9APp6Xduji
	acf6onRlZRnv1vOjH8Ma62QAI6/9xecdfM2vFLM76ceCHWJO6oKh
X-Google-Smtp-Source: AGHT+IGceJ76vBCda+Ox4UC6J6EQeEM+C24t3cQicUirSbaFgBk6NqiUYBUJOc9w3qL6fVvgKLL0CQ==
X-Received: by 2002:a05:6a21:3284:b0:1c0:e728:a99e with SMTP id adf61e73a8af0-1c4a12e31aamr16928307637.26.1722363637952;
        Tue, 30 Jul 2024 11:20:37 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72bd7csm8983783b3a.95.2024.07.30.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:20:37 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:20:35 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V2 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Message-ID: <Zqku82z-y2fjtIZT@yury-ThinkPad>
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-3-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725054808.286708-3-anshuman.khandual@arm.com>

On Thu, Jul 25, 2024 at 11:18:08AM +0530, Anshuman Khandual wrote:
> This adds GENMASK_U128() tests although currently only 64 bit wide masks
> are being tested.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  lib/test_bits.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/lib/test_bits.c b/lib/test_bits.c
> index 01313980f175..f0d1033cf3c9 100644
> --- a/lib/test_bits.c
> +++ b/lib/test_bits.c
> @@ -39,6 +39,26 @@ static void genmask_ull_test(struct kunit *test)
>  #endif
>  }
>  
> +#ifdef CONFIG_ARCH_SUPPORTS_INT128

Can you move this ifdefery inside the function scope, so that you'll
not have do it below in tests array declarattion?

> +static void genmask_u128_test(struct kunit *test)
> +{
> +	/* Tests mask generation only when the mask width is within 64 bits */
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
> +	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
> +	KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
> +
> +#ifdef TEST_GENMASK_FAILURES
> +	/* these should fail compilation */
> +	GENMASK_U128(0, 1);
> +	GENMASK_U128(0, 10);
> +	GENMASK_U128(9, 10);
> +#endif
> +}
> +#endif
> +
>  static void genmask_input_check_test(struct kunit *test)
>  {
>  	unsigned int x, y;
> @@ -56,12 +76,17 @@ static void genmask_input_check_test(struct kunit *test)
>  	/* Valid input */
>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
>  	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(100, 80));
> +	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(110, 65));
>  }
>  
>  
>  static struct kunit_case bits_test_cases[] = {
>  	KUNIT_CASE(genmask_test),
>  	KUNIT_CASE(genmask_ull_test),
> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
> +	KUNIT_CASE(genmask_u128_test),
> +#endif
>  	KUNIT_CASE(genmask_input_check_test),
>  	{}
>  };
> -- 
> 2.30.2

