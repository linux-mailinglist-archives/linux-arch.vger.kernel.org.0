Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66C1234E7D
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGaXSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgGaXSQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D2C06179E
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so8525669pjq.5
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=d74fEfH+AJT4QLl/pweek9M8JQU04VeKWDA6U2gixgr/mciheG5Ezlv7MgN6Rb1HWY
         2OBg7xnc3sUVIMCFnR1Y+igiUqbxr8jaR2zt1f0TV1ldOv8LhbyjysXpqao6LAEOouE3
         Rwi1z6MIeG7fXDb29GK8Dc5L/EDvqKHqNhytQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=n7hzkAnCa8yQZ8tAaLKgnIJPurhYO7Ylhgkp+dAmmfoy4PntAIFZBI3R0YWJCJMm0J
         Z8kUWenLoq0Zsa9S9ZtVM7JnNmWCSYItIsFHXLUJ6K68/J+k1lt5ulw5hxrz9VarRf68
         HyCsbpgdh47HQUU6rP7ZqvPMpstjYcpbOfoD7FW+wPVc0uDsuSNbz5e3DmNfPaszbHIK
         aUboGi3IIdlJGs//M3fSqVB8u0I5+rprQA0Xf3KWW5vN0436UwWIb7I4DnWaxaJ5RDsZ
         vMVi4i/nb/kBFnDJ3PDPeRGMrgz+5U3iYvm7XFxW+hapFcCHfDhQRAJeUSE4jL8Piqtr
         DOBA==
X-Gm-Message-State: AOAM5303GT+F6piTAVbFSVupAFbEzl5p3KxkPExeYLHhy4U3xUlaI9Wx
        VBy+fp7B+Ey0vZHXex+jrc1HPA==
X-Google-Smtp-Source: ABdhPJy/UWkqz0kX/iI9reViU3q1mzpCLU62ykzIRw2Fvekz5tfwEf5puBHtXUakR6EdYyybPNSt/w==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr5482552plr.136.1596237494096;
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19sm11621350pfa.9.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
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
Subject: [PATCH v5 18/36] arm64/build: Use common DISCARDS in linker script
Date:   Fri, 31 Jul 2020 16:08:02 -0700
Message-Id: <20200731230820.1742553-19-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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
index b29081d16a70..5c1960406b08 100644
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
 	}
-- 
2.25.1

