Return-Path: <linux-arch+bounces-4136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124548B9BB2
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437B21C2118F
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546A13C3CA;
	Thu,  2 May 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhp54mU9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023B41C60;
	Thu,  2 May 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656830; cv=none; b=PG4iO/alb6nPzWMp3c2e3A6WCYAhHw+eiVBK7/rQYKOXtKeYKFKHPwUmYkcL0q0diXGX5HuoQ9E10LXozWtvde+01569GgT0zX9OKCldjQKIlFRhv01KcQW/9s63hkWX7jg/mWrGO5fpnT9OF7mQNEDHzvbEjwANx8VCs26VlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656830; c=relaxed/simple;
	bh=/S7AtR8fKpgwqpaJ4A1qTHav5smcrL3bhTiibfOG55k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLXDPxzg2PbhwjFaVTGHhkhjuQHkyyZgHIftSdTHiFTsCZme9VKRixPwmjL9meY1F20wwx4VU4mDaGvDttY8UyIF4rv/x6bpfm5bTQLzUzO8bJCKCeFN8gq35LOYGWtSe6er4ipMRIPxoI7pbaCZHSP8BbmE1NLySiM1LVofLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhp54mU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B42C113CC;
	Thu,  2 May 2024 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714656830;
	bh=/S7AtR8fKpgwqpaJ4A1qTHav5smcrL3bhTiibfOG55k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Qhp54mU9jSSXO0Ilw5t8MMapJa5zcPhdM7R/X2INQGEYXTACs8zzcib5Rqs3EgxCj
	 veRnIhxG15azWVufx1iZFF87MuXz+ByGER8OjVUnRC0e/V5c7xjc+Oa3c9LxcLRuYW
	 LWxD6fVUp4TIpgBONS39StM80YhPGgF4nB9un5+oyTnXU8M0oKajjxTJH/eYpMv4tQ
	 m7ILTBNi1VCcl4olk1JSxpTyffW8LsK3arQ5WIkP95XaRWDkZct6bjkUqqX1R3lksy
	 RLIgtIsz/SnMo4CevZWIMUlTLSEFmm0Mf/uG+N/XEs5lREqxXHmZDErRU3z4jj+8Xu
	 JZcthxNuirWRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC0A6CE0A32; Thu,  2 May 2024 06:33:49 -0700 (PDT)
Date: Thu, 2 May 2024 06:33:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>

On Thu, May 02, 2024 at 07:11:52AM +0200, John Paul Adrian Glaubitz wrote:
> On Wed, 2024-05-01 at 22:06 -0700, Paul E. McKenney wrote:
> > > Does cmpxchg_emu_u8() have any advantages over the native xchg_u8()?
> > 
> > That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?
> 
> Indeed. I realized this after sending my reply.

No problem, as I do know that feeling!

> > Or am I missing something subtle here that makes sh also support one-byte
> > (8-bit) cmpxchg()?
> 
> Is there an explanation available that explains the rationale behind the
> series, so I can learn more about it?

We have some places in mainline that need one-byte cmpxchg(), so this
series provides emulation for architectures that do not support this
notion.

> Also, I am opposed to removing Alpha entirely as it's still being actively
> maintained in Debian and Gentoo and works well.

Understood, and this sort of compatibility consideration is why this
version of this patchset does not emulate two-byte (16-bit) cmpxchg()
operations.  The original (RFC) series did emulate these, which does
not work on a few architectures that do not provide 16-bit load/store
instructions, hence no 16-bit support in this series.

So this one-byte-only series affects only Alpha systems lacking
single-byte load/store instructions.  If I understand correctly, Alpha
21164A (EV56) and later *do* have single-byte load/store instructions,
and thus are still just fine.  In fact, it looks like EV56 also has
two-byte load/store instructions, and so would have been OK with
the original one-/two-byte RFC series.

Arnd will not be shy about correcting me if I am wrong.  ;-)

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

