Return-Path: <linux-arch+bounces-3821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220B8AB02F
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FEA1C22DE8
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FC12FB2A;
	Fri, 19 Apr 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJrriT5J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0812FB23;
	Fri, 19 Apr 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535409; cv=none; b=RNxbMwF2fxI9okkwOpDvZ7Gv7UHdVH5737PMRjckmYyzwnuYT2+Y5IDbtnamvvuPlXG1dKwCUZmCxBVlL4sYyqJFiXSEE6UvIOws9QMKlt1CDXtxQLE0Xfw+QxsYXW8E1qAqUVqUzxPmWfDzEsDmGHOZonovIFrg9PXBmp+O1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535409; c=relaxed/simple;
	bh=DU2Oh8nrRgXZi/yPndOQwhsltv4XMpBfwRnb1FWmP0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKpjVek39pbyB0Kq4EdiIj3LnK3LrgMe0mTbetYPbXQHO306+29BghgowcXlY6nd+MflnqZzL6sQ1Z5JZlKU/KvV1/r039nIlP8rg0yXUgncz+he6TDIYCAUXRrMz1+Fae6dhVZq8SXXE2GtYYRBedACOvHDSWkZm3hsyGhalNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJrriT5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72650C072AA;
	Fri, 19 Apr 2024 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713535409;
	bh=DU2Oh8nrRgXZi/yPndOQwhsltv4XMpBfwRnb1FWmP0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJrriT5J2X7hf4oYYUmstmlkPeq3DgvatCicCKVfFY05MHAXsGjIvsIH6c2UeFUCK
	 b1tQA9eFfPT9My24Bx5MwU3csOfL2xbVgwabrXecyWtYmZRKLwmjFTjcB9j5GYWGoy
	 bTMMwme5TOdiXtbdlz/weS3ViPl7AR23/VsdRSztQE4oWHicuv1Q1F6jzoDfRx6oFs
	 e91S/8iEAE+36zTfeMrMhg/6jsGIwDPTUf6JEt6bvmNpYbnQaXgYkrjgO5C+kCE1Jv
	 URoPOjT0e9X5jEpWoycpzzCiinEHMpKHGeCeKhjSjfGUKHI96+oFtwuokS//ELD+RL
	 Qpa7Bkn0p5REw==
Date: Fri, 19 Apr 2024 15:03:22 +0100
From: Will Deacon <will@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
Message-ID: <20240419140321.GF3148@willie-the-truck>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au>
 <87edb9d33r.fsf@mail.lhotse>
 <87bk6dd2l4.fsf@mail.lhotse>
 <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
 <Zh06O35yKIF2vNdE@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh06O35yKIF2vNdE@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 15, 2024 at 07:31:23AM -0700, Sean Christopherson wrote:
> On Mon, Apr 15, 2024, Geert Uytterhoeven wrote:
> > On Sat, Apr 13, 2024 at 11:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > Michael Ellerman <mpe@ellerman.id.au> writes:
> > > > Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > > ...
> > > >> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.com> wrote:
> > > ...
> > > >>> diff --git a/kernel/cpu.c b/kernel/cpu.c
> > > >>> index 8f6affd051f7..07ad53b7f119 100644
> > > >>> --- a/kernel/cpu.c
> > > >>> +++ b/kernel/cpu.c
> > > >>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
> > > >>>  };
> > > >>>
> > > >>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =
> > > >>> -   CPU_MITIGATIONS_AUTO;
> > > >>> +   IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
> > > >>> +                                                CPU_MITIGATIONS_OFF;
> > > >>>
> > > >>>  static int __init mitigations_parse_cmdline(char *arg)
> > > >>>  {
> > >
> > > I think a minimal workaround/fix would be:
> > >
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 2b8fd6bb7da0..290be2f9e909 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
> > >  config GENERIC_CPU_VULNERABILITIES
> > >         bool
> > >
> > > +config SPECULATION_MITIGATIONS
> > > +       def_bool y
> > > +       depends on !X86
> > > +
> > >  config SOC_BUS
> > >         bool
> > >         select GLOB
> > 
> > Thanks, that works for me (on arm64), so
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Oof.  I completely missed that "cpu_mitigations" wasn't x86-only.  I can't think
> of better solution than an on-by-default generic Kconfig, though can't that it
> more simply be:
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..5930cb56ee29 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
>  config GENERIC_CPU_VULNERABILITIES
>         bool
>  
> +config SPECULATION_MITIGATIONS
> +       def_bool !X86
> +
>  config SOC_BUS
>         bool
>         select GLOB

I can't see this in -next yet. Do you plan to post it as a proper patch
to collect acks etc?

Cheers,

Will

