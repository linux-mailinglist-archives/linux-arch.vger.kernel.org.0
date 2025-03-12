Return-Path: <linux-arch+bounces-10683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B4A5E17D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222CC1885B74
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295A51C5D4B;
	Wed, 12 Mar 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1nXbH0l"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C61DFF7;
	Wed, 12 Mar 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795771; cv=none; b=Xd/hfCoHPxXA0+ZNFN0Wua9+i79JbbzW4C3Z1JHuErCp9r2xRU+9eEUhJVCFfDwbJ2sva5j8w9AcNP6IN9HhjAk4IvPvuQi+ualtSoiCMixhiIhcRgPJh3rQ1fhurZvln5HoA3Mx9F/gmfI9kNGq8rE5pWHZfI1gLXyt2q4mfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795771; c=relaxed/simple;
	bh=U+kn0eqCA1vTkLcceUerHMcbUlG4P1T7ky+SM+cNeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozrJAaFVFCWioZeaKJmCYDgsf7Qg9+wcrMtjHgN3BJGg5skHVpsJ3AffbEAFsv2jOPXhreKBU6n809FP1wb0tY9t+vEkTH9mzQk5pT58t+89ib6dce6zIKVjIRUAcWHBBp6tyOxCpciEYj7X8ZqIqKyC1V0QcNYpOnGKGracKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1nXbH0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA43C4CEDD;
	Wed, 12 Mar 2025 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795770;
	bh=U+kn0eqCA1vTkLcceUerHMcbUlG4P1T7ky+SM+cNeZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1nXbH0lAp/Eqh29Z9apDenWiT7PjuKxKiO2JQvLOJVWK5GP4OmPvFpXi6asrnzZT
	 nu94zZUymz0UiYH5e2oHwUKtTI1fSzIDWOtzi+i34Gkz1xkL6x5U9bzNGRhUtzuTKS
	 DXX5HBMSnM0KQHz9TeDEZUAKZi2/XgNg8n+fKtj+coTJt3gRJNcK3xsnp4c0Rfm92c
	 yO1JQdFiH5w2Gbb11wg1ZkFYIseNAErd8Fb7JJ7KzSSF/QC6tMXJP/39miA0uSvCwy
	 IrlqFK1R0v32Dh9qsAKLmrl9vNb/vAYRou4oKyLZKKWsSVO2mj5QR0FroBYJHAdDo/
	 ffW5IRilofYyA==
Date: Wed, 12 Mar 2025 18:09:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 07/13] s390: make setup_zero_pages() use memblock
Message-ID: <Z9GxozjZTKOGDPv1@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-8-rppt@kernel.org>
 <20250307152815.9880Gbd-hca@linux.ibm.com>
 <Z8_Qawg0dGtZdys7@kernel.org>
 <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>

On Wed, Mar 12, 2025 at 04:56:59PM +0100, Ard Biesheuvel wrote:
> On Tue, 11 Mar 2025 at 06:56, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Mar 07, 2025 at 04:28:15PM +0100, Heiko Carstens wrote:
> > > On Thu, Mar 06, 2025 at 08:51:17PM +0200, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > >
> > > > Allocating the zero pages from memblock is simpler because the memory is
> > > > already reserved.
> > > >
> > > > This will also help with pulling out memblock_free_all() to the generic
> > > > code and reducing code duplication in arch::mem_init().
> > > >
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > ---
> > > >  arch/s390/mm/init.c | 14 +++-----------
> > > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > >
> > > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> > >
> > > > -   empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > > +   empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> > > >     if (!empty_zero_page)
> > > >             panic("Out of memory in setup_zero_pages");
> > >
> > > This could have been converted to memblock_alloc_or_panic(), but I
> > > guess this can also be done at a later point in time.
> >
> > Duh, I should have remembered about memblock_alloc_or_panic() :)
> >
> > @Andrew, can you please pick this as a fixup?
> >
> > From 344fec8519e5152c25809c9277b54a68f9cde0e9 Mon Sep 17 00:00:00 2001
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > Date: Tue, 11 Mar 2025 07:51:27 +0200
> > Subject: [PATCH] s390: use memblock_alloc_or_panic() in setup_zero_page()
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/s390/mm/init.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index ab8ece3c41f1..c6a97329d7e7 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -81,9 +81,7 @@ static void __init setup_zero_pages(void)
> >         while (order > 2 && (total_pages >> 10) < (1UL << order))
> >                 order--;
> >
> > -       empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> > -       if (!empty_zero_page)
> > -               panic("Out of memory in setup_zero_pages");
> > +       empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, order);
> >
> 
> memblock_alloc_or_panic() takes the alignment is in bytes, no? So
> shouldn't the second argument be BIT(order)?

The second argument should be PAGE_SIZE. Thanks for catching that!

-- 
Sincerely yours,
Mike.

