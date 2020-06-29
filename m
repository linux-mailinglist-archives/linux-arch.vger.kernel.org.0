Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3620E19F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgF2U55 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgF2TNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732DC08EB1F
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:27:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so7438594pfi.13
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcuGTfSUXtPYMFfpENNYu5S2NR6isuQ9uC03+go4k80=;
        b=jRyLPLKJ/wflGnWNIhsw1/xtdO++qU/4G4jZjo+lnOqYVWgtIzMYOnTwQtGOp4VTv+
         b8zRHjoyL25oKD4tWfpH43lrpeGB8egY2xI+HOcY319Hsy/yzaeePZ8YwW/uqTnkDoS9
         fbCN5nnFFpuj2qqzr47ls2rlOBAuxjOrocN5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcuGTfSUXtPYMFfpENNYu5S2NR6isuQ9uC03+go4k80=;
        b=LRrGdBIz9x7G375IEt0daoeNs/OtIXki672e6MExoD8taXlAxq0hbhGrf/lhD5LLJt
         McHOHdhZaL9wmYNx/vYLgf9jD6Mp43LGizeQvq2G1barlP4SSyPCYPuDUX8+tR5cQTYj
         NIU8wvoL5svxuVjgE/a8sL32o9grGRlAPEUaLopzZQHXu4KD3tpdet0AfSz+0Zvye1kA
         WQMnwD+HclGqhJbG3lbM6vTX0rbl718ED+l6t78NsF9bxzi9OhdYZelIad+NajV/Ni3S
         yruTsD223erL2bw5Ljgzronb1mHVjdMV+0o5QdwcTnfFaVfHEfOveZBhLCO2LeLnfLH9
         eA0Q==
X-Gm-Message-State: AOAM531tlo/vBmekNINBobpJWfrlqJHR4s+vBH1+i2wU6HjcpJQEUo/1
        NHJLdiRFptBKYSSUxVLvSCCPMA==
X-Google-Smtp-Source: ABdhPJyp58Bg9f7GuaQUlT4KpenbA1Jul+PfAUND8VkiaE+umM/0tCY0B+FCqda7VoHqscVan5uu+w==
X-Received: by 2002:a62:1646:: with SMTP id 67mr13176339pfw.281.1593412049613;
        Sun, 28 Jun 2020 23:27:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 27sm18066808pjg.19.2020.06.28.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:27:28 -0700 (PDT)
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
Subject: [PATCH v4 16/17] x86/build: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:39 -0700
Message-Id: <20200629061840.4065483-17-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
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
index 504d16968ed8..52e2b4952a0b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -413,6 +413,12 @@ SECTIONS
 	ELF_DETAILS
 
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

