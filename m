Return-Path: <linux-arch+bounces-1449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B038F8392D6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3270CB24317
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 15:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C860253;
	Tue, 23 Jan 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1RlvM5o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B55FEF1
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024070; cv=none; b=A2rW1gPSQcKeIf841qC8JaoJrNVVINOQFYbEpYQwUlit8gfFKQkZSOvVu3GfdtQxcUx7vmd+yDrXpxbABLuB0fe0O8XFPW1wlyfvS1r2UdY8VahN9sCW5Db0JwCfEAAJNjMve2Q7tHn0w/Fw2iJVTNGNSIP4xODGJ+m8FyGFSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024070; c=relaxed/simple;
	bh=uoqIziOYe4QOe66kMTI7DN3VeKJax6+qP/nGQ6cKH+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+xcGE2wLMwY/FO3yeI6PHq3N6gQCXuNeCBBq2BW2/rJRzvh6tc2mOnBUYmxnPuNJurWma3FlJgYpZN8YzJYmy/CwWXAmx05FyV0qM2x/uGf1XwWJI6SUXTOcYDs1DVun/tUXsW1UqS3j/N3FDzdQBjRNBvoUTFhi7HTyPjG0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1RlvM5o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so48813815e9.3
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024066; x=1706628866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjipWcrbNy/QID8T6cAOMZwyasQD1NXUWSbF3OJYF5I=;
        b=L1RlvM5oE0Oj1RrDBTSBpU+1U3MdF8SqeYR1ZU9HUn77CTtbXhHOj3Af41WBYv5nWT
         aMKEDw2ZDUCFSmGY1IPx4IqF3S67VYbQkEbGA2Kt4m4bGZVLvj2UYGfWlANbNe1fitwO
         pPiE/TvXjug1hdgITiQ/DD6LhV2WF4E7I++nkoyyreqrlA4iFUhhEtRNURDzOPii1oB0
         Sxsq91N71uF8qkhcUsKzKkF3f3FXny+RTuFD7Jvr37ZtLba1PmTv80AthUxnbfAkOJKI
         BTP4ZjwqVu2bGM9kNYj7GnhP9XP4b3oX36SZ4oqtlG9vCOsO4g/3z6s1Pk3nNKtj9DNW
         QCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024066; x=1706628866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjipWcrbNy/QID8T6cAOMZwyasQD1NXUWSbF3OJYF5I=;
        b=D8iQ342kd/kDJPAHrTjpc8vca0Ri14m5gDLklRhIRDisxt9l5U+Wm+qYqbaCvorUXC
         VYJViFNjKteuLybZFGdW9TIxhSd2gLAN3EUrGw5qLR7ziwT9DUBssFrxB5ZfwAic2kYk
         jiqTBsGX0zgeHFVU3ArUerIbTcgrhV3T2JdIhg2XmZemiNC3Ks0SBEoMyli0UVe6A+hf
         AXhVWGyKGErsqSuplOfG6nyrI14WBZPWP2MtnPBL5iEP+lYiTLh7Es30C73AJE2E7aY6
         snhOI0jHio7EIrKCGJW4dEr/0cKYE5v2WU5Ue5l3wVzBlCjo/0WPK/FZ8H+5EwLjqjFv
         yobQ==
X-Gm-Message-State: AOJu0YwyPdgznL1aRtQCkIWkflmuKPuOr+3QdBsFiYtr2GgOw7P8u7Jm
	OCLCFH6Z6FqKt4UjCijVGA3VKf1IpD1HXPakL+5MXxHNmO/SY+x0KTYXiMSRkr0=
X-Google-Smtp-Source: AGHT+IHosPR7aXkGESXR19H32liyG2yCDhVCsytyJRVKkzbH8iGrmrZbLr9K8ewIBbwBtT6UmR9VcQ==
X-Received: by 2002:a05:600c:9a2:b0:40e:4694:38a6 with SMTP id w34-20020a05600c09a200b0040e469438a6mr248582wmp.157.1706024066574;
        Tue, 23 Jan 2024 07:34:26 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:26 -0800 (PST)
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
Subject: [PATCH 01/21] spi: dt-bindings: samsung: add google,gs101-spi compatible
Date: Tue, 23 Jan 2024 15:34:00 +0000
Message-ID: <20240123153421.715951-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "google,gs101-spi" dedicated compatible for representing SPI of
Google GS101 SoC.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 79da99ca0e53..386ea8b23993 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-spi
           - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
-- 
2.43.0.429.g432eaa2c6b-goog


