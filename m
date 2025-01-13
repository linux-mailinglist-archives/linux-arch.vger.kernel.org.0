Return-Path: <linux-arch+bounces-9723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71985A0BC86
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F253A0F9A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499FB14B08E;
	Mon, 13 Jan 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE/CT9Gs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DE240221;
	Mon, 13 Jan 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783291; cv=none; b=ZS+4g7j0xezCjwwpJSIspGPKpqkXNW762nNaTeKnl41yBJu7ieYo3sLiYxGiVZjUXwESIDd6TEsUFCCqhtQ9y/iHJMyyfjtK4f84C0pfr9w2jQDdLbiQvSUaLJvle7tc0l0OENkiYt1e54K5Fbrp3hpXQhc4DTvril8nq8FSwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783291; c=relaxed/simple;
	bh=ExydEF6oUbBv3mhxl1sgVJvfB6r3da1uy1h0Ey5whoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atkNRdODTGq9V0Cqwx1M/fF6WXhZzUQ3T13OSZ7s/pjZfmy/+uWEBP+Iv6AlUc8LpQ946n4KQZDMqrWOpZoYJ+G6FoNBiD+4M+9U2oRDkkXzCuMivZ/ZF5jG9/GYAFaKg6YZ7/hn5YwTB2skrR5phGeFKf82icvTLCHrFFRCkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE/CT9Gs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736783289; x=1768319289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ExydEF6oUbBv3mhxl1sgVJvfB6r3da1uy1h0Ey5whoQ=;
  b=iE/CT9Gson6D3bFW+s7Bgby4OwbOTaNxvZMXsVlhlfmGR9OTeS7P4NPn
   RXdjPTRY2CaXMuXQv2933QdWLv2AbhFcpBAFJXjikKCNJQNcQIYKizQ50
   Y2CTJ9Q61hLRAH7zdYa3mD9v1HviBsW679kpWCZNxFRDzc5UKHO31lCrV
   ICa/qBanp6MHR+VqXrznlGSHBFY76YGyqwwB4ou5jsOs66jXjyjoxoYSQ
   pvk7O9iE+sPdfiiS92wzCeVxfKj1T6Pt5EDLoZaYDi9gWtcM/egE77y0P
   68zyzY2o7E1XC635cegZf021mB61LoYeGgdF+TSHpU8AKODttDtbV+RT2
   Q==;
X-CSE-ConnectionGUID: IsQ+kTlqSIuTx9stxs+LjA==
X-CSE-MsgGUID: xPzJLRa/TjCHnLqULFbWsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36340679"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36340679"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:48:08 -0800
X-CSE-ConnectionGUID: tF9prx5vSTOp32e9QHNHAA==
X-CSE-MsgGUID: idxS4SPKSjyFVgzRZeU+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104693236"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 13 Jan 2025 07:47:55 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 13 Jan 2025 17:47:54 +0200
Date: Mon, 13 Jan 2025 17:47:54 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <Z4U1qqBekZ-_l1NS@intel.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113112934.GA8385@noisy.programming.kicks-ass.net>
X-Patchwork-Hint: comment

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
> 
> ---
> Subject: x86: Disable EXECMEM_ROX support
> 
> The whole module_writable_address() nonsense made a giant mess of
> alternative.c, not to mention it still contains bugs -- notable some of the CFI
> variants crash and burn.
> 
> Mike has been working on patches to clean all this up again, but given the
> current state of things, this stuff just isn't ready.
> 
> Disable for now, lets try again next cycle.
> 
> Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9d7bd0ae48c4..ef6cfea9df73 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -83,7 +83,6 @@ config X86
>  	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
>  	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
> -	select ARCH_HAS_EXECMEM_ROX		if X86_64
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL

This one works for my hibernate woes.

In case you want it:
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

-- 
Ville Syrjälä
Intel

