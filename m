Return-Path: <linux-arch+bounces-4910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E467E909722
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1CD1C22201
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75101C280;
	Sat, 15 Jun 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="C7IePpto"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C0179A8;
	Sat, 15 Jun 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441714; cv=none; b=heSlwYpdcqtkt+ypn3AedU1lad2n+MRvIBVdxUrOa9+3UYopEEiWKfVETzDvAEZFe6XC9RqFGbEi4TyH1jX5Isl2aN28H5StA9Dv09O+STPQEr1lf+WSg2TJLuw6cnzy7T0lmqVaauYfRX1JXLNmH10SNCQKgHN+0+8Wx9JF3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441714; c=relaxed/simple;
	bh=gjwUXfnpJrMIPFPi48+TIaXScjHDYpomx5mQ/+7wIGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjn6mwfFkddB2pFXv5wGSCIC8jKsHcn2kLY6ixEXp5QOCzV4GWmfjxL2wsZu57AavLJS09FD5bmlWqPurpmKkxs4dww6kkeuISRCDjTRqBXjY90fU0x7iPxducyi+LQXWVcu6qTHHcJzE1+BDawt8XWxpryi2mO4AszefDcWxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=C7IePpto; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718441712;
	bh=gjwUXfnpJrMIPFPi48+TIaXScjHDYpomx5mQ/+7wIGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C7IePpto9XQdhZ0+o4x8Pi2AqxX1rurIZRgQWuTDAizCNamJN8Jjkxk59QxJzN41l
	 XnhAjNNgw0nCFF9pz7EuECbOJ2RWIzdzIiiwQeiJKj7JHPXfULBTGGQyVuq4qD27aw
	 9uf1HnHz/BpFdYMJjKaRRGme9ygi8tucgdhUKe5U=
Received: from [192.168.124.13] (unknown [113.200.174.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0115667456;
	Sat, 15 Jun 2024 04:55:09 -0400 (EDT)
Message-ID: <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li
 <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org,  loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
Date: Sat, 15 Jun 2024 16:55:08 +0800
In-Reply-To: <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
	 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
	 <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
	 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com>
	 <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
	 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
	 <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 16:52 +0800, Huacai Chen wrote:
> Hi, Arnd,
>=20
> On Sun, May 12, 2024 at 3:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >=20
> > On Sun, May 12, 2024, at 05:11, Huacai Chen wrote:
> > > On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de=
> wrote:
> > > > On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
> > > > > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb=
.de> wrote:
> > > > CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
> > > > this is the only allowed configuration, while on others (arm32
> > > > or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
> > > > both 32-bit kernel and on 64-bit kernels with compat mode.
> > > I don't know too much detail, but I think riscv32 can do something
> > > similar to arm32 and x86-32, or we can wait for Xuerui to improve
> > > seccomp. But there is no much time for loongarch because the Debian
> > > loong64 port is coming soon.
> >=20
> > What I meant is that the other architectures only work by
> > accident if COMPAT_32BIT_TIME is enabled and statx() gets
> > blocked, but then they truncate the timestamps to the tim32
> > range, which is not acceptable behavior. Actually mips64 is
> > in the same situation because it also only supports 32-bit
> > timestamps in newstatat(), despite being a 64-bit
> > architecture with a 64-bit time_t in all other syscalls.
> We can only wait for the seccomp side to be fixed now? Or we can get
> this patch upstream for LoongArch64 at the moment, and wait for
> seccomp to fix RISCV32 (and LoongArch32) in future?

I'm wondering why not just introduce a new syscall or extend statx with
a new flag, as we've discussed many times.  They have their own
disadvantages but better than this, IMO.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

