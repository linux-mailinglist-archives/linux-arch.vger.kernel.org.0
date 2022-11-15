Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1462A2B9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKOUX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKOUX4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:23:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139EB6577;
        Tue, 15 Nov 2022 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jLh684q0i2DlF59Q/LASmUdX+Kz5SV+3+RI44Jc9oA=; b=kJneZR+NyIAxbgBEKbrWlVj82S
        Q6Eddm+m0GcyshkgQ9O8fN+1r8e7QfNfeQh40dlLXeO42XuWL8VOJ5gPzAfVnrAdOdpeMejD3S07X
        6jBqE4qXBwUpUP5g6lVDO+9zskKa7tr5kYfW3fojSmutF9zf8IqeHIsY7Dgpyh0uc5kFClDGJ+pvw
        1GRgj+ueQ+/2BpdhLMMx9QV/pCJRin4bEEXvkVDpGXNG9q3AM+Xu/qss7ZcnAlQVxJ2o1Fkq0YaPa
        maxzBV6QK0he2I0k2+jdtNhVDqLfVTTKpzFfuEaNVxg8NYSdeaomAF0gKTCGFH72n5Fr+ngBv3ud+
        ZSmEP6rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov2T0-00GbpW-Uq; Tue, 15 Nov 2022 20:23:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A63A301BE3;
        Tue, 15 Nov 2022 15:25:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AB7A2015BE8A; Tue, 15 Nov 2022 15:25:47 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:25:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Message-ID: <Y3Oha6lAIlwypktM@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-25-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-25-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:51PM -0700, Rick Edgecombe wrote:

>  arch/x86/include/asm/cet.h        | 21 +++++++++++++++
>  arch/x86/kernel/shstk.c           | 44 +++++++++++++++++++++++++++++++

You see what's going wrong there? Eradicate the CET...
