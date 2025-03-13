Return-Path: <linux-arch+bounces-10712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C8A5F342
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70423B565A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75326A086;
	Thu, 13 Mar 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO5VPXe0"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8E1FAC5A
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866290; cv=none; b=MlnmwgDufR6ANW5nL0vVgSnJ+IS/DtKPL5G0kWiP8Tgp6kQToIk9ZwMi9Fktnp7tpD0P3DtVnQy6SaRkEY+AXJWsIP40sRRMjuDHuX2RRbdn2ySBQxMqkpMXxlaDczgaqNf9IJJwDE7SDadNC+Qhow+ZsFkbB7SZGL1J5ImKxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866290; c=relaxed/simple;
	bh=liO3eLVl1wJXmy8vDx1YCNgXVebD8YdGrdwAIJcfcmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=o6M8PemYjIbKCSrvXQvRUyt/SlCBMh7PscIGM0+uykDunoCWVz8y84TvP7nqxN3MML8VPyFFgiNMeLR0sHLaImWMiPrvJr44iqOHxvluUXb7+Of71PnhDsDMf+H1lMCC49Rrfj4SElSoL3JIAjiCEF9LW1UiV/6XvHVMVvcqmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO5VPXe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GROr3WSjkuWJZb5whyX7QQnwj0kVrCWo4LNK5GIabXk=;
	b=XO5VPXe0NBfQWbh3tLFkVefDubfuOo+XDt6lhuKHMBWQu2K8lHIMAznoR/y1ULKDqiryXE
	XPGGtMAlF6/zT+621RSPCD67Cj+8Bn/v18inl13XoISRtWj3FCSAq3qqp4BKjpDh3dafQs
	fjaejtCcrclcDhm6piul8HgTbkUU4wk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-G4Dw1903M8iAG9YAYRFKgA-1; Thu, 13 Mar 2025 07:44:46 -0400
X-MC-Unique: G4Dw1903M8iAG9YAYRFKgA-1
X-Mimecast-MFC-AGG-ID: G4Dw1903M8iAG9YAYRFKgA_1741866285
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceed237efso5985935e9.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 04:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866285; x=1742471085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GROr3WSjkuWJZb5whyX7QQnwj0kVrCWo4LNK5GIabXk=;
        b=ti9nCA6vAOl1cELI2ckcPPnqUoZVi940OkD9qJnk7j32BwrMKBO8Y8dYSSXWBcxqtD
         BdRHx4tuqi8WjnFtEpS8Plxu0rppxsG4Q163BA+mLJpV0BF8E4Dezl1ozAufouOK/0ie
         moPOlKEbTRQaoL+IoGGQh729+w13s4DlfYRRye1sXO5M4B+RIhYelnD2pXQwk7AFkWbr
         OQLfFY4Wc8Aan6Xk9wtuQq0+H9CI3N8Mxe5dy2RU6uK7gW2RsUgnm91N35i+nGZK6xrk
         ccWf2FACIFjZhwMaigExHztxOnZ8wlbM0dU5wFCgozOyrCuL5f9r+YsSEEHAF+jCEHFE
         SD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb/fyUtqvCxeQE1x+7uI0dI/YFsjdjjWqQqRYsA0i5YtGuehL/cAfli0QwXX35EJ989Z2amqvZgW/E@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdB4unbvaLSyHRJwD2/+ioaQvP9hJcUeYQBoYbdklyU2Vb6TU
	INcR/lvNBvHo8+mw7FeW7NB7sELlXjB9aFcDW8unjkF3JBxATGsdGoC9mtL3jwFz4E80fRmXRqh
	UAJ/LOdrtn/MDTzCfz0bT4m6/XXhBYxLb0keyjRGWCMsm0NFVi+CXmJPzhZ4=
X-Gm-Gg: ASbGncs/8rq2I60uvHDzI3R7cFLCNJd7r3fHjFZejK0DFGXjZU2rcO2LWmEtVCRLOhB
	qKxGbaFp6FDupdruqTRpHXOHGay2VYUoR+Tx3EGdNw47ZpAa8L3tcQD08u6yan/2kRA1qpaLoUg
	BZNvh0x4YKMN0o3e02jFZ2ezPjtK6ReMWTC3Vvzt3cHrV9IXNcMxK2lUvTkoswW2n6OFOXtjWoG
	qUELFm/CX++rGCcqmj8RTboU3hiwhCUlreXfyIQANJsiiz6Qol1kboCNJW3X4cv75ielaIWszXk
	6Rm7/L60JLUGUTNmMk5/
X-Received: by 2002:a05:600c:5493:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-43d01bd21e2mr95038655e9.1.1741866284838;
        Thu, 13 Mar 2025 04:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmAbVJJ3Axf7J+/aQFhSVgbztnHuV0D3aaCUWl74kfxPn81ZspK5wVSFqWrESjIWmYzw2aJw==
X-Received: by 2002:a05:600c:5493:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-43d01bd21e2mr95038375e9.1.1741866284399;
        Thu, 13 Mar 2025 04:44:44 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:43 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 07/14] arm64: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:22 +0000
Message-Id: <20250313114329.284104-8-acarmina@redhat.com>
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/arm64/include/asm/asm-bug.h | 27 ++++++++++++++++++---------
 arch/arm64/include/asm/bug.h     |  8 +++++++-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 6e73809f6492..bf0a5ba81611 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -8,37 +8,46 @@
 #include <asm/brk-imm.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
-#define __BUGVERBOSE_LOCATION(file, line)			\
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)	.long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif
+
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
+#define __BUGVERBOSE_LOCATION(file, func, line)		\
 		.pushsection .rodata.str,"aMS",@progbits,1;	\
 	14472:	.string file;					\
 		.popsection;					\
 								\
 		.long 14472b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
 #else
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_ENTRY(flags) 				\
+#define __BUG_ENTRY(flags, func)			\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
 	14470:	.long 14471f - .;			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)		\
 		.short flags; 				\
 		.align 2;				\
 		.popsection;				\
 	14471:
 #else
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #endif
 
-#define ASM_BUG_FLAGS(flags)				\
-	__BUG_ENTRY(flags)				\
+#define ASM_BUG_FLAGS(flags, func)			\
+	__BUG_ENTRY(flags, func)			\
 	brk	BUG_BRK_IMM
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
 
 #endif /* __ASM_ASM_BUG_H */
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 28be048db3f6..044c5e24a17d 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -11,8 +11,14 @@
 
 #include <asm/asm-bug.h>
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)				\
-	asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
 
 #define BUG() do {					\
 	__BUG_FLAGS(0);					\
-- 
2.34.1


