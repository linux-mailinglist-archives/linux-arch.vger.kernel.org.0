Return-Path: <linux-arch+bounces-11221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09ABA78EEF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D002C3B2EF7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C790219306;
	Wed,  2 Apr 2025 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUgtls2H"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510E1EA7DE;
	Wed,  2 Apr 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598008; cv=none; b=EbFPuuIqJ+OoSEvwX/R6ByexbxOUFN2GtsNO3wkPwwQhyj+8VzbvljPqTiJvywhNY3GszjpSlDdb8GRFpoZbuB9IYpdyEq/5EIaDlT4cUEnhdzv+AZZMEacdAkrThuCAKQkXbcZ+1DXzniDSAOsEezTiELuUBCwN+nxNQ1bscXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598008; c=relaxed/simple;
	bh=fuDw+v9E63a/aSleIffar11221krG7wOgWHTJ1Q3/68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqGtonnqIi0b41d3imOnyv+0XfiWgfW2CKFMki1S56baiFtdOsB1J7iXlVBIuqOBwhJN84kG5XKj62/GRWnN7vRzuVZ2oQG/ywhIqlruhYz5K6dV9MT/rQTHqZDULde9MEsrFXc9EmEfCdTRneOOvAH5kjGVOGXwd/wwixODxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUgtls2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F69C4CEDD;
	Wed,  2 Apr 2025 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743598007;
	bh=fuDw+v9E63a/aSleIffar11221krG7wOgWHTJ1Q3/68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUgtls2HhODVEH5+qLIKQLomvMF7ELxBw2MKKL+6p9VihJy6d4ilR7aZw4VM6bG22
	 zDUpLBwkinARXAebf2dC5uy5D27Sf/uK9zqZ+B49O6LNTG0nTIxRRy+6zHt6uiHuw7
	 5boShg/yXA5K3U142BUMUiz436tWHj7ha92cEpTGGgLBqz/uaRfxU/SobFsCzamk+8
	 MRnsgcyxYuQPHtOHzvmlrpD/jnUXZMC+dmrLYm6NsqGgAmSGJcY2+AWKZYdyihL0Pw
	 MkhiMnL7XaCGdAeekj/PX+fUOfk5PZyZhgr3fkpy2FJwN+zM/a5KhPh4b6M1nvbjWq
	 /VGfAQG+QNTyA==
Date: Wed, 2 Apr 2025 15:46:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z-0xrWyff9-9bJRf@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>

On Wed, Apr 02, 2025 at 02:19:01PM +0200, Thomas Weißschuh wrote:
> (drop all the non-x86 and non-mm recipients)
> 
> Hi,
> 
> On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > high_memory defines upper bound on the directly mapped memory.
> > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > high memory and by the end of memory otherwise.
> > 
> > All this is known to generic memory management initialization code that
> > can set high_memory while initializing core mm structures.
> > 
> > Add a generic calculation of high_memory to free_area_init() and remove
> > per-architecture calculation except for the architectures that set and
> > use high_memory earlier than that.
> 
> This change (in mainline as commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
> breaks booting i386 on QEMU for me (and others [0]).
> The boot just hangs without output.
> 
> It's easily reproducible with kunit:
> ./tools/testing/kunit/kunit.py run --arch i386
> 
> See below for the specific problematic hunk.
> 
> [0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0tpcvpz0tJFT4toLG4g@mail.gmail.com/
> 
> 
> > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > index 6d2f8cb9451e..801b659ead0c 100644
> > --- a/arch/x86/mm/init_32.c
> > +++ b/arch/x86/mm/init_32.c
> > @@ -643,9 +643,6 @@ void __init initmem_init(void)
> >  		highstart_pfn = max_low_pfn;
> >  	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> >  		pages_to_mb(highend_pfn - highstart_pfn));
> > -	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
> > -#else
> > -	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
> >  #endif
> 
> Reverting this hunk fixes the issue for me.
 
This is already done by d893aca973c3 ("x86/mm: restore early initialization
of high_memory for 32-bits").
  
> >  	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);

-- 
Sincerely yours,
Mike.

