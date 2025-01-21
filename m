Return-Path: <linux-arch+bounces-9833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3DA178A8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200E4165431
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D061B414F;
	Tue, 21 Jan 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lsoifdUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wa6h0j56"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35D1B4138;
	Tue, 21 Jan 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737445323; cv=none; b=DZpmscuu0Ov/vwUoC+hyOQqd8oCGJvK7i2Y0mN0RtHqEAMyYFqrjD/++I2kVVoar3UTzSZbbhha6BGDqg5/5twneK4O4llDXhQmTpFRwRgLyYWp/CJwiq2ziEVZfUxf7RG/PCfepFszcfZp/L3V4kKVUuXOyQMo9wet1Yx7x88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737445323; c=relaxed/simple;
	bh=qsy6JmiVJF4S5wiCjBpb9sjc3adaXv95wl7FmfsQkGo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pNOwB7fRZSkj68tCV4LZeKtczGHmhp0/dyJz8HOz8Jx+FGUc6uhre7h1M++KJpDhIkr9DGAbD32eJVM1Y6eNkb9YJW/rHsuAWPA1RRr9LSarJKSWEjyLjGttQ3B3+kmix2HafyYrIc6f8w7zGgQAE880Tko6dExw2oK7PYaFT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lsoifdUU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wa6h0j56; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72B891140198;
	Tue, 21 Jan 2025 02:42:00 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 21 Jan 2025 02:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737445320;
	 x=1737531720; bh=9OiF7r3Rql105Zia0h2LASumVCmwQ5qUHnyz2aj97rs=; b=
	lsoifdUUj2RIajNgeyvBlEdL+BPY/yQCpMdJSPdBjDCQG3pPBQxMQApXz22sscRS
	RG4Ol8FAYUvckKdDZXO65nXlZRrhbCtqc7lxo88Ot8qoERmFBzTX3ZnJOUfx/U3J
	ireWOUpcA9g13ebOZl/8K0JN0bycoXHOmJUzxO9QNX6l5+sTC1MmJbiEl3f1CeTB
	kqmhi6HAcZQQcwytcCFGOdXmqIgVy7GtzRRq2YqvRJ4/7B71GMdpPeFznTXOgJAh
	ilBU61Y4i0KzW6tkrOkZPijHN1JAaV5dqAi4TZ1lqtpdCZpcstuA2xK1lHqAG5V9
	wo6GNQMa6mQaDG0B8UM3sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737445320; x=
	1737531720; bh=9OiF7r3Rql105Zia0h2LASumVCmwQ5qUHnyz2aj97rs=; b=W
	a6h0j56mcm7A+IXYqbD/KjUVoQXkYQuZxjhX+Igvw4JNjDFhkcna3R6nZaX/Y/y7
	e/lWYvXMCKXcTOZU/KAZLQqBuYCiY+DZT2He1rZjTvhvUhyd50JsN8eOeUzWjLrK
	yR9N3iDVcchENtbZbCOsHGdz6EAC/Ucm02IExiPATDktpL6cXDM60/FYFMOQriOC
	Fwo5u5nFQGCWPiqwI5nT2Hnpu1Lj8+tj0ThNBZ+3YHiFWaw89PuiU13V9HuEP9DF
	qNwbUpdTjPydx9y/StJFD1sOAMeUBSxb51AwPpfIt4loaLCCLwBvzHBwGONXtD50
	vijq5aMSfma1YHD5qgmHw==
X-ME-Sender: <xms:yE-PZ7cVbT7Fot3OtAXE1Lim99lvdJFVfOfIwM1-5euTtipaHP-eyw>
    <xme:yE-PZxPFnpQ8qFuAp7dK_fGT58eeIiEJYUCL2cAiFWytYOUD0tGNeSDb2jCZLa_EM
    UMntuq6-NBhcCUiq7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepshhhvghnhhgrnhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepgihurhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghsrghhihhrohihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:yE-PZ0hTjQs8sUsTN36JhFc9qax9FwFNRyLiykti_kwn0oqK-6E_jQ>
    <xmx:yE-PZ8-RQl9nTLraS_KGH5sFr-i6tKNQA1fDMTAW3FeY7CTPdYZ7YQ>
    <xmx:yE-PZ3vTb4fTLmEweJJ3JnB3TCm2h5x2NyTlSAr3tNuz-4euS8Hy-A>
    <xmx:yE-PZ7Ep6ELT25NvZ29poHaoobJ6uSsLh1s6c7cGDVd0xL-QjnoxYw>
    <xmx:yE-PZ7EKEFDzQj4xvtxl6ClaJh1cZSwPTmLtbxRQCbIyOfCQx_0vRhlH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 180B12220072; Tue, 21 Jan 2025 02:41:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 08:41:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, "Han Shen" <shenhan@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Rong Xu" <xur@google.com>, "Jann Horn" <jannh@google.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <fef7c633-5577-4cdf-803a-a1fe10787186@app.fastmail.com>
In-Reply-To: 
 <CAK7LNASo+wGhpCVhBi+ew1mOtLbSXgx3AiQ6D7RtXO5P=R0EfQ@mail.gmail.com>
References: <20250120212839.1675696-1-arnd@kernel.org>
 <CAK7LNASo+wGhpCVhBi+ew1mOtLbSXgx3AiQ6D7RtXO5P=R0EfQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025, at 01:19, Masahiro Yamada wrote:
> On Tue, Jan 21, 2025 at 6:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>>                 linux-6.12      linux-6.13
>> ld.lld v20      1.2s            1.2s
>> ld.bfd v2.36    3.2s            5.2s
>> ld.bfd v2.39    59s             388s
>>
>
> Is this problem specific to the BFD linker from binutils?

I only tried the bfd and lld linkers, but I assume it's limited
to the bfd one.

> Did you observe a link speed regression with LLVM=3D1 build?

No, the ld.lld line above is what I see with LLVM=3D1, it's
very fast (1.2s) both before and after the change. New
ld.bfd versions were much slower before the regression
for this particular config and got even slower (seven minutes
for each of the three vmlinux link stages).

      Arnd

