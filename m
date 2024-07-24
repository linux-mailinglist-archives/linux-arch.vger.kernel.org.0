Return-Path: <linux-arch+bounces-5609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADB93AFF5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548CD1F22BCC
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BA715574E;
	Wed, 24 Jul 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="s6hxvRIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+ey1eWF"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322A5695;
	Wed, 24 Jul 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817980; cv=none; b=aIt1jwSIAG7cH+cKsnDY+J4UR4gR4Q9H6uveGb7G5ZXH1JFwKDeh27miRjhbRqohAU/Lp+oQApVoNUTs4JZ39hrhvaf6CYz5jf8YuaqcJX22G/Vl2+Np5zE9K6O3kDs2HCK+OqBplTI0Ir1zNdTRlvjIjwXeSUgZd1tKKLq4cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817980; c=relaxed/simple;
	bh=GXlmAKy0jMMHs8gtxnXJjGAILkTf99lkHKIFHd/fjQg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qcOOeQU+EEn4oKMIKYOH2Elqe/+VaCJXIxoXehLt9oSo0KmJ84lu+g6QwL4xpL9DwuBkbQ6QbYCEFiokPT2UZZpAcqhtcx42wXBuag7CxEkpncyxR27BzWLkYXisTCpR4QJ3qACIjOqq33VWsrSkhvLvD+U2FJLbHy7Myluh7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=s6hxvRIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+ey1eWF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ECF1511402EF;
	Wed, 24 Jul 2024 06:46:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 06:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721817976; x=1721904376; bh=8RDW4na2ac
	f1fEAvf5OQSQZ8CPgdR+2LrNzIIFbWMWc=; b=s6hxvRIXDc97naQPH8/GRtv08U
	gTFt+DIp8A4aNVLBFb2QzSIOXjmG9HW0b1XWXxiwDptxn/mnEFoAihchblRA5TRF
	ilDmUmJ45dU/zYbFERt1QoTdXqBAS09TCdn5ZPUmd9cPG0L2baddfwRYMa0S89Ut
	4Xvl1OBCht12+IDINgbpLflO1k1fXymlB+qPkk3SrfWCbpdxv2Jle32Lx5UHxsLk
	VzVpqsAwgFymEuKDVUqIgOL/TRPOAVPHQC8VKgZswQ5w6DkeSnEQlx4fFKZhcdZ9
	t8yqb+SdX10WkMqQ2MXAHch98k7Bkx9CKCwt3tQCfCAvflKZyUwZTMZJazAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721817976; x=1721904376; bh=8RDW4na2acf1fEAvf5OQSQZ8CPgd
	R+2LrNzIIFbWMWc=; b=G+ey1eWFH56VE0jYYrB4EvqSpBJU87TsMEtlQmVV1MtS
	Awob3WEa2lUqSa4OD40P8RNR7ih8C+hG7/FLIT0G7jgWrb0AivNHtdX71swSRRBf
	1iZeL9aLd1mOxSapQWdmCJf2m/pxXgG5+7UF30iZUXbIhJp4IxyHQkbG5xE8G5X0
	yE/MHEl1rfh13p6UD9DqRhreyVWzApT5f6ipM72YAHjFn0onq3BRAI51HK5j71uJ
	IN/Rb/RYzKdajr1atZ2eUAYRuLt+2LO7+wLcN1B6Tn3UJgO8fkSygKe8VMLdhnND
	gI1Ql/HSlTFJ1VaId9OtTC9K6/48pLuytCyRAz7MBQ==
X-ME-Sender: <xms:eNugZu6V-qZjD_i50s-g1Cj1FwgN1S5Nftcw3NUedxTYsTtNb4Vjgw>
    <xme:eNugZn7Gwx4iRzDxKGk02RZom2-adgaDy56VyZDLIOmAIY0c37Z8SlrMP2ZeyoqDs
    kmcMQfQJsjuEfgHt0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:eNugZtcPOTVN8a9TN31eR1LyFWReZIh8MUtDjTpMgpPVfqhSBGJVuQ>
    <xmx:eNugZrJUnj4b4Cr4lcCmuBk_nPqwc5nE-LTt6Y2y6eymjOBD8wqI2g>
    <xmx:eNugZiLA3ZXY0rUGjS75ecZNEy0hHUoxKoYkKQFMWuRdg1Akuq60VA>
    <xmx:eNugZsz2RyajP3HywBwDHatTi_LfOiVl3Obia-9vr6BsffQIyRvHCQ>
    <xmx:eNugZkhHphH-S_L2Nosm1_cS4bvjmAwsusP-oceCQOyaoptTaQuwK1o4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A66E5B6008D; Wed, 24 Jul 2024 06:46:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83972212-c8b6-4888-8574-4eb153008109@app.fastmail.com>
In-Reply-To: <20240724103142.165693-3-anshuman.khandual@arm.com>
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
 <20240724103142.165693-3-anshuman.khandual@arm.com>
Date: Wed, 24 Jul 2024 12:45:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/2] lib/test_bits.c: Add tests for GENMASK_U128()
Content-Type: text/plain

On Wed, Jul 24, 2024, at 12:31, Anshuman Khandual wrote:
> This adds GENMASK_U128() tests although currently only 64 bit wide masks
> are being tested.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  lib/test_bits.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/lib/test_bits.c b/lib/test_bits.c
> index 01313980f175..2515ddc34409 100644
> --- a/lib/test_bits.c
> +++ b/lib/test_bits.c
> @@ -39,6 +39,24 @@ static void genmask_ull_test(struct kunit *test)
>  #endif
>  }
> 
> +static void genmask_u128_test(struct kunit *test)
> +{
> +	/* Tests mask generation only when the mask width is within 64 bits */
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
> +	KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));

This looks like it would need an #ifdef check for either
__SIZEOF_INT128__ or CONFIG_ARCH_SUPPORTS_INT128, otherwise
it will fail to build on all 32-bit architectures and possibly
old compiler versions on some 64-bit ones. I think I checked
in the past which targets support __u128, but I don't remember
the result.

    Arnd

