Return-Path: <linux-arch+bounces-2945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B558799D6
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5523F1C2202E
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87E13A884;
	Tue, 12 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWfI6JO4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98113A25E;
	Tue, 12 Mar 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263007; cv=none; b=IOpn2OxFz106P3mS/NrDtFHWwscrbMtMzSfDf8RDL7BfVjriILsS0gRD9MxBVb8OFF+a18YiPXaOh+R5+KtedO0nOepcnFvjp+HL8Kk9WdXryIBRXi5YU6Dxb1AMzV8BHQD0KK+2VzpsWF9QATAJU8KKiC6jAENWULIyUJhDI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263007; c=relaxed/simple;
	bh=N5o0HnSZW5WhDNiR5nZH4ujEcqRXW+pWgts1zMrovCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPpwH+xd7wYIeGydE5iC3pswQblm9f6+qgfmRih1JwmMRsG5eA1EazSOGM61kewMhLpMxjvJ1ZRaCx4+slFXCVoys0PrZs5OJDHCoZGx1nxErqA15bRxTaKzDG33EizsP51nKD/3hEaVPoaqKeFLdZphJukghXYLvglPp7pePRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWfI6JO4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6adc557f3so577066b3a.1;
        Tue, 12 Mar 2024 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263005; x=1710867805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGQg+0HBD/PmNnv+fI5fQqG3IGlyLsIaZmNJE7ZYwjo=;
        b=nWfI6JO4W7MiLv4L0R5Tw0WRue65H5zlpc5F9gitpB39cQ9emdVl1WqGaCwBK/wTiM
         Gk4WXOsaqalAB+dghTbQacA7mYyQPCsIQWWJ7Wb7INrSYkmBJu/2KeLoJ7oUV/II+qz0
         Z/KDSoNap7r2txpGMJTfkx2kRilrhc5HQaX+ApCSznBpU9djakgh83sPJI0BZKaevTd0
         vgJ1i9WSiDop0fy5y/2Q0EarWK2sa5OfPr8AAEo9WbtQNjifYAC2Kys2M3mGGtvZfQpl
         AvX12tA2/gE7w55IQP5A5IxuNZjahXjbN2h1OAP87/HwenKh/yUzQ0wn0mPYiWtBbl0J
         kcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263005; x=1710867805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGQg+0HBD/PmNnv+fI5fQqG3IGlyLsIaZmNJE7ZYwjo=;
        b=E0vKxbWfGLyteHR5SAJub61pEkriZTF/qzuuuEMc6KbQ6AgjGS3aZkmfKUGkJhszMi
         9our+ADotnLuK1ppa+IvC5x1/nhSXlVV+qzUdhg0eUnmXwKzOhcpOeyGgw+wy64tHt9B
         rZ82qbPNcMHMRiE6/KzxMipq06UAY8UiSaCSxH58EL/Y/MO2RKpVwYoP+5ZstzYovGD2
         9pUQvPvRLFMp0BAMF2lpAUqoEACpwzEHrh2oFl+YrcDzMXle3FqiXqPOoFtkbjx/1oOC
         HX+5p8c8zZm6z5PEkZrut8n4tNq8UwpPHERi9JpJz7vG+iHCutfiDoJiLoVBGjcbl0XM
         Ez8w==
X-Forwarded-Encrypted: i=1; AJvYcCWNHG3z7pdxcC5WBIX4lT6J+RcJp11+gpz3QmN2YEl9EBcbMqJ4d49NIUGo2vyGS6aCYe/T1HQeCl3qBe9EYNxhHScGeDjhVl/3FhC8OuY99cAN2zs4HZzZYHeD7QRpnqS+0t/UXfuoJXwCFiHodc6COm/O1kW3vh/uOeJTHk/NIIJqF2qNkApBKwUZx0Ci6QvrQPjuprp/XLIPYhKYdugGee1lnaVCMGIyBTMz6m/tgY3tETTZSst6NVgkebs5g5iiGiTgWGNa3eRYGd8WrIouM389ENlJFw==
X-Gm-Message-State: AOJu0YzTnD9i9Aw8roFv2oFOW1F+mOXc24FA/p3WQyBqdj64vSy9+6U6
	Tiv0wPriBu2I8TvRFvUCnp0A2BSpIUaxg9rBomc6ezgNaL17g7Gj7Ds0Uehx
X-Google-Smtp-Source: AGHT+IGxFzq6cbK7MrvIXcZlkGCehcjfwe014BGxyN94I+kP8/p7v7PJMJz1gy7c7O8kch/y3R6C8g==
X-Received: by 2002:a05:6a20:1a8f:b0:1a1:4ea8:1844 with SMTP id ci15-20020a056a201a8f00b001a14ea81844mr8418900pzb.26.1710263004751;
        Tue, 12 Mar 2024 10:03:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b006e657c72cf8sm6830699pfd.148.2024.03.12.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:23 -0700 (PDT)
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
	netdev@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/14] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Tue, 12 Mar 2024 10:03:00 -0700
Message-Id: <20240312170309.2546362-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
References: <20240312170309.2546362-1-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


