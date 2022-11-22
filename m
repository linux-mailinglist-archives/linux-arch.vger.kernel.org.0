Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423C633115
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKVABI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 19:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVABH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 19:01:07 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8D60DE;
        Mon, 21 Nov 2022 16:01:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2D9713200955;
        Mon, 21 Nov 2022 19:01:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Nov 2022 19:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669075263; x=1669161663; bh=GK
        SMfwfa6pvS7PvzoP8mseYARhi9iWIxIIuJD0eitWc=; b=orVuwZMczxVq2gUe/a
        dop2fVTslC2Cy5fdFaM3NxzXZvAyYUL/XjiDWBAe4k1v8CTuaFsSppcG2QOzOY+Z
        LSb8GcdQyEgLCWELb5clRk158apyliXJ3UTFcCRbyNE6dPaVfwf+ZZ2aajFD3ZE3
        grNDEmobQEQEmnZ5LoTVOYj+tAWiBUA1LQkWlcXG+RMzE2T5k74BNhP5ix197oc0
        DUkXlvPqafIJAUUMTPR+kvbdg1+sQQG5D2SeFCBqnJsqB0xFjcDapsdL0vv6ywZO
        0Bx4fadysR7WK1z5LlLJ4G3ZgXM/K7N0ShKtRvDiy8VGxACVhbCrvGupVHkoP3XW
        D/vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669075263; x=1669161663; bh=GKSMfwfa6pvS7PvzoP8mseYARhi9
        iWIxIIuJD0eitWc=; b=tgdJZIruVcbtfE3KGqPvwv8H8u/bNfLZYWisPp2Ue39V
        /wbZTZM3/edKRRtx6ZpkXB3USIV3S2NMzSIRUpJkxphuMvvkKpzz8zj4rrp1EGK/
        8Ffk8xhbWrSCUQEMDCZ3egxbnk/pQIsW5E0OggNpb0Gf/sT1b5tro6XvDhCl134g
        K9dwutKll5XwH6151CVf4vlTtMroOkQDIHY1rp3g3hQEDcVBJguijXSTnSTP9GqT
        RP2DSsP7h4llzQjW+B6+ZGiC0f6Wt7nKoRXflYNycHaV9ZUu8Q8vNcRl0495tMSN
        DT8JnoqnbiCzbJu3dCiZqryWe3SxR0yivK+BqCeeeg==
X-ME-Sender: <xms:PhF8Y3SCGTQi_61VHIM9A4-hn0uWzKWI-z6KneGf0vAvrTLsrhWi7g>
    <xme:PhF8Y4zf9jzU_8nQS1WbudCdeKn20i-GjDvGh0edCsylpg86aUpn2zUvCWbIvIBX8
    Y9zcS0RFNkVH9FbX-U>
X-ME-Received: <xmr:PhF8Y81OZTbfz2dUI28sE9eYIULnQi6ZhlTtiw7oipLtpp7h2-BrWMZTqB69d77_c8ACCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:PhF8Y3Anzt0AXzs1x20pdIZ_13BamP2A7Iz1zg5YAaJOSXuCGP2IVQ>
    <xmx:PhF8YwgvuV9QJdATtuHdVd8qy2LP5Anznui6cfbU-M01uathlkjLNw>
    <xmx:PhF8Y7rSYO6aKj5YlemT-DAsbaywQyPzeekmgHVhstgr67CCmlyX1g>
    <xmx:PxF8Y4SFPnPXaMwaMfDg1gwvPeU77-DDo0jq_xVdqanSgjX3ITHN0g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 19:01:01 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 576EE109A30; Tue, 22 Nov 2022 03:01:00 +0300 (+03)
Date:   Tue, 22 Nov 2022 03:01:00 +0300
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Message-ID: <20221122000100.bizske6iltfgdwcu@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-3-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121195151.21812-3-decui@microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 11:51:47AM -0800, Dexuan Cui wrote:
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
>  arch/x86/coco/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3fee96931ff5..46971cc7d006 100644
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
> @@ -52,6 +54,25 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>  	return __tdx_hypercall(&args, 0);
>  }
>  
> +static inline u64 _tdx_hypercall_output_r11(u64 fn, u64 r12, u64 r13, u64 r14,
> +					    u64 r15, u64 *r11)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = fn,
> +		.r12 = r12,
> +		.r13 = r13,
> +		.r14 = r14,
> +		.r15 = r15,
> +	};
> +
> +	u64 ret;
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +	*r11 = args.r11;
> +	return ret;
> +}
> +

I'm not convinced it deserves a separate helper for one user.
Does it look that ugly if tdx_map_gpa() uses __tdx_hypercall() directly?

>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  void __tdx_hypercall_failed(void)
>  {
> @@ -691,6 +712,43 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
>  	return true;
>  }
>  
> +/*
> + * Notify the VMM about page mapping conversion. More info about ABI
> + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> + * section "TDG.VP.VMCALL<MapGPA>"
> + */
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> +{
> +	u64 ret, r11;
> +
> +	while (1) {

Endless? Maybe an upper limit if no progress?

> +		ret = _tdx_hypercall_output_r11(TDVMCALL_MAP_GPA, start,
> +						end - start, 0, 0, &r11);
> +		if (!ret)
> +			break;
> +
> +		if (ret != TDVMCALL_STATUS_RETRY)
> +			break;
> +
> +		/*
> +		 * The guest must retry the operation for the pages in the
> +		 * region starting at the GPA specified in R11. Make sure R11
> +		 * contains a sane value.
> +		 */
> +		if ((r11 & ~cc_mkdec(0)) < (start & ~cc_mkdec(0)) ||
> +		    (r11 & ~cc_mkdec(0)) >= (end  & ~cc_mkdec(0)))
> +			return false;

Emm. All of them suppose to have shared bit set, why not compare directly
without cc_mkdec() dance?

> +
> +		start = r11;
> +
> +		/* Set the shared (decrypted) bit. */
> +		if (!enc)
> +			start |= cc_mkdec(0);
> +	}
> +
> +	return !ret;
> +}
> +
>  /*
>   * Inform the VMM of the guest's intent for this physical page: shared with
>   * the VMM or private to the guest.  The VMM is expected to change its mapping
> @@ -707,12 +765,7 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  		end   |= cc_mkdec(0);
>  	}
>  
> -	/*
> -	 * Notify the VMM about page mapping conversion. More info about ABI
> -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> -	 * section "TDG.VP.VMCALL<MapGPA>"
> -	 */
> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +	if (!tdx_map_gpa(start, end, enc))
>  		return false;
>  
>  	/* private->shared conversion  requires only MapGPA call */
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
