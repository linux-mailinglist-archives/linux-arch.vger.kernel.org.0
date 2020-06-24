Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2849F207D5B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406612AbgFXUdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406618AbgFXUdk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE4C061796
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y5so2427045qto.10
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tvg1Fbryi0kMABLSJZV+2LlG9cMfXZohRvKr2b10/ew=;
        b=qDi1kJQp6Ay8PowzBhvgcAgfJKyEY22DJ3SehuRqjn/jA9tuCP3XgBFwyavVII/8H8
         +qDUOb2y6OKXwsbI5cxksI3QZk1MHXAA03OHDhdjTbrRcF9EMaP1PLIUJPhY0/usboE5
         WysdzKDHLGBWRBK078rHZqlAErXt2qVt2sq358db2q+vTaEhfb2Ztz8s+Npc56SUR/GU
         zam+aC0Fi9TXcLLkm/vCwtmB9CZFKkHlUgIzUuWu5eMrmtKdAXKTOQSgFxHw8mPgwD7i
         VrVAm6xkIce/iluM0BjvQMvc/W7Io0XF/CLOQ/Xz7mhbTAKzZSonAVtghl5cbcwT3k0W
         qRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tvg1Fbryi0kMABLSJZV+2LlG9cMfXZohRvKr2b10/ew=;
        b=bihPy9c4WopYi01SbSW5MmemBe4GklPi+Z3ThhBAr49NT2g9saWpOYTTP2h/xtk40V
         XWmNRTK6RnXr0r1vo2zUQh4HCktOa1NT0M0SJQ7LYsrEG2FSRo0uZn8o6pYdOYqxmMSy
         G+qIke49M5cVDp+V3OzlbM5nqpAiTZX/YZudPwxumnRJ4jGinEYemlEx06Gw4LvmdfxP
         Cg17AgM4L4zT8ttP0Gqw3znUoXGyX2dsEemzRzCQdJ7SDpT0S+om4urac/dIJwcvkw4c
         3vQjJFqABAZnqY5+sE/PU/InndJNf8/QKJHBi23ne/nJfbE0qwAYgE3Gu1jnwsIrXZmZ
         JWlQ==
X-Gm-Message-State: AOAM5316VxOrZtuYaTQHBxO3XdvBQZ+WyrKK9UNyNCcTeDxdYdBeDJ4o
        J3ndmx4NfJ8MqvxRlkQQgn1rRt6hP/lcoQxFMhc=
X-Google-Smtp-Source: ABdhPJyl5JOyQAzphL8fSerF19PzJDrN7smlmqxmskm8wB3636prwAzfuisg2Ek7D9XrgzzDEO8QBVxE0nwET9TpJnI=
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr31350632qvb.210.1593030818021;
 Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:32:00 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 22/22] x86, build: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..df335b1f9c31 100644
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
index 00e378de8bc0..a1abc1e081ad 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -188,6 +188,11 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
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
2.27.0.212.ge8ba1cc988-goog

