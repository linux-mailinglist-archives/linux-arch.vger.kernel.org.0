Return-Path: <linux-arch+bounces-10719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A949A5F362
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDDC18914C9
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29762686B3;
	Thu, 13 Mar 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f57rJeZs"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE2266F01
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866317; cv=none; b=mEsmIdPnJ/2mmDzKrxhoFN+QcD9GKKroy8ODn/SvmgZZSCxTseKKsdDRXRVF0fWGJ87uIYZqJAA4G8/Q5OGDrXdP9c28f6iwlq7F1Zqb5FrOC2vluCC62ck7zj0HevXXcmk0yRT2KW8ak2ZYaCzIAdWm0crR1JkIz6L3qMEi6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866317; c=relaxed/simple;
	bh=0aizeDhwWkFKZsPeHlQzOAxiwKdPV8X3HwIBD/FO6ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=B3TSijvK3RMdJdDWjp2hEM74/B0dUp95tW1d415wMOWQa+YjXVkNzcFPMGvTeyQgZqVUFq5B27Ev1i3o9kurxCcBUpXmH3aGX0GxRz5LTt41RG0lQ7bJf2/xFZFYAcSpI/04XK6h0fsi+go3TQbi+jXhzMIMVg4z8jfy44IBrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f57rJeZs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNDdusV5kHSN69Wnsdcb+ESaCAhVWZZ95i0rdnVfZIo=;
	b=f57rJeZs/V2L2DLaFeI1xW4B0SlSw7A9Xk6TT1pPpFoDMQ5fNnzSHsiRSF6L7Sdb/Dum2T
	j7EAjU1yHSsbhVhc/bjCytVJfPrxc0K1ctF8rnjlQpWkY+e6CiT/LIR0MOKCMD0Jsm80X4
	qZTH4XQLEjJCBr6pCUdFsin/uHsdRLQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-vYjZUENgNMaSDzPQcZdPxQ-1; Thu, 13 Mar 2025 07:44:50 -0400
X-MC-Unique: vYjZUENgNMaSDzPQcZdPxQ-1
X-Mimecast-MFC-AGG-ID: vYjZUENgNMaSDzPQcZdPxQ_1741866289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912e4e2033so382888f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 04:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866289; x=1742471089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNDdusV5kHSN69Wnsdcb+ESaCAhVWZZ95i0rdnVfZIo=;
        b=IXzLU8q03JwNGHBcZD5hBHyw/suRsh4iLtrih7QqoCmRxRQbXmIT8t+ca1XhT90H8i
         +bXlrLzvnwyvdnfWkqgD0GvV3tQzpBJta74++lGz9SaixKOpl+S/rE6Tj9+w7SG6idn0
         QA4ZqYKKdtX6WjpYp5AK7FDb0X+whXDJmBwAU3jFr46FPlktJ/NlEdPAPV/LhygttFEU
         s4lMRod79wCn9Jf0P3SZelylSgcskR2HRKPpT8Nj9cINN2s7DJk9aWdCT88KbIJg8Wjj
         rQLUGF1WKBlbSBExB4mDK9n+VOjqlq8qIjyaegamMx8VD9WxOkiRknA52Ek6aLB4LCoY
         y3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDzLc45MBHCMi7u8a74n3doRWGz2T8J7pz6eRHfdZlxgoRAIODWbqd+VPJzeWzlJ9joDKD8xHXJT3l@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTLmSK/DNr9HIvzt8Vwo06q1a/ttQmEKPnX2YvPbDCDVPXniE
	jb1/Jgrpqg6nq70DRDdQ4sQpKIC4qMdtb1A/t1QQ/Aq2+2EbmeZhwEbnimw8zLqEWT8J1ng8bNG
	qdYc9iN/g6MCsCAuvaP+SOq4fs1GlCtijzT/7wk6+6Nz3dfp/ABa1qE3HWxg=
X-Gm-Gg: ASbGnctSJZ842aB3PaE2iEfBzS2vWLO2g/qTkbU2m9OOHXI+79/51GwJAJ6QaHh4nOO
	MiVgj/aiyE2CGl/A/aW+tsC+VkNQSN2a7O4YdG4pyKdA+H1ZtFzNEi0RxEqniVHUBC4/8R/H/zl
	vqRqcUcGBHezmNGjeLexV2Rc+gS2fn4p+hXgCyMgNeo0aOwriu2BV73tmkuXgZPGZMmU5Ga/mvY
	PMKoYoL0+PB4UzaAXpgDGqAmuZopGHAOsWp1wwVztEOUIM5SP7fUKOZAYcInHeb8T3fRMrpCbTu
	NHNvEyLn6rE6yL6Kaxwr
X-Received: by 2002:a5d:6daa:0:b0:390:fbba:e64b with SMTP id ffacd0b85a97d-39132d8afb7mr18596808f8f.31.1741866289384;
        Thu, 13 Mar 2025 04:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYwocEA7kYpHNOe02FWF9uxS8M3FuzRDEqfu4GtiOXX78+oDlT7RdxLzaiu9BpsPlw7lldzQ==
X-Received: by 2002:a5d:6daa:0:b0:390:fbba:e64b with SMTP id ffacd0b85a97d-39132d8afb7mr18596786f8f.31.1741866289052;
        Thu, 13 Mar 2025 04:44:49 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:48 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
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
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
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
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 09/14] parisc: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:24 +0000
Message-Id: <20250313114329.284104-10-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

While at it, declare assembler parameters as constants where possible.
Refine .blockz instructions to calculate the necessary padding instead
of using fixed values.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/parisc/include/asm/bug.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..b59c3f7380bf 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -23,8 +23,17 @@
 # define __BUG_REL(val) ".word " __stringify(val)
 #endif
 
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define BUG()								\
 	do {								\
 		asm volatile("\n"					\
@@ -33,10 +42,12 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t" __BUG_REL(%c0)  "\n"			\
-			     "\t.short %1, %2\n"			\
-			     "\t.blockz %3-2*4-2*2\n"			\
+			     "\t" __BUG_FUNC_PTR  "\n"			\
+			     "\t.short %c2, %c3\n"			\
+			     "\t.blockz %c4-(.-2b)\n"			\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (__FILE__), "i" (__BUG_FUNC),	\
+			     "i" (__LINE__),				\
 			     "i" (0), "i" (sizeof(struct bug_entry)) );	\
 		unreachable();						\
 	} while(0)
@@ -58,10 +69,12 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t" __BUG_REL(%c0)  "\n"			\
-			     "\t.short %1, %2\n"			\
-			     "\t.blockz %3-2*4-2*2\n"			\
+			     "\t" __BUG_FUNC_PTR  "\n"			\
+			     "\t.short %c2, %3\n"			\
+			     "\t.blockz %c4-(.-2b)\n"			\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (__FILE__), "i" (__BUG_FUNC),	\
+			     "i" (__LINE__),				\
 			     "i" (BUGFLAG_WARNING|(flags)),		\
 			     "i" (sizeof(struct bug_entry)) );		\
 	} while(0)
@@ -74,7 +87,7 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t.short %0\n"				\
-			     "\t.blockz %1-4-2\n"			\
+			     "\t.blockz %c1-(.-2b)\n"			\
 			     "\t.popsection"				\
 			     : : "i" (BUGFLAG_WARNING|(flags)),		\
 			     "i" (sizeof(struct bug_entry)) );		\
-- 
2.34.1


