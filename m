Return-Path: <linux-arch+bounces-13735-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E875B973D9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7655919C5591
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090372BE644;
	Tue, 23 Sep 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="4iYvt3am";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nfi1wlRm"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93118027;
	Tue, 23 Sep 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653501; cv=none; b=ivEUOCeAMyj8V3R4JUpAiFji1v4ZxVO2+Se9z5me6jHezYb9QjKXXDZu641iHuXYnWXFeVWR+YOESSgy0XcynZLWPBAgfA5wAxYyaELn6IKalquD5DXIbruF6EZ8zaRkl7Kah/Ud/o1x6qSlkgODXf2MNUiEdWUVr/p0PWE/ouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653501; c=relaxed/simple;
	bh=m0dyoF3zbv516aK2r6Iw20+GBOGP3Nwqr5IcT5qfttc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P+t6jkjcljk6lr8fJ2GA+gMnRQOn38B119CWL9A5r2Mfn44RdXBwhAw8W/ZlZTEmWC447dYP8zxCNE1jF+ji8C3ig0rQ0MemallUorz8IBdgzwWlMADLtm62q3TEjPLV5wja8qTDefd4TRno7T7KPLe7yzVHz/8Ewy5sp0tkq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=4iYvt3am; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nfi1wlRm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E19787A01E3;
	Tue, 23 Sep 2025 14:51:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 14:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758653498;
	 x=1758739898; bh=lmf2MPQeiwJsAwtLP2v5pSNutJHWBNm/aiiaZc+tP84=; b=
	4iYvt3am4dDjecetJmpP7NM6jm2VaJZPHdE/6j5qNIaso/URWs4m++GO5uy31o2J
	21wnqrnJ+7sFWH1nxLC8uOhVAvp9ry0HeEuBJo/+O+brl/naFv4PWNXHmntMYWlO
	xGeEFs3y15Bz/W1GdB2cxMW0BtvJF+lzd+WuXL9536dtvDMaG2qYCIdx6HVfqfap
	wUr+cU2t849eML9sA29VjJ2Rzm09VQHexK9fLgEu9IizJTAGbtxqZaZXbsWVtjC9
	28aNTzDj4IKiofjP5ezxA637WWRu1xI/cbSOvN0LRau/X0BlKCnUDcNz6aPqjeX5
	Maqds4OauF5iLsGeU7vY0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758653498; x=
	1758739898; bh=lmf2MPQeiwJsAwtLP2v5pSNutJHWBNm/aiiaZc+tP84=; b=N
	fi1wlRmhRc1pKrk5aQTnBpJQ7uMjxXcikr0G1JpxQfnloNlTuIYq7tMPcd8L8cAK
	LSzt0TgkyPJca7G9mft3+3ZgYNwSOpSxR+IAO+2fngXRAS2o/8TOV+sQsiySlsIQ
	+DnbvXn9hZfk/HStct2K1ZaWnVFe81nXRhpweDX0paEIZ5GZCQPVklAerrIRTeyr
	+hOMrrwPSwqckOqflloGOUGiLWZlwxwyzghf7HRnBQortOINYjxQHZ0lzPulZdO1
	tpEcyZaLZyWfgm+Je9kPLX0WFnE3YftOTNlDoEg1Uc+/FE7JiqMFS66jOkfJVGhz
	cKWztcMGS4X75PR/ChTVw==
X-ME-Sender: <xms:OezSaLUDIbvpiCUzGA7ce962ySuhoSMt3VLSskyS8atjkW-ZmuAvOQ>
    <xme:OezSaOYFzpIpEAVCIlnF6gB18r5CM6Sc1Q6IMY5tNatwoqahhk5iTREq6AiQ9mgb6
    1CA76ctiQ6AIKcfG--HAZPNwHmypM-lTWz4OV4Mf5Fs5CKYWjtuqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtg
    hpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnthgrrdhg
    uhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdrshhimh
    gvkhesrghmugdrtghomhdprhgtphhtthhopehrrgguhhgvhidrshhhhigrmhdrphgrnhgu
    vgihsegrmhgurdgtohhmpdhrtghpthhtohepshhhuhgshhhrrghjhihothhirdgurghtth
    grsegrmhgurdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhgohhuugesrghmugdr
    tghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghssegrnhgrlhhoghdrtghomh
    dprhgtphhtthhopegsihhllhihpghtshgrihesrghsphgvvgguthgvtghhrdgtohhm
X-ME-Proxy: <xmx:OezSaK2PRjsvapyaVhaiJFjPFm0xxDyxNB8kLn988afpOOQE73pEwA>
    <xmx:OezSaPvZka9D2kdZrWN4DtB_9aDLDiGI734audr5bPNa_V0qAvUGTA>
    <xmx:OezSaCYAb8Ikf5A0WQpK_tI2mKOuXJlAZ2YeuHLgjtACQ-HU9_-FZg>
    <xmx:OezSaNIn80nRVoEzDuc83gmGPbIw6d75Rh-Wj5EUEm4dJwl4ssbE7Q>
    <xmx:OuzSaMzP4FJYnq2wSBvS22jGwixsuPQa5aRoWHk_BzAKbJcHG_kOzG68>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A93270006D; Tue, 23 Sep 2025 14:51:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0nVfrWCY5as
Date: Tue, 23 Sep 2025 20:51:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, git@amd.com,
 "Michal Simek" <michal.simek@amd.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Frank Li" <Frank.Li@nxp.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 tommaso.merciai.xr@bp.renesas.com, quic_msavaliy@quicinc.com,
 Shyam-sundar.S-k@amd.com, "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Jarkko Nikula" <jarkko.nikula@linux.intel.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-hardening@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Message-Id: <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
In-Reply-To: <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo()
 and i3c_writel_fifo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 17:45, Manikanta Guntupalli wrote:
>  /**
>   * i3c_writel_fifo - Write data buffer to 32bit FIFO
>   * @addr: FIFO Address to write to
>   * @buf: Pointer to the data bytes to write
>   * @nbytes: Number of bytes to write
> + * @endian: Endianness of FIFO write
>   */
>  static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
> -				   int nbytes)
> +				   int nbytes, enum i3c_fifo_endian endian)
>  {
> -	writesl(addr, buf, nbytes / 4);
> +	if (endian)
> +		writesl_be(addr, buf, nbytes / 4);
> +	else
> +		writesl(addr, buf, nbytes / 4);
> +

This seems counter-intuitive: a FIFO doesn't really have
an endianness, it is instead used to transfer a stream of
bytes, so if the device has a fixed endianess, the
FIFO still needs to be read using a plain writesl().

I see that your writesl_be() has an incorrect definition, which
would lead to the i3c_writel_fifo() function accidentally still
working if both the device and CPU use big-endian registers:

static inline void writesl_be(volatile void __iomem *addr,
			      const void *buffer,
			      unsigned int count)
{
	if (count) {
		const u32 *buf = buffer;
		do {
			__raw_writel((u32 __force)__cpu_to_be32(*buf), addr);
			buf++;
		} while (--count);
	}
}

The __cpu_to_be32() call that you add here means that the
FIFO data is swapped on little-endian CPUs but not swapped
on big-endian ones. Compare this to the normal writesl()
function that never swaps because it writes a byte stream.

>  	if (nbytes & 3) {
>  		u32 tmp = 0;
> 
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +
> +		if (endian)
> +			writel_be(tmp, addr);
> +		else
> +			writel(tmp, addr);

This bit however seems to fix a bug, but does so in a
confusing way. The way the FIFO registers usually deal
with excess bytes is to put them into the first bytes
of the FIFO register, so this should just be a

       writesl(addr, &tmp, 1);

to write one set of four bytes into the FIFO without
endian-swapping.

Could it be that you are just trying to use a normal
i3c adapter with little-endian registers on a normal
big-endian machine but ran into this bug?

     Arnd

