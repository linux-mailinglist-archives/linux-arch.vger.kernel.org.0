Return-Path: <linux-arch+bounces-2723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3586742C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 13:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630B6B26B2E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF435A7B6;
	Mon, 26 Feb 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VALUTm+B"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4E1DA4C;
	Mon, 26 Feb 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948692; cv=none; b=aioGzvykPeRhk6tcxr/xo3JdZGf1BFO+iv1DFANj1rQ+KLjc/tayNQWTAeWI4LNQK6qCkSqvS8tdMTgL4NEVuxQMWVhPYUCoZw5bJA+ztm7sX+RKoNNLy638SG+AOiNhyNi7MHfC4lky/eedTV/LPC4P/PJrHhIiVQRY5fj8/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948692; c=relaxed/simple;
	bh=LZ/iy7EvE9b3WFlZVAb1AN+o08sKkPZFvgB5cDWZLkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUv+N9iXh1dqfmbuiiV1M68O6U29il/s0xF6kWY4+YUNwyBon/6xSfm2JcB4gErbbB7cMZVfXWvUclQqzW02XjREoqnMHtU3PmDvLnDU4iykYwLmT/VKubpJq0i49FsyMqlrg4UlX+nEHRXkD7Q6wjh8r+JRYtdz/zxUTwVAYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VALUTm+B; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708948682;
	bh=LZ/iy7EvE9b3WFlZVAb1AN+o08sKkPZFvgB5cDWZLkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VALUTm+BIrGnBsYSAjZrazvciSZiDoQB3MEMlVIqZv7MPtj/uVKiHh/V+jJip7zZk
	 JvdlWtjV3LdzYI6fJhq+LfwIW+m4713aukDLNh3G8091G0VoV/wFJRfDlVOegTSy6H
	 KB9wYA8lW12KDJ0dV9OwT+VaqxZE7M46iIUjk+V4=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3B7C067084;
	Mon, 26 Feb 2024 06:57:58 -0500 (EST)
Message-ID: <6bf460d17b9f44326497ffb41e03363b112d6927.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Icenowy Zheng <uwu@icenowy.me>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Adhemerval
 Zanella <adhemerval.zanella@linaro.org>, Rich Felker <dalias@aerifal.cx>
Cc: linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, Jianmin
 Lv <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui
 <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch
 <linux-arch@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Mon, 26 Feb 2024 19:57:56 +0800
In-Reply-To: <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
	 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
	 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
	 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
	 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
	 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
	 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
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

On Mon, 2024-02-26 at 10:20 +0100, Arnd Bergmann wrote:

/* snip */

>=20
> > Or maybe we can just introduce a new AT_something to make statx
> > completely ignore pathname but behave like AT_EMPTY_PATH + "".
>=20
> I think this is better than going back to fstat64_time64(), but
> it's still not great because
>=20
> - all the reserved flags on statx() are by definition incompatible
> =C2=A0 with existing kernels that return -EINVAL for any flag they do
> =C2=A0 not recognize.

Oops, we are deeming passing undefined flags in "mask" undefined
behavior but not "flags", thus "wild software" may be relying on EINVAL
for invalid flags...  We *might* make this new AT_xxx a bit in mask
instead of flags but it would be very dirty IMO.

> - you still need to convince libc developers to actually use
> =C2=A0 the flag despite the backwards compatibility problem, either
> =C2=A0 with a fallback to the current behavior or a version check.

Let me ping some libc developers then...

> Using the NULL path as a fallback would solve the problem with
> seccomp, but it would not make the normal case any faster.

But "wild software" may be relying on a EFAULT for NULL path too...

/* snip */

> >=20
> > Oops.=C2=A0 I thought "newstat" should be using 64-bit time but it seem=
s the
> > "new" is not what I'd expected...=C2=A0 The "new" actually means "newer=
 than
> > Linux 0.9"! :(
> >=20
> > Let's not use "new" in future syscall names...
>=20
> Right, we definitely can't ever succeed. On some architectures
> we even had "oldstat" and "stat" before "newstat" and "stat64",
> and on some architectures we mix them up. E.g. x86_64 has fstat()
> and fstatat64() with the same structure but doesn't define
> __NR_newfstat. On mips64, there is a 'newstat' but it has 32-bit
> timestamps unlike all other 64-bit architectures.
>=20
> statx() was intended to solve these problems once and for all,
> and it appears that we have failed again.

https://xkcd.com/927/ :(

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

