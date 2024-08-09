Return-Path: <linux-arch+bounces-6143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962E94D7BF
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959B11C22825
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66451607B7;
	Fri,  9 Aug 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="o4EF+JwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJ33XtTE"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD51465BA;
	Fri,  9 Aug 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233437; cv=none; b=TFR5WDMjdMj8/LiSnJS0gAxFDQeYhbXs067THPkYrcopzt+sbbs56YZeZpOemZx52eKFGcfxUYuQG2T3454Z7YmR2x1QLWBod5MiPhWoJjZAUEONne8iAO0mkelJDCD+mM4xnZpSc10C7tkQl/vFxCmz7YbpxcVx1Y/Rslt6h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233437; c=relaxed/simple;
	bh=cSR/I6UIof3PaKmfx3kdogeOf9i1dw1xSHcycpodZeE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VhUTawov0GtMQbO5pJI/L4fL00P6bNl1YTMqd3RZETCaeZmytouuTQTnnU1iQb2OrR/eG6SQhGSVqaIj3HhCFaHwYdsgm46h5Xx8tA/nZQuW5ZnZmkvX2yNesFgszMz7XaUrbCnxbke8za1IJRlgHy1rvecC/uJu9C/OcY1X6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=o4EF+JwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJ33XtTE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A21E114ACF2;
	Fri,  9 Aug 2024 15:57:14 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute5.internal (MEProxy); Fri, 09 Aug 2024 15:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723233434;
	 x=1723319834; bh=XVglR1EpsTfCl2068j+vWAn56jnxT+atokUjXFwiBW8=; b=
	o4EF+JwH/u+5ce4v+mKsOfoCUdyVdsmmS6AVJXlBsSSVqEJHCSU+1YplH4C0KKqS
	jorAGjtzdDhMkNiGRL7VLHDEbiGDLcFNJLeKWzkbbNU2IXyhRcQKet/KC7UVreda
	4cfwx3klqARn6CszkZL9XvseRG6ynExaW6QKsmLvXbyFOIEUqs1gOxhitzk1OiIk
	fFIe61slsnROKQtKgqc8DDWpo5lAIkisVAn3fZpMruBZbEMtMPrxkvkAPSSnWis9
	j4nBjHfq73VQV5jpDKFq2LI5GqvMTz055zHmUX9nU6WzXLxhvr1tekRQBFoMxE2X
	3z02ieq55p7hYC0ICqJIkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723233434; x=
	1723319834; bh=XVglR1EpsTfCl2068j+vWAn56jnxT+atokUjXFwiBW8=; b=d
	J33XtTE5rmfAvVaTlWir4ypVOFY/hXFZJMrXTz197zSkPsEzMiDKuGHWGYJ9eheE
	oGPPcUjUGbAh28ViaV+KCQjaYt5PMx+S6NiP0jYvIaCTP6TIsb94rhaieY498zIB
	CoKfzxvE3+n4PWQgvVU6kgE7M7KVPAfrXKSDfVbsMlH3m2dEq2Z3sDr6QL+wXEP9
	5s2Y8jLuKq/a6ZSOOjgdGwXyV/n2Z94ReDCfPoG4oyU4ZRGWqnuk/b7MZh+xtGfC
	072E6gkm7BNBPU5Crl5IU3ZjLSiqIqcg7pX3gpZybrFRUN03BSZYjXyf8KhIjW5S
	P+Faak8l6ygl2Br8XQ5zQ==
X-ME-Sender: <xms:mnS2ZuXZfPrdTxpmpnzGm6KSPlDIbkSGWUa7kcI0hO_JzenpkW1LAw>
    <xme:mnS2Zqmg_o8arq30rBePVZUfHXjb8snGczrPwNSD-gPDwZ_p0KYYOSmcdzFNBtkuh
    C9diaOCCRqlMja3W8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthho
    pegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mnS2ZiaW7rRtz55zlVsdivgG1hcuqHxa89x-Zvo6dy1B7uYGNsTGuQ>
    <xmx:mnS2ZlV-ZwiMvaK3GE0roP_IarccYSUXFdK2nz-9YriPihqEWQ56wQ>
    <xmx:mnS2ZonsMPhq0LsjgKG8Er8qhTKTMqi34dEqlgET4Zh9iOpcBxpiHw>
    <xmx:mnS2Zqdoiv5mX89HwXXK8IlIzB80XuyzvgqPvXv_cbFJYYlosaUuGA>
    <xmx:mnS2ZmaCmNonnR0aq3XSlebHCgIeUt_z4l21sXUhK9Cuzb0FP2YyC-rk>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3738619C0079; Fri,  9 Aug 2024 15:57:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 20:56:46 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Arnd Bergmann" <arnd@arndb.de>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-Id: <f61081e8-6e48-4161-afa5-ec3a7a58ecd6@app.fastmail.com>
In-Reply-To: <70f908d0-7cca-40c3-9aaa-c838b02dc4c4@app.fastmail.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
 <20240809-mips-numa-v1-1-568751803bf8@flygoat.com>
 <70f908d0-7cca-40c3-9aaa-c838b02dc4c4@app.fastmail.com>
Subject: Re: [PATCH 1/7] arch_numa: Provide platform numa init hook
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B48=E6=9C=889=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=888:41=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Aug 9, 2024, at 21:25, Jiaxun Yang wrote:
>> For some pre-devicetree systems, NUMA information may come from
>> platform specific way.
>>
>> Provide platform numa init hook to allow platform code kick in
>> as last resort method to supply NUMA configuration.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Can you do this with a Kconfig symbol in the header instead
> of a __weak symbol?

Hi Arnd,

Sure, is this some kind of subsystem policy or general recommendation
applies to the whole tree?

Thanks
- Jiaxun

>
>       Arnd

--=20
- Jiaxun

