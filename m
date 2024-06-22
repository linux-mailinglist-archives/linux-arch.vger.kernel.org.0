Return-Path: <linux-arch+bounces-5019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97A913324
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 13:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9018B1F23023
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950E15444E;
	Sat, 22 Jun 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AnxmN8BL"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261F153567;
	Sat, 22 Jun 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054300; cv=none; b=nl+eJ5cDKcXfG2r62sgPeEJ9Y4ugQsGs17uvDJ+FIfJZONh369PMqB3lGhyXbcINfkkCZoIvj2JMwP7RxY0ocTz9ywWhR6rtUK98qNtaDLkzk/UWcrUFp8dINjbFuLH9+BqoXepVlyapvwgbTKH2LMO64LHhn9UWYxXJ/7hIFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054300; c=relaxed/simple;
	bh=NZNcXXX7oZ4Ic/I2g+QIbYzMDnjzRrmXaFWI7JJSPG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Au1wCTJRwRYGtbV2Twg7bsPW1yKnZo4iqCJLo69khYkfa+sfxQpUlNl+TBXDukem8fvmPt8zllc3K5/QQB6KJekNOHGisyPhE4WGkbGcO+Djyh0dM0lpzda9QaVRMCxhVilLDH1WS4c+LqOkBJh4H9IboMng5haVGHv6i5J0boI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=AnxmN8BL; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1719054298;
	bh=NZNcXXX7oZ4Ic/I2g+QIbYzMDnjzRrmXaFWI7JJSPG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AnxmN8BLmGsC/BO6Wk1w9jqw9fwm2EOqH4jG687DXDIT8f6HAPiLUMKIdpgvsgvpi
	 67YDoXyVqIo/mgPva/eSD+KVIOTX5ealwvluRoHkSGg7i93PhmfZtY+LMAgDkb+tsR
	 3jqvPbVAI8NQOCyBVLyFLeSEj8pcGsP48oalN3Fc=
Received: from [192.168.124.13] (unknown [113.200.174.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D8FA467190;
	Sat, 22 Jun 2024 07:04:55 -0400 (EDT)
Message-ID: <8c14c943ee0a5619bdc272adbdd76a61809b73b6.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
 loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng
 Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn, 
 stable@vger.kernel.org
Date: Sat, 22 Jun 2024 19:04:52 +0800
In-Reply-To: <CAAhV-H4HaAnKJFnDpfUY6qdEtoKPxLSgHgU8isMryrab=cq6pA@mail.gmail.com>
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
	 <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
	 <CAAhV-H4HaAnKJFnDpfUY6qdEtoKPxLSgHgU8isMryrab=cq6pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-22 at 15:45 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Mon, Jun 17, 2024 at 2:45=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Mon, 2024-06-17 at 08:35 +0200, Arnd Bergmann wrote:
> > > On Sat, Jun 15, 2024, at 15:12, Xi Ruoyao wrote:
> > > > On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
> > > > >=20
> > > > > [Firefox]:
> > > > > https://searchfox.org/mozilla-central/source/security/sandbox/lin=
u
> > > > > x/SandboxFilter.cpp#364
> > > >=20
> > > > Just spent some brain cycles to make a quick hack adding a new stat=
x
> > > > flag.=C2=A0 Patch attached.
> > > >=20
> > >=20
> > > Thanks for the prototype. I agree that this is not a good API
> >=20
> > What is particular bad with it?=C2=A0 Maybe we can improve before annoy=
ing
> > VFS guys :).
> >=20
> > > but that it would address the issue and I am fine with merging
> > > something like this if you can convince the VFS maintainers.
> >=20
> > Before that I'd like someone to purpose a better name.=C2=A0 I really d=
islike
> > "AT_FORCE_EMPTY_PATH" but I cannot come up with something better.
> Any updates? Have you submitted this patch? I hope we can end up at 6.11.=
 :)

https://lore.kernel.org/linux-fsdevel/20240622105621.7922-1-xry111@xry111.s=
ite/


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

