Return-Path: <linux-arch+bounces-3155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C688ADA5
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E111C3FB9D
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E4763F3;
	Mon, 25 Mar 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMLdE8Nh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7757316D;
	Mon, 25 Mar 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389178; cv=none; b=fiSbPfuHu7mnkKKibi5PSwc/4EW69FBMuYNGLdsffM7KPxdy90OL89dPua4Eho/JpHntM1D8rPF0xm41L4BU9ZfDCkWODwzWH9ynfmx7XZYLYaLx0gtokmxkvYwUagtyGHeI8xHaYkRXkkVJEBNgjfM+GYNuvFIFGXAEfH4rxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389178; c=relaxed/simple;
	bh=VOccJ8b4F3FXwu0VomVq1foVe5FqXJomPjb+iB5b73s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fp72Ylo/oPBGRwhBW3phHW6IPEtCDuwdk+agY3d8XmlhCi6O3kF/FXmT7JR+4wBguarCo/60xR1IQzKRyWcHTX2t6w07RQeuJJKU6Umj7udhXuk221xmtx+Qwn3fijiNceQ3O3Ao7pbMbEkD6D0/RY4r5nijF26ihc3IH2itqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMLdE8Nh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3160916b3a.1;
        Mon, 25 Mar 2024 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389175; x=1711993975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XNSADZIa55EnhS6o0yIL3ifpTu+GjUejKXDxEmLThHE=;
        b=SMLdE8NhIvS+23/6Ri6e6rdzSwgwu2ycsoDk5lDGQRGURaJu5cYQcP+2EjwCRUYeb2
         wGweWJsxo2A9fKbb+6RpI1gm2i9Ll1wBBJcQX4hoMQPjhnVs6eQHch5uLbT6NRkeULNy
         W6OGx2oPSewur/f4TvTbmNCaDD+o/gAicBhvAAv+8U099zp7a77vs3myPhDJv3Ehcgg5
         a8W6MpxsloS67xWWk0rVDI4tFwRdjooGIEuNvBmdY+hFWLc+sEW0f7Jih7WBDtJaP56v
         bmzB6PQ2cTPF1MmXnyTng3FOarpsbRUCagneumu5wE8OpaAt417pJf7kSYHcf5MM/xdm
         YZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389175; x=1711993975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNSADZIa55EnhS6o0yIL3ifpTu+GjUejKXDxEmLThHE=;
        b=pTOmskKrO1h0mgcGLJvQt8/IHGLF3LSeMLJWMMmD9Wc6ZuE46w3NpB+GEDctLWwLj9
         Wl3I0jJ5A7aEBPjkYXyLQgbn/dfmhm6Q+VJBjanYdRPG9uUAzfiI3t4V4TC68YvNW/os
         0+aCVKZ5U1LuUocaQGBJoNEdjmnQcO1a3JdG804tXRP9Tw++S1SoWvb2+J1P0+OTdhwi
         NlOlTl5E5p/WrWnzTty1SYnPc9//MumF31MlKUMPo3ZZBeBUYoLqkHuTNjhAP4bn5IMs
         z9FSx2Vb/vPKFiG0zpIi1Jpq2AVOXF48JpWfG8GGCJEQkLgjoBF8plEQCOoxdd1nZEnt
         Ny8A==
X-Forwarded-Encrypted: i=1; AJvYcCUKJUIL4B6OFUGp438YAZhGqW3a8Ccq+nTu+Z0rkTNkdoZB7XxNXgCexfTqVursAWlfZpYzdJp4DFmEtmZfN2YDKZ9VCaGSR11DCKq0lpwQE7xgguIoWJM123rQQEpgUO3uR+cmrRXccF5kDCfRKyWH/jcTOKWZ93/MBOP1bhe1gzJA4wQnaVZJ6UxVLu+y6p2BGm8OV5w1uMQmDkvwfkZ64IA9M9Lt7kzBZS+X812WUoNNSHpthZACLZp9+kKNGL1TigbCcu4sXdRZaMKrIvins0bLmL+RqsHfiGEA/vJQAauoIsLbhZbbPmQh7z+oug==
X-Gm-Message-State: AOJu0Yx+1f1tqoAf2v28Y3okPnVCpeNchqGfAGpD/pRkukccziO7HuLf
	6hCfIewTZnvBH8lvsAk1HqNdcYZ+C6FElfKb+qCpvhDUXiSbvmsxblKSciuu
X-Google-Smtp-Source: AGHT+IGIDWtPHdUbX+7LWIxScptU3Z3k9sozN35URR01B7XvfxcUzrh1Z1HYjZAKi2mO+Me8ITFPPw==
X-Received: by 2002:a05:6a20:6a0e:b0:1a3:c4ba:a453 with SMTP id p14-20020a056a206a0e00b001a3c4baa453mr6509702pzk.7.1711389175417;
        Mon, 25 Mar 2024 10:52:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dr18-20020a056a020fd200b005cd835182c5sm5239787pgb.79.2024.03.25.10.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:52:53 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 00/14] Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:34 -0700
Message-Id: <20240325175248.1499046-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons.
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad-hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

One option to address problem would be to add messages such as "expected
warning backtraces start / end here" to the kernel log.  However, that
would again require filter scripts, it might result in missing real
problematic warning backtraces triggered while the test is running, and
the irrelevant backtrace(s) would still clog the kernel log.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum. Architecture specific changes are kept at minimum by
retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
CONFIG_KUNIT are enabled.

The first patch of the series introduces the necessary infrastructure.
The second patch introduces support for counting suppressed backtraces.
This capability is used in patch three to implement unit tests.
Patch four documents the new API.
The next two patches add support for suppressing backtraces in drm_rect
and dev_addr_lists unit tests. These patches are intended to serve as
examples for the use of the functionality introduced with this series.
The remaining patches implement the necessary changes for all
architectures with GENERIC_BUG support.

With CONFIG_KUNIT enabled, image size increase with this series applied is
approximately 1%. The image size increase (and with it the functionality
introduced by this series) can be avoided by disabling
CONFIG_KUNIT_SUPPRESS_BACKTRACE.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

Design note:
  Function pointers are only added to the __bug_table section if both
  CONFIG_KUNIT_SUPPRESS_BACKTRACE and CONFIG_DEBUG_BUGVERBOSE are enabled
  to avoid image size increases if CONFIG_KUNIT is disabled. There would be
  some benefits to adding those pointers all the time (reduced complexity,
  ability to display function names in BUG/WARNING messages). That change,
  if desired, can be made later.

Checkpatch note:
  Remaining checkpatch errors and warnings were deliberately ignored.
  Some are triggered by matching coding style or by comments interpreted
  as code, others by assembler macros which are disliked by checkpatch.
  Suggestions for improvements are welcome.

Changes since RFC:
- Introduced CONFIG_KUNIT_SUPPRESS_BACKTRACE
- Minor cleanups and bug fixes
- Added support for all affected architectures
- Added support for counting suppressed warnings
- Added unit tests using those counters
- Added patch to suppress warning backtraces in dev_addr_lists tests

Changes since v1:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
  [I retained those tags since there have been no functional changes]
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option, enabled by
  default.

