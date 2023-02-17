Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D869AC48
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBQNUC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 08:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBQNUB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 08:20:01 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D410067452;
        Fri, 17 Feb 2023 05:19:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CC70D3200916;
        Fri, 17 Feb 2023 08:19:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 17 Feb 2023 08:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676639993; x=1676726393; bh=my
        TFn4KmrWimVKjCPObg5mC8iDNbWDR3kBMFSM8XDnQ=; b=jIl4Nkl5jkqu+kJgn0
        wN3uIEIM7zCYq38PGioTcFq7vXepwAOt0Yrlh2RIluYl39TyOPQOdpDut3RpbIOA
        Vohcmg5M2B1sl1ySUYJhLnyd0Ubk2RT8YqMB+Hg+t9xKnzhoUG15qhsMHOtvFth1
        dkh0X2N2KBk90VztU/Qvb3JkyFaJ1fYP57Bw+ogBoh24Lx/r4tRINJVR7O16jsBN
        LVTjws1NZMWCQ2CrJ9GPQoCmwy11gT3yZ6XoropRxbCy43JuISPzshzPyKOp7ebh
        87Ho9RXevbBCmlDQbnlf0bQdcjjhN5e9oedv4B7524ZLorgok+/GcdlSS/DdgCmK
        AUUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676639993; x=1676726393; bh=myTFn4KmrWimVKjCPObg5mC8iDNb
        WDR3kBMFSM8XDnQ=; b=cUKALe8Q4obU06Q6HHbdK8SDP5dP9iGmM13t4a2n6fz2
        911jUXRKpFCOCWCfkriiRPgaBg0d7saR/lL73FjsfjSfYR5XGaxxHt9HssZTtj3u
        GqfHTXiQTM6Steopzl4uZRFGpZ5Su1cdzGDBC/TnjOwvN2JgJT9MfRaiqPgTr4Rw
        n0zsLu4iE8b7yChlK8LZLBjkvnTockJ17AUa2QmW1WI1ZUruH2tWqFe87zy9mTM4
        0QU+MMlAV5ePqjdVaLbUMrDI6CdpjoaCqLFyRV5iL0IzwvhhCLb38q2sKRCBvCcB
        fxIY82lNSvWrOO3+rtmtJo0iAkc34ZiTciJQQMoDZQ==
X-ME-Sender: <xms:-H7vY67baue8pdKk10h1Fi2ENbQKuNV18npNZdESxuM-nRqhEgn3VQ>
    <xme:-H7vYz75OzpIIc7_4jz6msqs2FEI_W6uMYZM8ijM1_sfgWJLeH7EIyCXc0XPfZFHm
    2GaXkthmoSts3lQ538>
X-ME-Received: <xmr:-H7vY5cr_y1AcWEev1L3WIfbiYIs_6ygaKakrAtyWmDk_w1iCuaUZkns1M6fAsrYNV5qkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:-H7vY3Kl5jyiglPmMnnV4XJtu99v-mj0IYgcUrz709wsnUcWwxOqvw>
    <xmx:-H7vY-KhNMQUQ9kYPlmsRN81fM4iHUX18xYMiOSlGeKpdJpI9ECR6A>
    <xmx:-H7vY4yVGI1mk796blOZkk2Jnj-bTjUmTDl-v7hnHwXlJ2p7kraQTQ>
    <xmx:-X7vY2DMDwIvu7g2ocAODvyFBnQCMPepOEh9yiHIfyj98NRh-4sUOA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Feb 2023 08:19:51 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 13A4910BDBB; Fri, 17 Feb 2023 16:19:49 +0300 (+03)
Date:   Fri, 17 Feb 2023 16:19:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com
Subject: Re: [PATCH v3 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Message-ID: <20230217131949.oj4jz4dbvhyen5rl@box.shutemov.name>
References: <20230206192419.24525-1-decui@microsoft.com>
 <20230206192419.24525-3-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206192419.24525-3-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 11:24:15AM -0800, Dexuan Cui wrote:
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> ---
> 
> Changes in v2:
>   Changed tdx_enc_status_changed() in place.
> 
> Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
> how to get the underlying huge page info (if huge page is in use) and
> try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
> is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
> underlying page allocation info is internal to the mm code, and there
> is no mm API to for me get the info in tdx_enc_status_changed().

I also don't obvious way to retrieve this info after vmalloc() is
complete. split_page() makes all pages independent.

I think you can try to do this manually: allocate a vmalloc region,
allocate pages manually, and put into the region. This way you always know
page sizes and can optimize conversion to shared memory.

But it is tedious and I'm not sure if it worth the gain.

> Hi, Kirill, the load_unaligned_zeropad() issue is not addressed in
> this patch. The issue looks like a generic issue that also happens to
> AMD SNP vTOM mode and C-bit mode. Will need to figure out how to
> address the issue. If we decide to adjust direct mapping to have the
> shared bit set, it lools like we need to do the below for each
> 'start_va' vmalloc page:
>   pa = slow_virt_to_phys(start_va);
>   set_memory_decrypted(phys_to_virt(pa), 1); -- this line calls
> tdx_enc_status_changed() the second time for the same age, which is not
> great. It looks like we need to find a way to reuse the cpa_flush()
> related code in __set_memory_enc_pgtable() and make sure we call
> tdx_enc_status_changed() only once for the same page from vmalloc()?

Actually, current code will change direct mapping for you. I just
double-checked: the alias processing in __change_page_attr_set_clr() will
change direct mapping if you call it on vmalloc()ed memory.

Splitting direct mapping is still unfortunate, but well.

> 
> Changes in v3:
>   No change since v2.
> 
>  arch/x86/coco/tdx/tdx.c | 69 ++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 25 deletions(-)

I don't hate what you did here. But I think the code below is a bit
cleaner.

Any opinions?

static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
					bool enc)
{
	if (!tdx_map_gpa(start, end, enc))
		return false;

	/* private->shared conversion requires only MapGPA call */
	if (!enc)
		return true;

	return try_accept_page(start, end);
}

/*
 * Inform the VMM of the guest's intent for this physical page: shared with
 * the VMM or private to the guest. The VMM is expected to change its mapping
 * of the page in response.
 */
static bool tdx_enc_status_changed(unsigned long start, int numpages, bool enc)
{
	unsigned long end = start + numpages * PAGE_SIZE;

	if (offset_in_page(start) != 0)
		return false;

	if (!is_vmalloc_addr((void *)start))
		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);

	while (start < end) {
		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
		phys_addr_t end_pa = start_pa + PAGE_SIZE;

		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
			return false;

		start += PAGE_SIZE;
	}

	return true;
}

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
