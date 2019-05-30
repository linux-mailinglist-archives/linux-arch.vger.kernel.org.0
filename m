Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373AD2FD12
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfE3OQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:16:03 -0400
Received: from foss.arm.com ([217.140.101.70]:36514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfE3OQC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF231684;
        Thu, 30 May 2019 07:16:02 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10BDC3F59C;
        Thu, 30 May 2019 07:15:58 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Mark Salyzyn <salyzyn@google.com>
Subject: [PATCH v6 05/19] arm64: Build vDSO with -ffixed-x18
Date:   Thu, 30 May 2019 15:15:17 +0100
Message-Id: <20190530141531.43462-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

The vDSO needs to be build with x18 reserved in order to accommodate
userspace platform ABIs built on top of Linux that use the register
to carry inter-procedural state, as provided for by the AAPCS.
An example of such a platform ABI is the one that will be used by an
upcoming version of Android.

Although this change is currently a no-op due to the fact that the vDSO
is currently implemented in pure assembly on arm64, it is necessary
in order to prepare for another change [1] that will add C code to
the vDSO.

[1] https://patchwork.kernel.org/patch/10044501/

Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Mark Salyzyn <salyzyn@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 00bcfd2672cf..d98230f70caf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -20,7 +20,7 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
 
-ccflags-y := -fno-common -fno-builtin -fno-stack-protector
+ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
-- 
2.21.0

