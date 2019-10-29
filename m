Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08079E9144
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJ2VOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2VOD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so10509367pgt.7
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MxClQbH59XRrbTRajW1Gh8uACzcU2+htsVcXyM7D1g=;
        b=LQy1OlzqoHregmX7oWg1J+GCiPB+DnhcNeAFzNXO6O9s9wLhpCBsF0jSKzXlK9lP/k
         SDnj0o9+xZ39dyE9cCQWqZxyjuoHNyl3rdCu/xiTRCFpDNUVVX7tFk5VZETqdUPMammV
         NH8kU7Tb11dukK+QDn0fvxLsZMYk5M8Ahi8aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MxClQbH59XRrbTRajW1Gh8uACzcU2+htsVcXyM7D1g=;
        b=HVN/UoyNYoYyluD2146EYzo0To7w23V5IX5J2eUgWtkWFxwQGms9iMiq2mHutEkkIS
         Su/nOkhKc0MmAzCRAA/Y7BxkD5q8A1PI17PlVfc2qmUk65GjqfTJ521jRfswWXwVKpnr
         pKKmLmn/ukUKzJXPs+MHHVuhC6pHlyjO/CrHpRLaRg3hjob7ZMOX9IcsH9xQcdM9gNVh
         8dRYl/jDE9gn/8rUFvei0BJ0eVAum8YkVgfP1/zFVuxhB69iUxV4aVLrrlOlOJlwGpGE
         2z3N+fizLvGVujYWgViWsR0QhRbjNVtTc0KwucxVKbzCGKBtRkeYSN7e4phbnLjF7c94
         wiiw==
X-Gm-Message-State: APjAAAUMUUMWCqkf1kl9ONSsb/xQplthraopJYIrXQQZEcaREo/Fb57C
        2e/dnUOfXF+maDiDACXk3i2Dzg==
X-Google-Smtp-Source: APXvYqzb5TnssM+4Kax/lIY7+ocxpNqcjOJlOJ6nd7kpeZ9S4qL0Qt7FLOUhwi50TM1MUY+x1dQPhQ==
X-Received: by 2002:a63:3f8e:: with SMTP id m136mr30665411pga.213.1572383641052;
        Tue, 29 Oct 2019 14:14:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i126sm47757pfc.29.2019.10.29.14.13.59
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
Subject: [PATCH v3 04/29] alpha: Rename PT_LOAD identifier "kernel" to "text"
Date:   Tue, 29 Oct 2019 14:13:26 -0700
Message-Id: <20191029211351.13243-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, rename the linker script
internal identifier for the PT_LOAD Program Header from "kernel" to
"text" to match other architectures.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index c4b5ceceab52..781090cacc96 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -8,7 +8,7 @@
 OUTPUT_FORMAT("elf64-alpha")
 OUTPUT_ARCH(alpha)
 ENTRY(__start)
-PHDRS { kernel PT_LOAD; note PT_NOTE; }
+PHDRS { text PT_LOAD; note PT_NOTE; }
 jiffies = jiffies_64;
 SECTIONS
 {
@@ -27,14 +27,14 @@ SECTIONS
 		LOCK_TEXT
 		*(.fixup)
 		*(.gnu.warning)
-	} :kernel
+	} :text
 	swapper_pg_dir = SWAPPER_PGD;
 	_etext = .;	/* End of text section */
 
-	NOTES :kernel :note
+	NOTES :text :note
 	.dummy : {
 		*(.dummy)
-	} :kernel
+	} :text
 
 	RODATA
 	EXCEPTION_TABLE(16)
-- 
2.17.1

