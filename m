Return-Path: <linux-arch+bounces-10707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97507A5F31B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D673BF8CE
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A190267F6A;
	Thu, 13 Mar 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1XiBCrS"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1483267F46
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866280; cv=none; b=c9vcWdE14iSIzX8D8XiWCMj942k4kEyRtmtcu4ySVAKlLEKaBd/OIRsN3+DzkNYKe+72BRSzbs5gtZSajV2vMvi9X+/54fFvnjVguO0cKyTQP8wkPvanJj+G2lTGAp//AEWi3Ay8gqQ5FzTFhrmuWh1Dr2TswBH5TRpbZXqE0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866280; c=relaxed/simple;
	bh=JbNbHCb0M8H+Mi/VSJ+AkQrazCf6qqGs/PR+WCt/JcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=vCk1IaFdDVTCkVENyqZ6DNn5EoZ3uXQ8u81PQMIQ0RlVqhgdKpCHeCEay4H9UA7H/zpufPN3Us0m/khZQXisdjpRMrT764ffPH2UvoUO9TFSBlh8jjlFvcmHslP/kQUjJLdp1re0HsXbFOQCVC+shny/ymEgCWhDznGtKzcALGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1XiBCrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxCl1osfLw2v3G3W+1kfNU8xiBvtJTPCZorcBEjeG40=;
	b=i1XiBCrSF+9v2m6bPObCTrnvcNAnDgO5kEE1zMt1utiI0LpgrASITr7jbg9qG5sUCUHbgv
	40mtgZ/l3Kn37w+k5FntsbwoPAbLS778n0o3XZTL6fbH+0rb66j++/9sNOfxNM2ZoYRPti
	Px/yE3PrYMCXiUgZS76rONl/IlieYbg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-FbxBY-gXPgKsO9zlIesccg-1; Thu, 13 Mar 2025 07:44:34 -0400
X-MC-Unique: FbxBY-gXPgKsO9zlIesccg-1
X-Mimecast-MFC-AGG-ID: FbxBY-gXPgKsO9zlIesccg_1741866273
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so4274565e9.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 04:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866273; x=1742471073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxCl1osfLw2v3G3W+1kfNU8xiBvtJTPCZorcBEjeG40=;
        b=d9xj4SX1P5UBsdActdojkAUrtO0o8a8HTLLxEW+ib6smGw1qJfu4ltN4dNZUQa0Mc6
         YvMifSvpc2TDpnaA2oU61sxM0HrG8bskMBNV1EPI2mRIOsOt2f35z3R8Cg/52YS7Somm
         rTTQwBz3yBHKgbMjWWOOIACFQAzVH6+UrLSYjTFUDTd4Em5vizuvFv7RKKqO9NYvVmqt
         8d3Gg+EV9+ZxV6SKRlNXoPDsfy6ZkNe8ko5M2EuZZ6RtR1RC/zJLOnnoV2HRltDmZArG
         SI/M+A1hh8z1rZMqVn0g29FdvIP3EXWzYVZINvbfv4MKNntB0bAHdbURNEULp+RQUXHi
         DQzg==
X-Forwarded-Encrypted: i=1; AJvYcCWMMYvDmqHh8WlOPgs5HtLifBPW0VHKCHpG7pMDRKXWXWS7zdEpbpBPOW+ylPNOLdX9DnRiUI/Sq4LE@vger.kernel.org
X-Gm-Message-State: AOJu0YyxkCCzgB+iqjYuJ2hgOCEIzUkKYZT3de5aZhyZWp3l1p2/Sv9P
	wycJAXZv52rlCpD9LO59iCWFM54DRyH7cJ96juu9OH4e4QMfABIU8mCTVOAGNdu3SC1iJPgrhV5
	CX/+1YDPeFm2wWrVd46Zo90qQvXgYlxiFa8HZny9JoR8tacSz2Waj3MdEcJM=
X-Gm-Gg: ASbGncu2U55AC/s+/c3HUJC8xJWRnzlpWr4wRWoBPfFdx4GgqMftVXLjiiex+0zcZCH
	H1Vv1/at5boyagswXddetuD0hFtcZHM8b4U468pLjvaqTGrWxpsJGRlLJOn8ooiTWZZrpP9Yl7C
	zBrusVO27G0kCHJOr8JI4HC2j7vThofUUp5fO8jw5bUS16xLFVoxtTuUgh9Qp8X+7UpRgkOE21n
	PAb6bbM7itRoSIQBw37idH+o800U2EfXWsjvodDuYTSoKhuDRWkbYvM4v8hPf7XzGQDJQ/qV0wQ
	vMzPjsTJEDr5xDVFFl4X
X-Received: by 2002:a05:600c:190c:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43cea40af7amr174500565e9.31.1741866273482;
        Thu, 13 Mar 2025 04:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs6EAEForVjkecQAM8kbehVzhKfM/0tK/SxXfrbXe4b06Gjm7InnzRnhjTKgVzk9sVgzkBAA==
X-Received: by 2002:a05:600c:190c:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43cea40af7amr174500265e9.31.1741866273039;
        Thu, 13 Mar 2025 04:44:33 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:32 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
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
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
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
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 02/14] kunit: bug: Count suppressed warning backtraces
Date: Thu, 13 Mar 2025 11:43:17 +0000
Message-Id: <20250313114329.284104-3-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

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
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 include/kunit/bug.h | 7 ++++++-
 lib/kunit/bug.c     | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/kunit/bug.h b/include/kunit/bug.h
index 0a8e62c1fcaf..44efa7d5c902 100644
--- a/include/kunit/bug.h
+++ b/include/kunit/bug.h
@@ -20,6 +20,7 @@
 struct __suppressed_warning {
 	struct list_head node;
 	const char *function;
+	int counter;
 };
 
 void __kunit_start_suppress_warning(struct __suppressed_warning *warning);
@@ -28,7 +29,7 @@ bool __kunit_is_suppressed_warning(const char *function);
 
 #define DEFINE_SUPPRESSED_WARNING(func)	\
 	struct __suppressed_warning __kunit_suppress_##func = \
-		{ .function = __stringify(func) }
+		{ .function = __stringify(func), .counter = 0 }
 
 #define KUNIT_START_SUPPRESSED_WARNING(func) \
 	__kunit_start_suppress_warning(&__kunit_suppress_##func)
@@ -39,12 +40,16 @@ bool __kunit_is_suppressed_warning(const char *function);
 #define KUNIT_IS_SUPPRESSED_WARNING(func) \
 	__kunit_is_suppressed_warning(func)
 
+#define SUPPRESSED_WARNING_COUNT(func) \
+	(__kunit_suppress_##func.counter)
+
 #else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 
 #define DEFINE_SUPPRESSED_WARNING(func)
 #define KUNIT_START_SUPPRESSED_WARNING(func)
 #define KUNIT_END_SUPPRESSED_WARNING(func)
 #define KUNIT_IS_SUPPRESSED_WARNING(func) (false)
+#define SUPPRESSED_WARNING_COUNT(func) (0)
 
 #endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 #endif /* __ASSEMBLY__ */
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index 351f9a595a71..84c05b1a9e8b 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -32,8 +32,10 @@ bool __kunit_is_suppressed_warning(const char *function)
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
2.34.1


