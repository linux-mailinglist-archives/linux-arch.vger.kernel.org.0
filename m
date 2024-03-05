Return-Path: <linux-arch+bounces-2811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E778726C0
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A7288E99
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D291A5BA;
	Tue,  5 Mar 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfyqydVR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866217BCF;
	Tue,  5 Mar 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664043; cv=none; b=VdtjLalW5LRo6HhV4oorjCodhwMqjAqvNAYc6kJQgYNUWM+pr3xjGyZtR+vUCaWOuBeGBe6QB+j4LHMiaY5740XflbY4VkAqis7FFJB03cAz3SVt3x8e/2qLmyaaTHJ1s1K+kJeLVk5pTQqVOE9Szl9dTvkmZQgq5PVtggBoAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664043; c=relaxed/simple;
	bh=TN+Scyoyp6dZQCpBaMNsM7bVZM+1hGi8d1AI3QjHzcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5szxRRv1SMyNmRlXY65MO5qyDJ9kHJNXau5WUqZJ66zUtwGywel69S/CvD1SB+9yGgeUxsUtRS0rToRbc5y8+qTQnU8ObtUENJeeCUiRRT5fFwa6Tbj37z1pjhTdevvlBmfn+zi8DQKyZRr6VscRFJXvIOogIcZGhMrMqtwa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfyqydVR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36576b35951so4727535ab.3;
        Tue, 05 Mar 2024 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664040; x=1710268840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YQLzgqGcJCQTSOmHQSBuR9Qy4cscbXhB7FIpF8lqDFg=;
        b=HfyqydVRmlPuH9QySqIE9XLmpN0yrqVr3s6QfpXQQfEEKSmoBfXLBYEoEDXKTS8ilo
         YekL/diSRMHdbZJhlL6ZdTuAhju3shLmI1tk2e+UXA6h1XopcKyZxb/ICqlw6jSCkPl6
         0vxld/Qt4H/OhWWqwGRVvoIEXxQBUqelL4lsoVSLSmLB7PzWFtJcZU5DlnKvZpsHWnEK
         9bygaUsG9b2H4U1YIZEY+r0a2o8K1VffznbmgE1dYuO74NDZeTg7njZNFyVJBzWx0d7K
         3JvJdqJGkBQ1C2Por/Pf7jWC5DlQykYO3WcaFZWgKci3O6arSL5MAWmOQMJq94mVM27+
         hiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664040; x=1710268840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQLzgqGcJCQTSOmHQSBuR9Qy4cscbXhB7FIpF8lqDFg=;
        b=LGs+hNVbIo9hpMmPrUnyxTdOgD9guTrM7lZMY09gNTJxV3spJZSWL9qYxfu7VJ5V24
         VdjqTLjPA4ep+L5b9ygS0VfByuNU446TddcikoNZiNt6pcZSxhnnuPmzmtmcH0UkisBf
         IF/IaYqiyq+XNQfK4Y1i+OqrRYG+L7x1Ew5UzxT3ubJ6Eyz64bXUc2ag2ChgG6NzZ+Cs
         3UbDYVIefaNh0cLb7jXFAQy43/KG7ChptHkkXpxG01IMVJPUkAdrPTw2MQosehyJoPvj
         c5gOJGkERu4MYQPStET0Os/Yj90b1SEH586QXmfSecMjNY5Lrt0chhHG2raUCrPqWAVA
         UFsg==
X-Forwarded-Encrypted: i=1; AJvYcCUCOJyCsQpr/+vJHWuji6pprTQWKXNnlAa+DDU29VlMe1cIjKVTRPVSkhQIfznlKPDEXh02eTQa5Uq9mKWt0lXHnMLAdHJQCPOufkGV4/5a9Ltm1QTqubBOChEci966jA0+TJvdSW7elg==
X-Gm-Message-State: AOJu0Yzi7DCZGUfXxB9mZhlpSaWHDatj32JxVNB4Ov9cMLipGVO9s79W
	D+ub6bzWuukwaqKRhgQ7ZqoWNGi+4c8hbHkimj9HfO7hLd0k4iANnIhBJMSi
X-Google-Smtp-Source: AGHT+IHLOs8AkdboH9ufe3uVfCMuBj2myZQffsOSLGEYtVubGujAxHdd/KSSUYo1ed4iTaJle6dOCA==
X-Received: by 2002:a05:6e02:1564:b0:366:140:801 with SMTP id k4-20020a056e02156400b0036601400801mr1621302ilu.20.1709664040035;
        Tue, 05 Mar 2024 10:40:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17-20020a63e311000000b005dc4da2121fsm9444697pgh.6.2024.03.05.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:40:38 -0800 (PST)
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
Subject: [RFC PATCH 0/5] Add support for suppressing warning backtraces
Date: Tue,  5 Mar 2024 10:40:28 -0800
Message-Id: <20240305184033.425294-1-linux@roeck-us.net>
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
The second patch marks the warning message in drm_calc_scale() in the DRM
subsystem as intentional where warranted. This patch is intended to serve
as an example for the use of the functionality introduced with this series.
The last three patches in the series introduce the necessary architecture
specific changes for x86, arm64, and loongarch.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

Checkpatch note:
  Remaining checkpatch errors and warnings were deliberately ignored.
  Some are triggered by matching coding style or by comments interpreted
  as code, others by assembler macros which are disliked by checkpatch.
  Suggestions for improvements are welcome.

Some questions:

- Is the general approach promising ? If not, are there other possible
  solutions ?
- Function pointers are only added to the __bug_table section if both
  CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled. This avoids image
  size increases if CONFIG_KUNIT=n. Downside is slightly more complex
  architecture specific assembler code. If function pointers were always
  added to the __bug_table section, vmlinux image size would increase by
  approximately 0.6-0.7%. Is the increased complexity in assembler code
  worth the reduced image size ? I think so, but I would like to hear
  other opinions.
- There are additional possibilities associated with storing the bug
  function name in the __bug_table section. It could be independent of
  KUNIT, it could be a configuration flag, and/or it could be used to
  display the name of the offending function in BUG/WARN messages.
  Is any of those of interest ?

----------------------------------------------------------------
Guenter Roeck (5):
      bug: Core support for suppressing warning backtraces
      drm: Suppress intentional warning backtraces in scaling unit tests
      x86: Add support for suppressing warning tracebacks
      arm64: Add support for suppressing warning tracebacks
      loongarch: Add support for suppressing warning tracebacks

 arch/arm64/include/asm/asm-bug.h      | 29 +++++++++++++-------
 arch/arm64/include/asm/bug.h          |  8 +++++-
 arch/loongarch/include/asm/bug.h      | 38 ++++++++++++++++++--------
 arch/x86/include/asm/bug.h            | 21 +++++++++++----
 drivers/gpu/drm/tests/drm_rect_test.c |  6 +++++
 include/asm-generic/bug.h             | 16 ++++++++---
 include/kunit/bug.h                   | 51 +++++++++++++++++++++++++++++++++++
 include/linux/bug.h                   | 13 +++++++++
 lib/bug.c                             | 51 ++++++++++++++++++++++++++++++++---
 lib/kunit/Makefile                    |  6 +++--
 lib/kunit/bug.c                       | 40 +++++++++++++++++++++++++++
 11 files changed, 243 insertions(+), 36 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/bug.c

