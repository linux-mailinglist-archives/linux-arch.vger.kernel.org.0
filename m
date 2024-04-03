Return-Path: <linux-arch+bounces-3382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F183E897051
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675A31F23469
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C5149C43;
	Wed,  3 Apr 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrlSB0dq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2751494B0;
	Wed,  3 Apr 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150392; cv=none; b=YpP0D+jxfZP27px/7aRdMnzEMtrxesKTAJh9ydarxfUzRfIEiC21SkB7ilB4TsCUEX0gUQeBxQwfZqp/lh0UMYTV/vRyv7VRUj+7wmY7xvL84rRzlDLAOgq9BKrkxp0V+Jw4PN4xE39g0pp+hRyaGB/J8TTC/WIChK9qrnxAWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150392; c=relaxed/simple;
	bh=gwAOp4S2RjVEdHOKrWJyWwN/DfRkuBxfLFLX2qhlwAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+6oQG8n2g8lkNTxz5d/ICc385zgW537wmUnPcKvH9eeclayd+hqGhEefSdHHUt9d+9z8X5SJYSnZQ46ucQg4gKX3B7J4b5Q1OajnyH3PYfJrrLVnP20KuNq5vqbQR7T3YgQiJIioXzrRG0dwN68DkNXMn5hj14Z0cMvP9K3N8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrlSB0dq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1def3340682so55044525ad.1;
        Wed, 03 Apr 2024 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150390; x=1712755190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUpuwFkhA/ZZkaJrm+5DUMvKoRunaI4/ZlB0ejZmZW4=;
        b=NrlSB0dqzPGsGvaBnVtkkGzsPLlrHVxaI+Rq3xe6I19wF9TEovnFLLHjvXC61HbJFB
         sdlK0wK2zRKcS/CN4sjcfuSTXOBsPWqgAnOJs3Snur9RAkwEHizDTbxAw+JprxU7iQzq
         yVF/HeGNjbWQeKgQERK/20fQtN+ReHfG+i2zZxck8xlkHwSzak80A+1cosz38bYEJI1s
         p2Q4vyBRvMS8Sic/oHWB8eI5CzwbGBK17ftLTE3WWJ+PtRY+CUvsoB1dWoV1I4KF/b8v
         UE0E0Fqd2K3uzMFjRoKYryb7EVBG4zgXFJ/oHX2aim65MmskTwlAtS6uiZpzfeLAITyX
         g2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150390; x=1712755190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUpuwFkhA/ZZkaJrm+5DUMvKoRunaI4/ZlB0ejZmZW4=;
        b=btzO3UJhvivPKmI/H9F6bXeUCoLf8SN/1/NoAITJkmyaVlWswoVT257KmJxcU5qYVC
         bMAiGwYhIGq51C6Z9ZxXzoEYqmfiCncv9hxgarvYl3yptFRacMaezCGIxALP5HLVknw6
         LAUGiWF2MP88a76oCj9M9FyCi9SuhfxQXqGThWfnJpA5meiY7zIqE7PX0HJiBErIcKNI
         KI8ScHnSUHlIwFUvbljKqw/c/UPnKFOPBCiTDcL3wHQh8hm/ltjt1WPONHZ/QdyPCzyL
         COqbApfu7imDbMF/mV1uObeEn/7VTCZUsBuL0uba8McN0NLfRD1iMKXbwOOqfSuYHdWU
         kU0g==
X-Forwarded-Encrypted: i=1; AJvYcCU6BT4lqaj0MY5L+7RBsUjmSFl+KGwQlh3BbNwCabmBmR/Ae9aMp7AT2hUcRJ273dlbdvkmUcNGFR9T3TOowYePU69m6Jzx91B6RN+NJCb7O9vIVWyPRU7AJtrPXGdwBzcpcHCf+CtlbH4zThjG2Fm4JPFa9XkgdUABzQk3hAwC95q8SIeDYwprIyQKFuNiqsMFzh4K56zinSt8qIeLYgxUnu4vq346Y0z3DoCmF8DFHY5qKFQqv9x3SqJcD9//xmjXqsiXjWK1ARO/dPGk/2ZpzZtS9lW36zDjan9XokvEyQA7J6qvlvnOW0V37ZBkpg==
X-Gm-Message-State: AOJu0Yw7OgMLn5ewP84wGc57w+UK6yUHpCJRsFoFHCh80FS+7XVvo3Vv
	ZSGH3yTlO/0yUnLApHBgknoEg7xsiQcU/n6ARIGfj5uVqQxGE5Ihytib2DX8
X-Google-Smtp-Source: AGHT+IE/2OacMp/2cfvaRksBgAjGZgKxyI++pmI4VDvZRW0+d8012wJeFPX8kGKifNbdvVT4SH77dg==
X-Received: by 2002:a17:902:f68a:b0:1e2:9205:5254 with SMTP id l10-20020a170902f68a00b001e292055254mr1881147plg.7.1712150389795;
        Wed, 03 Apr 2024 06:19:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001e088a9e2bcsm13158796plt.292.2024.04.03.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:49 -0700 (PDT)
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
Subject: [PATCH v3 04/15] kunit: Add documentation for warning backtrace suppression API
Date: Wed,  3 Apr 2024 06:19:25 -0700
Message-Id: <20240403131936.787234-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
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
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
v3:
- Rebased to v6.9-rc2

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


