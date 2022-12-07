Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171DC645A20
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGMtn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLGMtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 07:49:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109892FA72;
        Wed,  7 Dec 2022 04:49:41 -0800 (PST)
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92DB91EC0683;
        Wed,  7 Dec 2022 13:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670417379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sbaj5o43ffgVtyPksCtVluOhwVf735Cxu4waTP4cQmQ=;
        b=rtwv536EWfGY4YZjI7jb2l7/4qP0s4vCoWkyUU3bDgbYYjiOHIIJ2S/x2h0N14kYjWHOxk
        BRUpXe3Z7Zw0qypSE8lU8IUC3wfcvXirkeAEzkOnBi9AKVnqY8RPD4Gnu/HsN+qXZETm+C
        baLuSFoBSDnB5+9oTn08Cs96TM+t1EQ=
Date:   Wed, 7 Dec 2022 13:49:39 +0100
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
Subject: Re: [PATCH v4 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <Y5CL4ySPtcTLVrrM@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:31PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Setting CR4.CET is a prerequisite for utilizing any CET features, most of
> which also require setting MSRs.

...

>  arch/x86/kernel/cpu/common.c | 37 ++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)

Looks better.

Let's get rid of the ifdeffery and simplify it even more. Diff ontop:

---

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 579f10222432..c364f3067121 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -597,12 +597,14 @@ __noendbr void ibt_restore(u64 save)
 
 #endif
 
-#ifdef CONFIG_X86_CET
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
-	bool user_shstk;
-	u64 msr = 0;
+	bool kernel_ibt, user_shstk;
+
+	if (!IS_ENABLED(CONFIG_X86_CET))
+		return;
+
+	kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
 
 	/*
 	 * Enable user shadow stack only if the Linux defined user shadow stack
@@ -618,21 +620,18 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
 
 	if (kernel_ibt)
-		msr = CET_ENDBR_EN;
+		wrmsrl(MSR_IA32_S_CET, CET_ENDBR_EN);
+	else
+		wrmsrl(MSR_IA32_S_CET, 0);
 
-	wrmsrl(MSR_IA32_S_CET, msr);
 	cr4_set_bits(X86_CR4_CET);
 
 	if (kernel_ibt && !ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		return;
 	}
 }
-#else /* CONFIG_X86_CET */
-static inline void setup_cet(struct cpuinfo_x86 *c) {}
-#endif
 
 __noendbr void cet_disable(void)
 {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
