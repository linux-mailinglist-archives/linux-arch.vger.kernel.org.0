Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88341204238
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFVUxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgFVUxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 16:53:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C5BC061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r18so8772890pgk.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=Jfz8nxtlqDdyEUFiNYROIMCvx3CmfLB7i6PghJ1Hi/EURISUOQ/go/6wXg7kWsRNYD
         CEdymigcOLNz1dztI4QdAZRu9I+C66qxkjsJ/hePmRB2EUTooiBBhOhS3fRT899g11PY
         e1r9p/89eFlp4rd1hjPImny24bey3KDGQa2Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYQ7/UZeNlKUAAzd40PNMMjARn27pZcaavNwLjboXuY=;
        b=rPGGK9rrrj9kexmie4r9fb720dr70LtwOxccPA7XjaJ0qxxMj+c+g5YVOTYewuxxWj
         fr3u/+tItMHUJ9zIpD9NFNxsAV18t4LMdH4ECc5r/P5UYdGplO3EILCDiTLtYQjrJ6yw
         220SGsXvE5eIGGcbbga7/EdKERMM9WN+bKofRo/0ZdaErkMg48P+6gUXlbVw5pxdBtwn
         gmf4dC7FylAb5pJoR6SS+Apgq9DSc3S5qauID0MxvaYjDnFERG8/HExi0vB9crxWpE1s
         okpO1SgHe9zqyGWMcDHX98nSQF7b4JTXfwNAuBFpNLWXXC1UacHD9JLh7Sk3UBuDP0DH
         3y6w==
X-Gm-Message-State: AOAM5325Y3wlxqyiNoHtSbsHttNzTIt+iNMGVVaaML2BJ5F3EYq2QGu7
        +1RZvLZDLQ2w54QEEM9omKNuRQ==
X-Google-Smtp-Source: ABdhPJyWBB6BndMTxHuqz2+8/tyBjuTLToAfkoMCHeFnVOD1O3PKDOktg7HbB+hrbiRrwlvZpQKeHA==
X-Received: by 2002:a65:4304:: with SMTP id j4mr14175789pgq.152.1592859228964;
        Mon, 22 Jun 2020 13:53:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm366797pjd.23.2020.06.22.13.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:53:41 -0700
Message-Id: <20200622205341.2987797-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205341.2987797-1-keescook@chromium.org>
References: <20200622205341.2987797-1-keescook@chromium.org>
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
 arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742f91c9..646720a05f89 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -48,6 +48,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
@@ -59,7 +60,7 @@ else
 KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
-LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux := --orphan-handling=warn -T
 
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 8f1025d1f681..6fe3ecdfd685 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -75,5 +75,16 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
+
 	DISCARDS
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
2.25.1

