Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC6E9151
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfJ2VOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfJ2VOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so10481803pgd.11
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUB0MN6IjH7KcACf0jON8xeDsmoKIFP2Ldh5d1L6UPI=;
        b=Mf8D0saeSN+0m1YpxFdkmvjwDLF69xca5s60V1U26r/aG9tDbY+KmdSEZ+ycIlGrdm
         fJay3bujo2c2izvt9E/Xr7795kKH5LjAp715+5k8tVYty/z0ImtxaP1C8iM07/GXFMce
         avtalpOy9rw451gCCfHNsjmH0eMt4o1fE+6Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUB0MN6IjH7KcACf0jON8xeDsmoKIFP2Ldh5d1L6UPI=;
        b=GSngdVfJOHubAWJhVyFTryiURgENEjNJ/Cx+VqZnRRxiI+FIag4qPO7VwbhQ/djAQg
         PuT1s/gbvPifAaQq29GSctZXWB+7FxLSDbwBAf49lbwPnS8pM1K9ChumjcHlNLmcVEZ7
         1/CabL3bbYgFtt5JsMfODygHtF04FTQtvSdJsMFiePWVWv7mDTyzjq6W+gVinc2I9M+w
         OSwS4yAOj3wpCl9ZGSYaN2br0e4e8i4dL4Hgvyk1dSZsXAprwRrkdprNxAxY+7nunJYF
         3VNWyIpR4jMa6Tp6psA3KfOcJ3cUYzxTzixa+v0FEf5HZm57oZM83rNZO26FcBrzdnG6
         tdNw==
X-Gm-Message-State: APjAAAXlJFT5KbfHiiNVN4ypVZiktjpEDoR9dSVxDHq8kGn+UtC5lfUs
        v7YDV6vHfgSjJmr1Myqu32oZ+A==
X-Google-Smtp-Source: APXvYqyam6Nj/3qGHt41KW7lrAi/B4rZMlVCWM/rpmjyHxsuoq9yc40ldr6w0Vf1EPp7DW/iR8X5qQ==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr3843926pfi.73.1572383644781;
        Tue, 29 Oct 2019 14:14:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c26sm25490pfo.173.2019.10.29.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 02/29] powerpc: Remove PT_NOTE workaround
Date:   Tue, 29 Oct 2019 14:13:24 -0700
Message-Id: <20191029211351.13243-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, remove the PT_NOTE
workaround since the kernel requires at least gcc 4.6 now.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 81e672654789..a3c8492b2b19 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -20,20 +20,6 @@ ENTRY(_stext)
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
 	note PT_NOTE FLAGS(0);
-	dummy PT_NOTE FLAGS(0);
-
-	/* binutils < 2.18 has a bug that makes it misbehave when taking an
-	   ELF file with all segments at load address 0 as input.  This
-	   happens when running "strip" on vmlinux, because of the AT() magic
-	   in this linker script.  People using GCC >= 4.2 won't run into
-	   this problem, because the "build-id" support will put some data
-	   into the "notes" segment (at a non-zero load address).
-
-	   To work around this, we force some data into both the "dummy"
-	   segment and the kernel segment, so the dummy segment will get a
-	   non-zero load address.  It's not enough to always create the
-	   "notes" segment, since if nothing gets assigned to it, its load
-	   address will be zero.  */
 }
 
 #ifdef CONFIG_PPC64
@@ -178,14 +164,8 @@ SECTIONS
 	EXCEPTION_TABLE(0)
 
 	NOTES :kernel :note
-
-	/* The dummy segment contents for the bug workaround mentioned above
-	   near PHDRS.  */
-	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0)
-		LONG(0)
-		LONG(0)
-	} :kernel :dummy
+	/* Restore program header away from PT_NOTE. */
+	.dummy : { *(.dummy) } :kernel
 
 /*
  * Init sections discarded at runtime
-- 
2.17.1

