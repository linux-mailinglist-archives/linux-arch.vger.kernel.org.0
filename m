Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0250527DAF4
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgI2Vsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgI2Vsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:48:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059DC0613AB
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b3so6378327ybg.23
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YnFARiKS6UDkwdk7WP0wlvbxlnuyKDZd5kTTgvwZzNo=;
        b=jWS8iUHI1yEZwlx3KeKvcgfGPXNdJ4L5onYlC3CBBL8D7obZFD5GHWOijlDtJb8Ij7
         nRmkWkJefVtEgGfyFLejApsO2VFmeAT9vQpKzbQWErmeV2XzN2V7GUaE7Pe9GHYQRqUr
         Xv61qqqbIr/UD4HQGH+NeCWqUBIaeXjzSEj5haCz3bHxBeyeFilgtE7h3SBO5qI9TeFI
         VNBOjzf+qN4PzKeK/ip+sm+V/3xF7iAcrvnH3Y+OXfQISp+lvRlaGKxv9Vs2X9cKIOs1
         +Egn3AASlwiipmUBXQC2SS1FvIyAuimNGXi91NcEG22l5xpotuSePeSMxIwf0qHe6n0r
         39pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YnFARiKS6UDkwdk7WP0wlvbxlnuyKDZd5kTTgvwZzNo=;
        b=FNJbum762bF4W+nHx6Dt2bVlPsEZydx5h671tKvJTXmX7Ts8FSQ1D5TdvgU45WTNJE
         anSC3fmok1gvg6QgUxfK+euMpo0xNy2IGClDFiWMRf8w/2XIlrXJaHNnmiw2k/rqQdPq
         QG2AYZh9AhmIhBJdG7VjQSXEqZfuuhTAn33fMqyRu6+bDHqScssI6ulsmVrRrKZvoJ6+
         cqXNLfhsZqmfjWG3i7yalVV0v1frD4vxwQxb2OLmexzuH0/zCAEFiK+pFSO0EpnP7a6M
         Wpc8jVeQjcv4zAZRWWzuMXSBQRYRfQBWt7HcmAEXeT9anhVyLKP6CfbVDk04JYIo8UkC
         mRXg==
X-Gm-Message-State: AOAM530hfqFYf1ifu80zNTSZbYEVCJFD40ZxAPCEtx7GubpQDo2L8l3J
        cfd3MraQyXynBkoUx8CmeWAZhBgBX+5Kpm/xnoU=
X-Google-Smtp-Source: ABdhPJxYhSRNOkwgDRc/l2C7Jl258wmN5ml/1qkiBHZtQEnR2mVC77q0+39UpprEXaMpqtbM+otlfoYoA23IDmqOt+I=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:ae9f:: with SMTP id
 b31mr8477359ybj.437.1601416057863; Tue, 29 Sep 2020 14:47:37 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:30 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-29-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 28/29] x86, cpu: disable LTO for cpu.c
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

Clang incorrectly inlines functions with differing stack protector
attributes, which breaks __restore_processor_state() that relies on
stack protector being disabled. This change disables LTO for cpu.c
to work aroung the bug.

Link: https://bugs.llvm.org/show_bug.cgi?id=47479
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/power/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..5f711a441623 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -5,5 +5,9 @@ OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+# Clang may incorrectly inline functions with stack protector enabled into
+# __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
+CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.28.0.709.gb0816b6eb0-goog

