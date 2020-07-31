Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2D234E77
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGaXSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgGaXSR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1DC0617A1
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so5427112pgf.7
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCrf0JNZv+v7XnAC2zXNDLnfzhwewMny4SzCwBazlpk=;
        b=DMIGjUeCu7WS1yf3tO/ZSurFXxQBrmrk+d4SNtYg3Zx4gCqGr5TRspd1Co3OvHWOuD
         HgP0Q2MhZC5ng5TdGuBK1N01WZRuRbuL0sGEYmgyIAQ/nfOQmSKgbXe+WhGM7kP/jalx
         nJM2JxLFu2JgqXahVDnFg8bR+aSG0MSFz/IAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCrf0JNZv+v7XnAC2zXNDLnfzhwewMny4SzCwBazlpk=;
        b=kkzHGYaCjP6za6pbElGfFUbEEPq9EYTM6gBkgf8H5TFhxXtub93KIpoaDDVF1soqGZ
         eSJktPvW0bRL9IjTKczHY+tEGO9WuReuqskh+dC7VJbmpSfnk9AqYqOAkyDXFW2jbAkX
         i+izOHMGDkzF+dA84e5NkyML1S7u26TV+EY6uDk9/7ZIbn15hrrpNh0d6e6lfHx3Hiut
         cV9OgPhczLb2VSwexW/DSuJUK8FOwpaWMaQtuOzYQRfp4a43vDoGvOO1+1Rpi2qp7HCl
         dRIWt8208KAdvDKQV4RPiz15CpyToATmxg/MkcL7iZTglAHdgCNv62oDkwskyhOpAzng
         IVyA==
X-Gm-Message-State: AOAM531twq0K4wJEScVJm9wGeA+H/PYFAFpu+yYCw5RSlIltM/3RRSVA
        1k6fsNhLzEEZ01+9zRrr95tkGQ==
X-Google-Smtp-Source: ABdhPJzxG26pp/QHLf5eE3Hfqcu8R6vyN4v2osnuJzxCtSaiYaQfi+Blj9rxPYtcQ07RmWuKHr521Q==
X-Received: by 2002:aa7:947b:: with SMTP id t27mr5503555pfq.117.1596237494645;
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm11609642pfo.212.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
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
Subject: [PATCH v5 27/36] arm/boot: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:11 -0700
Message-Id: <20200731230820.1742553-28-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..b8a97d81662d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -128,6 +128,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-- 
2.25.1

