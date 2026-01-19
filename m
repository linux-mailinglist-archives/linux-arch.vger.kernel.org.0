Return-Path: <linux-arch+bounces-15866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9FD3A955
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 13:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6773D3083F9F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00735E54B;
	Mon, 19 Jan 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rb8NIRkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAGEZ6q8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBA35E53F;
	Mon, 19 Jan 2026 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826729; cv=none; b=Ir4cWD5iK0Gis+qCX4MGOkHI3kjisZWgY1LXoPfLIPgrbbDIbRy573RZrh1edgI73gq5xO4rkvounXXJUZIelGI1C7LxjxPk5tot0JHznh+qLqPNWVebVBWyBhoI3nRyhrgDc/mpY9N/QVY3VBSLJyb8/QCmRGGAOSkxXQSYS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826729; c=relaxed/simple;
	bh=yKEXZ+AAxn84ABe/O9md/rSjO5b/3r1QcNr4Mj/qup4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bGjY7jx/cs129YeJIDaW337ekS+CdhCkNpDk7LswDLpnNVfjLPzmW0asE20yOHtlrVJskuSptPWnCSZp/nf1ilqmBewjYOE8VxzSMKJpSviVDjUyU5NrNHw9vlsNBNhUmKc5RqguNtI0uOUxhhpLmynF3yo4EAJareYcBSs+RBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rb8NIRkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAGEZ6q8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 927CA7A002D;
	Mon, 19 Jan 2026 07:45:26 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 07:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768826726;
	 x=1768913126; bh=70s7Zko6UnDtDy+h/M/P5ubFxQr/sFl87utIN9PwsIo=; b=
	Rb8NIRkUH+XGwhGWhURvfKe3MEz+hWFrSF2o77ViVW+Ojh7hjFBL/+NGuRNDnf8x
	O/Z6yp5crPLSctINxKTJ5VrD89A6/hJoXCw+EZIUvbW/rBOrvx6K8mQ/H5+ZS0OI
	tqp7XvzgwKq+UgrRVj4IZFbaOG7BqHxPYE2T+tZcnFgsI3BfY+v+mdBCBd7UGM7C
	X+hyLeO/gcE5rYrWJDfKdSJH31GwD0q3loDHvR14wcNbB3DU3dvdGMLq+5HSdMPY
	04b7f1CEW/X+aiqpPnCGEgnOwrIoNxJDNVsteUFAQI9wExvCOVXpDuaH10V0CGiU
	TRXcDc2CSSvrEPeFKQ+E7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768826726; x=
	1768913126; bh=70s7Zko6UnDtDy+h/M/P5ubFxQr/sFl87utIN9PwsIo=; b=K
	AGEZ6q8DsmNV8OcI6m/vICQd873Cqgh0BhHZn7DgQzyH/wIsomJsLsaT1vVIvQsN
	U+CE5Qao7w5BZkUgjk7MSfkIFLhEXREMQo4Kzm12RmnEjJcmZWNb9bk4PEXee7ba
	Gtriey0GwAAiiqX8dW1pwwsedA0gVuH/t3gxusGB+0mkuxRk3H/Qu4/oPLnypdg3
	TTfQliJExRMaLzqDcjM1p//ipWFvvk7GjNHDBEnUDK/ToEAmsAIkBVjhgGqcLMRE
	izqXhb1c8VIqHutCKuSZ2dG+oaa3RA+HRBOxvj5/e303vXdL9Et0+Ldd81EBwNyZ
	55pIsiPDu8AibhjpRZDig==
X-ME-Sender: <xms:ZSduad4WSCrsMecfkgobWSs_VwUocNxPKMGhz8K74wfP-M7woZxKWA>
    <xme:ZSduaVsEdDlVxltznCfb3ruTjHedo4uqRe6DHOHgeLAwhHyLO1Sv5uQvG5e3CCApL
    TxN1RDzMbAkiKN1_xMYhPcUu8No5mbD0KjjohnzMuOtp7f3ILRBZDdh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvggrshesghgrihhslhgv
    rhdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrg
    hilhdrtghomhdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhht
    rhhonhhigidruggvpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrd
    gtohhm
X-ME-Proxy: <xmx:ZSduaRoYnEWRBbm7VelJEuph9Utr8cfKrxgdZ0M0co-2KNNHJ8PdKQ>
    <xmx:ZSduaQ32TbtFI-rHjTXAi1I0ZrHDUOTZEnrtSSerQayGCMPX6YGVPg>
    <xmx:ZSduaSvq9Nw1G9GTryHCMG_vlm_SoMt2BtS2R2Hf_1w1xyAfW5l6Mg>
    <xmx:ZSduaZFdF1417SvU3r0caID2GYiWMZYsTIlTLHuKltytSmxDtqAmHw>
    <xmx:ZiduaYjin3CdjrfyQ5RzsKlcz32txh4gqxxr_DDZC04eLW8_WsiCJehq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2173E700065; Mon, 19 Jan 2026 07:45:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A42RL7jkrr-J
Date: Mon, 19 Jan 2026 13:45:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David Laight" <david.laight.linux@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org
Message-Id: <72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
In-Reply-To: 
 <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <20260119100619.479bcff3@pumpkin>
 <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
 <20260119103758.3afb5927@pumpkin>
 <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026, at 11:56, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote:
>>=20
>> Don't you need a check that it isn't wrong on a user system?
>> Which is what I thought it was doing.
>
> Not really. The overrides defined by arch/*/include/uapi/asm/bitsperlo=
ng.h are
> being tested here. If they work in the kernel build I assume they also=
 work
> in userspace.

I think You could just move check into include/asm-generic/bitsperlong.h
to make this more obvious with the #ifdef __KERNEL__, and remove the
disabled check from my original version there.

      Arnd

