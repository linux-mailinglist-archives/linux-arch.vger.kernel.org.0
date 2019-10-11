Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65860D34E6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfJKAGk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:06:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45453 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfJKAGh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so4923999pfb.12
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkQRciK9mkrlSR6uxFsvjRswhc34+65nZ5EFVAGwQNE=;
        b=YSecILoAsuaYNC3glukrCd31elBfhWrMe0PzbA6TDXYdPOVhmOhkQLy8xjOVCWTle3
         sWZgpOp1PTW2fO+D3A347Fw7oous07bPkmNpp/aoq4rj0PLZ+w9ksZu6jr+caikG/bpH
         XU/ce13E03H0+EglsamH4gM2AQvQFCYts7cLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkQRciK9mkrlSR6uxFsvjRswhc34+65nZ5EFVAGwQNE=;
        b=e/J67aVcW9Z7BCZAvKg/WARgZSGmqOyLOpNbuqz7lLLTZsmwuCIVnXosTLUqKB9n7e
         uRnZVq2bF3/qBoPZLy+P9Q1ltTv8zpOP9i9TRy10etF4Fg+OSFbOcFJaRPqH1Cf7ZIaX
         ezBLJAWe8UDSb3SI1ErKPQWTYK5ATFuzqAmPt5JKXqJj5brpEJOh8MAvKAd/iJY/HVsH
         sIFYnIyCzdQpP43/iyyfdLJSFuOX0QQfxh7gP0ibue8VynCy8viCuPfHnP7C3YUw/lch
         KcVG5ZP0Bu7QCBTXfWft0RB+A/hBaoJc/ZC8q0VeWklNs4NmiG6WgKEL8go5YcqmP4pF
         tFDw==
X-Gm-Message-State: APjAAAU8PLfgh1NYaUC7ObvpJlk3T8WbRAzYJxnVnAr1VmmOEePuabrE
        u0+UW3gppKc9KDaDhTXqhVvPjw==
X-Google-Smtp-Source: APXvYqynxI+SrUE/IFh3H47ImD9d3o8Z2E9DLcjnFNC1TbOkJf20nhWWRMuV9Tda9+s+1NYxkhzhYQ==
X-Received: by 2002:a63:2c7:: with SMTP id 190mr11717225pgc.18.1570752396275;
        Thu, 10 Oct 2019 17:06:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s141sm8901750pfs.13.2019.10.10.17.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:33 -0700 (PDT)
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
Subject: [PATCH v2 20/29] h8300: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:00 -0700
Message-Id: <20191011000609.29728-21-keescook@chromium.org>
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
 arch/h8300/kernel/vmlinux.lds.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 2ac7bdcd2fe0..6b1afc2f9b68 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
@@ -37,7 +40,6 @@ SECTIONS
 #endif
 	_etext = . ;
 	}
-	EXCEPTION_TABLE(16)
 	RO_DATA(4)
 	ROMEND = .;
 #if defined(CONFIG_ROMKERNEL)
-- 
2.17.1

