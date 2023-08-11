Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9867785C6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 05:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHKDH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 23:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKDH6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 23:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0169E76;
        Thu, 10 Aug 2023 20:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50461666B4;
        Fri, 11 Aug 2023 03:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4BC433CB;
        Fri, 11 Aug 2023 03:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691723276;
        bh=eN9CSYEbf3Xs1sDsJcrgo0eLFHBYXU3FQZg3hSvdbqo=;
        h=From:To:Cc:Subject:Date:From;
        b=g5CrG4a1mtlJaE8A8QtdZDCvrkVnSnmxLme59MM0OJf/4HDZW62J/Obkceq6jlOC0
         ciResOjtqpZMPnMCcQAi18HrR7Q5TsCFRnPZvGozXyZFC6wKsuRE+nhF1iYCyiUJ26
         bpQn1Y9nHMcK6GgqtH12mlz+5ZetjgCQ1SLnHSyJEVrbW/jKoRpuZTpEx2nhaI+iQ6
         9WwlHGC3jBipkB2t0FtE2p8o5rw8R5SG7gmpBi3g0B3lm/o+OfMR6RCCSbamxGGQs3
         u+E7Mu9q4wqyzw/MZYtKnNPYvhuUEQVBGG6uVQOM363qxbNz/yuwKdPciy0maeNFsd
         TFnhvrG6JEKDg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] csky: Fixup -Wmissing-prototypes warning
Date:   Thu, 10 Aug 2023 23:07:50 -0400
Message-Id: <20230811030750.1335526-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Cleanup the warnings:

arch/csky/kernel/ptrace.c:320:16: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/csky/kernel/ptrace.c:336:17: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]
arch/csky/kernel/setup.c:116:34: error: no previous prototype for 'csky_start' [-Werror=missing-prototypes]
arch/csky/kernel/signal.c:255:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:150:15: error: no previous prototype for 'do_trap_unknown' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:152:15: error: no previous prototype for 'do_trap_zdiv' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:154:15: error: no previous prototype for 'do_trap_buserr' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:157:17: error: no previous prototype for 'do_trap_misaligned' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:168:17: error: no previous prototype for 'do_trap_bkpt' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:187:17: error: no previous prototype for 'do_trap_illinsn' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:210:17: error: no previous prototype for 'do_trap_fpe' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:220:17: error: no previous prototype for 'do_trap_priv' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]

Link: https://lore.kernel.org/lkml/20230810141947.1236730-17-arnd@kernel.org/
Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/ptrace.h        |  2 ++
 arch/csky/include/asm/sections.h      |  2 ++
 arch/csky/include/asm/traps.h         | 15 +++++++++++++++
 arch/csky/kernel/vdso/vgettimeofday.c | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index 4202aab6df42..0634b7895d81 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -96,5 +96,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
+asmlinkage int syscall_trace_enter(struct pt_regs *regs);
+asmlinkage void syscall_trace_exit(struct pt_regs *regs);
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_CSKY_PTRACE_H */
diff --git a/arch/csky/include/asm/sections.h b/arch/csky/include/asm/sections.h
index 4192cba8445d..83e82b7c0f6c 100644
--- a/arch/csky/include/asm/sections.h
+++ b/arch/csky/include/asm/sections.h
@@ -7,4 +7,6 @@
 
 extern char _start[];
 
+asmlinkage void csky_start(unsigned int unused, void *dtb_start);
+
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/csky/include/asm/traps.h b/arch/csky/include/asm/traps.h
index 421a4195e2fe..1e7d303b91e9 100644
--- a/arch/csky/include/asm/traps.h
+++ b/arch/csky/include/asm/traps.h
@@ -40,4 +40,19 @@ do { \
 
 void csky_alignment(struct pt_regs *regs);
 
+asmlinkage void do_trap_unknown(struct pt_regs *regs);
+asmlinkage void do_trap_zdiv(struct pt_regs *regs);
+asmlinkage void do_trap_buserr(struct pt_regs *regs);
+asmlinkage void do_trap_misaligned(struct pt_regs *regs);
+asmlinkage void do_trap_bkpt(struct pt_regs *regs);
+asmlinkage void do_trap_illinsn(struct pt_regs *regs);
+asmlinkage void do_trap_fpe(struct pt_regs *regs);
+asmlinkage void do_trap_priv(struct pt_regs *regs);
+asmlinkage void trap_c(struct pt_regs *regs);
+
+asmlinkage void do_notify_resume(struct pt_regs *regs,
+			unsigned long thread_info_flags);
+
+void trap_init(void);
+
 #endif /* __ASM_CSKY_TRAPS_H */
diff --git a/arch/csky/kernel/vdso/vgettimeofday.c b/arch/csky/kernel/vdso/vgettimeofday.c
index da491832c098..c4831145eed5 100644
--- a/arch/csky/kernel/vdso/vgettimeofday.c
+++ b/arch/csky/kernel/vdso/vgettimeofday.c
@@ -3,24 +3,35 @@
 #include <linux/time.h>
 #include <linux/types.h>
 
+extern
+int __vdso_clock_gettime(clockid_t clock,
+			 struct old_timespec32 *ts);
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts);
 int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
 	return __cvdso_clock_gettime(clock, ts);
 }
 
+extern
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 			struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
+extern
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res);
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
-- 
2.36.1

