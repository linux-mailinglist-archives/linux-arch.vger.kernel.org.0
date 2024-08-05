Return-Path: <linux-arch+bounces-6008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A39483A1
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546CC1C22075
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAC14A4E1;
	Mon,  5 Aug 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF0xgt41"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79C149C60;
	Mon,  5 Aug 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890261; cv=none; b=VyMGhhVCt9F5N+8ZsowL3bmWZaNNs1IUQN1p07TKxi0IEsOkPDp85rT2Eun7TSzwTN5Iiv8fa1LeveyEqJkpX56REfaQiQtIDeL3RJUP4FAsF0XVeQBH47jVcUFftc8XSa3h96K59jg0rE3ECNHbAnPM1f44obhjrpqp6AKVUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890261; c=relaxed/simple;
	bh=qdRuOti9XNlLltkR78ltAp8iub7ZiaEGkve5ZQKgRXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc04VQjcCngW/HvjKCfRW2IYnMJQ0cmyqcTO1Wc44W+q4zd6W4B5OpnnYGmJpPnKFBmt8AvgBHa3lViJHzJOv2zndQgO9ogdHuZZ+lQ7RlTeOsR50ukTmMnOcU/FaAre5qJFobpaKML6hxJIt09pAoq3F/WxWdgnWzu1zydv5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF0xgt41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EBC4AF0E;
	Mon,  5 Aug 2024 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890261;
	bh=qdRuOti9XNlLltkR78ltAp8iub7ZiaEGkve5ZQKgRXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bF0xgt419GbxyCGFRj0fNjByi1OtMInAxUy0fO7kuEExoo6r6jeZMXGjN5ikPGLYH
	 /M1nzHizackmgautp/VnDSLRxQXCurMyrYVEwg5Yf+PdgGkwhSt7ZiA1a6tEsPe3+w
	 oJPfE55fHB91q50vVv1vV9hAXYemhAyhr6OpNgWOOvXUx9/9Vw4S7evidbf87YcNj+
	 pEPIiDW05PYUn8lRlujrJ1DKbY3WIHytjXuNelSTWpy7nXBiYR1lO2v9ZQh4g3aHrR
	 PgFXkbijAdUJ0BywpuS1YJGB4AvPiLFgG1t0OrXdtLJEh5IFQJb88z75ZKH8cfv8oU
	 ALk7ATW/rOneA==
Date: Mon, 5 Aug 2024 23:35:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 11/26] x86/numa: use get_pfn_range_for_nid to verify
 that node spans memory
Message-ID: <ZrE3ijXA3efepKcH@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-12-rppt@kernel.org>
 <66b1302ce5fd3_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b1302ce5fd3_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Aug 05, 2024 at 01:03:56PM -0700, Dan Williams wrote:
> Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Instead of looping over numa_meminfo array to detect node's start and
> > end addresses use get_pfn_range_for_init().
> > 
> > This is shorter and make it easier to lift numa_memblks to generic code.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> > ---
> >  arch/x86/mm/numa.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index edfc38803779..cfe7e5477cf8 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -521,17 +521,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >  
> >  	/* Finally register nodes. */
> >  	for_each_node_mask(nid, node_possible_map) {
> > -		u64 start = PFN_PHYS(max_pfn);
> > -		u64 end = 0;
> > +		unsigned long start_pfn, end_pfn;
> >  
> > -		for (i = 0; i < mi->nr_blks; i++) {
> > -			if (nid != mi->blk[i].nid)
> > -				continue;
> > -			start = min(mi->blk[i].start, start);
> > -			end = max(mi->blk[i].end, end);
> > -		}
> > -
> > -		if (start >= end)
> > +		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> > +		if (start_pfn >= end_pfn)
> 
> Assuming I understand why this works, would it be worth a comment like:
> 
> "Note, get_pfn_range_for_nid() depends on memblock_set_node() having
>  already happened"

Will add a comment, sure.
 
> ...at least that context was not part of the diff so took me second to
> figure out how this works.
> 

-- 
Sincerely yours,
Mike.

