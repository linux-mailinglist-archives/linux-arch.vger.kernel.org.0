Return-Path: <linux-arch+bounces-14943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB8C6FCA3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 26B172ED19
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5753AA1AA;
	Wed, 19 Nov 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h67n1qs9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F22E8B6B
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567167; cv=none; b=H9cdyEPVq9p5EBSUk9lSe/Nl5lSTovgg+1KJhuFJlM64IjfLpsRPCzhdUJ6cvUYBYoa2vYBVftD55giKOmEtTIeuMohEtNxGg+FfThrjLTYjfhYrehegWYtCo5nAAGJYBE5Y9TobPLbAC1lqhvfmmVgFgpxgJvUmVAKikKmUGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567167; c=relaxed/simple;
	bh=BG5tLoxomZq6QyZmtX+DmOmp49QzG4CslaIEh2rN2og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOf2Zg9K+xMlPNb487vDE77FeCLfTB2IVp9Q3K5jFvbqvj6VsF9lA7ameSqQL4WGW7v/34HqygvyULDi07A2pikQztwHW6poPXUVzOi/Mm094zcGn3PcmHCIeu9wov9k2JAqGc3M04+PtRkFw5znctEbjwPyAoQkzn5HKzHcZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h67n1qs9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so36866745e9.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567159; x=1764171959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqVd/I23ujzds6aG+1Lfyj/OLmPD/Ehk8Zy8jv9bGeE=;
        b=h67n1qs9Ihf0s3aPMinZSRCAczRQpw45ihMWMfjlNIvhknSfGnG+w+mMTwEi2c4pVy
         DL0+rKrt3+DReC07qFokF5Zkip6Gxvmbs6ndgMAcyZWTrgMwyDTjzLCMzlMYA9iEa8Sp
         Qtv3Ml8J57ag90nIHGke7OMoWVl6pkSuHd+H9mOYHRulvjzQRwMtGgelh1C/+3AXs0Vp
         mPSyP3aEBR4pq7oTf94IHwIeM5TfZSJDalWq7B2Kt327N8QvEp4zkM/wHSsLopjX5SEg
         6CImGXk5cI/2l+iH0yRuOdj8QppJoe8lro4QThyAmtoqPuVU4Oz9R0Ce1/nthGUifyJ5
         gWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567159; x=1764171959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqVd/I23ujzds6aG+1Lfyj/OLmPD/Ehk8Zy8jv9bGeE=;
        b=phPtA9pYts3f+aQgH/f6+BHlOSNMcvXiyDKFgYdAAegHWl/M5NqfbIs12dQoj2EfmQ
         OputT4sk4JDeYHKnHVc49XOB/aET2AT27fubaMDaTRt+MboEl3SH68sSCFczv1+xWEs4
         UHsLxbtEtNZIDax0IZGtqgOHj+INvc2CGfUJdTUV7zdu3xChJJwOy86A7Szu+Xy0XEQs
         03/WxL/BpvLkuI0az+T1zwLJHsK5UTUqi6VcGGuhUtkjtuiUqtFMVCKl+AWJOyG77cc+
         Kz48V4pTsKVKs3OIKp0OAik8eOYyAF7cvBRwiOCZVNI70a0KHKqfJxhks8xBnaH4KDND
         YrZg==
X-Forwarded-Encrypted: i=1; AJvYcCWRF4hD39ET07iQrgbb+tTvLn6NK8eF8tXJJrUie5deaQYdDAopZKuD4h6fEjC1mpHxHNOM1iSiOTBO@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrmSwoqa99XI1Yqyn6Y1p5XODFavbse7/lSMc3Xb0U7YtXsJ1
	+Gk1EP/YbtW3yT87DgjbX98pI9g1obgRS2XBHhwUYRMlXVx22iUNYrfgLx1Ku188GBk=
X-Gm-Gg: ASbGncsH75laM7sqZTqijFPN+pyZyi9G3Seuyu3f1Na1BjaDP/F4pUgc4X9zAg2HA6S
	CiEwxV43JAUcsuaWfGfhWltJjZYSWlGvDfFgyOqa5dSh/DxWcq3kSCM9b6258pu1hdtlnOe2vAQ
	jUuXZlqf1s/6z9uxbkwaV3Tml77JbTQUVYgpaavJhMFj0kA+poP9yDZnligeyAj/VL/+CYogWUK
	hL63aECOB8nt8JoGPyJSjTxYbxveNwC3dsOZg0WI15lNKoWvItYNx7C0XIw2RbhAOfgSM8EV6x3
	72mUfKqqulBp0lJLftAXR3Z3K/FQ2ljupoQZzxikHIWd/6r+YVO0YQkHBghngS8IXmeW2FUPf6C
	KZcDdscYY/vP7G7/o+Nuhg8vlUE8tQOPAfV89hCt/Z2ncwXEqNqQTyWAleYWoMbznY5sDxh9ztK
	ZOGwVDq/FDUkNVdgIR1fH1sBalucFtdQ==
X-Google-Smtp-Source: AGHT+IETZCFytuhcxmwyAYMbvVQ+k0LcHrDBKuExYdhaEVzislepliPqczS5k/WGmFJtVck24Vggmg==
X-Received: by 2002:a05:6000:2405:b0:42b:3a84:1ec3 with SMTP id ffacd0b85a97d-42b5937ff2emr21375859f8f.29.1763567158737;
        Wed, 19 Nov 2025 07:45:58 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:58 -0800 (PST)
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
Subject: [PATCH 24/26] soc: qcom: smem: Add minidump device
Date: Wed, 19 Nov 2025 17:44:25 +0200
Message-ID: <20251119154427.1033475-25-eugen.hristev@linaro.org>
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

Add a minidump platform device.
Minidump can collect various memory snippets using dedicated firmware.
To know which snippets to collect, each snippet must be registered
by the kernel into a specific shared memory table which is controlled
by the qcom smem driver.
To instantiate the minidump platform driver, register its data using
platform_device_register_data.
Later on, the minidump driver will probe and obtain the required memory
snippets from the memory inspection table (meminspect)

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4..03315722d71a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @mdinfo:	minidump device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *mdinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1236,12 +1238,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->mdinfo = platform_device_register_data(&pdev->dev, "qcom-minidump",
+						     PLATFORM_DEVID_AUTO, NULL,
+						     0);
+	if (IS_ERR(smem->mdinfo))
+		dev_err(&pdev->dev, "failed to register platform md device\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
+	if (!IS_ERR(__smem->mdinfo))
+		platform_device_unregister(__smem->mdinfo);
 
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
-- 
2.43.0


