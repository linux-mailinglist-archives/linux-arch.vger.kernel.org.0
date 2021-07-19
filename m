Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD03CF03C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhGSXHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354299AbhGSUXp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jul 2021 16:23:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E3C061787;
        Mon, 19 Jul 2021 14:02:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j199so17677115pfd.7;
        Mon, 19 Jul 2021 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5VbLoDXsQD50yQzjB6TT1EHQn/LEejS2HSUVl4nV+E=;
        b=jTIxdQWErN7a9362DzqyPp3w7keD5GTAVGG3eVJmU+FejkSbGQ1esSQDtyy/6HgHUD
         aqwGSD4qlS1YjFzh95Lneq02admIGC+Pd0eruJewo+423PBbHBTVQTw1ImjrBoFQEzlI
         5uIoGj8vCISnehbzlPGaWD6C9HXsf9GJJ3VUPw4+UjPfkLUI2p2a+YKWNELpFJSDsoZz
         HVXRynus4sXds1S8C/EdTBdDBD3Dbc4PAsLY7JWHw8zjBktowS8mMGoIzUqgCn/0+pwM
         njWvoe1/R+K2hObnO8HBZJRSA5GpMoBZ0kZ0fUXngYf0xSOuuZrxcGNrD3rUMThluN/a
         I7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5VbLoDXsQD50yQzjB6TT1EHQn/LEejS2HSUVl4nV+E=;
        b=P7apoH97kKoE/tLVfQiQY2/kp7sm1qSi6NdXeqoiIG5Jxm8zEGeINrhnUuTciLXwQg
         tzS/igHB8fb8aUDng8rdLM0MdA0A/t9v8xJX2E4TLAcI5sPmrXUr98qq7xyMD7Y+IDKT
         +YZRwTTfL8kNRbvDYvnxd/H4bOH2odEenoKDWQdpLRKdth612S6qTz+YvQ9Gqfq9owwT
         Cf9zmBzH/waU6hIazrJn74+DSsG31uBZscP1rpKzCDDEZQ+fCFkVexvfqaA23wdcoWye
         fblIVdm3lAFgH3IDeg3QEWsjLIXihopFzqOPm6okbpUl/Xu5ses2I+JLn8T++v8WGZ+l
         7r7A==
X-Gm-Message-State: AOAM531zZkAJyLPGWbJhsGWVGP5x1MR2CEjZIDRmHSyL749V1GrgUhIw
        wXf3rNPVkYMsIwA63eKxIYoQlqinwlYiiPKh
X-Google-Smtp-Source: ABdhPJzQrhbnl6q5d88XYxVJ2SDt2acFjbzYFNmTZC7RiLUV2Umt6AF8ZOyXVDdRcQzGl/XNojBPbw==
X-Received: by 2002:a62:5a86:0:b029:334:567b:d80e with SMTP id o128-20020a625a860000b0290334567bd80emr21479115pfb.44.1626728601684;
        Mon, 19 Jul 2021 14:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:a880:1:20::1f:7001])
        by smtp.gmail.com with ESMTPSA id i8sm390396pjh.36.2021.07.19.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:03:21 -0700 (PDT)
From:   Wende Tan <twd2.me@gmail.com>
To:     arnd@arndb.de, linux-arch@vger.kernel.org
Cc:     Wende Tan <twd2.me@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: Move page table config macros out of `#ifndef __ASSEMBLY__` condition
Date:   Mon, 19 Jul 2021 21:03:18 +0000
Message-Id: <20210719210318.1023754-1-twd2.me@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move page table configuration macros like `P4D_SHIFT` out of
`#ifndef __ASSEMBLY__` condition, so that they can be used by assembly
code or linker scripts.  For example, the `TEXT_CFI_JT` macro in
`include/asm-generic/vmlinux.lds.h` needs `PMD_SIZE` when Clang CFI is
enabled.

Signed-off-by: Wende Tan <twd2.me@gmail.com>
---
 include/asm-generic/pgtable-nop4d.h | 10 ++++++----
 include/asm-generic/pgtable-nopmd.h | 19 ++++++++++---------
 include/asm-generic/pgtable-nopud.h | 15 ++++++++-------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..a3de2e358ebc 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -2,17 +2,19 @@
 #ifndef _PGTABLE_NOP4D_H
 #define _PGTABLE_NOP4D_H
 
-#ifndef __ASSEMBLY__
+#include <linux/const.h>
 
 #define __PAGETABLE_P4D_FOLDED 1
 
-typedef struct { pgd_t pgd; } p4d_t;
-
 #define P4D_SHIFT		PGDIR_SHIFT
 #define PTRS_PER_P4D		1
-#define P4D_SIZE		(1UL << P4D_SHIFT)
+#define P4D_SIZE		(_UL(1) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE-1))
 
+#ifndef __ASSEMBLY__
+
+typedef struct { pgd_t pgd; } p4d_t;
+
 /*
  * The "pgd_xxx()" functions here are trivial for a folded two-level
  * setup: the p4d is never bad, and a p4d always exists (as it's folded
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 10789cf51d16..cacaa454f97b 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -2,14 +2,20 @@
 #ifndef _PGTABLE_NOPMD_H
 #define _PGTABLE_NOPMD_H
 
-#ifndef __ASSEMBLY__
-
 #include <asm-generic/pgtable-nopud.h>
-
-struct mm_struct;
+#include <linux/const.h>
 
 #define __PAGETABLE_PMD_FOLDED 1
 
+#define PMD_SHIFT	PUD_SHIFT
+#define PTRS_PER_PMD	1
+#define PMD_SIZE  	(_UL(1) << PMD_SHIFT)
+#define PMD_MASK  	(~(PMD_SIZE-1))
+
+#ifndef __ASSEMBLY__
+
+struct mm_struct;
+
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
  * us to conceptually access the pud entry that this pmd is folded into
@@ -17,11 +23,6 @@ struct mm_struct;
  */
 typedef struct { pud_t pud; } pmd_t;
 
-#define PMD_SHIFT	PUD_SHIFT
-#define PTRS_PER_PMD	1
-#define PMD_SIZE  	(1UL << PMD_SHIFT)
-#define PMD_MASK  	(~(PMD_SIZE-1))
-
 /*
  * The "pud_xxx()" functions here are trivial for a folded two-level
  * setup: the pmd is never bad, and a pmd always exists (as it's folded
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..dd9239073a86 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -2,12 +2,18 @@
 #ifndef _PGTABLE_NOPUD_H
 #define _PGTABLE_NOPUD_H
 
-#ifndef __ASSEMBLY__
-
 #include <asm-generic/pgtable-nop4d.h>
+#include <linux/const.h>
 
 #define __PAGETABLE_PUD_FOLDED 1
 
+#define PUD_SHIFT	P4D_SHIFT
+#define PTRS_PER_PUD	1
+#define PUD_SIZE  	(_UL(1) << PUD_SHIFT)
+#define PUD_MASK  	(~(PUD_SIZE-1))
+
+#ifndef __ASSEMBLY__
+
 /*
  * Having the pud type consist of a p4d gets the size right, and allows
  * us to conceptually access the p4d entry that this pud is folded into
@@ -15,11 +21,6 @@
  */
 typedef struct { p4d_t p4d; } pud_t;
 
-#define PUD_SHIFT	P4D_SHIFT
-#define PTRS_PER_PUD	1
-#define PUD_SIZE  	(1UL << PUD_SHIFT)
-#define PUD_MASK  	(~(PUD_SIZE-1))
-
 /*
  * The "p4d_xxx()" functions here are trivial for a folded two-level
  * setup: the pud is never bad, and a pud always exists (as it's folded
-- 
2.25.1

