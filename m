Return-Path: <linux-arch+bounces-14921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424BC6FD3F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8524FC983
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861B2E8B74;
	Wed, 19 Nov 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5pyMbCL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564E2FBE15
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567126; cv=none; b=BeNOkKc0xoao/e4VJJu1fipgIksd/Avkg64rAaNEyMaT92UdlDUBpb4Fak5YVo2JzyKaFwALHsuR7ttGu9hEwPYi+fQcUu0+fVJmrkRw6CoUvJMhOWYwMZWqYWdksM1uJvlTJveNtP3yEpEIv0ux7cYUeIMwy7QMoxhCw1eEt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567126; c=relaxed/simple;
	bh=u6+tt3XawPHF2h0PehB6Hh7l1nZTQ0AU8uD6w2tCd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNEXtl26XHAI3UPzK+OzIvKEJjBBpGqFmHT9w8IzJdXDaOL/6fhvf5Ce9lYA0NhiQMbekQlwSaZXzDJWcMQv2D1UoAeqlJbxVLlIFCU9uUlqejTFPY8Yc8dvjElRxFlc4gwfptCjkZKKUmSLJ/dALHu7QniY4Z2TOFWPGlRAPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5pyMbCL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b32a5494dso4138743f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567120; x=1764171920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgUegTKLQ5c0JCFFEcjPGQkSMjLGl3oe1WVgssxW3WQ=;
        b=S5pyMbCLkC+99Hx1gcI70qTu4rEHdL33Myi9JVWNml9rEIK8AWQfKJChpsnOS0UXSD
         xT/grITh57yDq5oiBWFs9gcA/vwkvJvSVf3fFbGjJew9lJHf/W54qPdFGXHI27RSZ4As
         7wtTkt42jRzrr0w4QQR4QBSzJv4PWWykiLymHhJNfnm6CDzJ1dLWtfC3uBB9XM3mU1cK
         FOQ3ib967M/9a3nhOC8EWr6flSDFk6rCgVV1g9lIsY3rurcRSu3uOB6VQWjXNzku79Lo
         2U28dsxwUkHJs6xhLfM/kz7nq1RnfFvGWiLU3ZHW4hdsQr3pf70KGHr6ddavAO0o5uqe
         rwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567120; x=1764171920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IgUegTKLQ5c0JCFFEcjPGQkSMjLGl3oe1WVgssxW3WQ=;
        b=sStJaQk8sNUFN8eaAmId+W2WXz9Owd6N0huFvq4vWSH9JmmRlOZlaIrbcZdHkcZ9ol
         1dl+BwKu86P4g4vDKEddG/2T0cVMrlQIuqmN0WxlY8bKgzBcOTLnoLY+L3ACcHmXviMY
         bAmboa64VIDoyGTNwVGDgksmo+5gNRzQwCxkBDaQAIJUE92gM5/JQFkq9zvUZvBojuqr
         c8bvt5jmfU/4aqSkoNng41swbJoznDJGHU+VTzJ+dyg41GTiQiAId8CatRTh2/VJMn3k
         Nwu5z55GmADUfPQlId4+AZFvtGg7g6bsf4gCA8v9sT4P+BvHEdvmtggzpO6oygXwvEFx
         HODQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj9BMN3Z2PEv8XvBloSBIFViCf7/VvIXT27ksi8hLS4ElB9trlauQVt3eh/O/hVNs2J8h1x9AhXTYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy524gpc1lFohtbRYsNltzzeluTdI5oTpF3vOAVJyIMfXvJzurS
	vI++oggS3PnvzDFG8x5NY7v7OtOfQGkgEfdzVCjYD6mO4RVmseNuz4g4zZcNValr+Ng=
X-Gm-Gg: ASbGncs75s6fuIpKvDc616as/Eee64llWKFPppJitCl4FXtBNgJTHIwtaj0Ac8UEXRE
	Eqa/rKJbZM7Fgk5xmztaXOrxLySFoWV8fPJ5ZG/MFp7tCJy18MWfwrnB9xTJIFUKQJ2h/i3UZsp
	ysv7sGUg5u6JrqPf73PE8gpCvNxWxcEsCJn46EX1Kyq3X60UVP1yX7hQH81I8Zl9Ii3+ezuyS7O
	K54WWQ80qn3uM5mWsbp4cQfWJo5msHbhv1z45GCXXyGh4WB4IFLm9vzwAkcvY4HErJka0y2zd+N
	Uknv18WHXEQZDf8061Fr+dwaVm5GoHbanWS5tM9cAAPl6GkAONEWw4teYFDOQR1Y0NiydorsP1C
	9PWmiCl33xC8sZFzImTZu9ydeV0GAx/a+vTA0ByOQQD6HFVVR6WBVLTDjEn4FtXwYkhk8ppyxu4
	o1ekX5+tjVGneiODzh8GhY3jhwdjqxm5iZHycQxFt6
X-Google-Smtp-Source: AGHT+IE38LHRCo1rRgXHbp1dPmtNTHQzc/1FY0jCSEqGBXN/4naA4QLiTpPfAdRH3ooZXhi3gOLsPg==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr3485815f8f.25.1763567120163;
        Wed, 19 Nov 2025 07:45:20 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:19 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 02/26] init/version: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:03 +0200
Message-ID: <20251119154427.1033475-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - init_uts_ns
 - linux_banner

Information on these variables is stored into dedicated meminspect section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version-timestamp.c | 3 +++
 init/version.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index d071835121c2..6f920d0e1169 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/meminspect.h>
 
 struct uts_namespace init_uts_ns = {
 	.ns.ns_type = ns_common_type(&init_uts_ns),
@@ -29,3 +30,5 @@ struct uts_namespace init_uts_ns = {
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+MEMINSPECT_SIMPLE_ENTRY(linux_banner);
diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..eeb139236562 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,6 +16,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
+#include <linux/meminspect.h>
 
 static int __init early_hostname(char *arg)
 {
@@ -51,4 +52,6 @@ const char linux_banner[] __weak;
 
 #include "version-timestamp.c"
 
+MEMINSPECT_SIMPLE_ENTRY(init_uts_ns);
+
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0


