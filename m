Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9596315C7D6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBMQQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:16:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMQQq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:16:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69F41045;
        Thu, 13 Feb 2020 08:16:45 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235143F6CF;
        Thu, 13 Feb 2020 08:16:43 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 01/19] linux/const.h: Extract common header for vDSO
Date:   Thu, 13 Feb 2020 16:15:56 +0000
Message-Id: <20200213161614.23246-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
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

Split const.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/const.h | 10 ++++++++++
 include/linux/const.h  |  5 +----
 2 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 include/common/const.h

diff --git a/include/common/const.h b/include/common/const.h
new file mode 100644
index 000000000000..cc209eec47a1
--- /dev/null
+++ b/include/common/const.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_CONST_H
+#define __COMMON_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* __COMMON_CONST_H */
diff --git a/include/linux/const.h b/include/linux/const.h
index 7b55a55f5911..447a5b98d5a3 100644
--- a/include/linux/const.h
+++ b/include/linux/const.h
@@ -1,9 +1,6 @@
 #ifndef _LINUX_CONST_H
 #define _LINUX_CONST_H
 
-#include <uapi/linux/const.h>
-
-#define UL(x)		(_UL(x))
-#define ULL(x)		(_ULL(x))
+#include <common/const.h>
 
 #endif /* _LINUX_CONST_H */
-- 
2.25.0

