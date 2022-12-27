Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6F656B55
	for <lists+linux-arch@lfdr.de>; Tue, 27 Dec 2022 14:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiL0N07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 08:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiL0N0h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 08:26:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CA77657;
        Tue, 27 Dec 2022 05:26:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A2FE1EC0662;
        Tue, 27 Dec 2022 14:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672147595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2imUoMui1724dAGSPFR9b+ZOTCSq0FVhRuTrmE4wohM=;
        b=ayWrv+PAgEhPD7nCG1JRpZ8rTirCBHp49hpCOP0uc67nnPJpoQhKjpAsuInX2LO5les70s
        NVGmDTkdtc/E4b6FON8pSbk/qlYjDrIM2VsBfuTCI1Fc57sa/znpXZhTI6H5Q1ZAJnVEZt
        1hvRyJRtaggSDl2/NjbOrr7FKnswlIE=
Date:   Tue, 27 Dec 2022 14:26:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
Message-ID: <Y6ryhvE3ev485oYC@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-13-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just textual improvements:

On Fri, Dec 02, 2022 at 04:35:39PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When Shadow Stack is in use, Write=0,Dirty=1 PTE are reserved for shadow

Pls, no caps.

> stack. Copy-on-write PTes then have Write=0,Cow=1.

"... are preserved for shadow stack pages."

> 
> When a PTE goes from Write=1,Dirty=1 to Write=0,Cow=1, it could
> become a transient shadow stack PTE in two cases:

1. Some processors ...

2. When _PAGE_DIRTY ...

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

"... also gets disabled ..."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
