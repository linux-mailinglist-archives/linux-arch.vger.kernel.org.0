Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325A24E149
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHUTyv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHUTyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A412C061797
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y6so1356011plt.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYY4BGMZpEUoUw6pwB0rAYIo+TQmYGtCQDuwjk0rFfA=;
        b=UXMo0g81IhuQadz0t0IT637YY3O6sDavMlgOlN8BROJi+h21xme8wQSpHfKN4VSjs0
         0zvn+K7mSlGI5ABhdq61uvamMUHMZX9mI8BGcLCW0h1nwgeZH2CIU7gdquipMxGV/X/g
         LkXmXYJdkoUSQ1wvEfsI5FA5lu5Z42khMLWbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYY4BGMZpEUoUw6pwB0rAYIo+TQmYGtCQDuwjk0rFfA=;
        b=LhN0cCKcD6RBv1iENMEAclr4DpU5B3oXdLAYKTCussxQ1N7cM7y1+4S48L46UrTh6J
         HuH60ClLRpOjrYcO30v4iWRxYgyfZsaSqITOvE0aY7A4vTKb1J3wX8OlwLUxWf8JTLsy
         zKfWOVYfd2NwdRixrzPkjrFuiUeS1tdHgHrwQCao5NU7LfRHN889+L0H6GrJ37TrRiD8
         363fy+z87U5Vxgl9p2V7ZnRZZvbq85cj4kF2d6lhPSyzoWo66P92E9oBnEerEaQu+3Zm
         9v1VNkDrlI0NHpTmqEVy/POj2nPU6fukE/JaCsTUruUC4r7oxZQV9fa/CpI6sELtAPXB
         bqdA==
X-Gm-Message-State: AOAM532bPcXy4bAvBJaQeO5BItdBZYqQWZbSgv9lD59YtM4wCZe9oyGr
        IBwFbbL+SavTpas4bDptf8Yb6Q==
X-Google-Smtp-Source: ABdhPJzdBaK0lQXKTsLBcoY+gieqzSTMIlMFnB1R1B39G09fhcKe/Ne3I8UbPt7DQq2SxYcgDyyTKA==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr88446plr.97.1598039646692;
        Fri, 21 Aug 2020 12:54:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x28sm3555441pfq.141.2020.08.21.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:03 -0700 (PDT)
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
Subject: [PATCH v6 27/29] x86/boot/compressed: Remove, discard, or assert for unwanted sections
Date:   Fri, 21 Aug 2020 12:43:08 -0700
Message-Id: <20200821194310.3089815-28-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for warning on orphan sections, stop the linker from
generating the .eh_frame* sections, discard unwanted non-zero-sized
generated sections, and enforce other expected-to-be-zero-sized sections
(since discarding them might hide problems with them suddenly gaining
unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 753d57266757..5b7f6e175b03 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -50,6 +50,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index ca544a16724b..02f6feb0e55b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -72,6 +72,11 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
+		*(.hash) *(.gnu.hash)
+		*(.note.*)
+	}
 
 	.got.plt (INFO) : {
 		*(.got.plt)
@@ -93,13 +98,18 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
+	.plt : {
+		*(.plt) *(.plt.*)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	.rel.dyn : {
-		*(.rel.*)
+		*(.rel.*) *(.rel_*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
 	.rela.dyn : {
-		*(.rela.*)
+		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
-- 
2.25.1

