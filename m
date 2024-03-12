Return-Path: <linux-arch+bounces-2944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9E8799CE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B5C1F223D0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761913A253;
	Tue, 12 Mar 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Afs6sh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85546139590;
	Tue, 12 Mar 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263006; cv=none; b=a7N1I60+JrUbUO384zaVgqU61hmvu6PNGXouYlik8Kr/Siwwq+a6yv18iSgM5zoqrO0PYDXS5ZuhpxSTRBn+yxZzc+jJNXvrIrJBzFsYCRQ7aKG9zD5gDLOfsXV2KD5U/qNaG/+8gFo4oBadhmKqXWKN3/n5lYlfuVWB0W6u3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263006; c=relaxed/simple;
	bh=yHteoDhfKPGcsj1rp+n2EnxWC6nzc7OGPJZKXcy8Y4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKCn6zSL9pzMgmps0n0riMaRGz5KdWPZrJfVrGJ7X+FLKn2XcR8B+uT8ZQCeC6Q0yYcf3fjZTJgMdsPYkU+n+gsNXAUC+Lstw1U3F1RvdKoo5ZrKz6K1UCDO0RuUX06+Eegk/dYZn56o6DmLObLqVMd7+QKkOQnwcmWbbLMX69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Afs6sh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso4201516b3a.1;
        Tue, 12 Mar 2024 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263002; x=1710867802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36BrykVX1YEJvDrrNJGSTLQfgxZ1lgqGPC6PgqTTbEw=;
        b=A1Afs6shx26k3sneKBVaM+JdA60O55y8zlBV/iZFoaRWakMn3D5Iw5ArItT/7Koub+
         owEC9j5sx9x0iLCI7c+MUahVD6X8uxAPbDcdUWektCVsh8HyxSfjh2oZXfKkOJ/vcG2d
         cdVBo0Huw/+49pI8ejflIkrGvmj8yOi9YCC151eMyZJ3wc4hc3MPuXaarGiiP0Yb+uUX
         Cjm83uOXN38cBfw2wmL6R4/yCEASwgyE2bgJzIWbedOxTHr1y09yDxC+7cIUEspRbf/V
         AYSrx7+g11BqBTgWungDl3BY4ya4rIbu8Ao70BA8P8oR80GAzqq8NMI/RRtfs/PTcTnX
         +TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263002; x=1710867802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36BrykVX1YEJvDrrNJGSTLQfgxZ1lgqGPC6PgqTTbEw=;
        b=wf7fNR0htm9T6o3YJMI1sZasrNlL8mBiNZ3Oo79sHYa2KPaWaLc3Iivtm6lET3H+0j
         YNsj7SzWmhku9+TzvR5z0plC3W7SrDhd3ujSefHWdarxJOaaMsorma8+v0Rk2Y92YDfB
         dibWJW67+MhgcC66+vvtcu6d+R/dQbK8ukyElLkdGlTXEwrkr+3vLVdEQEaQPk4NWpoi
         CqbZWSCVxFa6erJ8EUX0a9C4bxtqZfPNLUS+IrXJ51zQYkeWRiiruZXmnu7iuk6x3DtQ
         Qh7wp7mu8clIyzGPIxtjQoLldiLLJP00kbj4tddZIqrBfT6JHZ4kuTj/hm/6PQpn+0+g
         m2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW85UqGqzBsKn3x4WEmXRjkK4/cC5bqwKKsEfUoYgBb54HzcZ2e6s6jDTafNRGKzqQ6WyjcWZwJSYcpCSQE820fbF2xLucDfMKWYU1q9VKBarzE/iJkv2XbGpFPS+OZhV0EmrjBP3NTWwQwjaq1XQccwsz1TxxTJ0aj9oZCN9iFkbHNchE0Ip6EbFnUfxRNsJeEKnJMpGi3YqKxOH0AIH8X3Vk5vBiLsgZH1xNrXB2Hfhx9Cy7IlT0z9QHhOe49qaaIKfMBfdhaUp43X8VBtpHR995SFId5mQ==
X-Gm-Message-State: AOJu0YwQEFIXoj0u8NnnycALMM8JEmObK8YKYs5y+BnXO9ddIcPAxqlN
	Fd1BwsFb3wryBTMIkyqxXk/rwbpRwJ5BSpXKCWO90yhtPE3wKTZrJn4Kz4ya
X-Google-Smtp-Source: AGHT+IHYAZUPDqsFw7GWyh1RSbVI2Qwrh9Mdl1wKcQdsH3Ao31Ql441CQm7bvVJxkQ6v+AiS/8LElw==
X-Received: by 2002:a17:902:b198:b0:1dc:d8de:5664 with SMTP id s24-20020a170902b19800b001dcd8de5664mr9227736plr.33.1710263002517;
        Tue, 12 Mar 2024 10:03:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001dbb6fef41fsm7095813plb.257.2024.03.12.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:21 -0700 (PDT)
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
Subject: [PATCH 04/14] kunit: Add documentation for warning backtrace suppression API
Date: Tue, 12 Mar 2024 10:02:59 -0700
Message-Id: <20240312170309.2546362-5-linux@roeck-us.net>
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

Document API functions for suppressing warning backtraces.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


