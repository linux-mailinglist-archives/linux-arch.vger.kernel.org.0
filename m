Return-Path: <linux-arch+bounces-14913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 632AFC6F5F9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07F893674E7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E04366DD4;
	Wed, 19 Nov 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SONc/yve"
X-Original-To: linux-arch@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4FE2765C5;
	Wed, 19 Nov 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562549; cv=none; b=UklcMmN309c/ZEm8zJtrNXWZ7ovO4RZiYElcca0qzw1043DRv1SJ3IQjnZVIl8l6HGX7ovMyyauTIg4mPma7NvBTg0klWbRNhlhKvv19iFp5TVnacbkhw64OG+MmpWtNr7s9HzuJwYPeb+OTqJlGyXXWkenW7nQgj5s8gjBkhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562549; c=relaxed/simple;
	bh=D4pmJd3Ppn89lKNhz9R+dwK6ne/msmIoPaGjqyhpew4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDALauV4nZ7qcQfonli+9Lpm5kjsA6VvGM60MlJAcLcUMbKUwhgmimDgpMBDwwISn6IfkeWNcjZzxiqmSJsoBFEifD/hdKJu6bBaglgrymJ7s8hyLOLmhgLmQY4K6mtPOuCb/P50wek8Jd3zns1rEAYfdSIusvSWbX57S+yTHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SONc/yve; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B26B526494;
	Wed, 19 Nov 2025 15:28:59 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zSM5JGZUy_G; Wed, 19 Nov 2025 15:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763562538; bh=D4pmJd3Ppn89lKNhz9R+dwK6ne/msmIoPaGjqyhpew4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SONc/yve+hklYYQYMD3ObC5hXM4J/o7laRQONp0lQqSe8rJ8TNktdUPejDOQJT2di
	 c+8gWEJ9jmeMlMWDXnJEcPNY1R2RlJqwUDml3LddGKpBYIxlcTA5mv2BgQmO9Yw0fG
	 Dw5497L5yi8YAXdCZruLdkbaLcyMa909KCHqJWx69YC2z+GF4XZ5LWTc+usM6+KZVx
	 K2UKMnU86pjDQoylAWUpveFP+PuPujf2pmV/klJ+TiuNNEwjYasNg3FvVgE72//kug
	 5slF9knht1xKli7tp1tJ9t6FS3artrBpFLyNjSfv6GmYhdzE2Y1gAS9CggUFuLoYO6
	 zKEt/8rdj45Dg==
Date: Wed, 19 Nov 2025 14:28:41 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
	f@disroot.org, loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
Message-ID: <aR3UGUlqGFvo5aX5@pie>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn>
 <aRyoLBjD_8Hz91DV@pie>
 <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
 <04b04b74-ef13-4dd0-a35a-d629acb617cb@app.fastmail.com>
 <CAAhV-H6aM+nsK39iTDw1Fec25C7+D2UTh92X6FPf3gDouuyejQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6aM+nsK39iTDw1Fec25C7+D2UTh92X6FPf3gDouuyejQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 03:51:01PM +0800, Huacai Chen wrote:
> On Wed, Nov 19, 2025 at 2:03 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> >
> >
> > On Wed, 19 Nov 2025, at 12:28 PM, Huacai Chen wrote:
> > [...]
> > >> Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
> > >> property is also described as mandantory, thus I don't think such
> > >> fallback makes sense.
> > > Yes, "clocks" is mandatory in theory, but sometimes is missing in
> > > practice, at least in QEMU. On the other hand, if "clocks" really
> > > always exist, then the error checking in fdt_cpu_clk_init() can also
> > > be removed. So the fallback makes sense.
> >
> > IMHO this should be fixed on QEMU side, but I recall QEMU do have clock
> > supplied in generic fdt?
> It is difficult to fix, you can have a try. :)
> If without fallback, cpuinfo shows 0MHz now.

A fake "200MHz" output sounds much worse than obviously wrong "0MHz":
the latter informs the user something bad happened here, while a
mysterious "200MHz" output only makes it more confusing since no one has
specified so in the failing case.

> >
> > >
> > > Why pick 200MHz? That is because we assume the constant timer is
> > > 100MHz (which is true for all real machines), 200MHz is the minimal
> > > multiple of 100MHz, it is more reasonable than 0MHz.
> >
> > Maybe better panic here :-)
> No, this is not a fatal error, we don't need to treat everything as
> fatal. As you know, many "BUG_ON" have been replaced with "WARN_ON" in
> kernel.

But it is an error and shouldn't be ignored. I agree that panic is too
serious for this, but at least a warning should be issued.

> Huacai

Regards,
Yao Zi


> >
> > Thanks
> > --
> > - Jiaxun
> >

