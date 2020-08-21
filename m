Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30824E10B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHUTp7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgHUToh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E0C0617BA
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so1568976pfn.5
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FUB3tjALH2XvfA6zdfdUjwI0GuDEI1l9XpW++dZco8=;
        b=dwH4hSFn+M/JShOAvoDuz49SFgRTdFlTWo6hGZr9AwLMcNzDM8CCErZhyY7e1uO/Xx
         uqiHf1O97j60Dk9p27VnNcHgm3AvxP83RVdw0qpFJ6YHuX6CzA2/zf5uWMROb5mfhFC6
         0KXGu5Y3b4E5gPfjCLnwSk3EL5h0NSoEoS0pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FUB3tjALH2XvfA6zdfdUjwI0GuDEI1l9XpW++dZco8=;
        b=j3Ga/rtnEhBsZroWcgEAC99UY/SA51E48xT3tUthvTkSVF78L3w026jDiFwePRNCVg
         3iFh/ZN0krBq8Pa0IDi1YWkklTyQoyJYqFjFjwTBTQxF/4VprSIw1NBx0JZVOicMgT7p
         acoj5+n7xsm4h9/FN0kwSiZxj7Bqp+j33d4gKRyenfDN71dzrMK3zn7QHwT2HXNW9QiO
         L+s9oSNYvElVtyMNqien++OvCdZZHZ36EzgvMEWkVmk/3NtQOyuJ0rLu6QBrpyijcUPV
         XotHlao+uowYE04S3YOaFNrnnbatN9C1crqgMN+xAJvNnvO77WPLxjqms6mp2k/YuNT3
         DfXw==
X-Gm-Message-State: AOAM530utUVNdnG/zmeC6tAOBCh4GVl60YllNG5i514ZP6QiSDT2ql66
        L9bfsGT+hOHV/FQJ6Q0c6F6zSw==
X-Google-Smtp-Source: ABdhPJyehd01pOgX4gGLWRe5I8XmNR/SFexjrkeURt8pREiENkcrce1cR+99MhoC96hPn3LnwhjcIA==
X-Received: by 2002:a62:2ace:: with SMTP id q197mr3509274pfq.77.1598039067613;
        Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14sm3393575pfm.103.2020.08.21.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/29] arm/build: Explicitly keep .ARM.attributes sections
Date:   Fri, 21 Aug 2020 12:42:57 -0700
Message-Id: <20200821194310.3089815-17-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for adding --orphan-handling=warn, explicitly keep the
.ARM.attributes section (at address 0[1]) by expanding the existing
ELF_DETAILS macro into ARM_DETAILS.

[1] https://reviews.llvm.org/D85867

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com/
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 4 ++++
 arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
 arch/arm/kernel/vmlinux.lds.S      | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index a08f4301b718..c4af5182ab48 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -52,6 +52,10 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		COMMON_DISCARDS
 
+#define ARM_DETAILS							\
+		ELF_DETAILS						\
+		.ARM.attributes 0 : { *(.ARM.attributes) }
+
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 904c31fa20ed..57fcbf55f913 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,7 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index bb950c896a67..1d3d3b599635 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,7 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

