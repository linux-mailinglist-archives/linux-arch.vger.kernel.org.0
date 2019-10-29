Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D34E9158
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfJ2VOJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45894 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfJ2VOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id c7so9353546pfo.12
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9O9o67lY/P6wlTEjsCX8aHvBVVSD/zx23uzcL5Y/Qk=;
        b=YmH7JoRcIpuxHSBEzuyBZcI2cXlEocfRSYinjuQggynP+Yn5Bn4zkxrvfy7jAIlUuJ
         3z/TlcEeTvA6xOI+hfOAcAJs7nBEtgLlKKNYCzlXJEj1NFiiqMvLbkPYxAWyblfxS+ij
         cYtL8PEwHkOICPVjXRXFQwTlPFkJBooeg3rsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9O9o67lY/P6wlTEjsCX8aHvBVVSD/zx23uzcL5Y/Qk=;
        b=I4gnjtJyYVDS4nNovpzdnHXPbTQSoj5tC/YM+Sn8JTNPY7YuT5yzb4ZUgg2u7kvI3M
         GAsx4ejwnehmLX2V4/Ohf+Fg7OCMS+ocperOSiO1fMVQpcgh6RHpziiBajpu/gxSgkjb
         W4lajLxRjAOwY+lZTnGyIco871tv6zCm4pgAgCX6d6cI+oBtCaFLF37TnZ1/31Hx8lCc
         Xw24AguVVO8qt1UT/4jTrOvqVlucrscfr5MFR7v/ujfvHQbHe5morXZYDeuRiyehbX4I
         52mMP0+qQU+V49dE71Y6texWpdPCdSY2P/0LJdU+RdCcJPjEwHW3elOP7JSg8DKp4J5a
         qBzg==
X-Gm-Message-State: APjAAAWmdz2psg3FXNEa100eO9bggFrVKZqJrWth/EEePkvGgG4ZW0ke
        FoEW0z0IYM1fSSJMPwwhUmZkhw==
X-Google-Smtp-Source: APXvYqwjW3Si7/tNLiB0yWdzOESspeMKg8ZGEJduGjpXWpuGODoydLiyAFH5fAhzQLyONbMAITVrtg==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr30641499pgl.262.1572383648493;
        Tue, 29 Oct 2019 14:14:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm134824pgs.34.2019.10.29.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:04 -0700 (PDT)
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
Subject: [PATCH v3 06/29] s390: Move RO_DATA into "text" PT_LOAD Program Header
Date:   Tue, 29 Oct 2019 14:13:28 -0700
Message-Id: <20191029211351.13243-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, move RO_DATA back into the
"text" PT_LOAD Program Header, as done with other architectures. The
"data" PT_LOAD now starts with the writable data section.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 7e0eb4020917..13294fef473e 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,7 @@ SECTIONS
 
 	NOTES :text :note
 
-	.dummy : { *(.dummy) } :data
+	.dummy : { *(.dummy) } :text
 
 	RO_DATA_SECTION(PAGE_SIZE)
 
@@ -64,7 +64,7 @@ SECTIONS
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
 		JUMP_TABLE_DATA
-	}
+	} :data
 	EXCEPTION_TABLE(16)
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
-- 
2.17.1

