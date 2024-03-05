Return-Path: <linux-arch+bounces-2813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4358726CA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1E1F25AC6
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A193250FE;
	Tue,  5 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgOPkidu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA31A5BA;
	Tue,  5 Mar 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664048; cv=none; b=Zm8EnDxqYPqmzOueOKOms2wSHqThGtc31ZfughfaEhFBn0o0n9s4b8EjsA/xX9tRTC5JK7t3zhesbfljUBDvyAl1FUTiFYzrUU6AcaCBbvuuFIG+2g82e4/9geNFotm7LBw4Mqz7JyBGLzgShIdm0DNEQqPdeU3sJoLscR0l+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664048; c=relaxed/simple;
	bh=N5o0HnSZW5WhDNiR5nZH4ujEcqRXW+pWgts1zMrovCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTMRNUzh3qV9+RYenCcbVVYWmWRIT0OxTvLxUUwkyEqcKT+FD0NMlZ+NlNgpTqpao3p+6iEzGE9KSut0SOvHAWUe9rjfFTn5LcDOzVtfmdFq3e+hgRBOPbjosookRr+i+hzUr9LfA0uZrJT8SbeGVNgNOds3BrBRVI4MU+HaqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgOPkidu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e627596554so1853095b3a.2;
        Tue, 05 Mar 2024 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664045; x=1710268845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGQg+0HBD/PmNnv+fI5fQqG3IGlyLsIaZmNJE7ZYwjo=;
        b=IgOPkidufVz2ZdS+oTnN5XshrGI6nSYpUorR/8k2/tjFih0Hs1MPhb6w4oPIo9Pfhh
         V8ri5xzqHj2hjxJ2SI3S/JaTdAOEHXB1RWkHdU+GNNJO1NyWwjs02OpY7hJvnk22JuSb
         5I6iO0EC2a6tf49QkSDdV3S8BK7pQU6vNvVAjE97eZrBF7JVMcme21PRDs3GceMIpQgu
         +0gvdCmSoql4VFcSTr3VFqj01xgdz+5XCZgi3bLy/TiH3euP5Kx+ihQEnnYnVMevOKvj
         2H+SJ6dpCsyDYI2La2dfdVlK03x+IetTIFZVl7yB7XX+ZYj+1WB1QrKcZwVjXrl/gFHA
         8OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664045; x=1710268845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGQg+0HBD/PmNnv+fI5fQqG3IGlyLsIaZmNJE7ZYwjo=;
        b=ZyRXSant3QXj/fycD4uy0FdKDaZp6KI62cCylfB8DB2DcNOYC+zOJv7YktemhGpCNf
         cQQJgtSolp2hNPjTpBMr5fzN2Q9KDJvSCRrz2bR5aFb9TMac1EECd5TWGkZdv9m1cZcN
         e3m77u4864ep9sj+u3/r+SYUEG4aXhkXqMRgRG4bp+Rmq8uOAI5uBtfP5u7wNS4kUNcI
         nwKDtxl0+T0Nvp+woXzEDHFDFV6itJA0I9f4pRDdHIA9kEvs8gy3W5wze0F1kqr8TC02
         ElsX9jRvb2hSDHkdKsmDElzLjgtvzGj+8xYDDoQQXKcoHmmCw/Cvxegs1x0N/Jh9IiMQ
         NbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn2OX1eIpXcJptkbYb7DkxaZQG+4VHHX+RCKXIKzkoO8E++Xw1BLN8HNWI6GNCoY7HfRJPK/NITBWfvYTFyEL/bx04qTnGga6T4BAvc1nG0fgpwed/c1plw8EdfQDG3GBhOSWDrVcaaw==
X-Gm-Message-State: AOJu0Yyvdsxbak9aUSvUHBJJiBmsWPrdQXrxpIhX62NxMXzHxY0lkhGf
	d5WJ2IIflbQY2XxSljEgsc3cyTba9UHpzg9DGqejREZ2///LQIkL+fbXKdi2
X-Google-Smtp-Source: AGHT+IEEib95LASlxflZmOGoKOqjWt2O08nr6/dUyPF5bkMtYTcUru+1PyW5JqlUhb0RbpsxEBo7Nw==
X-Received: by 2002:a05:6a21:8cc5:b0:1a1:47cb:9709 with SMTP id ta5-20020a056a218cc500b001a147cb9709mr3127651pzb.44.1709664045282;
        Tue, 05 Mar 2024 10:40:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b006e50c083b90sm9219955pfr.212.2024.03.05.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:40:43 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/5] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Tue,  5 Mar 2024 10:40:30 -0800
Message-Id: <20240305184033.425294-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305184033.425294-1-linux@roeck-us.net>
References: <20240305184033.425294-1-linux@roeck-us.net>
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


