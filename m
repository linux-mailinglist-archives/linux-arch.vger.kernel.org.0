Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1AC2B8747
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgKRWHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgKRWHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:07:44 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3640C0613D4
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:43 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u19so2531060qvx.4
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7xcmRRx6qvqOlAhBXvPUxdlcJiFGDszFPn6Uy8LsYGg=;
        b=JUEhAG5/26jx0k7UneLL1f8TdMXEdBCuTZJVLjQZ+iZWRpM2bbt0EXRlMyK8xh/rhj
         JL4aCETLnrd/8DvtoDDkLX34DHCsBE1h9hQQTOHP3TNRNJUaUtVu/5oPiKBq0scCRP6Z
         +kh1Oyf9NPyMM2Lo7bgcXU9P4bjc/YYA21H9WcxDydQqHpZaclET/mWLe+Q6TCvtF3wo
         mKxhKgjFnSmEhpPgl/7XzG7iiLKXi7xIewYjRRnbWXMkQNf1t/hl5/7hnFoxRkDw2MOb
         rVfAfcrlGtLV3PMRjEVyZEJWFeaaAKgzOew1LFSh6KyTd7yH/s0nFEbQGjmL0toalfsR
         lLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7xcmRRx6qvqOlAhBXvPUxdlcJiFGDszFPn6Uy8LsYGg=;
        b=cTZChEovRbJWFGyn9E4SicZ/eeKGoBMXUhS/g+P2/65i/Ywp0h2GI5vZ7mzikdJC6/
         HZ+Tp+GpNA9/RJYMKaXz4iyXga6u39qxpOJuRZk0D3H0m9GzqYnJ0P74BTcuOY0B21Q5
         3vsXrknf/M4POzphxHm5WUEMEBj/CYhJ0iWrVTQck6afofCwyu1FjxCSEkwRYkIQXgUG
         v3e7C2haYL9urbzsCLZSQEWRmGP23W4IpzYqwDzi1NQj0o+An0ouwOuc3Ky8tijqMiQL
         ag2YBwo7TvmuerfcPuCvg3FvdQJKSKm3pvdWFJs1MWiknaA3h9thuz0Eb5GuUi23bpZ6
         +JVA==
X-Gm-Message-State: AOAM532NSVFi2cT7z8EDuoNyh3JLBsLG7y3cHo0Rtewtg9EJg/mbb5o9
        joKKk0s+f1zlAJWM91oeFA6i+8avK1fMqeyNGV4=
X-Google-Smtp-Source: ABdhPJwZi43l7NEtfrn2Ph6B8PwX83axN27eYs3bBjDKHIbJhot79HMgDc9/Lz03zP5kBQUcskAGDJr3yB94zqzoXoQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:8004:: with SMTP id
 4mr7501644qva.5.1605737263123; Wed, 18 Nov 2020 14:07:43 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:19 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 05/17] kbuild: lto: merge module sections
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
2.29.2.299.gdc1121823c-goog

