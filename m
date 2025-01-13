Return-Path: <linux-arch+bounces-9719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C5A0B61F
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EC188513B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF61CAA99;
	Mon, 13 Jan 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BsQUyE0M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E401A8F98;
	Mon, 13 Jan 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769184; cv=none; b=lf9+4Cyl8WgYFyo+mea9/tbjdaKJsVJcKclv1mZo3BuDwOznQ+gCqsuEGYwZ9c5vkKV7Vnioft2EYDPAxIY/yhNvvli2T2k3WRSbvxnWgNsDTlC2vVdKCr/4sRN2Zvwlz/1n44m+XrVP6T/OHqh2od1cGYiVCKwAn6FIRalK5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769184; c=relaxed/simple;
	bh=rj/R/90a7hLmRewZhsY/bA19NAKxOytvjRKPzmkvmTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph5UHDZj8SctAe/n4dSxSzPf5SOWIgf9qofjQeghexuNNs/lz4wN6bcqmaDLF+XgxcfJoPaY2WgVQCNAcLAyrmn0mftazyNfxrqt8rJdNWtjR+QNaIGS8u+qB18vvX0PmT7wevSjkuKdsX+lHOFmmOn7pWLeaLxXPTe+ja5ICt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BsQUyE0M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 549FF40E01F9;
	Mon, 13 Jan 2025 11:52:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xmIsbErgUaWY; Mon, 13 Jan 2025 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736769173; bh=qSbRHcCxicQ2oaohgQJ8xn6gI1z5hxVzGPJ9KcO78ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsQUyE0MpgT/tvDuXqOP2by5wxaln0pgDMNsyorzlEBunwnsVmYg6L2A1phKwPV7s
	 kprzy+NBoNbYbHsJnT3YmhuYEeQN554Y35wC/mmKzG9UGAMJVta9IWmsj8KPfG/LMv
	 XfD6aFYfx/eAJf4Z4WMS7uJGUgv47TyMQcsEz3kYN83euyk5ovQcb00rZstpPUl+k2
	 XbESf4MoT3jT5DSHXgpKMVuLAP/j4GxI90mVoMrz7jo6PB/bu04vVroAIHe+P4wncu
	 uMqHlK64sB5NHbaPMUduXTl1y6aXJwv3ihwZQc6RG0KfSGp8H2vD36ht30yi+eeqLV
	 QWhvaRrxLFVJpiCA6H19MvlreYEL+92uTMcoce80ej/6rD/fnlBL+Ga63CK5k96ts0
	 n2vTOs2LhW2VMmg+88LAPYd8NjdMMEnfr6zy1QtfqPlktXHYlwN/tkF4apvCcnQ3VS
	 CTn1EUlTZTFJseWRU7RWGhnI4DqXJUlXgdmWfAh0Hogqv0/+Bj8DIm/1FQJ6J6gGJO
	 EwdXtvJeMUKmR9tsmgnfLa4Pn6Qe8PTZ85dV6YjZqO3pPejIvC42f/ZubgkapbMYf6
	 dhQef/RqIIoxyOJiBZ0pWPWElWKBrNqe3G6IJPjHGPHPAherBr5S2sILxabshks3Oo
	 quZ4q2rdiiJ34vO8+Ur4yrU0=
Received: from zn.tnic (pd953008e.dip0.t-ipconnect.de [217.83.0.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4E3940E0269;
	Mon, 13 Jan 2025 11:51:56 +0000 (UTC)
Date: Mon, 13 Jan 2025 12:51:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.or
Subject: Re: [PATCH] x86: Disable EXECMEM_ROX support
Message-ID: <20250113115151.GDZ4T-VwIq_6ZafRE4@fat_crate.local>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-9-rppt@kernel.org>
 <Z4QM_RFfhNX_li_C@intel.com>
 <20250112190755.GCZ4QTC01KzoZkxel9@fat_crate.local>
 <20250113111116.GF5388@noisy.programming.kicks-ass.net>
 <20250113112934.GA8385@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113112934.GA8385@noisy.programming.kicks-ass.net>

On Mon, Jan 13, 2025 at 12:29:34PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 13, 2025 at 12:11:16PM +0100, Peter Zijlstra wrote:
> 
> > There's definiltely breakage with that module_writable_address()
> > nonsense in alternative.c that will not be fixed by that patch.
> > 
> > The very simplest thing at this point is to remove:
> > 
> >      select ARCH_HAS_EXECMEM_ROX             if X86_64
> > 
> > and try again next cycle.
> 
> Boris asked I send it as a proper patch, so here goes. Perhaps next time
> let x86 merge x86 code :/

I just love it how this went in without a single x86 maintainer Ack, it broke
a bunch of things and then it is still there instead of getting reverted.

Let's not do this again please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

