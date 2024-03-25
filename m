Return-Path: <linux-arch+bounces-3165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2588ADF6
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772E91C37648
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8A137C3D;
	Mon, 25 Mar 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqpEw88b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA612FF73;
	Mon, 25 Mar 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389194; cv=none; b=dv+f3YOOaMxxEywuXvmK6kEQIWwH/UABar2LmmmR3//pnwi2mLZilQwGGnhGwEfu+FyTBFc5BPyZdAtVG/h0Hx0Vrw5dMWR9oYhDAZNDQLxgA/wq1Ht4GEuCdmfY2lb1XAummneky2Z3HVG3WlXfbMLkQ66hh3N60OgVl961mAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389194; c=relaxed/simple;
	bh=gXmhoSugTMNNbGcVNtnGx4y/QKbSNifMSyDkE7Ry1VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K86DQNe+AyatNbiwm5CS12L99tXAnVPqp1JM8VudG8ONALxmgdLHW0TGtBG7udCLAwK171LPxm75Ht2vC1JT64Dmk9sD4UhsMaox1jIVPbyi5KqYDO9AcN+4l369YfiySCbhxIegWK9uy5Wo45HtbrxKtfhgTsJIiYMwVmh6+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqpEw88b; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a485724ddaso2776292eaf.1;
        Mon, 25 Mar 2024 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389190; x=1711993990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F30AvGE946RVy95xtPHKquJN7yP343T7iOtn6SBetHs=;
        b=PqpEw88b9CnxHKKcXYDzzFuCjAqkKSAsE6+/wxPgwSEaFuXu4b5PCJ4BiTmR4m6+8G
         wZWtFujT3XJgw4n27Dor3KzZJXgePpk/EsbiVhY7Vo+zJrJjq9BISILMkr+fWPcnRvOs
         cl10UEpwTHKhtoxDwzuSPrcZ1u3ZVlvFQj7+akvCMSF6ozpOz14tNeG3chqnWhjuOVL9
         CjPiJn07s0i8W8CTwBtILRj60IjAzI1auQgtpGWLzT38J9CciOTQedgqKxqSNfO8R6V8
         eEhuFvtUvG4ygBWPZlFrgDtltvAfmO9eNvQoWmOR+DqKcptLKQ7ZiCLCYQ4URsgfTExV
         OUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389190; x=1711993990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F30AvGE946RVy95xtPHKquJN7yP343T7iOtn6SBetHs=;
        b=Jx1KQnwBGoPFH0F9jEFv8TGlZzb4QsOUgBwBHmCT3K9xOtlIcluzQJvpPqPgZVe80r
         DtADtF1sedVvES8wDLWMcsdcnm7ZIbvAu87F15Ctk5GTjXbCa1SRVzm+DRwGlTiYe5qS
         gIGJfMvZAQ3G8dc9PJj6i7G8dFBQ4ILMX/nb0FzGxcrK49hD/ioZA1w6DYQWNI+2Yonu
         kESWuFwb5oCSM1v2GpOliNhybAOfG+aj1RE3l4KlRhOONXb2q5pqpeKjkXkIkzZIpnb6
         TTjOo5hCQEdgWagZqa0/AsxmpHMxeJyrqCkDguSbJJQOR06lOSweMEg4kW/dVnvzQZuc
         p9og==
X-Forwarded-Encrypted: i=1; AJvYcCUQJ63ormHIuAUv+bevVs35oNCssBO3gOmaBmi2+zS/bhaoCgdfDaZgL2jJEFSx/KamRdsvvJ+6HLa8HPmEChylPQzw3VdKAOK99sQqVF10kBCrCwHD379wnfxVOGxTUfqZN+pE8yJueRGOYQHlmszILvMFwFO0TAT15buRb/kKj3MSo4BYyT32cUaGC4uFyT5/grMTrKNQ2eI7Rui3FztsEqgAnduaMhqCvHuseJAcyG0ju722twi5BtLFHEbm+VBRwWrQd515y5K3HkZqDiGq1NjiT9o/b3K/bQt9zlbU9JnFMI2OFhGA6EQch9pkeA==
X-Gm-Message-State: AOJu0Yyn9U0gqO5GcX9w5/P9TzAx5wN5wYl06DeCVTf0TzfbE+BmjG0e
	QeCMqWp/j5dPzG++lkJpPMPOMYRk3l09Z76wZ4KfG4LdJQWH8YSC6cCrC9aX
X-Google-Smtp-Source: AGHT+IGEgVL6INIMyDJU0IaAEGEaDLUMgFRfTdxKfmOhvRWOloE0bqtXSOQ5POYMBfg/SxiyshOSnA==
X-Received: by 2002:a05:6358:2922:b0:17e:4cad:a11b with SMTP id y34-20020a056358292200b0017e4cada11bmr9108706rwb.19.1711389189758;
        Mon, 25 Mar 2024 10:53:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w62-20020a638241000000b005e485fbd455sm6068607pgd.45.2024.03.25.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:09 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 09/14] loongarch: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:43 -0700
Message-Id: <20240325175248.1499046-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325175248.1499046-1-linux@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1; resolved context conflict
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 arch/loongarch/include/asm/bug.h | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 08388876ade4..193f396d81a0 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -3,47 +3,63 @@
 #define __ASM_BUG_H
 
 #include <asm/break.h>
+#include <kunit/bug.h>
 #include <linux/stringify.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #else
-#define __BUGVERBOSE_LOCATION(file, line)			\
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)  .long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define __BUGVERBOSE_LOCATION(file, func, line)			\
 		.pushsection .rodata.str, "aMS", @progbits, 1;	\
 	10002:	.string file;					\
 		.popsection;					\
 								\
 		.long 10002b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #else
-#define __BUG_ENTRY(flags) 					\
+#define __BUG_ENTRY(flags, func)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)	\
 		.short flags; 					\
 		.popsection;					\
 	10001:
 #endif
 
-#define ASM_BUG_FLAGS(flags)					\
-	__BUG_ENTRY(flags)					\
+#define ASM_BUG_FLAGS(flags, func)				\
+	__BUG_ENTRY(flags, func)				\
 	break		BRK_BUG
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
+
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC    __func__
+#else
+# define __BUG_FUNC    NULL
+#endif
 
 #define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags, %0)) : : "i" (__BUG_FUNC));
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
+	if (!IS_SUPPRESSED_WARNING(__func__))			\
+		__BUG_FLAGS(BUGFLAG_WARNING|(flags));		\
 	annotate_reachable();					\
 	instrumentation_end();					\
 } while (0)
-- 
2.39.2


