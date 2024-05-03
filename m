Return-Path: <linux-arch+bounces-4167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7271B8BAF5D
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985DDB20D4A
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739C482FA;
	Fri,  3 May 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lK7TLf8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3ZL6Ft9"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDE57C84;
	Fri,  3 May 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748767; cv=none; b=Y0w7+qEmDjMZxhFi/3cr7WJh2ld+89YAZPKHNCKh8q9RCLD8YNEr7ag0/VExnIX+nXjQ+JkyyVHwDlQZQIoXj65jGvdvnI134GLWcnQVm5YUDm23hO0cW4jGBV/jsTbj5Hqx2NKF8ifTMif4fSBXmTt2wckz5h/Yr4iaXC21SKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748767; c=relaxed/simple;
	bh=JnpGwDMbq5BJ45XOyGa6afSjXzlIb4yHoH5QASjnFbg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eC0/JgH6s5wLqAPScd48Usz86wIbSaG878loGQxEsK6KyWNjcfFmhkskXzLQTLodtLE8etuE4xiXKf6NADd34ZWt0XZF84C8jb7tvIWs5mcYXjuj4VFv9T+CzGEdWMntKymAHGypaz612tz44CrH80EZ14k89ioXhn+CgvHUtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lK7TLf8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d3ZL6Ft9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9D10813803B7;
	Fri,  3 May 2024 11:06:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 03 May 2024 11:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714748762; x=1714835162; bh=JbVGGat4e5
	HAZ02u9XPTjIFCrew1jWN9uR5HkNHLs3M=; b=lK7TLf8vrFhT+1WnJsXkGgy6T4
	BYVijdxdGtOcVpZIZQG4xpRoGrZly+BWL2Xkdi/AF1q9UQmLtJgnekuQU8Gvip9N
	qAuREOv91ycGHxV38u7VRECiASV50H46G5qqozccoetwwVNQRPba+6bn/fn0p0Ab
	pBiivUJ8fFUvJYDobLgsgYMLoTckD7WR3oWFUqzdi+3uIVyJehXgzV+1R3zzvqXJ
	6ZOkRv4KM4fmDDNQz8BbPcu7/u+61Nu25bGh5VTqfgigB/3Q0Ri5gZYXlBTWUSZm
	r8pu9vGn8jgyk4Wwjn2+AbK3WjfC46WGpvuXYA8qGslAqtjm41TrQ5FAhRbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714748762; x=1714835162; bh=JbVGGat4e5HAZ02u9XPTjIFCrew1
	jWN9uR5HkNHLs3M=; b=d3ZL6Ft9U3/8PK4t9hNei5S/rBllz4MFbVHmJKr7kaoV
	KoFSHVxhpJCQ6KHxF5UplOMyCyPskRWxGaxySb3mix2wCpzRa5WL6yElOyjF5nDH
	QzHi3p0Bv3Mwy128xFy8Q4JmWVr9t0ze/LFsvfDvxzTamLOHai3zXD8o4m1/Rj3s
	/ajvQXFJPbJLwQtReHGXchey2pd46tN0Em6fyGaVN2KilXkE0/W8vV9xejFknWTd
	7OX5kHIwVtmG0KYBYWNruOx62B5lCnHzaddC7aTbQvPRHtwmEV73riPe4MaTCpmS
	XWeCyvYKuJxDp6eNqoizaz2mxnkfMSg838K4Ip627A==
X-ME-Sender: <xms:Wf00ZtpwdLsh-nFAWhxyJlAsFsdAxNH6oA7_h45bup7xm3YqKcAl_A>
    <xme:Wf00ZvoE5sqtEyIzpqh4Mx_K48izWBRegWNaOedaP_xDGg0WHbafGMOMSwJovbhLI
    MYEr4Zx0jR_R-TUNmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Wf00ZqMSQWaEGJZ6d3Do3tJEzRZPJPbWMSbtTitfxX7augEPjCY8SA>
    <xmx:Wf00Zo7Nms0sPRdN2ETZKyo2NubkvqwxZ3AlCkPvBaAASYL2nlnsVw>
    <xmx:Wf00Zs7dwn7CdDNkIj50iapNJmYf16XvHmxWp9pzIlcG3XAf5p9Eig>
    <xmx:Wf00ZgghDqvcLuHz6ULCONW3w_F8PPJ6vmLzRJFDGkS-CWYNhwwU3w>
    <xmx:Wv00ZsiFDsFAeByJsXqq40ltjTO8C6AkCJXphqz6zMPUdtKFCD1MyKv6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 112F9B6008D; Fri,  3 May 2024 11:06:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d59d9b67-3f0c-423c-a76d-74056a8444cb@app.fastmail.com>
In-Reply-To: <F1D1D3D4-CFB0-47A8-87F0-E1D8A6B5904F@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
 <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
 <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
 <99B58F85-CC9C-49F6-9A34-B8A59CABE162@toblux.com>
 <F1D1D3D4-CFB0-47A8-87F0-E1D8A6B5904F@toblux.com>
Date: Fri, 03 May 2024 17:05:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>
Cc: 
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Namhyung Kim" <namhyung@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Youling Tang" <tangyouling@loongson.cn>,
 "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Jinyang He" <hejinyang@loongson.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: Change function return types from long to int
Content-Type: text/plain

On Fri, May 3, 2024, at 16:49, Thorsten Blum wrote:
> On 22. Apr 2024, at 17:55, Arnd Bergmann <arnd@arndb.de> wrote:
>>> 
>>> I can generally merge such a series with architecture specific
>>> changes through the asm-generic tree, with the appropriate Acks
>>> from the maintainers.
>
> What would it take for this patch (with only generic type changes) to be
> applied?
>
> I did some further investigations and disassembled my test kernel images.
> The patch reduced the number of ARM instructions by 872 with GCC 13 and by
> 2,354 with GCC 14. Other architectures that rely on the generic bitops
> functions will most likely also benefit from this patch.
>
> Tests were done with base commit 9d1ddab261f3e2af7c384dc02238784ce0cf9f98.

Sorry for failing to follow up earlier, I think this is ok, thanks
for your thorough work on this. I've applied it to the asm-generic
tree now.

     Arnd

