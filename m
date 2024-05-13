Return-Path: <linux-arch+bounces-4354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE388C3BB7
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 09:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801131C20FBE
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B5146A64;
	Mon, 13 May 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TqZ5VZwi"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B51FA1;
	Mon, 13 May 2024 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584224; cv=none; b=Jf4KZosghsaMPcphx/OsEucc4M39fqFbf82ByVK6aUSlH2pDr8pr0zxsp65ShDJ1LCJcnUDDnWT56kpd1DF7I/kW+L9/GjtpndG+tI1oKkJm33QTGfZ9KcyOAgoe9gOEwO3xVbcDyE9w7md8T+im/a2LoTDJ8RPS4qcM8Ke4o7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584224; c=relaxed/simple;
	bh=cIaTuup17FLKy3SKuokzSPWCxTVA5LU27DQa4gaT41A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5JBCju5UmOxcZNsGe/c8GqnwPrx7x3m3LvBjEWq26wFxztcX+JCrxPqDbp+/hQT0WJnRhMkr8Q6FjX79pFGw78PaFl2o+eoEX4AMVQnBapZWpcwHnfbBf21gDyTI3rifEcPNIZeA9yVQjOJ787/w6vk5O7mQJn8VJFbzT7zGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TqZ5VZwi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1VtKiyWvSIZUu5Z+IFOoMq7wXL01ztBGeKBNrRkF5Q0=; t=1715584221; x=1716189021; 
	b=TqZ5VZwiDA+9WqIxBxXmBes+IiT6T/ilgEpP68YU1JY4qd5EyB1VJ/KLL6lg2E5Zv+bAr0W5Mh5
	bZFyqXqAOG9Lws50Tk3xuV27SYp1okJKrGPqwgkb5C98bJuTdGZu/SkDVdyil0duFU6tkgaHutLMr
	WoQHrJKZTxt5Q9HS9x96i4QTCcPV0m9HiPlYSAewba+/zCX6e5p/MJdrwpU2HNbxGt3emGAZwSjtG
	DNDW0+Q6uyfhqt1K/1Z/ViPPhu8CyOvqFIJ7O5RT7Zpn7nTy3Jzf6U0GBTakCgK8uEdB73iQq3wW7
	Y2hIFxeugMi7OKSavoQ4q9OWPABh4pyY7NJw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6Pp6-00000000bvh-0V38; Mon, 13 May 2024 09:10:12 +0200
Received: from p57bd9c8e.dip0.t-ipconnect.de ([87.189.156.142] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6Pp5-00000000iGC-3l6B; Mon, 13 May 2024 09:10:12 +0200
Message-ID: <ca22cfceb465dcbc336f51621f844593aa45619f.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: paulmck@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>
Date: Mon, 13 May 2024 09:10:11 +0200
In-Reply-To: <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
	 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
	 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
	 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
	 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
	 <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
	 <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>
	 <f01d9eb2-9ab8-4e82-99d2-467385ebce2b@paulmck-laptop>
	 <975442500864e4f30a830afb4ffd09a9bedb65d6.camel@physik.fu-berlin.de>
	 <a8241a71-2b7d-4be0-8772-5c3b40fb5302@paulmck-laptop>
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

Hello,

On Sun, 2024-05-12 at 07:44 -0700, Paul E. McKenney wrote:
> On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote=
:
> > On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
> > > And that breaks things because it can clobber concurrent stores to
> > > other bytes in that enclosing machine word.
> >=20
> > But pre-EV56 Alpha has always been like this. What makes it broken
> > all of a sudden?
>=20
> I doubt if it was sudden.   Putting concurrently (but rarely) accessed
> small-value quantities into single bytes is a very natural thing to do,
> and I bet that there are quite a few places in the kernel where exactly
> this happens.  I happen to know of a specific instance that went into
> mainline about two years ago.

But it's treated like it happened all of a sudden instead of taking the way
of a proper phaseout. That's what I am criticizing.

> > We could actually ask Ulrich Teichert what the current state is
> > on his Jensen machine.
>=20
> Please feel free to do so.
>=20
> And if the ability to run current mainline reliably on these systems
> is so very important to you, please also feel free to look into ways of
> fixing this issue within the confines of the Alpha-specific code rather
> than attempting to continue placing this outdated constraint on the rest
> of the kernel.

Well, we have had a similar discussion just a few months before with the
ia64 removal. But in that case we agreed that a good compromise would be
to slate the removal for an LTS release so that users would be able to use
an LTS kernel on these machines.

I'm not sure why this shouldn't be possible in this case as well.

> Yes, it is no longer the year 1973, but it still is the case that using
> four bytes (or, worse yet, per Arnd, eight bytes) where one byte will
> do is wasting a huge amount of resources across the billions of systems
> on which the Linux kernel runs.  So again, if running current mainline
> on these decades-old systems is so very important to you, please figure
> out a way to do so that isn't quite so wasteful of resources.

The way this whole change was pushed through doesn't sound like you're will=
ing
to give people the time to find an alternative solution. The pre-EV56 remov=
al
was pushed through without any further discussion with the claim that pre-E=
V56
support is broken.

Is that not something that can be criticized?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

