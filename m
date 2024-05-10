Return-Path: <linux-arch+bounces-4302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D48C2C9B
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7131285D64
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860013D244;
	Fri, 10 May 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMwCFRc6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E913C3D6;
	Fri, 10 May 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380082; cv=none; b=U631g//fb6j23KxVOT6zioqB1aoZ3UFfqz4q30FZQ2d0fVLMDMW6uR6FVism07sN48UhKyNiVrVM8AHOpqbJyzCndFjOioZjRKIuRJmW3OSPKcygpJH7xxVeYZVgXt1CReSOc7ZXHGmXpsbHrPDK3D/0ypDPTpi+6RX+Hfm0dUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380082; c=relaxed/simple;
	bh=TfXhzLc8LZpaUBRQEI8FHkJhBfZFDBgODilK/AieE9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq1a5TtyzzGL5ULYDbgGpTok38qh8CmqoRpIP2+kYbiTRoMaJ1LMHErsOi+iXbfucznl5R2x4GKhBvFbSHSaNrQxgtViC84dt7dVH5nZsw2haj6TNSp8roZ21f+6BXvtm0kCjDxythJ7PrFQw8svwWVB7kT5I1nEfi+6djGV3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMwCFRc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B84C113CC;
	Fri, 10 May 2024 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715380081;
	bh=TfXhzLc8LZpaUBRQEI8FHkJhBfZFDBgODilK/AieE9w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sMwCFRc6WSXs/UX5a8qwqV/meX5DzMmubQ7UsPhE/MH9RjqQ7ni+4F7iiYBWV91BC
	 73Btb/L5jvM76BTVtQCqB057cvnWADwWFeQn1D6sgiBpjlgxhGWKIBpsAZKEKNOIvS
	 CNL6HxFKQYXhgxoDDDQYhIkMGn9ER/KYiV8vdQqiVMckhOrkluhvb5dZ2XTDQjTnak
	 ZpsxPEFM6YGWNqnhLCo82JLQGfgVCRJSC6+lPMdsGWhfWRq4BxcrFRxsJc3Y65n9Vj
	 7I7E+t2iF5Jcc2ouuYm2SM51ZGeSdLOPkTpl3KoR+TWFbFmJU2lgyOvT3he27hZ3Nn
	 PA6wPEf4t02yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A351CE0F90; Fri, 10 May 2024 15:28:01 -0700 (PDT)
Date: Fri, 10 May 2024 15:28:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-alpha@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Message-ID: <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>

On Fri, May 10, 2024 at 11:40:04PM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2024-05-10 at 23:19 +0200, Arnd Bergmann wrote:
> > The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:
> > 
> >   Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha
> > 
> > for you to fetch changes up to a4184174be36369c3af8d937e165f28a43ef1e02:
> > 
> >   alpha: drop pre-EV56 support (2024-05-06 12:05:00 +0200)
> 
> I'm still against dropping pre-EV56 so quickly without a proper phaseout period.
> Why not wait for the next LTS release? AFAIK pre-EV56 support is not broken, is
> it?

Sadly, yes, it is, and it has been broken in mainline for almost two
years.

							Thanx, Paul

