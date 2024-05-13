Return-Path: <linux-arch+bounces-4371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334D8C4625
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4609B280C7D
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AA1C687;
	Mon, 13 May 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ulrich-teichert.org header.i=@ulrich-teichert.org header.b="mOlOjyy9"
X-Original-To: linux-arch@vger.kernel.org
Received: from wp441.webpack.hosteurope.de (wp441.webpack.hosteurope.de [80.237.133.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91532C190;
	Mon, 13 May 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.133.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621684; cv=none; b=hKcYx+Q6ItgkVqHOpuhsURyAPdR3S7txUCK/j1Yy/zBwS30ZUmE0xYrqkK+al1ekOtdVTeMi32Dv3qKnQ7a9yljyS1NXtQRQouQTAgePOCVh8IVPvpWbP17VklOMow75FT8PgF6grdCNWa9PvZpZ+vDwCDSnDzKhUkgXwKVui4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621684; c=relaxed/simple;
	bh=RjuB/bZTODZJ0KhRm7Wf7eYTPm6izVl1WgnIq448cKw=;
	h=Message-Id:Subject:To:Date:Cc:In-Reply-To:From:MIME-Version:
	 Content-Type; b=mQ1aeSHU8YjEQjWd3GQk1137fFHOso+WFBNExS+bPmyL/FGGpM7e+PPRlZDkXiXhrlPShkl9LjEbzX5GLOTvnrPtY6jr+aY/Gt0RxEFi8fcWQRpglCmBxAadoipkyJgQo61xhDhZB+OaCDbb5xm8xHh5G2mI/Edttccuy9CObe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ulrich-teichert.org; spf=pass smtp.mailfrom=ulrich-teichert.org; dkim=pass (2048-bit key) header.d=ulrich-teichert.org header.i=@ulrich-teichert.org header.b=mOlOjyy9; arc=none smtp.client-ip=80.237.133.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ulrich-teichert.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ulrich-teichert.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ulrich-teichert.org; s=he219537; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:From:In-Reply-To:Cc:Date:To:Subject:Message-Id:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=HTaf2Q1Js0w1JEG7adnW654h8ouqk/EoSw1gVBmO+yU=; t=1715621683;
	x=1716053683; b=mOlOjyy95u9CBBZm+rH+6W3dbYAsyHGwOHDas++2n9K8JX3Nfx1gXH5MJk/Go
	R5Cpat9HplezFVRnvybxkhA0QEmQBpWy6/FlhXhHeOXnxaLPmY9U4rYOpqBvD7LvkY2MCoTDKsFw7
	ecj0aOI+agl7XPkfo8WB6cWXkQusz5ke0rLXmM0if6DrMsojJyZeh9LOGznmnPF/5WUvaLxJuMT3f
	JIL2Mdgf9SpZt46mfMepPjk1DBuMY8w89q2X0lAC8bFpfQV3uvbo8awamNQgVlsDt8znV9QMlZUdf
	/NT+fnL0OuBJp3OTHd+V0WjkwnAjrKA72Ts3ed6W2zMVdxk9iA==;
Received: from [2a03:7846:b79f:101:21c:c4ff:fe1f:fd93] (helo=valdese.nms-ulrich-teichert.org); authenticated
	by wp441.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s6YuY-0005eL-4Z; Mon, 13 May 2024 18:52:26 +0200
Received: from valdese.nms-ulrich-teichert.org (localhost [127.0.0.1])
	by valdese.nms-ulrich-teichert.org (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 44DGqNBm007654
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 18:52:23 +0200
Received: (from ut@localhost)
	by valdese.nms-ulrich-teichert.org (8.15.2/8.15.2/Submit) id 44DGqMjs007653;
	Mon, 13 May 2024 18:52:22 +0200
Message-Id: <202405131652.44DGqMjs007653@valdese.nms-ulrich-teichert.org>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
To: akiyks@gmail.com (Akira Yokosawa)
Date: Mon, 13 May 2024 18:52:22 +0200 (CEST)
Cc: paulmck@kernel.org, arnd@arndb.de, glaubitz@physik.fu-berlin.de,
        ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattst88@gmail.com, richard.henderson@linaro.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        krypton@ulrich-teichert.org (Ulrich Teichert),
        akiyks@gmail.com (Akira Yokosawa)
In-Reply-To: <99765904-3f35-4c78-998e-b444a6ab90e4@gmail.com>
From: Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL8]
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;ut@ulrich-teichert.org;1715621683;92f8b63b;
X-HE-SMSGID: 1s6YuY-0005eL-4Z

Hi,

> On Sun, 12 May 2024 07:44:25 -0700, Paul E. McKenney wrote:
> > On Sun, May 12, 2024 at 08:02:59AM +0200, John Paul Adrian Glaubitz wrote:
> >> On Sat, 2024-05-11 at 18:26 -0700, Paul E. McKenney wrote:
> >> > And that breaks things because it can clobber concurrent stores to
> >> > other bytes in that enclosing machine word.
> >> 
> >> But pre-EV56 Alpha has always been like this. What makes it broken
> >> all of a sudden?
> > 
> > I doubt if it was sudden.   Putting concurrently (but rarely) accessed
> > small-value quantities into single bytes is a very natural thing to do,
> > and I bet that there are quite a few places in the kernel where exactly
> > this happens.  I happen to know of a specific instance that went into
> > mainline about two years ago.
> > 
> > So why didn't the people running current mainline on pre-EV56 Alpha
> > systems notice?  One possibility is that they are upgrading their
> > kernels only occasionally.  Another possibility is that they are seeing
> > the failures, but are not tracing the obtuse failure modes back to the
> > change(s) in question.  Yet another possibility is that the resulting
> > failures are very low probability, with mean times to failure that are
> > so long that you won't notice anything on a single system.
> 
> Another possibility is that the Jensen system was booted into uni processer
> mode.  Looking at the early boot log [1] provided by Ulrich (+CCed) back in
> Sept. 2021, I see the following by running "grep -i cpu":
> 
> >> > [1] https://marc.info/?l=linux-alpha&m=163265555616841&w=2
> 
> [    0.000000] Memory: 90256K/131072K available (8897K kernel code, 9499K rwdata, \
> 2704K rodata, 312K init, 437K bss, 40816K reserved, 0K cma-reserved) [    0.000000] \
> random: get_random_u64 called from __kmem_cache_create+0x54/0x600 with crng_init=0 [  \
> 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1 [    0.000000]
>                                                      ^^^^^^
> 
> Without any concurrent atomic updates, the "broken" atomic accesses won't
> matter, I guess.

I've probably disabled SMP in my test kernel, the jensen is a single CPU
system. I never had the pleasure of owning an AlphaServer 2000 or 2100,
which (according to https://en.wikipedia.org/wiki/AlphaServer and
https://en.wikipedia.org/wiki/AlphaStation) are the only systems
with EV4/EV45/EV5 multi-CPU setups (apart from the Cray T3{DE}), so
the possibility of ever seeing an error concerning atomic concurrent
updates is quite low.

Anybody out there with an AlphaServer 2000/2100 willing to try ?-)

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de | Listening to:
Stormweg 24               |The Hives: Two Kinds Of Trouble, The Chats: 6L GTR,
24539 Neumuenster, Germany|La Fraction: Les Démons, Nightwatchers: On a Mission

