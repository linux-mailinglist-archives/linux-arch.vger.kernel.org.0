Return-Path: <linux-arch+bounces-12593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A019EAFD056
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jul 2025 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209321C210AE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jul 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208E2E426F;
	Tue,  8 Jul 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H6/bnwit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+YFsz4K"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4B22FDE8;
	Tue,  8 Jul 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991056; cv=none; b=Iz+frlCFFCa34ZXMZemY/DBbk3M6nUJ0lRURQgh+mRbXFPulCYxZ5Vebk5BgAOtlTObmlWpiBMMTGC7az8J1ZzCW6jDwjRvOsx2THzhQ0f62bF9ZIPUfB9ywud8QOhXxsO3Mt4j428I3Wc8XznGOQDZwpFvwjj7eSeeQrpCIGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991056; c=relaxed/simple;
	bh=YDlJRj8Eioq/1zrSvVxYfVdlOp9tOKFbvFgfSG2MT20=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C6RNpBGArv07JsWFpqwuLVfI7y92kAZBhjW2QbLOTXkYE4J7r2aY5lIGoF4mgAcetVk5UlGFH2GvAAvSmP3k1muTg2C/SCBmO73Ge17Fxs5bsqWSo0w93HjU3aVk7mkEHkOeJjP2wi2U//uN1Rm7RikjHw432EV8cqKx4ZSYE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H6/bnwit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+YFsz4K; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DB7D14001FC;
	Tue,  8 Jul 2025 12:10:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 12:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751991053;
	 x=1752077453; bh=I+gwg1nh8AA6RawodcdsYVFpushDVY0A4ZD+VOA3xZA=; b=
	H6/bnwitxgpJEBIr68frASiwuqoIWFZC+05hVkP8+svrOco6RVdtpM7RdM6DRS45
	RHal+IKA+Px4f8X/K6mX+d9srrfxY9zJ5z19UnI6gwhm0WVz5afw9m6wdtw8R8Ky
	WzlFKmzsuopN+HBiPZVVNpXYX55oNelsjiIWUJm0dL16BTzjEkSFpu+rGD57ugVv
	CMCJ3pSzyeVr8+7uB4E1WbeNU0HxjfYKwgN58cSD4ofywYI79j54ebKMsEk03/qj
	OUJJY0+ZSwLn24P4SNR3zZCnh0FuuDWkC5yyVfQNQjbSwH+54Q0GHWswFrjSKP4o
	wMr6Ii99BQEsnHVBYr769g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751991053; x=
	1752077453; bh=I+gwg1nh8AA6RawodcdsYVFpushDVY0A4ZD+VOA3xZA=; b=d
	+YFsz4K3gR6nDCHzxDEMnrZTYqBv84cXyWjEyw4xtIhOifcaNEV/tHBhh0h7DTYD
	DN5R/P9WJV7PVSKQdm1BbrPwA5Em2km5NzT6EpvcpxxB7ibFl8IarctLKFseGHP3
	0T53dOpwFz1B5CuP4V5xkS3zkqyDBUrHwN6wc7/ahNUAU/uESNE0KbI164LhMGGz
	8Q50OhqLdHkYWGhxRI0Ch22D5kP0EZEo2K43aCAX+nb1TyhG3WVrjICZl/pT8pOH
	pmeaWxeUa8vXQlpZznXv0+mEfGY4WV3Wl9sZuHBNDpE9Si7CVvhFADduh6DMLXkp
	asUHJOVGcZ4oe230qlcpg==
X-ME-Sender: <xms:DENtaE0rF-rwTepm92dAlS0geD4nB3aCpcz426g5FlFMX_K5uEsynQ>
    <xme:DENtaPG5tnW6vYi1u1WOXucDH0DzsyLCedqlC34uJaIq8qd1GoJNhC7zcrDzvsCB_
    _HJAfp9xAtuMlqkmno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheduvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:DENtaP-74YN1bE9Ic220HsZi_eECeqj9Hn-9mhr3P5Wt9A0AN4SfGQ>
    <xmx:DENtaDkww4FicqYSpcv0wLv59DHm2TXacR9qdq3jZu3LetXY1BPh-Q>
    <xmx:DENtaMYdrjOG5-wGSA6anArF0Q92ydnc8ljwCqpn7zjv8ltwyYPwVg>
    <xmx:DENtaDMZvKq52HpndEM9SeHjiilo9_gxHodtlhnrHNBNvO79JJgUpQ>
    <xmx:DUNtaJ_0v2Nbp76kpIefnmKD7qdkhAf6mWRLqWHaTUGcjsp5rE0TYoJq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B034F700069; Tue,  8 Jul 2025 12:10:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1067a3d3a42d0b8a
Date: Tue, 08 Jul 2025 18:10:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc: "William McVicker" <willmcvicker@google.com>,
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
Message-Id: <746ab617-4db9-414b-a250-06adeb618b8b@app.fastmail.com>
In-Reply-To: <aGzp5esx1SpR9aL5@mai.linaro.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
 <aGzp5esx1SpR9aL5@mai.linaro.org>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the framework is
 initialized
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 8, 2025, at 11:50, Daniel Lezcano wrote:
> On Tue, Jul 01, 2025 at 09:52:45AM +0200, Arnd Bergmann wrote:
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
>> 
>> I feel that this RFC by itself a good step in the direction we want, 
>> so Daniel should go ahead with prototyping the next two steps:
>> adding the platform_driver registration into OF_DECLARE_PDEV,
>> and converting a driver so it can be used either with the _OF_DECLARE()
>> or the platform_driver case.
>
> I'm questioning the relevance of adding the macro when the driver is
> not compiled as a module.
>
> The first step of this macro is to allow the existing init functions
> to be converted to the same signature as the module probe functions in
> order to share the same code and take benefit of the devm_ variants
> function which will considerably reduce the code size of the drivers.
>
> Then we have the following situations:
>
>  1. The driver has to be loaded very early TIMER_OF_DECLARE_PDEV
>  (MODULE=no) the function timer-probe() is used
>
>  2. The driver is a module_platform_driver() and MODULE=no, then it is
>  built as a builtin_platform_driver(), we do not care about having it
>  loaded by timer-probe()
>
>  3. The driver is a module_platform_driver() and MODULE=yes
>
> If we do the change to have the TIMER_OF_DECLARE_PDEV() adding the
> platform_driver registration when MODULE=yes but using timer-probe
> when MODULE=no, we change the initialization and we will have issues
> with timers needing resources like SCMI clocks and where the
> mechanisms rely on EPROBE_DEFER.
>
> IMO, module_platform_driver and timer_probe must be separated.

I assumed that the entire point of your work was to simplify
the code when you have both a early and platform_driver based
probing in a single driver.

> Let's assume the one possible future use case with the VF PIT. This
> timer is only used on ARM but now it is also supported for the ARM64
> s32g2. For the first platform we need it very early and in the second
> case, we need it later because the architected timers are there.
>
> We should endup with:
>
> static const struct of_device_id pit_timer_of_match[] = {
> 	{ .compatible = "nxp,s32g2-pit", .data = &s32g2_data },
> 	{ .compatible = "nxp,s32g3-pit", .data = &s32g3_data },
> 	{ }
> };
> MODULE_DEVICE_TABLE(of, pit_timer_of_match);
>
> static struct platform_driver nxp_pit_driver = {
> 	.driver = {
> 		.name = "nxp-pit",
> 		.of_match_table = pit_timer_of_match,
> 	},
> 	.probe = pit_timer_probe,
> };
> module_platform_driver(nxp_pit_driver);
>
> TIMER_OF_DECLARE_PDEV(vf610, "fsl,vf610-pit", pit_timer_probe);

If you think we still need a module_platform_driver(), I would
not bother adding TIMER_OF_DECLARE_PDEV() either, as the
probe functions can easily be shared as well, the way that
drivers/clocksource/renesas-ostm.c does.

The only thing that would lose is the ability to call devm_
functions because the device pointer is unavailable here.

> If we change the TIMER_OF_DECLARE_PDEV to a macro which relies on
> timer_probe when MODULE=no, then the "nxp-pit" on the s32gX will fail
> to initialize because of the SCMI clocks not ready and the routine
> won't reprobe the function. This issue won't happen with
> builtin_platform_driver

The way I had expected this to work was that TIMER_OF_DECLARE_PDEV()
always registers the platform_driver and just skips the
section magic when it's in a loadable module.

    Arnd

