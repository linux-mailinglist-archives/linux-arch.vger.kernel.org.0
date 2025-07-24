Return-Path: <linux-arch+bounces-12926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70510B10C89
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B233B584E
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9272EA495;
	Thu, 24 Jul 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOAY9+ss"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7F2E5B1A
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365406; cv=none; b=PjjnkGUm0CeiJPyUURRlzwi/IaZkJhDDy0jyUL8ySZ8zpD4U7U5dJO7SqoA37M8pHNOi5FK10mTR1oicYeiyYw8ACzMr6SwjxEzJrNvAvkoj8BNiXNr0o0ulAcyrLTzlGzRXTVF1mjqUmxZTskOHksS4rM2ERXl4P5YJozy4jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365406; c=relaxed/simple;
	bh=wARnIHcM6q6qiMPnn5loBslIGs8WDjRosQ7TWci8o8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGGC4LtNoYV+MzbB3CAFM9jMgzNz2vAdeD/7P2nPd1TQHkhaNFYRliYX4D7pb82wDCsN0eQGe3cy+FPzs92TV2Y+w8Tapn/HMoDSfaynUKlG6DG8cE9d2H11Aj65yYf/QJdVkonf2M7RIsGBTbiEAg7QGoT7eEbUkrbuJ4Z4Coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOAY9+ss; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so10433635e9.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365400; x=1753970200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay6ISBVXr4RhwBg6A2t7OCdYp+NqRXGL2jP3qh5ffs0=;
        b=JOAY9+ssBL5AftLlTXlwCYP/JT+QP2lzmifqj13XQuxS3W5e2xCdZGZJnGOoxAJ+BH
         31i11imIbD07KejKcMpa89wM3cs+YfFj29ONOHDQ7VaHrBWEbk8SU3hOpyQll2rGMs96
         1WbBJO6uGitA1frzw/38lz3rF8qXBUsYBMeLOpuNlvl/9TgiJIzHAseN2dPAwJRnR7sn
         b2/QOtkcBzcgIa1Rr/PiTMLwP1DX5yui2tNfPlZXV3rV1jD6PM0Sk3O9pcW8OiOMaGvZ
         RbOvuf4JT21MCkQpb/L+SzfX8EOnFYRr9SCpz5xAtpIj9aMZHf4/6AN2HTCP+STXJ3Bb
         MVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365400; x=1753970200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay6ISBVXr4RhwBg6A2t7OCdYp+NqRXGL2jP3qh5ffs0=;
        b=QVEasuFQ/Wn0xqX7Gw/knz1hlsaRNc4+OcUPOWaAiCCgSHaPFaagvPObko5SeF91oe
         LaDrBStFLQnsgwzqVAS0x449aUZvmidxsI1i5NA36IFkqSM7YUV7ow475WCBxiMnxAK1
         xS2kgZLH8asCQbF7qRNRdAbFAkujK9lf8/nP5F5U63pQCc22NnWSpcgYbLVRmFPgTP3k
         m2FCNcmAMzDnGJOpNE5LEJeV8qXXyUfyptHERPGpxQ2vtK5bXMsMaOOaiPfgXeeNQCl9
         qVzgQ4ns4nO40jJrdKEiunKAhpC4OyAgCOJV8Q7+tfIKm3reRQDDcf910eOWfHL8G+q9
         ZrUw==
X-Forwarded-Encrypted: i=1; AJvYcCVMxa0DXRJZMe0zInAqOxvkmQ3hrSihNk+ZjgS9/QnuElSudOY8iv+X3MYyB+R9wE4KyMABIlQDbSsG@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+9JQiBzHcsciO6NY6mFr6o3JIzqwbbp3qjmfxhHPD2W0XNtN
	LPGtGS8GXTlwyvLtZ2SLmKRX6RDmu9jx/r3tWEbqTBkH2FLjdEgWEkQe1BpDRqj4ri0=
X-Gm-Gg: ASbGncu3Eqr1Ju8lzSeanytv7IVvZ5zL98jXxQuVTYLKU0cS2vZf0UixWnOSaYypo2U
	29ygB8rKGL9jXEx/1b0UeuNibI5OydD86vw9asas/BIuYAFGwf0cqfaHaDgallsRxijBxJHp1dK
	/O8JOhvqLimGsidtqjUhmWLDzJdYQCHO3fSqKyo9WdkhU/8hqldtrHChQ2vv7nNEi3vYIOcHHeT
	tEtsWX8MOo5CEPZ5rYFiqejVDk06+YrC011sP98k3A2LLlE9dzx0Sq6SId6cYW5vLXtVtZ7eOMU
	VAWHlkYQ9HZXudVbZ0+AoQbbmOFSrtlxlVFwjeYISQlziYJs9H9aGitrZXCgX0iu88vtscIJPoh
	pgDIC4vNa+XhXGyTxxVFZcr8WSIJynmw2J+dT9y98nF0ayVUPDrALga/B4rF7NTzhy/ase5xx9G
	ltVWywbzyWbxry
X-Google-Smtp-Source: AGHT+IGCkgT/Av7S5A2E0I2QQdMK0eQR1KK2t84reKZkouB15tDDQWfO+rh0+B+shYiLiz/J/iIBUg==
X-Received: by 2002:a05:6000:1882:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3b768c9c202mr6498976f8f.9.1753365400320;
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 20/29] printk: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:03 +0300
Message-ID: <20250724135512.518487-21-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - prb_descs
 - prb_infos
 - prb
 - prb_data
 - printk_rb_static
 - printk_rb_dynamic

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - new_descs
 - new_infos
 - new_log_buf
In the case when the log buffer is dynamically replaced by a runtime
allocated version, call kmemdump to register the data with a replace
flag to remove the old registered data.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..f7d60dbe5e5a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/kmemdump.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -540,10 +541,16 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		 PRB_AVGBITS, &__log_buf[0]);
+KMEMDUMP_VAR_CORE_NAMED(prb_descs, _printk_rb_static_descs, sizeof(_printk_rb_static_descs));
+KMEMDUMP_VAR_CORE_NAMED(prb_infos, _printk_rb_static_infos, sizeof(_printk_rb_static_infos));
+KMEMDUMP_VAR_CORE_NAMED(prb_data, __log_buf,  __LOG_BUF_LEN);
+KMEMDUMP_VAR_CORE(printk_rb_static, sizeof(printk_rb_static));
 
 static struct printk_ringbuffer printk_rb_dynamic;
+KMEMDUMP_VAR_CORE(printk_rb_dynamic, sizeof(printk_rb_dynamic));
 
 struct printk_ringbuffer *prb = &printk_rb_static;
+KMEMDUMP_VAR_CORE(prb, sizeof(prb));
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -1211,7 +1218,10 @@ void __init setup_log_buf(int early)
 		goto out;
 	}
 
-	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
+	new_log_buf = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_data,
+						     new_log_buf_len,
+						     memblock_alloc,
+						     new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
 		pr_err("log_buf_len: %lu text bytes not available\n",
 		       new_log_buf_len);
@@ -1219,7 +1229,10 @@ void __init setup_log_buf(int early)
 	}
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
-	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
+	new_descs = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_descs,
+						   new_descs_size, memblock_alloc,
+						   new_descs_size, LOG_ALIGN);
+
 	if (unlikely(!new_descs)) {
 		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
@@ -1227,7 +1240,10 @@ void __init setup_log_buf(int early)
 	}
 
 	new_infos_size = new_descs_count * sizeof(struct printk_info);
-	new_infos = memblock_alloc(new_infos_size, LOG_ALIGN);
+	new_infos = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_infos,
+						   new_infos_size, memblock_alloc,
+						   new_infos_size, LOG_ALIGN);
+
 	if (unlikely(!new_infos)) {
 		pr_err("log_buf_len: %zu info bytes not available\n",
 		       new_infos_size);
@@ -1284,9 +1300,11 @@ void __init setup_log_buf(int early)
 	return;
 
 err_free_descs:
-	memblock_free(new_descs, new_descs_size);
+	kmemdump_free_id(KMEMDUMP_ID_COREIMAGE_prb_descs,
+			 memblock_free, new_descs, new_descs_size);
 err_free_log_buf:
-	memblock_free(new_log_buf, new_log_buf_len);
+	kmemdump_free_id(KMEMDUMP_ID_COREIMAGE_prb_data,
+			 memblock_free, new_log_buf, new_log_buf_len);
 out:
 	print_log_buf_usage_stats();
 }
-- 
2.43.0


