Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5BD3583
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJKANY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:13:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44082 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJKANA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:13:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so4931404pfn.11
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FW8b8NX2lcqvjxUkqurmeLymDZQTO5emHjisNR3IdMA=;
        b=P4Fuk21mSaKNwFMUmZxSt/IIxNtkXj+Ys/JxlgIct6Hlb4B3yXk/i320iivrHPWx5w
         hPi5AFgp8NwZicAqmOBJvk6GzGKldRwbd/3LLSi/srLk+eGZ7yRithSSv41nscZhF3Dk
         GELZr5uH3JzvVYuz2LSeaVERr6mu//7mpofAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FW8b8NX2lcqvjxUkqurmeLymDZQTO5emHjisNR3IdMA=;
        b=gIpV/5jE0OvNe3MFN9rf3BMbpct3YWVu5b5nSYaEAu5hr6Jxeg5GpDkPgO1Kx+xR0a
         990sC2nGbJmKlboOgYg8qC5XSmQ/o/F9FSH1oW7ymuNG7ksHMFdtizQpFKWw2CSalB3V
         PbjHxcC86nRKEONxcNLXknOoDL+OCtN60qlhQWowu6q49ZEynIIZgvVVOy0NbyK8XIVD
         lmasXJ+2yJmVP5elVQyhUkDc/4PaNZCLPUcPd8i0f2eYnj/QRe4rCdmxRr2/3lr/hkQf
         rt7I7Tw/CNvbGR9GVbqRVMbXtUneoIkfdrNfbSC95+yLFfHAJ1P1DuPZKu2j6RCgTFfI
         RbCQ==
X-Gm-Message-State: APjAAAW41kvvN4JY5kShIM7FEdVkYKOiH9QKfan6dmy0kz0CmSELqlSL
        xNPxZKYSTboBx/5kzTrS9C7CuA==
X-Google-Smtp-Source: APXvYqwSt3lft0x1k4gSFxtu2q9aicPcZGAiZFY9usQRrxAus3R2IZvqQ+Z/MfqEoiJ8yKOquglteA==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr14385157pje.133.1570752779910;
        Thu, 10 Oct 2019 17:12:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7sm5985112pgx.26.2019.10.10.17.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:56 -0700 (PDT)
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
Subject: [PATCH v2 18/29] arm64: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:05:58 -0700
Message-Id: <20191011000609.29728-19-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA. Also
removes the redundant ALIGN, which is already present at the end of the
RO_DATA macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index a4b3e6c0680c..9128a26eb45b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -5,6 +5,8 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
  */
 
+#define RO_EXCEPTION_TABLE_ALIGN	8
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
@@ -135,10 +137,9 @@ SECTIONS
 	. = ALIGN(SEGMENT_ALIGN);
 	_etext = .;			/* End of text section */
 
-	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
-	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
+	/* everything from this point to __init_begin will be marked RO NX */
+	RO_DATA(PAGE_SIZE)
 
-	. = ALIGN(PAGE_SIZE);
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 
-- 
2.17.1

