Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9605A28C5E1
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgJMAc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgJMAc0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4CC0613D8
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x14so5803902ybg.7
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8bp3PQ/7kK50N/SyZEDvRd1Vp9NoLqhW+sLCA5D6N8E=;
        b=UJ5mCWL1fFmQ+PxULb9p87s0nqFxM+BepZ4cTj/3K/9Rl3+R69U63Qoo7kbjpQJmLF
         fe6htCxpHb5pvdMiMW7w4jfVTIc0MjpjYYrgO7qtJrxEcZluiiuQ4CilOc6suei2x16J
         ZyAV+xCVkwBYu4Ypv3PNkoRqnUEeD3oVuV25mZ/ZMBu+EeLJ8WEFNae5g2/awFDSCZgp
         hbWfhNOdCEgE4Orq6FyUsLEX8fGkRh/PRZNh5ngDsRLmToIgltIDpU1+UVeeaBKUU/SH
         2G0ccI3U01Zj6y5PdlF4BC4DIc7g6ih08EXhvn4pV3U8TiwtHluquziLm/T5nfcBgQ/A
         E3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8bp3PQ/7kK50N/SyZEDvRd1Vp9NoLqhW+sLCA5D6N8E=;
        b=f9+Ma5yVHaeal9Kkh0+qMu/2/nJR2COmh/b+1hCyEjpsLfncOTwbmC2KzvnFEgbKBu
         bJYn2Hv/Ps8bCdaeWeEblBgWMwmUF3/n6OlrFWwE1aMSIQxacBCR6ble2a3ShKM5ArDl
         fnul2186oQB7/MGyNnVaOLZZoMEO9tN2wTuQe4D3ylhkDmWei0kh7yP3WMw3DEzFbvDJ
         2Kts0dOLX+qsbPXa8XHy6pfPJfkKHwsKYt8us21CbGFtKdoBRv6uXLdCFG0QQ5Ov98AK
         ymNwnUTPxQR9wiKir2feBgb6bHjuqCEIv8WGp/pmPnjdzIL/pPih489KgA32zfXxcwJr
         MiKg==
X-Gm-Message-State: AOAM531sODz6R4lFtBRT3zuPUpUYVhtqFCL8rGF/G5nz6sr6o/ouzWNu
        1Ucsw6QVycBqr5ieYrGZZyBieUWKkzvuAmMaDIM=
X-Google-Smtp-Source: ABdhPJyaKJlnl73Nam7qP2rlTKBQqyq7hNelqtAXX2QbINkl92Xg8gdjjbAPMWIDS85cwQxWAerS5XsHH4+zdwdv4nw=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:5f4f:: with SMTP id
 h15mr34686955ybm.407.1602549145672; Mon, 12 Oct 2020 17:32:25 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:48 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 10/25] objtool: Split noinstr validation from --vmlinux
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

This change adds a --noinstr flag to objtool to allow us to specify
that we're processing vmlinux.o without also enabling noinstr
validation. This is needed to avoid false positives with LTO when we
run objtool on vmlinux.o without CONFIG_DEBUG_ENTRY.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/link-vmlinux.sh       | 2 +-
 tools/objtool/builtin-check.c | 3 ++-
 tools/objtool/builtin.h       | 2 +-
 tools/objtool/check.c         | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1a48ef525f46..5ace1dc43993 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -92,7 +92,7 @@ objtool_link()
 	local objtoolopt;
 
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check --vmlinux"
+		objtoolopt="check --vmlinux --noinstr"
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index facfc10bc5dc..b84cdc72b51f 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,7 @@
 #include "builtin.h"
 #include "objtool.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -34,6 +34,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
+	OPT_BOOLEAN('n', "noinstr", &noinstr, "noinstr validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_END(),
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 94565a72b701..2502bb27de17 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c39c4d2b432a..c216dd4d662c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -244,7 +244,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (vmlinux && sec)
+	if (vmlinux && noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
-- 
2.28.0.1011.ga647a8990f-goog

