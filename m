Return-Path: <linux-arch+bounces-14926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 753F2C6FD74
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57B624FD3F0
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE74366DA0;
	Wed, 19 Nov 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ/ijRdZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D372E88B0
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567133; cv=none; b=hmZZnvLDkMK3a5SZSe8RnmKpC8G/6SvePzNQxNNfW/OyXcdbyVESeWhcQbwHRLGthRZAuf52+JXzSGn35szFcsAi4o3eIIXi9aTb2t62rSTcOzNEfy6yzNnqC953oVdOFDhXK48e0ll42SkbujMdb4IewmBd8LITa9pLwAZHhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567133; c=relaxed/simple;
	bh=VU47rRSEpIhBbnpqxo3Mzoi4kyXh9HmEgVPJi/PKKQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOZ69klYB780YuyBSFn2mZQabjBbs/Y7FHvIkU4oFVTBAr6R02EuXakD7KXDEOSera7T2kCJKfhualAsEkxndJHQyg4JMbp2BopsNLNVIeLw1YphSrzIKbTZco2kmYBPywf8MYAo/VBAImxtLKexHMrv56pqsrzNnwEv/N2l7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZ/ijRdZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso3464066f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567127; x=1764171927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjfIjN6LzAYPexJPKxlzOegJPOplIDmw8UmBc2QBBmw=;
        b=XZ/ijRdZu5x0OvTVmkMq1wPbsmeKFbLQbYrPafVtvHT+ZqFCKf2Qcp9C1tVp2N/J0D
         knNKJXhbr9JziRTGWFdIQncXLZViZHEaisM6DwHPeG9AVVqt8e5GgvS/eZ6W3CQ/wgNE
         eUAxxuNkPdWWUIiLOxyTbNxpAEDi0zbJRjyi0M/skuHii8wzYx9Fd2XFdKA55bwmURB0
         E/GzFp+ssYwIxqtSwO6ujSuf9arYgXH7dCM0Qa9fwXjuXaTftH8SAdowmnTn83UEVeRo
         Dr6xOSIAlKga7MCQloURP4hs/LnWJvAeIdLWYMQ+WB3ui+rujTltgYm6XmZue5TsfJXv
         q+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567127; x=1764171927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjfIjN6LzAYPexJPKxlzOegJPOplIDmw8UmBc2QBBmw=;
        b=fdzNjzEQB9J2RcL1z31UsN97+XfarAy/WH+f/ktP3b+Rw4qz1AHMSCS4aSwxaN8781
         me/TkHyvo+K6LYc9HiTInhztwxESFWypdBq1NDUrtzIPhcgg3jLqEBdbrDUbCRJE+wDF
         11tRWGFmWzjDCRxEahLIbv0AlqZ6jhWH7LMi1mlG8bCOmLo68C09wVYG3z9xxLJlsreI
         8g/fjXz3Qwx+AcGdctHKSPax4wlb5Fbt1e2x0BtyEAPhpzBPdwnOsKTEZv+LwLgBB4Ey
         npc9ZHeeieNpLq+t/PyxV30k5NPva21x0P5AHQbVHI+WUQ03ludinQre1dxP1sbUIJC7
         BMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVirpXGtWOUQpgcJFcH3DfjGb+2QfIjI8LdrjYKXrQD4oNmMIX0GizSbs6L6MJaXHuFqQv2YKR4/KJE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo18xLgvM8X2MNT9AVwZ1hRaeM2u/JLGOa3MF0iOTzeIs1mOiX
	ern05MZ6Ybq/FlIr8DE8i0jUlkScn8k9mlg1KzLK1W2Wp370HTQlugWLJcZYJYQSIAc=
X-Gm-Gg: ASbGncv2/pPEuRDsT6zDv7RsWiLwsBbSxXZ/mS5MUKkQBaRKSh/LztVMi/4g2yQXJ83
	CZZH8lZIKg9dBWcM+1JMgDrpeTq3doSw7czkbYnsPpMBQLQmiuyauUhPu7/1Eyh//amnmzT07Ys
	3BJI81Yxn2PAB+YQ1dh53PToZ3FWrCPCKPjSJAcBSQprMNAHZCjhBgdBZzXXZHZULImN3SflPgr
	Yl53Kl3g66BOgeWwXwDv2r/1FIL9SLeZ9FjlKr4V3akI1I/an4jL327BTK64/bzlwRT9TUTtC+s
	lnFh/Mfg/mNZ7i5pahBBPHN8LHjXPfoQdwWvXSytOe+9gtWJL9gydCwjF7rV37ciRbQpAsQj+FA
	bLxvzToajcs7XirZhi+Vde48Ze0mygfppozrAvGPFBOfgAYlTM123cqk+BgKEuF9ddO2wU74ZvZ
	q4Wy+yRFoCsVfEtGU0GZFm1hxDoWESXw==
X-Google-Smtp-Source: AGHT+IEfh56DkbcMOsGMiLrQQwNoxfW0lTNMGX96p1i+gi2+G5lC/DiQdo+bbBRy4PiX1VmL8kOK2Q==
X-Received: by 2002:a05:6000:2a0e:b0:42c:a506:9dbf with SMTP id ffacd0b85a97d-42ca506a058mr10726960f8f.39.1763567127227;
        Wed, 19 Nov 2025 07:45:27 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:26 -0800 (PST)
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
Subject: [PATCH 06/26] timers: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:07 +0200
Message-ID: <20251119154427.1033475-7-eugen.hristev@linaro.org>
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
 - jiffies_64

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/time/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa469d7cc..c6adea734b93 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/compat.h>
 #include <linux/random.h>
 #include <linux/sysctl.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -60,6 +61,7 @@
 __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
+MEMINSPECT_SIMPLE_ENTRY(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
-- 
2.43.0


