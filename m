Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CE6BDCD7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 00:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCPXV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPXV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 19:21:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5B166F3;
        Thu, 16 Mar 2023 16:21:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CC085C00EA;
        Thu, 16 Mar 2023 19:21:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Mar 2023 19:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679008909; x=
        1679095309; bh=NDL3s7Y1GOqfG6hPqH5js9xDmdyyUkP3DPGLsp0f3rU=; b=e
        lDnp1MGxyujwkKlbmwPAXuwloUV6QY5G6tc00ba5wDbJqnmSGX9tVccVvIeBiszL
        79E9zptY6JHOvyUl55Tx7PUWVf+m3KpvClYCjcdGXrkkl7I9lDq9jbMSgQAQpVTJ
        A1rCTfAd4Dp6NdPK/GHb6JaANP29kIq5seX079J++PtH/gBhpMjowWIXeTLgBLfX
        69tKxfcyQPMvm/PN/egpsxwZb5zWF//gcJMUeaEd2IehVWVntqq6ePkX0am/QqHS
        1tp+/nVr+PKrhJNm0FqLpM18Uxkj6fAguH6K5oEmuiEhLtwcQ7eDXvH/Lx0veb+k
        T5GoI3XAmSGxOltCziSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679008909; x=1679095309; bh=NDL3s7Y1GOqfG
        6hPqH5js9xDmdyyUkP3DPGLsp0f3rU=; b=uaDND/ll7ww/okj6AaMBlo8tj1qsQ
        v8U3EJtNL8pcUpoeKfB7drMGdU8dc1899q4UXDvidFlcJmV00fpKPYutXEyAzZgX
        vYMoShZbTNUMyA2S+bGsEcQbeuTGvqVDUbCzsSEj0NyDxVAVrN+o8KtCZwwG6OXV
        uaD3LS10AwR3X683kPgBsBtVHwzJ/I+gYqsiYVsHNzibp31LCy4DNlmUKjZ4XQLv
        /SwpawF50+N7UPEtu71s/xtPxqD5BP5R87+DkNE67ztjRGzs2yDVtAciSyAwqDC6
        P/PpjJT0wd7bvy90/Xj3W4yp9hydMHKiEhONmrB/ErCDqQHhGeqt9dIFg==
X-ME-Sender: <xms:jKQTZDJPbXxIK9S-QkUCHBARIBVLCiJThHr_mqFLOFTq0hvKapiu2Q>
    <xme:jKQTZHLAv9W7_CoCkXfwX9pNSFrfgOpTteGf4AUGaN7H4pHwbG8rxqLizQktXhseH
    DzawpDlqQJ1rKhL-jo>
X-ME-Received: <xmr:jKQTZLu0A4YWDEuruNS3nEKd0-YVF86c1TmSYe1irpdphOVVt-cNPW1Zzwy0OFAeLYvQDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:jKQTZMZhO2_ndiqVoTSlJUmwVvQRwvph_2AYlK5fxXzTMkCsomwh4w>
    <xmx:jKQTZKZJ7MhDyE4YFQXU4LB16ndAonaEDJNDYrrdU2-06ZiuofQ5ZA>
    <xmx:jKQTZAActTCbfEJZ3lrsVwDIY5-3w59Vu1EGPGnqRvJ_i58i4Ztpkw>
    <xmx:jaQTZC5LQquisAxKcyLKnUZ74aIGEC7-hLuOAq-baKPKK6IV_Zkz3A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 19:21:48 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BD74310C9F7; Fri, 17 Mar 2023 02:21:44 +0300 (+03)
Date:   Fri, 17 Mar 2023 02:21:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230316232144.b7ic4cif4kjiabws@box.shutemov.name>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <06785A33-BDBD-4EEC-B063-19E1002F87D9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06785A33-BDBD-4EEC-B063-19E1002F87D9@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 16, 2023 at 01:09:30PM -0400, Zi Yan wrote:
> > diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > index 86fd88492870..c267b8c61e97 100644
> > --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > @@ -172,7 +172,7 @@ variables.
> >  Offset of the free_list's member. This value is used to compute the number
> >  of free pages.
> >
> > -Each zone has a free_area structure array called free_area[MAX_ORDER].
> > +Each zone has a free_area structure array called free_area[MAX_ORDER + 1].
> >  The free_list represents a linked list of free page blocks.
> >
> >  (list_head, next|prev)
> 
> In vmcoreinfo.rst, line 192:
> 
> - (zone.free_area, MAX_ORDER)
> + (zone.free_area, MAX_ORDER + 1)

Okay.

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6221a1d057dd..50da4f26fad5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3969,7 +3969,7 @@
> >  			[KNL] Minimal page reporting order
> >  			Format: <integer>
> >  			Adjust the minimal page reporting order. The page
> > -			reporting is disabled when it exceeds (MAX_ORDER-1).
> > +			reporting is disabled when it exceeds MAX_ORDER.
> >
> >  	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
> >  			timeout > 0: seconds before rebooting
> 
> line 942:
> -		    possible value is MAX_ORDER/2.  Setting this parameter
> +			possible value is (MAX_ORDER + 1)/2.  Setting this parameter
> 

I don't think it worth it. See below, on the relevant code change.

> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index d6bbdb7830b2..273a0fe7910a 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, int order)
> >  {
> >  	struct page *page;
> >
> > -	if (order >= MAX_ORDER)
> > -		order = MAX_ORDER - 1;
> > +	if (order > MAX_ORDER)
> > +		order = MAX_ORDER;
> >
> >  	do {
> >  		page = alloc_pages_node(node, PERF_AUX_GFP, order);
> 
> line 817:
> 
> -	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
> +	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)

Right.

> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 4751031f3f05..fc059969d7ba 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -346,9 +346,9 @@ config SHUFFLE_PAGE_ALLOCATOR
> >  	  the presence of a memory-side-cache. There are also incidental
> >  	  security benefits as it reduces the predictability of page
> >  	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> > -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> > -	  10th order of pages is selected based on cache utilization
> > -	  benefits on x86.
> > +	  default granularity of shuffling on the MAX_ORDER i.e, 10th
> > +	  order of pages is selected based on cache utilization benefits
> > +	  on x86.
> >
> >  	  While the randomization improves cache utilization it may
> >  	  negatively impact workloads on platforms without a cache. For
> 
> line 669:
> 
> -	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will be
> -	  clamped down to MAX_ORDER - 1.
> +	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
> +	  clamped down to MAX_ORDER.
> 

Okay. Missed that.

> > diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
> > index 7fb794242fad..ffedf4dbc49d 100644
> > --- a/mm/kmsan/init.c
> > +++ b/mm/kmsan/init.c
> > @@ -96,7 +96,7 @@ void __init kmsan_init_shadow(void)
> >  struct metadata_page_pair {
> >  	struct page *shadow, *origin;
> >  };
> > -static struct metadata_page_pair held_back[MAX_ORDER] __initdata;
> > +static struct metadata_page_pair held_back[MAX_ORDER + 1] __initdata;
> >
> >  /*
> >   * Eager metadata allocation. When the memblock allocator is freeing pages to
> 
> line 144: this one I am not sure if the original code is wrong or not.
> 
> -	.order = MAX_ORDER,
> +	.order = MAX_ORDER + 1,

I think the original code is wrong, but the initialization seems unused:
it got overridden in kmsan_memblock_discard() before the first use.

> > @@ -211,8 +211,8 @@ static void kmsan_memblock_discard(void)
> >  	 *    order=N-1,
> >  	 *  - repeat.
> >  	 */
> > -	collect.order = MAX_ORDER - 1;
> > -	for (int i = MAX_ORDER - 1; i >= 0; i--) {
> > +	collect.order = MAX_ORDER;
> > +	for (int i = MAX_ORDER; i >= 0; i--) {
> >  		if (held_back[i].shadow)
> >  			smallstack_push(&collect, held_back[i].shadow);
> >  		if (held_back[i].origin)
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 25fd0626a9e7..338b8cb0793e 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2043,7 +2043,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
> >  	int order;
> >
> >  	while (start < end) {
> > -		order = min(MAX_ORDER - 1UL, __ffs(start));
> > +		order = min(MAX_ORDER, __ffs(start));
> 
> while you are here, maybe using min_t is better.
> 
> order = min_t(unsigned long, MAX_ORDER, __ffs(start));

Already addressed by fixup.

> >
> >  		while (start + (1UL << order) > end)
> >  			order--;
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index db3b270254f1..86291c79a764 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -596,7 +596,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> >  	unsigned long pfn;
> >
> >  	/*
> > -	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> > +	 * Online the pages in MAX_ORDER aligned chunks. The callback might
> >  	 * decide to not expose all pages to the buddy (e.g., expose them
> >  	 * later). We account all pages as being online and belonging to this
> >  	 * zone ("present").
> > @@ -605,7 +605,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> >  	 * this and the first chunk to online will be pageblock_nr_pages.
> >  	 */
> >  	for (pfn = start_pfn; pfn < end_pfn;) {
> > -		int order = min(MAX_ORDER - 1UL, __ffs(pfn));
> > +		int order = min(MAX_ORDER, __ffs(pfn));
> 
> ditto
> 
> int order = min_t(unsigned long, MAX_ORDER, __ffs(pfn));

Ditto.

> >
> >  		(*online_page_callback)(pfn_to_page(pfn), order);
> >  		pfn += (1UL << order);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ac1fc986af44..66700f27b4c6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> 
> line 842: it might make a difference when MAX_ORDER is odd.
> 
> -	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
> +	if (kstrtoul(buf, 10, &res) < 0 ||  res > (MAX_ORDER + 1) / 2) {

I don't think it worth the complication: the upper limit here is pretty
arbitrary and +1 doesn't really make a difference. I would rather keep it
simple.

> > diff --git a/mm/slub.c b/mm/slub.c
> > index 32eb6b50fe18..0e19c0d647e6 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4171,8 +4171,8 @@ static inline int calculate_order(unsigned int size)
> >  	/*
> >  	 * Doh this slab cannot be placed using slub_max_order.
> >  	 */
> > -	order = calc_slab_order(size, 1, MAX_ORDER - 1, 1);
> > -	if (order < MAX_ORDER)
> > +	order = calc_slab_order(size, 1, MAX_ORDER, 1);
> > +	if (order <= MAX_ORDER)
> >  		return order;
> >  	return -ENOSYS;
> >  }
> > @@ -4697,7 +4697,7 @@ __setup("slub_min_order=", setup_slub_min_order);
> >  static int __init setup_slub_max_order(char *str)
> >  {
> >  	get_option(&str, (int *)&slub_max_order);
> > -	slub_max_order = min(slub_max_order, (unsigned int)MAX_ORDER - 1);
> > +	slub_max_order = min(slub_max_order, (unsigned int)MAX_ORDER);
> 
> maybe min_t is better?
> 
> slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);

Fair enough.

...

> The changes look good to me. I added some missing changes inline, although the line
> number might not be exact. Feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com>.
> 
> Do you think it is worth adding a MAX_ORDER check in checkpatch.pl to warn people
> the meaning of MAX_ORDER has changed? Something like:
> 
> # check for MAX_ORDER uses as its semantics has changed.
> # MAX_ORDER now really means the max order of a page that can come out of
> # kernel buddy allocator
>         if ($line =~ /MAX_ORDER/) {
>             WARN("MAX_ORDER",
>                  "MAX_ORDER has changed its semantics. The max order of a page that can be allocated from buddy allocator is MAX_ORDER instead of MAX_ORDER - 1.")
>         }
> 

We can add, if you think it is helpful. I don't feel strongly about this.

Below is fixup I made based on your feedback:

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index c267b8c61e97..e488bb4e13c4 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -189,7 +189,7 @@ Offsets of the vmap_area's members. They carry vmalloc-specific
 information. Makedumpfile gets the start address of the vmalloc region
 from this.
 
-(zone.free_area, MAX_ORDER)
+(zone.free_area, MAX_ORDER + 1)
 ---------------------------
 
 Free areas descriptor. User-space tools use this value to iterate the
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 273a0fe7910a..a0433f37b024 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -814,7 +814,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	size = sizeof(struct perf_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
+	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
 	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
diff --git a/mm/Kconfig b/mm/Kconfig
index 467844de48e5..6ee3b48ed298 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -666,8 +666,8 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes available
 	  on a platform.
 
-	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will be
-	  clamped down to MAX_ORDER - 1.
+	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
+	  clamped down to MAX_ORDER.
 
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
diff --git a/mm/slub.c b/mm/slub.c
index 0e19c0d647e6..f49d669ff604 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4697,7 +4697,7 @@ __setup("slub_min_order=", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order = min(slub_max_order, (unsigned int)MAX_ORDER);
+	slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);
 
 	return 1;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
