Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38A5F51F8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJEJrJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEJrI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 05:47:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD016B158;
        Wed,  5 Oct 2022 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ez8YlIIFOv1JcrTvLi176ZFPsOijgCCws1rJsbL1NQQ=; b=JdXR/MxGGX4PGx4m2OjRn4X6Po
        k8QQ0MTutqeLddcZYHIgdjqIu9wSUdXxHn+8RGQveN7mSyXGTreDfHd38Gw/lPegR2qw8mCHy4ZsL
        5pyF5a39L0ZJAT/P/sa7bC/ID+FrNRIxtlMrTbaSkYR590RYTPXvKsHAKvvzchWyma3uPY25SNlxn
        aYIOpFS7GLPObpJmlyHGJ/6iWVp+77owL6fwxhkp5OSnITTdngpp7r9fqNWLBuk8E+9MPIfCIUWUK
        Q8aNxs50K2rezmF5BicrZ9+vDQMClVyFyUndY7gXL30u1u0YnELjRLv4Ofk+7X/8pNYSUrcrYn9K/
        su9ecpZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1og0z9-000GTe-JB; Wed, 05 Oct 2022 09:46:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C917130007E;
        Wed,  5 Oct 2022 11:46:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFEC420C3B653; Wed,  5 Oct 2022 11:46:34 +0200 (CEST)
Date:   Wed, 5 Oct 2022 11:46:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Message-ID: <Yz1SepywKVcWzV0f@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me>
 <87v8p5f0mg.fsf@meer.lwn.net>
 <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
 <5832fa687e6da50697a7627d53453b728ed1b7b7.camel@intel.com>
 <Yz1KFj71T4Q4mFrg@hirez.programming.kicks-ass.net>
 <3f0417cf-a58d-a2bd-7a9a-1d4dabf89970@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0417cf-a58d-a2bd-7a9a-1d4dabf89970@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 05, 2022 at 04:25:39PM +0700, Bagas Sanjaya wrote:
> On 10/5/22 16:10, Peter Zijlstra wrote:
> > On Mon, Oct 03, 2022 at 04:56:10PM +0000, Edgecombe, Rick P wrote:
> >> Thanks. Unless anyone has any objections
> > 
> > Well, I'll object. I still feel rst should burn in hell. Plain text FTW.
> > 
> > 
> 
> .txt maybe?

We had that, but some idiots went and converted the lot to .rst :-(
