Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2C25CABA
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgICUez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgICUdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:33:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20C3C061A13
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k74so3981543ybf.23
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DRdAryjq8aJ9FhWbdHsWSPKN6ISJIFMAFBJf/ilStC4=;
        b=W5E0fdTWYYpdRgGn3+mM1jE0Lnq94Ez+0wXBu2gCXs/Y+ie/fjFHxxGVxqs4iDjO61
         XUhA7AwaMsRFv8vxG+A2l1ssqjpgTZnnYSVjKhst6YSRYn0OJjWUHRfPYs4kigu2qd4P
         t+7zq62XXAtCsJ6LJcQc5WI8i9ada15PY9rxQyYH3tgvVRCGIgzZ7AaRdUcs3DL9eEcC
         Mksgubm5f3YT2uHtXKoqiKJVJ82iqcQCdR5AMuaFyYG+/7pg3g10PdXI72qaqm/rzX7U
         +8H1VOT5Eb3eLUSsSkUJu8s7szptM4G6CN6v7v59SQ2mX07NJ6vsYtwXB5FrSylvGkOB
         +/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DRdAryjq8aJ9FhWbdHsWSPKN6ISJIFMAFBJf/ilStC4=;
        b=s8C7omxXFukBdAPKU4tBSut13ebSGmThG5n7BGUYIkf5BhHwzP0NH1cEXPM6UNQo8O
         E9Y+U0UkhiZbKqTvA9S6SA83uiBJO3ze3gND/mTC+1zjp+FB+WNzfwjyb35ev0+TNi/G
         cUbg0RTDj4Djxvwb4cPyN/tukFoNpaSxdtECMxpqPjkrrPESC8WYYVefyDvltXYQzD3W
         bU9y5gP+8OWoRT+/Sl5j5SaDAr/0xeRaITPCvi54PDLFHvGfpeLssz+XSItS1dN6KOL6
         WQfG0+nw1PryvHbyD9csjG4XBITK9Tli8VjZpfcGn2SbCoNrDeTJKI6cZiRiDhF0movt
         CTGA==
X-Gm-Message-State: AOAM5301Pvyjriw1+kN5WUq6CB4EtEM/NY5OI+BYh95NfAAlHLkMt3XR
        11jhQL+VPQi1VQNyEY/dp7w3joauxYF+MYyOgq8=
X-Google-Smtp-Source: ABdhPJwiTOpKp1DNcc2Niuh9wmKZr2hpSpikSLbkfpniA2lBbifw5OwcLaWnbhau9OTVobvQsgnuxmwxleyw5C1VPmM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:ef07:: with SMTP id
 g7mr4300288ybd.448.1599165103083; Thu, 03 Sep 2020 13:31:43 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:48 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-24-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 23/28] arm64: vdso: disable LTO
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 45d5cfe46429..aa47070a3ccf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,8 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
-KBUILD_CFLAGS			+= $(DISABLE_LTO)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.28.0.402.g5ffc5be6b7-goog

