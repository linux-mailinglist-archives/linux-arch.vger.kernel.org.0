Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA8234E1A
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgGaXJU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgGaXIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D3C0617A1
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so8064030pjt.5
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw0qFrlLAeGFNQICDxZAEcvNQljVuXBAcUPpDFT6mlY=;
        b=HwWUijwCN1yHVvMTBcWpAPeJzy4e7bIML4GGEjnycX031r9VYKdxWVfS6nNaj90cTh
         WCgBr3fpJFTJ9DUUwuFweceKIqpoU17PdRLq9usS711E+wIEnR2UVx9rK2Jqm12MH2Ly
         leK+goXQHjXkoEk8FTiq2zz0QFdbtKl/unv3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw0qFrlLAeGFNQICDxZAEcvNQljVuXBAcUPpDFT6mlY=;
        b=mG0a0TOTo8N2LBSpjpML3QtgVYAyrrTP7sq/PY1Ly3Cr6QaRCEfmCtIupVHH9u/VbB
         5uBdyz5XnrI/f1sAr/p8b+fAd49iXvs82yq6xQL/pvSjKg4bDLb6nw/PE9wluZOTg1i2
         2k4wpH4ITNWbCeMG9g80rIp5YI043mZ+MqwbtKof6UQzS0r5bXdLCbjUsdXBKd31R2Fy
         U+dDXvI1x+SN1gSHEOj7SDNCE8j393PxHEEElTJTE66NIF3ngqwn0zkuYCOkaKsoqKms
         XecNVl3R/4prH9tOo5kQ5txVgwAujfNKj1ZuKVKMW9V3Dj4GumngB/fDe9tfNfjWDYjr
         lUyA==
X-Gm-Message-State: AOAM531MDvdvEcp3BsUIy7LwEaJ0RB5vbF+isKDFbnYacf9WdPrUSrt8
        xXEpa4uxqWwpVNgUj/H3kivb7w==
X-Google-Smtp-Source: ABdhPJz6/VTMQ01SrfhMQ/SLXbQUnTuGTkQpv8usqAy0lJH0IrS74Nhjz+iAd2EIkwdY4wSBBsMY5A==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr6354051pji.154.1596236925542;
        Fri, 31 Jul 2020 16:08:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm3120709pjy.51.2020.07.31.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/36] arm64/build: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:05 -0700
Message-Id: <20200731230820.1742553-22-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

With all sections now handled, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 35de43c29873..b8a3142db0dd 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
-- 
2.25.1

