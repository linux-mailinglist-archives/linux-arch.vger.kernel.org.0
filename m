Return-Path: <linux-arch+bounces-1695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5183CE8B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203511F25DF8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82713A262;
	Thu, 25 Jan 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QK8SP0Nn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2sMW8cn"
X-Original-To: linux-arch@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876F13A253;
	Thu, 25 Jan 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218001; cv=none; b=bybJKuIwNwrEDG1n4185puD/OIb4jODL8C9icDeLhNQn9eOWg9weJZIXHpfRc3yH/tMSBmKgpvRNGX89jo4DYX508959/VeOAF8LEMFCsNH6D04VREoUAKLoGtpBeivU/s6FF2ytQ3mZM6DGimzDT0lBmOga+l7mriPbqA8SYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218001; c=relaxed/simple;
	bh=B/g0KfVrN0Gqw2KKiCNZ2MwRrOUESPX1O0BAPrvSEjA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=k+8WGAXJCFvq/RzwmM11v3VLyUpoY955gpZSX9AQ0cwN9LCuZkuTGQTfJ+rNHBF8O82uGHti4gV7snCofjLYJ8bPtr04yS9GWH8B1j3wPkA/fDoj8QS1LZpKKQ/9PPNqcr5LUpuBoOH9uR7hPXZ0BGR839eI0FPb5oms62xGpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QK8SP0Nn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2sMW8cn; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A406D5C00F5;
	Thu, 25 Jan 2024 16:26:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute1.internal (MEProxy); Thu, 25 Jan 2024 16:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706217998; x=1706304398; bh=qpZFUm5hoy
	UFSrZ1IxH2YPgLg1vDc0KKMVjTRgl2rig=; b=QK8SP0Nnse0H+PKqzFqPep9Eaj
	bFXXf5kjhp0BbqieJzJWYnxWIgyvg8HsOD39bYgIF+e4vTJn82B8CKgYZRf+AZdx
	MTYOWvDeO/W0at49Yu1e9RV/9V6xpHDfYki020xa0B7C3WKM+hHAWqjMOoVeVZoA
	fs7YZAhSMqi8XjJCMwenVuh6IYtQDvL9I5rINgrLsS/xdz+EI87khxKBiYY/XL+k
	bEJHaTtn5y98n+YeyLf/k+3u1pyXLbYRlv1O3QLf5W4QiZAe9wqRvMBKOsM/IE6Q
	au4QOp7IIsIBXMRZr6coDZsfVrGiMWfyyOLEsb4Ys/LzDvY0h5PfQoqsvLvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706217998; x=1706304398; bh=qpZFUm5hoyUFSrZ1IxH2YPgLg1vD
	c0KKMVjTRgl2rig=; b=C2sMW8cnE4/luDTxawebBPVlYXW16RsCLV4ctJZhaaYK
	VDwwwJmoAoBFA7kPsEG9uy1yM5GxmsKIlNfwmbK3+gr9Z3EhVIy/dzietHPFUukm
	pIj8YUTdaJdnJXj2zmSzmAI25Gyic96NSab/Td4xk3w83oRNo48TeQaW9WZAsfTM
	ut3ql2yLcnJE+7olFwqRl7G+mKp2iFkyvGdORNrlenQcEJ7c8MDL1dnXJ8xB2WcG
	rvV7YlC7F+OTjlspL/qbAQ5GoD+6zCvxw1QIp3AeekS/tiWmqOZlPD/Q9G7Bjff4
	pgTbmS0C/38BPcuv8pPnZXpZKzjQkSUBE28NY6Gz4g==
X-ME-Sender: <xms:DtKyZQdv4ugAirEr53Ddfnb5hEwiKXbAk4uKJ3WY5CvuL4Y6cUDA0w>
    <xme:DtKyZZKkPau6TiEpRYxZWelLmygMXFMLznkMrTWpS4qd6ldyLuzHoR8eZxFF7BPif
    0i0BwS0FjczD56yhpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DtKyZXKp1BlRrGpLl2j_wtnuVlGkXDDBhYgdoUQPH5q_Ew6voXwB5g>
    <xmx:DtKyZbESVomnS7EoKFMzRddRPuksuKMe5MNEOy8SJSAIpmYcEVWG3w>
    <xmx:DtKyZcnwwSgv-nFvLSPXv3uXKjSBpo36uKF6rnTTIlgYR4pckQfAzQ>
    <xmx:DtKyZSsDdHfxXbC4wk5AtsFKsmbUhk6GJLkb9tbPnhVoX9d5GEZS7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22736B6008D; Thu, 25 Jan 2024 16:26:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01d24044-6cac-4034-a9de-5b69c2dab139@app.fastmail.com>
In-Reply-To: <20240125145007.748295-26-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-26-tudor.ambarus@linaro.org>
Date: Thu, 25 Jan 2024 22:23:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Mark Brown" <broonie@kernel.org>, "Andi Shyti" <andi.shyti@kernel.org>
Cc: "Rob Herring" <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>,
 "Sam Protsenko" <semen.protsenko@linaro.org>, kernel-team@android.com,
 "William McVicker" <willmcvicker@google.com>
Subject: Re: [PATCH v2 25/28] asm-generic/io.h: add iowrite{8,16}_32 accessors
Content-Type: text/plain

On Thu, Jan 25, 2024, at 15:50, Tudor Ambarus wrote:
> This will allow devices that require 32 bits register accesses to write
> data in chunks of 8 or 16 bits.
>
> One SoC that requires 32 bit register accesses is the google gs101. A
> typical use case is SPI, where the clients can request transfers in words
> of 8 bits.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

My feeling is that this operation is rare enough that I'd prefer
it to be open-coded in the driver than made generic here. Making
it work for all corner cases is possible but probably not worth
it.

> +#ifndef writesb_l
> +#define writesb_l writesb_l
> +static inline void writesb_l(volatile void __iomem *addr, const void 
> *buffer,
> +			     unsigned int count)
> +{
> +	if (count) {
> +		const u8 *buf = buffer;
> +
> +		do {
> +			__raw_writel(*buf++, addr);
> +		} while (--count);
> +	}
> +}
> +#endif

There are architectures where writesb() requires an extra
barrier before and/or after the loop. I think there are
others that get the endianess wrong in the generic version
you have here.

> +#ifndef iowrite8_32_rep
> +#define iowrite8_32_rep iowrite8_32_rep
> +static inline void iowrite8_32_rep(volatile void __iomem *addr,
> +				   const void *buffer,
> +				   unsigned int count)
> +{
> +	writesb_l(addr, buffer, count);
> +}
> +#endif

This one is wrong for architectures that have a custom inl()
helper and need to multiplex between inl() and writel() in
iowrite32(), notably x86.

For completeness you would need to add the out-of-line version
in lib/iomap.c for those, plus the corresponding insb_32()
and possibly the respective big-endian versions of those.

If you keep the helper in a driver that is only used on
regular architectures like arm64, it will work reliably.

      Arnd

