Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5D5F533B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 13:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJELQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJELQ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 07:16:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF65815A;
        Wed,  5 Oct 2022 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jlNnOtdLgWp1J9aNwcNLhyUtm43E+rBcw5a9tZw4tKM=; b=jdvZQ1JWuioxO53YHfWyMIlwPO
        Crt4VyrM4DpQFGABM8ihqD6uCQ9lOmSnu6Vzh+FyURgi5JSApO0rWofMPZ+QiSuRPokJO+4lnLKKP
        w8oQ7pEDQ3kdIKkejORmZWIrpJAc5JfP6O+8uv9Dg0MZkd7ho74b7BbZ5ARN9R6EJenYFcapm2xiL
        yat+sxLvMINMLBWuQ7ATpDiS4Z1Kre/qrjly7jJFwPhZhXqksjDWGdEeOoOMcTKlt8HhLvBvmKcCs
        UC/aAdY8qrxzNlH1LwDNgOtOyOhiMQtjSaPc5HaBMx3+o46qEqgApTLVJs0DRLs/4h7TgkyMODVSv
        aGglGIUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1og2Nl-000JVi-9O; Wed, 05 Oct 2022 11:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ED00300205;
        Wed,  5 Oct 2022 13:16:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 778D620C48C87; Wed,  5 Oct 2022 13:16:03 +0200 (CEST)
Date:   Wed, 5 Oct 2022 13:16:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <Yz1ncw+up1nRb9Eo@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-9-rick.p.edgecombe@intel.com>
 <8d58f57f-cece-c197-2a8b-dd02b4e405bc@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d58f57f-cece-c197-2a8b-dd02b4e405bc@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 05, 2022 at 01:31:28AM +0000, Andrew Cooper wrote:
> On 29/09/2022 23:29, Rick Edgecombe wrote:
> > From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> >
> > Processors sometimes directly create Write=0,Dirty=1 PTEs.
> 
> Do they? (Rhetorical)
> 
> Yes, this is a relevant anecdote for why CET isn't available on pre-TGL
> parts, but it one of the more wrong things to have as the first sentence
> of this commit message.
> 
> The point you want to express is that under the CET-SS spec, R/O+Dirty
> has a new meaning as type=shstk, so stop using this bit combination for
> existing mappings.
> 
> I'm not even sure it's relevant to note that CET capable processors can
> set D on a R/O mapping, because that depends on !CR0.WP which in turn
> prohibits CR4.CET being enabled.

Whilst I agree that the Changelog is 'suboptimal' -- I do think it might
be good to mention how we ended up at the current state where we
explicitly set this non-sensical W=0,D=1 state.

Looking at the git history this seems to be a bit of a hysterical
accident, not something done on purpose to 'optimize' for these weird
CPUs.
