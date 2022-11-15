Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FD62A3B9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKOVI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 16:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKOVI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 16:08:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAD12D3D;
        Tue, 15 Nov 2022 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6xS2jzo+Wah9lxr2NfS/UZ9644G1gA/sqmdSnvREVHs=; b=EiNB1tnkdXXLjgnA4O8/EMHqKc
        9FCIhHO3JxuJspTSZrpN1+LzvlyOODa+K933+ciiSUA4mJC1+5eYBU2xCXXes8hAOkFyfDz6CRYhp
        TClH0deL8UGOrL+njUyaiNfk3BlssJl6eBGe1h51BxVX8wfh/Tv+pXZxTEO9RgTEXOA9uarn6RjTW
        zLWEXyu+kMlx1Vm/QVoKE+pTMV6EkElmvUv66cSQKdnEXe+PgYc9FS9tNKJYh998x4OsLFeVQ5BR6
        9FGjI0hI8JaKo486HpH9TFSI008U7pxXNIJwJWZ+Vz5qTAitgmZWdGNbp7SktYl0ZtQlnZXLPpM/D
        9bJffGTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov39w-0016bM-2x; Tue, 15 Nov 2022 21:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C26653001FD;
        Tue, 15 Nov 2022 22:07:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7F06201646D4; Tue, 15 Nov 2022 22:07:54 +0100 (CET)
Date:   Tue, 15 Nov 2022 22:07:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
Subject: Re: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Message-ID: <Y3P/qltUOcCYsXoD@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-16-rick.p.edgecombe@intel.com>
 <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
 <b89565c96a0330c27ae179d96be05d2fc006121c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89565c96a0330c27ae179d96be05d2fc006121c.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 15, 2022 at 08:03:06PM +0000, Edgecombe, Rick P wrote:

> That's right. I think the assumption that needs to be broken in the
> readers head is that you can satisfy a read fault with read-only PTE.
> This is kind of baked in all over the place with the zero-pfn, COW,
> etc. Maybe I should try to start with that.

Maybe something like:

CoW -- pte_wrprotect() -- changes a SS page 'Write=0,Dirty=1' to
'Write=0,Dirty=0,CoW=1' which is a 'regular' RO page. A SS read from RET
will #PF because it expects a SS page. Make sure to break the CoW so it
can be restored to an SS page, as such force the write path and tickle
pte_mkwrite().
