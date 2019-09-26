Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4CBF846
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfIZR5A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:57:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34130 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfIZR4b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so2280610pfa.1
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lY3gLtq1yv4TCNLsCOhid7qXT7bvA83WxioIIIqFVXA=;
        b=Ki0F6+sLs6VORroy0ffqnJseBA7QSYUqd1wFP0NbS4cak1Wh3YkGMRzQvtEEccudzG
         edctuQ/eEwwU5sHQJ5XfK3VeDlq6muLK9g3jC02FBRdOySPAoLy0gCS9CBjGysbAQtpV
         XAVWcStOY/x6BsVgnubCCJ1P6LNHIFc/5/2+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lY3gLtq1yv4TCNLsCOhid7qXT7bvA83WxioIIIqFVXA=;
        b=Adumr85ktfhVHXk9rTV0v3EQFgHyKYeFTylKB1caqPBSQRcZNyfxv8FvSLIVdrCrvd
         rngrgzygYrU6BBxnaa/gOdH6ZQsnp1VmrH2+cPWD6TZxKffQ53kq0a0/BKURwtS2xxI1
         0ahqWRixpQnunMIIPu+iV4L2Cc6yK37Yugh/E8pCGT2rb0PHAynYp4SEYhc3Ng2TqqQq
         3YAtA9hW9sTozffatv/M/Ve7tCMLfp21hXnN4S0OPnTjqUsb4DrSSmFDNSqUoNuAlqra
         CVx1KB6RYJZsKzx9fsi2YyaGoLS+lwwhw/+5lJ8N+2v0Ly88RYBUTn18j4T9/gOJE7v1
         8APA==
X-Gm-Message-State: APjAAAXCTAupXpFJihOip/c5TF1PzILHF2mJlfDbSmUviJc+G3Js6JQ8
        lcnzWi5gbpdvhRGy6neUxKyezEHj67k=
X-Google-Smtp-Source: APXvYqzUFG+7+GBGC0jBD0+mR//mqQSm/qKVQf8bQR8gVQHifb6ysRylAOP5049ta8XmpDzMuRucBg==
X-Received: by 2002:a65:500d:: with SMTP id f13mr4684873pgo.359.1569520591224;
        Thu, 26 Sep 2019 10:56:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm2842378pgd.87.2019.09.26.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/29] xtensa: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:58 -0700
Message-Id: <20190926175602.33098-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The EXCEPTION_TABLE is read-only, so collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/xtensa/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index bdbd7c4056c1..7341964722ae 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -14,6 +14,8 @@
  * Joe Taylor <joe@tensilica.com, joetylr@yahoo.com>
  */
 
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	16
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

