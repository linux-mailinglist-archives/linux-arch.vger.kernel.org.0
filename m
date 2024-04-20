Return-Path: <linux-arch+bounces-3844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74E8ABBE9
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32178B20E60
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FB91F954;
	Sat, 20 Apr 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA6tLWNR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A417C72;
	Sat, 20 Apr 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621794; cv=none; b=aIEjWqrh9wtdgRtmTUx/FOEOaVmpfdnhDt47WoxT45hB0PJR1j5PmkYL8fHHxFyvj0RYCwCN/C94LAta9dWrwEpl5gRE7yCc6a3Yim9YdQPG2nFx0840zNx4K8lBiFzWSqcBp3VxA1K1b/94ryw0vD+GawcDpCt0lGG4Yvk+Wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621794; c=relaxed/simple;
	bh=j6lkOrCtd+gNLxThy1+PuV3iXM5UNYHHzFBGzGmoBFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9iX5YGgFDWSIlvpqqnplG+kGt/8BKDbSzlvpJdGIN1F5IiJvODTHDz/n0/WfXRmhHVyXnwgIT45VucSXMyxdVpx0pkVZw/A2LPM8wBc0FmvTUrv2lACrcRsX3sYb+E1d+n3HSEwbkn0n2tE8WoPDhVB0IOQzhz/B7g5s063lIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA6tLWNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E1C072AA;
	Sat, 20 Apr 2024 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621793;
	bh=j6lkOrCtd+gNLxThy1+PuV3iXM5UNYHHzFBGzGmoBFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XA6tLWNRApa5LwuFmgU3vSb/vcXhA3ZwE3CRuA+qT77kbtRf7mhJodIFnmnX5XipO
	 3JtjQU/ULnzDsxtLQICmRnvN+Ch1fGYnSMyXRIbzVI8hXRwxZJUt7ADVU5seZQsIoH
	 +jmloeHtFGJnaGbuBRMCOfudDXfbkenpFSDtZdFJ2sXFdN+jIo25rB/T0Zu85L61XZ
	 2KQtjeyMBFLOnozMwnQijxZweMWMOv9dtzJ5YxHhVUJ8Idg2FVlNThY/x8zy3bH6oB
	 vf0wW0v/KFl7mIgcKfNkvwyPA1V8a5h7lNej++hNO6+Cc7m/J05reotMpZ7wrnKb5I
	 81MuEjKglcbxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6186CE0AD3; Sat, 20 Apr 2024 07:03:11 -0700 (PDT)
Date: Sat, 20 Apr 2024 07:03:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yujie Liu <yujie.liu@intel.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, elver@google.com,
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org,
	dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH cmpxchg 13/14] xtensa: Emulate one-byte cmpxchg
Message-ID: <307dc632-b34a-4297-8341-2bf7d27bf6d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-13-paulmck@kernel.org>
 <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
 <620a10e8-f5c0-4e23-8403-492ab1c7f110@paulmck-laptop>
 <ZiH8IBiLkYw7M281@yujie-X299>
 <CAMuHMdUWF=O4fEA8aQfhmRhuH88zB3aK1Mi3UCXx8=EaONRRkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUWF=O4fEA8aQfhmRhuH88zB3aK1Mi3UCXx8=EaONRRkg@mail.gmail.com>

On Fri, Apr 19, 2024 at 10:02:47AM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 19, 2024 at 7:14 AM Yujie Liu <yujie.liu@intel.com> wrote:
> > On Thu, Apr 18, 2024 at 04:21:46PM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 18, 2024 at 10:06:21AM +0200, Geert Uytterhoeven wrote:
> > > > On Mon, Apr 8, 2024 at 7:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.
> > > > >
> > > > > [ paulmck: Apply kernel test robot feedback. ]
> > > > > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > > > >
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/arch/xtensa/include/asm/cmpxchg.h
> > > > > +++ b/arch/xtensa/include/asm/cmpxchg.h
> > > > > @@ -74,6 +75,7 @@ static __inline__ unsigned long
> > > > >  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> > > > >  {
> > > > >         switch (size) {
> > > > > +       case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> > > >
> > > > The cast is not needed.
> > >
> > > In both cases, kernel test robot yelled at me when it was not present.
> > >
> > > Happy to resubmit without it, though, if that is a yell that I should
> > > have ignored.
> >
> > FYI, kernel test robot did yell some reports on various architectures such as:
> >
> > [1] https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com/
> > [2] https://lore.kernel.org/oe-kbuild-all/202404040526.GVzaL2io-lkp@intel.com/
> > [3] https://lore.kernel.org/oe-kbuild-all/202404022106.mYwpypit-lkp@intel.com/
> >
> > In brief, there were mainly three types of issues:
> >
> > * The cmpxchg-emu.h header is missing
> > * The parameters of cmpxchg_emu_u8 need to be cast to corresponding types
> > * The return value of cmpxchg_emu_u8 needs to be cast to the "ret" type
> >
> > As for this specific case of xtensa arch, the compiler doesn't warn
> > regardless of whether there is an explicit cast for "ptr" or not.
> > The "ptr" being passed in is "void *", and it seems that a "void *"
> > pointer can be automatically cast to any other type of pointer, so it
> > is not necessary to have an explicit cast of "u8 *".
> >
> > As for the implementations of other architectures that don't pass the
> > "ptr" as "void *" (such as a macro implementation), the explicit cast to
> > "u8 *" may still be required.
> 
> Exactly.  On sh and xtensa, the original pointer is of type
> "volatile void *", so no cast is needed.
> On E.g. arc, the original pointer is of type "volatile __typeof__(ptr) _p_",
> which is not always compatible with "volatile u8 *".

Very good, and thank you both!  I will spin updated patches and send
them out early this coming week.

							Thanx, Paul

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

