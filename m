Return-Path: <linux-arch+bounces-7743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A399269D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0901D1C223FE
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF86187855;
	Mon,  7 Oct 2024 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sFkqfEpy"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AB17BB1A;
	Mon,  7 Oct 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288406; cv=none; b=CxTApTlrYEA2DPqR/1xnz88Zv2VMRkJrHDCeay7f2OgIS2uq5xF1bw1iTGBijxl8S4hUM//+87jih74EVwPKaVx/whcWleia36QVL8XfJtzsYuMj1LJCwfx1NU2+Hj2BWj8lGIroCYDepp9gLprv9IskJfetQ8wQMA8gL/prDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288406; c=relaxed/simple;
	bh=VxsmENQliA0ha+9UHH8CUYn0b71VDQoYtn36QSYVOrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfJUB328XAIQU4NJnjPMdp9s1RnqjgNJ8BZKkler8EpC+fh31WdzD9br0TTZ6oZKHBZfI6ilynK1ON142BOnOwWFoKhNhf7AMjxA1aadm1fs/8OeD8A4Amk7RM+GtA39Dkj7sHeOOKUTJPeXCdFMsY9KXERlHrlDnGcI9YjgjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sFkqfEpy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VxsmENQliA0ha+9UHH8CUYn0b71VDQoYtn36QSYVOrQ=;
	t=1728288404; x=1729498004; b=sFkqfEpyYAdlDk/DhaKUjZOXOw429nuvBW0nP2YCYecxZIQ
	V7NCA4NEUNty7YgVqFnK3xlm8EUDjFjX+/m4Q1gdZ4EkMJ19HCxD0fY0cL8p6UQRprkUyMtofEOsS
	TXj5YPd/1ibsl7rgwTTw30eWKLYUPS3y/VGbQdEgPfBy9VeoOnqCaDIgzHl92O8+jgSXZRbPQy6dT
	0npHOXyJVlMvvIl1wMDzeFDD+yjz3923G8TTFW9xhPp2zWs46u2RU1lPqwdJksFeC5M9Go/X/g3UG
	fgxUj5QZEUJuVFw+e8PBiOrBwLwGHltPakBognnv8mBS71ziJvTOvel6fd+0QK0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxikz-00000003EXo-1qzg;
	Mon, 07 Oct 2024 10:06:17 +0200
Message-ID: <529f8d49b048af53b6b7e82197fe487b687241b3.camel@sipsolutions.net>
Subject: Re: [PATCH v7 09/10] um: Add dummy implementation for IO
 memcpy/memset
From: Johannes Berg <johannes@sipsolutions.net>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,  Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>,  Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
  Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>,  Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Richard
 Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
	 <ysionneau@kalrayinc.com>
Date: Mon, 07 Oct 2024 10:06:15 +0200
In-Reply-To: <54985915-be13-46ee-ad42-7dd5d9d245ac@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
	 <20240930132321.2785718-10-jvetter@kalrayinc.com>
	 <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
	 <54985915-be13-46ee-ad42-7dd5d9d245ac@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-07 at 09:49 +0200, Julian Vetter wrote:
>=20
> > > The um arch is the only architecture that sets the config 'NO_IOMEM',

(you did note this, for the comment below)

> No, I think you're understanding the series correctly. It doesn't work.=
=20
> I will revert this.

OK.

> > You're adding these inlines unconditionally, so if this included
> > logic_io.h, you should get symbol conflicts?
> >=20
> > Also not sure these functions should/need to do anything at all, there'=
s
> > no IO memory on ARCH=3Dum in case of not having logic_io.h. Maybe even
> > BUG_ON() or something? It can't be reachable (under correct drivers)
> > since ioremap() always returns NULL (without logic_iomem).

> Thanks. You're right. I added this patch because there was a build robot=
=20
> on some mailinglist building a random config with 'ARCH=3Dum' and with=
=20
> some MTD drivers that actually use memcpy_fromio or memcpy_toio. These=
=20
> drivers are not guarded by a 'depends on HAS_IOMEM'. I thought I could=
=20
> simply fix it by adding stub functions to the um arch. Because I saw=20
> there are A LOT of drivers that use IO functions without being guarded=
=20
> by 'depends on HAS_IOMEM'. Not sure though, how to handle this case.

Right, well, as you noted above ARCH=3Dum is the only architecture that
has NO_IOMEM, so I suppose drivers are just broken. But e.g.
kernel/iomem.c is also only ever built if you have HAS_IOMEM, so devm_*
functions related to this are not available.

So I don't know. On the one hand, it feels correct to have NO_IOMEM and
HAS_IOMEM, on the other hand that's a bit of a fight against windmills?


What happens now though? Seems it should _already_ not build with
ARCH=3Dum and memcpy_*io() being used? No, I guess it picked up the asm-
generic version?

Hm. I'm almost thinking we should let such drivers not build, and then
see that they add appropriate HAS_IOMEM dependencies, but ... windmills?

johannes

