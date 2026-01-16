Return-Path: <linux-arch+bounces-15830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CCD2D7B3
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D603072F9D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48E2BE647;
	Fri, 16 Jan 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wcnfFEpF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAF90mRX"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC7283FE3;
	Fri, 16 Jan 2026 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549607; cv=none; b=Xza69MyQso2qZuaWI0YtHjb0aZXCU4N86TwvQoo5uwEW+0OS+ddh52EU/rC55kgZ2KjNHcPt9xdo0xUsJv0RHCEvOoqpac6tKZ3HTDrV/t/DgJf71UF1hkyGW65OnNVBZii6Sjhn6S7vSmBL4/LWpsKV8si5YrU3jxOTa0YiiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549607; c=relaxed/simple;
	bh=RRPZA1AKXR+QnIOWxiGpqY6TTtEeq2Sm6aGzQoR6MpY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XDqTbsPqacA/ujkQ6j1K0Ib+JamkHjjE7Hi1bqy2/OzBZvT8aEfYP+EafeKry8XnlSTm7Y+Fsz02nIMhEZFufH9quh2Pwv0v+Jj60rhb5T8B+ZwIVy1EiOAJXUYeXU+9TlqfJpDbvF40nysp5pyvWdp2+o0c69KrGhZfCVlD5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wcnfFEpF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAF90mRX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EDFE7A00E9;
	Fri, 16 Jan 2026 02:46:44 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 16 Jan 2026 02:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768549603;
	 x=1768636003; bh=RRPZA1AKXR+QnIOWxiGpqY6TTtEeq2Sm6aGzQoR6MpY=; b=
	wcnfFEpFkDnHJO7mLJ49GejGWIsRRMtWiAjahGnA1YOcUg9UTaZHEUvI7GPRFULh
	cxTcWotkGTgFT46pephLYQ5wIQf/UuCywCrGrJd1UXtPZgsjVuc/wgLBdF5h+C9F
	VbTENBQrS46jfg95Nw+0EBPWW95eQW4WZALy2xIwVxzRmVFZgrv5gehEXZgDeEfU
	xwd+FGpca9lpkAnalv8Ixa3mzXxm15E9SJSO5Y2om7mPXSdAu+fVAQEgv1UsVWV7
	kCZRJm8XtXFQxPSAm+09mJBtWKLXqmq0dzOJRAyjxDqy9biQF4xz0ozBYXkLhwRk
	UXq/tLyOYKVu4UNDcxMEYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768549603; x=
	1768636003; bh=RRPZA1AKXR+QnIOWxiGpqY6TTtEeq2Sm6aGzQoR6MpY=; b=O
	AF90mRX7Cegpgdpy9ROJJKAF7A5HvxLrPdwe8bSU8FfpKYjFZWA4MypHUbc61qpu
	jdH1IsaIRqnD9YUYw4TjZqRbX9W1GuxHA2A3cY+YnHt5A3WkoFGjwzTZyJg6UpsJ
	3Z+r8I2hS/SnAMv8LFCuFtT062ewEY78NnZPAwRs4E3mroPbHn0Q5FZRzO5JjHEM
	4Rq4/KGyKhSY6edDquaL4s+FzBeBc/Pbl/JsukP5+IOVWxj/iWFjtN431noIWPtX
	1Pf2xhUFuO9aPAJhKAsstcd2C7QBOFLX5CLdNtt5dOcRrODg5F3DUeQT9opdZXY5
	9DNUQCy7mPx0w8fGn7qOw==
X-ME-Sender: <xms:4-xpaTp_K8L4z7eOgDg6XuMv1mAjjuTVX67piSMM2ocr7rgqy6Mr1A>
    <xme:4-xpaYcb2jETv_k65Byjo-SvCLumMUArokZF5JExtvV5fpN9i84VQPdSwJxCXiC2_
    GNNGccZaeN3jcahisURFtR07gXcr4yBCXicG1lsYVkrqvLp5qnB0Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4-xpaaOO7X-I3fVN0KS3Frvdh8TEnKZXo8WEz3JHksShJI7uckeK8w>
    <xmx:4-xpaaTeYVwAPAS6_2UifJ5usUYSG4gLjX8QRMypsCz8DdJTUxFS8w>
    <xmx:4-xpaV4oElbVsM1QrCVwmdFzph6ansRj2OfXHX8mP4wD2HF6mGAWEg>
    <xmx:4-xpadZLY1t9JUd3IVVB1YQQct87ldLWgrNXpCLRJZGoUvGZAEY1rw>
    <xmx:4-xpaRKq5FPK0mYhMeX_ADiueQs4PTmNBYoHVTbgIGJlCKnsUIkXYoLJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 667A9700065; Fri, 16 Jan 2026 02:46:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A42RL7jkrr-J
Date: Fri, 16 Jan 2026 08:46:22 +0100
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
Message-Id: <5424652d-3607-4718-b32a-a9591437c133@app.fastmail.com>
In-Reply-To: 
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, at 08:40, Thomas Wei=C3=9Fschuh wrote:
> The value of __BITS_PER_LONG from architecture-specific logic should
> always match the generic one if that is available. It should also match
> the actual C type 'long'.
>
> Mismatches can happen for example when building the compat vDSO. Either
> during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> when mismatched CHECKFLAGS are inherited from the kernel build.
>
> Add some consistency checks which detect such issues early and clearly.
> The tests are added to the UAPI header to make sure it is also used wh=
en
> building the vDSO as that is not supposed to use regular kernel header=
s.
>
> The kernel-interal BITS_PER_LONG is not checked as it is derived from
> CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> deactivated check in include/asm-generic/bitsperlong.h.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

