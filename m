Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DAB2706BC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRURE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIRUPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA4C0613DE
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:14:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d15so6781117ybk.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TOBnIZLn7hTmqm3x2JBReVnrcc+31akc4aFm1uMW9E4=;
        b=kOFoCTd2FrUUKnCgnEw8fv7o1qa+wmfRKSJE7DESuzOriLdT6KRMVuJelBjZTPWmjv
         hcDMZ6eRTe3iEYXYYraJYirqopgmczBB1BvP5hOrngWEf/fJbpBz7Sj2ruTbsoRETl29
         O7E7brX0kO22gIX86Vdn9SrCa3mebEscFAw0lojJhTqtnAkLGvP02ofXmERBjubIHHQK
         t7UD4ZZSX0u9/8uvxMAjisPSz3BRkcsoaicvmVdgo3PttZXSpnN03wSqMqeZkfmkBk2J
         sEFprVm9QM8nc23vRgjZ+UPh4svXmTbLma/ZToJN6dcDACCd3xjRpcEHrZhhhibZCAUO
         2qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TOBnIZLn7hTmqm3x2JBReVnrcc+31akc4aFm1uMW9E4=;
        b=nKW6J/U+cDOwfK1cdBnpbl/kAd3upYo/m1+y075aQumE0eKZY2KZRarhtwvx5u58bT
         4KPj5Lv+/5prmD72+Wni5D4Rt3VrvLFuk9GKTo7P/q6ogelrSbeW78MkwRRBBWQ/GJOQ
         q8m1KdRH2DKvHzr2hAqYU0Q1oM7pWkKLmv6luDyjaUCxvZWe3OJHB3R1YUsgtdGato4l
         LpYx1iycymNH6BB8f/1U7HbbxAtij/R0M1SugM0RTzSIl5Ebi7moltemDKJ1P+p8L5GS
         ihwfkYoDsvhqrQrGk5NO+ZJWsN1XYdjVhQKO0aXgQReHk6vdE5eGK2zMskZpdmXog1eo
         Oqnw==
X-Gm-Message-State: AOAM531NeKEn7eC2oE1+3D02k4nZ2NBlhBQXr2WltSDIN7VcNdwpucVK
        V9mCBmaicffu+OFnYWaFi7CQkYnsZXkKHj5XqW8=
X-Google-Smtp-Source: ABdhPJwPfv5GKIky8nZ4/qO1HfgSl+GRdDXQT/EDjzvo193fwzx6dbwv1k7QAc3pOuPuB6s1Frhn6PBXdOnzsCVgbLU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:be13:: with SMTP id
 h19mr55802534ybk.50.1600460094899; Fri, 18 Sep 2020 13:14:54 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:13 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 07/30] objtool: Don't autodetect vmlinux.o
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

With LTO, we run objtool on vmlinux.o, but don't want noinstr
validation. This change requires --vmlinux to be passed to objtool
explicitly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh       |  2 +-
 tools/objtool/builtin-check.c | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

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
index 71595cf4946d..eaa06eb18690 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,18 +41,10 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
-
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(check_usage, check_options);
 
-	objname = argv[0];
-
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
-	return check(objname, false);
+	return check(argv[0], false);
 }
-- 
2.28.0.681.g6f77f65b4e-goog

