Return-Path: <linux-arch+bounces-2720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E1866A75
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 08:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7799283B31
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA21BC5C;
	Mon, 26 Feb 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="lQJSXIzL"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C721BC53;
	Mon, 26 Feb 2024 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931384; cv=none; b=SUWTOmGjkQCpEVkJwShBoz/pPAM39EQwMsCSnBuPu6S7vfmN36I1MfRcK135oiBou4DM1+j+VDXWcH5HMLs+Pv/oPdzgYBGCDBCGijAXa+pNeqgNSSs1xtH0iqsnSsd3nH/9+7EjAliwHEw4aKncgzJgP7Q+YO4IomHkalJetP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931384; c=relaxed/simple;
	bh=TS2t5O9Ej8aC5JljLUiRdfFSsdI5NkEOBunRV3BF1EE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O76ob8Fb6CpAqG4RIU95NQo/CY2EJQ1XNoQHXmV4P0QCiLK0+SfMa9kftwrAAZlzoejWBIIGb9kqjgl/0siGMh7pz44DFuD0eA8yzS9wBHdV9kCKMNCCKcCQTH26rk+jxhPuseP8cgLb0Z7xffFstG+ZdsIyXWRls7E1e0TNeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=lQJSXIzL; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708931380;
	bh=TS2t5O9Ej8aC5JljLUiRdfFSsdI5NkEOBunRV3BF1EE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lQJSXIzL2mKFMEaHlj7saQf/5h7AZNE2jTXEM+zOr3lll49LlBVcV5LYONIjt8KDn
	 jRGtdPv8zoeNDUtgyXe8Y1ZKdMPLjvKc/TfQvwU2cpVoT/YlGBjDDpQBfaobLG7J4l
	 aGhwh520dUNnO4xBtIT3a4Z5PARoyiFRtULbbBaQ=
Received: from [192.168.124.4] (unknown [113.140.11.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A0F9266B6F;
	Mon, 26 Feb 2024 02:09:36 -0500 (EST)
Message-ID: <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Icenowy Zheng <uwu@icenowy.me>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, Jianmin
 Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui
 <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch
 <linux-arch@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Mon, 26 Feb 2024 15:09:29 +0800
In-Reply-To: <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
	 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
	 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
	 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
	 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 07:56 +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 07:03, Icenowy Zheng wrote:
> > =E5=9C=A8 2024-02-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 15:32 +0800=EF=
=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> > > On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
> > > > My idea is this problem needs syscalls to be designed with deep
> > > > argument inspection in mind; syscalls before this should be
> > > > considered
> > > > as historical error and get fixed by resotring old syscalls.
> > >=20
> > > I'd not consider fstat an error as using statx for fstat has a
> > > performance impact (severe for some workflows), and Linus has
> > > concluded
> >=20
> > Sorry for clearance, I mean statx is an error in ABI design, not fstat.

I'm wondering why we decided to use AT_EMPTY_PATH/"" instead of
"AT_NULL_PATH"/nullptr in the first place?

> The same has been said about seccomp(). ;-)
>=20
> It's clear that the two don't go well together at the moment.
>=20
> > > "if the user wants fstat, give them fstat" for the performance issue:
> > >=20
> > > https://sourceware.org/pipermail/libc-alpha/2023-September/151365.htm=
l
> > >=20
> > > However we only want fstat (actually "newfstat" in fs/stat.c), and it
> > > seems we don't want to resurrect newstat, newlstat, newfstatat, etc.
> > > (or
> > > am I missing any benefit - performance or "just pleasing seccomp" -
> > > of them comparing to statx?) so we don't want to just define
> > > __ARCH_WANT_NEW_STAT.=C2=A0 So it seems we need to add some new #if t=
o
> > > fs/stat.c and include/uapi/asm-generic/unistd.h.
> > >=20
> > > And no, it's not a design issue of all other syscalls.=C2=A0 It's jus=
t the
> > > design issue of seccomp.=C2=A0 There's no way to design a syscall all=
owing
> > > seccomp to inspect a 100-character path in its argument unless
> > > refactoring seccomp entirely because we cannot fit a 100-character
> > > path
> > > into 8 registers.
> >=20
> > Well my meaning is that syscalls should be designed to be simple to
> > prevent this kind of circumstance.

But it's not irrational to pass a path to syscall, as long as we still
have the concept of file system (maybe in 2371 or some year we'll use a
128-bit UUID instead of path).

> The problem I see with the 'use use fstat' approach is that this
> does not work on 32-bit architectures, unless we define a new
> fstatat64_time64() syscall, which is one of the things that statx()

"fstat64_time64".  Using statx for fstatat should be just fine.

Or maybe we can just introduce a new AT_something to make statx
completely ignore pathname but behave like AT_EMPTY_PATH + "".

> was trying to avoid.

Oops.  I thought "newstat" should be using 64-bit time but it seems the
"new" is not what I'd expected...  The "new" actually means "newer than
Linux 0.9"! :(

Let's not use "new" in future syscall names...

> Whichever solution we end up with should work on both
> loongarch64 and on armv7 at least.
>=20
> =C2=A0=C2=A0=C2=A0 Arnd

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

