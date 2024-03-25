Return-Path: <linux-arch+bounces-3159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771488ADC0
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DECD30434A
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2287129E69;
	Mon, 25 Mar 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpAqiNCO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6284A26;
	Mon, 25 Mar 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389184; cv=none; b=OZMI060ZCpiJLnSdLy0/6KVo4Tpm+tyOqpfjPLaX1D/kdFMytHb1VHR4gqm0VIrvDNejp1DG+sDOnti89vWLFvW+rJF/Oyysa/A4HFaEZvkYhDdHIHR1n/KHwZu7mVEJKyq8YBuGHj7owoNuJxxJ+pBzg2226dEqS/kV+k+42+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389184; c=relaxed/simple;
	bh=T+Ia0Pc3N4kwmjFvQN0LMacAar1RnknNeZiqXVkndLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASUnGzX8DsoHN13gWaAMlG45AMkmWq+ZkxAzavD2Ar38pK8YmVGTReqAyzHsCeOQdQnJXulQEAZu39k8QsaOvEdRT8WEs+hwC/gotUDV31+yB2A/YHqpXzza8hh+/WYG8Y/rM+mmVNG6yTLX8PtcLu+iDxefLCAcp2sn10n2BEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpAqiNCO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so3783539b3a.0;
        Mon, 25 Mar 2024 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389182; x=1711993982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5DnhCN93QNiYO14tG2AocbiB+DMWlDa/rXDsAPUdjs=;
        b=XpAqiNCOSqXNKJRDv9anGHboV4m9fGmsgYncRC7wUk3YxU/tJgEHvLvhCKI2iZbPwQ
         Ikpzba6m7eewXZDW9eDp0YSzPrV94I9ZTb0qbyeZeApgs3dIif8m7TKEwaKpsBgkNtgx
         h7MK38ZQWo5CRD5NLE0y7NwNuDy4+N+AXdJbJLFJxfS7vyIM45FBaPQv5zPVkj7+noqg
         IkHwCLoLNFwRoqAAf+ZyoqPudOk5qFXOImspdZuJ8/zu7vOdlK2bfr9faXUs8g6/qjXK
         3O4UAn/MpiwBAb3ShnE6iHaFHikbjnJ27a5D1ZM+ez5emjxgX7ERNAcBlJ1TunPxK60i
         LAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389182; x=1711993982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5DnhCN93QNiYO14tG2AocbiB+DMWlDa/rXDsAPUdjs=;
        b=kLH36Ac/a1BC7ScKpSlG3MC4LLwgttROMM7VdP6G40sH4UZkS7NjhqSuF+oq9KxsAH
         eEn333k/eXfC6Hd4JiyTClR2vUSSHdKF3GHcAD+uEIbIjgaOKIlaAvHlKXO8enVjfwcZ
         HHwkM9N4+SuLdfbuIuqyw/mTohMR9lgJ+BbtvTA3atqGLWVnFw7wd2gVTCG9u9b5dT9u
         5MTIRrAP51+TBXgHV19UpbYU2Cf4KxJVUJ1mZqjzih/yXKeHdvXDbG41v5zluqzLnqWv
         b+pbF/O30LMEEcgqHCpbDhXgAOTnJQ0IVHaQ6K+V8rWuEQWAVPrsUZku1el8IrqGR8Kb
         pqtg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+7l9Alic04NIjEkNoLFLESPUpe8pIGKserBDG/w9dPqGN7uUS4m9DA6qOFrk18KaX2186r/B2XBEPf/d5aKiXm+CyypS77G7FkkpZEJOUoINJN/HFVlo6oSk84jYfD0LdnvEK2neZ34loUPIIJ0wS9jZW6wc2JUNCWueFS/eP9o+zcaGjjGCbEl1PfB2N/kDzW0gfdvHCyON0qqD9pydCSpR0hAldIS1UtQEpcWkWYlZfY43zPx7aaJY2jYpz84z8Ey021OOoDwHDH735awsyVncoPiCl+5o2/cDdK+otiJ/YfOLejQi/jfIn8povQ==
X-Gm-Message-State: AOJu0YyJFbIDHRNkb2dnjV1MJOpq5oZ0M4OkBDyYoM5uPeRH1y2yH7rI
	ob9c8DVDvT2MDw5HmpF64CF5WC25o/YALy8VE7chR9Uy2jyE1greM6LfMqST
X-Google-Smtp-Source: AGHT+IHUbFCxxsrPDRZqrZE3rVYi2h6yvmCQyCE4SU/FpvCJKM9Sju0fTz4yCOmRcDciiduCin1d7Q==
X-Received: by 2002:a05:6a00:9298:b0:6e8:b78a:29fb with SMTP id jw24-20020a056a00929800b006e8b78a29fbmr9626545pfb.2.1711389181672;
        Mon, 25 Mar 2024 10:53:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z24-20020a630a58000000b005e83b64021fsm5516536pgk.25.2024.03.25.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:01 -0700 (PDT)
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
Subject: [PATCH v2 04/14] kunit: Add documentation for warning backtrace suppression API
Date: Mon, 25 Mar 2024 10:52:38 -0700
Message-Id: <20240325175248.1499046-5-linux@roeck-us.net>
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

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags

 Documentation/dev-tools/kunit/usage.rst | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22955d56b379..8d3d36d4103d 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
 	if (some_setup_function())
 		KUNIT_FAIL(test, "Failed to setup thing for testing");
 
+Suppressing warning backtraces
+------------------------------
+
+Some unit tests trigger warning backtraces either intentionally or as side
+effect. Such backtraces are normally undesirable since they distract from
+the actual test and may result in the impression that there is a problem.
+
+Such backtraces can be suppressed. To suppress a backtrace in some_function(),
+use the following code.
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		DEFINE_SUPPRESSED_WARNING(some_function);
+
+		START_SUPPRESSED_WARNING(some_function);
+		trigger_backtrace();
+		END_SUPPRESSED_WARNING(some_function);
+	}
+
+SUPPRESSED_WARNING_COUNT() returns the number of suppressed backtraces. If the
+suppressed backtrace was triggered on purpose, this can be used to check if
+the backtrace was actually triggered.
+
+.. code-block:: c
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(some_function), 1);
 
 Test Suites
 ~~~~~~~~~~~
@@ -857,4 +885,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}
-- 
2.39.2


