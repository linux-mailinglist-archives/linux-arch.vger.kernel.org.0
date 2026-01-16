Return-Path: <linux-arch+bounces-15829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD4D2D6A5
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A454300793F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C9283FD4;
	Fri, 16 Jan 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FDrOs6T2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNP1FOxs"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31F1A840A;
	Fri, 16 Jan 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549527; cv=none; b=ZW+McNICNzGMAWvvUH58oAwt52IzHr9Bubk0Yru+QhOhgvyaesgxoLd5uLCUElJUvOaopdtEhH+ZBf/1HnXsf/eIM0pPztTqj9Nco9fVpZDV9te7/NS0aIO9p9fYGCbFvc1nHdA8oQQ9TjBbllGUQjIbhpIi83Ax7EVIpf8m5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549527; c=relaxed/simple;
	bh=NczJXBVMiKn2vKt9LvztTP2m8qqCtdImPLXdFp+ZYE8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nPU7QZKB1tgmDygswcpDHS7c6hNNs1rPc+zCWLMhN3m4x/ViTR36tiKcHUNi+2zg4JHvOHu5ECTaCgHWDQfXIh7L+ZK9wLIMAvDcyqT0Quwz9kYpnmVkTIwRwu84zVbXq/96C7wUO1wHxccX24FzJPTnDn6uVUdr+nXffl2iy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FDrOs6T2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNP1FOxs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30F547A00E9;
	Fri, 16 Jan 2026 02:45:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 02:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768549524;
	 x=1768635924; bh=0GY6uW4EfHcjEhKoCKaXl5iPY66LFt+39ly5D/9ZP4o=; b=
	FDrOs6T2okUPvaN0wZNP8uUzr6pwy/PEQiFr5m1HHyhjEqjL1toNvMdSrIuTwEPh
	h3BmSIlH+/MJVXn18pbn7HekKfVWZYDUdn5rZVc/4I33EC68jXHNHn9CTLEwGFq6
	nYn2kzAidSK1ToafLuN6EiQTBx1i8p5UHYpUVyqk4Inoj//pB/JIpPJXDeyQFP6w
	A9DbEyVuZYa6KWYTkEhWY6OJ1nzF+Q90J50Ye+U1qpvYb02ufZsWrWuSW8Pyqg5H
	hcLV+W2xgls9MVPJTUGdKDAjcXO7kmLmQ4kpTL8O/3u79jzEeHnGSO4f0MBPIXrt
	sKtvedsmbHVzZhfRWzZGKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768549524; x=
	1768635924; bh=0GY6uW4EfHcjEhKoCKaXl5iPY66LFt+39ly5D/9ZP4o=; b=q
	NP1FOxsoc9Z2QgoGozoznTdqYf8LaXUicwh3AgVkXRjmJwp8jWpGzwzT9/V6uCUW
	JDC0l3C+YY8m4vhXyW8irxFCWpJlkQ10CNF9r/5Jzl9y0od/P8T0JXXG0uZ+AW2c
	fCLsdxI2sKTcWXpKbO8wL1A84nzNNuNfilEh+A6iciGotTsdFNX0EaV6De4pYeol
	ZdslrTCRh+rmLlSpZPKKydyzwYN3TVVetofD4M8vLZGScW7rGC/m/YQJb5zVUc6X
	b+rzubFmxcAQQrtS2Qr4ZrurYbbwErsEmiMsUx94Tiktj12EXZVBdMa444IGx0qT
	ndnleo3fY1mgiOIj6gw4w==
X-ME-Sender: <xms:k-xpaWMvFbxulgOWiKV7IOe3BgKXXaNxjGBtT7Wm2-B-morTDpuZVw>
    <xme:k-xpafzyaoJFZgpPuJ_Bxax2h7e3VYHX2Kzuju248FIlZp6d06_0tU3_HKj94n4gN
    dCaGhHrwSqZ4gnQgPbE37ALDicEbaoAId63Mlc9JUcRwvXSlzr1JHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvggrshesghgrihhslhgv
    rhdrtghomhdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrh
    honhhigidruggvpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgt
    ohhmpdhrtghpthhtohepsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:k-xpabmJnGrx9OFLIEqlguE-coLrQa0A8H-gnuXLImzHF8GriskJ9w>
    <xmx:k-xpaU_eHQhUMf1NmdRqkWMSHTyJp2W09z5UVYp3nvI1aoXerTfzeA>
    <xmx:k-xpaXNJAmhTPmXZLgWYBQlc3ydOXSZb7vWVGttew9-L0G1XC-31lA>
    <xmx:k-xpaW81IA1nz-eDzd5yYPlk_K4U2yhyLo380QHse2m5b8gJoU-Y8A>
    <xmx:lOxpabxzhzCdsLThIc0pdlq3HcwnaynSTYdr6iESGAB2J5gbGNKJx2jV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 22C50700065; Fri, 16 Jan 2026 02:45:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5KQZWxRIPew
Date: Fri, 16 Jan 2026 08:45:02 +0100
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
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Message-Id: <7827adb0-b2a8-4809-8f5e-859102600e02@app.fastmail.com>
In-Reply-To: 
 <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
Subject: Re: [PATCH 3/4] s390/vdso: Trim includes in linker script
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, at 08:40, Thomas Wei=C3=9Fschuh wrote:
> Some of the included files are unnecessary or too broad.
>
> This is a preparation for a new validation step to validate the
> consistency of __BITS_PER_LONG. vdso.lds.S may be preprocessed with a
> 32-bit compiler, but __BITS_PER_LONG is always 64.
>
> Trim the includes to the necessary ones.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

It's certainly a good idea to limit the use of asm/page.h and the
other headers here.=20

> There are other ways to solve this issue, for example using
> KBUILD_CPPFLAGS +=3D -m64.

I think we should probably do that as well, especially since my
kernel.org cross-compilers still default to a 32-bit s390 target
for historic reasons, but the kernel no longer supports 32-bit
userland.

    Arnd

