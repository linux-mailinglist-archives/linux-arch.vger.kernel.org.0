Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF66338A3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 10:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiKVJhE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 04:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiKVJhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 04:37:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05A4A055;
        Tue, 22 Nov 2022 01:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDAD3615D7;
        Tue, 22 Nov 2022 09:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68428C433D6;
        Tue, 22 Nov 2022 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669109821;
        bh=7wpu88Q6B2Kkm7KKjQcA0/8wvOjYoaetfEppOc8/LrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBY2vKikg0x96nQXt+AZQCh4q2OfzV+uadi3H6VV6L3w+cJ59JhcNem7fCPrHkIcN
         E8JP1Y58itlhsaVm+Kq/CKnkSXLu263e4xIoFUlMaqKQh1/QO8RcbsGYjdjdtCwh0R
         5OFrI5sKkBOQlC3X9n+nBLpT9LNQyG71hf9Bp1/BmPP3k3BPyslhYlTvmeaqUQE5AN
         vG2RXMynurkwvAYVPn4hJwUPjELYfPXpxRSd14Ft6URqjU3hd+EN47CIIb5eWReXQk
         0oa2UIVkMOcTUKDXxQMCQstO/5rMhb28sqTUy6o643p6EdsyPkLGx+LDBMTuYjVlzo
         1vcd54Ioazxwg==
Date:   Tue, 22 Nov 2022 11:36:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Message-ID: <Y3yYJzz2o95fyMnf@kernel.org>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-36-rick.p.edgecombe@intel.com>
 <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
 <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
 <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
 <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
 <Y3srU89TAwMURoEj@kernel.org>
 <dcbf087fb8082be8ff9be14c440a0efaee95cf93.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbf087fb8082be8ff9be14c440a0efaee95cf93.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 21, 2022 at 03:52:57PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2022-11-21 at 09:40 +0200, Mike Rapoport wrote:
> > On Thu, Nov 17, 2022 at 07:57:59PM +0000, Edgecombe, Rick P wrote:
> > > On Thu, 2022-11-17 at 12:25 +0000, Schimpe, Christina wrote:
> > > > > Hmm, we definitely need to be able to set the SSP. Christina,
> > > > > does
> > > > > GDB need
> > > > > anything else? I thought maybe toggling SHSTK_EN?
> > > > 
> > > > In addition to the SSP, we want to write the CET state. For
> > > > instance
> > > > for inferior calls,
> > > > we want to reset the IBT bits.
> > > > However, we won't write states that are disallowed by HW.
> > > 
> > > Sorry, I should have given more background. Peter is saying we
> > > should
> > > split the ptrace interface so that shadow stack and IBT are
> > > separate. 
> > > They would also no longer necessarily mirror the CET_U MSR format.
> > > Instead the kernel would expose a kernel specific format that has
> > > the
> > > needed bits of shadow stack support. And a separate one later for
> > > IBT.
> > > 
> > > So the question is what does shadow stack need to support for
> > > ptrace
> > > besides SSP? Is it only SSP? The other features are SHSTK_EN and
> > > WRSS_EN. It might actually be nice to keep how these bits get
> > > flipped
> > > more controlled (remove them from ptrace). It looks like CRIU
> > > didn't
> > > need them.
> > 
> >  
> > CRIU reads CET_U with ptrace(PTRACE_GETREGSET, NT_X86_CET). It's done
> > before the injection of the parasite. The value of SHSTK_EN is used
> > then to
> > detect if shadow stack is enabled and to setup victim's shadow stack
> > for
> > sigreturn.
> 
> Hmm, can it read /proc/pid/status? It has some lines like this:
> x86_Thread_features: shstk wrss
> x86_Thread_features_locked: shstk wrss

It could, but that would be much more intrusive than GETREGSET because
currently /proc parsing and parasite injection don't really interact.
If anything, arch_prctl(ARCH_CET_GET) via ptrace would be much nicer than
/proc. 

-- 
Sincerely yours,
Mike.
