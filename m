Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E224E154
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHUTzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHUTyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA2C06179A
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so1561119pfx.13
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7lCPABz4JNrayMBdAlXz/o0k5wzYACi9B/neD0BSpY=;
        b=h4th2Gwty/g8Cg6oI4xBM2C9OsM+YtTMFNWMQxaSJxeMsiGbGHmjIpyPzRqnDYUohj
         mZEWv+JTiMGCqWpGcvezka0JZwFqupIZBq+bYlxEMz2m2f5RPnDUM/esPBUqClXzhknr
         KDHkGu/E7WUrNYpV0Two51F+fgNxBgpigGGNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7lCPABz4JNrayMBdAlXz/o0k5wzYACi9B/neD0BSpY=;
        b=Z4PzWBI/JgoOi0UkJ2p9ti/bMSNyrB6DQ/cCWVZdNi1n3zG3ZrTdsGITZyMkJBIVGu
         OJerfTPgjhgDN3lN7PgphqN+AKUG+AIzxZT+M6s/pSSf3LUKylFr/BuB9t1G/1pGn/D4
         F9BVjgWT3g8Ng/o/V+H/JK5sl5nTQYSqVEQOMZybc1sQ5IAiC18bUfSsv3OIr1MK/qtI
         Q0TWt1lon22I4FpZQLQVCiAHC5yHh0nyttpKF8zQvbtp7m5Qc/zSpM2twLNHF4zIa3XA
         9FethfaAd3AQzG575a9y2Wu+eWXj8AZU43s5YUKLRPiI0ekKjNloO9r1L9DsXF09GMeq
         3izA==
X-Gm-Message-State: AOAM531GGTNZQX4NHEn0qev2jztGgyE/ryobfPOj/fvGQqRrK1lNpSsW
        wRTgXUv0zmnkGzmCM28JvJjuzLxjbevFJA==
X-Google-Smtp-Source: ABdhPJxhC+bVf5xz8oKClettUbKDwzdI3ZXBGK3DWk9rxsSxl1YyINcFuh70sERopw/lGiEEpzQkVg==
X-Received: by 2002:a63:cd46:: with SMTP id a6mr3322488pgj.267.1598039642059;
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l67sm3026438pga.41.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Subject: [PATCH v6 25/29] x86/build: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:06 -0700
Message-Id: <20200821194310.3089815-26-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4346ffb2e39f..ccacbf808552 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
 LDFLAGS_vmlinux += -z max-page-size=0x200000
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
-- 
2.25.1

