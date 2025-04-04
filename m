Return-Path: <linux-arch+bounces-11274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB6A7B779
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 07:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB8189CE00
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB816CD33;
	Fri,  4 Apr 2025 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cREzHxhO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7DHAjdH"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5D15B54A;
	Fri,  4 Apr 2025 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745800; cv=none; b=GC6U9EKjxYDrlKAXit3kgVvdh48rbc2MJ6qpxyTK1BBJ84yLGfzikaZyXQc1gb09LXWCwYmDLCjT9c7pk2cY00+Yxiqr+99Fi9GZkuJ5FkmiHCB7KhtRsPu05Hy1VeiJDG59IM3GJ7VnGxkl6Lr6YaeU2expL2ASCuaH0QOT3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745800; c=relaxed/simple;
	bh=qkTHqjl83pLG/+D8Skug3u0Mx3mxlwN9CoNV7VolM9o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gT0iOtfgyzgG7mMXjp3y4N9OoWIGMUGfC+hMwbfk3FasvMb6HoYjdLJOm4wzngc/3fONjwMzwQiV4FVyUURj4pabw/tvyrKgFEhyGnAaFtE/ac9cFErqOz0bESlNYtr3PRTLL9z0qz3n6U1RL8PpdNN26RO+3tgAWOBHiks1GJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cREzHxhO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7DHAjdH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C69A92540208;
	Fri,  4 Apr 2025 01:49:57 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Fri, 04 Apr 2025 01:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743745797;
	 x=1743832197; bh=jiFFNkuCIH7ZG6pqQ+AbUtFKAmY8bCOOF0MhNJ0ccxk=; b=
	cREzHxhOLd5iw3lJUyZ1sf6YboO163DBvMqtwijXmO4lmnoacGSPuqlMob1TnYmM
	EjMU6X5YAW9aQ09Ah2mT9mvvdhkJPLq2q1Epz/rj4KohQRcsos0TpLmYsKT063qj
	YCrBgtjRvsQS9EHMV593u2riSDxRbjysuPrD0upNA2LO9ZBPd0uYjX4qWnBfMnj6
	eu4xEov0C9k2TMhXbj46vp7mTXuPhAqrNCmS4jehSScUEgAO+fd2I+dtPLSA3cEI
	dZv0NMCuro4DOLn82nGXZZ6UoimbIs0iO1lq19nJDr4CRH2SMm2c3KToCAG2mJNe
	yJhd6VIW0bG/WAH+xyk17Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743745797; x=1743832197; bh=j
	iFFNkuCIH7ZG6pqQ+AbUtFKAmY8bCOOF0MhNJ0ccxk=; b=c7DHAjdHlCs3c171T
	FgJDkeEPXP0aJlvKNt8vzX9KU3eVOmGbYhugcn0TPh3sqJfoiPvKiM4cswWhVz9F
	PVV3Pn6FXGW6G9yvMnAuOnFJo7zrWRZcmKIJ/hFrVTLIX3MF8ggWKsDHCyt3M+EV
	ac/YXaLhY/qZ3YIg1g4F3Uxt0tq2B3s518lxj0R6UY4FiJ7vSrcedi1NA4B6weBn
	p6ZMa2R91kNFoMnlHmuQB9an+1+jUZRwCtCiaKcmdkUWN4YvyBQMyynilQrvjnLB
	cz+guR4Xl3iGnOjGgH79kEWrBj0O3wlfqH4Omy1OvFUtErMAWd7Et+xy8QMIpYmy
	7TSLg==
X-ME-Sender: <xms:BXPvZ9nrG31ueBFogNnTDWcbR6J8RNsw7X0OLEV-lSFzqvjM0g5ppw>
    <xme:BXPvZ419yjwzmgHqGnMFn1DOo1fy9CHJKqMNehqhAeUnkhUfmvBupKUXdYkuQtddS
    TFjohemrgGunKQjvGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnih
    gvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnh
    drhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgrtghosgdrvgdrkhgv
    lhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BXPvZzp7YMrawrFKcXI2LMRtjebMbG3rtCjrP35MqaiZsxrBppNatQ>
    <xmx:BXPvZ9n_JQQFZg8tVnlWAofPSEpckD26vuBabjRQayQDt-6RUDbbVQ>
    <xmx:BXPvZ72pWi6ev2M6fgLT9fI2b7yhZg7icuL5NQ3qnBlNfBnAN1TfYg>
    <xmx:BXPvZ8uvPBJ21iyQrb4G_4yFxp6KdiitPQ4TQfx-YgFk-UgQU0zM4Q>
    <xmx:BXPvZzruerDU4_YF2_WRKMkMbfqdBC8fp3mIjafEbcgtGLzAcKxjwi0Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17A782220073; Fri,  4 Apr 2025 01:49:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbabee1c6d5c86beb
Date: Fri, 04 Apr 2025 07:49:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ian Rogers" <irogers@google.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jacob Keller" <jacob.e.keller@intel.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <dbba94f1-27ee-4344-b4b2-d8dffe6b7d33@app.fastmail.com>
In-Reply-To: <20250403165702.396388-3-irogers@google.com>
References: <20250403165702.396388-1-irogers@google.com>
 <20250403165702.396388-3-irogers@google.com>
Subject: Re: [PATCH v1 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 3, 2025, at 18:56, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit.


>  unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
> -		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> +		return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
>  	return __bitmap_weight(src, nbits);
>  }

I don't understand this one. hweight_long() and bitmap_weight()
both return unsigned value, so why do you need to cast this to
a signed value to avoid a signedness problem?

hweight_long() should never return anything larger than 64ul
anyway, which is way outside of the range where it would get
sign-extended.

A more logical change to me would be to make hweight_long()
and bitmap_weight() have the same return type, either
'unsigned long' or 'unsigned int'.

      Arnd

