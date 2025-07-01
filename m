Return-Path: <linux-arch+bounces-12549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC30AF052A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 22:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D24448FE
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98F1302049;
	Tue,  1 Jul 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cNjFReID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgcqDESg"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641F2FEE3F;
	Tue,  1 Jul 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403349; cv=none; b=Vre5KKacURVzUta2OGwrSlTZw90ZlWPdVojQtsv5eAGQzEi8gk6qRyfuGP1dDSq0C0euSH1m58trxi0CdtKulmwtGzL3X2NQD5vgfWi0Uk5bHTwoL7MSK+tXHlyz0tWVW1Qjf5MhRAsU1WcLK2gaB6CdB9Xf7Kum8RbcvFlmxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403349; c=relaxed/simple;
	bh=LhtTLZghsQ2oCHBy62D6Fvso6IXy/MsuutcGw2uabx0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=afKISgmn4gWMi1LJIaXTiBtK9OPbq4PiAJd4OMYjHwkA/7d8v5jWZDQ2TVemaJ4JX7xghE70rYFnNFW+zJzmTEJ4sGVxsnzQTcrUxpKszrrh6GJ5h7ZsptphzBCDw0qO7GJF9w+pbV24D8J3xpmPZI2df/Zt4crjVAx+uePnWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cNjFReID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgcqDESg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A2931D00168;
	Tue,  1 Jul 2025 16:55:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 16:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751403345;
	 x=1751489745; bh=awBVC+wrhtAgL6C9QQzRkh67OL2Xmg4L+hYvay+T57Q=; b=
	cNjFReIDNA1JFdL+8vN71IV2PFUHIu51LPr0co0ZoBJ6FEZOq8avVTSmXBBvlOAx
	4RYPGHt4sNiHVu6shivKhklDchYQw5P4HJc8KBpBT6TBcuS03i9zQE6jj6HV8gbN
	FUP1WLZsBJA9tFHrW3l/YBbtlxDMgVDyl6QY0HJGObYprYl2xyRM08Y89MMJnkCW
	nv+u5hza1+S9udW910nVsgd3tCkEpJrphxikXeobtEzxlreB0L53qi/Y/IIlkjXv
	GlkTGanP/9WIuPHwNekEGRB64uQusJp4Unt2MQ49r5gy0Xre/o67J+C5sgyMC6M2
	+/gz+aw5n+OZADZgt+1KkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751403345; x=
	1751489745; bh=awBVC+wrhtAgL6C9QQzRkh67OL2Xmg4L+hYvay+T57Q=; b=M
	gcqDESgtP1JgmPC8iaRaUdNcGrqu+xDk0NQg8PAboAlK/7KMLtIACYlPEiOF3gvG
	iFGwrAQeYNbxlamEjklt98YPaFs9cgg8p02Wk4v/lun5MzV4EU2qHSDxoOykZ3mL
	ID5Vpu02u5OSDw4ju4axWt4faL2BTQQ4w/xb9u9y3MwTq3uh99PvvDwwccLArA4d
	oeNhr925978n4KnotubcHRSP+4okBpFF3HljXy+tt3RvUx2zVatun3GGIzWQkFb2
	G5ReK2qqxdf5FjHMVmvW5kvo0i1Z92HV4Kn9mafPSJOvk4DGuxM1OtBOoHT7sG0Z
	gfscw7qXBJ0WEzaTDsGOw==
X-ME-Sender: <xms:UUtkaIePeZhebY9xm0MNoE1uQT1tiqlhOnbts2SGzFeQ3w4O0zEgWg>
    <xme:UUtkaKOCH83z9yn46WSlf-UCwzw11p-Yk6VG0EM4dJ2mY_qCFAQ3SJx-8YWXFHUTZ
    5Pdw9A7rr5IrHEHc68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsh
    grrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlmhgtvhhi
    tghkvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrhigrnhdrohguohhnoh
    hghhhuvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggr
    nhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlh
    hishhisehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:UUtkaJhpbWUVi3vo4-tSapxC3EnYvhkLdRUm8TXe6jgUGGHkntAFEg>
    <xmx:UUtkaN_xd-lKV0UxghhPPvC2wb1AsNKinh9gHd0fVin2_P5TPU6ByQ>
    <xmx:UUtkaEsaOMOK947udcGvLrIgiPCfxlXm05VIFynBJ69OPpL_dS8-8Q>
    <xmx:UUtkaEEwjU4G6kIbUhrOB07Id-N-2B_OQmzJ9bt-cOjjMyUuxWca4w>
    <xmx:UUtkaA1O6D8mIKxEr_keeaStGwda-mTnw1edsUaY3Izda0Q2JZxKP6Hm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F07D8700065; Tue,  1 Jul 2025 16:55:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1067a3d3a42d0b8a
Date: Tue, 01 Jul 2025 22:55:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "William McVicker" <willmcvicker@google.com>
Cc: "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@linaro.org>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Message-Id: <92daf35f-9240-450f-a05f-b7869fafeb6b@app.fastmail.com>
In-Reply-To: <aGQnOMDyBckks78k@google.com>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
 <aGQnOMDyBckks78k@google.com>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the framework is
 initialized
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 1, 2025, at 20:21, William McVicker wrote:
> On 07/01/2025, Arnd Bergmann wrote:
>> On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
>> >> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
>> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
>> >>  #define OF_DECLARE_2(table, name, compat, fn) \
>> >>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
>> >> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
>> >> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
>> >
>> > To support auto-module loading you'll need to also define the
>> > MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
>> >
>> > I haven't tested the patch yet, but aside from my comment above it LGTM.
>> 
>> The patch doesn't actually have a module_platform_driver_probe()
>> yet either, so loading the module wouldn't actually do anything.
>
> Probing with TIMER_OF_DECLARE() just consists of running the match table's data
> function pointer. So that is covered by Daniel's patch AFAICT. However, it's
> not clear if this implementation allows you to load the kernel module after the
> device boots? For example, will the Exynos MCT timer probe if I load the
> exynos_mct driver after the device boots? My guess is you'd need to register
> the device as a platform device with a dedicated probe function to handle that.

Yes, that's what I meant: the loadable module needs a module_init()
function that registers the actual platform driver in order for the
probe function to be called. module_platform_driver_probe()
is the way I would suggest to arrange it, though that is just a
convenience helper around the registration.

The platform device at that point is created by the normal DT scan,
so there is no need to create an extra one. On the contrary, in case
we successfully call the probe function from timer_init(), we end
up with two separate 'struct platform_device' instances 

     Arnd

