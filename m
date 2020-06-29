Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAD20E066
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgF2Up7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbgF2TN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35DC08EB00
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so7020862pgg.10
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=M9ZSb4qoWIq549nkDC9nITi2Y+iOVB3dYWRDDV3WRmfzVjtQks65kDEF7l1+ij9SlB
         Ohi65fuChmNNYze5qrvJVk6IOjVJ/rxa8jvdv0qO+qmBCzMBaCbtUOo4//H/OjguzP5R
         T/UGeSUbVaM1bo/CG0rdGvwUKCmIM2bIikow4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=JRPzwNOTB+FHEjn3znvc4QaCc2lqbdKVTXtmxD5H7QiwXV9xvIwXn22Hlmj9ITPVK+
         h2L06V5tz4ozWC2j5rH2QuHJEvtAIVcqgqlQHGxV3xBVz0OphSoYgsXehuVnEyaiA4ji
         pTxpZmTzYm5n9RhOGFX3wSPUnNsrgCuT54qCN017iQ7p2aNX6Y+jW/BjUkO/O03emYpm
         w2w/pFGEgzXAcQYetjTqitzrQ0y8rg0s45T7e6vdL9KE0ZCwph+4KOk7oMwTB9KFCvSp
         ek4oy9pEYf5PCZn6X+X/SLHMglG+w6TuTVaHqdqSusxRA8RzMb1Bo6AQxu8x9DTZsfrx
         yWfw==
X-Gm-Message-State: AOAM533mNtC42OjJc3g7I+zQjKAZkvWA5+aTM4pR4YnEd2YdCbwAP+J5
        7JvMunrnhExkTNhPwYId5RDKgQ==
X-Google-Smtp-Source: ABdhPJw58QIF5f/Yv5c9CUFM9Nx42xHsS2ePKHv+mXeT2M6dXWhB9Q/p3SvpYavVwb4WSrkztjUiRQ==
X-Received: by 2002:a63:4419:: with SMTP id r25mr2949678pga.198.1593411530134;
        Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm34391423pfk.86.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/17] arm64/build: Use common DISCARDS in linker script
Date:   Sun, 28 Jun 2020 23:18:30 -0700
Message-Id: <20200629061840.4065483-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 55ae731b6368..b5a94ec1eada 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -89,10 +90,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.25.1

