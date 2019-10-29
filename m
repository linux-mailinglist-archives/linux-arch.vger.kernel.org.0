Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5FE9175
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfJ2VOU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32891 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbfJ2VOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so10524793pgo.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+J574mlC+dRmZJG9pHhpppQFEze5VvTPTaNiTnbyaQ=;
        b=XxYZzxUJLSS1EjXOu0N/W8WJ4nsXkGW0wuYPPQz4S9Q7ybSmxfOvzX4/Pbx0hRVhwL
         IrpMdG7OEhiyZc3pXm3O/EWpZWxxrVnOcBtrFviHXzAXJGTEX7UE4FQN2re4YmyUukvg
         kN8X/p4Rc2H96j4CDSRi5o2KB2cQvjaVsgVbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+J574mlC+dRmZJG9pHhpppQFEze5VvTPTaNiTnbyaQ=;
        b=hhEW4fKx07OPlyWF8++oSQZsHSfFbzPf2m38uDZVxDbXt+9VX33Nbc/XCkxJVZwBtN
         2jdFAJOxkzE+ENLov9D6n5RB8Hm28u+QDjsrFq4WQ4szvlH1b+LdMjUhbladNGZ6hGu0
         dxpWpCFr4OVhBkyJaBSRkfqqWSPW5CZdQ7eyP9xBL61+FIekVQv9MT64ejI4D22RPO1A
         XHxeiN7fDxVElKcBREOpY3QAUgwOUa2o00v9wKhlSPErJLuNpOu3KD1WzGCOdrVIpKD1
         BjuOQUsSJExkPLfGWUzB5F+EEKBPPHEhUAf67Ex+SRNmnyDCHoTTdRFrWwi7uUJHup4C
         OJSA==
X-Gm-Message-State: APjAAAUG27WJ4BhtoVqnqm3cizM+SRYAEJWXX5ljdm6tVNUW1OGZhFHc
        P8JBjwhziYdjoL4QFYdn2IxTkA==
X-Google-Smtp-Source: APXvYqwDTCHy7ekbXHpuxYWgHEZHkPXVWMIgLthR/cRPbNMgyLncTh1RVOtUSpgF7h0Elx7DzeS6cg==
X-Received: by 2002:a65:5382:: with SMTP id x2mr1341257pgq.420.1572383658639;
        Tue, 29 Oct 2019 14:14:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm150632pgd.7.2019.10.29.14.14.08
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
Subject: [PATCH v3 19/29] c6x: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Tue, 29 Oct 2019 14:13:41 -0700
Message-Id: <20191029211351.13243-20-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/c6x/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index a3547f9d415b..ac99ba0864bf 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -5,6 +5,9 @@
  *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
  *  Mark Salter <msalter@redhat.com>
  */
+
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
@@ -80,8 +83,6 @@ SECTIONS
 		*(.gnu.warning)
 	}
 
-	EXCEPTION_TABLE(16)
-
 	RO_DATA(PAGE_SIZE)
 	.const :
 	{
-- 
2.17.1

