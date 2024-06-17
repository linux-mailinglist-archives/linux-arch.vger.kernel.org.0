Return-Path: <linux-arch+bounces-4939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129C90A60F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 08:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5641C25B23
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7E186299;
	Mon, 17 Jun 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="LNBeD+39"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9B1CD02;
	Mon, 17 Jun 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606725; cv=none; b=J4kFbd2TboooxrQWpmmDZqbG3tsP8/7LLKRm8HEU6nsdz3Om7D/ZUYYFuYxixey+e+sFBPKSOc/mkS8lSbRYaGKQWjfj7N0IZbIWt5hnva3ONGTh4XtrnfHtrNMQ/lVoSpEvIQGZSzaohLWvvi6fk62/7EAlbBwF9cgyZ4GDtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606725; c=relaxed/simple;
	bh=5Y+iVadFmjWijG+8D1+yTO8txZNzdyKc9h7Z5w1h3+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kg45CddM0kGOwzxvpz3ULDaAKRmCF6DdJkMisk0eEWuXesUro0tQJhtJcaT3SdKQ9FaMEvfRoqy58XODhdEIPi0ztFXfdqi+vvG0+/qswCr7Ll+NcRB8anAow2nZBX2C5hn/sBsp8lss1jyITg+8VtjzsKumAoI5GPd7dy/tRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=LNBeD+39; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718606716;
	bh=5Y+iVadFmjWijG+8D1+yTO8txZNzdyKc9h7Z5w1h3+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LNBeD+39PtRfrNNh++jvHI0Tv8FEbdcEtuqb/wVVCeeZXHu5mRytiWP5xt9luk7vS
	 BgL/WLQFvY4iTLAx8K/iogA4x6tlCybfx7EP6/cE59FCYChgsNW8D9tsNLMF8OXfp3
	 EmIcBKntbjORNao38lqqGqSLaWe/gBUW6Tyh/XwU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3CE0966C5F;
	Mon, 17 Jun 2024 02:45:09 -0400 (EDT)
Message-ID: <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org,  loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Date: Mon, 17 Jun 2024 14:45:06 +0800
In-Reply-To: <4fd0531d-e8f8-4a4c-9136-50fcc31ba5f2@app.fastmail.com>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
	 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
	 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
	 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
	 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
	 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
	 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
	 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
	 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
	 <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
	 <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
	 <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
	 <4fd0531d-e8f8-4a4c-9136-50fcc31ba5f2@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 08:35 +0200, Arnd Bergmann wrote:
> On Sat, Jun 15, 2024, at 15:12, Xi Ruoyao wrote:
> > On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
> > >=20
> > > [Firefox]:
> > > https://searchfox.org/mozilla-central/source/security/sandbox/linu
> > > x/SandboxFilter.cpp#364
> >=20
> > Just spent some brain cycles to make a quick hack adding a new statx
> > flag.=C2=A0 Patch attached.
> >=20
>=20
> Thanks for the prototype. I agree that this is not a good API

What is particular bad with it?  Maybe we can improve before annoying
VFS guys :).

> but that it would address the issue and I am fine with merging
> something like this if you can convince the VFS maintainers.

Before that I'd like someone to purpose a better name.  I really dislike
"AT_FORCE_EMPTY_PATH" but I cannot come up with something better.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

