Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6742CAEE8
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 22:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbgLAVjh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 16:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390151AbgLAVje (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:39:34 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98085C094261
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:45 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o1so2290073qtp.7
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=ty5f8H7kzpU+lvDsHXGI++1V0wurJB7DQJHEXEwufmtrCxIRoiPJOPP1X/3lLsz1Jb
         yjTR/AGDyQQn3kRjvvw2d88GiqDY8VcvMWomB5DuCrtNFFxHuktvMeKvMrFz+Xfk1Q77
         MRmeM7k7VctuQepKTW4pproEuOE+zIwcrFORj2gPW2IlyOU7IhN8JpWoK+mpfeUx5C/d
         ojaTkHbYjh10G7mgJCJekN588v9SPU5sVPQSTu4fzbRdcVzLgMGzXyAyI0u1gJhvAtr+
         L9s0tFmZLbeuu51bgQUHw9Ysitz1s+n7ja3zUrLOpDRRdxizWkaeqCKUaIf410z146BI
         /CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=tzeRQfLRZobKPB6li/r+WNLmYy1SrwITFycQTdaJWhcWWewJ9NKCNIJQvnPGVbpZLC
         HW8rmX+mHjbvWYlvC105lh7dDI+UdPOUJPGAzg1+iqrIIRpDO1IirpRbYSi8s6Z+NQLd
         20QxPGilZshYULIIKTJxRRqJqnSEvJtHOe+1VbjodkJ3bw3IJGUGtBmXHo7bcmZRV8px
         ehkQqtY0JA/YxOcJODIKGKvztXllAFqYgouHwVGSElA3m+QXik4f0LKvoqF+G0BeH7FC
         WAUreMgc2VbhnJvNP51GZeY/2DpCSwSbfcCzJjCHmQ4dr5UnwUJJm1jtef+/vgaZ+YVB
         B7Gg==
X-Gm-Message-State: AOAM530OjyOOh71WTxHQLx5VQMbPCZRphu7RyEuZLGEOe2XHBTmvGrTL
        vAq1jYTYAo206e62/gIldTEyeCjgH2aXswQy2Fk=
X-Google-Smtp-Source: ABdhPJz0uxxT0ZlEK90fhImd7lL6Fuzds0C69/eAFTomtuQ0mN0EZEi1KhWi4R7wk6mCpdkDbecP4SoP9hzTb5uJL7A=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4d84:: with SMTP id
 cv4mr5421264qvb.14.1606858664762; Tue, 01 Dec 2020 13:37:44 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:05 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 14/16] arm64: vdso: disable LTO
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

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d65f52264aba..50fe49fb4d95 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.29.2.576.ga3fc446d84-goog

