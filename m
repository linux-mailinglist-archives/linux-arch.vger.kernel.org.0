Return-Path: <linux-arch+bounces-9963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97982A25450
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585AE3A98A1
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2A1FAC3E;
	Mon,  3 Feb 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2ZD/gxDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgTrZQg2"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F51FAC50;
	Mon,  3 Feb 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570736; cv=none; b=mYyjCnypxBlC170IY/CWdjFN1WjnTrJ/cbaWVItMCWLDZRwGmcDV09ummf5Qh+6rtsmJPU6eqaLCqJ4+7kMvTK7Ra6zyKSJDtoX8W2GDTkT3UWGIG4xmakzgWhawFLx/mfKT7wAYp4gIXGodutH9zoj9BXfX+wQIHFmPO66pG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570736; c=relaxed/simple;
	bh=50YAk0L0Q6yUtJ/22k5/0sx7XppJX7q/VbO4MlWl0kw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sWlHtqvOAps/wheCZtm1cyx2pJ+LaPjHUMMr5w/sfbovB7MtkgYo//Jkz1gCPOXDeURsypXzBH7TJU0OIy7uf7nwgt93ifUYdUYeWg1n6lshR0eVq1OsO5mKuEugq5odPyCVmyLyI87mBUW3ZKut1ZrWJwrzbgG9H0mvq/WoaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2ZD/gxDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgTrZQg2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5E2411400DB;
	Mon,  3 Feb 2025 03:18:53 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 03:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738570733;
	 x=1738657133; bh=FKdwgdQes6gNQQrLDoRfBEkdAHgeHZ2aOkctxwHArZs=; b=
	2ZD/gxDYIT1tOo64wcQeqhFxay/eEyLkb60iou8pSaO8v6ZqBxacwiYO+Ze24wyz
	GvUpqNIAy5uCN3aRLlfyUZeYpteapdIAEgIrmxYSJFs8dYWO/5hoeueWXxGz1glh
	lCx+91slc1W0C9nhpDxnNFKWzdK1vVqNRsCRlnNqEHjDrJLgD23u+WCs0PG87GrN
	ptkl0nwEZn9dYjmtwhHjMUN3AFtRP3ZR4yk15txV3gDNhveBeVgQaTIVy98XCE1z
	E0L3Vh///BTzpOpcHL3C3gkp800wAN5BnVkYjmNpAbHO1xQXXbbpvmSQjV8nC9c1
	nz+YMrDlEpgubb21Ri/a/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738570733; x=
	1738657133; bh=FKdwgdQes6gNQQrLDoRfBEkdAHgeHZ2aOkctxwHArZs=; b=Y
	gTrZQg2NZ8uFsNPmtM7f9YrEqkO/ldIoq8IivNkRGT0rxkyCUoeTo/hwPh31NWYG
	Ko6tPFVjt9cVVHlXUY5sWSJ8jzE9U9sc5ejhThrvEO66sOzc1oySl1sA/GKSf94i
	yRbYND+9jz0vRW9VEilRcQNioszYdESJuYrmcPqZvJ4/RlXrdKoAiRd887Nytuje
	0edQ5OyF8NApGTZ6otRdQGcx7T2BcOYliv8O/JeIZ11zR6UxipGQv/zijwD4F1bd
	yZmODpG4a67QWwBRWTfD3iiWHw2VhUFfkxGAfJHocqCWHl54YxomqpO8s56sqvTw
	HDkWvFaw8a6oHv/EGzUGA==
X-ME-Sender: <xms:7XugZ82DefEdJtQRO7iYN9QI_s1WEP8NO4qUxnkYx7-Wn8EyOcE2Bw>
    <xme:7XugZ3FoGYwd6W3C-nEWFufyHO7wV0W-RXNSUiWzzKsQtNBQEf4YxOoVyNdGqGSIi
    bwGucx23wQzxY0Zqxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrd
    horhhgpdhrtghpthhtohepphgrlhhmvghrsehrihhvohhsihhntgdrtghomhdprhgtphht
    thhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7XugZ05WM7heS1RCUCMQUV4HlkOe1HvCNEk_gx6MY9P9j2ICLP44yQ>
    <xmx:7XugZ10_MQa89zXD94j5-O3odwolnKutwjgV3U12iVt_JDIoJswEDw>
    <xmx:7XugZ_FM5S1hl7GfvN-cwqqrgpIrHtnywn55PbSQB56VcnnUoX9Iyw>
    <xmx:7XugZ-_k1PqMf47wrfcfLEigYVJQ_bZvlzm1kz_rRbAQYT6ubnuprw>
    <xmx:7XugZwMi2GBWG_DQlFaKJdKMeCX6MIaymEohi7jIqtOW9xXSFVTW9ZYO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6996A2220072; Mon,  3 Feb 2025 03:18:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 09:18:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Kees Cook" <kees@kernel.org>, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
In-Reply-To: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025, at 08:26, Thomas Wei=C3=9Fschuh wrote:
> Building lib/iomap.o on UM triggers warnings about missing prototypes.
> These prototypes should be defined by asm-generic/iomap.h, depending on
> other symbols. For example "ioread64_lo_hi" is based on "readq".
> However the generic variants of those tested symbols are defined in
> asm-generic/io.h, only after asm-generic/iomap.h has already been
> included, breaking the ifdef logic.

Sorry I never took the time to fix this so far.

> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -13,10 +13,6 @@
>  #include <linux/types.h>
>  #include <linux/instruction_pointer.h>
>=20
> -#ifdef CONFIG_GENERIC_IOMAP
> -#include <asm-generic/iomap.h>
> -#endif
> -
>  #include <asm/mmiowb.h>
>  #include <asm-generic/pci_iomap.h>
>=20
> @@ -1250,4 +1246,8 @@ extern int devmem_is_allowed(unsigned long pfn);
>=20
>  #endif /* __KERNEL__ */
>=20
> +#ifdef CONFIG_GENERIC_IOMAP
> +#include <asm-generic/iomap.h>
> +#endif
> +
>  #endif /* __ASM_GENERIC_IO_H */

I have not tried it yet, but I suspect this is not the correct
fix here. Unfortunately the indirect header inclusions in this
file are way too complicated with corner cases in various
architectures. How much testing have you given your patch
across other targets? I think the last time we tried to address
it, we broke mips or parisc.

    Arnd

