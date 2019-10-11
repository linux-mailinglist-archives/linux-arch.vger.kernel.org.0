Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22894D359C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfJKANj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:13:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39884 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfJKAMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:12:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so4954606pff.6
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aXC4EKkSKWAzbgJ5UkNW5ASNd77O0uNGfoVDwB8PV7o=;
        b=QKMy1WMIao8eo2h9Q1TmJ+NvwxmYIJS5BiRFvnKXyWnyHt2NVU1sSJRyaYkSK0bnTI
         3g26hGi2M+7oPqpQxxO8mfA0+ckl3W/NOZq89OJYBy8zqpl256YQ/kRKmZl3wcK/Al8o
         WR97u6SnuI6udJBDDM4eXoslNY2BMQS6h8HHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aXC4EKkSKWAzbgJ5UkNW5ASNd77O0uNGfoVDwB8PV7o=;
        b=apNG3PLDwI0EIIRn04CXJUZC20v+t/LEoPd5FSkHz0vKbBWNSC9tNJKcoWDQWgWBrJ
         s3PUmM8NFBEacCh1i8+3Dt8tCKOzSEjkHUXSy5M91qbbAjrRS8ZbrYe+CRB/ymMm8kRo
         GDO6qKM+vj+lsHJ9v0RYTsel5KIlJryE1RPLLRFCvaDa77qy+XN7qnzhllWZqFvgRlHV
         2FZM8a4IlZ7z/M3xGefQ7B19w1IDSuMeCgDDKzYJ4tSmYEDp9hdII1MfLy1GcSATqxXg
         Jt7KXuBYJ27czVbamAKzhA05ZDLDo9Y3ckSpjSCosGlA2YnMeG0TYha4F+f41SaOCesi
         doPg==
X-Gm-Message-State: APjAAAV6QweyTDeK2I3PFEKaICY7pvlL+e9nzO9Ek0MO34Ny0p+Jhud6
        CVtQBMx/r1YFgk1R17JanUCTCA==
X-Google-Smtp-Source: APXvYqwyN8mvkbsH6LAVRfjY92v44FJMaCqPYldcWqY2MvbBlNQ7Douul4dniL7y8RNurjH2A60mLg==
X-Received: by 2002:a17:90a:1617:: with SMTP id n23mr14581628pja.75.1570752773811;
        Thu, 10 Oct 2019 17:12:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm5837436pjq.3.2019.10.10.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:52 -0700 (PDT)
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
Subject: [PATCH v2 25/29] xtensa: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:05 -0700
Message-Id: <20191011000609.29728-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/xtensa/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index bdbd7c4056c1..0043d5858f14 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -14,6 +14,8 @@
  * Joe Taylor <joe@tensilica.com, joetylr@yahoo.com>
  */
 
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
@@ -130,7 +132,6 @@ SECTIONS
 
   .fixup   : { *(.fixup) }
 
-  EXCEPTION_TABLE(16)
   /* Data section */
 
   _sdata = .;
-- 
2.17.1

