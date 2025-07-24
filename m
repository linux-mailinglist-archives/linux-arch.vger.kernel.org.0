Return-Path: <linux-arch+bounces-12917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DDB10C56
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B791889FF4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8D2E3373;
	Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW9AcyqK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCD2E54B2
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365396; cv=none; b=DM37KlvQJDF7lsYjs0TQEc/muO1+wbkTy/p09Az/W2rwQu+qiH2iL2vx34nBJEb08Pl1Eg4zKW617xRUQo7d5WmSdS/m9ddcb6Hy2YL825e6JJiOoIKRWdNFj91+wqxLRNfPVOl0cSUtrZsn1UbZzAYfipZ1bs+3+FqDdWDqANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365396; c=relaxed/simple;
	bh=lInkchUokjBe+FHAH3BxBiq6Y7tXF29NidQLxKe+PNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVjB7PyOiKrulKZk6aJ1OPfj//RQqzzQuzol0hM6QvO1KoL3R2rwtm4DbxVhYmgF//NIhLfv+Tzq6PxwJ3dEuFYfuQm9erOrD/nxNNcF+5dW9HSYHs7+E6zwqfLkr5ZbtPa47GcwUptElHKhDQl8Bodeugeaj8tmRBrJK0ju4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gW9AcyqK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00283a5so6422125e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365392; x=1753970192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=gW9AcyqKuSMhUqviT/CaEES5gWyFk0OxnCjCR0DV8Rfx02S0IQgPMd6CCa6dOcVh30
         63+5SGga433jpyLCKRIXeF4x+RONQMfgfnRhuEXYSrdOc15P7ZP6knymrDIPSnlOXUbc
         zFBeJYEvIP+0Q6l8vESKKOH7mvgMS3go6yHjeswsqDv5pCRNkBsMaFUpGolOHFcK9KIp
         B6bRuQK/BFUJdswR5pSmYLkG3M9hemjwfzoAjOdEICNheo8uqwkwqNhLV8X2BZObm5mV
         YQDLMYBBmiQ1th6CMa1aSDiOzN50Af38DcFCS6QDL1+4TAlQC9tZri6Kb23R6heF4d/x
         wrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365392; x=1753970192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=lHxkXM3Y5o5eLDbpNQ3l9cNKBeSn6ysoNyXKTZPN2y/iAV+wR5CESqMttLh6b6puRK
         ZkogV7SPkwRCLrzGOY6ee19n49ri3ln47zZE9kHy9G+JgrXAPhWDj/agvspscjX93usW
         RzPXfimx+odSws3eRaPbwhprWAEckVSZHSfwcM1UZhtdsWsJLK5HxukkcrQEwNh3/2Ey
         Ep4jkmfQwr78XxvF1Ffy+mN9P2/w1w7NGym2QEg4l9iQlQgCA9QODTVJVb2t5A+RWGKN
         IzqcJkMrmVJMsa/2G6Ja/Uc1QbNuUWip0CtaIABLIoSq1H32xVxo5AZiVovvJGSwlAMu
         z3aw==
X-Forwarded-Encrypted: i=1; AJvYcCXkCiJVxSre6w1qHq0tJRn+0f7uoVOFpmx9q8sCzZTi4wugDUe8/gzqWzajJqjZ2eE+zieNZ/n+A666@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4Gl/iqQkULsDth+g0QZvrUNifuxfvKcEgPU9ig7h4gwfxpDX
	PO91U2EaoXVzV0o9aBUsCydP2s7QkZbiwaCzkx+QCSvfNkV/WOZAG/IZgZ8Qt8CBDuM=
X-Gm-Gg: ASbGncv8awyhj60+wl2+xiake5ZAuNWrwbvxEbg3RUHdypRHajqxUPeJwaKbXuqXsHj
	uef1GbTQj6CsfAv5I3f5E7AC/8CSPDXiqBVpAHPC7dXyrH6se7r/Q6QGBxszh2kYZ0nc/vpo1hV
	QwjysTWEkQjPSXfAw2oP7ZXCL7vSSb/TMY33dqnx/JX72bIJC6B+3YZqc5gwQVFbJX2Xv6zd97c
	k7yQnAfOMGXoCrrdvfaudb2cjdRj36R5nyor2epz/OB4e9nzYYH2TwzEtC22ng7CcS6jqniAjcN
	gNniQJak1wtO5JQ9dpKHSwipMVnvmaLzZXKmOAEzMRD7cwMV4dI10BFQcQqIQdQJTrk426qsUKh
	W2KI0vX5dK/Qz/LWuYd+/brjXfvkRIaZlWNu98WCym6O8dWjcAZCyS3D+jdRnNIewYMONSTKW3h
	Z+ZFsNz4ArEm2o
X-Google-Smtp-Source: AGHT+IHonQ82jnLO0p5HYq/pDMzB+6N1t6DWFVzcA1CVX2U3nXqH6sJ8SaBoH0rb44h0xr8LW+w4sw==
X-Received: by 2002:a05:600c:6992:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-45868c99c85mr63756925e9.12.1753365392038;
        Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
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
Subject: [RFC][PATCH v2 11/29] sched/core: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:54 +0300
Message-ID: <20250724135512.518487-12-eugen.hristev@linaro.org>
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
 - runqueues

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2343f5691c54..18ba6c1e174f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,6 +67,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/kmemdump.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -119,6 +120,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+KMEMDUMP_VAR_CORE(runqueues, sizeof(runqueues));
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
-- 
2.43.0


