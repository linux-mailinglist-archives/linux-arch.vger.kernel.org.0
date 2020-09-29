Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554A27DAFA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgI2Vsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgI2Vsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:48:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B509C0613AE
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f199so6413501yba.12
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Dx9e+jODClwF/iJJnqk8YtFURfMacOCvss9V22Z0Fc8=;
        b=eAC3sd7FrybIqBNLqwYFttqKxR61Obt0chM7GPqJ2OxngMW62bPdYhZA03LkxasyLY
         B3iIEkAaae/i6FcyaXra7MzsSeTktk9SwvMjM5fm2HSdLmalbA1n/A2LnoW2enoNz2xH
         Pa+KaLqo0+4ezjXKZ3nIXcw8vdNmqiqgTTdM1O4aI1LZoCE0afJrbw/Lg6fCj7Knl79R
         dCZ2OQwKJA3VuP7P5zfT+/aSxe8doPfdOU5zwJ44DkhelW0fuXKUxoxboiSN5Vgcgh8/
         1UpdKZV3POTPW1YqyNWdduZmHvQs7b6iJJF0ZHtHSgHddEocODQ/IaHpeomSTeSTfXWd
         9F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dx9e+jODClwF/iJJnqk8YtFURfMacOCvss9V22Z0Fc8=;
        b=QoQ8KisiN8kCNgcvXGIDuqcJZp9dyoNFetFv4904+3KZOwdbzdXJ8L3Ge/pAJKitui
         U+KuGizkzPoLgZfbSAER3Bn/gfTI22Az5YugC/QrMCjKXTLMgvqgi4U2X/L1vvLSkuxm
         sLMueZpqGCW6jtjchPtDEvxoUHaNQYHpi0QERQanaQZqvSepF31Q8NRAPzxMe/u/E0vA
         eZscP84kP7q4aDHTNKfZDmEImvphgedBUufa9oYp0Snt21ocufl4pfKmcwjKdoz5cAyi
         lc9UyOYEJNrP6OzcbndBtq9++N0JPhwkXisIWn7j9pgtaaSx6vTgSpIJYWv6dhzMofPm
         u4uw==
X-Gm-Message-State: AOAM532IBeyarwiHBTvBjbmYxsnedJDlPKY35Ymh23ZZNVNWaq7r2cLs
        J1Se3pbnrwmH/pGxIkGO97FW5FMeLUrXVq0rayE=
X-Google-Smtp-Source: ABdhPJyHM8XluAgvy34F/u1LNyOoQbT0Sdbx3DlubA3WLU9aFNNTvcz1CX/0eQ5kfYR71jHg9kQHDJLqsi2a5BN5I2k=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:bfcf:: with SMTP id
 q15mr8695443ybm.133.1601416060255; Tue, 29 Sep 2020 14:47:40 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:31 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-30-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 29/29] x86, build: allow LTO_CLANG and THINLTO to be selected
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

Pass code model and stack alignment to the linker as these are
not stored in LLVM bitcode, and allow both CONFIG_LTO_CLANG and
CONFIG_THINLTO to be selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6de2e5c0bdba..0a49008c2363 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,8 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
+	select ARCH_SUPPORTS_THINLTO		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4346ffb2e39f..49e3b8674eb5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -173,6 +173,11 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
+		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
+
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-- 
2.28.0.709.gb0816b6eb0-goog

