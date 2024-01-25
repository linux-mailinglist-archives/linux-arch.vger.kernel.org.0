Return-Path: <linux-arch+bounces-1587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68683C54F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F32296262
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F5745CD;
	Thu, 25 Jan 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyDkaGgB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87C7317B
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194217; cv=none; b=bvH19iGxzpi3nc0VaSnEWAUxPsUjqRHmRIXVE1d1NsVI8aZhzwbnV1U/J5cgAAQlxM0USPfk/N5P04cUd2iNzqKOvs7mMNq06dKLsw5McpCVrZAGr1VXVBrveCZtcoLGFwk9HgcoptNUx8ko8HIh/gG5Ju4+2cH0KdPoH3oGzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194217; c=relaxed/simple;
	bh=yzELhYFXes/7NkJUo8dvnktgc+S2FFN8e6Aigg5/vkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEm32P3Pd+SVRet02nB/rNF5jTvCi3SslMwu4BnchT0AQNCO6kqKZ8Ii3F4YAUdRFsQcu6QGXUQp7PXAN7Fk+yMZEzZkeo8VqA1qICzBfDP467wWOnDhXRJIcueYDMr64nPqT+QAhe+9nUA6DfULhgXQ1h1UuChNRZK0g4P3rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyDkaGgB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ed252edd7so6240805e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194213; x=1706799013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRFUn44quLj+PIfBqhHItZqwl4f97FWUBTKk7RiZwVk=;
        b=LyDkaGgBxvgdVB6IN/rgrCv2B1bkxPVy/djXL/JiqIjjMQGIEXgPHUGqqOIM+Sgea6
         p1fYsWxDtd1uzqPpeCQwfDTOgDUVEolepJ3OIkDZhRivew16Ioh+ksZSDdsiezK5YVjy
         JKxGsjeaAdnRVJGUIUF1Kxba5e1JoD1WvX7+olk/tGfcbJpS6EF/n8Bcw4GUxHMicTwe
         6M3Lrx8xdVy1+rAWlqVAZZNcfm+KtgmJoPh00tC/cAUTxmlezo5QDxNeHQ9FPR3mcxEX
         cpVm/n1AyAeFCw8guXMifltneze6u7BmVdHvn3ilakh0OfQcl2FwLyQ/I6jVMgB+LvtF
         HEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194213; x=1706799013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRFUn44quLj+PIfBqhHItZqwl4f97FWUBTKk7RiZwVk=;
        b=Eot0z5i7fKFoIJvMy8KI6DTchKJQJvO49dNnNo/Y9zL1HoP8d/z0sT8Fa9fy7Ye5+L
         vOPFQ/2eC7Za8UCC83zYctxeWvhSgHHvMwP6WvSZVvJp0yCgcq7Mk/Ksm37/jViysTbB
         nN3r2h3fEeMfr3mq8Q8DFG6MesR84g+JNXh+/ZnyhMT2/lRg5GNzTJyUmkriyRyRv1na
         B5rZGAvo21LbC6cOPnhxhFBLECsgPzsjllG6k4E8nr98DlQ6dHR15yndncRnPmm7qpke
         rdDX2kg/6/trsKS5bZod2RDOGnvCbRHIEpXglhSR63yz00uRTUHeLFlTLpfM5k3VHDwh
         zb3A==
X-Gm-Message-State: AOJu0YxAghhwH3LC8f5Ta+etithP7GLahE2qdgzhPIl4BcU0gx3CTWSS
	4FhgAMsl+rNTc8nYO+1+XHIfpxMIkc//1DBKSa2W1VV1iBkFKvne4/oS7ha+SGQ=
X-Google-Smtp-Source: AGHT+IFOgajdcjx12foem5jJQ5uVJoa8Xt7GnwMZgRpKmkxOeOk40qisvSZ27ix7km3lnNNA6G3wyw==
X-Received: by 2002:a05:600c:cc7:b0:40e:d2bf:5b03 with SMTP id fk7-20020a05600c0cc700b0040ed2bf5b03mr271370wmb.82.1706194213512;
        Thu, 25 Jan 2024 06:50:13 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 03/28] spi: s3c64xx: avoid possible negative array index
Date: Thu, 25 Jan 2024 14:49:41 +0000
Message-ID: <20240125145007.748295-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform id is used as an index into the fifo_lvl_mask array.
Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
thus we risked a negative array index. Catch such cases and fail to
probe.

Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2b5bb7604526..c3176a510643 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,6 +1189,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
 		sdd->port_id = pdev->id;
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


