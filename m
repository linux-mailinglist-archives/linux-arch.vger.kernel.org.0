Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC6346A3B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhCWUkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhCWUkP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6952CC0613D9
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so3830801ybr.11
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qy/qpaQcjeJGAGSX/SJfdvrV6+xztRS9WV/l31kV3fo=;
        b=p9ojVOb7QdO7JLZj9S/1SqPGP8MeifFmkf1e6TNJokU+4X+mDo0s3TIOhU1rmJD0gQ
         C3q3EV251sFO4e//IgvNjn6P29FqOur3szQsT80WVJVAgcgLC/L4gp8LF+fgzMkzOMdQ
         qK0XZckG24gPmdHwXF6V6z62Qj29O8AjeBevFbC/8BXBEoj5BXdSL0u6CL6w5E92BGE7
         +vtDECL4yMlxuZ35+QWL2+CnrRi7FlCo5jHCQ87YudtBBhNKSZWNcK4Kl6XHbFJXUSPL
         qDxp8oIjW07ybSAxf6LQQ6rDchJmoirsp7IIZbdM6z6gMba2BAhKKUVuDpzy54UcfqSt
         3+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qy/qpaQcjeJGAGSX/SJfdvrV6+xztRS9WV/l31kV3fo=;
        b=atarjLiUaoHRjNKF0x66dJwAgx+2ztRtD7iJJxo376kTvnEDP38xuAmLw5AGh9c09k
         KYSqxRuqxVo+K4lKOKcmgvlkxoqUQBYWSLpGs6ChnidlAQKSu7f/QXRLBvLncYiLyma3
         Qaee+oWJBVd/a+mlokkfNQZeLpFNUb/dcQb2lFiDbGZI8owh0d2QGOcROyChzV/n8pbW
         /Tu71+zmhRMjfRIjFJ9Ywu6p04gzv81d66+R+modthx1R8vs7lRGc3VRE3LRWQPYUXI0
         5P7VQCJQYjlDHXU9u+vckfxnTFu13zmmYRuhm7z/Sspnb7CGxxLzf+HInupBOMYwoONx
         VQdA==
X-Gm-Message-State: AOAM532v+o2y3mEBjQeSZq4naS7PYuj0rwFJ40EHzdBUZrOoFsvE08BZ
        5U8oSNjbWqWVEAg8nKpWBjqcWTrYgvqU7WI6Dak=
X-Google-Smtp-Source: ABdhPJynHOWSO11EeejwuL7BmZY2Zs5wB2dBb0RO3vU6HGkp4hd57n5miL7y+94vuamNMAUwpzA/HtJp7Bz7P8/50B8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:da48:: with SMTP id
 n69mr74886ybf.47.1616532014644; Tue, 23 Mar 2021 13:40:14 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:43 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 14/17] arm64: add __nocfi to functions that jump to a
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
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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
index 16cc9a694bb2..270ba8761a23 100644
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
index dfba8cf921e5..a05bda363272 100644
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
index 7ec1c2ccdc0b..473212ff4d70 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1443,7 +1443,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.291.g576ba9dcdaf-goog

