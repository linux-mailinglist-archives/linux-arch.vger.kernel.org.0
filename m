Return-Path: <linux-arch+bounces-5520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EE937943
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA961F22E94
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC88383AE;
	Fri, 19 Jul 2024 14:39:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C3C2D6;
	Fri, 19 Jul 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399940; cv=none; b=sqp4/0Krl8vwmWTIp6QKtL/SAyfo25kLIr4Y0lbUshfsgbELEEdOvORh1scCnNj3UHbDilVuuihtXLbRdBxH+G+BHGsW3HL19h0NSq7s6pESAmtsEEoeJgSejVEDggS6Ib4lkWerMb4WnE+L7PT+aGp8XjbX4HEF0+078QqsyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399940; c=relaxed/simple;
	bh=MthLwAZw/K/pHDsypzwnpxxVpjnrL/t3lpnlDB9Cp0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOAi+7thFhKnKaktgyzcse1NQeHqjm6hDQ8FzbruE/hG3pderNui9BF0sgLil2BSsAy6CWqk35kfL9ypenfiTbhqhwdn/3gsNA9qdSJPlgoY6FKEKUJ/vi07eDJAiUjrrEncJMBqF1PCRQ6vv/hNhVMHAAhn9tRujzFwPmbIGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQXMF48rrz6JBjL;
	Fri, 19 Jul 2024 22:37:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6E9D140684;
	Fri, 19 Jul 2024 22:38:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 15:38:53 +0100
Date: Fri, 19 Jul 2024 15:38:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Hildenbrand <david@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>, <linux-kernel@vger.kernel.org>,
	"Alexander Gordeev" <agordeev@linux.ibm.com>, Andreas Larsson
	<andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd
 Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH 02/17] MIPS: sgi-ip27: make NODE_DATA() the same as on
 all other architectures
Message-ID: <20240719153852.00003f44@Huawei.com>
In-Reply-To: <e57eca18-b66d-4b5d-9e73-8ab22f6bc747@redhat.com>
References: <20240716111346.3676969-1-rppt@kernel.org>
	<20240716111346.3676969-3-rppt@kernel.org>
	<e57eca18-b66d-4b5d-9e73-8ab22f6bc747@redhat.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jul 2024 16:32:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 16.07.24 13:13, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > sgi-ip27 is the only system that defines NODE_DATA() differently than
> > the rest of NUMA machines.
> > 
> > Add node_data array of struct pglist pointers that will point to
> > __node_data[node]->pglist and redefine NODE_DATA() to use node_data
> > array.
> > 
> > This will allow pulling declaration of node_data to the generic mm code
> > in the next commit.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   arch/mips/include/asm/mach-ip27/mmzone.h | 5 ++++-
> >   arch/mips/sgi-ip27/ip27-memory.c         | 5 ++++-
> >   2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
> > index 08c36e50a860..629c3f290203 100644
> > --- a/arch/mips/include/asm/mach-ip27/mmzone.h
> > +++ b/arch/mips/include/asm/mach-ip27/mmzone.h
> > @@ -22,7 +22,10 @@ struct node_data {
> >   
> >   extern struct node_data *__node_data[];
> >   
> > -#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
> >   #define hub_data(n)		(&__node_data[(n)]->hub)
> >   
> > +extern struct pglist_data *node_data[];
> > +
> > +#define NODE_DATA(nid)		(node_data[nid])
> > +
> >   #endif /* _ASM_MACH_MMZONE_H */
> > diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> > index b8ca94cfb4fe..c30ef6958b97 100644
> > --- a/arch/mips/sgi-ip27/ip27-memory.c
> > +++ b/arch/mips/sgi-ip27/ip27-memory.c
> > @@ -34,8 +34,10 @@
> >   #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
> >   #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
> >   
> > -struct node_data *__node_data[MAX_NUMNODES];
> > +struct pglist_data *node_data[MAX_NUMNODES];
> > +EXPORT_SYMBOL(node_data);
> >   
> > +struct node_data *__node_data[MAX_NUMNODES];
> >   EXPORT_SYMBOL(__node_data);
> >   
> >   static u64 gen_region_mask(void)
> > @@ -361,6 +363,7 @@ static void __init node_mem_init(nasid_t node)
> >   	 */
> >   	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
> >   	memset(__node_data[node], 0, PAGE_SIZE);
> > +	node_data[node] = &__node_data[node]->pglist;
> >   
> >   	NODE_DATA(node)->node_start_pfn = start_pfn;
> >   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;  
> 
> I was assuming we could get rid of __node_data->pglist.
> 
> But now I am confused where that is actually set.

It looks nasty... Cast in arch_refresh_nodedata() takes
incoming pg_data_t * and casts it to the local version of
struct node_data * which I think is this one

struct node_data {
	struct pglist_data pglist; (which is pg_data_t pglist)
	struct hub_data hub;
};

https://elixir.bootlin.com/linux/v6.10/source/arch/mips/sgi-ip27/ip27-memory.c#L432

Now that pg_data_t is allocated by 
arch_alloc_nodedata() which might be fine (though types could be handled in a more
readable fashion via some container_of() magic.
https://elixir.bootlin.com/linux/v6.10/source/arch/mips/sgi-ip27/ip27-memory.c#L427

However that call is:
pg_data_t * __init arch_alloc_nodedata(int nid)
{
	return memblock_alloc(sizeof(pg_data_t), SMP_CACHE_BYTES);
}

So doesn't seem to allocate enough space to me as should be sizeof(struct node_data)

Worth cleaning up whilst here?  Proper handling of types would definitely
help.

Jonathan


> 
> Anyhow
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


