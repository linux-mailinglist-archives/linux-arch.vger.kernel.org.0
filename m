Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4405234E07
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgGaXI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgGaXIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E3C0611E2
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so8517385pjq.5
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=Lr9or3Hp0DSvQYElAg+xki465Vdb1uAtDe85PRDbs1d8wZ08VYB9OlhllbtENPVieR
         V70iE3+WoadE5MGnu8i8GLUrfRA1t5+LbrYMwG75g0Vr4sqB1S8u5be8NrKejxdMS7gm
         byUy6rMjO1J+JL4A2Xwyw8hGAHymoJEGFEhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=j5UncGPhFdry71mbE0Suo2ReHEJa2cCDsCIjwN0K73Ul0sTD8fUh9slWWKbN3FAza2
         +KRbWHxVcYXQ0jsDENewZPbMIHm5FjlaBWYm3aW+hHpoUAHtSKAffibdWMx6uxWv5oKI
         UwUhmEWGVpGzq/gKEXVKcMupGUqnhWnkaTY0ovsZss1gkjYZyBF5fvhnSfP/HUuKX3m7
         K7fsI27md+V3fA/Qul/GvZW3mGQmHRIfUbEmS6k+SOPWWxTP0ve0xgEBOvgd1N4PdVOt
         VrQFVXp2LqHMg99aD1mglVVtiF0iCpbCf9+ejLl54fVTVTbT/ZsCmZZuUhYOSzyCwstA
         /N0w==
X-Gm-Message-State: AOAM532+NcSJw/ng74IBN7nXESjA1/F1bu56bct+KBIrv8fHBjX3iL91
        RbdE5PWXHWcl8NXv05E9lKeZHw==
X-Google-Smtp-Source: ABdhPJwhHCIH/rXPbloue7Ao7LwdLWcpC7pKCtwRdsLSguHj3gdxjmuhn4CNI2OYzSlwA+KLPraTmQ==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr3631713pjw.146.1596236931297;
        Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm11218113pff.10.2020.07.31.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
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
Subject: [PATCH v5 35/36] x86/boot/compressed: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:19 -0700
Message-Id: <20200731230820.1742553-36-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 43b49e1f5b6d..f8270d924858 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -53,6 +53,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += --orphan-handling=warn
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

