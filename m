Return-Path: <linux-arch+bounces-9970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90CA25A5E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1519D164700
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D1204C29;
	Mon,  3 Feb 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Wlu6S2hJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcVjbAjV"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C499204F74;
	Mon,  3 Feb 2025 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588140; cv=none; b=eMpOIQhmcr/JKavlfuDJZyFewWWu2kZ23FgJAmSiK2HUMfDuIEA7EFgQEJO7BlhWgBn5ijAM54u9Lz2FrsUuyvW1+uXO4YD7BvcCZn+jmarInTN6RNBk1cTbE4VK25JHtlX4PtVhIKU118SPFmiZ/b7XuANLp22hNcI7B2FoZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588140; c=relaxed/simple;
	bh=+NwHHzB7CfXzPsy0HnohhfWy3Y5mQ9HH10z6NP2WYeo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wo8+nGCbkvr73vUueNMrzEPDGR83A9TTPLrIq8x6Naj10kXqIbXmzM+B7j6rqJc3YoTndPJTxCAREgSq/T8n6Pe6b33b9OWnu9mmqIpSpL7oOSR4KRoy39MV/RRK8/dFscPDSpjHetEpmaWBSYcmcwaNZgNjRTKLND51+7toNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Wlu6S2hJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcVjbAjV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C6A01140198;
	Mon,  3 Feb 2025 08:08:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 08:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738588137;
	 x=1738674537; bh=ZMwnP1Jj4y0bYniSzOqznHTLK7DvuIzD53X1nOSo2so=; b=
	Wlu6S2hJ3V6eae3giIyRLi4sHW45sZ8u+Y8Uq0BoVhbfm5uBS+rovaDuhsDGkmQD
	uc97vDi+A6++JKbIhQkOOMi6csyc3VXtHsbKOHIuztQH/KyT0BB+8z8b5afVHzBG
	KTWPw0WDmungyJ7i/6W3O1yE+gcm4+qYqKn5bi1AjC/VBiH3c0Yo8EgsqZgCSNSU
	a2k7JuuQZoYeAgubxqojAqP8wIUgHHz2nkZId9Ikem+epR/lFbxErNOg2GME2VEL
	v/wqDTuelkrUOIJcM9XsvbkTbMrjnlgbO8yls796MiAiLGAqcDFgm224/UFD8tbE
	jXG+oMPUR5fxB+tz1r5GrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738588137; x=
	1738674537; bh=ZMwnP1Jj4y0bYniSzOqznHTLK7DvuIzD53X1nOSo2so=; b=w
	cVjbAjVQzMzSozR0VuSKKFykHQFZPn/8gDkxs8XxZOIOPWWOalFAa5FqXZaKi4o5
	8p4GA64tvx0Oz7T3rJAq8p4qb1Bg2MfSAif6/iysBsj0WJ+YEDL7K0JJB7ssWRbn
	01ww4akOZyn23NNoJ8K5Vds8uSjphFOKAujX/dM3V7oShc/+eE5OOgyiJ63nvHIQ
	kQ+RGANwCB3NANratCcd+pxhYLxT5y1PMWppnTGiz2XXZPPk1OHSEEvvxVJmnV2g
	yH1ZM+j1H4VM36W3qzjKCbdgSh58tBwhKX20riZEoAveiRyYDBdub6+3dCeeRvwK
	0mw+UCLA71aT7nASfV3wg==
X-ME-Sender: <xms:6L-gZznE0UZbA7NVtk8klM7BS9ngko2W7lp36n3zfztcNpuKyLGdRg>
    <xme:6L-gZ23eHThm8GPlxIrWflEi29qWatazdmY9gpZP54BLzaVN7HACwpc0loMJIAo8m
    wjc6NKMLq2sqrEL1QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhueevudegudfgieffvddttedtieefveffgffh
    feevhfdvheelhfehheejvdffgfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphht
    thhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdifvg
    hishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghnughrihihrd
    hshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehp
    rghlmhgvrhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtg
    hhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6L-gZ5r6aURK0nBysX31y2R-VrWpmu8xIC-aKK1cxCCAAJUpRe6dpg>
    <xmx:6L-gZ7l7IS81coZAE0f60LVHy8EyVvfPXPytE0JEn5EuWgfBZoGc2g>
    <xmx:6L-gZx2oOd8Uky31v6NHQOTA4b1GwWywUhdtHAok05p0sbNt-FLSpA>
    <xmx:6L-gZ6s-OXpgKuY-g2r7KQDFl9jsJ370PCLcNE8NcTHFpVBmDByglg>
    <xmx:6b-gZ-ndHxekzEwbP0HKFjDJV6b8cACfCE51jgewYpH2yxvvWH8RzAuF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 423C02220072; Mon,  3 Feb 2025 08:08:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 14:08:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Kees Cook" <kees@kernel.org>, "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Richard Cochran" <richardcochran@gmail.com>
Message-Id: <96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com>
In-Reply-To: <Z6Cxan9WE38_x41e@smile.fi.intel.com>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
 <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
 <4d4ac954-16c4-4c85-995d-c7bb1e15b0ce@app.fastmail.com>
 <Z6Cxan9WE38_x41e@smile.fi.intel.com>
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 3, 2025, at 13:07, Andy Shevchenko wrote:
> On Mon, Feb 03, 2025 at 12:43:01PM +0100, Arnd Bergmann wrote:
>> In addition, these seem to be timer registers that may overrun
>> from the lo into the hi field between the two accesses, so
>> technically a 32-bit host needs to do an extra read to
>> check for overflow and possibly repeat the access.
>
> Yes, precisely why hi_lo is used to minimize the error when it races like this.
>
> But IIRC *_pch drivers are for 32-bit platform, the code, if so, was made
> to be compiled on 64-bit but never used IRL, just for test coverage.
>
> (I believe the PCH stands for EG20 PCH, I have [32-bit] boards with it.)

Ok, so we don't even know how that hardware block would read to
a 64-bit bus transaction, it might give a race-free result, might
have the same race as 32-bit or might just cause data corruption
(e.g. ignoring half the bits).

I think the usual way to access a timestamp in two registers works
like this

u64 read_double_reg(u32 __iomem *reg)
{
       u32 hi, lo;

       /* check for overflow race by re-reading upper bits */
       do {
               hi = readl(reg + 1);
               lo = readl(reg);
       } while (hi != readl(reg + 1);

       return (u64)hi << 32 | lo;
}

void write_double_reg(u32 __iomem *reg, u64 val)
{
       /* ensure the low bits don't overflow right now, assumes
          low word is ticking up */
       writel(reg, 0);

       writel(reg + 1, upper_32_bits(val));
       writel(reg,     lower_32_bits(val));
}

[If there might be concurrent read/write accesses, it gets
much more complicated than this.]

Do you know why the driver doesn't do it like that?

> I like the lib/* and include/* cleanup but PTP probably should stay as is.
> OTOH WWAN case most likely had been tested on 64-bit platforms only and
> proves that readq()/writeq() works there, so it's okay to unify.

Ok, I'll try to split it up into sensible patches then. For ptp
(both ixp46x and pch), these are the options I see:

- leave it unchanged since nobody cares any more
- add some comments about being racy and possibly broken on 64-bit
- revert your pch patch d09adf61002f/8664d49a815e3 to make it have 32-
  bit accesses again and fix the theoretical 64-bit issue but not the
  race
- use helper functions like the ones I showed above and test it
  properly

I also added Richard Cochran to cc, as he wrote the original
ixp46x driver and may know of other ptp drivers that have
this issue. One potential candidate I see is
https://elixir.bootlin.com/linux/v6.13.1/source/drivers/ptp/ptp_dfl_tod.c#L226
and other functions in that file.

       Arnd

