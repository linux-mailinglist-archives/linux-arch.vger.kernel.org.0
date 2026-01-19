Return-Path: <linux-arch+bounces-15868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81AD3AE80
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 16:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7D1030116CF
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFBE37C0FB;
	Mon, 19 Jan 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="E7MUOav3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xpkTUEcj"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BF3346BC;
	Mon, 19 Jan 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834693; cv=none; b=bEvGBTbeXfOn5IdOEOB9UTOQm/zjvWcGe37DPvh/QTIAJLGphHGJbCVwop17KEoeymWG/ohmOhXAbYeGcZJoBiRax4Gw3D2qR6NyObr7nCKeKZ9dI6Xgh7TqGCYUoGTx6qnSQC+/6yjyTUyu/hvEMPfVywlLKwnPeTHeKuT4SgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834693; c=relaxed/simple;
	bh=HyRGxTRA7XFN98cQZnOTZ2Xah5whNzETxlAT7dVOlRc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e//fACeu3p8tzc3McNSlxonKFdJJUYXkcwIeX8bXDqSRspBRg4W/J39DNVHDTrI4PMk8IIVsyxhl7E9OyzYD2ISkM/BFrjM/oG5ygDS2MSdhE+BoCMbtcDf+eYAYI4EjUaTT7GgLZBqZ3RSNA9fnsTm969rW6532EGXRAhr8ZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=E7MUOav3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xpkTUEcj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5696E7A00F4;
	Mon, 19 Jan 2026 09:58:10 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 09:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768834690;
	 x=1768921090; bh=gTj1eTlF3idOd09kgm/8d0Oc7CqpX08CamxNoQKOdtI=; b=
	E7MUOav33krnIrgj1N899qwREuH2bIJc/rKW/nsFegxJuwkSjMKuNut2VP6BMUAB
	g9sKD+9IERdJy+pUex8tDZ1hgTnvusuEbp2X0ZABg6ftjsd/t3+tz1Iz2bCnPO3o
	hmt74nrO2hSNQEpnbOIYcHy1f4eDOAAK7bpYW1xcI3hrsn30hUCy4CAOldxeY+dL
	64BsEtOoTRFquc4RPtDboTorSXr7xmsxXvxRu1rPthQ5XJMtOSb7CSLkrHCrZXtU
	Vv0oFPmEhUNhSV3R7SW/fPj8R/9eRobbaIoShKZbukz6JRSO0KfGqK5Y7lFK0zhM
	ac+hGyoUzkFXqgQv6YzrFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768834690; x=
	1768921090; bh=gTj1eTlF3idOd09kgm/8d0Oc7CqpX08CamxNoQKOdtI=; b=x
	pkTUEcjg3J2j9QL8pHCGr8uCRJgcCXFUYQVvuCZ7eZhfq9MDGgsw0jaiAbnmUMoX
	RzsIEgDfS38tlcas3Blog9HB7OqrwjM05LGarGaZOjucjSytSgxF6En9RgaFeEyz
	8ghKeIFZGU/YOQ8ETwzT9zTsUVoVBD2NM0r828o8inNEP21t+tc8nx6h6AEAnnj7
	GOz2ypJahb3vUcmy8piNRRb9LiX0zrnphY5V4nwvZMgsAZtivWtOCEa8905w+Ofj
	3GxtCcqKqZywwcJ2URIgeZMe6wMw2w8DS8i0NGfYNNBEBKzYU7SXZumIpGFj7b9z
	j19eVR1m5bsyZzR4jPMdA==
X-ME-Sender: <xms:gUZuacpITPlAATHEDsFnkVHimDSXb8QrrLm2E9zJ5B7yByYb2qcUyQ>
    <xme:gUZuaddNp9BZR9NrUDn39zUIldvD0zjRFnFbInk--tAnBUJ3aN8vDMo1F0c8vJh-v
    CIOvbnyFhDRR3Ghi7-Lb81NK6ojNA1IJ7ahTKj04C0CMvkCuK1uYwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gUZuaSnjdDTg7jEUkdAiJ3rR9-V_2bVDUsyGG5tXkrA8pvIh9LFPIA>
    <xmx:gUZuaRcHX0nObL3KCWH7mpcDbiaKrX8puqQiu93IHv9ObozOJ_frSQ>
    <xmx:gUZuaQ220S5mcUBvtXM1YhpHr_bNZoG9fWW2jm-6u9QVgjZ40zTW7A>
    <xmx:gUZuaekWmNkEU6kHVh5euHdARM_VjufJTsZ4p5ShpkpbzYgFzfz0rQ>
    <xmx:gkZuaTuN-zKabzuh55Dr7gTR0wTgf83Sbwth-mbv4GnAYZV16aCCShCb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D198700069; Mon, 19 Jan 2026 09:58:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A42RL7jkrr-J
Date: Mon, 19 Jan 2026 15:57:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David Laight" <david.laight.linux@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
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
Message-Id: <4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
In-Reply-To: 
 <20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <20260119100619.479bcff3@pumpkin>
 <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
 <20260119103758.3afb5927@pumpkin>
 <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
 <72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
 <20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026, at 14:41, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote:
>> On Mon, Jan 19, 2026, at 11:56, Thomas Wei=C3=9Fschuh wrote:
>> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote:
>> >>=20
>> >> Don't you need a check that it isn't wrong on a user system?
>> >> Which is what I thought it was doing.
>> >
>> > Not really. The overrides defined by arch/*/include/uapi/asm/bitspe=
rlong.h are
>> > being tested here. If they work in the kernel build I assume they a=
lso work
>> > in userspace.
>>=20
>> I think You could just move check into include/asm-generic/bitsperlon=
g.h
>> to make this more obvious with the #ifdef __KERNEL__, and remove the
>> disabled check from my original version there.
>
> Ok. I'd like to keep your existing test though, as it tests something =
different
> and it would be nice to have that too at some point.

Sure, that works too. I wonder if one of the recent vdso cleanups
also happened to address the problem with the incorrect BITS_PER_LONG
being visible in the vdso code. Maybe we can already turn that on again.

    Arnd

