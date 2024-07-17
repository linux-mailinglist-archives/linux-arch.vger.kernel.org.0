Return-Path: <linux-arch+bounces-5453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB1C9338D1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 10:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3B01C232C2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C339FC6;
	Wed, 17 Jul 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs9bfBue"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E839879;
	Wed, 17 Jul 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204230; cv=none; b=EFXsb3KPnd476MVw3iY0BQOQqx3WT3Au0gn5nREyZFqATFRX70YkdnEX4uqbvInPj9CmWesntUMzk64WbNjt1ikd4Jz4Ja4eraWRBFoKV9k3+Pr6FM4N0Yktv/J8Q3RvsEQRmzfelH0UehL7Cz08k2K4aQGJyRtmCMTC2I34Hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204230; c=relaxed/simple;
	bh=rSLQAE5R5XyJVKc3bL13vDnmqk+hn+xn+GeAR87Ppeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukOWs56YaBWqp3xxHPmLFbhUY2p/BJ+ow5apH0Ie8hNg72K+uGcgLezX785+KWf6iK+DqUKBsdaLzz55BmwqvdtLU3okqsqQ/RkUjS18AD8qiAKntzrp+WeszMBTEzWid48Hbeur8kaCW/dgzr8e+n4TRmo07rxA7BblxOBw4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs9bfBue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77758C32782;
	Wed, 17 Jul 2024 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721204229;
	bh=rSLQAE5R5XyJVKc3bL13vDnmqk+hn+xn+GeAR87Ppeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs9bfBuepk0tW64t9UP6JapsBWLgEUwmlAc2KyxVx4NUGCm3YuGnM5hmpwDeUHVd3
	 v4a/qhFqoqRn8LrZSc5qr2WOIy3akxIVyaDrwOHmMcSG++1/H6EmHJ6+HQL+Sa97I2
	 XCM3fMvjsbLDQvOIj9gfmTjrdSulOUGeQfgN1viWZHi2xxiDFLsuZNrhZ6+TTaTs2b
	 hS69zFhzGSEZnoRNaTpQos2uv049YlI0vpcU5Kuv6PTB79BRIrqWYgY3IWOS379p64
	 9spyEkXtHrFY6CWh1Jh6vJHq40b4Ah5aBshIvPxYpgpoH9eCLmLYkTDJYudivKqRA1
	 TdOlhPvTxLW7w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTzqZ-000000000I0-08bF;
	Wed, 17 Jul 2024 10:17:11 +0200
Date: Wed, 17 Jul 2024 10:17:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: Re: [GIT PULL] asm-generic updates for 6.11
Message-ID: <Zpd-Bx3VwrYWVeTs@hovoldconsulting.com>
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
 <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
 <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
 <2b6336d1-34e0-48dd-b901-7b5208045597@app.fastmail.com>
 <ZpdnhhaQum_epcGp@hovoldconsulting.com>
 <be80d8f6-2a1b-4f63-a43e-652fa5328d11@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be80d8f6-2a1b-4f63-a43e-652fa5328d11@app.fastmail.com>

On Wed, Jul 17, 2024 at 10:01:10AM +0200, Arnd Bergmann wrote:
> On Wed, Jul 17, 2024, at 08:41, Johan Hovold wrote:

> > FWIW, I noticed this last Friday as well when I did a few builds of
> > linux-next and every change I made triggered what appeared to be a full
> > rebuild of the tree.
> >
> > This was with a trimmed config [1] and separate build tree (tmpfs).
> 
> Thanks, that makes it quicker to try out. I'm now using
> your config to do more testing. I still don't see it with
> a normal build though.
> 
> I do see that setting the timestamp of syscall.tbl to
> a future date does result in always rebuilding everything,
> but I don't think that is what you are seeing, since that
> also produces a warning from make:
> 
> arnd@studio:~/arm-soc/build/bisect$ touch -t 202501010000 arch/x86/entry/syscalls/syscall_64.tbl 
> arnd@studio:~/arm-soc/build/bisect$ make ARCH=x86 CROSS_COMPILE=x86_64-linux- 
> make[2]: Warning: File 'arch/x86/entry/syscalls/syscall_64.tbl' has modification time 14483017 s in the future
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
>   SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
>   SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
> make[2]: warning:  Clock skew detected.  Your build may be incomplete.

Yeah, that's not something I noticed at least (and I assume I would
have). And I only did aarch64 builds on a 6.9 x86_64 host (make 4.4.1).

Johan

