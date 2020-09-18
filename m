Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF879270652
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIRUPY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIRUPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:14 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E86C0613CE
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:14 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y17so5577389qkf.15
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sDhFGpvlf4HylY15zQIKyDPQxuNLHaPJE4lahmB/U3o=;
        b=sk1n8gFBPt/lpLBQ+GOEZFF5kf8UOnntxOTB32HnkQWAWrSaStYhtRE7qWdbcSLxg4
         Gg9GXRGdMLUsdCB/c8c7q8AGDDfB/5JLmacB5t9QnbyA5wUTdMVAdy75TO8BlVneBzVp
         lSI/Cl7ny5ny1K6+J3oitNwzfaSptJ76VcMWpOgVfjxm3SIpHxo4N7r4B3FBuFcxcDvy
         /qw4ESM9nEFmfuEfRVkLCqb7J/wr+gTYbwx15VUb419uhouvZ7OLiu3JBT/XiuB7nklt
         UMu9qGA0f4VwicJFQUJEGU3naFOTNsTQSVhBYOgrLyZldxhatmDZWt2FeBBqcQGwQmbr
         piUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sDhFGpvlf4HylY15zQIKyDPQxuNLHaPJE4lahmB/U3o=;
        b=ZcF+vUeZopGHJz8wNQ8HSvM2bN30XajFwbzkCyUXRmUiIO8Hv1zRSh1R3hfyqzttZ+
         uMMa411uvSBCKdBskF+efGBLjHx0Eo4X0BoIkGYSHQOuCoM000V2bhQkiRgI6J1jOzHj
         MqLjQoa+lcXMvMmNHLKSW0NMTDwUJfSrWbvR/4KiWMxPmKjmEdwgH8JvIa0VRquD0Ge9
         V2VMPFqeChtQG//4cgEuS3UUa2jN5WS/lzEDbv69/SyCi0UC/CdqGJ37sfrMJ1AND2K/
         Rje9/hMGJ74S2qXk1VyaOnxz2LR625RbnJ42H34fj9FykNXC1aTYThdw66zJvYkIeoBl
         Gs3g==
X-Gm-Message-State: AOAM530WFF1KyHmY1ZxnEOIqN7pYmxWh3aIq0b1BfxHyrzQCYSMKHcgb
        PNw8NBSNIIV4m1MCcTndtk4wsZt77PNogqc2ANI=
X-Google-Smtp-Source: ABdhPJzcLc2Llf2NYvBudjp2BIXvLbxitZeqdCSBF9rMkMxLi5VdEAKNXht5tAMiNUsnOx/RDEKyI2Da9coZSC3R4XU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9d04:: with SMTP id
 m4mr18731516qvf.50.1600460113739; Fri, 18 Sep 2020 13:15:13 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:21 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 15/30] kbuild: lto: merge module sections
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LLD always splits sections with LTO, which increases module sizes. This
change adds linker script rules to merge the split sections in the final
module.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/module.lds.S | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 69b9b71a6a47..037120173a22 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -25,5 +25,33 @@ SECTIONS {
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
 
+#ifdef CONFIG_LTO_CLANG
+/*
+ * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
+ * -ffunction-sections, which increases the size of the final module.
+ * Merge the split sections in the final binary.
+ */
+SECTIONS {
+	__patchable_function_entries : { *(__patchable_function_entries) }
+
+	.bss : {
+		*(.bss .bss.[0-9a-zA-Z_]*)
+		*(.bss..L*)
+	}
+
+	.data : {
+		*(.data .data.[0-9a-zA-Z_]*)
+		*(.data..L*)
+	}
+
+	.rodata : {
+		*(.rodata .rodata.[0-9a-zA-Z_]*)
+		*(.rodata..L*)
+	}
+
+	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+}
+#endif
+
 /* bring in arch-specific sections */
 #include <asm/module.lds.h>
-- 
2.28.0.681.g6f77f65b4e-goog

