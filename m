Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71044387181
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 07:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhERF5g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 01:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbhERF5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 01:57:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44873C061573;
        Mon, 17 May 2021 22:56:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ae2005a49629880ac02d2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e200:5a49:6298:80ac:2d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A18381EC04BF;
        Tue, 18 May 2021 07:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621317374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CoUZNshFKwxzJxvmNesTEWJlLKO0exgHkOr0ngGYwGI=;
        b=W6eJZYjN6OnGJsyDztzN/sdVdUAbQx1dIeHKqupFUaPUwJGH0Cv+k6IWqpHcsdMOFLs4Om
        2yzHcQIIT7BswXG35L+1FYQ2Q3QHSgvXmQrXO2fond/n0k1FEGWEXFfiA7QWi3O/ZYUVj+
        fZFj44LzauzVdhV4ExYc6fy4mBxiFRs=
Date:   Tue, 18 May 2021 07:56:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <YKNW+eiosSVDCTsA@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com>
 <YKIfIEyW+sR+bDCk@zn.tnic>
 <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 01:55:01PM -0700, Yu, Yu-cheng wrote:
> If 32-bit apps are not supported, there should be no need of 32-bit shadow
> stack write, otherwise there is a bug.

Aha, just a precaution. Then you can reduce the ifdeffery a bit (ontop
of yours):

---
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f962da1fe9b5..5b48c91fa8d4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -235,9 +235,14 @@ static inline void clwb(volatile void *__p)
 }
 
 #ifdef CONFIG_X86_SHADOW_STACK
-#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
 static inline int write_user_shstk_32(u32 __user *addr, u32 val)
 {
+	if (WARN_ONCE(!IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		      !IS_ENABLED(CONFIG_X86_X32),
+		      "%s used but not supported.\n", __func__)) {
+		return -EFAULT;
+	}
+
 	asm_volatile_goto("1: wrussd %[val], (%[addr])\n"
 			  _ASM_EXTABLE(1b, %l[fail])
 			  :: [addr] "r" (addr), [val] "r" (val)
@@ -246,13 +251,6 @@ static inline int write_user_shstk_32(u32 __user *addr, u32 val)
 fail:
 	return -EFAULT;
 }
-#else
-static inline int write_user_shstk_32(u32 __user *addr, u32 val)
-{
-	WARN_ONCE(1, "%s used but not supported.\n", __func__);
-	return -EFAULT;
-}
-#endif
 
 static inline int write_user_shstk_64(u64 __user *addr, u64 val)
 {

> These are static functions.  I thought that would make the static scope
> clear.  I can remove "_".

No, "_" or "__" prefixed functions are generally supposed to denote
internal interfaces which should not be used by other kernel facilities.
In that case you have the external api <function_name> and the lower
level helpers _<function_name>, __<function_name>, etc. They can be
static but not necessarily.

This is not the case here so you can simply drop the "_" prefixes.

> If the busy bit is set, it is only for SAVEPREVSSP, and invalid as a
> normal restore token.

Sure but the busy bit is independent from the mode.

> With the lower two bits masked out, the restore token must point
> directly above itself.

That I know - I'm just questioning the design. It should be

	addr = ALIGN_DOWN(ssp, 8);

Plain and simple.

Not this silly pushing and popping of stuff. But it is too late now
anyway and it's not like hw people talk to software people who get to
implement their shit.

> Ok, then, we don't use #define's. I will put in comments about what it
> is doing, and fix the rest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
