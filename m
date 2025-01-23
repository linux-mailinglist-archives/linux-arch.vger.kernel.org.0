Return-Path: <linux-arch+bounces-9866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF2A19F0A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 08:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E31E7A4386
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241A20B7ED;
	Thu, 23 Jan 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YWlIN4sc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lO07YF69"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991112010E1;
	Thu, 23 Jan 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617649; cv=none; b=JI30i1UpGppVIdM7MhfN1IKzsd06zZw0gJyLWTarr1ee8X0lXBvafdZ0vw0vSTNrJMf6bpawCqNT9Jm7TEFXGeTvOt1uyl2kRdG1t1/7mE3exDer2sJv74mPCqOelmbg7LIlBQpNYB7/lQPUulIPCmmJLRtHlr3ii4FhS6bNXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617649; c=relaxed/simple;
	bh=hgdBbTi6iC59E/Q39IqIOh81d9VnLRM9a40Ky10vnX0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hoMnEBe9ekkPmhd1vNp8Vsqrp0FQYGitIndsiRr7xrj2BLLImEpUeXgd/YW3XFa1/e2ALy/DznJ7/0FA5ZAjF3Rk/QgbtphOSpMeMvZwEk2xSQrajiI7EZY0XoPTRoEPSNiNQjjjAtzYHowMLNIKY3MYcjKhrx5m3F8S1+Sgdhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YWlIN4sc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lO07YF69; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 330AD1140136;
	Thu, 23 Jan 2025 02:34:06 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 23 Jan 2025 02:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737617646;
	 x=1737704046; bh=I5I1QNV++9Jk9n7Ca9xgDhJ5Nhz5AgwhkTf5BK5VZIM=; b=
	YWlIN4scupYNojGrYp+tH1XkJJWcJylqER0woXB+c4QJQA82zZZsVYAC+zGyMAu0
	ql87uRo5eLyv06B1AnUSdWmj9uJex37VuzbtaoxbeK/CCd4vPXECjFMCci161zVF
	bsl8a0XSWWSXAt6/fu6CcMtdQlUU/Wnft2ldGpK1lA3XmbzrYYJ/AgtdbabwBCpm
	U0MJiI3bUpUvGXoj5Lvf5Opg+Q0ZhfCVi+i/UszD2tIkaohcwiAh/g8Rcu9X2goL
	v4BA5uEWCcyESgf6wWNmV3JbZV4K48eGVS2lYVgSozdJLlBS50lWByllhNFh3k0e
	trpiBVETjYagJC4JYTS8yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737617646; x=
	1737704046; bh=I5I1QNV++9Jk9n7Ca9xgDhJ5Nhz5AgwhkTf5BK5VZIM=; b=l
	O07YF69aL5hFdsuDVmvmZPFX5TKieFueS13Qvjbnap6ZndF3RCWUU1k24+t1iAaM
	J+xrn6HpGhpgFD58N9Vnkc8Bxu7aDtL69XTgAudKrqqhxDaZLij+T4yTb5Re6Kom
	y79iYdxPoWfsFQch4QifaMIb2WluPVVCoQsQWObeGtmFCjVM39trUptuobNAdeLE
	upkjYgi7bHvrc5hD2Rcg+tv5StmF8lK9k6s9GbfFTVeNHf60j8jzAzmGIqLS3emM
	eIzx9wTrI8G+MfSL2VS3jgt+t2vquhfvrUY0up3Uwt5Qv7xaJ4mUkqs1qyZAZRqC
	KVBdA8ySLxFGSU+/7O6Kw==
X-ME-Sender: <xms:7fCRZ_Cvwzn-QoNnn1U4O71uBbjxIDzskHE0XnHJBkHNr726pIlNDQ>
    <xme:7fCRZ1ilmQFP29GNX4M9sd295IfJnSBjQjHL3EpugLhPu5up602vqd33gxmaaI8Id
    rM4WCTnjOOObU1hNHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeegfeehueejheegjefhheetudduueeltdeugeei
    gfeiheelleefueeggeevtdelkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsoh
    hurhgtvgifrghrvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduge
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhvg
    hnhhgrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepgihurhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrh
    hnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7fCRZ6nOeG0grD9rN4ehFDMptXg5HQg-ytLUY5MoZVM-IBYXmsx6jQ>
    <xmx:7fCRZxxAy3ypYpbS_oSCBD4UCklI32DH4deoTpfjI-OlBS4V2zVTHA>
    <xmx:7fCRZ0Q4N1yTw07KPgK229c-QNnkeT-UKSZM7BcvhX7Q8gAMKli_CA>
    <xmx:7fCRZ0appjcd40YUqaqC_MPBFZHV0KZ4U2pIARWcWuyp3w7UiM0dww>
    <xmx:7vCRZ2AUaEvF2mQhBfPCUK15JLsW3jXBrJMHEr8HsQ0lLmm4e_lTfhVL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC9222220073; Thu, 23 Jan 2025 02:34:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2025 08:33:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam James" <sam@gentoo.org>, "Rong Xu" <xur@google.com>,
 "Michael Matz" <matz@suse.de>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Jann Horn" <jannh@google.com>, "Kees Cook" <kees@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, regressions@lists.linux.dev,
 "Han Shen" <shenhan@google.com>
Message-Id: <1ee17220-79ab-4449-a993-21789b80d95f@app.fastmail.com>
In-Reply-To: <87frlaxuwo.fsf@gentoo.org>
References: <87frlaxuwo.fsf@gentoo.org>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 23, 2025, at 00:59, Sam James wrote:
> Can you file a binutils bug please with that reproducer and the bisect
> result? Something smaller would be nice but isn't required (at least for
> an initial report).
>
> (CC'd matz, full thread at 
> https://lore.kernel.org/linux-kbuild/20250120212839.1675696-1-arnd@kernel.org/).

I sent a report now, https://sourceware.org/bugzilla/show_bug.cgi?id=32584

     Arnd

