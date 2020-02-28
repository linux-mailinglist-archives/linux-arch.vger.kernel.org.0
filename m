Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C946172D26
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 01:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgB1AXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 19:23:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgB1AWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so740897pfc.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFQSSd8joQB26Yle3LRphyYOwCqM8lXqrwgR7KUB2ZM=;
        b=nHZ4Y7YbhF6uEk5/uFndEuekX2vKGSTC1OQpgCF1rYdVz1hL9KwhWsI6HLQwltLv2c
         olhA+OX8/TcWhf7cu831s2b1jUqHSYSvZqA7RHqWjI7TZURQ1M6+nuep8zkL0yqIzO/G
         rYLC+NOCo0eRuvYBoJQwHOB1tY/rFRwdZY/+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFQSSd8joQB26Yle3LRphyYOwCqM8lXqrwgR7KUB2ZM=;
        b=t5djumVX1fW+m5zkvJ1ddauv7amF7xiFepqIPn6KTlOTBD72Euivx3o3nvFKMw9iki
         zLtodTB5sWSNaUYekV5jaDwamhfAO/RxdWk9DW6lXrU2Una1+JvS/DLE/6VES3cuWTob
         ZfJV37Fyz+m/oN0+0HKwRfTKcqjWj/MkzdvXjqo2V8qkpYvth5kWV5u3ulmoaWXiZYYx
         ixVte0AQag7cjSxIQcK+bsQffr5JH+9qHXek3cWWytUVhcQCntPjcoUo/rX2QjrQtFQs
         M2Dms/1Ox8qJEZn/6C+uJM+FRS3vYM4JBJdYvvaJs/1el3NJLVceMUnVEnkCiIOLDBuc
         Vg3Q==
X-Gm-Message-State: APjAAAV9VtTtYGOdbzXhuBtXXhIIHPspgMQRc6J/6xQAB7EEIicijXQt
        QncBwIz7Br68ibXKBk0fe5c0YQ==
X-Google-Smtp-Source: APXvYqw6fCWM2xfT4DJ+VFMmyrDy6sPXs7ZYweUNi5l07x3V/XFaixY8I4K8wHA9HcWwEBIBYQBH6A==
X-Received: by 2002:a63:5713:: with SMTP id l19mr1913060pgb.216.1582849369348;
        Thu, 27 Feb 2020 16:22:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm7577879pgi.28.2020.02.27.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] x86/boot: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:39 -0800
Message-Id: <20200228002244.15240-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Add the common debugging sections. Discard the unused note, rel, plt,
dyn, and hash sections that are not needed in the compressed vmlinux.
Disable .eh_frame generation in the linker and enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index c33111341325..e0ea6b0924e8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -46,6 +46,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += --no-ld-generated-unwind-info
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
@@ -57,7 +58,7 @@ else
 KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := --orphan-handling=warn -T
 
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..b5406a8cebe0 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,4 +73,17 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+	/DISCARD/ : {
+		*(.note.*)
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.plt) *(.plt.*)
+		*(.dyn*)
+		*(.hash) *(.gnu.hash)
+	}
 }
-- 
2.20.1

