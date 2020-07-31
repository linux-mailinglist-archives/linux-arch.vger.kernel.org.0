Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAC234E0F
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGaXJJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgGaXIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590C5C06138E
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so1599995pgx.12
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrAblmr6ozIS72tPylywn6+f+xtS4UhaP8bWtW4yv24=;
        b=dE/Lv+CUA/T7hFTSyS/prDIBwKu/ji5fc0y2Bvs2zCPUa36aaYuKYtGCWE1TiPc+U5
         VmeZKoRZYCjcKC45iW2ezGMhW8mV6FXFni0hFNHu5kzRpTCuDIkn88ZAPH+X6Su8OTPX
         dsyMxubhpOlOMQIDeQNqP4d+u9LhnVaPCznvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrAblmr6ozIS72tPylywn6+f+xtS4UhaP8bWtW4yv24=;
        b=KUm77eNjtsa/to4sXBMkhfh4SmCJVQCQZ/kMZXrwwloZo6h7SVZPiFXUHgDvgiO+UK
         +oS3lAn8/V0RzK73Lg4DmYcKJ0JB858WH8PVY0lEo/jJA4KDO2p9hno/dAi0YlDypCGV
         M0yruJGW1Jen4vEurPuu4BZBTCneBbZF/b6t1nAgSnjxn+ruqkKA5ZTtyiL+HKfYBlw2
         4SlepYJJEVvRH/pqTeJmfYoFU/9h/PO9m5Bqtt/rIdfwrj8BGumboqXMJ15pjbMpCNGI
         NIR1QoLdWNgBexKbbZR4Zj9adwiE7ZMBJhJTY/AFyHgFADbhGMxlJ646YagqUOE0uhmk
         eKsQ==
X-Gm-Message-State: AOAM532cjGa9lLNKAgYL5Q6VH6BySsHZGGfgRwGiDtv8Rsk/GX2Z/LPx
        btrl0Bq4CHNdxnqgIUEXkYvdFQ==
X-Google-Smtp-Source: ABdhPJyu/p7gfXhwLLFTUjqcKNpeho/cbat9YHoxOtNjsvvByKqqv61amhieFG04PGKt/BiiHt+iFQ==
X-Received: by 2002:a62:6083:: with SMTP id u125mr5816247pfb.286.1596236928921;
        Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm7192916pjg.48.2020.07.31.16.08.43
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
Subject: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size section asserts
Date:   Fri, 31 Jul 2020 16:08:16 -0700
Message-Id: <20200731230820.1742553-33-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For readability, move the zero-sized sections to the end after DISCARDS
and mark them NOLOAD for good measure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3c2ee9a5bf43..42dea70a5091 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,18 +42,16 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.rel.dyn : {
-		*(.rel.*)
-	}
-	.rela.dyn : {
-		*(.rela.*)
-	}
-	.got : {
-		*(.got)
-	}
 	.got.plt : {
 		*(.got.plt)
 	}
+	ASSERT(SIZEOF(.got.plt) == 0 ||
+#ifdef CONFIG_X86_64
+	       SIZEOF(.got.plt) == 0x18,
+#else
+	       SIZEOF(.got.plt) == 0xc,
+#endif
+	       "Unexpected GOT/PLT entries detected!")
 
 	.data :	{
 		_data = . ;
@@ -85,13 +83,23 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
-ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
-#ifdef CONFIG_X86_64
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
-#else
-ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
-#endif
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got (NOLOAD) : {
+		*(.got)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
-ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
+	/* ld.lld does not like .rel* sections being made "NOLOAD". */
+	.rel.dyn : {
+		*(.rel.*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
+	.rela.dyn : {
+		*(.rela.*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+}
-- 
2.25.1

