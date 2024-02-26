Return-Path: <linux-arch+bounces-2718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B48669DF
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 07:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D250B213F5
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6331B968;
	Mon, 26 Feb 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="QDmAwvF+"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE363B1;
	Mon, 26 Feb 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927477; cv=pass; b=lTutuD8hjoP5/YT5z+UnwnZUYbV4AvXbyx23geJpJ0CW3Pii903mWG+XiJE9bmKjz1JVaGvgdfb16lCa6ZI+PmYEBM0R+P24gZcSYdrYdJ0v3UqZOgr8u1muZ3JN8PlOS7m2W6hnVBzJM2qmTUNT7g1fCkhw80S4IFz6DTPHCbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927477; c=relaxed/simple;
	bh=CZVTpBGF86V/SGUwaHA7h+OYsTh8TAqio3D0tYnMqbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWEmFSpS9UaEHp9zyMebi5BuyeSZFBOyuP0aYef9dlpVmjeLtA260Yo5gFywvKJBPdWlo0ocMbe2f4S0cO1epZEdlnbpNVXch5ClHuGszaJdIEIRg2jWrd1YspY7fsIgqfg+GjIDuQE+3lkbt0gL+2Wfzs1ea+UAkRHfQ9aKfeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=QDmAwvF+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1708927440; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TcsIh9ADSLaGaizzV7Meh/U0sik1DIKqedMt5LCLU1EDdkZ2LvzM+qsEw8l+VJ8A1TcTKXyAwbia9UOmDNmEY4cVp+6/Dhoio0RsFq+xIBPAkZ0bhXkl9RxWj1d1NThHyV1zLHxL4R4Yx01mb6oMEqqgekvsx4UnmArRdRTaSvo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708927440; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CZVTpBGF86V/SGUwaHA7h+OYsTh8TAqio3D0tYnMqbc=; 
	b=ka45S8jnRfOOrzbW+F7FPqM8zRrOLq9z6pJ1dfB5WGGx2H4K8evZPWy9SREDOeEX42Jqlzsdoq0QjCeQXDBXmsFz9Tkeu3CufAFArqaf96tcnyuVDCwIDhpFvvJr0nJJQQnuuh7nFTEotRy85feH4XDxMim7iDDkbIIUsGAhKHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708927440;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=CZVTpBGF86V/SGUwaHA7h+OYsTh8TAqio3D0tYnMqbc=;
	b=QDmAwvF+V4Q9r8FMBx2ZQH+E53G1Ax9gHEBQGLrkvyRAxfv26QHtlDrdpsT6XnKP
	GJpKmhbRedV61bI4UQ88PV1jgE66pqllfBnm/5CD+s6fyIBkXRebQx3F6naU9QOdNLZ
	SPGpGRRfnNHNVaaxIoFOXoXfqUBjTxwwkXrt88rmOvevvy2xl/lsxkrr1iS+y2Mm+/D
	qDeeuBLLNgkDDPpo0YwjDkaxd2kGk6Gr40jTxf/2XvGHaUcmvWL824A5F7Pl6+A+IoQ
	P6eUXKQ+irEcf53sY5htc5Y1/zdl4fz/gMFGIqzDzatrQLTdrY/sl9Cl/n6mDkjKqiW
	e589WQTyUw==
Received: from edelgard.fodlan.icenowy.me (112.94.101.70 [112.94.101.70]) by mx.zohomail.com
	with SMTPS id 1708927438859856.127358578202; Sun, 25 Feb 2024 22:03:58 -0800 (PST)
Message-ID: <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Icenowy Zheng <uwu@icenowy.me>
To: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christian
 Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu
 <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, Miao Wang
 <shankerwangmiao@gmail.com>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, linux-arch <linux-arch@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 26 Feb 2024 14:03:48 +0800
In-Reply-To: <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
	 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
	 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-02-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 15:32 +0800=EF=BC=
=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
> > > From my point of view, I prefer to "restore fstat", because we
> > > need
> > > to
> > > use the Chrome sandbox everyday (even though it hasn't been
> > > upstream
> > > by now). But I also hope "seccomp deep argument inspection" can
> > > be
> > > solved in the future.
> >=20
> > My idea is this problem needs syscalls to be designed with deep
> > argument inspection in mind; syscalls before this should be
> > considered
> > as historical error and get fixed by resotring old syscalls.
>=20
> I'd not consider fstat an error as using statx for fstat has a
> performance impact (severe for some workflows), and Linus has
> concluded

Sorry for clearance, I mean statx is an error in ABI design, not fstat.

> "if the user wants fstat, give them fstat" for the performance issue:
>=20
> https://sourceware.org/pipermail/libc-alpha/2023-September/151365.html
>=20
> However we only want fstat (actually "newfstat" in fs/stat.c), and it
> seems we don't want to resurrect newstat, newlstat, newfstatat, etc.
> (or
> am I missing any benefit - performance or "just pleasing seccomp" -
> of
> them comparing to statx?) so we don't want to just define
> __ARCH_WANT_NEW_STAT.=C2=A0 So it seems we need to add some new #if to
> fs/stat.c and include/uapi/asm-generic/unistd.h.
>=20
> And no, it's not a design issue of all other syscalls.=C2=A0 It's just th=
e
> design issue of seccomp.=C2=A0 There's no way to design a syscall allowin=
g
> seccomp to inspect a 100-character path in its argument unless
> refactoring seccomp entirely because we cannot fit a 100-character
> path
> into 8 registers.

Well my meaning is that syscalls should be designed to be simple to
prevent this kind of circumstance.

>=20
> As at now people do use PTRACE_PEEKDATA for "deep inspection"
> (actually
> "debugging" the target process) but it obviously makes a very severe
> performance impact.
>=20
> <rant>
>=20
> Today the entire software industry is saying "do things in a
> declarative
> way" but seccomp is completely the opposite.=C2=A0 It's auditing *how* th=
e
> sandboxed application is doing things instead of *what* will be done.
>=20
> I've raised my against to seccomp and/or syscall allowlisting several
> times after seeing so many breakages like:
>=20
> - https://github.com/NetworkConfiguration/dhcpcd/issues/120
> - https://gitlab.gnome.org/GNOME/tracker-miners/-/issues/252
> - https://blog.pintia.cn/2018/06/27/glibc-segmentation-fault/
> -
> http://web.archive.org/web/20210126121421/http://acm.xidian.edu.cn/discus=
s/thread.php?tid=3D148&cid=3D#
> =C2=A0(comment 3)
>=20
> but people just keep telling me "you are wrong, you don't understand
> security".=C2=A0 Some of them even complain "seccomp is broken" as well
> but
> still keep using it.
>=20
> </rant>
>=20


