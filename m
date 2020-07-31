Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60C234E6A
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGaXS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgGaXST (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1DC061756
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z188so7342588pfc.6
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=d1nsCRiVeR5V7xSyyra8TUXkzVGGZyVGicIMpvsBxz4UYBltmv2pChbuD9HAWx1JRZ
         nTzgrAEI4ydMYR6/86qDA5RBERE0C3DwH6MGQ/ocUxKfyvRkYDsOGgPU8V7aUbsGFQfr
         K/ypLFr1ufBcI2TdFJYN71D2tSdiicMgRSswc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=mvuyCkuUnDkywUHFSkO0aQ2wO5Vp0R14P3KpmDeFbuvlWneWd/87hdjgC+eGUljpAW
         6NdtaLmaqVFhGG1/MPK0pghNqtcIjmvs58qxpw7M4K5G8dQhm3zSFGEKimtbjXedrEcM
         hp/OWh88MIqmdqTvX+ITp+4q5xPqtQ1TRyspEmVi9NtU26BmdUvcdhLTtdysUbQubYj1
         De2AFDn4aAcOz7O3lH0iaJKvZZKi5Fwq3PhFbt1Z6stu0YZQZMe5EGnujWk31X+zaCJa
         D6rCBfD54bBmQuyn7t7vlokhANBNKx2Pc0CufOEcqPS5qWAETQBA1ACJYM9qTyRKRabf
         rPoA==
X-Gm-Message-State: AOAM53320UHGTHeHNB5cog5NchqK/4hbaTd4B/lhywvo4TdL9zXc8xLj
        PSD7+kX1tf8kpGYq9F2wTtuHIg==
X-Google-Smtp-Source: ABdhPJylqiQpL9f/Meacfle4u2dUrOQCvbKxNn7AAVKGg1HE/JSZSV2cXWPDWp4nKgsIRycs40SrKA==
X-Received: by 2002:a62:2546:: with SMTP id l67mr5959404pfl.154.1596237499260;
        Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c2sm11380501pgb.52.2020.07.31.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:15 -0700 (PDT)
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
Subject: [PATCH v5 24/36] arm/build: Add missing sections
Date:   Fri, 31 Jul 2020 16:08:08 -0700
Message-Id: <20200731230820.1742553-25-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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

