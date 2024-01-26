Return-Path: <linux-arch+bounces-1734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5283E335
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 21:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DB12857C3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD022EF2;
	Fri, 26 Jan 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Q12a/uNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DSGcaOuF"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1320B24;
	Fri, 26 Jan 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300238; cv=none; b=IHis4GNQjegZ4FQQLpi/azfMwl7WsGJn5pJRxHYNrZH3cwsmpGMJCx1JM5jUY3IwOIcwdkVB4QR74+zkjD2cB5SYNveEPBn97LBB9sAauR8odVzJFEcApg+4PCfNBaAInBM9V4zTXyQ+zN/55Jg/VnnsuXxTfAlyEPnVZz3xq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300238; c=relaxed/simple;
	bh=cYHtuArHRMirwJmit//qLZ3eHUilr1A2hgsLc1/fxA4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MPi/AUYibJT0mipp7DqusW+Ut5aClvWMxrsJDziBY1LUiOKz9MjS3px96n0BbTyC34n1TrxmOCHjaNULxCQSrOKAJOcekaQ3pppIiKi4op19f41MG4NNrppWMEr3t00v13AUl8ujTTHLPsZsGHzFC/unbEq4VWkODxZnlFqZTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Q12a/uNG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DSGcaOuF; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B7DBF3200B0E;
	Fri, 26 Jan 2024 15:17:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 15:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706300234;
	 x=1706386634; bh=z2A+avOaMKmRLkUsiKnEgnVKPzoq69SgtffOycodPe0=; b=
	Q12a/uNGznp2BLZdENbAOaFkfP5Z38OiBLG0M2JdOp0xaxATHgj+ZPREL85itC4O
	53f/7/KRhhwnNtVrSiEsJP0qRT/IDEIaFDSwlfXwJdSC2SXvjqflVOU5APQfcG+H
	Ah66Yq/9qAeZeq8FenouyrzQQ4gEP8P2y9FibtU5U1UIxhBwKh0pL+NBeSzkHPNV
	haeI2RRhaKvwAZqF1aflUy2FLmJcrOtJsyGpMfa5CZizbJ5AVuiy8vD6GLqKa3tC
	2LSfeS6FxVKwOgmxRs2aSveguEpwJcwlc5lN+5WjsJZjUGHTz8GSVp78Zwe8gr5W
	GiPalLDJJkNBfm21l0rvLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706300234; x=
	1706386634; bh=z2A+avOaMKmRLkUsiKnEgnVKPzoq69SgtffOycodPe0=; b=D
	SGcaOuF7y730z7+NR1qdYOZXgMCd8XPvFKne2mQ/oekgyDjdYxq/1MHAKPs306z6
	+zEjE1TjFLeczqCyrwtem1Ff2nQjY2y/7iIzcyE3ykQz9PFexGnHQrQyxKGSq/0Z
	94Ie559QNzL2ZVq047oEwbcbwQmDKilYRJIqa3y8NR81wBRiP3F5Zza8JSPe42oO
	1fJNB+rPRKHdX/VfLSxP4eRPzvct46sirIHxl3lyN/jUyD2fIxLRVtZH4YgQuVws
	p0aDv+wO+gXLii5DyyreIkWwLzaLz2zlAU8Wal4vsPyDz9t7D9xEeAQscxjU+pwa
	rr0MuU6dcrJTr4vfWlfQw==
X-ME-Sender: <xms:SRO0ZSMZzqRZ8lb2YYIiCyS-nOkNAG9ysQhBZ9TMaHPkWmXCkqNLMA>
    <xme:SRO0ZQ9CkCSsXQtlW3-oBlHG2DkzG3OmtUwJTgQvzTODi7iK6KzvD2qAmhE1KZocF
    AI3DV0-Tm63S_6rzGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:SRO0ZZTy-QuYBHpCkC9Rc-N0vDKScQzQQwHo7aq_oVvRwR0v0VPcGQ>
    <xmx:SRO0ZSutsObRgpNgpPz8Nf-7Yf2rJTpskWAUo1_41tsR4oQ9LBpfrQ>
    <xmx:SRO0Zachth5OLh3bDL-sxVaC9W86mBMwBEZq93r5w1X2YrgMKSI0cA>
    <xmx:ShO0ZW8QdiR716c9BzNj52CSOswsNd1WFZ_PnrgBYyIsfkpuXmghFA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 95048B6008D; Fri, 26 Jan 2024 15:17:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
In-Reply-To: 
 <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org>
 <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
 <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
Date: Fri, 26 Jan 2024 21:16:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Mark Brown" <broonie@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Andi Shyti" <andi.shyti@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>, kernel-team@android.com,
 "William McVicker" <willmcvicker@google.com>
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the device tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024, at 20:23, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 11:33=E2=80=AFAM Mark Brown <broonie@kernel.or=
g> wrote:
>>
>> On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:
>>
>> > Allow SoCs that have multiple instances of the SPI IP with different
>> > FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
>> > device tree property. With this we can break the dependency between=
 the
>> > SPI alias, the fifo_lvl_mask and the FIFO size.
>>
>> OK, so we do actually have SoCs with multiple instances of the IP with
>> different FIFO depths (and who knows what else other differences)?
>
> I think that's why we can see .fifo_lvl_mask[] with different values
> for different IP instances. For example, ExynosAutoV9 has this (in
> upstream driver, yes):
>
>     .fifo_lvl_mask =3D { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff,
> 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
>

That sounds like the same bug as in the serial port driver,
by assuming that the alias values in the devicetree have
a particular meaning in identifying instances. This immediately
breaks when there is a dtb file that does not use the same
alias values, e.g. because it only needs some of the SPI
ports.

      Arnd

