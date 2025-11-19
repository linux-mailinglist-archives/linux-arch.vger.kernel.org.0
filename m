Return-Path: <linux-arch+bounces-14925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DFBC6FCE5
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE14F4528
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827832C927;
	Wed, 19 Nov 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POzM0FwJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144492EB859
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567132; cv=none; b=G4Jlr7srjztOrXlCFaqsbckNaCkIcGfYbQeB8NcLd/D16AYAj1xTO2lDB8t1DRIZI/snwoP23vWPMyrcDcV3fNWwrAL+LbThfT55sxwwsG5Vsc8DX7At+RkZq9ygNU1ohVOJNYp285jXbluoUglYZ5tWbA1Kl5ZJykjV1P9lLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567132; c=relaxed/simple;
	bh=uHw2K4abduiDzGpZ4eX0j1eSGliuYPoG3xQUhEMZuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtcqKjLpqRJQ/QM8KbvRQULGRZmvqEuKWC/axtGKzu3JrMadGbNVRlXSMDxULZlj5sc9LDQRhc5dbkndMKfJslHqM9ueot4Zw5P4SvnOCKJPAjxZ6On9LS+X3XfWVC+OG6vmOwNE6P68e0m2HiyMo9wuhvOb4JEGneSIOotVdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POzM0FwJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3720e58eso6292312f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567125; x=1764171925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3irtgR9V6ILkzi6aCmzqNOzM4wzsrVUTWgR/+hcFNWM=;
        b=POzM0FwJqd/SdL87jP2GMAUIGjXey4fOCpL7ccvdQFlLBGoh6TpPgeAOPAXKPy3rC6
         2f3BvlcDX4lGoOR84lem+RbdtLt8RPGa2tbgMBuPxaKNO9opaYqdf80cop3Q/VowQgGH
         YYkotKtpK0JABL5JcU1bH7o5RsJIPKV6mp4ED0W7ecl9GKcdZ79YCxbL0muGEPLcKqMz
         V6THVAxGDvUJThgal+ibL1TYjlGAVALilt5bF29kE3NJAqCBjI75PkcU1CeyuwyN4uq4
         O4kcmlKLnYIOJl89JsWU9g848fXyvYpsKSEPvVHwlzHnJpQY5MTIgruFA6oe0bBx7Hqs
         kNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567125; x=1764171925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3irtgR9V6ILkzi6aCmzqNOzM4wzsrVUTWgR/+hcFNWM=;
        b=gYOCiWxm5VKLi9sL55vTA4QFpNfv/LrlLEl+rGFNqaFNPQHsOaOUIOVFVdxjtaf3d1
         xM7eZe7Lm+UpXNbSKFqXEVobBDxFL4t1gwtgYS4p5sKjv5N8D59yJsH6pVLP2rFa+Esd
         YfFFkqCHWSpXFQhOSS9S6RoGzG0DP0WNI73DQcXSTKq8Lk3FJ+tn0c64Iyrn+d4MxsRK
         gtMdUHBsTv050JVTMxro9Lx9btQvxYc7z+nY8X/nYsm4HbuQQfB7uIPEgZectUhw9lST
         SLbvEznVNSAAdnRoEeUShtufNGtq+811M91+ImaYXLZ/AfhjnGxpCuNYxifM31LDUzcD
         URFA==
X-Forwarded-Encrypted: i=1; AJvYcCVz9owuz/6LZ271er5ilSvRCtyNdjeLBmrgtpVJ/7NjObqJHiHXRIQ4JY2Ke0tbBesoLBUAvneVXt+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSOE7huSdLFcCy0ojoXUDL3JtiAaW/7LsuCySzuGTW0F5aLIv
	L3Mca2RPIcQTrx6Qh5vFk0FXFEBJVmj/5aMazm3aQ1cdkMMVW+Wh2aEvzWeS7Y0hIO4=
X-Gm-Gg: ASbGncs24QtGLe1KMskm+EZ3Ja3AfBq9wUl//cbeLDNn4LjGDaBAIrglp+XD9l3l7MQ
	JHsk5dgSOpiPAw8C9BFzJDjA9LzrRTSFm1QbyABLW/qcT3V4J0lgeexsCi5KEdXO+7UV1hTa/vk
	2HsPT9EOTRkfzce5Swo4wF8G24VyG5OGWLQpe1S08D1gbwJXDieVNtkVSrXl/THdYWYDId3dGcE
	lLsVB02SewuhAxtcPZPUlc57aEUPbJLdkWheSKM6bUMzX1JB81AzsvMywUSqxMlSu1VDcEkuxlO
	/YdHjT+W+M0Bv7JUF/mMdjuvye/FTIjjPIahVGB+ifIWthHxpiNX+Z7zrnPr6wHnrDU+DS/8AWu
	REh8BbTz4wK8CNcO5AaSBFtJ8aWyZ1VYJwmT/RUAfUWx33hUIuQ4S0FFyfSy77eCxbuOkyD87EN
	I2JGZqyLOj4hr8G7GclvGUcFZfglf7sA==
X-Google-Smtp-Source: AGHT+IH7OiMHuWdKqmUscjGj0hpAhy0+8U72IgAGXn7ATooehRTT7HxTJk0qp9VlE6dzqjBsHdcltA==
X-Received: by 2002:a05:6000:2901:b0:42b:3e60:18cd with SMTP id ffacd0b85a97d-42b5933dfdemr19022522f8f.11.1763567125510;
        Wed, 19 Nov 2025 07:45:25 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:25 -0800 (PST)
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
Subject: [PATCH 05/26] genirq/irqdesc: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:06 +0200
Message-ID: <20251119154427.1033475-6-eugen.hristev@linaro.org>
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
 - nr_irqs

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5..89538324a95a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
 #include <linux/string_choices.h>
+#include <linux/meminspect.h>
 
 #include "internals.h"
 
@@ -140,6 +141,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+MEMINSPECT_SIMPLE_ENTRY(nr_irqs);
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0


