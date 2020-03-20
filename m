Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7617518D1B9
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCTOzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:55:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbgCTOzT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:55:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE50D1045;
        Fri, 20 Mar 2020 07:55:18 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8FE43F792;
        Fri, 20 Mar 2020 07:55:15 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
        Mark Rutland <Mark.Rutland@arm.com>
Subject: [PATCH v5 11/26] linux/time32.h: Extract common header for vDSO
Date:   Fri, 20 Mar 2020 14:53:36 +0000
Message-Id: <20200320145351.32292-12-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320145351.32292-1-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split time32.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/time32.h | 14 ++------------
 include/vdso/time32.h  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)
 create mode 100644 include/vdso/time32.h

diff --git a/include/linux/time32.h b/include/linux/time32.h
index cad4c3186002..0933f28214c0 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -12,19 +12,9 @@
 #include <linux/time64.h>
 #include <linux/timex.h>
 
-#define TIME_T_MAX	(__kernel_old_time_t)((1UL << ((sizeof(__kernel_old_time_t) << 3) - 1)) - 1)
-
-typedef s32		old_time32_t;
-
-struct old_timespec32 {
-	old_time32_t	tv_sec;
-	s32		tv_nsec;
-};
+#include <vdso/time32.h>
 
-struct old_timeval32 {
-	old_time32_t	tv_sec;
-	s32		tv_usec;
-};
+#define TIME_T_MAX	(__kernel_old_time_t)((1UL << ((sizeof(__kernel_old_time_t) << 3) - 1)) - 1)
 
 struct old_itimerspec32 {
 	struct old_timespec32 it_interval;
diff --git a/include/vdso/time32.h b/include/vdso/time32.h
new file mode 100644
index 000000000000..fdf56f932f67
--- /dev/null
+++ b/include/vdso/time32.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_TIME32_H
+#define __VDSO_TIME32_H
+
+typedef s32		old_time32_t;
+
+struct old_timespec32 {
+	old_time32_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct old_timeval32 {
+	old_time32_t	tv_sec;
+	s32		tv_usec;
+};
+
+#endif /* __VDSO_TIME32_H */
-- 
2.25.1

