Return-Path: <linux-arch+bounces-5546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9880938A75
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990C01F216CB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F01607A8;
	Mon, 22 Jul 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG5YJpR0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B1381BA;
	Mon, 22 Jul 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634874; cv=none; b=PWx5w94DjJ+OmYsFyKGi1Dhc/1F2mnsmv03FhZB6bd9bVY8OhZmm5KU+WOPJVEo/xAYcVTkHDeoqKyn5VwlwLBH7KFZq61JIp5/9EPBVELQ3gG/QMQ57ZwTa/R2BPaUo/Dow6zRYoVzqqkIr0iM2gSRq8NB0WyQSbKM2oKK2GS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634874; c=relaxed/simple;
	bh=OYRHdXxfKMdclKQlgCt5VIPfcSGA+/ROfi++yX8letM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5OrWN4lxF8Ys2G+6UO9msJS3gWDmTSgfIkoB2arYHaDMAglXnhb6azaF89O1LtyaRRY46tIkQ8borFUmkThGiK75jVsRS7jJaK0oQ4QKuBj0SLP6wYFME0mxCyt7aUvUWg4lbJEth5PJyi/nKRa3HxF9keA1njAYXWajVOE4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG5YJpR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDAAC116B1;
	Mon, 22 Jul 2024 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721634874;
	bh=OYRHdXxfKMdclKQlgCt5VIPfcSGA+/ROfi++yX8letM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG5YJpR0vvG3aK5NTi3fHWDP8/wPCXQEHPpVI03jXrmGjAqE/3ek11pgDez93GupD
	 MYY5cht8NtUour0LZG0EOmrqfl/+OGAQSwhfArqnV9dkDfvXzt+BYN0GoRqQLdf0w8
	 YDUR98pajEJ8JNfue+NyDcAaZ9Iwtukzez1OaHeCmGruaLhg9UE9Wgr4pPcIvv5uiw
	 dIFU4pKtQYikq/zjd4jZhqdwQH73y8o8PB2Iwv4e6pw08hibJoHxG/W9t5i5ZVahkj
	 dZ6r/bQd4gp9OtjoJH+9/yH+xOhOU700mNl2aycElgfDFiCdhzErMhj4jiW1C3Hzxx
	 qgTOP+LBC9IQQ==
Date: Mon, 22 Jul 2024 10:51:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 06/17] x86/numa: simplify numa_distance allocation
Message-ID: <Zp4PfVZKAg3djFOu@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-7-rppt@kernel.org>
 <20240719172849.000019a0@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719172849.000019a0@Huawei.com>

On Fri, Jul 19, 2024 at 05:28:49PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Jul 2024 14:13:35 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Allocation of numa_distance uses memblock_phys_alloc_range() to limit
> > allocation to be below the last mapped page.
> > 
> > But NUMA initializaition runs after the direct map is populated and
> 
> initialization (one too many 'i's)

Thanks.
 
> > there is also code in setup_arch() that adjusts memblock limit to
> > reflect how much memory is already mapped in the direct map.
> > 
> > Simplify the allocation of numa_distance and use plain memblock_alloc().
> > This makes the code clearer and ensures that when numa_distance is not
> > allocated it is always NULL.
> Doesn't this break the comment in numa_set_distance() kernel-doc?
> "
>  * If such table cannot be allocated, a warning is printed and further
>  * calls are ignored until the distance table is reset with
>  * numa_reset_distance().
> "
> 
> Superficially that looks to be to avoid repeatedly hitting the
> singleton bit at the top of numa_set_distance() as SRAT or similar
> parsing occurs.

I believe it's there to avoid allocation of numa_distance in the middle of
distance parsing (SLIT or DT numa-distance-map).

If the allocation fails for the first element in the table, the
numa_distance and numa_distance_cnt remain zero and node_distance() falls
back to

	return from == to ? LOCAL_DISTANCE : REMOTE_DISTANCE;

It's different from arch_numa that always tries to allocate MAX_NUMNODES *
MAX_NUMNODES for numa_distance and treats the allocation failure as a
failure to initialize NUMA.

I like the general approach x86 uses more, i.e. in case distance parsing
fails in some way NUMA is still initialized with probably suboptimal
distances between nodes.

I'm going to restore that "singleton" behavior for now and will look into
making this all less cumbersome later.
 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/mm/numa.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 5e1dde26674b..ab2d4ecef786 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -319,8 +319,7 @@ void __init numa_reset_distance(void)
> >  {
> >  	size_t size = numa_distance_cnt * numa_distance_cnt * sizeof(numa_distance[0]);
> >  
> > -	/* numa_distance could be 1LU marking allocation failure, test cnt */
> > -	if (numa_distance_cnt)
> > +	if (numa_distance)
> >  		memblock_free(numa_distance, size);
> >  	numa_distance_cnt = 0;
> >  	numa_distance = NULL;	/* enable table creation */
> > @@ -331,7 +330,6 @@ static int __init numa_alloc_distance(void)
> >  	nodemask_t nodes_parsed;
> >  	size_t size;
> >  	int i, j, cnt = 0;
> > -	u64 phys;
> >  
> >  	/* size the new table and allocate it */
> >  	nodes_parsed = numa_nodes_parsed;
> > @@ -342,16 +340,12 @@ static int __init numa_alloc_distance(void)
> >  	cnt++;
> >  	size = cnt * cnt * sizeof(numa_distance[0]);
> >  
> > -	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
> > -					 PFN_PHYS(max_pfn_mapped));
> > -	if (!phys) {
> > +	numa_distance = memblock_alloc(size, PAGE_SIZE);
> > +	if (!numa_distance) {
> >  		pr_warn("Warning: can't allocate distance table!\n");
> > -		/* don't retry until explicitly reset */
> > -		numa_distance = (void *)1LU;
> >  		return -ENOMEM;
> >  	}
> >  
> > -	numa_distance = __va(phys);
> >  	numa_distance_cnt = cnt;
> >  
> >  	/* fill with the default distances */
> 
> 

-- 
Sincerely yours,
Mike.

