Return-Path: <linux-arch+bounces-11187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D75A756E5
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1814316B6CC
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F181D63DA;
	Sat, 29 Mar 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McGusEZ6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7801C1AD4
	for <linux-arch@vger.kernel.org>; Sat, 29 Mar 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260688; cv=none; b=IyIDtobgpbDb/TrVSVmVM9/6h13x+O7+nThwQB+8Eqp6np9DjRJfNstukBlOM8LmNz0YcNSiyiuwMBM//kg3JbXI4uA4irOZzOyYs+kP8MChMuFVD/seAapXvGS2RAg490PvcicHozaJzNYN162z6aU+yQ4LSejoL3l6SP4UdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260688; c=relaxed/simple;
	bh=puzgkOgCUPbE+wQ6SBvpkomea7X06UdpL4PsTVyABso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=MMQFuyQAJr78hZ/Gf5FSwrOuXLjVFMkO1jogGff5n3CYpjqEMByTn1qcDlGNov1/JoEFnKj7qrpFK2EVmd1PIUiwoXEHxvNPExVh0xoOaXb99Ac3QGOlJKqBTBwIO5dvimUGtAuo/kDYmtFLda+q59F4qukZfcZghzRbZqp1tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McGusEZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743260686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9rZcFa00OKiutAluKujooWT6oAB0DkFh89UjHpXtZTM=;
	b=McGusEZ6JfqNO+09Dpac0+Io2xdOMy4gMUWY06XCp74m5xnF27o9E+QY5lkdygzAsNxTYe
	WqbgiK8EaEHvy8g0f6m+OB+/23uT7dS1TuJgT4tI0nwOsZ/fFTzF8VLVkQhAPKh8Uq3Ccd
	fqkUsLc9bmHxUiex16SB/yHBGGGsQDo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-YjZXUotCMv-098mEEvRBTw-1; Sat, 29 Mar 2025 11:04:44 -0400
X-MC-Unique: YjZXUotCMv-098mEEvRBTw-1
X-Mimecast-MFC-AGG-ID: YjZXUotCMv-098mEEvRBTw_1743260683
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912e4e2033so1335913f8f.0
        for <linux-arch@vger.kernel.org>; Sat, 29 Mar 2025 08:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743260683; x=1743865483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rZcFa00OKiutAluKujooWT6oAB0DkFh89UjHpXtZTM=;
        b=PDCY8TdveO92YczbfI9brdKYBT+lA28Kg6t3VPEgmPGPF5duMPiN2mFsEL5bT12zCr
         323caLtf6dWW1nKQ+f2JSUjUtmLKh2P/KO/SybR9M3qzinXGOqYKd2t/M4VhTicd9daV
         hD89bWrQZTkv5tKERrSocs3uykghfhEC+qIetjyMzrynXqU7AmxcjdMe/7ncfZWT/56K
         3pi9Eec8BfCQJwOl/detFK676rOVAg6Jw19IOMJlGC7WYtr5W501OYomz97ReCOOj1WO
         Cl67MHddMdwBkvS7/amKmkwK0ZGt1SiAHu6zHwdR3vXC/KfjNoaIZ3wdkH0vMxUOHI1t
         YWrw==
X-Forwarded-Encrypted: i=1; AJvYcCWYHcFF4TcPSce5F1TybbUhI3/EZpLw9TpXtw5sm//FHh4W3aFmNWj3KWVpKD/Mx2Z6l4trC6e2h0Oi@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZrD2VRif2C03pLfUOmAEWOgYeLUpt85cN9FTzufvmir4VoMJ
	FfE9enyqDU6j4YnUeZXyts/1iQs+6OVkHM7yR1EpB45iJSQPetWCPfyjY8mWc2rTQb/KLHXHf5i
	Iwc5Lv+Zw9i/hDkcQivGOPbFF4p9bYLyEwmDaiD2UAMkxthvQrBjCzC+ffVY=
X-Gm-Gg: ASbGncvIsuwchLI7I8s2nYGKqOnkstUR5DstgCxR4BnqumKDg5V4kTun3rv0LcqCz2/
	Lq9Fklp1vv0pYI0ScY/7Phf+V0ArDv217T1F30E1tbILSV+IqHoZdLwKbvmRsqKlzNUHQO8Iqms
	SKXaeuIrcXUL728qECXDVcjPg9uzjluMHxTZ5TZjJNRuoxPq3M0C1F52ZxXJA7e4iyttqU936i+
	8Q9910Zg+a8Pp1p3eF5wnhnWILjNZ2Ayv2hCeAhs+oWfK3+7sNFupIQNv9GncAykZCW4KZN57ph
	cMHopg5grh4Ux6b57fmw
X-Received: by 2002:a5d:598c:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39c12119db3mr2073756f8f.49.1743260682742;
        Sat, 29 Mar 2025 08:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/2bHdcw2ELtkQnH3PJgr7VcNq4CZ6lA8znbzDKP3oWHKcunfSfI/tIlxfFak/s1ZEaKAEVg==
X-Received: by 2002:a5d:598c:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39c12119db3mr2073713f8f.49.1743260682362;
        Sat, 29 Mar 2025 08:04:42 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8ff042bcsm63073205e9.28.2025.03.29.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 08:04:41 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mickael Salaun <mic@digikod.net>,
	Kees Cook <kees@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-next@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH] kunit: fixes Compilation error on s390
Date: Sat, 29 Mar 2025 15:03:20 +0000
Message-Id: <20250329150320.331018-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The current implementation of suppressing warning backtraces uses __func__,
which is a compile-time constant only for non -fPIC compilation.
GCC's support for this situation in position-independent code varies across
versions and architectures.

On the s390 architecture, -fPIC is required for compilation, and support
for this scenario is available in GCC 11 and later.

Fixes:  d8b14a2 ("bug/kunit: core support for suppressing warning backtraces")

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 lib/kunit/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 201402f0ab49..6c937144dcea 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -17,6 +17,7 @@ if KUNIT
 
 config KUNIT_SUPPRESS_BACKTRACE
 	bool "KUnit - Enable backtrace suppression"
+	depends on (!S390 && CC_IS_GCC) || (CC_IS_GCC && GCC_VERSION >= 110000)
 	default y
 	help
 	  Enable backtrace suppression for KUnit. If enabled, backtraces
-- 
2.34.1


