Return-Path: <linux-arch+bounces-5545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DE938A2A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D0E1F212CC
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E314B094;
	Mon, 22 Jul 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5rEoxjJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84311125C0;
	Mon, 22 Jul 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633837; cv=none; b=AHbM73RsVE6mxgK4klzOTbjeVOBfDTg3XDbbIromD+I+xe6iHZJr9osxe5BDGP67E2nDpU9sU5v7NVhd7LmvLC+NLqTSR2XNH043iOs+QCY9mZdv+q3hC7PPegBE/iU95Mh5x8P50WpYFt1xYLTENDWcqRnob+bZGrzofFsZrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633837; c=relaxed/simple;
	bh=Dxslf8J1nw2EoO1825aVEeJAxLrpHgQU1wjgg+XF/0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEHEYwVMD4zmSR2Inx8/xm+5BTYzhC4bDJ/TAbB/G44qnfxWJgfmFDCOK7ISqp/jz6DC8z26w7sunC5Bio++y2Tj1wkUnVbS7zJKPc6TDvB7GUJa0FSTsvwwUzbg413uxr/jVw5iIyeyn/rTSBJHhYFp2OI5ZW6KGfa3j9jHK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5rEoxjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C14EC116B1;
	Mon, 22 Jul 2024 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633837;
	bh=Dxslf8J1nw2EoO1825aVEeJAxLrpHgQU1wjgg+XF/0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5rEoxjJyp8Si4Ol1tKmDHfxujD1M6arK5yB3md41TgtMqzL7133QUbpMAiRqALI8
	 zHqP2jnhANmIGx1K6HRYtObkAQqmVJ2vQFti7pCzHaOzz0dds7xFt2urt534cJHiXw
	 CurmUQ1pi3n/TpSSCUqTSIn7TV/EpAfGuHiiiLk6U01osyb6JXJ0yznQ72y9r7YmE5
	 p6fsNYiqRdEsZWZ4qQtfi/2IxHr6rbbdo6JlW+fM0tWjobtA9os1Uj3kz7eGY4SLEa
	 ISuNDqsn9MvH468ghs8RFDYohLKYRIm2o5BjdJ/Ni63NJJU1x+XnEdyepZgDkMsXF7
	 by+28UouvqBSA==
Date: Mon, 22 Jul 2024 10:34:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH 02/17] MIPS: sgi-ip27: make NODE_DATA() the same as on
 all other architectures
Message-ID: <Zp4Lbh20_IHZ2I5n@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-3-rppt@kernel.org>
 <e57eca18-b66d-4b5d-9e73-8ab22f6bc747@redhat.com>
 <20240719153852.00003f44@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719153852.00003f44@Huawei.com>

On Fri, Jul 19, 2024 at 03:38:52PM +0100, Jonathan Cameron wrote:
> On Wed, 17 Jul 2024 16:32:59 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > On 16.07.24 13:13, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > sgi-ip27 is the only system that defines NODE_DATA() differently than
> > > the rest of NUMA machines.
> > > 
> > > Add node_data array of struct pglist pointers that will point to
> > > __node_data[node]->pglist and redefine NODE_DATA() to use node_data
> > > array.
> > > 
> > > This will allow pulling declaration of node_data to the generic mm code
> > > in the next commit.
> > > 
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >   arch/mips/include/asm/mach-ip27/mmzone.h | 5 ++++-
> > >   arch/mips/sgi-ip27/ip27-memory.c         | 5 ++++-
> > >   2 files changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
> > > index 08c36e50a860..629c3f290203 100644
> > > --- a/arch/mips/include/asm/mach-ip27/mmzone.h
> > > +++ b/arch/mips/include/asm/mach-ip27/mmzone.h
> > > @@ -22,7 +22,10 @@ struct node_data {
> > >   
> > >   extern struct node_data *__node_data[];
> > >   
> > > -#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
> > >   #define hub_data(n)		(&__node_data[(n)]->hub)
> > >   
> > > +extern struct pglist_data *node_data[];
> > > +
> > > +#define NODE_DATA(nid)		(node_data[nid])
> > > +
> > >   #endif /* _ASM_MACH_MMZONE_H */
> > > diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> > > index b8ca94cfb4fe..c30ef6958b97 100644
> > > --- a/arch/mips/sgi-ip27/ip27-memory.c
> > > +++ b/arch/mips/sgi-ip27/ip27-memory.c
> > > @@ -34,8 +34,10 @@
> > >   #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
> > >   #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
> > >   
> > > -struct node_data *__node_data[MAX_NUMNODES];
> > > +struct pglist_data *node_data[MAX_NUMNODES];
> > > +EXPORT_SYMBOL(node_data);
> > >   
> > > +struct node_data *__node_data[MAX_NUMNODES];
> > >   EXPORT_SYMBOL(__node_data);
> > >   
> > >   static u64 gen_region_mask(void)
> > > @@ -361,6 +363,7 @@ static void __init node_mem_init(nasid_t node)
> > >   	 */
> > >   	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
> > >   	memset(__node_data[node], 0, PAGE_SIZE);
> > > +	node_data[node] = &__node_data[node]->pglist;
> > >   
> > >   	NODE_DATA(node)->node_start_pfn = start_pfn;
> > >   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;  
> > 
> > I was assuming we could get rid of __node_data->pglist.
> > 
> > But now I am confused where that is actually set.
> 
> It looks nasty... 

Nasty indeed :)

> Cast in arch_refresh_nodedata() takes incoming pg_data_t * and casts it
> to the local version of struct node_data * which I think is this one
> 
> struct node_data {
> 	struct pglist_data pglist; (which is pg_data_t pglist)
> 	struct hub_data hub;
> };
> 
> https://elixir.bootlin.com/linux/v6.10/source/arch/mips/sgi-ip27/ip27-memory.c#L432
> 
> Now that pg_data_t is allocated by 
> arch_alloc_nodedata() which might be fine (though types could be handled in a more
> readable fashion via some container_of() magic.
> https://elixir.bootlin.com/linux/v6.10/source/arch/mips/sgi-ip27/ip27-memory.c#L427
> 
> However that call is:
> pg_data_t * __init arch_alloc_nodedata(int nid)
> {
> 	return memblock_alloc(sizeof(pg_data_t), SMP_CACHE_BYTES);
> }
> 
> So doesn't seem to allocate enough space to me as should be sizeof(struct node_data)

Well, it's there to silence a compiler error (commit f8f9f21c7848 ("MIPS:
Fix build error for loongson64 and sgi-ip27")), but this is not a proper
fix :(
Luckily nothing calls cpumask_of_node() for offline nodes...
 
> Worth cleaning up whilst here?  Proper handling of types would definitely
> help.

Worth cleanup indeed, but I'd rather drop arch_alloc_nodedata() on MIPS
altogether.
 
> Jonathan

-- 
Sincerely yours,
Mike.

