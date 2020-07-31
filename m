Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C8234E14
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGaXJQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgGaXIs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8BC06179E
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so16784335pgk.4
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GUjcxjsZxZ8lM3nHzNDLygJ5FIXra6/aspJ0PfOUm4=;
        b=kXpcLutZEBDIK8r/VrXM0/S/M66OR5FIx7eppKkF/v1AAyqoIG1EcJSK+MAUIX1GFO
         +VctBRcweBl+L7+RbRpkCnLdW+eB6f/AB/C7ovm8+db2FE3qYt6eJuyH5G4NG9EB2Nqy
         kXp3k3nuHXo+uMdBCXjaRxsfyYI9gbQEgrOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GUjcxjsZxZ8lM3nHzNDLygJ5FIXra6/aspJ0PfOUm4=;
        b=UqKx2nIgHLR1gRMRrlMiJYjDpn+mxx0OmZd9nndwouILJDwAtlkokScN2QnLOFN11v
         J0q8J5RBuiUBEuZd5dj9x2cYpeIZ0C1xXQLK3WwPskXsNBCmytkik6gV/nVHlo3jXj0L
         VaK/wkuZE2OQiCWSXfLfQTqLRE09P5vaYqGiy032QQWHaEo2Sn0ejOIoZayBRx3GrJZx
         fojQnDE0vNZhs3+9437ATEsEno1QwFv7hBAHWqlDUR+TFpdBrfXzEczdXK7oYQvCGQAi
         NiKqnOY4BX6x/fVuZeP1LSEbpiOdDFYwLhgdlrtLXq/K+VeR3s7L5sZisQ3NOeKzch/3
         Evvw==
X-Gm-Message-State: AOAM532H+K1C9byAZMp8cPqHkJZnRCSaoqxIuwzUM0kVC6h1JdfBKG0Z
        oY6ucDEaa6eyxsGjwmG3Drxw0A==
X-Google-Smtp-Source: ABdhPJwiN0XXHdkflMLnP3OGR+ZptMLbM44ofV7XUW+Prs0tZqxumVQ+EVPIU7ICfg7NjYmYai6cfw==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr5466462pgb.389.1596236927556;
        Fri, 31 Jul 2020 16:08:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 75sm649022pfx.187.2020.07.31.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
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
Subject: [PATCH v5 31/36] x86/build: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:15 -0700
Message-Id: <20200731230820.1742553-32-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.25.1

