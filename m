Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB83207D86
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406695AbgFXUey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406476AbgFXUdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCFDC061798
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:11 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p9so2444943qtn.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BYARsb6kk5gBajh2Z9y53LZQA7+hhrma13n1XSCdmOU=;
        b=VR9flySjUJwP/ToHZH5/xrbg3xtifUP2l8XzNOwvghrmkrOPlt0NBT0Anzq/fEaIeF
         KEoHKkAEPYQr1ae9axGCAMJQRNQ8Zn+uof7PhiL9L7JyAKcAQBsmFp+OoG91RU7+TJkG
         Yd8jJUh3wkbN8zyU9bxEpyOLO9sldP4qCwirdkQYZ3Ena38i/lEtgSWPv5cRv7bJRl2N
         UiX9uZX38aM3TP9J7+dUEiU2tJ3qLNH5BAb5fEeb58kPFpZiXEQBsf9meYLOuEa3jWcW
         FzXtiDx3izZRRi7FrJm7yt+UOltEWjza1vZCyR1pwcnJuQrqqarBC6T6qstSc9SdhCTJ
         LIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BYARsb6kk5gBajh2Z9y53LZQA7+hhrma13n1XSCdmOU=;
        b=Rnt4IF4DGM8XTzqW6qiJEYFHgD0sJ2ia/LO/LPL7atdXNkNY/Tg0t5kLBsQzpdzyT6
         uxYrLuN3VqT7RZ1l4oRbs+jrjeG18WLXkTgDJSGjxZ+mJzMn6rzDXlTVRUyQfFV2rrG6
         I9qLbT1/dFnY4ADqn7WvQcCnVGw2Wr3nc7NUdapUVm08GzPxi5tTho6Lvnw3oLZk9rT4
         W5jii45BLzBXmBSbhR0mDknmbP+b8h+i+Fk6Lz25lQRxDf5ehKrDjastKtyxKObL6k3O
         tNvjkxbP74X5EISlE+MoHw6NjnYc2XGM3CYFxzKMHxWVPbI5MjX7mScMncN9br4nNABx
         orjw==
X-Gm-Message-State: AOAM530iDPvBhPiGlcdpoKw2PhotIY1g2OBejgsfonM3U/9pk3AZr2LB
        kb/SDhWKf/YriudBcyrjBna2OpAM/e1/rEX7YEo=
X-Google-Smtp-Source: ABdhPJxdPEjdTvmHsLqQfGRhGHv9oPLaWCC1GyywhBzfg/9OiO3i8xn63G4zB3hyB9DGHni9+sZkZnE+i9lcXDX/20s=
X-Received: by 2002:a0c:9d44:: with SMTP id n4mr20638647qvf.35.1593030790865;
 Wed, 24 Jun 2020 13:33:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:45 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 07/22] kbuild: lto: merge module sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

LLD always splits sections with LTO, which increases module sizes. This
change adds a linker script that merges the split sections in the final
module and discards the .eh_frame section that LLD may generate.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               |  2 ++
 scripts/module-lto.lds | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 scripts/module-lto.lds

diff --git a/Makefile b/Makefile
index ee66513a5b66..9ffec5fe1737 100644
--- a/Makefile
+++ b/Makefile
@@ -898,6 +898,8 @@ CC_FLAGS_LTO_CLANG += -fvisibility=default
 # Limit inlining across translation units to reduce binary size
 LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
 KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
+
+KBUILD_LDS_MODULE += $(srctree)/scripts/module-lto.lds
 endif
 
 ifdef CONFIG_LTO
diff --git a/scripts/module-lto.lds b/scripts/module-lto.lds
new file mode 100644
index 000000000000..65884c652bf2
--- /dev/null
+++ b/scripts/module-lto.lds
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+		*(.bss..L* .bss..compoundliteral*)
+	}
+
+	.data : {
+		*(.data .data.[0-9a-zA-Z_]*)
+		*(.data..L* .data..compoundliteral*)
+	}
+
+	.rodata : {
+		*(.rodata .rodata.[0-9a-zA-Z_]*)
+		*(.rodata..L* .rodata..compoundliteral*)
+	}
+
+	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+}
-- 
2.27.0.212.ge8ba1cc988-goog

