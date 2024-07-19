Return-Path: <linux-arch+bounces-5530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E446937AFB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDB2B20156
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF929145FF8;
	Fri, 19 Jul 2024 16:28:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95077145A19;
	Fri, 19 Jul 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406537; cv=none; b=U+i9bXFZk+qPCd3Iz2s0pIOE0VyhNvqXLR/07nNP/sFoGw4ZPNDEqqhRtZEHGDEcbHadRVEMfi47ORmj668dSgGMewRHa6VEn3lYlRU/Ce8iaq2itIKF4ORRf8pjAg+e65+M5JQrV/kSDCsT6pPmlcjKRK81PqCkYi86SCFV7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406537; c=relaxed/simple;
	bh=N1pdKNBGQDY1wRXXdSL7Pu0XSWIwV9tnznh+gOEKyG8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPcq5XOae/QSfvQsausuJ3JlZKal0ZA+thVyxIBBr/gzS4M7nN+GfpfBikIDhhplyT0KxK3pPv4le7DmsyGzcA/Sht90K0/pTw80TYAOYZc7baeRnS8TGWVejWuVNcLi/4iFPjE0uUaIgKKByBnIOctlmO7Ds624OVoOmW7f8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQZn61R1mz6K7Fc;
	Sat, 20 Jul 2024 00:26:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E616140517;
	Sat, 20 Jul 2024 00:28:51 +0800 (CST)
Received: from localhost (10.48.157.16) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 17:28:50 +0100
Date: Fri, 19 Jul 2024 17:28:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH 06/17] x86/numa: simplify numa_distance allocation
Message-ID: <20240719172849.000019a0@Huawei.com>
In-Reply-To: <20240716111346.3676969-7-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
	<20240716111346.3676969-7-rppt@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jul 2024 14:13:35 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Allocation of numa_distance uses memblock_phys_alloc_range() to limit
> allocation to be below the last mapped page.
> 
> But NUMA initializaition runs after the direct map is populated and

initialization (one too many 'i's)

> there is also code in setup_arch() that adjusts memblock limit to
> reflect how much memory is already mapped in the direct map.
> 
> Simplify the allocation of numa_distance and use plain memblock_alloc().
> This makes the code clearer and ensures that when numa_distance is not
> allocated it is always NULL.
Doesn't this break the comment in numa_set_distance() kernel-doc?
"
 * If such table cannot be allocated, a warning is printed and further
 * calls are ignored until the distance table is reset with
 * numa_reset_distance().
"

Superficially that looks to be to avoid repeatedly hitting the
singleton bit at the top of numa_set_distance() as SRAT or similar
parsing occurs.

> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/numa.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 5e1dde26674b..ab2d4ecef786 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -319,8 +319,7 @@ void __init numa_reset_distance(void)
>  {
>  	size_t size = numa_distance_cnt * numa_distance_cnt * sizeof(numa_distance[0]);
>  
> -	/* numa_distance could be 1LU marking allocation failure, test cnt */
> -	if (numa_distance_cnt)
> +	if (numa_distance)
>  		memblock_free(numa_distance, size);
>  	numa_distance_cnt = 0;
>  	numa_distance = NULL;	/* enable table creation */
> @@ -331,7 +330,6 @@ static int __init numa_alloc_distance(void)
>  	nodemask_t nodes_parsed;
>  	size_t size;
>  	int i, j, cnt = 0;
> -	u64 phys;
>  
>  	/* size the new table and allocate it */
>  	nodes_parsed = numa_nodes_parsed;
> @@ -342,16 +340,12 @@ static int __init numa_alloc_distance(void)
>  	cnt++;
>  	size = cnt * cnt * sizeof(numa_distance[0]);
>  
> -	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
> -					 PFN_PHYS(max_pfn_mapped));
> -	if (!phys) {
> +	numa_distance = memblock_alloc(size, PAGE_SIZE);
> +	if (!numa_distance) {
>  		pr_warn("Warning: can't allocate distance table!\n");
> -		/* don't retry until explicitly reset */
> -		numa_distance = (void *)1LU;
>  		return -ENOMEM;
>  	}
>  
> -	numa_distance = __va(phys);
>  	numa_distance_cnt = cnt;
>  
>  	/* fill with the default distances */


