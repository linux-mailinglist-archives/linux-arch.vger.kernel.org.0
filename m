Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41872D7E9B
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406217AbgLKSso (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 13:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406079AbgLKSsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:48:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD5C0611D0
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:46 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id o17so7102639pgm.18
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWPxRCPjFejanLxpgRG3fapg45p9YOPZWT66lZNPqfI=;
        b=NmW10Ys2Tgg9pvNOzRC87vTxzQN/QNTXAjHd7AFTV8ok00h9tGhhYMLsRuxKeNhXDl
         iMPagwzzegEY0NAWkP8VdeyEnPICgOM5AE4FTcCbPPAinuDjGz68sbCLgXPYhkRq1Pep
         /oDzt2sWciOe12Hb0BMOoaCF9qAfZgz+jdivhEhkTAz3ohV7gcdM13QrPXPixLmDjCSe
         nTPKcCoKQq0gq3xcii2Dkj1W1xDXw/X3VKykyVsM1VgUoEe62p+1hemZShAFUHpH1Tsi
         8OfLqN3hCowWbgVvrwWk8fm6stKJ1NblXBwjNE+NVf/Ofnn3fkAOASnNgDC94IzGVftK
         2nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWPxRCPjFejanLxpgRG3fapg45p9YOPZWT66lZNPqfI=;
        b=cyHTiIaUu++SbR7RA3J6en1h2QtOh181O5bKoN6CRfYXXSQ4bScEz9q0vZYXZ3rTCA
         FXJ4cxHUTK4h2soGIWDWP6B/Sva/VCbpUmFjwxz/8VSO0+CjRF7udLzL2Np4fmUlB3ND
         Q5/Dpz8d2zP2IuinLhY+lH7/yvir3uFtYV/qQJhx5VnKB7mPe+hiud7gfSPqvpqCPJH1
         aKtA9qbkfDq0Pm97YIKo2Epu3aO4Y7P+Zsv6onwazgAYqAyJOtzvB7wUvVzPR7SEZXLa
         yB5nl0C6xQ67yKU6iqMD3kEqn5I0mS2I9/l7PztrOfLG9AaSVXaUHI6xSl7cLsDWlS/c
         DoGQ==
X-Gm-Message-State: AOAM5319i+mF8nE+2D0DDa7LHjVLkpr+T78HQ8+dfHghmgGKN2efipXi
        L9xeABLhyRX4zXQY/Wcig60LZnLHYiHvvhbqeI0=
X-Google-Smtp-Source: ABdhPJzm7bBo2qDvtUgK6v6rrLGQ/0dJj/ATzhcF3Fgu3P9N3k/LVow1+5c7Y8w8YkEUkh1r4Djckvq7KIZM8TNXHU4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr136813pjn.1.1607712405109; Fri, 11 Dec 2020 10:46:45 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:22 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 05/16] kbuild: lto: merge module sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
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
 scripts/module.lds.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 69b9b71a6a47..18d5b8423635 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,30 @@ SECTIONS {
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+
+	__patchable_function_entries : { *(__patchable_function_entries) }
+
+	/*
+	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
+	 * -ffunction-sections, which increases the size of the final module.
+	 * Merge the split sections in the final binary.
+	 */
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
 }
 
 /* bring in arch-specific sections */
-- 
2.29.2.576.ga3fc446d84-goog

