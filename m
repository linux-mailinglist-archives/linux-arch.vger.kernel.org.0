Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548AC5F3CC6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 08:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJDGdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJDGde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 02:33:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD36476E0
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 23:33:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 83so5356303pfw.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z2WK+wlDbtY/C0uGfFoDk9EIHilR5NLBt+oI60VmnUQ=;
        b=apjnRLGMPZL8pBtCKL095i7yoKKQVhaqXtX6qC/Xd2jKkrBDxM3H84Gkxb0WKHBZVV
         MDSIC2epEkJ6WJLkhtRIdzB56iLpn4+2ILZPXKHNsJ5n18KZJ1bodjKc6aNgcTK8K9hY
         G650urgoW056ehs6I25AIbfvKGPguCINYEHGRD4zYG3oC4CFmKC+VDU+nBpxfW7JutVD
         z9wP3qcNPB4JDk0gPsLfSLSNi6N7a5tDR30SsNiIU/0p2Rn06Rl3/p+SnPjphg+mvehV
         ro+HnKuvsYUZLm3GHU9jt2RKj2PIHnIs/mF9L2c0p1kH9Hri1Kcf8z9xTBb4g5KGzHjU
         0qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z2WK+wlDbtY/C0uGfFoDk9EIHilR5NLBt+oI60VmnUQ=;
        b=SNOAUhHw0MRzJd2VxuYyESqAUazaRy6w+vUe1vv2gK5l0/6I4UC4E6PBDoQCOLMnX0
         EzlWztKQ3wLHNYXXV/vPqR4ehreRiok19JMTr6wIwkJnODABgUNJyCfDnAJEjY0JpDE4
         1vbKx+lYiFydI5b/rWIfp3ocXgTDbRSlU6jzQsdTRduwC5+TYR+CIbPQYRfziRWANDsy
         9sUEuMssBIdMlzLjVHENraz7VPNvmOYGXfo4pljbmGOmj6LQJwnSOc/so8qlIF+vCE6c
         /ZQdSUrdi+7KzDW8FwxHYA8rakNUBpPnS9iFeTc+SVRjnifIM4vcLwozUCHUTXjeVXWo
         GPPQ==
X-Gm-Message-State: ACrzQf1Lyy//JmKid8aehYjcCnq7ZqBSYCyIsrwIm1tTeUYaZo7aPI82
        vR/dwcUPa0C2K898OdyGTjE=
X-Google-Smtp-Source: AMsMyM7CJBZHT64mLwlP3q7AMio8FRpN4kA/992lfSLMx6EXkWvS7pHXOHP9EIM/3a+qdcFMCVE04w==
X-Received: by 2002:a63:b545:0:b0:43c:2ad9:b00 with SMTP id u5-20020a63b545000000b0043c2ad90b00mr21923516pgo.535.1664865207032;
        Mon, 03 Oct 2022 23:33:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (123-243-1-173.tpgi.com.au. [123.243.1.173])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78bd1000000b0056160437e88sm3701782pfd.20.2022.10.03.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 23:33:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arch@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC PATCH 3/3] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date:   Tue,  4 Oct 2022 16:33:06 +1000
Message-Id: <20221004063306.511154-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221004063306.511154-1-npiggin@gmail.com>
References: <20221004063306.511154-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This option was created in commit 554b0004d0ec4 ("vtime: Add
HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.

The cputime_t type has since been removed, so this doesn't have any
meaning. Remove it.

Cc: linux-arch@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig           | 11 -----------
 arch/arm/Kconfig       |  1 -
 arch/csky/Kconfig      |  1 -
 arch/loongarch/Kconfig |  1 -
 arch/mips/Kconfig      |  1 -
 arch/xtensa/Kconfig    |  1 -
 init/Kconfig           |  1 -
 kernel/time/Kconfig    |  2 --
 8 files changed, 19 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5dbf11a5ba4e..54c73e22c526 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -829,17 +829,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_IDLE
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
-config HAVE_VIRT_CPU_ACCOUNTING_GEN
-	bool
-	default y if 64BIT
-	help
-	  With VIRT_CPU_ACCOUNTING_GEN, cputime_t becomes 64-bit.
-	  Before enabling this option, arch code must be audited
-	  to ensure there are no races in concurrent read/write of
-	  cputime_t. For example, reading/writing 64-bit cputime_t on
-	  some 32-bit arches may require multiple accesses, so proper
-	  locking is needed to protect against concurrent accesses.
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..47f3a23564e8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -119,7 +119,6 @@ config ARM
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3cbc2dc62baf..8102d0d3f3b3 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -72,7 +72,6 @@ config CSKY
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_CONTEXT_TRACKING_USER
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 26aeb1408e56..201b5d4e5c25 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -97,7 +97,6 @@ config LOONGARCH
 	select HAVE_SETUP_PER_CPU_AREA if NUMA
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select MMU_GATHER_MERGE_VMAS if MMU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec21f8999249..f67291d8e09c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -90,7 +90,6 @@ config MIPS
 	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
 	select MODULES_USE_ELF_REL if MODULES
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 12ac277282ba..18053fe9ec38 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -47,7 +47,6 @@ config XTENSA
 	select HAVE_PERF_EVENTS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
diff --git a/init/Kconfig b/init/Kconfig
index 94ce5a46a802..bb6d7f0d80fe 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -490,7 +490,6 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING_USER
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING_USER
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a41753be1a2b..ed480ba6cf35 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -121,8 +121,6 @@ config NO_HZ_FULL
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
 	depends on HAVE_CONTEXT_TRACKING_USER
-	# VIRT_CPU_ACCOUNTING_GEN dependency
-	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
 	select RCU_NOCB_CPU
 	select VIRT_CPU_ACCOUNTING_GEN
-- 
2.37.2

