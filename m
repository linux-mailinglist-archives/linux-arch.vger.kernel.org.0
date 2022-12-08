Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECC1647897
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 23:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLHWIc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 17:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiLHWIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 17:08:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA4B1050;
        Thu,  8 Dec 2022 14:06:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F80D5C00C7;
        Thu,  8 Dec 2022 17:06:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Dec 2022 17:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670537203; x=1670623603; bh=9D
        fHTo0GC4PlZwrEkw31ByuDSYGHJwT7xoG/PgPL6pk=; b=H6vddsgHc7VHy1bBar
        C8oNkomXtE3xW6kcFD1MlJiUFdVasLaRkzX4fK0fysvwdlmwrHPnHEEXhP9qkZ2H
        ZpEGQMW5yoDn/e5fnJ5GDsI7Fb6U+dOlS8juDk/6kTqC4I+RCiM2t1a48mvzECm8
        B8ZwzAVZRS557nwV6py+oNGIsr+aXbZxF1FMkqVCN5jv8CeQ6sA12Ux2/lDbdqQm
        p1kKrfYQ9WoLJwGpHbTfhQJ/0Kl0zlgxHp5cCutV6h0EzadH3UGhc8AqYHvy/64v
        3PvGM6lVj3ugvQ523lX619iZPpo1sgt5RKrAW+toiAfvXQESaSvh6Ln4ffL/G114
        ZkvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670537203; x=1670623603; bh=9DfHTo0GC4PlZwrEkw31ByuDSYGH
        JwT7xoG/PgPL6pk=; b=HVZzdDMDN/Hqp2Z8Ow7oh5FxzvzJoCOL+Vf4zfqI8L24
        +Cqva1jNg2YA7W+5GOiFH4Ff60jnjavsIO5PL4xr7Fr/3C/Xc/nJDSIibX4m9SNy
        pIPiQKuBwMkdmROl5ujKFskU2hJQNe9VaITkwHsAhlAu8OlW4KtoSD9qnLz6vfy9
        T1JoD3h1j6N9CC/L7CdVcfZC9012/Hs3QX4DGc0Dv3mJg/82YaSVw+ngmh5RmnES
        J0DI4tdIleeY1CqxEGm2thHmgVEGOGHCKQbCfQxXpdJc12XNKI36UoHKXqFycjKa
        YFdIw7mOlG4bd5azs45ERB58/+khCAPll2UKOm7mEg==
X-ME-Sender: <xms:8l-SY6uKWAoYSN7Gl1cFraUeuA9qIv7pu1jajQRQDHt4MFU2c55zXA>
    <xme:8l-SY_fI4lufb51eKrfrV7gUaEwSTkQBZ5Y8a-4bvbdfpapWn2M_ENDBoLFPPFjQq
    CqPyHAc5-0xwleC5dk>
X-ME-Received: <xmr:8l-SY1zTMU27tV82k4PtivUK3WXptUOfUncua1BVm2eXih2EB0a1PpD8hM69jgY1JgVCbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhgfffueetheehveetfefhiefhueehvdfgjeeg
    tdejhefhvdeijeekvdekheejfeenucffohhmrghinhepthgutggrlhhlrdhssgenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:8l-SY1MSz4daK6XbnupE8-zYUAZq1k7qZYg5ldVo0hqZ6tX709qBUQ>
    <xmx:8l-SY68jafi3HDcoRRAH257R9wVs59UD81r6RFD5aA5f8ZN9LeyKtg>
    <xmx:8l-SY9UHDmOyylg6bzYf5E3NyGVGnwvEoOjiIkaSmSGx2RjRRUhjcw>
    <xmx:81-SY4OTsVbkI4Cv2zjoeOa7zBB4lVZBS28s49x91Aatpzj8qxEj-Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 17:06:41 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ECD4B109CB7; Fri,  9 Dec 2022 01:06:38 +0300 (+03)
Date:   Fri, 9 Dec 2022 01:06:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Message-ID: <20221208220638.2km3gibpn7wicbtb@box.shutemov.name>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-5-decui@microsoft.com>
 <e6a4aeeb-382f-18cc-64da-7730101282c6@linux.intel.com>
 <SA1PR21MB133568F9F4C70C9F6412BC49BF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB133568F9F4C70C9F6412BC49BF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 08, 2022 at 03:54:32PM +0000, Dexuan Cui wrote:
> > From: Sathyanarayanan Kuppuswamy
> > Sent: Wednesday, December 7, 2022 2:14 PM
> >  [...]
> > > --- a/arch/x86/coco/tdx/tdcall.S
> > > +++ b/arch/x86/coco/tdx/tdcall.S
> > > @@ -13,6 +13,12 @@
> > >  /*
> > >   * Bitmasks of exposed registers (with VMM).
> > >   */
> > > +#define TDX_RDX		BIT(2)
> > > +#define TDX_RBX		BIT(3)
> > > +#define TDX_RSI		BIT(6)
> > > +#define TDX_RDI		BIT(7)
> > > +#define TDX_R8		BIT(8)
> > > +#define TDX_R9		BIT(9)
> > >  #define TDX_R10		BIT(10)
> > >  #define TDX_R11		BIT(11)
> > >  #define TDX_R12		BIT(12)
> > > @@ -27,9 +33,9 @@
> > >   * details can be found in TDX GHCI specification, section
> > >   * titled "TDCALL [TDG.VP.VMCALL] leaf".
> > >   */
> > > -#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
> > > -					  TDX_R12 | TDX_R13 | \
> > > -					  TDX_R14 | TDX_R15 )
> > > +#define TDVMCALL_EXPOSE_REGS_MASK	\
> > > +	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
> > > +	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
> > >
> > 
> > You seem to have expanded the list to include all VMCALL supported
> > registers except RBP. Why not include it as well? That way, it will be
> > a complete support.
> 
> Hi Kirill, can you please share your thoughts?

I wrote the patch to handle redefined ReportFatalError() (the updated GHCI
comes soon). It doesn't need the RBP. And we run out of registers to stash
arguments into. Let's think about this when the first user of RBP comes up.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
