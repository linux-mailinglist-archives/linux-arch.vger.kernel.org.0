Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514B3234E26
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgGaXJb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgGaXIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1BC06138D
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so5417525pgf.7
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=klOQguEyjL+W3pS7h757dA97Jss1XwCr9uiod+TUnQnifo+W8HZxqnhpghrEPuhfhz
         orOov5palRtEjwarVacfnfixNz/3aBq8qsEHACSBEYKMfnct6CzEpn+hdJxpAimvvV6n
         TfN5kHYecvHl4EkWHkAnabuO4KrAoCTvFJ6U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=gysjFOwwjBlYXwjsEpuGPUZVO8bWTJX5NRZ3CUB4UEQKxy+iABDaDlnZ0jnqZc0rVU
         tq47rzDq3+Yc+bplCPfYo9gz4j2PRSikq64WrGvEgsv4dLZZ2b/qrb9JvkZTNKz+6zh5
         4VugOkDGmMHPILmN5N+EC/M9HFPF9afm67VICSZGYcq0VI9cZ6afsG0igRPCkikEDeHX
         slLyJdVFo08YFycNVuxG7hGxLWOdVCnkeL2JYSoV9rFKu5i+ceCQEO0QmwgLWlJolDKk
         zc6ByIoLbNvoDCiiEtP3cBJCzlg1qPJydam8+KMomevpe3ucdbXnwArMepCPGJ9Mrkp6
         nV8A==
X-Gm-Message-State: AOAM530GoBKTfuZLaQknU/w/Zbdb41HwvucmF+008T1qmCioBQHa1CoQ
        yGHz/J2XSvH0lVfsQLYnt8XLUA==
X-Google-Smtp-Source: ABdhPJz/K7Q0NhIe2TN23D0lBoo8o7R9UHhN6RM4BLn3KCwsvDLXrhht2x1eWmeoEfDbj/ppP75PXg==
X-Received: by 2002:a65:408b:: with SMTP id t11mr5660099pgp.407.1596236922651;
        Fri, 31 Jul 2020 16:08:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m31sm10905376pjb.52.2020.07.31.16.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v5 16/36] arm64/kernel: Remove needless Call Frame Information annotations
Date:   Fri, 31 Jul 2020 16:08:00 -0700
Message-Id: <20200731230820.1742553-17-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove last instance of an .eh_frame section by removing the needless Call
Frame Information annotations which were likely leftovers from 32-bit arm.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/smccc-call.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
-- 
2.25.1

