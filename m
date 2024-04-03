Return-Path: <linux-arch+bounces-3392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603778970A6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F281C264BF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8014E2C3;
	Wed,  3 Apr 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsD0oyiP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C614D425;
	Wed,  3 Apr 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150409; cv=none; b=ZSNTEXUCuxxy7oF8Fy1Q7fE9QcaMo+IVBXar/4fF4CArBLGiRQvlKpNp0aWMd/Csx89/x6xvXTxZMvUiBT25UcQbwNRkqCkba6+ckomyjSYllW1H7TmIVISM5guPOv3zzFU6iPfNmjX0jnCx8IdIC/F2Kla58Q9k2pJVLVvkWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150409; c=relaxed/simple;
	bh=6CYnXopnOEFDbmnJvQptcozsBT0uZcC6Gw55E5+uo5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOLjs5xqP0Lq4kMpuNkSJYySQVWzr5zzV3sv7058Q+7Ga+Gps07olqeswG9/IZQnQTNlVNdSft+zPKaSsejyEj4vVMnkw+AOYSFtxHo/SG6cbuJTqTQJp7mNwCF8zoRseMJ2Y9Rb74h72eGSkQ05BshZkAQHf3z/RvZrpWpbG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsD0oyiP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e27e174ccbso10908035ad.2;
        Wed, 03 Apr 2024 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150406; x=1712755206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODnUVSnKJhDEm1BurB+AUz+TF6tuatLZNT+jGpCl49o=;
        b=CsD0oyiP2JQ991rgfHqWBL1D9T7YSZr45F+iyC38jltBcMOIX48ki8j60N8ck+XLh3
         Ajko6sJcpH4IaghYFZjY8Bgd7/DJdFfA5aUf2jKuQKc8rjsSkor3Vw4PbM7VIXNG90HG
         7vlFCvIQ8855G2VRAmoSSB1h+DXvRzhHRmefZt3gWrPbNc1WUn+eH/UVCy7UuMvVIOXi
         YXt9sTOnbjk18gCl4NcZYnWJd6auQAfQWsn3CGWYnWeXo0JD1lU4vRcHERVtM+MS14pC
         fD7SGXP7k7pOrKbFV6RdTfYfSLYm9JN1nAk1EyheE6tui5H05PgZF1bgGW4Rn5A4CaR4
         wxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150406; x=1712755206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODnUVSnKJhDEm1BurB+AUz+TF6tuatLZNT+jGpCl49o=;
        b=iGisyINYQyjneZ5zL4zNz7RK0X9xlLzuyv/6hjCLSGD+ZIuIrIrjtMp4AvnkiA+DpO
         RvegreJnmCjddB6QQHh4cHPiZEmqb+IoVAqvytig+/LTjLl5+emu/bSpHIoX/vGkY355
         luBx0lPS9DmPOG4cLwszX0vQkdTOiJ06xDLWuAKunXiBfQJwmgA4U2NgxG1AguEaiyPW
         ZoXqK1aQ1l39y6hj4ezwyl0/QGP10n6Bk6Z/HrSp2zNokv9th4lZM8aJe242lt9BcCjX
         4+5q+I209c2hCnbx7KHgdvsScnceh3y3EZFt6jWPxTzgH4qb6AfEpSX2iDlhrnJOGYzy
         nImw==
X-Forwarded-Encrypted: i=1; AJvYcCWgvdAb3hjjj5r8idm5dzpJwQTVDmfhrWN3205eQPGJl9usESWnVQXstZQAsOJGXhshnL6qgxHze5JzJbnpscS/wyCu+J4tkH0Au/heFKlcrnkwk5IlME3gk5PrMqzGfociVuRfpGIJMFnljG0dmUVlCPOmP0UUsPfJptqBhpqRL5Jt+1pTlOonpL54D1rBUO4DtFBKwDKWnpNyoWMFNFCnZUQoqrCVokxexGrOiVTWnp5/IN4Vl2b+n6/YO3Db9jFUJ6CmXdNM6H9j7a0cqO+MbQkpI3GXkB/2huUyd1GERzMUtoQ5wjFr5Q7C5RZlHQ==
X-Gm-Message-State: AOJu0YyoB8/uCRw8BDXx6zKklfgyB6/G0Nsd0Bxc9KgP0mj3x5CMwxAt
	HHiJd8wxtycBWBgJz9xCrtdhw9FuEDEK1/gv6EfN5n8olE4oYnDq5umPHZBt
X-Google-Smtp-Source: AGHT+IFJ9xVFhcxKPjkQ9awCqlJIsW3wvRmyEJkLnkWMs/f98CPvZeN33nEjiQcGmSbiBbYrqVdc1g==
X-Received: by 2002:a17:902:ccc1:b0:1e2:3d61:e266 with SMTP id z1-20020a170902ccc100b001e23d61e266mr18724864ple.49.1712150405920;
        Wed, 03 Apr 2024 06:20:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001db717d2dbbsm13207508plh.210.2024.04.03.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	x86@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v3 14/15] riscv: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:35 -0700
Message-Id: <20240403131936.787234-15-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

To simplify the implementation, unify the __BUG_ENTRY_ADDR and
__BUG_ENTRY_FILE macros into a single macro named __BUG_REL() which takes
the address, file, or function reference as parameter.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 arch/riscv/include/asm/bug.h | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..79f360af4ad8 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -30,26 +30,39 @@
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
+#define __BUG_REL(val)	RISCV_INT " " __stringify(val) " - ."
 #else
-#define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
-#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#define __BUG_REL(val)	RISCV_PTR " " __stringify(val)
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%1)
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	__BUG_REL(%0) "\n\t"		\
+	__BUG_FUNC_PTR "\n\t"		\
+	RISCV_SHORT " %2\n\t"		\
+	RISCV_SHORT " %3"
 #else
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	RISCV_SHORT " %3"
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)					\
 do {								\
 	__asm__ __volatile__ (					\
@@ -58,10 +71,11 @@ do {								\
 			".pushsection __bug_table,\"aw\"\n\t"	\
 		"2:\n\t"					\
 			__BUG_ENTRY "\n\t"			\
-			".org 2b + %3\n\t"                      \
+			".org 2b + %4\n\t"                      \
 			".popsection"				\
 		:						\
-		: "i" (__FILE__), "i" (__LINE__),		\
+		: "i" (__FILE__), "i" (__BUG_FUNC),		\
+		  "i" (__LINE__),				\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
-- 
2.39.2


