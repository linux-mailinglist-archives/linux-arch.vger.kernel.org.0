Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04DC1883ED
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 13:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCQMYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 08:24:02 -0400
Received: from foss.arm.com ([217.140.110.172]:37060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCQMXt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 08:23:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C0C101E;
        Tue, 17 Mar 2020 05:23:49 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6157C3F534;
        Tue, 17 Mar 2020 05:23:46 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in vgettimeofday
Date:   Tue, 17 Mar 2020 12:22:12 +0000
Message-Id: <20200317122220.30393-19-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317122220.30393-1-vincenzo.frascino@arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For ABI compatibility with arm32, the compat vDSO layer on arm64 needs
to return -EINVAL when UINTPTR_MAX is passed as argument to the
clock_get* functions.

Replace TASK_SIZE_32 with a more semantically correct formula that checks
for wrapping around 0.

Note: This will allow to not define TASK_SIZE_32 for the vdso headers in a
future patch that will introduce asm/vdso/processor.h on arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso32/vgettimeofday.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index 54fc1c2ce93f..91138077b073 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -8,11 +8,14 @@
 #include <linux/time.h>
 #include <linux/types.h>
 
+#define VALID_CLOCK_ID(x) \
+	((x >= 0) && (x < VDSO_BASES))
+
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
 	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
+	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
 		return -EFAULT;
 
 	return __cvdso_clock_gettime32(clock, ts);
@@ -22,7 +25,7 @@ int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
 	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
+	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
 		return -EFAULT;
 
 	return __cvdso_clock_gettime(clock, ts);
@@ -38,9 +41,12 @@ int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
 	/* The checks below are required for ABI consistency with arm */
-	if ((u32)res >= TASK_SIZE_32)
+	if ((u32)res > UINTPTR_MAX - sizeof(res) + 1)
 		return -EFAULT;
 
+	if (!VALID_CLOCK_ID(clock_id) && res == NULL)
+		return -EINVAL;
+
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
-- 
2.25.1

