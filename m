Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2661658C4A0
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiHHIGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbiHHIGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14B11472;
        Mon,  8 Aug 2022 01:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2756260EA5;
        Mon,  8 Aug 2022 08:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8661C43470;
        Mon,  8 Aug 2022 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659945978;
        bh=E9+7aC4Yw8oq+CFp7IBpO6wuIDD2IWECqn1vNuAh4Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0qSkbBljX/OZVI0viXnuLml2pfStiIeGHBuHL3siHSedGE3HFxJdpmfkjTY9a4o2
         f5NMfXHQKQHILSlbZ1zG2pisBhbG7vz014u3Y8Sp2Oz9cu+qVCv7crr5i34VxSOz/8
         XdZ+Ln/igjZG2mQylv4rBO7mxi0r7j8Nf/S4X9deoEe+uC5XXgDh6+sP2fRdNioMi5
         UCeotd8qCbNhW8Si/WhecVACDm2EMuIWOPIm+Bc3nUYy2bw0BBOwjV1WAVbKfLD+Pp
         e4bTQ01W5hKN5m7clD3wp5pv+E0xom6T3Qym7q5pccVtQRktYW7+v+vDOS3scds5ch
         W3IXChEmQpSkQ==
From:   guoren@kernel.org
To:     tj@kernel.org, cl@linux.com, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 1/4] vmstat: percpu: Rename HAVE_CMPXCHG_LOCAL to HAVE_CMPXCHG_PERCPU_BYTE
Date:   Mon,  8 Aug 2022 04:05:57 -0400
Message-Id: <20220808080600.3346843-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808080600.3346843-1-guoren@kernel.org>
References: <20220808080600.3346843-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The name HAVE_CMPXCHG_LOCAL is confused with using cmpxchg_local, but
vmstat needs this_cpu_cmpxchg_1. Rename would clarify the meaning, and
maybe we could remove cmpxchg(64)_local API (Only drivers/iommu/intel
used) in the future.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 .../features/locking/cmpxchg-local/arch-support.txt         | 6 +++---
 arch/Kconfig                                                | 2 +-
 arch/arm64/Kconfig                                          | 2 +-
 arch/s390/Kconfig                                           | 2 +-
 arch/x86/Kconfig                                            | 2 +-
 mm/vmstat.c                                                 | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 8b1a8d9e1c79..4d4c5c2fa66d 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          cmpxchg-local
-#         Kconfig:       HAVE_CMPXCHG_LOCAL
-#         description:   arch supports the this_cpu_cmpxchg() API
+# Feature name:          cmpxchg-percpu-byte
+#         Kconfig:       HAVE_CMPXCHG_PERCPU_BYTE
+#         description:   arch supports the this_cpu_cmpxchg_1() API
 #
     -----------------------
     |         arch |status|
diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a..81800cdfe161 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -471,7 +471,7 @@ config HAVE_ALIGNED_STRUCT_PAGE
 	  on a struct page for better performance. However selecting this
 	  might increase the size of a struct page by a word.
 
-config HAVE_CMPXCHG_LOCAL
+config HAVE_CMPXCHG_PERCPU_BYTE
 	bool
 
 config HAVE_CMPXCHG_DOUBLE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..24a82bdc766a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -175,7 +175,7 @@ config ARM64
 	select HAVE_EBPF_JIT
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
-	select HAVE_CMPXCHG_LOCAL
+	select HAVE_CMPXCHG_PERCPU_BYTE
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 318fce77601d..ac03af800bf7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -151,7 +151,7 @@ config S390
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
-	select HAVE_CMPXCHG_LOCAL
+	select HAVE_CMPXCHG_PERCPU_BYTE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..5f4f6df7b89f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -184,7 +184,7 @@ config X86
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
-	select HAVE_CMPXCHG_LOCAL
+	select HAVE_CMPXCHG_PERCPU_BYTE
 	select HAVE_CONTEXT_TRACKING_USER		if X86_64
 	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..b2fc6d28d3b2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -554,9 +554,9 @@ void __dec_node_page_state(struct page *page, enum node_stat_item item)
 }
 EXPORT_SYMBOL(__dec_node_page_state);
 
-#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+#ifdef CONFIG_HAVE_CMPXCHG_PERCPU_BYTE
 /*
- * If we have cmpxchg_local support then we do not need to incur the overhead
+ * If we have this_cpu_cmpxchg_1 arch support then we do not need to incur the overhead
  * that comes with local_irq_save/restore if we use this_cpu_cmpxchg.
  *
  * mod_state() modifies the zone counter state through atomic per cpu
-- 
2.36.1

