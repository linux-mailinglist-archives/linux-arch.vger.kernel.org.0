Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686028C617
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgJMAdY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgJMAcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDFC0613DA
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so17167408ybs.8
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=i0HfMD/wRChzzw+H0j5SIQI+XYlsyfomuEvjB0A2b7U=;
        b=RWGnAnvd5Lp76tMdFpNH1+zuCs711HvTmjeeqWExWdLO0b+IYvl8hseJy7bQVsA/yQ
         WbWgdjz9odSgS33tA7SyJrG23HtPbcQQ2sqTeDLN0z+XNW/U1+B04f29pxuTIBAo0Bwr
         1kuUI0qew0RRwWEdSqeHxrYPCuM0lKcyAQQHVJyqk0NDK5lndU4kJ0nEntK7Gw/b+6ds
         NINAxQFY1xV9pWKvIAxegfc8BATcwAptMc23jyb2HlWegaJKMJtRw94gvpud1QRadkKB
         gA/bzBYbBksOIuoqgqduz/XaFVcQDSEIQm1NvRkC4MArUYBfjsPwupbm8iuKYDaYWWMx
         dfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i0HfMD/wRChzzw+H0j5SIQI+XYlsyfomuEvjB0A2b7U=;
        b=MfqZlNwdN0W3u04pPbyeuDjKlifeJJ99ee6t5lAlwjIIryK7VnC2CQF+6YiAoTVmZ1
         B1n6qilCl05JRkfML7LhmmJUKd9KZOEDsWB2aM5k9yswFqykRTZLKT7/sNAxA+U63a81
         Ns+fddXsxwFln3/UoXsGeEHCUGSoPDrpcOD7DQXe6pBcvmkU+KlQRz6P1/fossURql+k
         FV9cp4AT6GcbLVuDqa3AOcvLNZ7lSgiXR7FgaBZjfTM/jHk2cLhsQaXYavATnSn8LpAJ
         yvoLwUpTj8wvZtui2OG8TsYVsmoLv2ZIs2nfP4XIbVebxGe9e2CCTfLTJwmgyjlJaDTo
         9rgA==
X-Gm-Message-State: AOAM5326z3iNZl/m40Vs/LodowZEe2MLBlOE0QBb/Pkh1kCMtz9hfT5Q
        sZstcw7jbpXw95VlqUWYpRfCwdxv5T6CkZd12xk=
X-Google-Smtp-Source: ABdhPJyWpX0TYRebf3Rkf2Yh1c8ADAskEKEgvpC4cZTbopj2J6pmYFQCkigTg2srbz/p2P1Qt1W0jVbIt5KqdOEhaLA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:cc89:: with SMTP id
 l131mr12649555ybf.154.1602549152704; Mon, 12 Oct 2020 17:32:32 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:51 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 13/25] kbuild: lto: merge module sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
2.28.0.1011.ga647a8990f-goog

