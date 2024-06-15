Return-Path: <linux-arch+bounces-4913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2B909821
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 14:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855B3283026
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BB45023;
	Sat, 15 Jun 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="C/fpvPYg"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCD44C68;
	Sat, 15 Jun 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453573; cv=none; b=BJ/MfBBHDAbF1kbFBQBn6XBxqxV0lnfvIeORyTyB1Tz0x+EdDOG3vU6PhKv9J0OhqHMW9lt2VU7+QOYUVAXyMQpT2QlZMYg2Ol/QjtRy+pZEu0wIsKCW6XWAvjKhtCf9cRat/ocIjgCk4fq2grFJq4ox95d0zaAnTOjMtISUhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453573; c=relaxed/simple;
	bh=Rie8EOS2HocIJQKELqDA8dhCoGwxflKqxoLfMmmwY6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQB7IC+wWc2fve+dpnNNTteNJdBu2muQUhyYXJEPNuP/tiObphD/tKizEOPun5sw5PgwfB5lz94edzOopVQFVxKSB0LOHs0lugci+zF6J9V/u322M33nnpq5QK0w7tT8WmSjWmXiBhImQpLa3oJ4ceh5sjqhIOQ224FeJKehtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=C/fpvPYg; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718453570;
	bh=Rie8EOS2HocIJQKELqDA8dhCoGwxflKqxoLfMmmwY6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C/fpvPYgKWoo9vhfwEBu7ePIrjNUfZm89ecgtFbty1xUipyRQN8Gi+eqtEf3+UjJy
	 pINvUxh+nUSA8PWyPJCaJ8qo+kZ+06L6QfMcjK74tfq2IBqfGNJy4HEtxocDSjDCQ9
	 3x3t/KlMESJvr6y1K9BP8AEn6lrU5eUJ15e7YK+8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 123C566E92;
	Sat, 15 Jun 2024 08:12:45 -0400 (EDT)
Message-ID: <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org,  loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Date: Sat, 15 Jun 2024 20:12:43 +0800
In-Reply-To: <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 13:47 +0200, Arnd Bergmann wrote:

/* snip */

> > > > We can only wait for the seccomp side to be fixed now? Or we can ge=
t
> > > > this patch upstream for LoongArch64 at the moment, and wait for
> > > > seccomp to fix RISCV32 (and LoongArch32) in future?
> > >=20
> > > I'm wondering why not just introduce a new syscall or extend statx wi=
th
> > > a new flag, as we've discussed many times.=C2=A0 They have their own
> > > disadvantages but better than this, IMO.
> > We should move things forward, in any way. :)
>=20
> Wouldn't it be sufficient to move the AT_EMPTY_PATH hack
> from vfs_fstatat() to vfs_statx() so we can make them
> behave the same way?
>=20
> As far as I can tell, the only difference between the two is
> that fstatat64() and similar already has added the check for
> zero-length strings in order to make using vfs_fstatat()
> fast and safe when called from glibc stat().

Do you mean https://git.kernel.org/torvalds/c/9013c51c630a?  It (only
partially) fix the performance issue but it won't help seccomp.  The
problem is you cannot check if the string is zero-length with seccomp.
Thus seccomp cannot audit fstatat properly as well.

In [Firefox] *all* fstatat (and statx) calls are trapped and *the signal
handler* audit this fstatat call.  If flags & AT_EMPTY_PATH and path is
zero-length, it calls fstat to do the job.  But on LoongArch there is no
way to "do the job" as the only stat-family call is statx.

[Firefox]:https://searchfox.org/mozilla-central/source/security/sandbox/lin=
ux/SandboxFilter.cpp#364

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

