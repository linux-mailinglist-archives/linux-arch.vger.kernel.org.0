Return-Path: <linux-arch+bounces-7799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC2993EEC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14C71F24287
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 06:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0411CBE9E;
	Tue,  8 Oct 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLZ7O/Hp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E1190463;
	Tue,  8 Oct 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368581; cv=none; b=b0+i7NIf4tZtGEygf48LH97G/5MJNgJD3Lo+n/svHlSRHc5+O8C+ujWoXX1dB4dKEj2fXIFPikjSodmb09XaVgY52wid/yz0lRL9LgnSlpxRbXYqdXDn+jyd3keRyqyanJQcYvX2ML7ELdWGDwMW3UEQOPZXOEWjxptmNQfMw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368581; c=relaxed/simple;
	bh=7+OOlYDwjjrmYkugp0zG3rCIOBJXVhabkZlBvijiN0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+jiP2eICH93Xd25lhaeFb8hoxpl+Au5fgjUGRklcsO4Sm7rSGaAqmt6p2Xka+wAs8DAVY0qTGDKecUG1Qz+3ELSjZns6wXXoJLbFmnYmCVsLTstksO9Q7eNYJjhQwrVrbwf4x8hr7N5qpaYaSKTevBs9vvE0dV+0CTatrl0BcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLZ7O/Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C076C4CEC7;
	Tue,  8 Oct 2024 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368581;
	bh=7+OOlYDwjjrmYkugp0zG3rCIOBJXVhabkZlBvijiN0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLZ7O/HpKqwZhtBX1cNCiAk8EV6vD0WzAl1dR/RILMS7jSHhGDnYDNH2Dzn6ECEly
	 M0+GSr/JGL8nAopaejPjKSQKa6Jmnx6kHabKvo9FyggKvIK/+rwoLnO5mphSBOrVi8
	 U9wdgL7Nl7zM0jbSh9FiGcxw5b5J+su+JR+7Gf4XG9wvT3v6GVYlXJH8m3l11OFKZ1
	 9jEHuFYuJh2kBStvb3JCpXCoRR3L/JiHNjMlM70jCbMyIiQEwYJp2wijiSZ4G1su3J
	 9j8W/sm+G2yCx41UsRZ1DC/eNueJYqT+Lq5WzrcGaGCVNkuw9bP/AltQfceSnkaSt6
	 lK+siW3UD/EyQ==
Date: Tue, 8 Oct 2024 09:19:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 5/8] arch: introduce set_direct_map_valid_noflush()
Message-ID: <ZwTO4S_smfPbP06x@kernel.org>
References: <20241007062858.44248-1-rppt@kernel.org>
 <20241007062858.44248-6-rppt@kernel.org>
 <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>

Hi Huacai,

On Tue, Oct 08, 2024 at 10:11:25AM +0800, Huacai Chen wrote:
> Hi, Mike,
> 
> On Mon, Oct 7, 2024 at 2:30 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Add an API that will allow updates of the direct/linear map for a set of
> > physically contiguous pages.
> >
> > It will be used in the following patches.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/arm64/include/asm/set_memory.h     |  1 +
> >  arch/arm64/mm/pageattr.c                | 10 ++++++++++
> >  arch/loongarch/include/asm/set_memory.h |  1 +
> >  arch/loongarch/mm/pageattr.c            | 21 +++++++++++++++++++++
> >  arch/riscv/include/asm/set_memory.h     |  1 +
> >  arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
> >  arch/s390/include/asm/set_memory.h      |  1 +
> >  arch/s390/mm/pageattr.c                 | 11 +++++++++++
> >  arch/x86/include/asm/set_memory.h       |  1 +
> >  arch/x86/mm/pat/set_memory.c            |  8 ++++++++
> >  include/linux/set_memory.h              |  6 ++++++
> >  11 files changed, 76 insertions(+)
> >
> > diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
> > index d70505b6676c..55dfaefd02c8 100644
> > --- a/arch/loongarch/include/asm/set_memory.h
> > +++ b/arch/loongarch/include/asm/set_memory.h
> > @@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
> >  bool kernel_page_present(struct page *page);
> >  int set_direct_map_default_noflush(struct page *page);
> >  int set_direct_map_invalid_noflush(struct page *page);
> > +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
> >
> >  #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
> > diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> > index ffd8d76021d4..f14b40c968b4 100644
> > --- a/arch/loongarch/mm/pageattr.c
> > +++ b/arch/loongarch/mm/pageattr.c
> > @@ -216,3 +216,24 @@ int set_direct_map_invalid_noflush(struct page *page)
> >
> >         return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
> >  }
> > +
> > +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
> > +{
> > +       unsigned long addr = (unsigned long)page_address(page);
> > +       pgprot_t set, clear;
> > +
> > +       return __set_memory((unsigned long)page_address(page), nr, set, clear);
> This line should be removed.

Argh, copy/paste is so hard...

Thanks, will do.
 
> Huacai

-- 
Sincerely yours,
Mike.

