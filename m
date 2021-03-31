Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA53A35095A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhCaV2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhCaV1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC746C06174A
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v136so2371882qkb.9
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCxq1N1gA7TwxAMFKmL7hLg9EO4lnSukatZLoaD+FFE=;
        b=KeQedqCHSppeGUQMSB3qvddKepeNQHx1p1/VSfzMSylvv0LONVB89TrLW3prq8oZLd
         GBGSMaPvGJnxYeqpyXqf46YXoIA4BadxdCS+/OCujIT/cSSW4RH6HuseJGcAaYs/B2h0
         VPCq2Yot/QxDNIrN078Op8TpVyvUgNLnqtUsZWFs4jkRLeq3QIubrq+hsNm8jw0/sNbu
         x6ydT94rlxQyzBBmMXhSg1nR2cT5jJEpSyTDeTKaFhRS7JORrsdmSYdEe1cmftX7I5J0
         WBiVyhSq+sZPQBRPdqZ0g2ebTLAodY/JCdgVHrXBLyUi190r5xfaOS+yUqmC2AQgYhO3
         ejSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCxq1N1gA7TwxAMFKmL7hLg9EO4lnSukatZLoaD+FFE=;
        b=KHdvJhAwEo9LsscWxfe2FvvOIrE4GQ1eDDzvPOeaUXgGLnNDeCCsjJsUbRdAAdOOzS
         sPCluCcnnUDuffcbbOYpv3foOhjJ/D092pkVZsa51z8V/nCbBMntsVtTaKSsMCs0cWB5
         S9fSTdclw+GPnjyzqsz9GkvYI6bgrFrLiBsZXx3SZ/HcnmpCPFvfANYdxGTbZPiwEcKM
         CAKOq1V3pMb2Lvpy7VOqKs2HIJxCvN6zR7RlwvKZAiv5Nia9NOZfCEiKreGUeWf9Rjlf
         FcaSleXEPngcYHbpfESNvB5Ap8iywzzqw8tHHzlyzFjtpM6+iyMd4tDnH1QltE6JLejY
         gqAg==
X-Gm-Message-State: AOAM532eZDsKJ0L9zZyab9le7l6YhTkXMvI7J/5O6veAwftgVbIR1D/9
        k4mPwkOb5rVOi0Exs9hYX7qaUPGrp7TiMixwDmg=
X-Google-Smtp-Source: ABdhPJx7XX2KOGLVRiBBOLjdMcWGg8SbFNRL+HOjMTa79TjDOvRh955y/RHVoyp83P6xuYihqrO7IRPK/3G0aLsMx0w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:b04:: with SMTP id
 u4mr5243055qvj.0.1617226071830; Wed, 31 Mar 2021 14:27:51 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:18 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 14/17] arm64: add __nocfi to functions that jump to a
 physical address
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable CFI checking for functions that switch to linear mapping and
make an indirect call to a physical address, since the compiler only
understands virtual addresses and the CFI check for such indirect calls
would always fail.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/cpu-reset.h        | 8 ++++----
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 386b96400a57..d3cef9133539 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index f3adc574f969..9a7b1262ef17 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -13,10 +13,10 @@
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
+						       unsigned long arg0,
+						       unsigned long arg1,
+						       unsigned long arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ac616c59ae92..1cd7877deada 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1446,7 +1446,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.291.g576ba9dcdaf-goog

