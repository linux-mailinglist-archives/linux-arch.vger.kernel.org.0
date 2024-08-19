Return-Path: <linux-arch+bounces-6317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2ED956432
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 09:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E337B2241D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778615748F;
	Mon, 19 Aug 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jUWg3ftF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYoyqUYc"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA3156C65;
	Mon, 19 Aug 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051626; cv=none; b=GDTaRHgQ2s269FwcCU5CqKTFms378DB/pOqlBiXkILADQJRfEhZYs0dqDXcO7WKwMvBmZzloNFVLh0yoeFmtB+TGaXmi0rrUPsUCF5q9MkGf8RmkbyInf3Qx+hhiX3bukhYhiXJODrQlgKYa4OD1Vswi/TSmu4hWyc41lY8VG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051626; c=relaxed/simple;
	bh=+uyVveA05i+0z9RqiARBKsUQTWytXmBTj23JiyhLifc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F20PRWiA/1UShe9ijSuTSGS3YcLC+dCmi317wiEnI99Qwxzj2c7X6faDiOPuFlvA4DU6fUdhsjY960aqUrZwoPHgEm8FRSqYPGQOCKnkkmA26F37bUd3W7uSlmlu+MSdNTWDc84DTq3S/1GxmlKBQthrdwW6iJ+ZuiiLNN+qt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jUWg3ftF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYoyqUYc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B9A1F114AB0C;
	Mon, 19 Aug 2024 03:13:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 03:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724051622;
	 x=1724138022; bh=/AyYONc647/SgUmFrxZcnoWv2j0dTReNKV8vQzoChbc=; b=
	jUWg3ftF1YSQF0BsQx4GdBfXMCG5hYnFr6QCEsUPOY2kpptsz8kAX185nL9axqHi
	5rqiFd4XDSbPcj9q6TraI6YfOlkJI8YKhwdoF7FFZ2KJQ5Dy0u+TIzqxGOyrz5SA
	4FQc+TACqXEiZd4HNIPzHMvDzgK2GhSanBfwn9o7cADgNtpZUtR20gDzSgdrmmKF
	Fq2YFaSTqEdxr9Fh453kPm1k0P1+wf1FF1DT7RHAzZXZ0S+K5oMCnTF6AR5GgnHZ
	YDWgPZiaVTYyQuk+/sy16a5uis/9ojDjTKRtsSCwqMecWPbhG8Q7OqWvDd+NZ/xQ
	zGDio0U8WP9ApabMg3Qg0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724051622; x=
	1724138022; bh=/AyYONc647/SgUmFrxZcnoWv2j0dTReNKV8vQzoChbc=; b=G
	YoyqUYcJMNdgy/GMlrH4Pb5w+c2ZKBvdOrL/rPNdCxNqpAWA4a/UU2frnulOnVcM
	+rF9x7VioTP/znsprPnq6Dgs8KLKUWaiKvrBMtbLG/bAJ+FJyQiE6qBuF13I7Vnp
	13JzIUbi9IyzbncMFXajo9/6NjqIYK4VaventJpGBgr1G7bc9EgD56LMT748/pxw
	rjFwK9NZFvXAM+UKWj/dCC9m7vQLcjxkXMRvX+ZVtd1zHj/YFfHFMUFjl+/uUGA9
	ggcGNPImafFlOUYBLD944JsxIvgNQmTEob3TunfZ7sUXoY5Lu2CWmjgNTCLAmELI
	WAiaLOKzIApjrhNpT8/pA==
X-ME-Sender: <xms:pvDCZmFLIFc2c9QGi3NSd5Axa7HkCjkBLI5QSlm51H3HPQHvCZ7Kwg>
    <xme:pvDCZnVa2_8Vc4mauW7RP-g0C-uyXdVoJUqy7TTYUrkv0IPSBuoVOUsVXaKt2J95a
    E47GrfTyTz-avrOe_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhshhhumhgrnhdrkhhhrghnug
    hurghlsegrrhhmrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhi
    nhhugiesrhgrshhmuhhsvhhilhhlvghmohgvshdrughkpdhrtghpthhtoheplhhinhhugi
    dqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pvDCZgL65tQK4uFa1m8vw5JgrS7BxiQRyFMZvq2Lw8I_PBpFQkNSuQ>
    <xmx:pvDCZgGrsaWlxQeUqExGZk_Jycvlw8wE1oaknEfGBqZXck7T_2eQrA>
    <xmx:pvDCZsV5eOsspMpSfCTqM9wXb3r7bASi3mqiPm9QaHQxSewey30IiQ>
    <xmx:pvDCZjNzNRg-SW_FLzQ57kjjvEwHZuj7lUrAwZuAg9UMRtPlmF59Tg>
    <xmx:pvDCZuJKK5N6HhoyYcba9eJ-ahQ2Nw441V1vUtLM_sDaTh3uy28_CAjF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2E57516005E; Mon, 19 Aug 2024 03:13:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 09:13:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anshuman Khandual" <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <3b219e52-1d2a-4e6d-adff-efbab3e2282d@app.fastmail.com>
In-Reply-To: <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
 <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 16, 2024, at 08:28, Anshuman Khandual wrote:
>
> This is caused by ((unsigned __int128)(1) << (128)) which is generated
> via (h + 1) element in __GENMASK_U128().
>
> #define _BIT128(x)	((unsigned __int128)(1) << (x))
> #define __GENMASK_U128(h, l) \
> 	((_BIT128((h) + 1)) - (_BIT128(l)))

Right, makes sense.

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

This could probably use a comment then, as it's less intuitive.

Another solution might be to use a double shift, as in

#define __GENMASK_U128(h, l) \
       ((_BIT128((h)) << 1) - (_BIT128(l)))

but I have not checked if this is correct for all inputs
or if it avoids the warning. Your version looks fine to
me otherwise.

    Arnd

