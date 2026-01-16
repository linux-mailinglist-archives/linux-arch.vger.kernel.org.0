Return-Path: <linux-arch+bounces-15831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 054ACD2D855
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A67C30B514C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419022D5950;
	Fri, 16 Jan 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K6vZsm2M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOECjkcW"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD682BE65F;
	Fri, 16 Jan 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549777; cv=none; b=k6GcGnMLuM4mRgpGiCngSE4FT5CJvamUYvAjo1SB7WFRm64Wylf44HWqZfHHHWTR6ueXvXIWkrgdtljPCBfmdQMun3kMADl6GWS/oqGq7Uh6Ej5J+VFX+vQp7wLORe1d7/TcfX001SQeCnyGjdvnKK2EgvPzRLSxlo1uGfqppnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549777; c=relaxed/simple;
	bh=RXWDqAdLZcTJvhwatSusU4vt75Aax8tkKS2QqboMI1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=do5VCaWYFb/AWnRyv9FB0zC8YyZlHXKnfnjSJlyGin2Y0tU9eSZ+bMpWixQKyi7BQtLzkRiPXzFb/w6gvZKBmMmq42skBgT/cPTgBCS5+C56E1eImXsfRBMX2I170tZovRuBwy0dnvDIChDNX1YkmXg9O4L0Ho/gttGRLUsCMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K6vZsm2M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOECjkcW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 977507A005A;
	Fri, 16 Jan 2026 02:49:34 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 02:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768549774;
	 x=1768636174; bh=OOEkW/VVyRuMfIofkXVsoE3+Qr35ltML1K9ZLShVqr8=; b=
	K6vZsm2MbIqr3DB2dYYMciazteFY5vjiccg3cSGFwqz1kZdDPHyqVytCnjn0qqKC
	oiocStSV74eoOwp2PP565PZoBFACh3vcL2obRBZfE122qomhBsGGXOInvLpyd+Fr
	0+TNgN+jKlGwTqruDEapykbEZ8nUEQ2vEI+HuMj7n0IrxcvpXCdxlmHCyLQf2oix
	nxUq6bwxTwN1IfMd3I5Z0vij0IOWgeiqnzJJ5L+kjt3A5BGU/4f0kRUTPcZsuDnX
	oUxagOTDSugbUfAGCKiWau52LVqjQQTlNymoPQe3TkkflSsK9yh6+9DOVMhAKeLc
	ZpnC1jUHZdxHQfrDwdF3Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768549774; x=
	1768636174; bh=OOEkW/VVyRuMfIofkXVsoE3+Qr35ltML1K9ZLShVqr8=; b=l
	OECjkcW0aucX+ZH4nLmKrTCMjRAALMwlLwo1Rp+08IFI5r/gtPMvknr2ygL616da
	hYi8N+U0k9f9/p4sm/iCG2vzt0SXkqbdYgorcGy2P0ozh9WEvaeGJa8XvldzZXj9
	LG0vr0aw64rAq72C7q2PHVO4U+XeTKSRaob6My/rHKWbsI3LN7DFNLCHxFrKP3DS
	D9qXkWYIkVBwF33ovZonJd1ktxuIEvzDcsN/P0BfZ7xJDlV0LxoHJQm9fUtWXPec
	f7Mic8BoF9nJek6M04wMpqVg0V+u5tt1vpUvYKlxWaLguW7pmSZZY6OP92EfZ1Sz
	MvsO/dNCuzXNaho70QPcw==
X-ME-Sender: <xms:je1paT5ATetf8sSBFyfB-1s_03Rf7JXa2V8h0ev74jRshd4jyZoIzw>
    <xme:je1paTviUnAE8ecWzIA9AjQQQ2vfLPEc6nMsDbO1nZbxn5KtsVaSLSxdF9JG61fxf
    batqLiCeXluPVOTMCTIgImM10GuVFohDRmVFTRwpJHyhKU5hWNvVhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivg
    hnkedruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepshhunh
    drjhhirghnrdhkuggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhtoheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrfigv
    ihhsshhstghhuhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:ju1paXoiO0IaRrOcA3KG3P7TgEILUCdR9YP8wLQU6nHMmy-c0dRkZw>
    <xmx:ju1pae2g1_7EgaExIZKp7PwQB31Hn2TRiOl4pv2kvadh3YVBhcPGZg>
    <xmx:ju1paYvrlxSq1QXO4qZ9o9llJr2RyGQbPXyILGHGHezUopV2F11JhA>
    <xmx:ju1paXEzOwaQFUvMDZaO2vowr_Kzhxlzq5I34y7FUyEbJo3E4iteNA>
    <xmx:ju1paWhmhOGl8Nj5M8j45VRKOEdHJc1kpjXALJAc5jGrzqJ93i9Igjds>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E327A700065; Fri, 16 Jan 2026 02:49:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0bkllDka2_o
Date: Fri, 16 Jan 2026 08:49:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "Sun Jian" <sun.jian.kdev@gmail.com>
Message-Id: <edeb782d-f413-48e6-b6b5-36961aacfcdd@app.fastmail.com>
In-Reply-To: 
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, at 08:40, Thomas Wei=C3=9Fschuh wrote:
> When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
> are used. These are combined with the 32-bit CFLAGS. This confuses
> sparse, producing false-positive warnings or potentially missing
> real issues.
>
> Manually override the CHECKFLAGS for the compat vDSO with the correct
> 32-bit configuration.
>
> Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
> Closes:=20
> https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kdev@gm=
ail.com/
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +CHECKFLAGS_32 :=3D $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32
> +
>  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_32)
> +$(obj)/vdso32.so.dbg: CHECKFLAGS =3D $(CHECKFLAGS_32)

Have you checked if something like this is needed for x32 as well?

     Arnd

