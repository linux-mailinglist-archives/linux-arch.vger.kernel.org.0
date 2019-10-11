Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AED34D2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJKAG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:06:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33114 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfJKAG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4959064pfl.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObCdg+imqB9G1d842Lgck/VSTqVGl2xoAH4cm4FkKow=;
        b=crQ1Wv7yU8u6QDGlDwBktMC8ID6kd2jR2ktjlIEg9lNMaYkSGp+vVyfOhN5n/bbb4w
         tpNmt7wW87sAgB/gHBbhR1BwKIxx8HWLuqxVFsB9sj+yjEeBVLxwYKqP8+nT6ULOb4qs
         C5n7z+PSjnqWQlNXFQHms0qNFflOzMMUW6V2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ObCdg+imqB9G1d842Lgck/VSTqVGl2xoAH4cm4FkKow=;
        b=sMIKWNdvWZWG90IzsT4YLJJRv3zhJTGVvvhaWWRuE/CdhNYRmwpVFBavsO9K1O807b
         VuCppESwQVsVjv2Hxgy0o0VK9pneHSJ5cl6Gvl2i3LUnkb+pw7pip9mOxGguHh5gtozl
         Li95Te41WqwQwCjxDgItHGeSd6a5VJv9ooMTmcGUW+/uuv5T2a4jVPKaMKiN7JpPX42G
         9YYTaMwBhrAmsRTz80JYQ/QeNP68sOc/NQdUylxDe3yklbYXttCS5F2sfGu7wiWrseDN
         7hTOIj40+oGzGrRFnef7A1Mm3IYejdd1zTSJs5x6qpM6alr3FBGoJEwfe14FUX3ugVWo
         vmBg==
X-Gm-Message-State: APjAAAXIpHzDtMUCQ28EaKD+W/o4EPiLZMqz9T7hSrZMTu3Fz+cpaz1w
        gjmG/ainCBs/r5+JUae1Z8zGfg==
X-Google-Smtp-Source: APXvYqx+lfPTpnvfcuRRBeqTz2GN8uCmPc7RnUYQGVmNn2nMH+aP0xZQtQocoZFSsUHXgigJlUoJog==
X-Received: by 2002:a63:fb0a:: with SMTP id o10mr13787560pgh.258.1570752382982;
        Thu, 10 Oct 2019 17:06:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k23sm9231444pgi.49.2019.10.10.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/29] powerpc: Rename PT_LOAD identifier "kernel" to "text"
Date:   Thu, 10 Oct 2019 17:05:43 -0700
Message-Id: <20191011000609.29728-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, rename the linker script
internal identifier for the PT_LOAD Program Header from "kernel" to
"text" to match other architectures.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a3c8492b2b19..e184a63aa5b0 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -18,7 +18,7 @@
 ENTRY(_stext)
 
 PHDRS {
-	kernel PT_LOAD FLAGS(7); /* RWX */
+	text PT_LOAD FLAGS(7); /* RWX */
 	note PT_NOTE FLAGS(0);
 }
 
@@ -63,7 +63,7 @@ SECTIONS
 #else /* !CONFIG_PPC64 */
 		HEAD_TEXT
 #endif
-	} :kernel
+	} :text
 
 	__head_end = .;
 
@@ -112,7 +112,7 @@ SECTIONS
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
 
-	} :kernel
+	} :text
 
 	. = ALIGN(ETEXT_ALIGN_SIZE);
 	_etext = .;
@@ -163,9 +163,9 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :note
+	NOTES :text :note
 	/* Restore program header away from PT_NOTE. */
-	.dummy : { *(.dummy) } :kernel
+	.dummy : { *(.dummy) } :text
 
 /*
  * Init sections discarded at runtime
@@ -180,7 +180,7 @@ SECTIONS
 #ifdef CONFIG_PPC64
 		*(.tramp.ftrace.init);
 #endif
-	} :kernel
+	} :text
 
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
-- 
2.17.1

