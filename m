Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC162DDC5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 15:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiKQOSj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 09:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiKQOSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 09:18:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0407617D;
        Thu, 17 Nov 2022 06:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LF9qnU9ueFzG/Bylc7E69vWwnL1I+GU41GAT4rdB6kA=; b=nIXpURg+Y8f25kudoCA5olsfHz
        /EltvxuuE17XMktIvYP8zRCyJMQ454nHHssGgB9fBxgz9pC/AOB/0PX2dVi5rGivxesVgsNqjZ+8P
        RLqtXObfkKAly5eeVWGMbsineXGePk3E8JuBFPh5rl2BjLZA7lVezFemk0JkY5grwVSknNRxe2ULT
        XJtC4ToTtg3nKJ/SzwQj+12JBEa3B9sV8LSW0Aad1T0ZO0lHXJgi9L8UBP8U3qIRpA1JhVoZyHHig
        t3RkBPvHEmZvWiP1C2WJkl5kijRDdsq8bAWyFmtaYhm0V02dY++1D3qN7ycAZ7nLwpBZDN3Ha3Yj3
        ZA/nUKQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovfi8-0015ca-Mx; Thu, 17 Nov 2022 14:17:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0FFE300220;
        Thu, 17 Nov 2022 15:17:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D92D02C12E288; Thu, 17 Nov 2022 15:17:40 +0100 (CET)
Date:   Thu, 17 Nov 2022 15:17:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Message-ID: <Y3ZChDNwybrNKFX2@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-28-rick.p.edgecombe@intel.com>
 <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
 <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
 <Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net>
 <cb4c70dd57f43fd46a47e0bf7d3c759b0b313f83.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4c70dd57f43fd46a47e0bf7d3c759b0b313f83.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 16, 2022 at 10:38:19PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2022-11-16 at 11:18 +0100, Peter Zijlstra wrote:
> > > > 
> > > > Should you write a 64bit value even if the task receiving a
> > > > signal is
> > > > 32bit ?
> > > 
> > > 32 bit support was also dropped.
> > 
> > How? Task could start life as 64bit, frob LDT to set up 32bit code
> > segment and jump into it and start doing 32bit syscalls, then what?
> > 
> > AFAICT those 32bit syscalls will end up doing SA_IA32_ABI sigframes.
> 
> Hmm, good point. This series used to support normal 32 bit apps via
> ia32 emulation which would have handled this. But I removed it (blocked
> in the enabling logic) because it didn't seem like it would get enough
> use to justify the extra code. That doesn't block this scenario here
> though.
> 
> Pardon the possibly naive question, but is this 32/64 bit mixing
> something any normal, shstk-desiring, applications would actually do? O
> r more that they could do?

It is not something common, but it is something that things like Wine
do IIRC, and it would be a real shame if Wine could not use shadow
stacks or something, right ;-)

But more to the point; since the kernel cannot forbit this scenario
(aside from taking away the LDT entirely) it is something that needs
handling.
