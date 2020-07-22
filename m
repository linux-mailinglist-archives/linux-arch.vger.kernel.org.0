Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE5229D56
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGVQpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVQpC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64739C0619E0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so2618616wmf.5
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iEzS/K7FKWZpD3ua8htStuWzJAGtakSYjlBsBpxZ/4=;
        b=l8EUVZgCpIRU1QL7F3sHnMulBx+ndcr+hiyAH/9TDLEfZ3e4nRnvYcMRlw8pJ1RZDD
         usP3/tJ/orr9olI8t2Qx+Sj/5tEnhSWSaxwGyGsDcxf+AzwpzLvAQgo1GARi5BT9Pose
         fSVvL492qfWaMefMcn5RNZm4KMBSxUa2R4mITHBHTG4G42tVvAyz5XC8X1EHjDPKKVTC
         gnO+1g9xzqhkqboMF9feb+jULlJjKVO8BTsdu5IB3Jql+dhjkP+s/fUtYQxamWeUqX3k
         YELPwGsw80aBmerABn4F7VHRlZuY5XWbtJqzVum5e1OoTgXIAeaBwQQFl2H3zHD4YBs6
         8Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iEzS/K7FKWZpD3ua8htStuWzJAGtakSYjlBsBpxZ/4=;
        b=VLLwlHEfVK+SVrDShlkUL9u/PtklHuKCmpey+IUIslpxB4uIuQd6MiBJyKGxrVi/RE
         4LMYENStRkzBiD2RaKqP9VyAuHE9WQSdza1A5qb824mbqDDemK4/1+yDnPvvVXaU8sse
         9pXn7kuzzkWYxfU27tq57NsnJRLNs5HNA0CrrEmlR4OcEWjbWEQw8vK3SFcj1FjUb8Su
         jC9XO+46NyJZJbrXvdPukmXL1VMsV5GL/+HW8RHmRtCsS9vuunM5ZeRWoUrIGw1T5ocf
         tDaX7G2o9AEp3Op6ZCuU24FUb+RjJm2jdfFoTU6IcYfcSTuQ+eTGtRga+D6VYb1A70cc
         xROw==
X-Gm-Message-State: AOAM530gXw6/a7WANnw7XCDombnQ8xNjXTLT5ZtW5isx/aN4giQI0/Zp
        N41+Xs3hE1cwSHlHRaXdwtJo+w==
X-Google-Smtp-Source: ABdhPJyvvcrdUvKbE/hxCmWbSibjaaJ7nEtZ3HDL894GJKBpxshjcuwx5vl2E/hVxnCbvqkXRidabQ==
X-Received: by 2002:a1c:a756:: with SMTP id q83mr457233wme.168.1595436300851;
        Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id u20sm265826wmm.15.2020.07.22.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 1/9] Macros to override naming of percpu symbols and sections
Date:   Wed, 22 Jul 2020 17:44:16 +0100
Message-Id: <20200722164424.42225-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modify generic linker script macros to generate section/symbol names for
percpu area using overridable macros. No functional changes.

This will allow arm64 linker script to define a second KVM-specific percpu
data section using the generic PERCPU_SECTION macro.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 include/asm-generic/vmlinux.lds.h | 40 +++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..1bfc002ecfce 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -892,6 +892,20 @@
 #define INIT_RAM_FS
 #endif
 
+/*
+ * Macros to override the naming of percpu symbols and sections.
+ * Used by arm64 linker script to define a separate percpu area for KVM.
+ */
+#define PERCPU_SECTION_BASE_NAME .data..percpu
+
+#ifndef PERCPU_SECTION_NAME
+#define PERCPU_SECTION_NAME(suffix) PERCPU_SECTION_BASE_NAME ## suffix
+#endif
+
+#ifndef PERCPU_SYMBOL_NAME
+#define PERCPU_SYMBOL_NAME(name) name
+#endif
+
 /*
  * Memory encryption operates on a page basis. Since we need to clear
  * the memory encryption mask for this section, it needs to be aligned
@@ -903,7 +917,7 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
-	*(.data..percpu..decrypted)					\
+	*(PERCPU_SECTION_NAME(..decrypted))				\
 	. = ALIGN(PAGE_SIZE);
 #else
 #define PERCPU_DECRYPTED_SECTION
@@ -947,17 +961,17 @@
  * sharing between subsections for different purposes.
  */
 #define PERCPU_INPUT(cacheline)						\
-	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
+	PERCPU_SYMBOL_NAME(__per_cpu_start) = .;			\
+	*(PERCPU_SECTION_NAME(..first))					\
 	. = ALIGN(PAGE_SIZE);						\
-	*(.data..percpu..page_aligned)					\
+	*(PERCPU_SECTION_NAME(..page_aligned))				\
 	. = ALIGN(cacheline);						\
-	*(.data..percpu..read_mostly)					\
+	*(PERCPU_SECTION_NAME(..read_mostly))				\
 	. = ALIGN(cacheline);						\
-	*(.data..percpu)						\
-	*(.data..percpu..shared_aligned)				\
+	*(PERCPU_SECTION_NAME())					\
+	*(PERCPU_SECTION_NAME(..shared_aligned))			\
 	PERCPU_DECRYPTED_SECTION					\
-	__per_cpu_end = .;
+	PERCPU_SYMBOL_NAME(__per_cpu_end) = .;
 
 /**
  * PERCPU_VADDR - define output section for percpu area
@@ -984,11 +998,11 @@
  * address, use PERCPU_SECTION.
  */
 #define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
+	PERCPU_SYMBOL_NAME(__per_cpu_load) = .;				\
+	PERCPU_SECTION_NAME() vaddr : AT(PERCPU_SYMBOL_NAME(__per_cpu_load) - LOAD_OFFSET) { \
 		PERCPU_INPUT(cacheline)					\
 	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
+	. = PERCPU_SYMBOL_NAME(__per_cpu_load) + SIZEOF(PERCPU_SECTION_NAME());
 
 /**
  * PERCPU_SECTION - define output section for percpu area, simple version
@@ -1004,8 +1018,8 @@
  */
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
-	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
+	PERCPU_SECTION_NAME() : AT(ADDR(PERCPU_SECTION_NAME()) - LOAD_OFFSET) { \
+		PERCPU_SYMBOL_NAME(__per_cpu_load) = .;			\
 		PERCPU_INPUT(cacheline)					\
 	}
 
-- 
2.27.0

