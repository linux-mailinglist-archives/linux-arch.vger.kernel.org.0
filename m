Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C11288DF5
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgJIQNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbgJIQNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:13:49 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF30C0613DC
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:13:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w189so7095455qkd.6
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U9AWLI1l8Wt7A0cF28qGkPASeONcRk66Flk+7SBLZDk=;
        b=Cs8QGabJC78gMfxCfdvLPfCPnCBG8mqCKPXEuMCN2NC6cv08XQMiyI4smlwEiGiNII
         K5gTrYd24O0LiqamFF0wMr7ffmfDahQ9HIbIV6xVeWfcY4n4loXTL7qB4SwSDhaTv22i
         JczK/qDFNcSAT/rGSksO53/MTogKRMrT4041PX2tsxI6Ol1/yOYMbOF5s0gzKJQaLOor
         yww9sOX437QtKLvGDUEhwKcWSCy/hihhvRz4D2dTrLX4XDXEq0a/ORKzM2aJL7PziE+Q
         dfJ53ml7GAYdcnN7kTVctFYRDH3JwtUPDTivWPnwTUWriMtoL1NC1u8waNqdhrkRHmX2
         5NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U9AWLI1l8Wt7A0cF28qGkPASeONcRk66Flk+7SBLZDk=;
        b=oPo1lEr/mPNIrurJtsbWnvfDUfKF6cwTbVmnmucVmdzjDrlXBv0qI3/U+r+xG7GgBS
         zXvXwweZ+MT+xbnpNejEe6Ik6s7tmVzq9dZOftAt9SBtJ3nAqFKl6/aRH7Y3bcYq/uLF
         89kIY1TZJMg8hh/ARiFstFqVqwmv62Zs7rCwJRVveR2QuRRs3ZkkqRJyzpWnou9iTAK4
         bRfnuUckRkN3Y6larAqh283W7fGgxZfngfwgGGXlnvIaiD0n8mUlQeyi6kIzOsGmsvEm
         hQTCGUtE02qImtNY4hcS/mAyerg9uuDq3/j/2rwqsjKAMfansmiu/xc9rjCqQJuRAOU+
         jfCw==
X-Gm-Message-State: AOAM530aOW3El3SK+RGiaDoor3ubhSEKMvP8QLgBXIJtsyLLwWCD1gVz
        Vp5VMM6p3XE2f4AxXd01rb1DIXXL551HrbOLmlA=
X-Google-Smtp-Source: ABdhPJw4RMWV15gzdZdV2Vo6jQV+j2a4t3/6R15rRlHdwc/PJqRQfP3Xi6A8PE05kNsUfa7/hoQh3uRP5EnfqZb7Aso=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4454:: with SMTP id
 l20mr13954751qvt.49.1602260026976; Fri, 09 Oct 2020 09:13:46 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:12 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 03/29] objtool: Don't autodetect vmlinux.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

With LTO, we run objtool on vmlinux.o, but don't want noinstr
validation. This change requires --vmlinux to be passed to objtool
explicitly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh       | 2 +-
 tools/objtool/builtin-check.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6e2d9e5ff48..372c3719f94c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -64,7 +64,7 @@ objtool_link()
 	local objtoolopt;
 
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check"
+		objtoolopt="check --vmlinux"
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 6518c1a6ad1e..ff4d7f5c0e80 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,7 +41,7 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
+	const char *objname;
 	struct objtool_file *file;
 	int ret;
 
@@ -52,10 +52,6 @@ int cmd_check(int argc, const char **argv)
 
 	objname = argv[0];
 
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
 	file = objtool_open_read(objname);
 	if (!file)
 		return 1;
-- 
2.28.0.1011.ga647a8990f-goog

