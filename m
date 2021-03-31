Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2875F35093A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhCaV2N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhCaV1d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86632C061760
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l83so3641862ybf.22
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YGJePCNXceByqZDSpRB0j7cl0450LnSJo98Rt1jHcOo=;
        b=UKPRZLEVzQZ3FHZ8QXJYCx4bJrAbgSI5gphfsVy9Eh1BZdT2ViP6pqHMKIIiVfgLu4
         /gi1KUU5U2+ZkKwNjqjYEauBXMhyzaSePxCZZn171LdZoYhov4+U6PkkZu9CI0t9VE/g
         EcO6T6hhaf/UW1kedb1b3JSsszfVLrEJhTCLBirrO1Sv5c7XmHwbUaDImN6AyVRm9sC5
         J+yHAq4xdOdlx2p9fxnW5OfqPxrdOhlT6KJpdZflXru7nEv1aCTjAwHr1fD1LSJrpxDT
         Po9hlnSXcQkFp6fw0Jac0NpPJzt8tzOpYjDqVdhCzOoPiSuJW5f5frOQhykp/SJ/gkA0
         Eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YGJePCNXceByqZDSpRB0j7cl0450LnSJo98Rt1jHcOo=;
        b=K6fxYXxW+wevqGgS5j6p7LF+gejaalFHNQe4LwKtxVqH2C2rdYW4wENW3TM+5N9Uxb
         ohBeBoB0AMVVmFViP6N10BpcGTa/9Y+Qkl+3CqxcuDBCRq5BS/iKvvSFQlOO2PAsQYLm
         oOqafE+CxaX8c+3czrVEAqSYaw0t45QCaxgFMu78+3L5qVClrwVeaaRFy85ejUMuVH0p
         OJ8jH7lnZRC53iKUqVQF24mGSDojG/HJrIz9paiewR5hOZ6QXZEaqRsq8vlw3W/g+Vbj
         iaYf2mmr+kCvDX5ZN+IKAZkEelxPdx39rcogvb8nM5jHiZUtWGnuwh3kcjVJVHch13z6
         br6A==
X-Gm-Message-State: AOAM532F6nlqLKHuyM4X/nj5vBmevxN8Za+GksWj9i/iQ8Ov/UC6T3hG
        voVpVXf/ZMoSmJIHj0GoZXLJ0z7dU0o1KAtSvUk=
X-Google-Smtp-Source: ABdhPJwmO9kJKbm2q20e0oNRMu00heZHbCRG+dyo78LV875MSN1mKqcPNV/crmv9eoJDAI0BL3m/hxc31xh13ueKjrs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba87:: with SMTP id
 s7mr7123638ybg.222.1617226049790; Wed, 31 Mar 2021 14:27:29 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:07 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 03/17] mm: add generic function_nocfi macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses
in instrumented C code with jump table addresses. This means that
__pa_symbol(function) returns the physical address of the jump table
entry instead of the actual function, which may not work as the jump
table code will immediately jump to a virtual address that may not be
mapped.

To avoid this address space confusion, this change adds a generic
definition for function_nocfi(), which architectures that support CFI
can override. The typical implementation of would use inline assembly
to take the function address, which avoids compiler instrumentation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..22cce9c7dd05 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -124,6 +124,16 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
 
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
+ * instrumented C code with jump table addresses. Architectures that
+ * support CFI can define this macro to return the actual function address
+ * when needed.
+ */
+#ifndef function_nocfi
+#define function_nocfi(x) (x)
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
-- 
2.31.0.291.g576ba9dcdaf-goog

