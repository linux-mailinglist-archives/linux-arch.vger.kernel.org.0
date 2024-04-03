Return-Path: <linux-arch+bounces-3383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDB897057
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B928F922
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD9149DE2;
	Wed,  3 Apr 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmnCkyTD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0BA1494D8;
	Wed,  3 Apr 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150394; cv=none; b=gjpRws1PIMmjRBbB2SmaXd3mGSO1kyAkQQsABkR0BhdWyb/TLBwRcEEIesDZ5NMO5916pXX8VW222nG1r0aaiEX0I/KEonKwn6OjD55+nVarxdrTsmoNQOU49aUeZvw20m+24edEypbdhQnmcM9RCvYQaPJOlj1KbxNv58liUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150394; c=relaxed/simple;
	bh=kq5+RMCvHSKQHxJsCA0Sj8YeDyJpY+oX/LlT/96C6xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKSvL1qAIBwv6Wv8ugflknNTlRIp1G02rtTX0qt0kjyEfx3EmhO+oJ++DwE1qHSnIWJY4MBw7YV5i4To9mXCof3f+VbqcXruViknCgZUg6RQ5NsBRxVRTbCNBL5pVrl9/2vgftEpAfEQQE15WQ1GhKjEmEjYYZjQ49XVFaACBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmnCkyTD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e29328289eso4704835ad.0;
        Wed, 03 Apr 2024 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150391; x=1712755191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HH3He2M5JGBbpn1IyUzwQbFpqNeS8i3zDjnB0NO5L0=;
        b=KmnCkyTDVQ8LTmmPVRaWQmewlpAXMAbluotff3psu5SqqHRsDUqb1WDVVJhpfSwt6D
         qeNPXiD3fjotHJFAO2xIhTDu3Bx3oe+wdBvY6IbvBKIfElt7gOwqeDRlVhylYKIDdexT
         nSGvn6TGNo+YfQWpGrczNNcHUoaMNcGmqwjmVtxlfDpEVN/U/GbUQVRVZ2oLO4GyrZxa
         gNHkqqOOx2wAUuBKryz2EH0NU0pXsiOqNgNzwCDp62Y9lC+vGqC839aRicD3013tLjGL
         ZI0f6v61/JJWK7dxndRRMrHKcsqQ2ardbcbV/KezywD5dF9Nmrpzucf2rxV3ZNl4GM+b
         otHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150391; x=1712755191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HH3He2M5JGBbpn1IyUzwQbFpqNeS8i3zDjnB0NO5L0=;
        b=QnGx9lj/SIqw7CmbpP1dVYK9Ebggu0GiaZNHXTPsXcRieo3oAnu9WPP7rCQBNt+Zy/
         fWDgkEW+SJZs/u2kN5AK4Yl89SKuKF9pdDCrVHIGH1DXCCzLVcNbkyMDtKRZCq3VmkOt
         SmSELE3MOx3LeQ0KRDyMys4Ozg/z924TAFUyUdbbkz0k2H3PrDb5xsvEIJbSKDS9ZuS3
         QaKnbEEkHvYUGWxcoBciMiOvdATMhxMXIksdNqwp37/eMCzwHEA0yphkwnmYsfZc40N+
         6epW8dwxlgSymkzVE5uEujjKSMrGXkQP9VqgxBBFOTRaeH4QLGDyjBOa743AofmH7hsq
         24/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4su6MLSBZl/joLOGT38EAsbC2D20Q2SCQF0A+b/tHZ9HOa6GuoJGTAZBaEqtE4X9ORB63Zo2BYhD+kl7e0vDR2CD5J0oXNna8ixWP9Vcl1jueZWrZhTqSIUm7YYsRF2bd5Qzf778CwXbd8pJ5OmK5wmqbTynRq84c7cxKB5Cn2bOfGsEFERW9oom1olZXTPQh1RhMqKY7GTBy6jwoaf/f5vbAX9rMkmOTT9s0SmR5PCKj3eVtI0B07KhrDP5QjrkMEvmuV9MobGmG0sl/ri94HiryfoexwHf2tWXixPOZzCiy/sHiCuJEikJEH5gr5A==
X-Gm-Message-State: AOJu0YzYBFwfxuYK8gIJD2Ug3iQAUSCHSU5PDtYLhtXz5ojGn6dOZ9BX
	lXHb/jKVaXX93AdLPFLNNKD3vaLulPbYuGicqnpx/Up220tv3XwuY6myKsNu
X-Google-Smtp-Source: AGHT+IGzp4oN8GRSo/9EyN0xy1NOVYsP3l70Car4fBvR2s7g6gbB9/O+yleAACI5/eSTY78txokLLg==
X-Received: by 2002:a17:903:d1:b0:1e2:a177:d6b with SMTP id x17-20020a17090300d100b001e2a1770d6bmr229571plc.19.1712150391428;
        Wed, 03 Apr 2024 06:19:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902b94100b001dd0c5d5227sm13149194pls.193.2024.04.03.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:50 -0700 (PDT)
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
	x86@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v3 05/15] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Wed,  3 Apr 2024 06:19:26 -0700
Message-Id: <20240403131936.787234-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
v3:
- Rebased to v6.9-rc2

 drivers/gpu/drm/tests/drm_rect_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 76332cd2ead8..66851769ee32 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,38 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
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
 
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
-- 
2.39.2


