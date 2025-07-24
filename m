Return-Path: <linux-arch+bounces-12911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9813B10C4A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907FD1888CE8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961A2E3AFD;
	Thu, 24 Jul 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHROcwon"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA942E1752
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365391; cv=none; b=r+GCb/LhNmJ8QSw2GAoR6F+qRi2DH1xWjslIE6VkB2Qea95SpY9NRwENsRKKYtYFhRS5cRyL+EgBT+pwTP+8wLQKJjA5Vtg+4vxDL4ZLhzzsyUy6CvIczmc6x6OKEJd92JoqeapEgc9wwmeUhYgCPjMQPaaQvkKnlbYOtwzdvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365391; c=relaxed/simple;
	bh=Vzp3U7aGndkyJ82EgcFvHbZjMAKNTPgILqBaVa9ZKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6mlB+c/oD91yH/Oui3jM+aYeV8xULmmjXz9EGrU4Bx/VCRvO9t+lajfx344cqhGb/TFsQgHAKLWJpM3d73OA1gx/G2Tk3jXdXPDI1VXT8JTLsn3Uv6XYpCEHv1QI14A1MmLbmIotaMPogUxDWNEgsN0cQRvKtXJP89djqnHfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHROcwon; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4561607166aso7021125e9.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365387; x=1753970187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXG7080vUoTS71soVhA4Gbq56Ym56pqDEVpEhL2XCIg=;
        b=RHROcwon2Ud+HX/4JYfbI8AeIlRPuE37aGaORXuyjeuCK/5tKW2uS7682GhreQmJfy
         qSgjbAlw6xuO2e7ct5d6oRHucze+NlfN9iQuh/n9nVkLmQSo705NqE4p2jsK//pIXT1R
         FWR6LLd2cmYFXEebAjCGRR+N1I2TqAayaMGiXUNn0iudgrZLXParpU8hWN3n8bVbvlSq
         HofZDgHCJIKBBaZGQhprxt13iG6iTTDJrYWOtdsFQYzkJamAZrXBklaWNqmMzHOGbUpD
         2T2KJz5gkBfibeHVzVokkFEhJ8pS4WsK6UPNZRE+Y9DsNQlJI8e67jM1BpTQ8B4Tqiwr
         mYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365387; x=1753970187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXG7080vUoTS71soVhA4Gbq56Ym56pqDEVpEhL2XCIg=;
        b=XvKENq7gaQszp7M9rDn3AQO1ZlP5mYHrGsN78q5aIfnziBgWL8hi6al971TScUO8vb
         Kzz3lI2cIoCkCEpGKqLGqZPDfr8UoVuxvH5hZeOP+vI+vD8zPEVxT358DDvj64PJV22u
         M2geUIso8BoaQgTNVuh4pHQl/ItS+qYFCxAj45jbQUYGNB06/XNPsWMnPp79EHk9Jh7J
         +Wp+sisAZnMbwpH9tu4MQ8GOvM3j6az0N2KSGboG8ey9zq9tdnXOyEXJnLprmrp23RDQ
         TfrMmtLlu641NgRbQgvZGdW67GIhtPPQzs1vFkZql3Pch/UAZ0cGqKGRnZEwnakZpb6M
         FQDg==
X-Forwarded-Encrypted: i=1; AJvYcCXuoxgjv12YwWrjeM4pYRNrjOGltxK1qx67sMeLFMKWVpBsFJORzt0JEjjp6zCX6x7shjK7jWBYkUBO@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRpEtCcjY95lPozOm9z8ZlIKWMhwjc6H1ic3t2q6A6qLGsGWZ
	bxk9xi5MbT5qNqgB7mHxbpdDDw7W0/O7mc/Kq46SsA3OlY+apJ6tXha51you4tGKGLeN37H8jja
	FEHfXEWk=
X-Gm-Gg: ASbGnctL1sJZGJyBJDZ/xa0YnF5UpP8aAo+yA1xdBqNX6e7f/fd9njY64v14qEFVnxJ
	jFWhSkMBBNqVuH9tG0nXWkbYSQbbHOjYOG40G850dbCkyAtt5TWrPwq4WvoK/4/G48H4hmVWwqc
	wHihmmYTayGHTRqJlMMxoYrhekAXjsIX704ev52ka7sD/+NBLNrU8FLWrYnKD/Q6U9QKbPIVOub
	fjuwfo83Z/di/f2OTJAPRzJWYSfvXwpztWpAQD1piWEdSOR8iRWu1Wm/1nW05Aizk9e0Q5FvZ8V
	MG3YseLlqIic4OaxVOMBGhaBArvxi6LueCwO42v4FFmPzSINcSYcWxNZFD6Jkj+KjISsBB2CSM1
	VgdQaTbsUykGOqC0+D2XAF9eLuXDJoTXlaIbzvBQYeEIjEZtPyLU5Y5IB9fUaWQEpnT+FwkSMD7
	H62ZYjaFk6/wDI
X-Google-Smtp-Source: AGHT+IGoSF/EqSdGIwDb9gZl52m8tCgkgoHOuTGrpWGU+P8oq0e6jpOpRi4GM0HClIhflbnZpXQODA==
X-Received: by 2002:a05:600c:630f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-4586a7df4e9mr64595105e9.16.1753365387527;
        Thu, 24 Jul 2025 06:56:27 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:27 -0700 (PDT)
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
Subject: [RFC][PATCH v2 06/29] soc: qcom: smem: add minidump device
Date: Thu, 24 Jul 2025 16:54:49 +0300
Message-ID: <20250724135512.518487-7-eugen.hristev@linaro.org>
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

Add a minidump platform device.
Minidump can collect various memory snippets using dedicated firmware.
To know which snippets to collect, each snippet must be registered
by the kernel into a specific shared memory table which is controlled
by the qcom smem driver.
To instantiate the minidump platform driver, register its data using
platform_device_register_data.
Later on, the minidump driver will probe and register itself into
kmemdump as a backend

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index cf425930539e..2aae0e696150 100644
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


