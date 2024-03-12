Return-Path: <linux-arch+bounces-2951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A595D879A08
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93D11C22132
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CE13D303;
	Tue, 12 Mar 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVYk1V59"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67B13C9EB;
	Tue, 12 Mar 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263021; cv=none; b=SoemvvqO7D0S26mvmWpqdYheepaz6DK5nU3jfT1LTBjov1vuCft9m+K4Ht2Geo3Cp09mIGLz/0EMA1FkbgJM91idXM3mKPP6PblH/h1jbp1xUdYsMQdLuRBZXmro0U/WPitOvW67bKqHdp5ijNAMLcbKxp1yDCLU0/zj8xw4QMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263021; c=relaxed/simple;
	bh=/dkJjeYnC4xp3pBdcYmRMb6HiU3G4u98Gd+EGKHtNq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKWP9zHva+wOU+sq8PMsd0HJkYy0WPJ6B5nYSOr0bFNqmZl7UUBiAHLJHhLIfMvI/Yg8y6KavkO2ex3uX1fgMx1xoCaKdL22yZ4cU6EcVz5ma3fo8ZS8+BNb6kvCNV0rN4KLq3rnFAZeleFI1gs9etBgjttf5xEqzlhbmSv0RCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVYk1V59; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d944e8f367so1243445ad.0;
        Tue, 12 Mar 2024 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263019; x=1710867819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNfBGF7ZRB5gRY5ju3ZTnVyluuI6d4pIMWMvwwDFCuc=;
        b=NVYk1V59fcBZDVxiWT2IfmOoElqDPK97pxT/VCzo6wJgWudZjLl+Y1KEdnr60XWlSn
         T2c0xSlH6oHtntvN+R1tjFXZjmg7HIm48dNZhhyVQhTYdYuNoFgcnhCJPPfuCOHeJhXO
         wtMVxWvc/dL/HqB57oQwsxd+6VxpKB7VMSS3JPmg39AR1bKUm0IOoM6VfP8Glv1WqRRU
         arbCDUaZPfRipWq8FHJSRE/AaQTB/kVNXkP7ukz8MDFVvHshMkFsKbGCbcOC1SQonurJ
         Oggd42Fgw2oZzzqwd34VRvmmJb7tVo9yJnWlzZxhTroyopkN47eTcUtRmk5AstmuQNvd
         06iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263019; x=1710867819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNfBGF7ZRB5gRY5ju3ZTnVyluuI6d4pIMWMvwwDFCuc=;
        b=tAbKVjDzOI36qX32pNu8u7NOaaz4rBr4xg5TR401LRAVkjpWnYDdFxx4CBBMjNVAgP
         LNgSqY+7cej3Toqo156cB2C6cAUfyDVQF8R6ePRpu7PtrnYPwjC3O+c7pLg8fdevH2UQ
         7AB9EyhWITAxagS8M7PBEhEA+2CR3ab25jEW0wJiYOH4ZmUIOWERt72lBbnJva3eomRt
         YvYYvgpV9BO0V9vNHdwmIVFPMfoqD8BrgSfTZfp8S+2rGgli7bKuiAvdJMabUnL73FY8
         lIHmAHxlz9d/pkopWUTy+qkgozREAzu7iWiAhBxCGsyKI4pGTa6JMOr1m9SOrQLup8aF
         oIDw==
X-Forwarded-Encrypted: i=1; AJvYcCWQaIkrMSvzLce0pzuf/i7GAggwx7WrLAGJsb8inkXWMNS8CDPmmkU5Jdze0oBLlMaSgRxRSdV2t4yocARg4IRKMhVcg6xiDc7z353sNDipfU5UA4Y3RoP6nzAptzIdjnsMXjRh0nY3KAOIY186fNhlkY2vsipAamXL2NpJ1nHrR88qoqTQoCinUhUGPI800DqMt9U90HWQcGCl3CX7qzB/vcLssqJWNsuVqxL/GCD0dn+/aT1Xoe5B5IrkL0p0a3cSxzmeZtHtxU+WTkSxKDttTnTa/vyzSQ==
X-Gm-Message-State: AOJu0YxXANmm2aaKketi727qJ+6EWJQpSSzVvLcLLdMFRseB7Bo1Fv52
	eaNwwkD89rrw9/m71x9QCYq+r3Mr2vxE10zHym8CulH5UuWjLLUP5QJJOdTF
X-Google-Smtp-Source: AGHT+IGjcPO5G+GnCGVDj4Jcw0R4zzS4LNLUn52exaX20Pa+MrIRq7GoxtzdXir/jkag847FtE7VIQ==
X-Received: by 2002:a17:902:cec8:b0:1dd:7d6a:de4f with SMTP id d8-20020a170902cec800b001dd7d6ade4fmr939106plg.2.1710263018703;
        Tue, 12 Mar 2024 10:03:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b001d9edac54b1sm6398555plk.171.2024.03.12.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:38 -0700 (PDT)
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
	netdev@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/14] s390: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:06 -0700
Message-Id: <20240312170309.2546362-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
References: <20240312170309.2546362-1-linux@roeck-us.net>
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
to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE
are enabled. Otherwise, the __func__ assembly parameter is replaced with a
(dummy) NULL parameter to avoid an image size increase due to unused
__func__ entries (this is necessary because __func__ is not a define but a
virtual variable).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/s390/include/asm/bug.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index aebe1e22c7be..01e2aa4069d7 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,19 +8,30 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.long	%0-.\n"
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
 		".section .rodata.str,\"aMS\",@progbits,1\n"	\
 		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
-		".section __bug_table,\"awM\",@progbits,%2\n"	\
+		".section __bug_table,\"awM\",@progbits,%3\n"	\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		__BUG_FUNC_PTR					\
+		"	.short	%1,%2\n"			\
+		"	.org	2b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (__BUG_FUNC),				\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.39.2


