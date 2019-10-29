Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE7E91E4
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfJ2VUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:20:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbfJ2VUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:20:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id u9so3786pfn.4
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6NYi1SpcPEk1nAcODb6GN96JVcdeHOxwVojV0owHqow=;
        b=dNy1CZ6LVOC5Xwy361W5/FOiLjIeZ1a3UnC8UVfqNFHlsVQ8qbaqjGnKLGJCwZ4kjW
         R9OofJoUgLk3AYwWdNoTsAeWT8lvKhX3jyPzcDsVrpYn7dDwO7ngiDpQ9N4Jp5AybLbF
         IvOGqmpRh0nWfHe5uyqSfrp6ttnHKPg3vSxs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6NYi1SpcPEk1nAcODb6GN96JVcdeHOxwVojV0owHqow=;
        b=Y8c/lkCIjTgYhN8ZAj1d9vpRu6Hp3V5tcJMuhTaQth5SqObYdKAgmeizbIU7o7TUR/
         9MwmWrZ++erQkri6frWJGgmLl8SIpSDPNvyNwT7JPIMoJYw3vcPviyouFp/q2+zjtphw
         erhvw7qRqVLkw2XBfM5uLONTdMh4D6iSP1BJqIEW4Oj5HqGGg4giPlOIaydMEUsfOQFh
         FVbbJwUWFMdOPPmGY7miaCyCZlG5r5YPjtwdoccIv1ngJcMSRCYudEOIUS4ZNwPmi0Du
         V+Ye81GckTH1nKKdEf9hPJ1qXsRLV2Bi4b9Kh0TdyDAwA9szooasTOq4WN9dCB6kxXL3
         QyWw==
X-Gm-Message-State: APjAAAVoyOQ85M3oB32/ihvpZoYzsoWf9inttkwuaxTh++OOSI8V/QEC
        is2SSvsiRAFT6dcT/Q7bYATEZA==
X-Google-Smtp-Source: APXvYqwXkyOdxRjPJDw9RQKLanWP+r60JXUsvq8Thfmh0vWjgoChchb/tzi5pjG59oK1fgBkYf+n6Q==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr9331544pjl.63.1572384042527;
        Tue, 29 Oct 2019 14:20:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v25sm47257pfn.78.2019.10.29.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:20:38 -0700 (PDT)
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
Subject: [PATCH v3 25/29] xtensa: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Tue, 29 Oct 2019 14:13:47 -0700
Message-Id: <20191029211351.13243-26-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
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

