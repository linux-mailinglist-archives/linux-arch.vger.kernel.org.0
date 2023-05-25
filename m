Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4C71189E
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 23:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbjEYVBA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEYVA7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 17:00:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D519C;
        Thu, 25 May 2023 14:00:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-530638a60e1so7775a12.2;
        Thu, 25 May 2023 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048458; x=1687640458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUEkNGDX6cV0iQXAiFNgFjvKJpYklaG2ZlRS0uxR5ls=;
        b=DW4DzSXOAJLOeRF0iu9R3lD0WFtF3jtGW7qacMd4+bka2yvmy8GA9YJgnYThxgpsWe
         0xzSvWUjLpozTCpKpRUpRRcolyUUtizjzM2WKTIlPv5CoJc3eaFzzxHZwlkKyqnVTLcI
         PCWByPN99ekQtdSEFPOea+7eFoNUYEiui8cNcj3ylIF1MYDAw8dz9PdvylaYvi4yHym6
         D8AOvQNLzvdBosadCjBUWCjq1WW1ZHDdGhw+KHMxPz7AZIKh3JMCew1BlAabLkFpAtpA
         4yEorxwCA+KB+Cm0x36QqoKmIeG3hU4okiesEWRw3EnPN8ZqxiszGkloDo3BDNgKijCi
         1wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048458; x=1687640458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUEkNGDX6cV0iQXAiFNgFjvKJpYklaG2ZlRS0uxR5ls=;
        b=UzpZa0IQf1Qro4duA/DjNlaxBqsID7f+ZtQCga6peNKg3oQF2ziz3vsvs7p/o6VPzm
         5ggUnf8b+9+lySotMZrME4DlyEC2tgGh2vwmtwC/iNOwGnDHDD8f2msGioP777aqewWo
         2g5zm6KWDSgtBQ1GUqFhIhuI/UFNNBVJtXKpJzfNABgatLw14f6ClLgzojI3HpmoViB5
         kXTtGBQuffYgn4K7h5aVfC8IaYEkQSCaOuzun4FMEqTAcdw1RqGsbdpOwHootl3g52Rm
         ahDN/3WXAa+RgJx6CUativRvz7hcYKHmDB7qlkPS8reX4b4+pj16k0JAYN1sDzIv5wzh
         EBWA==
X-Gm-Message-State: AC+VfDw5+GaZKqfZsnmiHSr8A8M4J5tKdzK3Z1NjCGXX21R/HgdhhqCo
        EwyYE4et1Ekj2evqRu+F/DQ=
X-Google-Smtp-Source: ACHHUZ7KQoExLFsvdM0qFZVOei5matyori6x50UzHtK4vBxDTJK1mctzRVqVn/yv1v1i8h9CBTNb3A==
X-Received: by 2002:a17:902:f7c6:b0:1ae:8892:7d27 with SMTP id h6-20020a170902f7c600b001ae88927d27mr2842006plw.42.1685048457437;
        Thu, 25 May 2023 14:00:57 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae8587d60csm1807673plj.265.2023.05.25.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:00:56 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>
Subject: [PATCH v2 1/3] kprobes: Mark descendents of core_kernel_text as notrace
Date:   Thu, 25 May 2023 14:00:38 -0700
Message-Id: <20230525210040.3637-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525210040.3637-1-namit@vmware.com>
References: <20230525210040.3637-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 0e8ff85890ad..a8c0d0a06664 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -330,7 +330,7 @@ int in_gate_area(struct mm_struct *mm, unsigned long addr)
 	return (addr >= gate_vma.vm_start) && (addr < gate_vma.vm_end);
 }
 
-int in_gate_area_no_mm(unsigned long addr)
+notrace int in_gate_area_no_mm(unsigned long addr)
 {
 	return in_gate_area(NULL, addr);
 }
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 7f5353e28516..6dbd3acbe837 100644
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
index e0ca8120aea8..2d1d09877f0c 100644
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
index 29b2203bc82c..1f92840af2f3 100644
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
index fe3c9993b5bf..e11743e68124 100644
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
index 27ce77080c79..e71ea764659c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3485,7 +3485,7 @@ static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
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

