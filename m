Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E146ED3524
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfJKAG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:06:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36217 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfJKAGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so4947042pfr.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MxClQbH59XRrbTRajW1Gh8uACzcU2+htsVcXyM7D1g=;
        b=TBJeuKMY2z8zTRQ1bFw/ImZS5YFoYQAHk+uSCJMry9jQKOeGheQ5i7gXGHU01GWcTB
         uOgoFqPErAXZia+mP12x9qnkRfY1Ys9PjUB5SmB5We4kWHLZQ5n99yhQi0dIKcFUZu6/
         hILLkVhE9upOn1PuRtaesOlh4SL00TV9kLm5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MxClQbH59XRrbTRajW1Gh8uACzcU2+htsVcXyM7D1g=;
        b=rJ+kUDqI3NU+uK4XuEzWGxWnN7CnhzViEh4VWEc1+ppfR43K9bClPr0dKrGHGPmARq
         b8Qr1m/oHqb5iDCGltt7XKniq/DPUUNfkunG8XMBVTFaV0VeDfL1KtuMLIBBqesx865V
         Tbp0m9WpMLuMqsUzYIRwKq5PBde4QFgs6STFjb0Ew/vgo0dy5uQoEe0+CVCOhB4jMu5X
         PN9WRMNa6+rlmyH4rQu/HUo6sc8cekfCEuy2A63HCyfLMfoRkeSj0GyKO4Mea2BEkQFH
         fryBRC4djtG924EIe87+q6kxZRVYbTQbsUZKkjlUuBjFmWrAQS9+1WkDawNj44/gqVpb
         XKqw==
X-Gm-Message-State: APjAAAUqepMr7HQaos8eI2qJl0sgde/lnlAw2yGenJgYvg7YQX+C5emd
        Jt195ar+A/cItpFoshMgSP07Qg==
X-Google-Smtp-Source: APXvYqwg7IWyK5GALjp45zOGgCtbjryTtA5MoWvVIZiHDTE9GJEt+Ue8rYJCs4VD37qrCGGbQgqtBg==
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr12930072pfb.180.1570752383534;
        Thu, 10 Oct 2019 17:06:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm5372814pjw.31.2019.10.10.17.06.19
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
Subject: [PATCH v2 04/29] alpha: Rename PT_LOAD identifier "kernel" to "text"
Date:   Thu, 10 Oct 2019 17:05:44 -0700
Message-Id: <20191011000609.29728-5-keescook@chromium.org>
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

