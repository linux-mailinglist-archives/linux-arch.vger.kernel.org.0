Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C2E9171
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfJ2VOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42195 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfJ2VOR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so10518896pfj.9
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=BLxlII5rDGoHmuigiKEk7antvAdvT/j3giLp5TnKagC9nulTOKvHicMJhgLTJ+AKjt
         LLFa576ZnM7bbaXQ2jb97Idx+ncHmLJpJMLmr4o4toROhc1fZICnCkh73tOmvHe/0Lk5
         zMTVw0I0Iv5ESqJhCqUkt09+m+oXMu/pMXKQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=pTvmWWDc2PBgsAzKbBU2j4EUljIXLqmWcO0w4JcNrYPq9m4MRT03WHRvZxzbls91lT
         Lk9soQDwghFdx5pcPtjqrWrN73252BbKuCv9lDVUAJm2+lGrgXOeQdEReul1CBI1b1ul
         tWeBruTOO5wd8yZIBw0m/DbRLPEqOUQeaoitywkarSoWsUaPULmZxaxGpTgMbXv7j8Da
         PC350aK6uyYaMNcD8g2onTqTysyapemKq88x1rRJUBxiqR76Qm43UlFwQKtyen71GxPe
         9QLUW9o/nVRZ5BvAhiKtEKViv4H+t4rl02ecYxmbrWrh+K8Kf1u8UaR+KXbUuInVLuj7
         N5Xw==
X-Gm-Message-State: APjAAAWdg1mVcLJcV56A0hMYk2Qgu+bq7xqJMslfJof5yG/ZnxzDh7fD
        rZ6onGwyKLYASQNjs1YzheXlVq7HUHc=
X-Google-Smtp-Source: APXvYqxIz8Zfja85HNwsMZQJeGaOSKeaS1VAjTfMrFhoCZX55Emhn1vDqjO4e6bfN5HPCuUgRo1k5w==
X-Received: by 2002:a63:364d:: with SMTP id d74mr5244833pga.408.1572383655700;
        Tue, 29 Oct 2019 14:14:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p6sm49172pfn.26.2019.10.29.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:12 -0700 (PDT)
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
Subject: [PATCH v3 16/29] x86: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Tue, 29 Oct 2019 14:13:38 -0700
Message-Id: <20191029211351.13243-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The exception table was needlessly marked executable. In preparation
for execute-only memory, move the table into the RO_DATA segment via
the new macro that can be used by any architectures that want to make
a similar consolidation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a1a758e25b2b..b06d6e1188de 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -22,6 +22,7 @@
 #endif
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
@@ -145,8 +146,6 @@ SECTIONS
 #endif
 	} :text = 0x9090
 
-	EXCEPTION_TABLE(16)
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

