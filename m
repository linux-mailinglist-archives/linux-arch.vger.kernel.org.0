Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCB6330FD
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 00:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiKUXxC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 18:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiKUXwv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 18:52:51 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC71175;
        Mon, 21 Nov 2022 15:52:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 187A632009A2;
        Mon, 21 Nov 2022 18:52:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Nov 2022 18:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669074761; x=1669161161; bh=/T
        TpDFg+so1Z9SXl6Kq/T8u7wvo0UjCRKomGK5iT/s8=; b=IJJVwzzxcJ5DKHsVm7
        ov7o5ATR7Ri0E7u4SgFnhVBO/2koLsIfZpLv0oz8cR+C44lPdeoLnOtJkBEBEeMr
        kHB+OirEKGY+vXm7EyIupVPaK+W7hEZ2h9WaDfeaT6y/Ugb1HIWVyPrsWE4C/2DW
        qlB240D94BMFpy2CHxAZfdEekkB6nwnnuAvXI9N3OefTrp+ju2a2V2sFKn6BW/OJ
        UvCUARpsv/KIl7eAhQPhSSOrRtxyaiQfUMj1+M2EDKnunVo4Mryq7UklG/VwbgQG
        qbPsWN/D8dCALig5St6Rk3LliwliekArVDuSWhUOxWWKrXim3u/OkCPUofso59Cz
        f1NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669074761; x=1669161161; bh=/TTpDFg+so1Z9SXl6Kq/T8u7wvo0
        UjCRKomGK5iT/s8=; b=FSVjBrQYZDQk8TpV4oQ04LxFlUfEoMBRvwugBnRlbuPo
        gHi8c22Oh6H5xbpx3GZVqN62UQq7IA4uwPFrOQHE+icrclxaTOX0ksaCr92EQui5
        mwyDdH23IHFuWB54Ym+WczOqX+Wo6D9vPgQQ3gg+FZRLdyl+/lqVb7o1GQ9zrgF9
        moDuDZnr69/ztHvUYkDxFkHZMKJr3wDjJcqsyKX7LpKra0sNTO0VIIwMIXHjgcnD
        VOBX6eTpLYqpcdY5nh0x+egPvdRaxLY4fUxerLuoSdGrZfogcBPU2NSuzo8dysgL
        Bd8YN1tQAZDlb9HMiRS9ucE4mi7ferN3/k3psD8IBQ==
X-ME-Sender: <xms:SQ98Y1h1UInJhsagoVTUqQdPlmeNJCraT3zKn9pzLFlsnB0lom9lsA>
    <xme:SQ98Y6AixYXHTIlL6_sSTVBIY5rp0_zRmOIKg6O2zYalIum7fM0TZeBm3QKOwZvYZ
    gtdNuNHLb4KvAoJHGs>
X-ME-Received: <xmr:SQ98Y1HW67Ta2vDoM8OsCZ6to0ucXALiBAOSwTAgfureTOII2w7FiilPH0h_ou-H7THn1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:SQ98Y6RyhgCQ8YCKVGl70EqBUWHsHtwIaiXeWveXCPfhQe6py7iN-Q>
    <xmx:SQ98YyzssSdBZG_cNqV7-4ewi9IIpMssjW4kZenxRukH8XczU1krGQ>
    <xmx:SQ98Yw6zZyLHRucvfn5EXv0cI86_5E9KsNz5VpORyYnkjQ-Y4qyKHg>
    <xmx:SQ98Y_g0eTL5HAoaos2nOwJPZsMOhYjuMU1wYcoYJ8U71jmoqVA8fg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 18:52:40 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 07E89109A30; Tue, 22 Nov 2022 02:52:38 +0300 (+03)
Date:   Tue, 22 Nov 2022 02:52:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Message-ID: <20221121235237.ebvkgxe3zm47wp6v@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 12:38:36PM -0800, Dave Hansen wrote:
> On 11/21/22 11:51, Dexuan Cui wrote:
> > __tdx_hypercall() doesn't work for a TDX guest running on Hyper-V,
> > because Hyper-V uses a different calling convention, so add the
> > new function __tdx_ms_hv_hypercall().
> 
> Other than R10 being variable here and fixed for __tdx_hypercall(), this
> looks *EXACTLY* the same as __tdx_hypercall(), or at least a strict
> subset of what __tdx_hypercall() can do.
> 
> Did I miss something?
> 
> Another way of saying this:  It seems like you could do this with a new
> version of _tdx_hypercall() (and all in C) instead of a new
> __tdx_hypercall().

+1. There should be a strong reason to add another asm helper.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
