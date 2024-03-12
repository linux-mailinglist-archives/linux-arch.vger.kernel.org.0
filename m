Return-Path: <linux-arch+bounces-2947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A698799E8
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992D8B23314
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90213A25E;
	Tue, 12 Mar 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaeG/q4k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121113AA4C;
	Tue, 12 Mar 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263011; cv=none; b=Kms+KaQ+ZhDpY6ZqxWYw3wdzceo10aTLV+jDR7aFSIXDzIFLq0FBpxBAgJ0kmMMGC01D6rXtXNYhHEfilEPkjG6Lr1a0TqppmU7tBVaY3V2NHj0jhUL827zSH70pcS9gNxWznhcbq69iAGDUc45V3gkhU7NYDQpKDikeHzQDers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263011; c=relaxed/simple;
	bh=2NHIPSEeh5V+X5+GdK5eLhFVjFh0D1jEmjx7oDfzWbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SR2e4hAFVRoGFHZpA2W35FrRkzd/iu02nUwDFV2i39qnhG47qYv+iBOumC+VMVBP2xMhAr8bJTcz9qDF/9L8eP7Jx6uIPKlS62DKF8VdPFdnLp9bhi79d27yKUTGRSnG1DX/pCLR38XpEFOkWhtMn0FDfjutVpnOgk2GHfe9NWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaeG/q4k; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3350307a12.2;
        Tue, 12 Mar 2024 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263009; x=1710867809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e/E6ddr2rv0O0qI6ESGYNVGq97JQ/YRs1mbYMxZhW0=;
        b=KaeG/q4k2oTvKthueq3In95ouKsGzvDChhRbSwKB9rGceH2ZIqnow3ELZSd4ldzY3I
         3qmwFcc9fZRV+5zf9Ep5sL5ZNnYfGFFeb/5/pUBRwn2a3f4GDo7z1SXiXUlmmjRUTSNW
         2FrmB/13kuQaDgj/QBoofnCtB9jhgkm2VAtJ5MU+z67tiYA/ZqJDWajhEazgxVKTqpkq
         9OIE+X1oyMPNn8Xg8N1mzYulx7l1l3Juf+w+q0lhj5hbmZoWMgKSE0V1UleSyHzQHAJW
         wJM9veOocS84V6wIiiKuGBP6FtCbodMQH5C+ueHEK4Br9lxJMzJFvEaYbaIuqk5+peeZ
         QuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263009; x=1710867809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5e/E6ddr2rv0O0qI6ESGYNVGq97JQ/YRs1mbYMxZhW0=;
        b=OrjWVB9Bu4SPimeMsvt3qj4OPCsMXAhS8x0fYnS3o15l2JcTuC1QfmGxLJidvUdc8/
         Erl0iBCbRxNomSruhg9YfdqaRBoq6eTSz+qKQmrtrrhzNqiyZLVIvOSwcOvkF0UqFm0T
         6TuN50UGJRh19QnlqwzfW+tic/N4WSgz9i04tQxqkxpaB0sCFAIWcPN/XyrdKCMSjyJY
         Z1GlFcBW4fqGgYAw272ZYE5H2OBRAvfd+0ukw46NB4X1tVRXuJIlg3PNkUmkjB3orW4x
         HFbsHrymyLmBQdUC+sNMOdULWqIf8Y+9Ep1Xfc/1v9QpC8b6qaGEuDNAXQJ+W7BrbGuQ
         FhsA==
X-Forwarded-Encrypted: i=1; AJvYcCXukJ9LeUdG6MAKwldh41kRcHw+AU1/+kDVAiBHuAbdlIzxSJ3rqQrNQoSnp2jPkr4DzYJISIpcTdGYJXaJmU7iTHNZv8keXwplnFIs9wqNPG9piaTb7yIoorxyC3gaGquRJ8bJMrUdz0ZYUoyGz1XWgjxbKyiG6abqkTXMtS/fgFKOT61+8FdQD6XldNEg8ckaag0xky3qAKFDEGl58F/3tG6B5Jhbu4dVyNwAJG1rmQLxgPvLO0yhY5BNDMp4z0hl6HU+L1IWoRMrWHnVb/dIDrJNxduj+w==
X-Gm-Message-State: AOJu0Yw+wNuYZXHZB05Qhkd3UXL2pVG/d3RozlOpkmh/QlJYax1tekRw
	2MjQ2NpaMDyp9OoZFeKf9KfT0IFJhg1+6anJOvf/7FcUQNoNWQWaUU6uJMwd
X-Google-Smtp-Source: AGHT+IHnpV6pQ4sbhTQFUz6ATEKXpUTcdarefNsnZ32RzB7TxwrdDKUDIv3vmdM+PJbrepqm0Atu1Q==
X-Received: by 2002:a17:90a:ba93:b0:29c:844:a91 with SMTP id t19-20020a17090aba9300b0029c08440a91mr5600961pjr.48.1710263008670;
        Tue, 12 Mar 2024 10:03:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf20-20020a17090b0b1400b0029bc2b845c4sm5986405pjb.11.2024.03.12.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:28 -0700 (PDT)
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
Subject: [PATCH 07/14] x86: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:02 -0700
Message-Id: <20240312170309.2546362-8-linux@roeck-us.net>
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
 arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..d87bf8bab238 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -23,18 +23,28 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
+		     "\t"  __BUG_FUNC_PTR "\t# bug_entry::function\n"	\
+		     "\t.word %c2"        "\t# bug_entry::line\n"	\
+		     "\t.word %c3"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c4\n"					\
 		     ".popsection\n"					\
 		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
+		     : : "i" (__FILE__), "i" (__BUG_FUNC), "i" (__LINE__),\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
@@ -80,7 +90,8 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
+	if (!IS_SUPPRESSED_WARNING(__func__))			\
+		_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.39.2


