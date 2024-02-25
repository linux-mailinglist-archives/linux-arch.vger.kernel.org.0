Return-Path: <linux-arch+bounces-2717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4008629A5
	for <lists+linux-arch@lfdr.de>; Sun, 25 Feb 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A586B21546
	for <lists+linux-arch@lfdr.de>; Sun, 25 Feb 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E434DDA3;
	Sun, 25 Feb 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="TK+l+50W"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BAD512;
	Sun, 25 Feb 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708846358; cv=none; b=g4XbPxDn6WeqRpRGIhwp1BCWskuKGs3RKrhBa9mpSRVOYJkFP4pOwkRsZQZgzD80rXr3BLO57ekBCr0sjq6xtigkCwQ+VVCCePoexJc4OEkGRdml3YmKJ+0idTQcCT0jJrqSUKhJpY0zOyD3vfKj9bvFH21SzKEOC1QS+mgtA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708846358; c=relaxed/simple;
	bh=LbYhaKq7d6bXAqiyvWbizJuhbnKxuNLIU02M3y8Swcs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLOacz9tEyTrMDfJ6yVsLbqs+BAh6EXyB3LmSxNU0uBSE7U458b+DMYXAm9HsxrF9SYnwogehdHZD1i6rRLIbQ7fdTqas7RbyTV0parjyAKtVgxhcU8rOIvJrXa9pTO+PCj1u35T1v9JTifSaEl7hDuoDyZG8PzXb84+gO/+3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=TK+l+50W; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708846348;
	bh=LbYhaKq7d6bXAqiyvWbizJuhbnKxuNLIU02M3y8Swcs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TK+l+50WWwXr8ks4dAV5JQieBO4oLWZV5/s59mdb7rr39ago66iuFwT9eif2fJArs
	 Vy7/2uGWx3NiZJtQvpSi04KfGCF8fiEUe12ByW5iVUcmyXqnLREf/+aEkq/mOnkwo+
	 Ac5e3DL5QRkTxGQlzTtSjmNAnuCJPfTqTw+9p7m0=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id F3F1966D60;
	Sun, 25 Feb 2024 02:32:24 -0500 (EST)
Message-ID: <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: Icenowy Zheng <uwu@icenowy.me>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christian
 Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Xiaotian Wu
 <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, Miao Wang
 <shankerwangmiao@gmail.com>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, linux-arch <linux-arch@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 25 Feb 2024 15:32:23 +0800
In-Reply-To: <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
	 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
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

On Sun, 2024-02-25 at 14:51 +0800, Icenowy Zheng wrote:
> > From my point of view, I prefer to "restore fstat", because we need
> > to
> > use the Chrome sandbox everyday (even though it hasn't been upstream
> > by now). But I also hope "seccomp deep argument inspection" can be
> > solved in the future.
>=20
> My idea is this problem needs syscalls to be designed with deep
> argument inspection in mind; syscalls before this should be considered
> as historical error and get fixed by resotring old syscalls.

I'd not consider fstat an error as using statx for fstat has a
performance impact (severe for some workflows), and Linus has concluded
"if the user wants fstat, give them fstat" for the performance issue:

https://sourceware.org/pipermail/libc-alpha/2023-September/151365.html

However we only want fstat (actually "newfstat" in fs/stat.c), and it
seems we don't want to resurrect newstat, newlstat, newfstatat, etc. (or
am I missing any benefit - performance or "just pleasing seccomp" - of
them comparing to statx?) so we don't want to just define
__ARCH_WANT_NEW_STAT.  So it seems we need to add some new #if to
fs/stat.c and include/uapi/asm-generic/unistd.h.

And no, it's not a design issue of all other syscalls.  It's just the
design issue of seccomp.  There's no way to design a syscall allowing
seccomp to inspect a 100-character path in its argument unless
refactoring seccomp entirely because we cannot fit a 100-character path
into 8 registers.

As at now people do use PTRACE_PEEKDATA for "deep inspection" (actually
"debugging" the target process) but it obviously makes a very severe
performance impact.

<rant>

Today the entire software industry is saying "do things in a declarative
way" but seccomp is completely the opposite.  It's auditing *how* the
sandboxed application is doing things instead of *what* will be done.

I've raised my against to seccomp and/or syscall allowlisting several
times after seeing so many breakages like:

- https://github.com/NetworkConfiguration/dhcpcd/issues/120
- https://gitlab.gnome.org/GNOME/tracker-miners/-/issues/252
- https://blog.pintia.cn/2018/06/27/glibc-segmentation-fault/
- http://web.archive.org/web/20210126121421/http://acm.xidian.edu.cn/discus=
s/thread.php?tid=3D148&cid=3D# (comment 3)

but people just keep telling me "you are wrong, you don't understand
security".  Some of them even complain "seccomp is broken" as well but
still keep using it.

</rant>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

