Return-Path: <linux-arch+bounces-7840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1641994E0C
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6685628336D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A91DEFE6;
	Tue,  8 Oct 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="no/6/4gP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9/6lKMd"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B81DED6F;
	Tue,  8 Oct 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393125; cv=none; b=doYq6XOKTtmWttDNxwr4qykeTocXgTUVzRkc/xxQC9GNfPyVHxTCUL/Y798Vu7FgBjWUqG4j2Q1blZLutHuOJslyvXZDuRmO/kNGtKhcg31LnzLGeJr29eqHJUGKTv9crUksM5NBmUlFxMq3J3rCyeYqY+5ML3fpM4kUVF1n5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393125; c=relaxed/simple;
	bh=bIg7dNjnnJrDPE9cQexGYZbgwrER5395ETWAldvQNOY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M+Qjk3i2vbvoZ55vpWRMJhGhxk5yAaKfu0vWVhIDf8bQPyYp4uZZOu+uzPnop6Tz4tMiQsSdPQqZK3XxmVnAfvKD1DapvC5iaEP+Uc82h1czizw9o/ZgzmB113/QI8VlFyyE5u/zjkkY2eA387lmlgemoc7N3/qFWXFwPYuUtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=no/6/4gP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9/6lKMd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B24E1140174;
	Tue,  8 Oct 2024 09:12:02 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 09:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728393122;
	 x=1728479522; bh=GQL6iG91BDYw7iUJiG2qYtNJaU0dzlAyjz84zK1b03w=; b=
	no/6/4gPM4Bzg4fRgeqQHakXIGgmDGJkY1y5WB5cfHCmSqXhKkKdiiOaBvu0pdFr
	wvA6lPLeuf2chZ4odaMzqFb9y3duAV9AjLJidcfh1wH4Lf/V0SfXBru7F3eJYeZ9
	HCLESWzVbwtKWb8sJRlwP8OYx24oX1kRJS0X9xxmEKJtIEF55YuV11lnGH9QJHkv
	wEvkkzdtK+MMpWYr7PURc0i6DsgA0nvyjgrcKOzaZfGm7GgMOviJGb154yuDsnDO
	otSvXXqoCtfJiKsHCSG1LAs34DOm00MqqYZFkLDmUlIbvNjJHkYXUhw2XOBgv/Bd
	aNb21NuXPqcKPeSNDPN2vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728393122; x=
	1728479522; bh=GQL6iG91BDYw7iUJiG2qYtNJaU0dzlAyjz84zK1b03w=; b=E
	9/6lKMdlP05iZ0fRcxt3VMNk/SV+4kJagSyQH6n7B9KZjNH61WMSdnlMfEiyclXr
	CTF4V43dvbqfDqbS7fSI7rvcBGhTcUOlfz8zuVVzvnEzQ5uJtHtgJQjKXQZ0hfPH
	97P1WelnO273CIRQsPb5p1VH7YDqX22nU0rocHYVt1o+bSm8uwhcnTFzEQ6tys65
	mTCs5KsNDc/nVv98vhB0hmBIL8Q6GaB/CR63UazUw0Rekqgu8JV27sTcYISYik2l
	Q72sZofwxwErAFW8WOrHTPgdXPDlBMpjfQVJM3O9Icy0+MtK4ztfYZ5kfWQOzeXq
	QUb3F7KgHKAiRH7iBeYwg==
X-ME-Sender: <xms:oC8FZ5NtfgksWvnk4Tp2uQstm156eXBXx4wNqmqek_HB285VGJeW0g>
    <xme:oC8FZ7_VwGZGzUzf7gzmAFTfI4Tl8DiYYV7pTP8q8OWErNUnrdgvjEqVMaRvwLf0Z
    cUKr5rbu8Sd4zLlSHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oC8FZ4T0mKVDOUAPr0Sv-UydK8dyAFViBrqGbFAOrCZe_XSQHqreuA>
    <xmx:oC8FZ1sgYhS2wHWPNKpPs8BrwfX78thruS0LXJdoKnfMAdlFFR8dgw>
    <xmx:oC8FZxdNAdGqGIF42LgB8U97LZxJL2U-Es5DbiMwdNhHcLUjJbELyA>
    <xmx:oC8FZx0Z66x9p7y5-zIZ0a1TOtsFH1mmNX_oSrE9YdXTxEPDFLvRsQ>
    <xmx:oS8FZyAlYvdqc1Wh5udpTJQE7aMLK7ZF9mprAfohhiKR9sxf8yK-P4z_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1BE0A2220072; Tue,  8 Oct 2024 09:12:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 13:11:29 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <acfd8173-9ee5-460c-92d3-1cb48f8d3fc9@app.fastmail.com>
In-Reply-To: <87ldyzubk4.ffs@tglx>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
 <423e571b-3ef6-4e80-ba81-bf42589a4ba8@app.fastmail.com> <87ldyzubk4.ffs@tglx>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 16:23, Thomas Gleixner wrote:
> On Fri, Oct 04 2024 at 13:13, Arnd Bergmann wrote:
>> On Thu, Oct 3, 2024, at 15:29, Vincenzo Frascino wrote:
>>> The VDSO implementation includes headers from outside of the
>>> vdso/ namespace.
>>>
>>> Introduce vdso/page.h to make sure that the generic library
>>> uses only the allowed namespace.
>>>
>>> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
>>> it supports 64-bit phys_addr_t we might end up in situation in which the
>>> top 32 bit are cleared. To prevent this issue this patch provides
>>> separate macros for PAGE_MASK.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Looks good to me. I would apply this to the asm-generic
>> tree for 6.13, but there is one small detail I'm unsure
>> about:
>
> Please don't. We have related changes upcoming for VDSO which would
> heavily conflict. I rather take it through my tree.

Ok.

Vincenzo, in that case please add 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

to the two paches when you send v4 to Thomas.

     Arnd

