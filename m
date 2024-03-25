Return-Path: <linux-arch+bounces-3160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A988ADCC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571B11C3ECCC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8A12C52A;
	Mon, 25 Mar 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJRVe2dg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D29129E8C;
	Mon, 25 Mar 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389186; cv=none; b=INDGjQC4mjq2Ba9+PM0vRd1msCbNUXqPAW8VOvMo3W9Kvk8tf5fb4NZJDb+WoJP3RPlL4Gq6EnDAv4xvZaff0fT4kwZa2/XrWp7BdbbeIrxnkt7s99POyfv2TsM0/6B2HyIexn0wpiKFG77FXAgNZiUjGVZhgYkwnRpyWubRtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389186; c=relaxed/simple;
	bh=uf1EZIzeb5JONuf8FpS2iqxmJGsd3vztWjuaJxfsGis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGufsxNh8OT2H0yOD+33ndQ0c4v0RidhEVMlE6VkMCca4LomtXZzg+M9pJXpIXn65X6p7cRdtGuBjmIps2cupGop4mmf6HgzZvJU9s6UARk0PvXo6mg2IGISGdBdjv9Rxz+LIhFBJeeLC02oOVXWJRyVUN+asWdP90us0ThPFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJRVe2dg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so2399395a91.3;
        Mon, 25 Mar 2024 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389183; x=1711993983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSmEsP2HwUjZ+Kmad7RzlLHqlu7fphsCj8c3+UcbJqs=;
        b=YJRVe2dgQrZ1XJ005FhecXb7dt9JHkwWj0D74mWRekhYluW2iOEXBi71w/NB2C8INs
         brVAcSLA4SbdNtPSz2Xry+4btjafdIKPkWbqAhqX+qxSXGpJA9lFneqqqiadfrE014gt
         kkCOhLVzCr2BYmyR80u7akYi3sLh/AXqGLwbW3QAt19S6BluQWZZ0nef93dN2FoTB1kA
         cP0T4xzKy1w1x+0uR8w7a2E3RE5MXNPHMqaNJEDtkXE3ktAjnaABpIiAT+uviyjwud41
         MAbJniUZRHxXD605hzDfrJYmXGBWFBB4PFu4DgcpKHtY5cG0b4DkSBoeOBdFNoDQAj/f
         IQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389183; x=1711993983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSmEsP2HwUjZ+Kmad7RzlLHqlu7fphsCj8c3+UcbJqs=;
        b=pS6bHXExLKzBbxV76bEm5WQht82fks9W7gT+1uwqdXQ/t+EGKfnfX/waYiBHa4WPn1
         fUEgKo97s3OOawYfPkbVZfN7OjPgGDFSbmnURVJghhSSTQIWzgU60/RBSGFX98OlUmcP
         88MplRdfrLfqBOdXbPrlsHkgODIWkD+oGB9u5mBEGcaPTfniNY/YJfHoZ79oeLOrf0SV
         L499K/5ZrVEcqdETPecc6leGxlLg8e1qFMGk+hBAsUpGoOmW6bWttc7h6+gI3rQFRe5b
         UBwcdrJfUs+F0gKlRir46MOStoUgpzWv9l/5nhKbt1iXidqcfeOr+dVbwZrfPThmiFSL
         SIHw==
X-Forwarded-Encrypted: i=1; AJvYcCVEvWLdgouQCGr58JjrndNswEShCyWmFbIkLtEtWngSNX9d4eL2E8NLJJ590cp3xFj+OcpL28dcMAh80uFacbmVLSJxGcYpVjz4p9kccy4nntC8wPWFtO2zTCutEtFCU/f4IEaXpN8GvTOGqcfEUMlu0slyS9LYMcbCa2eH2v+LL1pOqKQKb11dlke/EpkucXcW7dnDaLeRblekYc22hGNSubpyylJqqg2GOasDVf4zyorKV4qQ3hAKFMEOsp5KWVTqTOZs8XT44HipH8+4Rs0D6z/RXmVV0wSmWZNyANYE+a6v62T0J1NuF27v68RuvQ==
X-Gm-Message-State: AOJu0YzE6+Ez8hD3yh0ZRirgfwNzEacnja6LNyw9hlzeeQb2BeqtKWvt
	hHLa6cPtkalXgPtINDIdmUB+hifhKMB3rcTAWoPTsaNprjSpBi6bHMzvBRIo
X-Google-Smtp-Source: AGHT+IEVej1vJgDHyMhirxlQLl4uccA8YOz8D7GQmS3E1f+SiDCdIFMWODSUkw2joL6x2b4cQW8ruw==
X-Received: by 2002:a17:90a:a88a:b0:2a0:486e:780a with SMTP id h10-20020a17090aa88a00b002a0486e780amr504319pjq.15.1711389183399;
        Mon, 25 Mar 2024 10:53:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r12-20020a17090ad40c00b0029c68206e2bsm6603983pju.0.2024.03.25.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:02 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 05/14] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Mon, 25 Mar 2024 10:52:39 -0700
Message-Id: <20240325175248.1499046-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325175248.1499046-1-linux@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags

 drivers/gpu/drm/tests/drm_rect_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 76332cd2ead8..75614cb4deb5 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,28 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
 
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
-- 
2.39.2


