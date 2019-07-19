Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEA6E3FD
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGSKKe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 06:10:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSKKe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 06:10:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41564337;
        Fri, 19 Jul 2019 03:10:33 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C823F59C;
        Fri, 19 Jul 2019 03:10:30 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, daniel.lezcano@linaro.org,
        tglx@linutronix.de, salyzyn@android.com, pcc@google.com,
        0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com,
        luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com,
        yamada.masahiro@socionext.com, Will Deacon <will@kernel.org>
Subject: [PATCH v2] arm64: vdso: Cleanup Makefiles
Date:   Fri, 19 Jul 2019 11:10:18 +0100
Message-Id: <20190719101018.1984-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The recent changes to the vdso library for arm64 and the introduction of
the compat vdso library have generated some misalignment in the
Makefiles.

Cleanup the Makefiles for vdso and vdso32 libraries:
  * Removing unused rules.
  * Unifying the displayed compilation messages.
  * Simplifying the generic library inclusion path for
    arm64 vdso.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso/Makefile   |  9 +++------
 arch/arm64/kernel/vdso32/Makefile | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 75d25679d879..dd2514bb1511 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -32,10 +32,10 @@ UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
 
-ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
-else
-CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
+
+ifneq ($(c-gettimeofday-y),)
+  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
 
 # Clang versions less than 8 do not support -mcmodel=tiny
@@ -73,9 +73,6 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Actual build commands
-quiet_cmd_vdsocc = VDSOCC   $@
-      cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
-
 quiet_cmd_vdsold_and_vdso_check = LD      $@
       cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
 
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 21009ed5a755..154767d60001 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -155,17 +155,17 @@ $(asm-obj-vdso): %.o: %.S FORCE
 	$(call if_changed_dep,vdsoas)
 
 # Actual build commands
-quiet_cmd_vdsold_and_vdso_check = LD      $@
+quiet_cmd_vdsold_and_vdso_check = LD32    $@
       cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
 
-quiet_cmd_vdsold = VDSOL   $@
+quiet_cmd_vdsold = LD32    $@
       cmd_vdsold = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
                    -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
-quiet_cmd_vdsocc = VDSOC   $@
+quiet_cmd_vdsocc = CC32    $@
       cmd_vdsocc = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
-quiet_cmd_vdsocc_gettimeofday = VDSOC_GTD   $@
+quiet_cmd_vdsocc_gettimeofday = CC32    $@
       cmd_vdsocc_gettimeofday = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) $(VDSO_CFLAGS_gettimeofday_o) -c -o $@ $<
-quiet_cmd_vdsoas = VDSOA   $@
+quiet_cmd_vdsoas = AS32    $@
       cmd_vdsoas = $(COMPATCC) -Wp,-MD,$(depfile) $(VDSO_AFLAGS) -c -o $@ $<
 
 quiet_cmd_vdsomunge = MUNGE   $@
-- 
2.22.0

