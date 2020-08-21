Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A424E14A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHUTyy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHUTyR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB90C0617A9
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so1496755pgf.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsnjhsnTEGM+Cj4mkGtPoVyQesfOultuLxrGhrBG5/A=;
        b=BjCkHROY2CmoPNZCfAPOetFdIvdym0/mRthIj0PP/ZbxWLiS1o8kmsIYg0iFHhWFr8
         A1Ch9dHodBjR4Kgfc/+/25Zi2M2gQZpGoSfr+Pjwhdw6LLPfKoFH3OIlxQdx816GQUNA
         NreqRzvr9dx2ItAUVHWMIgobbpacT3nHTvf3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsnjhsnTEGM+Cj4mkGtPoVyQesfOultuLxrGhrBG5/A=;
        b=CvXXZMoWm/FXKhEFuygEpf0/Zr5Ii4vkTgh+UgLli/3qcoVbYs30o/CqUR0GkSQgEs
         jErFKdrSHSOBDisZe0TshMISEvbJL/FYQ09Yel8b8UF+KGAeK/d9s/U59fNekgWqWDGK
         4C8LeB/pX95ZmUlULtRMl8Mk2GYGJ9bWs5lC9O9Pqo7IJQHpJ9Tlfr04talsV1WlcoEs
         9/Cqid+ZUVLJZXrFApwozWW7AmWJwRnTon8T8fKtk3CuHROSht+H5gVyFBgmsUSSsfEx
         BeWzkrBc/skOPbM4D4CRb226KxFieHDgx5rHUKMEioYfn1+C4fio8liHSoWPOdG+PzSu
         b1UA==
X-Gm-Message-State: AOAM532TndE96tdabLDKINSQMOrB4v1eshMGp5fuZUSnnIP9j9gwujxE
        /Bwip8J/eCKvKp+AFILeFRix6w==
X-Google-Smtp-Source: ABdhPJyPCEIQonjaCu7PamGqZDSgUVRQO30q/exO3L7q+oKI5u+eXQ3pQsbPZBczuMA9B/OknhGw6g==
X-Received: by 2002:a63:2809:: with SMTP id o9mr3518924pgo.410.1598039646154;
        Fri, 21 Aug 2020 12:54:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r15sm3651023pfq.189.2020.08.21.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Subject: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
Date:   Fri, 21 Aug 2020 12:42:54 -0700
Message-Id: <20200821194310.3089815-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for warning on orphan sections, discard
unwanted non-zero-sized generated sections, and enforce other
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 16eb2ef806cd..6ccf19fd2b39 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -121,6 +121,14 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
+	       "Unexpected GOT/PLT entries detected!")
+
 	. = ALIGN(SEGMENT_ALIGN);
 	_etext = .;			/* End of text section */
 
@@ -243,6 +251,18 @@ SECTIONS
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.plt : {
+		*(.plt) *(.plt.*) *(.iplt) *(.igot)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	.data.rel.ro : { *(.data.rel.ro) }
+	ASSERT(SIZEOF(.data.rel.ro) == 0, "Unexpected RELRO detected!")
 }
 
 #include "image-vars.h"
-- 
2.25.1

