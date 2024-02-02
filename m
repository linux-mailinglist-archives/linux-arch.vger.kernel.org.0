Return-Path: <linux-arch+bounces-1989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F86846945
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 08:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6728C182
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC691799F;
	Fri,  2 Feb 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eprMJ04E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tx2jpuRx"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552B1799B;
	Fri,  2 Feb 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858889; cv=none; b=VB5bRquuv2Xpxqey2aoqvA7qXLnBiQ3db9WhbBkEIfaw58evbocgOcLyc3QlQJL1u6FcpRz5lNIi90QSPR3kbqURwICRvpVy16HoLYGKij9j/Vk+KMz0zczBb98WxO9SkRYC0YkFUX2Yj4cbMsWl6q5Eg0xPEcd7tjVhzeBfRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858889; c=relaxed/simple;
	bh=qzWs7s2cjCDmOtXG5wsxz7DfTUlVvOtF6j0Zrjbgr1c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QEudhAQ3RaUVAUmh5+Z28GuwPZQ6vlv8QD4QQsM/6OJd8+rXXnitLyBFERH4rJGKsyeDxApPBrzCL1aY+zm3z809tgwTDbmPQYg9nDKQqjBa4GJAPi9n0pdstpjzOI6FeTxRQDK+pHvfucp5P7iGY6cNtaKjCundq9lpo/yS0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eprMJ04E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tx2jpuRx; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B2F3E5C015B;
	Fri,  2 Feb 2024 02:28:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 02:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706858885;
	 x=1706945285; bh=IBhqBcxYgArhRS7kDjbkPgkUVZMe8vXWLNsnaVY75NY=; b=
	eprMJ04EiYCWlFcEeNIqGZhp0qteiNOVp5xwxMRhruh13A+1lHAv14LGC0mgYfzQ
	DNoKWiZlvG1DpONyKEAeXwbYZGC7gahiGm6RryFrS2/OBT4GvOfea8xVSmJetlDU
	oCM5FoDhTnIcn9xx2sw8EPkQAuiZf1Gy1s6rKGHTxPLd0q3YUGu8A6maWGfzlPr/
	Ar6N2/yBu9G0pJybx16suvWI/7En9wkR36rOhvYFZwEM2ImIrmOg1+XT0M8nR9Cq
	AhaFZW5Rrl8AQYxHZgpjs90T/1s7i+nhHQvMjqyg5WnGHE7o6EwxBvgSl9ow/Ydh
	IYkI0t9epQnLiW696GDpWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706858885; x=
	1706945285; bh=IBhqBcxYgArhRS7kDjbkPgkUVZMe8vXWLNsnaVY75NY=; b=t
	x2jpuRxZFTXsR+uLz6RFaAik9Xok8AF/8AFgu+VBnBy3I6BdakGBCKoz54E3plrn
	wMkr++6acBGqXmZAFGwGjo4TKsfdb8yHAI95XcgUrVAWIp83eYeu/LK0i4iBemaU
	PnAF6Xn4RgUnGCavBwbeFAie31CWTN+GT21PBmFxj1kgnYi9sWPzam2UR15N3D9u
	A21tl7DW6JA4ITC6mrEfnMs2kEmxQ9RX/II0S2i7qH9QI1oEI3kUghAmfz+0+NtJ
	XiTd08wRwcDJlVYzJnVtEchE3W4i4Ab91pXUurS49WMkwS4hKeiGN1fmQJKMMCMQ
	C7eDadqSNO4RpTqhlVSsQ==
X-ME-Sender: <xms:hZm8ZXvvbRMfzy7svCN_sNXsMryR7yOUCKvADPtNBiNpwJTqNJ9gUQ>
    <xme:hZm8ZYeVUcLy6HrRYn2WaHFtmUqRcPuCJBXPKO5OkSfjQMPruhFi5HK7EnEZfSUTH
    DDs3C9FgpVM3F4BMWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeghefggeduuedvvdfgiefgffehfedtffdvvddutefhvddvtdfhgfetveet
    ueevheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hZm8ZaxM6OoRWhGpL46GEYaSFCgq_sk_6uSNzNWdPyfhmGmo5ezeSQ>
    <xmx:hZm8ZWOZPtWitIYGcNKjrQDCCto_K7L_mm0vgtGwIOx_tOpqWoZxGQ>
    <xmx:hZm8ZX8F_oaT9NFnhztJSzuwMFsM0pTfXiP2eh6CE_zukT4WrI8n_A>
    <xmx:hZm8ZY31fPDy9VGPiAfoXQadB8awDZtcoPBLELb-3nXF9sqEvCBZQg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 18AA0B6008D; Fri,  2 Feb 2024 02:28:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38ad9807-a298-44f6-88eb-4fb8047eafbe@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdWPToeXdcBWv2LJuu2Z6td-JYz3GGf5fD1+ScqVD+Wurg@mail.gmail.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
 <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com>
 <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
 <CAMuHMdWPToeXdcBWv2LJuu2Z6td-JYz3GGf5fD1+ScqVD+Wurg@mail.gmail.com>
Date: Fri, 02 Feb 2024 08:27:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Yan Zhao" <yan.y.zhao@intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Stafford Horne" <shorne@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024, at 11:46, Geert Uytterhoeven wrote:
> Hi Arnd,
>
> On Thu, Feb 1, 2024 at 11:11=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> I think it's fair to assume we won't need asm-generic/page.h any
>> more, as we likely won't be adding new NOMMU architectures.
>
> So you think riscv-nommu (k210) was the last one we will ever see?

Yes. We've already removed half of the nommu architectures
(blackfin, avr32, h8300, m32r, microblaze-nommu)  over
the past couple of years, and the remaining ones are pretty
much only there to support existing users.

The only platform one that I see getting real work is
esp32 [1], but that is not a new architecture.

     Arnd

[1] https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-6.8-rc2-esp32

