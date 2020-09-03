Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BF25CA80
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgICUct (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbgICUcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:32:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08388C061264
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d80so4113408ybh.0
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=v4aEDtr6bLZLPmR/ra6D5NVXgPqHTR+q2+p+53rP8YU=;
        b=d3WTta769MJh+Bo0VzFx1dIubRn1F3/0OsgdvpRIABs/0F8aoQ0QxN6GC6ogiN8YAt
         1n2fy7ycG6neE8i4JP6mcoL5+gOWppxCnH2U8kbhGmk3Ke0U/7qP7lute7a6H0uDoYhQ
         dWVIqp9Xjw2Q1WEklB8eqrGPTTy0VYDaAb7Vj5vkDxGtzwmgFWOj15UwJBAbJ05tl1sN
         Q4rZl0DzGVRAuAw5PJyrACjWBxr1NbGCE0oN5TR+pUi+Dq3TH5paoF63RYX5l7QEOrpB
         +a+BflxQgXchm/xsTBNIInkXUZW2NMgvFiHC7w8tScjlytwkaK3yal7TbaDvFzX+VZKt
         2LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4aEDtr6bLZLPmR/ra6D5NVXgPqHTR+q2+p+53rP8YU=;
        b=exx+JjNVXtH9KUwGo/zo2L1/2BZ9z0mi7Vg2N3myXm+uVU4p+ZxolwRjc5lfhm18ps
         V4kXSjXhMB0yltLIXdZooDDg5SN58PmMkA0BYZt2uUzhW6bdPiWeTo8XPvPq7GPHObtR
         tAk82VHU+6EalcpLBvzd3dwc0q916WoubPlml9bJxtSwSQJ1excMzEegiro+H6qXWSbG
         xkpaX16J+rn392gRQ2B4VlBd9ZGJG/1YGKApF8R4lYdOzlmvZlKDgzWwhh9nRRNS9dtI
         7IDOvrRukFspTTm2/ftWSd5Y2TmE5PWV9ckYhEjmYkxmaCj/Wpifs/yv28GEwO8w6MCc
         LQHg==
X-Gm-Message-State: AOAM530xl6+wukH6PYk6j33nXuPLSxRLrKcCUBY+bjB558HyC982wRaS
        iR+d5meVWwWw738IF6cz88xhs6QnPG8fH6TrZ7E=
X-Google-Smtp-Source: ABdhPJxLcteMiXx6yxIAtF7C6LDsd43v+S+v/BljrbTvv0EuuMtNnvGzhvJa2qGTBh5Tw0uOlOWuvZqeImKd2fr7SwI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:a366:: with SMTP id
 d93mr5081717ybi.415.1599165079173; Thu, 03 Sep 2020 13:31:19 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:37 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 12/28] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 2752be67b460..c69e07bd506a 100644
--- a/Makefile
+++ b/Makefile
@@ -917,6 +917,10 @@ else
 CC_FLAGS_LTO_CLANG := -flto
 endif
 CC_FLAGS_LTO_CLANG += -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
+KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.402.g5ffc5be6b7-goog

