Return-Path: <linux-arch+bounces-3167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE188B5C3
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0FBA77D6
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B983413CA95;
	Mon, 25 Mar 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn3+zbKh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2A13B794;
	Mon, 25 Mar 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389197; cv=none; b=sBakY9DxXHCI3NFYSQR6avtH40eAjsj0RrDoD/ujUfjkEJXWgvO8VBGoB3uqMp5/mL4HO4HQUspAiJ0Xl34CxtR5V0dk/io73H5/Paac7I49pMBtiOPJzOdcZEgaZc+FJMkuDMWhsny98CvPyWbIb7KzbBLdxwr/yeagf/F6IKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389197; c=relaxed/simple;
	bh=qdStSeM+VJCbqbzuADj4lChWMSBHWJ8X0eHOGVaPa9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/tnPmbwikNfKOrV7ZzOZkj0FKmAVE64CIx2GcJ9JhmjYEwWrjXXam8xBdTTnQgmlybJbo9v5At0v/LkwT+v8nD9moiQEQuTZSdgxH/l6iO9NhUHow89gotmCchv3/NVzihEboepKvCtSIRgBfZ3LfG1DI58zUI+9zLBX7YAHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn3+zbKh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0189323b4so34638625ad.1;
        Mon, 25 Mar 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389194; x=1711993994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YzJYq0fkceHof/EPazly4M40tZRXgMzxd6Hp1cFk9M=;
        b=Bn3+zbKhWji2FwFKDH//yuXeYz8EpRWrhcGQCv/jVRfgAhqUJ3U+k8WOOmjHb0U+nR
         5m7WTaG1BLp5gqTVZ/OWhOI9ovgbj47j5OGUqvc/aiJoQN28dCOD7xFZRnzHNXUEymh9
         1jS2SuyasViwcd4a43dCn3we4aLQDELxDTndNc48L1Bkf58hpYoFhKnBb4/yJWkJiGMh
         zqv+FG2e7kMZb+OE8gU990Wye38bTqXdrHi13HxEtPQh8Pw1vhiM/yasksuw/mKAPOGH
         YNfTo9m6fc6p+wNHAu9DzcP7zIVEh6sL5y0Wu59+l/Jpz3chgOWnzNgFZQPbMtWtygI6
         1ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389194; x=1711993994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YzJYq0fkceHof/EPazly4M40tZRXgMzxd6Hp1cFk9M=;
        b=Jj6zXNFP7PemDH9ydWDWpb1EEbaMHnrNJweRqCoznOOmgeY++E/Aohq7QtNd25aCWC
         2lqdt+5SzLbQxQXSu44/Uku92XM4bccHLuZqiVBo1K0t4QI06YKxx55RoFGL5+aX/Gwi
         uY3ZEZ7RP7eJQfyPeqzILkjQoM4yedBEDLzkvQMTAuHXJeBhFHmS41Uz2DO9vlnDBzBK
         9Cnjxcr3GaT4JzxTDBjsBVX6Jwj3l4sG8FrAQTqkvOmEqIQiIlo9tiWz2/j+Iij1c9vJ
         u5MysLw/UJXwq/us9Xu0ULlvgQGlTJ41HuLD16bZu9mpkxReqbOcVyQgzWCZJqm0bi0M
         smyg==
X-Forwarded-Encrypted: i=1; AJvYcCUfKBNUy5k6JkmVoJn7PUdWoafwQ7dyWSBNMhbA5xaXLWON7MKBgboPDjABd35up9urvDzkBcIrCXvv1/cKB7uvg1FH+QT5rzqgT/c9uqkShgu+ZxnSLzw3W0zOvxyebUB/Bc7rMn6zUe1IpT4ZyP6jVjexS8avJAD+hL6o7mBpSASj2vhA6WXgIWXwOqMbaBel8LyPqz9P9fwxeK2vlQMJ5vMS5tn16VKnQEKpsDBDNnCHdPNX0lM+7LNWWjdgdG8CzknACSso/ACElDF0208DsrYyKM+ZVAkjUbuCiVF79YzgXU6ZGjs7L1i2+m20bQ==
X-Gm-Message-State: AOJu0YxXuhTLIb2+OUWZqYSjyqBWyPZ77JpPCBAJBs2h6IawppJbcXRj
	cNT5yvADLUkwSi/IL2rl8oNDKmcom8TbSYmkaRqCmRvwJJ7x9+c48dNsz8Vy
X-Google-Smtp-Source: AGHT+IH4L5pCyOM7/NriCMnotw9B9wTRd/QlGQsY00iVlUfB3rIc/3hcXxQD6OWxPS5Q16CPFVorBg==
X-Received: by 2002:a17:902:b495:b0:1de:faa5:552 with SMTP id y21-20020a170902b49500b001defaa50552mr8062370plr.56.1711389194428;
        Mon, 25 Mar 2024 10:53:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001db8a5ea0a3sm4986539pli.94.2024.03.25.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:14 -0700 (PDT)
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
Subject: [PATCH v2 12/14] sh: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:46 -0700
Message-Id: <20240325175248.1499046-13-linux@roeck-us.net>
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
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 arch/sh/include/asm/bug.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 05a485c4fabc..470ce6567d20 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -24,21 +24,36 @@
  * The offending file and line are encoded in the __bug_table section.
  */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"\t.long %O2\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define _EMIT_BUG_ENTRY				\
 	"\t.pushsection __bug_table,\"aw\"\n"	\
 	"2:\t.long 1b, %O1\n"			\
-	"\t.short %O2, %O3\n"			\
-	"\t.org 2b+%O4\n"			\
+	__BUG_FUNC_PTR				\
+	"\t.short %O3, %O4\n"			\
+	"\t.org 2b+%O5\n"			\
 	"\t.popsection\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	"\t.pushsection __bug_table,\"aw\"\n"	\
 	"2:\t.long 1b\n"			\
-	"\t.short %O3\n"			\
-	"\t.org 2b+%O4\n"			\
+	"\t.short %O4\n"			\
+	"\t.org 2b+%O5\n"			\
 	"\t.popsection\n"
 #endif
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define BUG()						\
 do {							\
 	__asm__ __volatile__ (				\
@@ -47,6 +62,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__), "i" (0),		\
 		   "i" (sizeof(struct bug_entry)));	\
 	unreachable();					\
@@ -60,6 +76,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_WARNING|(flags)),	\
 		   "i" (sizeof(struct bug_entry)));	\
@@ -85,6 +102,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_UNWINDER),		\
 		   "i" (sizeof(struct bug_entry)));	\
-- 
2.39.2


