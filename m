Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175F62DDB5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiKQOPk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 09:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiKQOPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 09:15:35 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D55D63E5;
        Thu, 17 Nov 2022 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fwfXj9i+0drfeAtV3x/BJbMGowEj2984Cc/3ytwqZcU=; b=KZVC5rscvSiJsyoZlBXxoTQtTB
        5ldi2h+HYWjRL1mnMiZtA39wkJdfvf9ezxl3yKLMMVJnDkoG0btc/6h8cUs10tELVVdgxp5/HP13k
        lty5MCtWPNWA8yVbzaNK6Erpks/hJfDwdkagDaJH/50gefiKH4OuJqQa6sDhi9BEH4UdUyg+A3+MY
        t7N0sM4tE4/X/wG+mH2DUnF2cx/E7okVhFaHzmFdOvVSLBse+ad6x6xJ961SiYWD48vNi9CK8tkez
        BbI5DPiuGl29Y6FLhXH2dm9j2fl2pRZ+1vWOXmtVTvQmF7Ct0tc/aZjtkquIQ2GdhQIa3vVlqCjuU
        EABT5AzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovffP-001hFW-Uz; Thu, 17 Nov 2022 14:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73C33300454;
        Thu, 17 Nov 2022 15:14:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B4D0207D6246; Thu, 17 Nov 2022 15:14:58 +0100 (CET)
Date:   Thu, 17 Nov 2022 15:14:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Schimpe, Christina" <christina.schimpe@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Message-ID: <Y3ZB4iJew2Fkh4R3@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-36-rick.p.edgecombe@intel.com>
 <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
 <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
 <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 17, 2022 at 12:25:16PM +0000, Schimpe, Christina wrote:
> > + Christina
> > 
> > On Tue, 2022-11-15 at 15:43 +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 04, 2022 at 03:36:02PM -0700, Rick Edgecombe wrote:
> > > > From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > >
> > > > Some applications (like GDB and CRIU) would like to tweak CET state
> > > > via ptrace. This allows for existing functionality to continue to
> > > > work for seized CET applications. Provide an interface based on the
> > > > xsave buffer format of CET, but filter unneeded states to make the
> > > > kernel’s job easier.
> > > >
> > > > There is already ptrace functionality for accessing xstate, but this
> > > > does not include supervisor xfeatures. So there is not a completely
> > > > clear place for where to put the CET state. Adding it to the user
> > > > xfeatures regset would complicate that code, as it currently shares
> > > > logic with signals which should not have supervisor features.
> > > >
> > > > Don’t add a general supervisor xfeature regset like the user one,
> > > > because it is better to maintain flexibility for other supervisor
> > > > xfeatures to define their own interface. For example, an xfeature
> > > > may decide not to expose all of it’s state to userspace. A lot of
> > > > enum values remain to be used, so just put it in dedicated CET
> > > > regset.
> > > >
> > > > The only downside to not having a generic supervisor xfeature
> > > > regset, is that apps need to be enlightened of any new supervisor
> > > > xfeature exposed this way (i.e. they can’t try to have generic
> > > > save/restore logic). But maybe that is a good thing, because they
> > > > have to think through each new xfeature instead of encountering
> > > > issues when new a new supervisor xfeature was added.
> > >
> > > Per this argument this should not use the CET XSAVE format and CET
> > > name at all, because that conflates the situation vs IBT. Enabling
> > > that might not want to follow this precedent.
> > 
> > Hmm, we definitely need to be able to set the SSP. Christina, does GDB need
> > anything else? I thought maybe toggling SHSTK_EN?
> 
> In addition to the SSP, we want to write the CET state. For instance for inferior calls,
> we want to reset the IBT bits.

This is about Shadow Stack -- IBT is a completely different feature and
not subject of this series.

Also, wth is an inferior call?
