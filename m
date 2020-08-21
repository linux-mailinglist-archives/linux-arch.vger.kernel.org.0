Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFE24E0F8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHUTpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHUTpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:45:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19597C061347
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q3so24020pls.11
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=hSwetOEXXxyxeqO2If++xh0K5ka/8LVM4nGggu0hSfsYxPm6EElfkKCKJXvMPutNd2
         +nEASJBRgtVPVNXEsdkY2ic7EKx+blKB8AzP2lSSIUTBVYnSjMvenCFrH6X5tNxRdcSy
         u0VnAuKKc+tad0YmxEFMvwCtQ4NCnqkFN296g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=MQZLJMx/OmdopmyrK5aT0OUX9fjadVJOZrCWzDngOs0Pdp8qOZjjweQKOrz/ObwPog
         NB7b2kfpbQ+Bl4EK3Ko0c2qOnf9O6tffiS0u+gCr4pkrjcMGuTKOe0U3RanILDcREYnL
         l8jckMaWBw1ti89hrTmACeKweD5KTQraF9IykuOv+XNSRwpA45m8nJ9aDaAW3Ym4LJny
         4lyj58Q2HxOs1cLi+0DIyDymbUC66/KkvlXPgxbGiEOFrTE3wKvDXuPMHcMVgTbxWboq
         boR/+/w9yeNTkenD2wV7NDpz4+zbIvmEl8FifikJPfPBzlDnByKGbcCaFezvX0w7O6l2
         XWTA==
X-Gm-Message-State: AOAM531i3DgMwmus7stnEXl2f2H1UxMBW67We/Ivj7MXTi23ks8dCFf4
        dGJlom6hYmd95YIYHViBYv30kQ==
X-Google-Smtp-Source: ABdhPJwFMRlTYY2KYKppAuaQC9yLtjntKg85fiBsI+6m2kKPSyZ8YXZJFboskYZxMwNbk8lwKTO2kw==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr3489157plo.289.1598039072600;
        Fri, 21 Aug 2020 12:44:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 207sm3467672pfz.203.2020.08.21.12.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Subject: [PATCH v6 17/29] arm/build: Add missing sections
Date:   Fri, 21 Aug 2020 12:42:58 -0700
Message-Id: <20200821194310.3089815-18-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add missing text stub sections .vfp11_veneer and .v4_bx, as well as
missing DWARF sections, when present in the build.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 4 +++-
 arch/arm/kernel/vmlinux-xip.lds.S  | 1 +
 arch/arm/kernel/vmlinux.lds.S      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index c4af5182ab48..6624dd97475c 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -59,7 +59,9 @@
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
-		*(.glue_7t)
+		*(.glue_7t)						\
+		*(.vfp11_veneer)                                        \
+		*(.v4_bx)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 57fcbf55f913..11ffa79751da 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,6 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1d3d3b599635..dc672fe35de3 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
-- 
2.25.1

