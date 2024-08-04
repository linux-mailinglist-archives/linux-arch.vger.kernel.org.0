Return-Path: <linux-arch+bounces-5953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F0946D0A
	for <lists+linux-arch@lfdr.de>; Sun,  4 Aug 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EA2B216DE
	for <lists+linux-arch@lfdr.de>; Sun,  4 Aug 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B41A277;
	Sun,  4 Aug 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIU8LoVO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8323182AE;
	Sun,  4 Aug 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722756394; cv=none; b=Z7CadaDeegNVS7gRk3bQlQXC0tSwb295nAVtwl8CiSOyK3Sya2a+6tPgPKn0eZlj5KcsMAxtP/qTN3es5P/1n5mI+MAId4P/pAzOpBuBHBNCkfo99twUzKF+qR9UL+XZgkv7uTdAMvXbL0pk3tmqiz57iMlFllu9bp9hpT7xHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722756394; c=relaxed/simple;
	bh=rx2UdBu3Jn4YvMBlkSpIvWfaZAHG3g5eVDYxreRC0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X20AeBFAVk/Wo5HEZjYW3gPQIelM1eCMXWKq8vKdHwmk8E/N/Nct7eEC5LGF0vkZMmAE6I4fQ6F42FlLpYZEXrNUw4QAGlptnhT4Tho9LTiU3ik5alz5qy8RJaeel0D+gT68fkYAoIRSSPWHOHV+ovPbDUNsAadScBG+oLr7c6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIU8LoVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD611C32786;
	Sun,  4 Aug 2024 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722756393;
	bh=rx2UdBu3Jn4YvMBlkSpIvWfaZAHG3g5eVDYxreRC0w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIU8LoVOwFPBw/i+e9r4MNw3lCZ9Vibx6Dii6JlG87646MCH9g5WB4uLhl1sgD8XY
	 fdhDH8dGci/plC04bp2qqqFN5dQbJHMWc6fWKJYivJ+bk5+GubVSlg3B3t+HSNIfir
	 JTwRTaCcEoGzTNU1jYvwPfIqnBAdwUe1xFf3HqAX19LfaXMjWdmtrEyuqIK93JEmBz
	 EFHb56nL5u7GvI90DNZwVtfaVmCpUg9fU4iOezzHPPuQFpcF1invnI5Iw9ThB6TUT4
	 ADe9mcgPXLgojRwwccp6Y65CANZWgRQC4iHBhVf31YxxkVq1gi+zDus1lvqFhKf27J
	 Jc+qx/YNiH/Gg==
Date: Sun, 4 Aug 2024 10:24:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
Subject: Re: [PATCH v3 07/26] mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
Message-ID: <Zq8sn5iD1iOmYrss@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-8-rppt@kernel.org>
 <20240802104922.000051a0@Huawei.com>
 <20240803115813.809f808f1afbe9f9feaae129@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803115813.809f808f1afbe9f9feaae129@linux-foundation.org>

On Sat, Aug 03, 2024 at 11:58:13AM -0700, Andrew Morton wrote:
> On Fri, 2 Aug 2024 10:49:22 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -1838,11 +1838,10 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> > >  
> > >  		if (!node_online(nid)) {
> > >  			/* Allocator not initialized yet */
> > > -			pgdat = arch_alloc_nodedata(nid);
> > > +			pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
> > >  			if (!pgdat)
> > >  				panic("Cannot allocate %zuB for node %d.\n",
> > >  				       sizeof(*pgdat), nid);
> > > -			arch_refresh_nodedata(nid, pgdat);
> > 
> > This allocates pgdat but never sets node_data[nid] to it
> > and promptly leaks it on the line below. 
> > 
> > Just to sanity check this I spun up a qemu machine with no memory
> > initially present on some nodes and it went boom as you'd expect.
> > 
> > I tested with addition of
> > 			NODE_DATA(nid) = pgdat;
> > and it all seems to work as expected.
> 
> Thanks, I added that.  It blew up on x86_64 allnoconfig because
> node_data[] (and hence NODE_DATA()) isn't an lvalue when CONFIG_NUMA=n.
> 
> I'll put some #ifdef CONFIG_NUMAs in there for now but
> 
> a) NODE_DATA() is upper-case. Implies "constant".  Shouldn't be assigned to.
> 
> b) NODE_DATA() should be non-lvalue when CONFIG_NUMA=y also.  But no,
>    we insist on implementing things in cpp instead of in C.

This looks like a candidate for a separate tree-wide cleanup.
 
> c) In fact assigning to anything which ends in "()" is nuts.  Please
>    clean up my tempfix.
> 
> c) Mike, generally I'm wondering if there's a bunch of code here
>    which isn't needed on CONFIG_NUMA=n.  Please check all of this for
>    unneeded bloatiness.

I believe the patch addresses your concerns, just with this the commit log
needs update. Instead of 

    Replace the call to arch_alloc_nodedata() in free_area_init() with
    memblock_alloc(), remove arch_refresh_nodedata() and cleanup
    include/linux/memory_hotplug.h from the associated ifdefery.

it should be

    Replace the call to arch_alloc_nodedata() in free_area_init() with a
    new helper alloc_offline_node_data(), remove arch_refresh_nodedata()
    and cleanup include/linux/memory_hotplug.h from the associated
    ifdefery.

I can send an updated patch if you prefer.

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 3b12d8ca0afd..5a749fd67f39 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -34,6 +34,7 @@ extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 
 void __init alloc_node_data(int nid);
+void __init alloc_offline_node_data(int nit);
 
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
@@ -62,6 +63,8 @@ static inline int phys_to_target_node(u64 start)
 {
 	return 0;
 }
+
+static inline void alloc_offline_node_data(int nit) {}
 #endif
 
 #define numa_map_to_online_node(node) numa_nearest_node(node, N_ONLINE)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index bcc2f2dd8021..2785be04e7bb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1836,13 +1836,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	for_each_node(nid) {
 		pg_data_t *pgdat;
 
-		if (!node_online(nid)) {
-			/* Allocator not initialized yet */
-			pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
-			if (!pgdat)
-				panic("Cannot allocate %zuB for node %d.\n",
-				       sizeof(*pgdat), nid);
-		}
+		if (!node_online(nid))
+			alloc_offline_node_data(nid);
 
 		pgdat = NODE_DATA(nid);
 		free_area_init_node(nid);
diff --git a/mm/numa.c b/mm/numa.c
index da27eb151dc5..07e486a977c7 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -34,6 +34,18 @@ void __init alloc_node_data(int nid)
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 }
 
+void __init alloc_offline_node_data(int nit)
+{
+	pg_data_t *pgdat;
+
+	pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
+	if (!pgdat)
+		panic("Cannot allocate %zuB for node %d.\n",
+		      sizeof(*pgdat), nid);
+
+	node_data[nid] = pgdat;
+}
+
 /* Stub functions: */
 
 #ifndef memory_add_physaddr_to_nid

 

-- 
Sincerely yours,
Mike.

