Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A063731D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKXHvh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 02:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKXHvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 02:51:35 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D511EC7B;
        Wed, 23 Nov 2022 23:51:34 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 32EBC3200A06;
        Thu, 24 Nov 2022 02:51:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 24 Nov 2022 02:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669276289; x=1669362689; bh=sG
        ZdtfEWGSBqamp6pKOyApGq/wm/DF7tGrDzz1+dKwg=; b=NMN6KHpM2CI3s9x1Zs
        QTYbDYK5jMgtqj3AhfY7cPoxLud6LDOllqbfI0EhbATKT5ESzoFYeGnrHyBphmvc
        q8zirwUNcoxzWuvmgYB0fVM4CUAz/7FITTsFnj/C8j6dBezNLQi8PLSEAGnvpqgr
        crWD2vgegEWv0xe5hE8MgWG+sJUl+4AtFd9oOv29xjClN5di5jpH8jmvD2Tt3RJb
        Oyo7WuyXrU9EoIlCULlDZojPl3FZfSN9hEaaTOVqtQJUl9hv7FbLzoGpVHkj4ZI5
        1lvpgVqFv0SyqX/Hkn34K002puIQkttpqVbSXDyr+tIL8VQecBBOeXeh/GU0Blzi
        DnPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669276289; x=1669362689; bh=sGZdtfEWGSBqamp6pKOyApGq/wm/
        DF7tGrDzz1+dKwg=; b=SCo98fcq4Y9dwWYBgr4WWI6c8so/N2W1m+4GoWD7zPSZ
        USM2x4ONfBNC7H5HMFtMjymc3PJg8YJwzT4YcYbfFoVEQaTnYyWCnrGzrjxJhoGx
        o7zHlTEi55NGrPUVm/OYMNgAk6hS/81WQ7i3HpcTz6SivigXXYOdn9Mg1Gk+ss5r
        Gk8k4ZZvUJyY3PUxVBMrkBYW5yqxbBWhFUaYszwpqkIaM2WFyN5NYI8Zyfsf6Dwj
        iShFXP3fcgXnj9uUzN992TgL1aaxNhZNr3To5nJz3JJ6mt9T6qJotDCvWR2Zo53j
        JhbyzkK6ZKKB+68gm0qBkdubTzDIHfdkPNWzbwpbsQ==
X-ME-Sender: <xms:gCJ_Y82l4TfY_svmtoc69axlJ-rPbySv_Gu1yUoIv-jdkbPL_5hNXQ>
    <xme:gCJ_Y3Hi-2waZF3qxKG7-NjxGPDj6npCEarAXugE0o3ycAux10osnX_bwTCZ-E5oC
    EncQs3f25kja8UUndk>
X-ME-Received: <xmr:gCJ_Y05IPWpST0dyLEdup9pPn_-tUvBvu-XBpwt4PIboo8Ml3eBbRxuvz28zsqn10g6Itg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpedujedvieetleekfedvheetgfdthffhhfetueet
    kefgvdfhffejveduieeltefhjeenucffohhmrghinheplhifnhdrnhgvthenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhh
    uhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:gSJ_Y11J2dsecz0MLG00XO3WrzVmZYnkJkLcqc57Lezi7VqjBoibnQ>
    <xmx:gSJ_Y_GObVd2aMlHeQrseXD-L1mRLWqNFpUq2Cu79Laipw8o2S1w7w>
    <xmx:gSJ_Y-_-JO06Bbtkv7ONS0OGACi6NjDfCgATWHLu0S_XMvPoN7iORw>
    <xmx:gSJ_Y-ne_2keqaeJ_Z33gKRdFtNCOLVo5K2AfvYxcLLwNyMg1zHtdA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Nov 2022 02:51:28 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 797D41049C1; Thu, 24 Nov 2022 10:51:25 +0300 (+03)
Date:   Thu, 24 Nov 2022 10:51:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20221124075125.56cpbkmjyr26dzsn@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
 <20221122002421.qg4h47cjoc2birvb@box.shutemov.name>
 <SA1PR21MB133536EA0C26DFE0168E2F98BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB133536EA0C26DFE0168E2F98BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 23, 2022 at 11:51:11PM +0000, Dexuan Cui wrote:
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > Sent: Monday, November 21, 2022 4:24 PM
> > 
> > On Mon, Nov 21, 2022 at 11:51:48AM -0800, Dexuan Cui wrote:
> > > When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> > > allocates buffers using vzalloc(), and needs to share the buffers with the
> > > host OS by calling set_memory_decrypted(), which is not working for
> > > vmalloc() yet. Add the support by handling the pages one by one.
> > 
> > Why do you use vmalloc here in the first place?
> 
> We changed to vmalloc() long ago, mainly for 2 reasons:
> 
> 1) __alloc_pages() only allows us to allocate up to 4MB of contiguous pages, but
> we need a 16MB buffer in the Hyper-V vNIC driver for better performance.
> 
> 2) Due to memory fragmentation, we have seen that the page allocator can fail
> to allocate 2 contigous pages, though the system has a lot of free memory. We
> need to support Hyper-V vNIC hot addition, so we changed to vmalloc. See
> 
> b679ef73edc2 ("hyperv: Add support for physically discontinuous receive buffer")
> 06b47aac4924 ("Drivers: net-next: hyperv: Increase the size of the sendbuf region")
> 
> > Will you also adjust direct mapping to have shared bit set?
> > 
> > If not, we will have problems with load_unaligned_zeropad() when it will
> > access shared pages via non-shared mapping.
> > 
> > If direct mapping is adjusted, we will get direct mapping fragmentation.
> 
> load_unaligned_zeropad() was added 10 years ago by Linus in
> e419b4cc5856 ("vfs: make word-at-a-time accesses handle a non-existing page") 
> so this seemingly-strange usage is legitimate.
> 
> Sorry I don't know how to adjust direct mapping. Do you mean I should do
> something like the below in tdx_enc_status_changed_for_vmalloc() for
> every 'start_va':
>   pa = slow_virt_to_phys(start_va);
>   set_memory_decrypted(phys_to_virt(pa), 1);
> ?
> 
> But IIRC this issue is not specific to vmalloc()? e.g. we get 1 page by
> __get_free_pages(GFP_KERNEL, 0) or kmalloc(PAGE_SIZE, GFP_KERNEL)
> and we call set_memory_decrypted() for the page. How can we make
> sure the callers of load_unaligned_zeropad() can't access the page
> via non-shared mapping?

__get_free_pages() and kmalloc() returns pointer to the page in the direct
mapping. set_memory_decrypted() adjust direct mapping to have the shared
bit set. Everything is fine.

> It looks like you have a patchset to address the issue (it looks like it
> hasn't been merged into the mainline?) ?
> https://lwn.net/ml/linux-kernel/20220614120231.48165-11-kirill.shutemov@linux.intel.com/

It addresses similar, but different issue. It is only relevant for
unaccepted memory support.

> BTW, I'll drop tdx_enc_status_changed_for_vmalloc() and try to enhance the
> existing tdx_enc_status() to support both direct mapping and vmalloc().
> 
> > Maybe tap into swiotlb buffer using DMA API?
> 
> I doubt the Hyper-V vNIC driver here can call dma_alloc_coherent() to
> get a 16MB buffer from swiotlb buffers. I'm looking at dma_alloc_coherent() ->
> dma_alloc_attrs() -> dma_direct_alloc(), which typically calls 
> __dma_direct_alloc_pages() to allocate congituous memory pages (which
> can't exceed the 4MB limit. Note there is no virtual IOMMU in a guest on Hyper-V).
> 
> It looks like we can't force dma_direct_alloc() to call dma_direct_alloc_no_mapping(),
> because even if we set the DMA_ATTR_NO_KERNEL_MAPPING flag,
> force_dma_unencrypted() is still always true for a TDX guest.

The point is not in reaching dma_direct_alloc_no_mapping(). The idea is
allocate from existing swiotlb that already has shared bit set in direct
mapping.

vmap area that maps pages allocated from swiotlb also should work fine.

To be honest, I don't understand DMA API well enough. I need to experiment
with it to see what works for the case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
