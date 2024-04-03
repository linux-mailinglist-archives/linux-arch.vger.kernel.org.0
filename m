Return-Path: <linux-arch+bounces-3380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA72897040
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34E228BFA6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626AF14884A;
	Wed,  3 Apr 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InvFh4N7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90112147C6C;
	Wed,  3 Apr 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150388; cv=none; b=RD1rfPgrcOwRWgNgD/FRhHaYDeMnSnlwOTTrK4eWIXaE09XXwUbSMFb4dX7mRhafWR0ZqpSLIwgLZRRoAW69iXQ1v3+KiYlkfWCWM7E4QFcT3hqsonYYfYGN+RZ+xvIH/tvkwvUfI9J/ynYzjnmO025is5xF1isi99aTpg87hj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150388; c=relaxed/simple;
	bh=qIpKll238/HMKyMj8OXA3kK3I9zyQbT0+DzHrIXJApg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3UE/+DL5x6yERGzYXJ9gvUWbXTdj/1BmKA98BsvPyyBey4u8I1huCUpefzBpdQs0ZYpQeT5mr0TILO9iw/ID9ecrpiT7XzODzhDg+21FgTEW6W7WTYJMKHPt2o2ippYfhq4m3nRbqUPJ2aKl587LTgGhi6GXV4G75hryzszg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InvFh4N7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e296c7aa7cso4303095ad.1;
        Wed, 03 Apr 2024 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150385; x=1712755185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPi3jXYhV/VW7gVgCzBi2KBL1/Xcj6OVJJpN8P4Laxs=;
        b=InvFh4N7Hb1IP9fVLAn2M2FO6/oG4l7vTjWn1rnmBl71Ep6ntedclhWog6OgqsYZA6
         CROmiegIbIREQAxXQb3xhh4/hkvq3OrptAbkn8SFxnjxQmp2gDRaj7dWjCxfJQUCUvPU
         RlOocwLjXHCqBpQLaW0/BJLuvTOLO5pE0teSzwK4OpqS6b8R8I448GvGvncyJnkFUQ+Y
         gHePaXzdp/WFJGV6WVZZhKqnAeqqaIQTgYctdSYvqsi+rnJxG7louyzJcxJZXnRfPIrn
         AHzwHkX1tiGo7BUDjbhepv+jiCOU8o7ALusoVBRKfRy7FpbUV8BKYmUXl9afA6+ol48m
         6D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150385; x=1712755185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPi3jXYhV/VW7gVgCzBi2KBL1/Xcj6OVJJpN8P4Laxs=;
        b=ZydZy6urPjyueBDjpIhV7V6bkvAPSh8jeA7Ubp3TbVdCWC1lD4P+Am+ejvyQiY49O5
         0OYny4O//KjUM3pZK1kDbKXI+wBwnaZJc+zbspSIHFgA0ADnVUbay5VIA6A6iFzvjDdb
         aN1bRxZvvjtybYDDcinAv7rNG/QAynEJP8aruCpX810HM9S8erbo8k0l9xcPKeAq+rUV
         xl6w5fhS7Z3CFSGHCWZbplIu/k5XgM+xjkH3QbUpp3PbNF+rVtS3gwPxNFtZYeH2Emr7
         DUIWnO/A3MOayp1htQa0EcZBJes2DQLRg8hERTKYMeHcAym9/CgQ5ieXe4tVVuiGONY1
         G7ow==
X-Forwarded-Encrypted: i=1; AJvYcCWlwjS9mvJ5yhRr4ph9ZOyIj4mcmrqOtsGzCQQ55pj8jGAOzgYU6y77a1tikxyA3uaNQn3ezYyE1HQM1qxFmaTN9nwj6BffUNAiUXI7mQu0lmwE6IbFb1wrWZy6rm80Ed9sc337c9ll4xhNadID4oZXNraeGHakjlNVdvh4sI26QOdHpJMtAH/v+EpsYZqcq3ae9CPCzulY0SAYJYftV9btuWLRD3Jiw9pag7s0rlguoSTX24xRZinCxRpr7HWdBAymJ4MiyveJ2NmzyNQf+vaLNxZQEwvHVtFMwyeJu9Bwx9VqMobSOlw5Ckjdzf6h/Q==
X-Gm-Message-State: AOJu0Yw0sIzM5kbnjN9CB63lqA8l/UsoSnYrHTKkC2H0zgx+GiICF59+
	uocPzyUSnV+BWMLfdRCFl/74u9XT2FlkHY1USi4Kz0LRNtLO/060R7lDEieE
X-Google-Smtp-Source: AGHT+IEBdntNuCJK1g1Qd+nUbBCHvT+g3ANfVkijVSktnMtYlUtgHLeuVpmPgg+o1C+TJMJB0A4+8w==
X-Received: by 2002:a17:902:9004:b0:1e2:5e2f:682 with SMTP id a4-20020a170902900400b001e25e2f0682mr6996194plp.2.1712150385380;
        Wed, 03 Apr 2024 06:19:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001d8f81ecea1sm13305095plf.172.2024.04.03.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:44 -0700 (PDT)
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
Subject: [PATCH v3 02/15] kunit: bug: Count suppressed warning backtraces
Date: Wed,  3 Apr 2024 06:19:23 -0700
Message-Id: <20240403131936.787234-3-linux@roeck-us.net>
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

Count suppressed warning backtraces to enable code which suppresses
warning backtraces to check if the expected backtrace(s) have been
observed.

Using atomics for the backtrace count resulted in build errors on some
architectures due to include file recursion, so use a plain integer
for now.

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 include/kunit/bug.h | 7 ++++++-
 lib/kunit/bug.c     | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/kunit/bug.h b/include/kunit/bug.h
index bd0fe047572b..72e9fb23bbd5 100644
--- a/include/kunit/bug.h
+++ b/include/kunit/bug.h
@@ -20,6 +20,7 @@
 struct __suppressed_warning {
 	struct list_head node;
 	const char *function;
+	int counter;
 };
 
 void __start_suppress_warning(struct __suppressed_warning *warning);
@@ -28,7 +29,7 @@ bool __is_suppressed_warning(const char *function);
 
 #define DEFINE_SUPPRESSED_WARNING(func)	\
 	struct __suppressed_warning __kunit_suppress_##func = \
-		{ .function = __stringify(func) }
+		{ .function = __stringify(func), .counter = 0 }
 
 #define START_SUPPRESSED_WARNING(func) \
 	__start_suppress_warning(&__kunit_suppress_##func)
@@ -39,12 +40,16 @@ bool __is_suppressed_warning(const char *function);
 #define IS_SUPPRESSED_WARNING(func) \
 	__is_suppressed_warning(func)
 
+#define SUPPRESSED_WARNING_COUNT(func) \
+	(__kunit_suppress_##func.counter)
+
 #else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 
 #define DEFINE_SUPPRESSED_WARNING(func)
 #define START_SUPPRESSED_WARNING(func)
 #define END_SUPPRESSED_WARNING(func)
 #define IS_SUPPRESSED_WARNING(func) (false)
+#define SUPPRESSED_WARNING_COUNT(func) (0)
 
 #endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 #endif /* __ASSEMBLY__ */
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index f93544d7a9d1..13b3d896c114 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -32,8 +32,10 @@ bool __is_suppressed_warning(const char *function)
 		return false;
 
 	list_for_each_entry(warning, &suppressed_warnings, node) {
-		if (!strcmp(function, warning->function))
+		if (!strcmp(function, warning->function)) {
+			warning->counter++;
 			return true;
+		}
 	}
 	return false;
 }
-- 
2.39.2


