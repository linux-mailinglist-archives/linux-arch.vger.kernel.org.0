Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA192069C1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgFXBtw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbgFXBtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34BC0613ED
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so345169ply.1
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dy932Q1L6bL01oX9ZyNGxMZGfZc9HBFmwG4K7Tai+w=;
        b=TdJYKQfKuVwGeVGHEDD2vnD1lvuUL7cKVDKIPrO6knxxj6QtsEWzxUWr99rLFOCPfK
         9ohQqyEVVZpfo0ViNiWBQ3Ut68BJePEhP9nQaLhMsRG6OBio29yJbdvSaN570AxQ3PxD
         VtIPRHCizmozN4OWucFCQVq6c7qciUfkrqN+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dy932Q1L6bL01oX9ZyNGxMZGfZc9HBFmwG4K7Tai+w=;
        b=XPn85QyOrhPx2jZo0fqNvAdAAcUR8F0+c5wGyfsMGJ910DVJfxvsf1k7i70Q7cRF1F
         p26iNqUyiEybDHhq3qssl9E9HAoC4XVMDlDTM4MPbGpam4PJ5R9xJVQuVc9boci6pdGd
         wI4mh5lNke0qr3hYmpfaPC6CR0ptmCytmYyMzx1BnPMUxXzmbvYKT7yjGYzJP5oTC18t
         vLgclHZqiT4VdVNkPJzRwZYJf9XPvKDBXrxet0Dcfqc5oxDuG8q28f2so8gXM2sEKHQL
         QWv0La3NWPQaxCwgLdPoxeETjhwTcrk7WvkYKPC6c+xZXcOQP0ZXdScUUR6tWFno9ibj
         9uCw==
X-Gm-Message-State: AOAM530rrjx7ozBoQ0smXVn2Tk0uIm0fl3AxOStrF4iiJXwOcNiGclny
        L8qbXTSrP3+MRUowTa9PYot+8Q==
X-Google-Smtp-Source: ABdhPJz6GuoF4HjGXS1UVnYm6pgHtPqOwo/XSsJjpo3fuRaU8aGICUridm4hb0FUl1JDIqO0EOq+8Q==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr16693200plp.253.1592963389555;
        Tue, 23 Jun 2020 18:49:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm172748pfd.105.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
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
Subject: [PATCH v3 4/9] x86/build: Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:35 -0700
Message-Id: <20200624014940.1204448-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
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

Discards the unused rela, plt, and got sections that are not needed
in the final vmlinux, stop emitting kprobe sections without kprobes,
and enable orphan section warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile             | 4 ++++
 arch/x86/include/asm/asm.h    | 6 +++++-
 arch/x86/kernel/vmlinux.lds.S | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..f8a5b2333729 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -51,6 +51,10 @@ ifdef CONFIG_X86_NEED_RELOCS
         LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 #
 # Prevent GCC from generating any FP code by mistake.
 #
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0f63585edf5f..92feec0f0a12 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,11 +138,15 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_NOKPROBE(entry)					\
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
 
 #else
 # define _EXPAND_EXTABLE_HANDLE(x) #x
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..bb085ceeaaad 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -412,6 +412,12 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.rela.*) *(.rela_*)
+		*(.rel.*) *(.rel_*)
+		*(.got) *(.got.*)
+		*(.igot.*) *(.iplt)
+	}
 }
 
 
-- 
2.25.1

