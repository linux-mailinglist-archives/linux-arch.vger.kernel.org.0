Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1E692051
	for <lists+linux-arch@lfdr.de>; Fri, 10 Feb 2023 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBJN5X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 08:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjBJN5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 08:57:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87475AB07;
        Fri, 10 Feb 2023 05:57:09 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17A0E1EC0745;
        Fri, 10 Feb 2023 14:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676037428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6j9AGvbK6QZWswMMubEra1MMawrAyneStMphrQrJwmw=;
        b=O4uH+MLv7Ria1BC4GVqbfWA4aby5n4GH2XEDD5iM4lZ7HO0vP4Q3rJEaUQl8i3CUuiSh+8
        6SCz9zFm3WgmTyaPZc1ZXwfHK/2vVZaklhrkdPJzRWJi6uaMFjrZs0psEHPsFX+e5vjN3m
        /KqBzgzV3KubqqXyj0vPv7Q8Y05f240=
Date:   Fri, 10 Feb 2023 14:57:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <Y+ZNL4o57lCrmwpb@zn.tnic>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-12-rick.p.edgecombe@intel.com>
 <Y+T+ZxydCZS1Yjmz@zn.tnic>
 <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 09, 2023 at 05:09:15PM +0000, Edgecombe, Rick P wrote:
> What do you think, can we leave it or give it a new name? Maybe
> pte_set_dirty() to be more like the x86-only pte_set_flags() family of
> functions?

I'd do this (ontop of yours, not built, not tested, etc). It is short
and sweet:

pte_mkdirty() set both dirty flags
pte_modifl() sets only _PAGE_DIRTY

No special helpers to lookup what they do, no nothing. Plain and simple.

---
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7942eff2af50..8ba37380966c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -392,19 +392,10 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_NX);
 }
 
-static inline pte_t __pte_mkdirty(pte_t pte, bool soft)
-{
-	pteval_t dirty = _PAGE_DIRTY;
-
-	if (soft)
-		dirty |= _PAGE_SOFT_DIRTY;
-
-	return pte_set_flags(pte, dirty);
-}
-
+/* Set _PAGE_SOFT_DIRTY for shadow stack pages. */
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return __pte_mkdirty(pte, true);
+	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
@@ -749,14 +740,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 	pte_result = __pte(val);
 
-	/*
-	 * Dirty bit is not preserved above so it can be done
-	 * in a special way for the shadow stack case, where it
-	 * may need to set _PAGE_COW. __pte_mkdirty() will do this in
-	 * the case of shadow stack.
-	 */
 	if (pte_dirty(pte))
-		pte_result = __pte_mkdirty(pte_result, false);
+		pte_result = pte_set_flags(pte_result, _PAGE_DIRTY);
 
 	return pte_result;
 }



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
