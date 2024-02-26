Return-Path: <linux-arch+bounces-2736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C1867C7F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 17:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667B21F2831D
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65A12C7FD;
	Mon, 26 Feb 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="M1bF301I"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387A12BE8A;
	Mon, 26 Feb 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966212; cv=none; b=Oyp3/Ef5R0Pek1a6l09yvZEAE2Gu9Q06/C5ZSJ0V+TqR9P5tZ6FR3lGvHEtxWyIdBgszSBNd5saiS9BtBqSAIeEaCFhbyDIoDIHIzpedrgBflNCYfEnXP5f8nr4ICpSNpxl/me8cnRdERqvWzFSQVJI8Q/VXSKvkPYhZ5sI1/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966212; c=relaxed/simple;
	bh=tYJtKOb5YnFqEfI64gUF97SWIUHpOFQPG5IqgXsQzxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbuFX22eOXoioXyZaUOWmxtTYiU6PB2htPVeWTX1j4StjWyHAMTQLMTOryGl++ykP6s0O87tyPsin8BK67obuNGapRFOmWluvGUMUKZMJclPfi+mf4xgNEqujhjyP/dDZpeyvUDc09xWKbhp4x7hF1HGEdYymLtBGBeUhXWxrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=M1bF301I; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708966207;
	bh=tYJtKOb5YnFqEfI64gUF97SWIUHpOFQPG5IqgXsQzxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M1bF301I5pHXWIqKowEvXZnugysDMbfT3wTfA7qcjhKz9uSu0mytoul7Sj3riwCki
	 0btIqqUngLHgyE1W1pUD3G4BtlxJJy1uSZXjH1kIty7wGFzyWFe6dEWHVVFxHYGzty
	 /x1VA7kY0mPFaP7OgjjseuG8Cb3rkoXO1MKcVzR0=
Received: from [IPv6:240e:358:11b4:ae00:dc73:854d:832e:5] (unknown [IPv6:240e:358:11b4:ae00:dc73:854d:832e:5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id F41D466C2D;
	Mon, 26 Feb 2024 11:49:57 -0500 (EST)
Message-ID: <8e5e31daa3b76dc80ff5ec6ad46191bfd87f7df7.camel@xry111.site>
Subject: Re: Chromium sandbox on LoongArch and statx -- seccomp deep
 argument inspection again?
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Icenowy Zheng <uwu@icenowy.me>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, linux-api@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv
 <lvjianmin@loongson.cn>, Xiaotian Wu <wuxiaotian@loongson.cn>, WANG Rui
 <wangrui@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Linux-Arch
 <linux-arch@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Tue, 27 Feb 2024 00:49:51 +0800
In-Reply-To: <20240226-sandbank-bewerben-219120323e29@brauner>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <CAAhV-H4oW70y-2ZSp=b-Ed3A7Jrxfg6xvO8YpjED6To=PF0NwA@mail.gmail.com>
	 <f063e65df92228cac6e57b0c21de6b750cf47e42.camel@icenowy.me>
	 <24c47463f9b469bdc03e415d953d1ca926d83680.camel@xry111.site>
	 <61c5b883762ba4f7fc5a89f539dcd6c8b13d8622.camel@icenowy.me>
	 <3c396b7c-adec-4762-9584-5824f310bf7b@app.fastmail.com>
	 <6f7a8e320f3c2bd5e9b704bb8d1f311714cd8644.camel@xry111.site>
	 <b9fb0de1-bfb9-47a6-9730-325e7641c182@app.fastmail.com>
	 <20240226-graustufen-hinsehen-6c578a744806@brauner>
	 <ef732971-bf70-4d8c-9fe8-3ca163a0c29c@app.fastmail.com>
	 <20240226-sandbank-bewerben-219120323e29@brauner>
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

On Mon, 2024-02-26 at 16:40 +0100, Christian Brauner wrote:

> > I definitely don't want to see a new time32 API added to
> > mips64 and the 32-bit architectures, so the existing stat64
> > interface won't work as a statx replacement.
>=20
> I don't specifically care but the same way you don't want to see newer
> time32 apis added to architectures I don't want to have hacks in our
> system calls that aren't even a clear solution to the problem outlined
> in this thread.

So we should have a fstat_whatever64, IMO.

> Short of adding fstatx() the problem isn't solved by a new flag to
> statx() as explained in my other mails. But I'm probably missing
> something here because I find this notion of "design system calls for
> seccomp and the Chromium sandbox" to be an absurd notion and it makes me
> a bit impatient.

I'm sharing the feeling on seccomp and/or (mis)uses of it, but using
statx() or fstatat() for fstat() has a performance impact as they must
inspect path (do a uaccess) and make sure it's an empty string, and
Linus concluded "if the user want fstat, you should give the user fstat"
for this issue:

https://sourceware.org/pipermail/libc-alpha/2023-September/151365.html

If it was just seccomp I'd not comment on this topic at all.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

