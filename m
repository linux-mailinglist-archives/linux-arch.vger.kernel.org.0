Return-Path: <linux-arch+bounces-13790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C9CBA3713
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273EF1C22AFC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122E2F5479;
	Fri, 26 Sep 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="yc/LWSgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADHVkpwh"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FF23D7FD;
	Fri, 26 Sep 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885025; cv=none; b=l5i7EXmXXHcVoRlXH8e4ECGKiNebbQFw0AJ4qIugdO9qingWn3+DlGiMrIpyMfNMPpJH+G3zTN6Ea9/6/y1VL3TNLWwHfql2phHLY0KuSc6qU0YzYEOabWX09+yq3l/nNdqtAnrGYQf38lxHQWIRA4OU0PlhFtoEW5oU5LTPrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885025; c=relaxed/simple;
	bh=h7WVqumuZ6rtpDNTZvXXkSxCTPj1sdwQ/ezqhU6wNLA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KGwh63h2JLeNOEscVyGB7qLC9FRK7w3z1THF0xi33frHOoYTJi6Ynk5i9efjq+L7wEbyBUh/Ufe8QNXwRydx+P2FcfyM/9icryjlhhaFj2UJwMDivoEXJPscOOJNgWoUi+k87DGCqL1OV+tncURLsoazKulMzb+gFEUuxCA0PUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=yc/LWSgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADHVkpwh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FEAFEC0209;
	Fri, 26 Sep 2025 07:10:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 26 Sep 2025 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758885023;
	 x=1758971423; bh=qRImFkmPF9+KEGIYvcQCn7PydMZrzs/++uOGJWkLiNs=; b=
	yc/LWSgFtYGtMEeLfmhIrfr4ItgbBs3CsbThTb3+IgcUmg8jX6rq+qfXKNH9udi/
	NG+dxggVGhGgf49CsGj4npoweYKoQxZ6rAUmczEYhYneKuIC3yD05GySeN7qAybk
	C8yG7kNxSHvpTgXEov2OxHXF4+e5JnZtFMLkeUVZ/IvAzFFTHE1TZsv5Zs+mMsr2
	7AMMQW0N01w2grhi/VojdgzcAtrjALMrsi53dGSo+ZlBG7pNcSEAvxohC4KMEldo
	UG0jW+QdjwhxQgC22iSNK6dP7jjnhTrSW0qfurP1AUsE7LZfNLSJTz4jEv9F2Nkc
	dnCj9uYszaZhbaxmGKnmNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758885023; x=
	1758971423; bh=qRImFkmPF9+KEGIYvcQCn7PydMZrzs/++uOGJWkLiNs=; b=A
	DHVkpwhmFgx7ipWNayKfjX9cdMnPjQrF1Le3j8dT9sfgRHaRbU1keRiebrtkPyYT
	DJUg2vA+kXlL5vJU09XiyR9CWzE01FTTlX522fpwcdqWp/2EtgN/86fjmVXag1M9
	Xa4/15kxerC1HXEW5Qm1YU4OQMksFCC7/TeJ4yJ7AjcHXg56Fo+aDGzYOxogQKTx
	DKAjx1jDdz3ewQz0PTRzHigD2VbGc8b2zAe+NaBHmPeDE+m/KiJuCzLW0w18k4++
	Ea23PSvCzVB3PJSco+8w+P/UBeJrQ+ShE2EUMF7bKsz5zWeYjR77nhvf0lgSCPDj
	ZFPelHy9lCYf7hJJY6rWw==
X-ME-Sender: <xms:nnTWaNu1PbmDIPSE8-LO9a9LrbwUyASxcw2jn0t5YMA_Lh_y7lvSeQ>
    <xme:nnTWaBQEHLxs3B0v6Lf5UqtHXjJ7KSkw3V5npIOHVBbSYtHz4lrX7Wvj7vBKCOfha
    oyaOfAqg44aMQleh5GZ3624FBpRAvyPGq7F3H7ZQjLfNz_twrJEosk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiledvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nnTWaINqgrfu7ds06QqsQqcUxBt_YjmHOoEhinvOegFF5lUdNRPpqw>
    <xmx:nnTWaBlL8qxklIHSjkW0IUkMfI0oGgz_7ThAj22UWK1q0BiPlE_0Lg>
    <xmx:nnTWaOwdyJUBk7WiJmTHZr4W5vAZzyl1iP_u4dkL7sH42kU1MDhHRw>
    <xmx:nnTWaCC5LH40aI3Ovwft2K0EFTi-n9pvPxrZonv6iXF3xX9BE_yPyQ>
    <xmx:n3TWaLpo9s07AFg8N68KeP8JXAiLMPS_hVtNzXWRvosyyZNy0W0PbJnC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 131A8700065; Fri, 26 Sep 2025 07:10:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANlaf4aDyzkw
Date: Fri, 26 Sep 2025 13:09:37 +0200
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
Message-Id: <93704e82-ea7d-45ea-8527-8ce92108eccc@app.fastmail.com>
In-Reply-To: <20250926105349.2932952-5-manikanta.guntupalli@amd.com>
References: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
 <20250926105349.2932952-5-manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V8 4/5] i3c: master: Add endianness support for i3c_readl_fifo()
 and i3c_writel_fifo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 26, 2025, at 12:53, Manikanta Guntupalli wrote:
> Add endianness handling to the FIFO access helpers i3c_readl_fifo() and
> i3c_writel_fifo(). This ensures correct data transfers on platforms where
> the FIFO registers are expected to be accessed in either big-endian or
> little-endian format.
>
> Update the Synopsys, Cadence, and Renesas I3C master controller drivers to
> pass the appropriate endianness argument to these helpers.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I don't think this is a good interface, based on our discussion
so far, and I had hoped you'd change it the way I had suggested
with a separate function for the xi3c driver, so normal drivers
don't have to worry about the AMD specific quirk.

I think this should also avoid mentioning "endianess" in the
changelog and in the code itself, since that would likely
confuse readers into thinking (as I did in my earlier replies)
that this is related to using big-endian kernels.

i3c_readl_fifo()/i3c_writel_fifo() are already portable and
handle endianess correctly by using the readsl()/writesl()
functions.

    Arnd

