Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91E8BF806
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfIZR4U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:56:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38902 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfIZR4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so1963852pgi.5
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WqLTzjTdYtu13eBI1Hsh3syPKd5R5C/bZSENvznkqN8=;
        b=DCGoaVd19CahdKM67vauwYq6A0n5O1bU2fwJSQI6+6L/QL8IWduHMpbD2D082JUMYu
         tdZce3zeDL64zrWCWjE/SDwatGi3I36cLWh3ChbpkxGYUJmrkhZ3GZpcYkkrQcTuN6Kz
         BMWhWC28K9ifpqbHkwnwms2pPbRZQRavPSH8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WqLTzjTdYtu13eBI1Hsh3syPKd5R5C/bZSENvznkqN8=;
        b=X1F+6Aa44beDhJJMwIgwdxGHQQglHeJUKhZMcoXKRGz+kYNRNrwIh6FnwU+DqMXXsM
         mV0deTuB12QjKx30PhMio+rop1mtW+u/9JN6mSdh8pP/cyajB4AgLIPrvJr9UbZ/nGX1
         6zun5Sj+u4lgSWIOxc3DEFPShfCRwTgpzPupPtap6DEv/XiwqYRTeheQTdhOmZ8hqSRf
         QlZieac2TwFGAVTkWJ4SQMus9sTMUoUdyO0fVUSE9r5BKZryxHPUjRphTbh/M2exb0Gc
         iHQDYhi739itlFA4vhZLC9jEmW2gpxjNtyf8dX6dk7YK310okCztqB5HT1cH6DIGm7ip
         /U8g==
X-Gm-Message-State: APjAAAWB4i25dTjn5pR0+9W8o41H10vem1R9mHlwOuQDbQZRYCE+Eue0
        /yjx3NqmdUP0PqaYjhSiQVCB6A==
X-Google-Smtp-Source: APXvYqx+Nc4F3BFxu5gBtlblqAA7dVzSt2eXx8oUumqPJNhjfOYoqU7jhFXju/6qtRKJS06j3p5MdA==
X-Received: by 2002:aa7:8bcc:: with SMTP id s12mr5094703pfd.93.1569520579420;
        Thu, 26 Sep 2019 10:56:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm2855407pgr.31.2019.09.26.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:17 -0700 (PDT)
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
Subject: [PATCH 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Date:   Thu, 26 Sep 2019 10:55:34 -0700
Message-Id: <20190926175602.33098-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
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

