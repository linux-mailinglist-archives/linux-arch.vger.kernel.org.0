Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8F25A33F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 04:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIBCyU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBCyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 22:54:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F05EC061260
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 19:53:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2017307pfn.5
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSRmKV4TxKCXU40IBJQsfTYjUw2udm0vFSvEERZRBX0=;
        b=FwZ8Z44SN7D4KRJA4npu9mvkVI0wXuCLYH1l2mLJj8aelE0Rk0L2zjDZgtqEkgrGP5
         Vdlh91A3FK9cW00PtADerkvJE2DbDmOjQwdEO6PDh5uBo9JY+jiyUUcP5hnU8Rb7ZGKm
         uWPcKxWzPxVjBdhDrkoEXl9Yq9bB3c9PCSDYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSRmKV4TxKCXU40IBJQsfTYjUw2udm0vFSvEERZRBX0=;
        b=S/aw9MoB1XRRbQJvmXwc8a+j/vu5KkOyx70s4m0NrqkRIjWRtz1zF+rE3l/xD+qnad
         gonIXoOnTt7uIKOVXx8q3VmwgpT7WMBRSaa6r+35uxmQHIvRaPj1rvk76kNNAw6DZK4C
         Oem8RmoCIMiMxfg6X9dK+TFyf+tw2r+6CTAashpFFZ/i4l0VPkqOO4/fvstzj5CSZXaE
         B0q76YheqFHsU2UissffP1oUvkrO38owu64hghZ8RB/qTKcoaYXAVcgRKMbwnw5XM/uE
         r4EVzP/6Gwn0JMF3AoScDkgUDBqf47KsV0qOeQ3tGHllyRU81Y1PzqDnycQX0/TRcEfd
         tEsA==
X-Gm-Message-State: AOAM5309YQtsFiB77fO3HdvP65ve7vJChVoPKdG0cxt2+b5bJY250uA6
        jxOtNyGhng5H6W9lPifMbn+TRA==
X-Google-Smtp-Source: ABdhPJwGPpNyETRl4VuDPYZiIlH2eDa0br1azIegj/wzZtKCn4U41u9SncizzsUSeepmeQxRgh8NDQ==
X-Received: by 2002:aa7:824a:: with SMTP id e10mr1243727pfn.62.1599015234783;
        Tue, 01 Sep 2020 19:53:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm2560666pgo.17.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
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
Subject: [PATCH v7 4/5] x86/build: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:46 -0700
Message-Id: <20200902025347.2504702-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
References: <20200902025347.2504702-1-keescook@chromium.org>
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
index 4346ffb2e39f..154259f18b8b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
 LDFLAGS_vmlinux += -z max-page-size=0x200000
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
-- 
2.25.1

