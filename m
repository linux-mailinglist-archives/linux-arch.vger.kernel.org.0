Return-Path: <linux-arch+bounces-3385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808F897068
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C49291DB4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7514A4C3;
	Wed,  3 Apr 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP2g0AfD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7E149E1B;
	Wed,  3 Apr 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150397; cv=none; b=C/ohZooTdvMFMKwzQkLNOUoaoNjvQMiHU8xnq57khyoZc2iqsJ48fs8IjtMwdCfTbuk6jpe3JPpPtDIXfr3ZKjpyFp01jLdgxSLPPuqTyVGEUOSJssPDVNbeOqWN4ryA4coxB/3NE4Cm5s/NcCBJjCdwkBSHYbv9qy2Ce52Gusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150397; c=relaxed/simple;
	bh=Kg0z2PrQoRReOXjtrLEi52h24HarnnfhxKRaAaDyADY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVrARyvXuKd+sjcW8ccmQAOXxpjSOu8gZ8CucC2WYjklhXSF3qeAm+0EkLgmuZVN/0a2g5mrwHhnMV3OHzuF4Me5d5iLH6oPMidvedlb5lkqPCEC9O/RtDl4KJBSsvANYtvZzFTaZIopXyowIeuQ4VFhnu397gWUkYrdikJnF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP2g0AfD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dff837d674so50252435ad.3;
        Wed, 03 Apr 2024 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150394; x=1712755194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz48OxP3NhYfgMKsflTw0/QUK/EsEKDn2LToBTsPHNQ=;
        b=hP2g0AfDoHZFvnL0luSMVUxwiR5yVYW7KZAIa7W9WW2e3kad388CvGRTxV9kQvfLit
         ewh9mFZ2MQkvSTYa5jflk6/ActGD5oyIrb0oOAclGC7eBVysTZ9MM5vweAhVVXAiiUJh
         LXa4sx53QWAzk0zeeQU75gKP9KRB+ux+4jOLoJ5601lc/XbBeRP5g2Y8rA+aU8ZsxvL9
         OT9jMoNORJv+LMrgfSc0Cb2Mn8nTccwgd+uo4UO0Mq1CCvgu193TxTiEzw+lxm+vkWmJ
         fvuGfNPVAjDa1tCUaaIJFhPzX7jMeDeSoKJDC0ppx9FHOhVefNKqnzQjsOrdK88HHA6q
         viKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150394; x=1712755194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kz48OxP3NhYfgMKsflTw0/QUK/EsEKDn2LToBTsPHNQ=;
        b=ZDWrRNzOLnNEjCM9fUKXEY8cbAXuXq9VMvDzbQxtNNXiYGgQB0RIMKuw5LNdQPBhGH
         V2TGk0+uIGWZdXdiSgD5JhxnQdVPKvR1YPIIYXiHPAhTJhytK/qNUeq4llPeoZ1LW42N
         zdbQaopSIvPgkW8FBFLxcl0W58jrStyGz/xLWmCJ8+c8/iLtEHpuaUn0UR53Ei1GHlGG
         N/Y17YkunbUW1RWcadJ2jiSi/Q++m2vLWEyIF8teaLXVpWG2c5kNH2LwPocJ1Zg5Yvit
         Knl8S96rJOHhJI8czVolu4bzcvFrhs9PBZeGGpNtZaBQ2d46i1J9mZvCRIIdX/2NNZcd
         NW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhYycPqUSV7YML1xYWEyt3k1mF2WHV2AMfSwZhEdEt1QOp4uwyTtlABH73cyQZV/B6KrikJ1mUN8Z1Ej9mAJXt4cf27jxhbtHlReOuL5XfggVpQ57lePW1NObEKZ5la5thCAsX3AGqEVPfnxpFarBQlFZbOVUmbY9IxD5xLO47EoeLHkHhhhD4xs74KHuhFiYlRqojl22HjK2oFOV4tp2hi677M3Gd8G+NSddlF64EwLIV5RlwHVIlp5QAJMcv1atTGhBmdOPpMp/KRatvsvYRIeP9TXzFIfwGfmiuw26b8mtx7t1sSPW8yCuH+uB4QA==
X-Gm-Message-State: AOJu0YxR2Az6LUf5fFXX0GTidOUTw5A6ay01H7MuyszuC9guZJUiu2WT
	CC9/P1nvRqubr7x5HSVmFKbKSa8TUG/FVcehB5APd76WIOnmjdf7pZ61o9cD
X-Google-Smtp-Source: AGHT+IFNgcjVYp4BARBLtJXFan7xr/0CnX1zHuDDo3GwnVh2w9uqbZMBPA/s2jR8/t1K3n7W3FEYHw==
X-Received: by 2002:a17:902:ec8b:b0:1e2:2e93:10ef with SMTP id x11-20020a170902ec8b00b001e22e9310efmr15831594plg.52.1712150394590;
        Wed, 03 Apr 2024 06:19:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902704400b001e26e1e62f9sm3840318plt.176.2024.04.03.06.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:54 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 07/15] x86: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:28 -0700
Message-Id: <20240403131936.787234-8-linux@roeck-us.net>
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..7698dfa74c98 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -23,18 +23,28 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
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


