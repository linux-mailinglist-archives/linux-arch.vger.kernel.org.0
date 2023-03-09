Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DCB6B2672
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCIOOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCIONz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 09:13:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550531ADCF;
        Thu,  9 Mar 2023 06:12:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBDBE1EC06C0;
        Thu,  9 Mar 2023 15:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678371153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w2fyPKd/3AyQO0vRIYAONySJuiNLLI9cVCZnriSsS1Y=;
        b=daTlHMXWbU7km2++Pqh1oYE/nsYUwrFU5fXZAkkWykVSRndcnEPsQVIjbBxgSOZO1YC0BR
        6UsZoKQ7vh+Hyd4HmhRuLraKwnWiCZMKlmf1iY9ezyPRnbOPeO9bzBsWJ/F8t4tRgCvm4g
        Ol1SfaLsjAlGQdngAX8UoQnSwNF0pb4=
Date:   Thu, 9 Mar 2023 15:12:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Message-ID: <ZAnpTYV55gbdROxx@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-31-rick.p.edgecombe@intel.com>
 <ZAipCNBCtPA2bcck@zn.tnic>
 <d4d472e2e44787eccfbcc693bdf338370013f8a9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4d472e2e44787eccfbcc693bdf338370013f8a9.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 08, 2023 at 08:03:17PM +0000, Edgecombe, Rick P wrote:

Btw,

pls try to trim your replies as I need ot scroll through pages of quoted
text to find the response.

> Sure. Sometimes people tell me to only ifdef out whole functions to
> make it easier to read. I suppose in this case it's not hard to see.

Yeah, the less ifdeffery we have, the better.

> If the default SSP value logic is too hidden, what about some clearer
> code and comments, like this?

The problem with this function is that it needs to return three things:

* success:
 ** 0
 or
 ** shadow stack address
* failure: due to allocation.

How about this below instead? (totally untested ofc):

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index bf703f53fa49..6e323d4e32fc 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -142,7 +142,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
-	unsigned long shstk_addr = 0;
+	unsigned long shstk_addr;
 	int ret = 0;
 
 	childregs = task_pt_regs(p);
@@ -178,10 +178,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 #endif
 
 	/* Allocate a new shadow stack for pthread if needed */
-	ret = shstk_alloc_thread_stack(p, clone_flags, args->stack_size,
-				       &shstk_addr);
-	if (ret)
-		return ret;
+	shstk_addr = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+	if (IS_ERR_VALUE(shstk_addr))
+		return PTR_ERR((void *)shstk_addr);
 
 	fpu_clone(p, clone_flags, args->fn, shstk_addr);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 13c02747386f..b1668b499e9a 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -157,8 +157,8 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-			     unsigned long stack_size, unsigned long *shstk_addr)
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+				       unsigned long stack_size)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
 	unsigned long addr, size;
@@ -180,14 +180,12 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 	size = adjust_shstk_size(stack_size);
 	addr = alloc_shstk(size);
 	if (IS_ERR_VALUE(addr))
-		return PTR_ERR((void *)addr);
+		return addr;
 
 	shstk->base = addr;
 	shstk->size = size;
 
-	*shstk_addr = addr + size;
-
-	return 0;
+	return addr + size;
 }
 
 static unsigned long get_user_shstk_addr(void)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
