Return-Path: <linux-arch+bounces-4353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9248C3B4A
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 08:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBAE1F213C2
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 06:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96114659D;
	Mon, 13 May 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="houEKXze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1DwLKaY"
X-Original-To: linux-arch@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C244C81;
	Mon, 13 May 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581739; cv=none; b=FzQuzD3bHBn4cLH2Z7XlJKanJOL23tFOQh5A22KPDG4lkXuHD/WK+uX3OB/h0eArqQEmsisyggrZBzqkz/r67BIpLhTVm/zwReCt05M5bjXmjMQHkMI6bguHqrer5SflrvabqBOTeQ9LCtqwRFcymG57fIhNlGAFeeoBrwWkyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581739; c=relaxed/simple;
	bh=45tmY0y3fCnmCaYapY24snPsJzwbRpZeHWt1NB5OFVY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aMvlX93o0rJ1KZtE9FkKjO1q8CwT+KKO9S55DZj+yDxT14sPnaAuTTCXQrUo0s69MGKj9kIzK90i3nwCQRoUetZIjGIUJnBhpnl9ITJuipZMTpRBDhpxN+fN0l0SNjfE7zJ3CMeU9YGhvMARdQgCgu8ZMqDVZBacYOWbT52Lj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=houEKXze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1DwLKaY; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 326A31C0010F;
	Mon, 13 May 2024 02:28:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 13 May 2024 02:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715581735; x=1715668135; bh=TpM/zmvwgi
	jUMxmdKJcAierdUfGrsz/jUMwlUvAaFws=; b=houEKXze/j/MdIkhmLt5MsvlEO
	Pp4F29Yws9M8yregVlfHfQMom7K9ci3NTFqH++QcteQVqqIXBpU+ZxoucSMyrcaf
	un1imsZAEL1aIBJExzJOnr5li8sxcH3kYE+9/1gm9EDmrlWQ1+hivXIP/c67YMj4
	X7mLRurn3pcW2bpT0Xekm8Tqt8Bu0CdVmXJVWtnGLstPgyoj0VqjDuYXORj6spI9
	kmAgrGVOEcsuphnBDImvezqp455CEzY17SIrh3u3NvZIdUM3hWtQISG2ugotnEtz
	NYrpe+VWp4G0NWShWJp8YWVWN4M9WY+7WwOl0fKsDkiaLd8uWYBLwrSntcNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715581735; x=1715668135; bh=TpM/zmvwgijUMxmdKJcAierdUfGr
	sz/jUMwlUvAaFws=; b=j1DwLKaY2CtQAq3/Axsg2QsYlTwdiYiLHWJngeb/CN3w
	xpLogJFuhdBwlmuXX87cfJk0xN74hR8ewyFFiXkq5/EUk7phw0VnzmZcUYB3UCJ7
	iWc4iQRyPhZoLXYUsfnHSbUeJ2bSfyiKMr5tjcx6tHmUvw2j0vvJv0CSZZN29Y7k
	h7/iW5nQdajdGjfgOMyFKSsT7ozGw+x++fSVOmpGIy8NFLYlUUIxdZ4+khEbjra6
	yv9Xvdh35ehTWlsA3e7OJ1J8ecqWr0n651hew+zzkxvJQDB50adQYBpicDArdSLb
	q08mHTmiJeWNz2dsFjZr9lLhtoQ9bnUIcYO3u/3bWw==
X-ME-Sender: <xms:JrNBZkx0beJwrzd2laZBBHUGSR2QPuSJBV_uIsBL7h-Gi7ihTt1gYg>
    <xme:JrNBZoToHCVBhOe6_hBYEL38JUxWneblqjNKvsdm6Qr5MzBkvRK2TuaLDUmQRmk1K
    Y1WVJ3C55gf_pL_QKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeltdeuvdfgfefghefgfeeltdfgieffiedvhffhffevleeiieeffedufeeg
    ueekkeenucffohhmrghinhepmhgrrhgtrdhinhhfohenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JrNBZmXwRY-Vn1zrlUtKjgx8nv-ED54AtZ1hv-aE1Rm4uCPE-3Azcw>
    <xmx:JrNBZiiFwU5_AN2mxY6BPxKM-8oh2dsXb4V5kIxO13vG20eieAjcPQ>
    <xmx:JrNBZmBmKxOJS99TldUgsJ-6bavERdDqzvEFEeUFePrKSWzYU0lZSw>
    <xmx:JrNBZjJz20i9RH06b6viojlbd1E8zT5iVwK_PQajA4gx44Cbi3lGAA>
    <xmx:J7NBZnK23GcGtP70w5i2dAGNsHPEpY_PaKjWFHGzo8soHErQTkY_28KT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EBA14B60093; Mon, 13 May 2024 02:28:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11bd3fe9-302c-4554-886b-f4a883f8de36@app.fastmail.com>
In-Reply-To: <ec4e905b-030c-43bb-818a-f4a0299597f7@paulmck-laptop>
References: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
 <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
 <ec4e905b-030c-43bb-818a-f4a0299597f7@paulmck-laptop>
Date: Mon, 13 May 2024 08:28:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>
Cc: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Matt Turner" <mattst88@gmail.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Ulrich Teichert" <krypton@ulrich-teichert.org>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Content-Type: text/plain

On Mon, May 13, 2024, at 06:03, Paul E. McKenney wrote:
> On Mon, May 13, 2024 at 12:50:07PM +0900, Akira Yokosawa wrote:
>> On Sun, 12 May 2024 07:44:25 -0700, Paul E. McKenney wrote:
>> > On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote:
>> > So why didn't the people running current mainline on pre-EV56 Alpha
>> > systems notice?  One possibility is that they are upgrading their
>> > kernels only occasionally.  Another possibility is that they are seeing
>> > the failures, but are not tracing the obtuse failure modes back to the
>> > change(s) in question.  Yet another possibility is that the resulting
>> > failures are very low probability, with mean times to failure that are
>> > so long that you won't notice anything on a single system.
>> 
>> Another possibility is that the Jensen system was booted into uni processer
>> mode.  Looking at the early boot log [1] provided by Ulrich (+CCed) back in
>> Sept. 2021, I see the following by running "grep -i cpu":
>> 
>> >> > [1] https://marc.info/?l=linux-alpha&m=163265555616841&w=2
>> 
>> [    0.000000] Memory: 90256K/131072K available (8897K kernel code, 9499K rwdata, \
>> 2704K rodata, 312K init, 437K bss, 40816K reserved, 0K cma-reserved) [    0.000000] \
>> random: get_random_u64 called from __kmem_cache_create+0x54/0x600 with crng_init=0 [  \
>> 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1 [    0.000000]
>>                                                      ^^^^^^
>> 
>> Without any concurrent atomic updates, the "broken" atomic accesses won't
>> matter, I guess.
>
> True enough!

On the other hand, you would get the same broken behavior on
any SMP machine running a kernel that has support for EV5 or
earlier enabled in a multiplatform kernel. It doesn't really
matter if it's running on hardware that supports BWX or not
as long as the compiler doesn't generate those instructions.

If I understand it correctly, simply running rcutorture on
a large alpha machine with a 'defconfig' kernel from the
past two years should trigger some bugs even if you don't
run into them that frequently on light usage, right?

     Arnd

