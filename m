Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE027DAF9
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgI2Vsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgI2Vrq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:47:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32050C0613E0
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so4055531qtc.22
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DIPWfuOfjnS0FLqqhnzrIZ4jlncEeE+o+vZP3RuRCL0=;
        b=jeIjKmg7IRS+l/ui8Q+LF8nOaIvlsjsr5dJcnvSqyimVjw+fgPn/vAjJUtO4XmZBa6
         Xd0TPg2PXsxw8JWRlXMof9WtQxCvHX0ajUKKZHY+h9ZrQj/vHt4kd3uCJRU76eVTlT3l
         qvq/mdBiAQCfz0NkdrERe4By8JjkFVxXJhBvXJYakKcsE9Q3uXpA4c2ihpOBil6Arsgm
         /XRIkE6YivpM0yPirN/ctrfV5AzOopT2G8KpjaFwIzwdIty+tJ9NNd0YLGlPN6mpQHOt
         PZmo5ltSZAvrWwfyVtCxNb3oLaXN5GzVBEfApucjE1oqsSv0iOxejixTaxe7xLdJuwWh
         mCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DIPWfuOfjnS0FLqqhnzrIZ4jlncEeE+o+vZP3RuRCL0=;
        b=CwIQgMqYjepE+IAknVInDL/wcMOYcugv5GPvrHrYAR79z4B41Y6BHHmMHNMOXQmLeY
         VCCAaOiuf09+OgwZL3xPYWPd/Yfc2EOAwruDGwRzgI65czTftXA5swBbUbEyhWPRve70
         OMOv6CsjNTnuzYbsISdbvGVEc/tTS1k61K6AC1ymgYLpnlBl4erzONX+UGdmMbaibb2o
         VQ1prQhgPxKUUbduR5e1ZHMsLMBJYhxE6IP3gz3daMRvGiwQ5ydQA/Nn7RGfSt5CAvRJ
         QDgdZXLfC+xAoFZxr7Ub+rY4oAHUPZmYqNAT13VWeMWOK8aiPPNhYAebHPFsZLFm3xwN
         P+UQ==
X-Gm-Message-State: AOAM531MBFl8h9y05q1XUzA/UGNki+2LFrMtAJqESBYosN2naQYG/fEe
        9yQEj1KmPHtejmi49QE2Y1Q5i4hR75dwf+GX+CE=
X-Google-Smtp-Source: ABdhPJxh9cX/NQWJyeaf5NLdRHxlNrjwWH6kgp9BcYdpdAAl3zdkTlK7VGeQKrVU7UdbXnmP9NjmecTJ1e08yzk/vjU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b308:: with SMTP id
 s8mr6728794qve.16.1601416048309; Tue, 29 Sep 2020 14:47:28 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:26 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 24/29] arm64: vdso: disable LTO
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

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index e836e300440f..aa47070a3ccf 100644
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
2.28.0.709.gb0816b6eb0-goog

