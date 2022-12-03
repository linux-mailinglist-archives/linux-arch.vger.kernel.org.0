Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A146964136C
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiLCCcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiLCCc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:32:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113EE368A
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:32:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so6695777pjg.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Ihv9qw1XxpYrbScjLffw/alIz8VtCrsDRCV2Vt/fA=;
        b=QXSoEg7SQKzpsbJ82DpCGUnwNJ0uFOfcySMzR7iXW98rnwNi8Lz2pFXPYWaLIwp3d9
         Vnd7yKJVO8auIjJoI1uliImiekq1h5lMqHMZVGukoSmzMsUjdG3zvIMqHNFqn6HtH8Ru
         nmMWN8u7hH4Q9kx+WC26+Tao4MmSqrxNlGKjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9Ihv9qw1XxpYrbScjLffw/alIz8VtCrsDRCV2Vt/fA=;
        b=NSqAB5bwr6ggxkBekaxRXSyqkLlu0/qmVco7gpbfDfbt/GW2zHT8a4DbGMiIYYCow4
         YxCb9+1c9p8UYhiPri/ZM/xMqLpWn9N//gTr/ckvHNZRyWPG/ldX3hJ4anv9hCoNgfjK
         JpAJQeIlWhY5Yt37AEBd317VZuqGCd13pRtd7YkOhKds5menqfRDVxKSk3SfaIg+lHbU
         6hs85SeX98dl8NDFMBKqcW0XPbA/U5zPQFT5UwwHuFHu1GUzY0mkWPIPUScgeG7YKpWl
         lRLoEIj+IfDV1GEevKO+Wfqdc07Pbl0C5GiGiMdaaACG36eY/CAc2Moss1C4fTdULN1a
         jePA==
X-Gm-Message-State: ANoB5plNySul9g4ln3Uwo1YqjCQF5qOe8bDRFPh1HPtjcEi9UNhibb5l
        +DCP/e/4/znLR8j+ZCl8J36lbg==
X-Google-Smtp-Source: AA0mqf7D8WXWZwGQab9G9ZWzQhwxxRNvvsY+VtafM+07J8d7KYaCB+Gh37BgeTMnrFp8WF2UfijGAg==
X-Received: by 2002:a17:90b:609:b0:219:3ad9:64f5 with SMTP id gb9-20020a17090b060900b002193ad964f5mr29067100pjb.138.1670034747610;
        Fri, 02 Dec 2022 18:32:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y187-20020a6264c4000000b0056ee49d6e95sm5715665pfb.86.2022.12.02.18.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:32:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:32:26 -0800
From:   Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <202212021832.3793DA082C@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-13-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:39PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When Shadow Stack is in use, Write=0,Dirty=1 PTE are reserved for shadow
> stack. Copy-on-write PTes then have Write=0,Cow=1.
> 
> When a PTE goes from Write=1,Dirty=1 to Write=0,Cow=1, it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a Write=0 PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE. However, this will not occur on processors supporting
> Shadow Stack, and a TLB flush is not necessary.
> 
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.
> 
> In the case of pmdp_set_wrprotect(), for nopmd configs the ->pmd operated
> on does not exist and the logic would need to be different. Although the
> extra functionality will normally be optimized out when user shadow
> stacks are not configured, also exclude it in the preprocessor stage so
> that it will still compile. User shadow stack is not supported there by
> Linux anyway. Leave the cpu_feature_enabled() check so that the
> functionality also disables based on runtime detection of the feature.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue. Jann Horn provided the cmpxchg solution.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
