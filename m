Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF0234E5F
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgGaXST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGaXSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2662C06174A
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lx9so8528829pjb.2
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcAsy2Kya2vQqvsN7ZPWA8EbcQkwVEcJexXEETLKJik=;
        b=Acdhtx1taL3cJ0UonSyJvk6bfFnzMNMb/OtYeoW8WVgIkiBmz9TPNPTuYBMmsdYmlO
         sAcW9XztYuDymTfimZLg8+HmpaYdTmmT8tF/BpBGfhsLUyvDHTtHASScwa7qJiTP1nko
         Qv/5rrTmKuRHOM+nwd77xCgRKODhxuUNBL7Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcAsy2Kya2vQqvsN7ZPWA8EbcQkwVEcJexXEETLKJik=;
        b=cQSZ+oCDb8qwUAa6ngZ8q8F5CD2AsdhyKyJ8LJcs/TjYY3k+CbRipztwEUv0mP65M0
         S0/n3qQKeHwUqF4xB6lw9v8Y2Z0vJdEbWUle0UOhSTLgdgZLC8+scv5OFQ7I0kWD4uwm
         TXEofUrVW/Ey29pdDcmequFJm6tQFffZmBIpmGMVLAuwJz+y2Z435KYNeI8IpS/fWzIH
         4SgqHuUxnUoXnlTJlQ+n2D3AWqDFguZyoU2WwIio/rGqKjWgrIopjxwnFwoORFsiAF5E
         H9y5g6ixc5Ny6prTpvwTNEQe9XSnYbCwn3svOX4yYStAcjpUMjPB+EYtpnWreBR5/e+T
         rklA==
X-Gm-Message-State: AOAM531eESnBWa1g6U4ZnCWKO5TeIjwHPofb3uiezGKKwns22NmDCC8G
        hA0K61fgnEqGKK9U/e58+o0IGw==
X-Google-Smtp-Source: ABdhPJyzzUS6jU3nY40Z2QdxjoOaZJ0MXEzHC7GLhL52i5IAnjsxzb7V9wPgftjtuphwT5Pu7c20Lw==
X-Received: by 2002:a17:90a:8d06:: with SMTP id c6mr6370143pjo.137.1596237493405;
        Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm11163353pfp.172.2020.07.31.16.18.11
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
Subject: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Date:   Fri, 31 Jul 2020 16:08:13 -0700
Message-Id: <20200731230820.1742553-30-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The .got.plt section should always be zero (or filled only with the
linker-generated lazy dispatch entry). Enforce this with an assert and
mark the section as NOLOAD. This is more sensitive than just blindly
discarding the section.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0cc035cb15f1..7faffe7414d6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -414,8 +414,20 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (NOLOAD) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 ||
+#ifdef CONFIG_X86_64
+	       SIZEOF(.got.plt) == 0x18,
+#else
+	       SIZEOF(.got.plt) == 0xc,
+#endif
+	       "Unexpected GOT/PLT entries detected!")
+}
 
 #ifdef CONFIG_X86_32
 /*
-- 
2.25.1

