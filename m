Return-Path: <linux-arch+bounces-5892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981C9451AA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5079A1F2452D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC11B9B3D;
	Thu,  1 Aug 2024 17:44:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8331B32D9;
	Thu,  1 Aug 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534258; cv=none; b=N7E0Zw8SHltXT7EIc0IOO1NnbjIntXvbCFz+oIaJT+qQHO/QEwYM+WvRSLo9BO8dMhWCjDYETA7SvLTBOl8amsRwp88ryWonuEULOenyXzXwgLPFi9OxwYBSPOT2334H35YpSu1PDE10Ximu3cyL3Xhinr+A9veDWZNvsRkys/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534258; c=relaxed/simple;
	bh=wRdCTzlDewZSbPkP8IJ71BjVzwzJ/uMan6/8YvZafK8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWaegQw3HQxW+sowcYs7B+EJSOUpgfrm95UiRtkid0mgUW6lMrADUZ0eMPEFE6KH+nNzhZ4pJG/ThJ+VSLVgi402JTuv5O3yCL72bfoGGqfYKMw0ZhfLPVB5B1c/ol4kXMSAUlbGfcA9baGbXlEw3J1U4ywBo3oZzgMb0/75bU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZbqf2c9cz6K6MB;
	Fri,  2 Aug 2024 01:41:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C75C1400F4;
	Fri,  2 Aug 2024 01:44:10 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 18:44:09 +0100
Date: Thu, 1 Aug 2024 18:44:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
	<dave@stgolabs.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Heiko
 Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
	<corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt
	<palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, Zi Yan <ziy@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <sparclinux@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 02/26] MIPS: sgi-ip27: make NODE_DATA() the same as
 on all other architectures
Message-ID: <20240801184408.00002e8b@Huawei.com>
In-Reply-To: <20240801060826.559858-3-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
	<20240801060826.559858-3-rppt@kernel.org>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  1 Aug 2024 09:08:02 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> sgi-ip27 is the only system that defines NODE_DATA() differently than
> the rest of NUMA machines.
> 
> Add node_data array of struct pglist pointers that will point to
> __node_data[node]->pglist and redefine NODE_DATA() to use node_data
> array.
> 
> This will allow pulling declaration of node_data to the generic mm code
> in the next commit.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
After staring for a while at the use made of the other part
of the __node_data I think what you have in this an the next
two patches is fine.

I'm far from convinced it was correct before though as
arch_refresh_node_data() called on offline nodes in free_area_init()
would have replaced __node_data with an allocation of
size pg_data_t but the hub_data(), visible below, is after that.
Maybe hub_data() as never called for offline nodes, but
I couldn't establish that.

After these patches the arch_refresh_node_data() generic
version will only be replacing the pointer in node_data
leaving the hub_data where it was in the first place and
thus is fine.

So with that in mind (and it could be completely wrong ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> ---
>  arch/mips/include/asm/mach-ip27/mmzone.h | 5 ++++-
>  arch/mips/sgi-ip27/ip27-memory.c         | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
> index 08c36e50a860..629c3f290203 100644
> --- a/arch/mips/include/asm/mach-ip27/mmzone.h
> +++ b/arch/mips/include/asm/mach-ip27/mmzone.h
> @@ -22,7 +22,10 @@ struct node_data {
>  
>  extern struct node_data *__node_data[];
>  
> -#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
>  #define hub_data(n)		(&__node_data[(n)]->hub)
>  
> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[nid])
> +
>  #endif /* _ASM_MACH_MMZONE_H */
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index b8ca94cfb4fe..c30ef6958b97 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -34,8 +34,10 @@
>  #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
>  #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
>  
> -struct node_data *__node_data[MAX_NUMNODES];
> +struct pglist_data *node_data[MAX_NUMNODES];
> +EXPORT_SYMBOL(node_data);
>  
> +struct node_data *__node_data[MAX_NUMNODES];
>  EXPORT_SYMBOL(__node_data);
>  
>  static u64 gen_region_mask(void)
> @@ -361,6 +363,7 @@ static void __init node_mem_init(nasid_t node)
>  	 */
>  	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
>  	memset(__node_data[node], 0, PAGE_SIZE);
> +	node_data[node] = &__node_data[node]->pglist;
>  
>  	NODE_DATA(node)->node_start_pfn = start_pfn;
>  	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;


