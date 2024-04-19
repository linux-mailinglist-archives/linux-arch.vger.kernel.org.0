Return-Path: <linux-arch+bounces-3823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B58AB0DC
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F021C2147A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3611712DD93;
	Fri, 19 Apr 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuC/adN8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044512B2D7;
	Fri, 19 Apr 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537534; cv=none; b=phc0w5Rq6WyTvxAVDYsSuErlji0gGQrKTyPAnr8VG9QA+ijXIRsEbO/0I/0XKfvYCfcOjoafeR3Do2lV3wItsyK0CnXZxKqy0MCCQWCQIqUeapBzvf61o30lQxATRo56rc8sGOxJmGMNTeNRp4Ov04ct8Sc+nlPo5EABxMExG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537534; c=relaxed/simple;
	bh=HaHW8LOM7CzKYKcJLEDAbtk0kNe6pNRRkCefhatJTL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBNUouwzbXw5f5+cYvnoSZBP+da+jLT5YG9Kz0ANBp+P/ZbroalnsdYbusUQknvsQTSbEZSCwJcbKyEyqtr6IqXzmHycMB6cIXluZouAYxHkXZP0HZrGE4A14DMIFRGT51rNqr+JCg74k926xN5qRRJYt9hJnGRCq51O2G34yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuC/adN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAF7C072AA;
	Fri, 19 Apr 2024 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713537533;
	bh=HaHW8LOM7CzKYKcJLEDAbtk0kNe6pNRRkCefhatJTL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuC/adN8zf/JDG9shHoubRIOiGr8+e3T+cmz3cSQBxc1sRisROcD1PalPMEM1+H3W
	 Vd6BevhpgR7mhl7DO2NMfRRSe6BXR/wVujj42nN/4G+fL+JONDvCzJMP3wP579Fpsw
	 cgyJUtLLAQDxAvH3Ly3pt4v2Y2PgZvmwLa2RzXTuTudFsnoa2zaRHtz2XXKih66UlP
	 AzYaOEH6gkaaF7QE2I6XX8jPYiaeKRMWv0vdVDNTa9H4OgS/1y5ZwOXm7ndFEtt+2V
	 KCwi7ssV9O6ndE5yCOD0aFxRcFd2qz0vTgt5OnIE1YtwbPrH2KAMfKevsHFhvkTpH3
	 dHBYKIhHWK5ZA==
Date: Fri, 19 Apr 2024 15:38:46 +0100
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
Message-ID: <20240419143846.GA3508@willie-the-truck>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au>
 <87edb9d33r.fsf@mail.lhotse>
 <87bk6dd2l4.fsf@mail.lhotse>
 <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
 <Zh06O35yKIF2vNdE@google.com>
 <20240419140321.GF3148@willie-the-truck>
 <ZiJ6SDcbTBQjrG3r@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiJ6SDcbTBQjrG3r@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 19, 2024 at 07:06:00AM -0700, Sean Christopherson wrote:
> On Fri, Apr 19, 2024, Will Deacon wrote:
> > On Mon, Apr 15, 2024 at 07:31:23AM -0700, Sean Christopherson wrote:
> > > On Mon, Apr 15, 2024, Geert Uytterhoeven wrote:
> > > Oof.  I completely missed that "cpu_mitigations" wasn't x86-only.  I can't think
> > > of better solution than an on-by-default generic Kconfig, though can't that it
> > > more simply be:
> > > 
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 2b8fd6bb7da0..5930cb56ee29 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
> > >  config GENERIC_CPU_VULNERABILITIES
> > >         bool
> > >  
> > > +config SPECULATION_MITIGATIONS
> > > +       def_bool !X86
> > > +
> > >  config SOC_BUS
> > >         bool
> > >         select GLOB
> > 
> > I can't see this in -next yet. Do you plan to post it as a proper patch
> > to collect acks etc?
> 
> Sorry, I neglected to Cc everyone.
> 
> https://lore.kernel.org/all/20240417001507.2264512-2-seanjc@google.com

Ah, thanks. I'll go Ack that...

Will

