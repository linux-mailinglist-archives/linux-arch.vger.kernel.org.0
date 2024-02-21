Return-Path: <linux-arch+bounces-2577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F362185D799
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB1B283FBC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721324D584;
	Wed, 21 Feb 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Jj+yFUaN"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9171482DD;
	Wed, 21 Feb 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517023; cv=none; b=n2mkVUr8JYV4n9hx5xFl9nzMGrUpDErCJ6d4cjDeYYmaHJOdDyaO/y8wr3xaA7dmjXZDppt+JaUgn/5od9AVvO9KpHbOS2dhpXWP6+71C1yjreZ9st5NLR8XbgZG2+vKy6iTAv0I9mqs0IYj8Pb861/veLd2qPJo771hTIUe1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517023; c=relaxed/simple;
	bh=G9lw+pWH4sUOkUH0bXaLYBB+FhlhFrbv+OlBmjcgIkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0x1pTrNg1pSET66Z5jOUstzuFVw5l7BYO1nRa2a30s9R+54tOP4VehaAVz/9G7wbJhoRsSsakGC0ayEOB6FcDzIKVD199Ld9T6ru+Ok0cfqmAZlhdI58f1F47hQfv+sHxDvDXCYPS2iiaiPERHF9jaruSo22EZJoChnxfKX6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Jj+yFUaN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708517016;
	bh=G9lw+pWH4sUOkUH0bXaLYBB+FhlhFrbv+OlBmjcgIkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jj+yFUaNwpoNaTbYAo72StJA+aH4ps7quIo42ug/l/UFyv9Pk5Yp3nIcAGLlf3Ebh
	 2jVzjsZ8lBESomvHQu954Lpbj9kzja6ChBqVvrySsJq+RxkmijzskprQTCKT3NMoEo
	 RXL/j6bPEZ5gTy9D5SAbUJ2ilXvKJaQ3Y855P99k=
Received: from [IPv6:240e:358:118f:d600:dc73:854d:832e:7] (unknown [IPv6:240e:358:118f:d600:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 27E6C668DF;
	Wed, 21 Feb 2024 07:03:25 -0500 (EST)
Message-ID: <f2b7c35e25a51e9a9f8036a5c08e95ba1ec45831.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
 Kees Cook <keescook@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui <wangrui@loongson.cn>, Miao
 Wang <shankerwangmiao@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, linux-arch
 <linux-arch@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Wed, 21 Feb 2024 20:03:16 +0800
In-Reply-To: <f59d73fb-7d3e-4c55-821a-082032267978@xen0n.name>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <f1a1bc708be543eb647df57b5eb0c0ef035baf8b.camel@xry111.site>
	 <2d25e3bb829cbca51387eb84985db919f50ccd37.camel@xry111.site>
	 <f59d73fb-7d3e-4c55-821a-082032267978@xen0n.name>
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

On Wed, 2024-02-21 at 18:49 +0800, WANG Xuerui wrote:
>=20
> On 2/21/24 18:31, Xi Ruoyao wrote:
> > On Wed, 2024-02-21 at 14:31 +0800, Xi Ruoyao wrote:
> > > On Wed, 2024-02-21 at 14:09 +0800, WANG Xuerui wrote:
> > >=20
> > > > - just restore fstat and be done with it;
> > > > - add a flag to statx so we can do the equivalent of just fstat(fd,
> > > > &out) with statx, and ensuring an error happens if path is not empt=
y in
> > > > that case;
> > > It's worse than "just restore fstat" considering the performance.=C2=
=A0 Read
> > > this thread:
> > > https://sourceware.org/pipermail/libc-alpha/2023-September/151320.htm=
l
> > Hmm, but it looks like statx already suffers the same performance issue=
.
> > And in this libc-alpha discussion Linus said:
> >=20
> > =C2=A0=C2=A0=C2=A0 If the user asked for 'fstat()', just give the user =
'fstat()'.
> > =C2=A0=C2=A0=C2=A0=20
> > So to me we should just add fstat (and use it in Glibc for LoongArch, o=
nly
> > falling back to statx if fstat returns -ENOSYS), or am I missing someth=
ing?
>=20
> Or we could add a AT_STATX_NULL_PATH flag and mandate that `path` must
> be NULL if this flag is present -- then with simple checks we could have=
=20
> statx(fd, NULL, AT_STATX_NULL_PATH, STATX_BASIC_STATS, &out) that's both=
=20
> fstat-like and fast.

But then to take the advantage in Glibc fstat() implementation, we'll
need to try AT_STATX_NULL_PATH first, then check for EFAULT (not
ENOSYS!) and fall back to AT_EMPTY_PATH.  The EFAULT checking seems
nasty to me...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

