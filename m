Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36396D3527
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfJKAHY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:07:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38505 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJKAGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so4692080pgi.5
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WqLTzjTdYtu13eBI1Hsh3syPKd5R5C/bZSENvznkqN8=;
        b=fUPnxPNkLbKz79eLdwRoDJjW70ASz4RGYombh+MpItuFQQCQWGWcKvPqy4gl6E62bz
         YXcrXM4MjXChDuBwxAdJsCaz9rjKO2RPeC3DbmTKU7AZ15ypootuMHyTiE2LYXks+fRY
         MfiZIZu5Q++w2SE3zrFSij8n4HmJ+XDt2oi0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WqLTzjTdYtu13eBI1Hsh3syPKd5R5C/bZSENvznkqN8=;
        b=lCCJlWZnHZHRxhRIPZ7v0eFHUEl3fNPOCPlmjzKzCci0OmNq+5dVX3KNOvYjqroHZk
         TB4dGXFIkvTrFfYyLJ2aoqoVuvRrpMkhZkLcd+5RIcCiCOp4aKnmtfQ13TJc1zR6LLZW
         V6zKEvSSVGe9YHteRf6OLWBjYH13n2WSOOeRq6qHj9JfCRWWc5gpaxdzOIEtaeDQl5f0
         6cuKfTLXoNrftGdOPSyoG+N1KDrr7JyP6xoPvAZ50obqu9Wii0MDsi5hxTR94jSUl4Cu
         8MyYHYP50ZPNPowIIlm+CRFIz+2G9cTW0kfgAtI+Ignp6ek4Cc7NYdF2fsGYJEedcpja
         DGJA==
X-Gm-Message-State: APjAAAV+atxl+rm/kxwTlgXICWZwk79MPRdmSmRkukGkz55JcPSO631g
        Lkp4xuvXeanEsUr66r0DDD0ohQ==
X-Google-Smtp-Source: APXvYqwSvIKQzn0Wh29UPciSLsyXo4RVbmYIVzpELs7182W3aoZycw+TLoXbSJd3JfRFzRbTSmYlrw==
X-Received: by 2002:a63:fb0a:: with SMTP id o10mr13787651pgh.258.1570752384285;
        Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e192sm9402924pfh.83.2019.10.10.17.06.19
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
Subject: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Date:   Thu, 10 Oct 2019 17:05:41 -0700
Message-Id: <20191011000609.29728-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Program Header identifiers are internal to the linker scripts. In
preparation for moving the NOTES segment declaration into RO_DATA,
standardize the identifier for the PT_NOTE entry to "note" as used by
all other architectures that emit PT_NOTE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..81e672654789 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -19,7 +19,7 @@ ENTRY(_stext)
 
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
-	notes PT_NOTE FLAGS(0);
+	note PT_NOTE FLAGS(0);
 	dummy PT_NOTE FLAGS(0);
 
 	/* binutils < 2.18 has a bug that makes it misbehave when taking an
@@ -177,7 +177,7 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :notes
+	NOTES :kernel :note
 
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
-- 
2.17.1

