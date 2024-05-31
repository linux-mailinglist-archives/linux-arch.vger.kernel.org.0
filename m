Return-Path: <linux-arch+bounces-4629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A28D58BE
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 04:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D40287655
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 02:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C2757EE;
	Fri, 31 May 2024 02:53:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EDD256D;
	Fri, 31 May 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124007; cv=none; b=ZS2mfHtttkyWAe2T59EUWOIAftAHiveGon640u3dYHf7h+Xt43ClHyM3SLckfTo9wL2AE7P5ZcBcfR7FzuPy32M2DqonPCh5TZfQuqt7jInTdtGMG/PmzBQgYHCnfDul8/dTrhTdZ8shwHtTByhmlmirARGWIVhc8KiAxBwj2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124007; c=relaxed/simple;
	bh=nodIbOdPoKIokjXmVQX8k90b5CU5WcK6Y6zL/0OO9zE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XpUJ53MTTstxp2ogjFKOq/bJZqbjeopI1l5VFEucc3566f97n/97LVJVbs5qNk4H25LIfYzIZvUxX/aCsnww4j1VReBcaJvMQTeqw3aDhaMssKe5bQiRNbWYZfgmewwnPgZPgj2+it294qmTksNk4AA/J+jPiLxy2gnXBprPLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 46B0592009C; Fri, 31 May 2024 04:53:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 360DF92009B;
	Fri, 31 May 2024 03:53:23 +0100 (BST)
Date: Fri, 31 May 2024 03:53:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
    Linux-Arch <linux-arch@vger.kernel.org>, linux-alpha@vger.kernel.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
In-Reply-To: <c585d63e73453082ecbf7ddc19d5116abdcfba79.camel@physik.fu-berlin.de>
Message-ID: <alpine.DEB.2.21.2405310350360.23854@angie.orcam.me.uk>
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>  <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>  <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
 <c585d63e73453082ecbf7ddc19d5116abdcfba79.camel@physik.fu-berlin.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 May 2024, John Paul Adrian Glaubitz wrote:

> > Well, despite the discussion about timing of this, I have pulled this.
> > I still have a fond spot for alpha, even if it has the worst memory
> > ordering ever devised, but the lack of byte operations was an
> > inexcusable "we can deal with that in the compiler" senior moment in
> > the design. So good riddance.
> 
> As someone who spends a lot of personal time and energy and even money into
> Linux, I have to say the way this change was steamrolled into the kernel
> without any real discussion actually hurts.
> 
> It's days like these when I'm starting to question my efforts.

 FWIW, me too (the other factor being recurring PSU failures).  Sigh...

  Maciej

