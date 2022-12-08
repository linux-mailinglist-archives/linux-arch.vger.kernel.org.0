Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039AE6476C9
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 20:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHTsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 14:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHTsM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 14:48:12 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D2389DC;
        Thu,  8 Dec 2022 11:48:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B2CA05C0069;
        Thu,  8 Dec 2022 14:48:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Dec 2022 14:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670528886; x=1670615286; bh=hn
        /OnOtk3EASdGn92mWNbIzbnlYcn0q3Kf908b3pElo=; b=k0BfM5Xmr1BuhCrrQl
        03JuMYehLfM6mUUmRIOk0F3ik/ftbG7J2GUi93knfDi9fvkegXdewTDmKbYTdSWq
        Z81TR41z7Vplq+QyjWiqTbght6/53lIN1U9+9rWEOi5itMVycc3KSTSLPcv/ypvQ
        ewFRB95lN3Kl8eBFhpv1EHpX+vJE3cbQBMU+Qth9sx9/7PaTgryDartyR25robn3
        /UGoitFYqhbTr3iJL36T8juROQBNqds0JvYnngTCj1k2LQ35FLE6Vofk7q8W01u4
        H0z5cPE2ycN6YhJtznV7DxpppzSUL8b4I1bcsopa3yqqHvj18Ig9SVdaxNds+Qwo
        uzGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670528886; x=1670615286; bh=hn/OnOtk3EASdGn92mWNbIzbnlYc
        n0q3Kf908b3pElo=; b=qavhLUIrbBjbDvtE/aQE6C82RgilvuZVpyOGz0ip7N2U
        xn9kgkts8vSnerOddtY/Vj0Yj7+GS5szWg1APvswdRLqbYKa8QJUb57JAsp9A4be
        Dgv2lEsxeLeMznOlzuv5iSKdibFg5BaaRqsApONfrWOH8cJyveHbF3rMPK0g179b
        cwyDSgHnqTDq45/RWGbGq2zg+DhONNga83Swg9l9iGY8+pXW/SqijAdtb8UbT/Dq
        B14MnY6INU1v8EjDImlmKsBTOTND7H2KsfIgdbHc35daZf2ueBeuYKgD6R/C1Wh2
        0ic2kFp+LI/HTgIjhqS47onD67Y5e4k4K6hSUTbGgA==
X-ME-Sender: <xms:dT-SY8YvffzaelK86bZuXREEACVZ5wlO47_y7MGmP1odIFLSQXWpoQ>
    <xme:dT-SY3ZXtwB3GJ7E1U1RyAAK5mDD28zpWhaijx-_gEJI_mb71jdvMMln98_0FCR7D
    s0MtbCzAoUvo8vQpA0>
X-ME-Received: <xmr:dT-SY2-ZzPJkygjgodaaYWQsuEiXA1aMtHPP198vcDC9a9BP3JnQznhSclH-B-oBJdEENw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:dT-SY2p6LiyBboVTxyFHH1oecN3QTCPC0xVZIIMBnASLy7xwfu73wg>
    <xmx:dT-SY3ofwZPLui7aVwZmADkcCsBAgGfF9To7YpF6xXK8fL_lkuDOkw>
    <xmx:dT-SY0Sf4LzpdQKHVp7YnDINAG2Y5bH7erZ-OY8uW2U8YNOL2DKCwA>
    <xmx:dj-SYxbfvz63zviX8rgeDKC6YaCjTXsEmHmoWeyFYb4XAw3HZmJLYQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 14:48:05 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 91B70109CB7; Thu,  8 Dec 2022 22:48:00 +0300 (+03)
Date:   Thu, 8 Dec 2022 22:48:00 +0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Message-ID: <20221208194800.n27ak4xj6pmyny46@box.shutemov.name>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207003325.21503-2-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 06, 2022 at 04:33:20PM -0800, Dexuan Cui wrote:
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
> 
> When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
> when hyperv_init() -> swiotlb_update_mem_attributes() ->
> set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes in v2:
>   Used __tdx_hypercall() directly in tdx_map_gpa().
>   Added a max_retry_cnt of 1000.
>   Renamed a few variables, e.g., r11 -> map_fail_paddr.
> 
>  arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3fee96931ff5..cdeda698d308 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -20,6 +20,8 @@
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
>  
> +#define TDVMCALL_STATUS_RETRY		1
> +
>  /* MMIO direction */
>  #define EPT_READ	0
>  #define EPT_WRITE	1
> @@ -692,14 +694,15 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
>  }
>  
>  /*
> - * Inform the VMM of the guest's intent for this physical page: shared with
> - * the VMM or private to the guest.  The VMM is expected to change its mapping
> - * of the page in response.
> + * Notify the VMM about page mapping conversion. More info about ABI
> + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> + * section "TDG.VP.VMCALL<MapGPA>".
>   */
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	int max_retry_cnt = 1000, retry_cnt = 0;

Hm. max_retry_cnt looks too high to me. I expected to see 3 or something.

Any justification for it to be *that* high?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
