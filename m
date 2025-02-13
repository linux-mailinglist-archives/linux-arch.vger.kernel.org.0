Return-Path: <linux-arch+bounces-10141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C5A33EF0
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6165E3A9420
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023A221569;
	Thu, 13 Feb 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gj50goYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KGIXqOEX"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C8227EB4;
	Thu, 13 Feb 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449029; cv=none; b=EhgSIJIkqlxN1V++c5J7HVVLeymcm4wleVG63U65TddQJ0w+A52deI/8he7OVoKbhqzq4xOxZalNKhJ8ZSHhBaSuJVX7YT9jPpzZQ+QWlZSPKhY5Zb+yNptZoDm2Qyzy3trT0ryR3UAB7PCOt+cXhzOYVWRcQsSWtrHMGhCclz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449029; c=relaxed/simple;
	bh=vlhlBzSkIneMGWYQBwFyfnTl25nGWzLsKGHhhsEs/qs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E6jJV1M3iln5CXusHDIk+9L9WvHDN5ygQXtdHzwl0W3wVM+WYTLyxCGRuw1y2psA0eZcMN/LMQdSZvo6t4VYS5ValGruu9JRIOK9YPrcNuv7BIaaKQREU+KCuOVG4CkWXbZIoGJlzdp2h6djLJLHNaAM54Qhzg3r3A2TbBHhHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gj50goYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KGIXqOEX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B8C811401A0;
	Thu, 13 Feb 2025 07:17:05 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 13 Feb 2025 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739449025;
	 x=1739535425; bh=vlhlBzSkIneMGWYQBwFyfnTl25nGWzLsKGHhhsEs/qs=; b=
	gj50goYMrgEWpERcjDoQkgN9f3pgpWRaH9UTa9EeXqLr+vNsHhkSI10rDN2pRbPs
	0dMsVZxIK8KbQJ+T7z0GfbemKmz7GcdahAp3mx+r+hvixy8hF7f7FN4zuGEm0grg
	+OIwutIYnvZv9OcE9iL+nhLx7OG2D2dV+ja54OB39VnqKVdjTR/Pl9L2ckVtpLYf
	nTOuF3/3/bFKCEEYaN6BQIbqw6bhYP6BfvS50t7yqcgctyoWAG4ACjticINh6EMo
	jyNIMqrJOUGp/xRm9Y81r2U55gJz7ysedkHH4N2Nmfocl6tineRAWXK30FfDarhb
	QnVbj5L6tsNXrDuw38j+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739449025; x=
	1739535425; bh=vlhlBzSkIneMGWYQBwFyfnTl25nGWzLsKGHhhsEs/qs=; b=K
	GIXqOEXDGqLOiIjohIg/UsrKcsUsFtJQspSxYVUbqFU2MmRVSknGiAGOdHheWGKY
	OT68kTYQCcvgc1Hr+5SJm0XWij0WkkhrP9aALWDJRbpMpu57WwTp6Md0Os+bSZ5j
	v4JCkkKw6HtLiEW7PR0PT8cfTKOV/bw9r3rakcK8c81GB/mO/vWNxso1AwNTIlVP
	JoTeaL8Kx0XIW8t/zEDvWal1fNogVXF/1apPPdqNUX4KgrCrGwJj1SJAmdDwOT5S
	+KZxke609KApqoVkYMmInLZvrCjdGUc3chIcZyGQr8gwMJ0BIzXc83ULenyZfDvg
	edV28qdFhn7EjVVoUkxQA==
X-ME-Sender: <xms:weKtZxZ2Jx0SogXKgrce2SjWTjH38dKFCmZc39GEp1sDVs3S0TbyhA>
    <xme:weKtZ4YnIxba5f_D6pt-4Ddpe2s4Uw3nT0sCRfd8VgWa25I8OCEAy8cHqGhtfw3Z-
    _-vVmtxmZuU-ScxE3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtghhvghhrggsodhhuhgrfigvih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhr
    tghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:weKtZz-QYp083JbvMAwwfYxmY3dIwwRyfVC1pJyvFu4paKpmoSO4jg>
    <xmx:weKtZ_pwh3ESfCs4C12dD4F52BjHrnepmhkcN64rV-I_fx4sFyqDzw>
    <xmx:weKtZ8p65zSwpqVmaWg9jlnDriUkxQ4bY-czD3PyRW4ZE5sYXgzvaA>
    <xmx:weKtZ1Rg_13YwDOe9KgRY6eNSAXZxhNHKHsmkvGB94yG2QK4j3psMQ>
    <xmx:weKtZ1k722L4lapCobovkiUcJ5fLaEUOUgSgs--Xdnd5DGEk9anU9dE->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFD6F2220072; Thu, 13 Feb 2025 07:17:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 13:16:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
 "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <607d3acb-0950-4ce3-b8b4-46fdeca3ce0d@app.fastmail.com>
In-Reply-To: 
 <6d69b25e9c720e0e7fc037928695ece7c8a35034.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
 <6d69b25e9c720e0e7fc037928695ece7c8a35034.1739447912.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH RFCv2 1/5] include/asm-generic/io.h: fix kerneldoc markup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2025, at 13:06, Mauro Carvalho Chehab wrote:
> Kerneldoc requires a "-" after the name of a function for it
> to be recognized as a function.
>
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this will be merged through the documentation tree,
let me know if you prefer me to add it to the asm-generic
tree instead.

