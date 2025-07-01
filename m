Return-Path: <linux-arch+bounces-12525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C112BAEF02E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5CB189EBCF
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26B1F428F;
	Tue,  1 Jul 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fQvKWJVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSKx4sNM"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E51263F30;
	Tue,  1 Jul 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356455; cv=none; b=orfvOII40x1UR6j4Fos2ilJl5Kev/yRYKBCOprquT+jpRQgxQmCHVrxiRN2cbVGI+i1X3A1wDEjbCemC1r7uK9AO7FSBWPk7dIVMn81uUDUkTEfF3UZ2DTBZOPvdSgGJMzcKIpHGroOph/zSi0idGyNu4GJfw6PjwcJea63S6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356455; c=relaxed/simple;
	bh=h+G1tTJ0bFf9zk0gY6dlDAUz1LYkXgQlPfSzWe/IUJg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G2frK6YnRuIBl+9wthC6HWbrh3tvFuvcUi769AGFjiFZjdYKB2r82FbjxJ7lihj1j/851nASUEwF15OwgW187+9p1zknSL3oUB1l6GqR6W6zYc6N3J7sIkXt4O9qeNR7nqx/N/ZxTb2hCQD6VxC/qx49nCfNHRKtr1qtVH7jh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fQvKWJVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSKx4sNM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BB3CEC04B8;
	Tue,  1 Jul 2025 03:54:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 03:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751356451;
	 x=1751442851; bh=zYIM/y5KUb8LuLsTwnFRYfBitpCmTyytEVjI+bZcC+M=; b=
	fQvKWJVy2F3XL9mrW/NsX/znHcPnnTFslnWBNBlOamy2LW4SuQaEyFVZxZP0TPGL
	h24EJEbr2R0HrUPO6hUYxeDCUpwbWANk3gaCg3BndYUyUY3fPMm/kt3lyQQbsY5B
	Qgffs2amWH6K5UtF9OGJo8DsHytlaLgajonYKqzKvEYBzr5MKTy2/d1fS1Rv1hjN
	Tqrlxr8Pjl/EYxhzvJ6LY64woUgvSJlZmckvcn7146lOs3CA/otzxs/21jlY6Knr
	nFjmawuOv9oNUD28wJFbb2zGfCayZDb8lUWzo0pXx/kjfYnTb7ySCL5x+TgnZcvE
	oFuGYjWsu0/XCzgXZfhXrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751356451; x=
	1751442851; bh=zYIM/y5KUb8LuLsTwnFRYfBitpCmTyytEVjI+bZcC+M=; b=V
	SKx4sNM2UGFbEnljcl6Y58fity3E1hqrLS2cdYU50g5m1XH+4Gy2iI0xOiyY64Pm
	l37XCLysJd9arB8gs9uTuZrDirMv+maPlHY4Q7hOrHvDhRUJjHmLcPE0kY7/vniy
	4Cgbh6PwaCafaGgMKkjIXRPbi1NreRcRoQ7JkJqVt6bW06luGBghN0V8K3F9v8p1
	b5CNYMY6UKasWTV+D8qEyjvgmPVHpKZJo6YAH6rQLa1CqxwF6T8tM+hLv27Jhhmc
	ZI23FoaPD8LEUFm8/AW8NydgIgKjIkbZDvIzY34cyVZvN+tyCoL72tXbFrUV5FqV
	mpolCCIdrGzm8RbS64b9g==
X-ME-Sender: <xms:I5RjaE9borZee998x-h_5WVKHMNTHkps3VnUh9PTj4kTa4i1KK1TWA>
    <xme:I5RjaMv285eOopSFmrNL2zt94807nqhXbs6RCRnSBPqIQpdxGpCQlqnQfCgLVRlIe
    sn4BocR7nYIyWkiZHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:I5RjaKDOHmfxwDXqz6reR74Lp2qNwZ0tnhwyINVohVBmr3SxDc0-Qw>
    <xmx:I5RjaEcmJRYHeoPYaMv99I6yPTutVSAhzTydwxd7tM6iGaMNlBxwlQ>
    <xmx:I5RjaJPa7OXiI8J-zZyOCzVZIr5DGUEDP2FNQM4KzV01AWhDT6QhKA>
    <xmx:I5RjaOm-oywwV26M2wEaJUVCX7K6ffXR310n0WndyUn81ud1BsCbDw>
    <xmx:I5RjaFXfvouvH1YOkUeI79muLG8uoWNYvYRRg5Uvn_zAB9nuADwzfmRR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05E2B700063; Tue,  1 Jul 2025 03:54:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1067a3d3a42d0b8a
Date: Tue, 01 Jul 2025 09:52:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "William McVicker" <willmcvicker@google.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
Message-Id: <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
In-Reply-To: <aGMjfxIvbCkyR5rw@google.com>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the framework is
 initialized
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 1, 2025, at 01:53, William McVicker wrote:
>> @@ -1550,6 +1553,8 @@ typedef void (*of_init_fn_1)(struct device_node *);
>>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
>>  #define OF_DECLARE_2(table, name, compat, fn) \
>>  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
>> +#define OF_DECLARE_PDEV(table, name, compat, fn) \
>> +		_OF_DECLARE(table, name, compat, fn, of_init_fn_pdev)
>
> To support auto-module loading you'll need to also define the
> MODULE_DEVICE_TABLE() as part of TIMER_OF_DECLARE_PDEV().
>
> I haven't tested the patch yet, but aside from my comment above it LGTM.

The patch doesn't actually have a module_platform_driver_probe()
yet either, so loading the module wouldn't actually do anything.

I feel that this RFC by itself a good step in the direction we want, 
so Daniel should go ahead with prototyping the next two steps:
adding the platform_driver registration into OF_DECLARE_PDEV,
and converting a driver so it can be used either with the _OF_DECLARE()
or the platform_driver case.

Regarding the sh_early_platform_driver code that Rob mentioned,
I think this one is already better since it doesn't duplicate
parts of the platform_driver framework and it interfaces with
device tree based probing.

     Arnd

