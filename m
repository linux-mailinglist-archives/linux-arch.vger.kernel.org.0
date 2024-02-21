Return-Path: <linux-arch+bounces-2555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8485D594
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED17285F80
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162434C87;
	Wed, 21 Feb 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NGd6lt8p"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897543C00;
	Wed, 21 Feb 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511517; cv=none; b=JCkmnSrJ8ZCUVQyqscxIAyLvtXKrqyUqPomEpHpMScLh12fhOPGzRZGlhm4cjDHx5hcpbGoOUE8iHW/ygfOdUVh8T+O8t6Kl+eqXhahnLPVmxVKcrrX109rn2h/QMR1w9HxFBJhKRwCMV5ZTsTHpIjBt7c+J6DYklNU6nKG1Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511517; c=relaxed/simple;
	bh=Oh3gvh1Pw1qxlpgIFh2j2ukWBybQ4o4q7lMKldkLy/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syTUX/AuPkpbuDbie0HCWcCsRdyrNHXh4WWr0STFZ9wkcMx1sxvLyqM/4jlL+HjOAE8QhKDW11qeMWWggIGjHVYxrvXKGg/EHUE4w5Ylh6lFmbfwmG0TajLCtLwHWvHeUhzcCnbRZazSCrE0f2HAW7wNf1CWwNiXb841JcUMzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NGd6lt8p; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1708511513;
	bh=Oh3gvh1Pw1qxlpgIFh2j2ukWBybQ4o4q7lMKldkLy/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NGd6lt8pyEA17xui9odAE9LSFX6wxR1ZmmYK8Gb06gBbOSfUJ3hh+cyXSeGNYKH5c
	 AA87aRIpu9zAgNUIagytDHZR4HBh/2b6QoMaSvQQtqreWFrBHJiR0jjPl/FlKgqPLq
	 vtLKOfDtXWmKRqTic+8hPNr9WqieNkpXUGvunf5o=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A19CD6722C;
	Wed, 21 Feb 2024 05:31:48 -0500 (EST)
Message-ID: <2d25e3bb829cbca51387eb84985db919f50ccd37.camel@xry111.site>
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
Date: Wed, 21 Feb 2024 18:31:46 +0800
In-Reply-To: <f1a1bc708be543eb647df57b5eb0c0ef035baf8b.camel@xry111.site>
References: <599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name>
	 <f1a1bc708be543eb647df57b5eb0c0ef035baf8b.camel@xry111.site>
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

On Wed, 2024-02-21 at 14:31 +0800, Xi Ruoyao wrote:
> On Wed, 2024-02-21 at 14:09 +0800, WANG Xuerui wrote:
>=20
> > - just restore fstat and be done with it;
> > - add a flag to statx so we can do the equivalent of just fstat(fd,=20
> > &out) with statx, and ensuring an error happens if path is not empty in=
=20
> > that case;
>=20
> It's worse than "just restore fstat" considering the performance.=C2=A0 R=
ead
> this thread:
> https://sourceware.org/pipermail/libc-alpha/2023-September/151320.html

Hmm, but it looks like statx already suffers the same performance issue.
And in this libc-alpha discussion Linus said:

   If the user asked for 'fstat()', just give the user 'fstat()'.
  =20
So to me we should just add fstat (and use it in Glibc for LoongArch, only
falling back to statx if fstat returns -ENOSYS), or am I missing something?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

