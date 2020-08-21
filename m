Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAA24E112
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHUTqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUTo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD9C06179B
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so1336869plj.6
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUDDa5Q6lLloNoTQD6KqNHOrv0G5BcLftZGhmDIGIUI=;
        b=WQAO8nzc20p4joT5SWjFSFwNOUK151WWyLE1F1s8PdTuZonJVYgAtlZ8pDXZ4AqOqd
         vECfHj/uT7fKKd8Qks16HHdoIyHotqZJnMRENHTJLHqtxq4/EKASXKh/xIpHq1PCzQOe
         6/Oopz6fd7xjErT/RlKOTUW3p5afBMZhqXfX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUDDa5Q6lLloNoTQD6KqNHOrv0G5BcLftZGhmDIGIUI=;
        b=UQLFYrgnNCGM4X3Nlc3oj0lp+jEtDCpuFhHK45UtO4q0hLEtVMOMg7xo2eIj0I/bgr
         wY1eKj5mt7JOzhKyrCxDKkpWXxvXGta9+OeAAr3dLq2299xY8ULWkihmZeghWxxwO2H6
         byeQr8e64QLPkBUY2wxV/iXc/xqSdlsbN2WcSzyMT12DCwfNJR8BcRGYnMJclQ6Ozr8B
         Tm7A5zVa4v5lfkmpLeR90M9bIiTCiyysg2YW8JHkP73b6Q8dj7yUZ3LSsvj32GFVDbVT
         VpnUPu85NIfxDAPbV05YF0GxEa+K6ZrmRgcj+bp6911XH0X2HFkQh8XxE/S48FUkTmxX
         kSqQ==
X-Gm-Message-State: AOAM531SZg6ZMYQ+Uw5VyWhbJRi327j1Mj36Q2Plpd+YStKvQmg+GWuM
        kcuMwLMcrQbo40hai3F7WAfqgA==
X-Google-Smtp-Source: ABdhPJwAkf1pEoEXTnteUwchu7GM7Vb0zPYumreldvv1hu9wDHdvHTU4ydc4PdV7f7+x8VGZjdhzEg==
X-Received: by 2002:a17:90a:4dca:: with SMTP id r10mr3568315pjl.200.1598039063622;
        Fri, 21 Aug 2020 12:44:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 74sm3320208pfv.191.2020.08.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
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
Subject: [PATCH v6 03/29] vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
Date:   Fri, 21 Aug 2020 12:42:44 -0700
Message-Id: <20200821194310.3089815-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KASAN (-fsanitize=kernel-address) and KCSAN (-fsanitize=thread)
produce unwanted[1] .eh_frame and .init_array.* sections. Add them to
COMMON_DISCARDS, except with CONFIG_CONSTRUCTORS, which wants to keep
.init_array.* sections.

[1] https://bugs.llvm.org/show_bug.cgi?id=46478

Tested-by: Marco Elver <elver@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f1f02a2f71b7..6b89a03e636e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -954,7 +954,27 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * unwanted sections (.eh_frame and .init_array.*), but
+ * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+# ifdef CONFIG_CONSTRUCTORS
+#  define SANITIZER_DISCARDS						\
+	*(.eh_frame)
+# else
+#  define SANITIZER_DISCARDS						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+# endif
+#else
+# define SANITIZER_DISCARDS
+#endif
+
 #define COMMON_DISCARDS							\
+	SANITIZER_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
-- 
2.25.1

