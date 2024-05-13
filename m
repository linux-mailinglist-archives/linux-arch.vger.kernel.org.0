Return-Path: <linux-arch+bounces-4355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE78C3E1B
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CAD1F22806
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0B1487E5;
	Mon, 13 May 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pkOsR+8Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963921487E2;
	Mon, 13 May 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592383; cv=none; b=sLOnQwOzY/+GifBX7XzBy+ZoJ02tABm3fjQQu+nXz59fFLCX5vjjLxJzhgUh2fhhSw5Nz/oGagwyRcRaeVg62uJss7AFu2eLp0hJ2Ejl1TpDonId9c0gI2HkePMElLPk0Y7cCpgt/BKcG49TA8YrSeYjnXQwIWUFSEYUkHD+8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592383; c=relaxed/simple;
	bh=3+SaavHS99Cwl9vnJNW3fGg2az9uoJolKOnYP9G3qq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VsSpTVz/BycMBxPMHjhhUsI2Ta8eMPys9jX//HuwMwTHm2V6JfX11tGFjoSWe47hVuIwAvANqr2mOldf8oHm06O6Wzzp5sGU5AzEenY7bnWiD+AmOLslXgMd06jQyn54GIZ4EH8TtfR92qBnA9jtqDbUxfRgDk1POeBXZdVJ5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pkOsR+8Y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n5fYRKZOOxszQhTBpaiPHWnUxAoMygv8dpLvNys6cPY=; t=1715592380; x=1716197180; 
	b=pkOsR+8Yqc+Y9fAE28msFVTFGfDsbS4idyMMNjQwFQEiSghHF5aNnqwEyrEO8Q5nhEnfJP2wwwZ
	cWexG6VMZ9eq0gnSun140e/DzsQ7CGS0Kbe49QJaNCXlZ6JMKc47Rbu3ofzBchv+/k02uG5lta1Re
	O0UZke3gh7/YXRl9GCbs5YOwT9zXLl4PLFmftogkEAWswBi0bRDyZ/gAKrmeT2KZPK8o5y0yI/cJ3
	fgDIoDczxvy8AuZ82RXg8hy7CgnemaxS7OcoF0E/OeZrah/yqFqqhVQoSI+yubwauo+5BamiP78TD
	nYQkWNZshbHebXGJq4t33C9S/vr+pfgfBOJA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6Rwl-00000001npY-1qbD; Mon, 13 May 2024 11:26:15 +0200
Received: from p57bd9c8e.dip0.t-ipconnect.de ([87.189.156.142] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6Rwl-00000001Efn-0s5F; Mon, 13 May 2024 11:26:15 +0200
Message-ID: <59b2fc5781c65fcedbac21142408ed6e7824e84b.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Akira Yokosawa <akiyks@gmail.com>, paulmck@kernel.org
Cc: arnd@arndb.de, ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 mattst88@gmail.com,  richard.henderson@linaro.org,
 torvalds@linux-foundation.org,  viro@zeniv.linux.org.uk, Ulrich Teichert
 <krypton@ulrich-teichert.org>
Date: Mon, 13 May 2024 11:26:14 +0200
In-Reply-To: <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
References: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
	 <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-05-13 at 12:50 +0900, Akira Yokosawa wrote:
> > So why didn't the people running current mainline on pre-EV56 Alpha
> > systems notice?  One possibility is that they are upgrading their
> > kernels only occasionally.  Another possibility is that they are seeing
> > the failures, but are not tracing the obtuse failure modes back to the
> > change(s) in question.  Yet another possibility is that the resulting
> > failures are very low probability, with mean times to failure that are
> > so long that you won't notice anything on a single system.
>=20
> Another possibility is that the Jensen system was booted into uni process=
er
> mode.  Looking at the early boot log [1] provided by Ulrich (+CCed) back =
in
> Sept. 2021, I see the following by running "grep -i cpu":
>=20
> > > > [1] https://marc.info/?l=3Dlinux-alpha&m=3D163265555616841&w=3D2
>=20
> [    0.000000] Memory: 90256K/131072K available (8897K kernel code, 9499K=
 rwdata, \
> 2704K rodata, 312K init, 437K bss, 40816K reserved, 0K cma-reserved) [   =
 0.000000] \
> random: get_random_u64 called from __kmem_cache_create+0x54/0x600 with cr=
ng_init=3D0 [  \
> 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Node=
s=3D1 [    0.000000]
>                                                      ^^^^^^
>=20
> Without any concurrent atomic updates, the "broken" atomic accesses won't
> matter, I guess.

At least from my perspective, the machines that matter for hobbyists are un=
i-processors,
i.e. workstations. I don't know of any early Alpha workstations from the ti=
p of my head
that are multi-processor.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

