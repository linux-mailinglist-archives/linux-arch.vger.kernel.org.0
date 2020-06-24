Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B02069CD
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgFXBuH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388590AbgFXBt4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01039C061796
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so330788plo.7
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=j28MIPdYYt3rY4/fE2dihfZR9TtTRv8EMgAkzm1ilSN6UZi55d+226fwO0IcvhUj4K
         vHHrxFoODLtRR/epcOqkEuSfW+ofLwENnqR5DFbYOepfBQg9RkNmTQqNF+kXA9wtnTS1
         Tk9UTZMAwnTwdOtIjCCjIuRRK9aYxJ1pREKZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=Oc9rvCy86wtkQkuf3T0JYqkQ1Fh5R25QiQIL1Pccb/pSReEUPwqAYSnGE/fro5cljA
         SrApD5XbcYHO2UCftNowivnaUOOvDV9+6c8bzrR/nxbbhmQV/L3sBOJL9yVN6WsGylWt
         VrflIJZodA/2xkwEqmVj91fou8cNHngsYuBh4zbTkCIscJvGtPMH7A8onP1nLBfbL4qn
         K4y/vhtK7Xs3SahKRA8egSFINmLB2x/RY/f5SQN+WVgiZAiQRwC4xAI91nijyTisT9Ju
         sJA8ZTgrJfgpR3Tu7R4oleGMrB9MngLyC1fBDKroNfJ6WhPRjzW1Rly4q/PyiXRC4Rl5
         H6KA==
X-Gm-Message-State: AOAM530rz5B/zAri6tnhglXarhYJpXrjDw0ggMtAI3j2u6MPk7DXwyGe
        Hw6SWHB7yumyGTN2keuqSayPSQ==
X-Google-Smtp-Source: ABdhPJx8Traz2lKjHxXn0KSX6VTp95qm0SkAntTLnpPXidTYMSKWi0+Ran7jdJt/zuP45e018upD0A==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr24514257pjf.187.1592963394576;
        Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cv3sm3283177pjb.45.2020.06.23.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
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
Subject: [PATCH v3 8/9] arm64/build: Use common DISCARDS in linker script
Date:   Tue, 23 Jun 2020 18:49:39 -0700
Message-Id: <20200624014940.1204448-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..5427f502c3a6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -89,10 +90,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.25.1

