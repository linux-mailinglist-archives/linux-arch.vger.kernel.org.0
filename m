Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67562A1FC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 20:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKOTe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKOTeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 14:34:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF36A198;
        Tue, 15 Nov 2022 11:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QR6n+vA00Dlok+NeJO2qYZC04d5g39W8pXVCw+YOkug=; b=hj+ppKnTzlA4/rLNRkRsmj84g4
        rBmfHU+K7gBrv/4esPsOcYckFekm8hkTs4ZHZM5NpqAjEn7RIrg49OmU+LB0LIfcA4AucT0Ou+ii1
        nMMQz4/w4wOPgdPsEltcsGtDqThJ34kPGFUn1EO2uDNFND4UNrbKICVVFFBRLCfOKGYnHZi89GvNY
        opHKCutTO9hp/95pRKWMvcWwPSezcDL9qCKql1mT1tJvX6T+VR9xdZq4nyHQycQVBfhaIRlu70MFr
        qu7zWNcyr+Ocl8GMz+ZTB+68H4O/9FThRnNV9m5GMT7zMbJrUb4nD29HrmtGT2YqfHWRNVXCaRwpZ
        K83+u31A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1gX-0015JT-1w; Tue, 15 Nov 2022 19:33:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 904E0300422;
        Tue, 15 Nov 2022 13:26:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76E4D2C368970; Tue, 15 Nov 2022 13:26:23 +0100 (CET)
Date:   Tue, 15 Nov 2022 13:26:23 +0100
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
Message-ID: <Y3OFb1035Ef+4oLj@hirez.programming.kicks-ass.net>
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
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add three new arch_prctl() handles:
> 
>  - ARCH_CET_ENABLE/DISABLE enables or disables the specified
>    feature. Returns 0 on success or an error.
> 
>  - ARCH_CET_LOCK prevents future disabling or enabling of the
>    specified feature. Returns 0 on success or an error
> 
> The features are handled per-thread and inherited over fork(2)/clone(2),
> but reset on exec().
> 
> This is preparation patch. It does not implement any features.

Urgh... so much for sharing with other architectures I suppose :/

The ARM64 BTI thing is very similar to IBT (except I think their
approach to the legacy bitmap is much saner).

Given that IBT isn't supported and needs the whole legacy bitmap mess,
do we really want to call this CET ? Why not just make a Shadow Stack
API and tackle IBT independently.
