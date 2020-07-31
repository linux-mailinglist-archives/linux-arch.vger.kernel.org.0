Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5204234E70
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGaXSd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGaXST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FB2C0617A9
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so5009553plb.12
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTlH0MxU2Zy7x/fgIfuiZYJNDywGHlIxz6xu6/7rQq0=;
        b=XZ/hdSqGOXxtc3cUCRpcO3X+flbjfzVQ9wRzdah5JRxSjtKauEC+KmC6JKLNVw6K0I
         0odKqTFybGrYU3HrvRFA6uTa+ZpJfhVd4ftn5sSo4zWNF0KyI4iOS2pUVCJ6VEYKS+Za
         zJ5gM/J22lvp+RGJ6myvn1iQm4hMGsG/qPnG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTlH0MxU2Zy7x/fgIfuiZYJNDywGHlIxz6xu6/7rQq0=;
        b=agWuZwRgxbiFIinvx9FFKquOtxMuPkyrR0GSg36AoulmcEqxEliS4obyDEprS7NDeC
         dzTfAoZFwpzsojKooFofLORTe5Gf0CsIRi2Yg/6bCXD7ky7dK2NxuPIiXS4bPiTRa9dQ
         OEnNXayE6Xy6e1DYGwZZLxRaAFKLZIhm9k4s7VKvUu7LVeiHevd87Lnab6YDyq7W93cr
         V/p7zcCJlnhtsz0Req+tR+Mhc2KCHSdC+5eKYHSuuPkEBvr3uzjtreCPtDRKKBcTZSi8
         vpH9sFxMCAPoKIACTwWpoOTaH/CAFk83ZMu5Og/JksZZhjAWoethhMcf3lOdAbs7Bv7g
         CHig==
X-Gm-Message-State: AOAM531AaBs997QfMpmyyGC3yCnVbv6hNepkW4hAqzGCLcw+2skDA1pl
        +jAlrnWF7NoUXX805iCmOc4QpA==
X-Google-Smtp-Source: ABdhPJzf0olkAIljTwX2os818gCPZMZcjJOtgbWSTwGCt5MV/6unatQm6z/7QVNN+viuWaDDBfNmHQ==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr5716481plk.198.1596237496047;
        Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mj6sm10153236pjb.15.2020.07.31.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Subject: [PATCH v5 15/36] arm64/mm: Remove needless section quotes
Date:   Fri, 31 Jul 2020 16:07:59 -0700
Message-Id: <20200731230820.1742553-16-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1

