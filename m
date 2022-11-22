Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300CF6344F0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 20:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiKVTys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 14:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiKVTyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 14:54:22 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFD87569;
        Tue, 22 Nov 2022 11:54:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s196so14970078pgs.3;
        Tue, 22 Nov 2022 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nn7aMM2ad863pOwZNew/EvwCgnDwcAXHi2MWDQYfDjI=;
        b=RWz8sQLTQNvwgI2df8iLxqTr+sEw2wL39ea4kS0x0CprI1Kazflsy25JZbcrvSVApe
         /J8BU2BdqPBAPvrZwiFyTsF2oCcIaJupZWYCUmQpgc6w7Mci0k796A2l5q76RE9EdXTA
         Y5Jj086CqiUiB+OQPu8JUCbvrxhw976thH2TDil0rbo40+rwg9yMA9TmoS6O7Ol5eP0M
         d/kKVs7mx9Y2/nqKZ4BSB8geM9Ng39PiXZ7FjJWo1AqWLj4/Qm9gyHpiz7oo9Yj1tmpT
         wKNk/r5X7uwX8DtW9DnIcUHEJ5XGFAzB8j7SPddwv5jfphWDzG5VNfg85Tbz35un/sdx
         gXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn7aMM2ad863pOwZNew/EvwCgnDwcAXHi2MWDQYfDjI=;
        b=rBCVGZH+vZjRvVNdIIcBL63B0GxsmHq2dQjK5fuK9c3WxmEZZnyqnwOoCr9x4seHtW
         uOtWENm/d63znGDAispuUNKP30KWQDX2d2VDJMH54KPido6TLKPcJI6zi/B0ts0hsTmu
         KXZ3FrNE/qsMBvE4gE17hGD3oTpJjAOzzQYYyYUNv44Ktl4Ke3FqZm66XoSrCzY8Kcz0
         Blvchhi8HRN22FUngzqLlcIAvi+Yw6S+no1pUOE0WGIi1Q0cXnany6tEVqQDHLyexRe2
         NB2hHVaFsqmyE6kYKO+zC+z1DImUWe+9yypRPPOo/s0tF8hGkboFVctxtvG1dekQLbo/
         qr1w==
X-Gm-Message-State: ANoB5pnoLSzrpBEU6mH7kHnmp3Mq5XNqOC0VsfXpmiIOY3gHzv4A3c+d
        esihhYK+gYfpPg9mY4Zv1qQ=
X-Google-Smtp-Source: AA0mqf4xdDjkEQnqny8aCR9O4Z6MZfbB7hXn6Tt6gZf1irhsfXFQuaWdxi/hknugWvaiEseiVIEXXg==
X-Received: by 2002:a63:cd09:0:b0:476:d44d:355 with SMTP id i9-20020a63cd09000000b00476d44d0355mr5437893pgg.289.1669146858593;
        Tue, 22 Nov 2022 11:54:18 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a63d408000000b00460fbe0d75esm9699252pgh.31.2022.11.22.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:54:18 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>
Subject: [PATCH 1/3] kprobes: Mark descendents of core_kernel_text as notrace
Date:   Tue, 22 Nov 2022 11:53:27 -0800
Message-Id: <20221122195329.252654-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122195329.252654-1-namit@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Commit c0d80ddab899 ("kernel/extable.c: mark core_kernel_text notrace")
disabled the tracing of core_kernel_text to avoid recursive calls. For
the same reasons, all the functions in the dynamic extents of
core_kernel_text should be marked as notrace.

Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/arm/kernel/process.c             | 2 +-
 arch/ia64/mm/init.c                   | 2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/um/mem_32.c                  | 2 +-
 include/asm-generic/sections.h        | 6 +++---
 include/linux/kallsyms.h              | 6 +++---
 include/linux/mm.h                    | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index a2b31d91a1b6..a32ca8fcab5a 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -331,7 +331,7 @@ int in_gate_area(struct mm_struct *mm, unsigned long addr)
 	return (addr >= gate_vma.vm_start) && (addr < gate_vma.vm_end);
 }
 
-int in_gate_area_no_mm(unsigned long addr)
+notrace int in_gate_area_no_mm(unsigned long addr)
 {
 	return in_gate_area(NULL, addr);
 }
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index fc4e4217e87f..e3d63d3d3e59 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -284,7 +284,7 @@ struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 	return &gate_vma;
 }
 
-int in_gate_area_no_mm(unsigned long addr)
+notrace int in_gate_area_no_mm(unsigned long addr)
 {
 	if ((addr >= FIXADDR_USER_START) && (addr < FIXADDR_USER_END))
 		return 1;
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee..68ebad6abd2b 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -340,7 +340,7 @@ int in_gate_area(struct mm_struct *mm, unsigned long addr)
  * context. It is less reliable than using a task's mm and may give
  * false positives.
  */
-int in_gate_area_no_mm(unsigned long addr)
+notrace int in_gate_area_no_mm(unsigned long addr)
 {
 	return vsyscall_mode != NONE && (addr & PAGE_MASK) == VSYSCALL_ADDR;
 }
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
index cafd01f730da..cfec8b00b136 100644
--- a/arch/x86/um/mem_32.c
+++ b/arch/x86/um/mem_32.c
@@ -28,7 +28,7 @@ struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 	return FIXADDR_USER_START ? &gate_vma : NULL;
 }
 
-int in_gate_area_no_mm(unsigned long addr)
+notrace int in_gate_area_no_mm(unsigned long addr)
 {
 	if (!FIXADDR_USER_START)
 		return 0;
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index db13bb620f52..d519965b67bf 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -188,7 +188,7 @@ static inline bool is_kernel_rodata(unsigned long addr)
  *
  * Returns: true if the address is located in .init.text, false otherwise.
  */
-static inline bool is_kernel_inittext(unsigned long addr)
+static notrace inline bool is_kernel_inittext(unsigned long addr)
 {
 	return addr >= (unsigned long)_sinittext &&
 	       addr < (unsigned long)_einittext;
@@ -203,7 +203,7 @@ static inline bool is_kernel_inittext(unsigned long addr)
  * Returns: true if the address is located in .text, false otherwise.
  * Note: an internal helper, only check the range of _stext to _etext.
  */
-static inline bool __is_kernel_text(unsigned long addr)
+static notrace inline bool __is_kernel_text(unsigned long addr)
 {
 	return addr >= (unsigned long)_stext &&
 	       addr < (unsigned long)_etext;
@@ -219,7 +219,7 @@ static inline bool __is_kernel_text(unsigned long addr)
  *       and range from __init_begin to __init_end, which can be outside
  *       of the _stext to _end range.
  */
-static inline bool __is_kernel(unsigned long addr)
+static notrace inline bool __is_kernel(unsigned long addr)
 {
 	return ((addr >= (unsigned long)_stext &&
 	         addr < (unsigned long)_end) ||
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 649faac31ddb..7ee6a734b738 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,21 +24,21 @@
 struct cred;
 struct module;
 
-static inline int is_kernel_text(unsigned long addr)
+static notrace inline int is_kernel_text(unsigned long addr)
 {
 	if (__is_kernel_text(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
-static inline int is_kernel(unsigned long addr)
+static notrace inline int is_kernel(unsigned long addr)
 {
 	if (__is_kernel(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
-static inline int is_ksym_addr(unsigned long addr)
+static notrace inline int is_ksym_addr(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
 		return is_kernel(addr);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bfac5a166cb8..36a938c10ede 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3186,7 +3186,7 @@ static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 	return NULL;
 }
-static inline int in_gate_area_no_mm(unsigned long addr) { return 0; }
+static notrace inline int in_gate_area_no_mm(unsigned long addr) { return 0; }
 static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 {
 	return 0;
-- 
2.25.1

