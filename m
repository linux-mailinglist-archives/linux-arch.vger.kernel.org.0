Return-Path: <linux-arch+bounces-15874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCFD3BA2A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 22:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6295D30274C3
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344502FB085;
	Mon, 19 Jan 2026 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mkgKsOas";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cmf21LKZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218632DEA6B;
	Mon, 19 Jan 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858817; cv=none; b=UMx8m+zeuamapfCwegWlhEIC7YsbyyPxQsC8pnkDFJTM9BImTgQGGm+XxyVmXZ9mnbo6EEoJHV1KTnG4L5c9g491KSPdvJoLwWSAY8NIycSLduJ3ZiQk51kmv4liw4AQtQqdeIILB29PLTkc6jEUTspD8sN+So+3VP2TdKnizYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858817; c=relaxed/simple;
	bh=gs6BVu6/VpnyGRvND+w9+duH8hXXVjnlNOxRU5VgotM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R2LQeG4v3+71tQZFZ0G+Xq2c//1DnFAg39ivFM+B83wganCtHIgfEuoO5XBQ2QN/W3msyTvMT/nTzytuj/T7zOL0rs+TkqNm7PXyNgLjxF0VbjDu32lsREbjl4XygCvV9Ytmy1kR4AZGBazZuTmUJ54DI4wt7zAML4i5S+SLTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mkgKsOas; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cmf21LKZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B3EEEC010E;
	Mon, 19 Jan 2026 16:40:14 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 16:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768858814;
	 x=1768945214; bh=zgknL4UuViFz2udA1n9uNjl0KEeqbd1goKOOyzv5WmU=; b=
	mkgKsOasFjdPhT4fSnHW9l7ug/BsWP5+bizF/NxBr9o6g4YC6/e7nRtitcjqXeAC
	LXvMYXHTkdnSvpicxRCOSPZImgSVRDkEesW13EZ0FFCABZrKMI6BMMm37XYr/kF0
	ZxWBWyJ3jxFX2Yko/6r7Pj+lLEh1i00p9DPQ2GQATUInjfERGCsK4CrpjG4xPhLG
	t0831qMOx9gXp1ZfZCAIn58gZwdxylZWAP7AlqZBu8RUnnF2aO6ed1oDEb6mkIx4
	1fFDkut0S6YrrFrEnQFT95aywRlfVy/keF8N9bnzs1PEUfP/Ip1T4Kae2DwIdGUw
	Uj8zDAIUr1Ar/AoUuturfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768858814; x=
	1768945214; bh=zgknL4UuViFz2udA1n9uNjl0KEeqbd1goKOOyzv5WmU=; b=C
	mf21LKZKu3Ya299nr6+mpSyNyEwPkrYtEb9N34xWT9AkFdAnGFFAKfiCrUM8ek7E
	H1n3PxFofYCbwfW8WCxqrQavVa5sqc7DW/7puBPTwb/0dklelQSdcm5n1g5AZPEl
	qXY7u3mjDyS/P/dBrWft8uucrifpJQgL5XR1EOaAvpQhHcwHXmL2QZqz3ZC6K89d
	8T5ZORmPdhYfuewcsiKGKUM4qlnn6TXOR46Xl791+m0vtMejlpsoRq2/m89E2Xb5
	S+nFSAeMJMIB8E+TOkVHFW0vHzCErOtorXhLm5VAIEXJS8WjvK3Kfqbk/CNETJAf
	9RLAn2d0fkBYCNbtN2GnA==
X-ME-Sender: <xms:vaRuadopWw7IDakwJbaVKEmg0t83kak0pX8C0J95QJxoDRcMc41PPw>
    <xme:vaRuaaeB8YBFtbC-XdThz17XwdrIAdNRmqU0QZuJR_LF-6NSRMog-WjLB2oRNj0fm
    MixakOgs9ps-C7O1YNQCbU9w_yM_DKexex_-7J3zeIbYnbRjefx1-RP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:vaRuaUMt6-21r-SpmjsC2OKFqzkMGJy-LAKEozkP4f2wxjMvYMYeJg>
    <xmx:vaRuacQoYgkAZy63sDVmA4XMUEwuJK3j291AjWIl-LYTCnhTBV67fQ>
    <xmx:vaRuaf53Slf121PMfKLh_WkRnlOyEJE4L0ROXZCzOXDpAkUZyuosVQ>
    <xmx:vaRuafbyZp_xHA6q_3hdE3P4Jlwnn0ZxTWJorrJXx9QXzNmSzA1Wcg>
    <xmx:vqRuabLrH6Ze0AC6CjuSFYZP1XcdpQxvWKp7JocMAlT0yBvFtqjhyZjy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4110B700065; Mon, 19 Jan 2026 16:40:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A42RL7jkrr-J
Date: Mon, 19 Jan 2026 22:39:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org
Message-Id: <7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
In-Reply-To: <f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
 <20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
 <f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026, at 22:12, H. Peter Anvin wrote:
> On 2026-01-19 07:39, Thomas Wei=C3=9Fschuh wrote:
>>>
>>> Do we actually support any compilers which *don't* define __SIZEOF_L=
ONG__?
>>=20
>> When building the kernel not. I used this pattern because it is used
>> further up in the file. There it makes sense as it is actually a user=
space
>> header which needs to support all kinds of compilers.
>> But this new check is gated behind __KERNEL__ anyways...
>> For the next revision I will move it into the regular kernel-internal
>> bitsperlong.h. That will be less confusing and still handle the vDSO =
build,
>> due to the way our header hierarchy works.
>>=20
>
> The point is that we can simply do:
>
> #define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)
>
> ... and it will always be consistent.

We have discussed this before, but decided it was too early to
assume that userspace compilers are recent enough for that.
According to godbolt.org, gcc-4.1 lacks __SIZEOF_LONG__ while
gcc-4.4 has it, as do all versions of clang. Not sure what other
compilers one may encounter using Linux kernel headers.

     Arnd

