Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D85636237
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiKWOrT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 09:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiKWOrS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 09:47:18 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DED5800F;
        Wed, 23 Nov 2022 06:47:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DE8845C017F;
        Wed, 23 Nov 2022 09:47:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 23 Nov 2022 09:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669214836; x=1669301236; bh=dk
        lom4LU7h4zmmCS6kdcNAX+zdQlMXjZUyObz2F6gPk=; b=Xawxb54qJvyp523rXJ
        Q829SsykOAL96QKi8ei5UXKubHm6dQgTgH327/QPDT/4GgDk6r0WiLRo3v/nuoNt
        IrLBR/Hx5rFkS5isaocs3X1DuAzftGsHmP6SmdCRGIVu3cuAub+GQCrkoOjeTEuj
        y8noLcLchKZLakCks9XLdeJQZz2RIJ6P9R8piM2UfZfK1v6UWt0x0gfp1Qe9ivIG
        +F/cl5gn8Aej9Z2TrvnQFK0i1B0aTKuE069mOGiNeTuzs8NzGUlnBD62zPy3d5xQ
        j/GutrBz1zcxoMwQ0rQW4GdFDp0cfSluNooXlfCbxQc5qUVwfhmryJRZTThpkiz1
        sCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669214836; x=1669301236; bh=dklom4LU7h4zmmCS6kdcNAX+zdQl
        MXjZUyObz2F6gPk=; b=MYi1zg+v0DiAScLMO1+MGIGV9+huuKFzbTAq8cGDqxho
        w1pmg1/mLs6lJsHSWVV/RxXtUsA67QsH1TBZcmzys2R+9MQ83LUInV33+VtEmLf9
        g4ErUPlZAYuLWuI0aBj6dxC9AuPNo+mNRfPQneSVw+58dhaRL2D6yAgoAIHY/xkg
        9OvOOy2oizlPskwYLg1/HsFEkpeFMq2GMd6SWEScvjGVFxlRFhQZxVb+sIqohOhH
        XDGocQO6azo51c6AcgUodKfsE2wbLAWHimmj0MlCOUtlkFEOWU6QhVSTq9L9G7lb
        WC+PU2VNNUF+EGO60DKkm5829pT6eTeXKP7bNkNz/g==
X-ME-Sender: <xms:dDJ-Y86lWReASnhfdEHjmHd__J8gL7rzL55cy22cdIoSX2ClX8uQbg>
    <xme:dDJ-Y97IAEKcIdQDSp_r3ICUU44YDDc4Thmgd3y-lHrehYMhNAVCoS9vz4Z0hzczs
    sA2L1-IBTPnNjw2bW0>
X-ME-Received: <xmr:dDJ-Y7dS1Xbi3Z2cmbKEvwW4KSLN4k3S6e2QhLU4ETOz79Y-yMHtr5V1eNHabstwSAo5iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:dDJ-YxIOvHhftdTDhPEo3ysgYrIHKVv9MyXG7Kmcjgn1K_Vbsoz-gw>
    <xmx:dDJ-YwLukS21UfA3K8kvTXvVxYxeLc5vPwONpAZacz4lgEJx67fgkQ>
    <xmx:dDJ-Yyy_timEfBU4CEcY2vzg4RUZ-z9ennuNv0tC5Ecp3-kmYm6FJg>
    <xmx:dDJ-Y17cRs34nVmBf0PA-MLbhHKeob1ckmTRx8y3pLjnh6GtgoYddQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 09:47:16 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9E9B9109687; Wed, 23 Nov 2022 17:47:14 +0300 (+03)
Date:   Wed, 23 Nov 2022 17:47:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
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
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Message-ID: <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
 <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 23, 2022 at 02:14:58AM +0000, Dexuan Cui wrote:
> > From: Dave Hansen <dave.hansen@intel.com>
> > Sent: Monday, November 21, 2022 12:05 PM
> > [...]
> > >  #ifdef CONFIG_X86_64
> > > +#if CONFIG_INTEL_TDX_GUEST
> > > +	if (hv_isolation_type_tdx()) {
> > 
> > >  #ifdef CONFIG_X86_64
> > > +#if CONFIG_INTEL_TDX_GUEST
> > > +	if (hv_isolation_type_tdx())
> > 
> > >  #ifdef CONFIG_X86_64
> > > +#if CONFIG_INTEL_TDX_GUEST
> > > +	if (hv_isolation_type_tdx())
> > > +		return __tdx_ms_hv_hypercall(control, input2, input1);
> > 
> > See any common patterns there?
> > 
> > The "no #ifdef's in C files" rule would be good to apply here.  Please
> > do one #ifdef in a header.
> 
> Sorry, I should use #ifdef rather than #if. I'll fix it like the below.

No, can we hide preprocessor hell inside hv_isolation_type_tdx()?

Like make it return false for !CONFIG_INTEL_TDX_GUEST and avoid all
#if/#ifdefs in C file.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
