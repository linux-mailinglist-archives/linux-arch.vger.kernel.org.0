Return-Path: <linux-arch+bounces-3378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4C897021
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185F41C21B06
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C21482F3;
	Wed,  3 Apr 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8+qq+KH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5F146A7E;
	Wed,  3 Apr 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150384; cv=none; b=QkgYaXcpKo9orSgros14iuQLoKodmHdXOmQ0ouhWtHbo6/BT0NTDlQR0SkkP1CcrA1XL35zpHjkqprOV1ZJSRk7qEvg0JRrMbt5+xc/GBswEKywueLcTO+5viE3300frtUOkEqApkDT6gwJKVuvvoH/mW5OP3SBwdUdiHJP0Psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150384; c=relaxed/simple;
	bh=l/Ke/wiPt7/TaV9ybG3TveTzs1CGNNNgzCBPCA58cXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2XKSWFqepNHm0ZwXRLashhbvkytXagXL/k4dX0R9wdymoH3N+/jKn7516MDyDCcJY4EeoVOBLqLEgr4o+ZRAbpmFZDr7NXnZRjjITu32HbVGETRiUQ94CVc3Yoom5KQLDjbx9LBHHtrtSHooNQNDvoZcSvw90zmFaVgRVO2oPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8+qq+KH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0f2798cd8so52875975ad.3;
        Wed, 03 Apr 2024 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150381; x=1712755181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5jeOyVY2AHqhv0KvV6kieVXey6Da3SBwUwdCTK976WY=;
        b=g8+qq+KH/4ZOw4yKmBeAN1AEjHVv4iug/VmhgFNn9K3CpsBNyhSrCcyW9HDX4iUS3w
         /zOuq23Y7ylAmJ4g4SKSm5GrP+9Hqr6mx5kq8xfut73OVqpZgFccbQufMji2kpyz3nfO
         WSRP0qc8YcgQIWWCuGBmNtnMRy8uHFeX7UmbnrEVJ+WdKNlhVeJe2PxSE29c8fb/UuPF
         cM+41js+04qz9ygVpN/pJELTfwE2hs7qLkiAIj6xdSS0+HXwRtraj8/WGlsPpvq7JPOT
         23hJBjMtOmfbX7uNlA3nB/TKAiZlRrLRsMTzScAcHJfYJqpdvOMj4dNodseyrs5d4QoS
         ye3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150381; x=1712755181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jeOyVY2AHqhv0KvV6kieVXey6Da3SBwUwdCTK976WY=;
        b=Te9qcRJDk+wo+ljEOihoLhkG/BO1zjSc8CsltTQQV3pbB0vrTGVdqzy9NJZeqazZPW
         vyBNrS2F2O3EPCWckNAGeJSFhbMAFHg1jO0eVYt2+501YhSDUsssAhPCP91CNLtc+yg2
         5hBeNrp8SU3rkC7Rha2I99Uv5nAeObtwC1XaNhabZF5GakQTnew36LLfgdz4iXWaFxkD
         8BXE2lioeV1/WsrOLlv4Fw7zgr1hpIuMz8KL2FdPHQRsfmCDvuklMa7NWObtgW6G8IqB
         610kBPh7nlCBHy7/lzBmzrLrqzsGMlrf4o2YtQp9Kz8MLDbWxhaA24Q5ZL6sp7KwGMum
         vWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn0tQYIthAh+dAgS8It5Dh0e3tsOptMMWzEWD/SPt3Ish5IZRiZqXw0uINqRmcZxvGGcp+89IvG/mMP7dY8wvxoRQ6rOSFkG0yLOeimq9lTis3JTucGBfm/YpMyj4Z0BQmES0q80vOEM10OqYR+pKMFj0BjfCwDWk/m5GIkvfhHY4wnChUpiwWxhKtE8BAUMguqT0Whm5VCbZMEG7J5SLP5jnkT+LaX03yGTnRoREmVufV2u+DT4EF11djn8CafzBoycRVj8jg54Mz5ZsvmTpu2apKGcR1pgcQsMDBUVS8UZzqbD+1jn3U5agG/sCmbw==
X-Gm-Message-State: AOJu0YwwkDi2irBujbKEOLv/JDyRJlsvoxKJjgfm2x6yf9eVUoHMGxJy
	vdVkc3vj9oZ2iOJHypcpRflgPNmTlWltVpHF6nDNmdo/z/TR9wrdovK/eWbd
X-Google-Smtp-Source: AGHT+IGUUHIUOOsCxCF/TsSf8IWxMRQa7fBTBtgLaZOyDBRCO0Z9+JW6g9cTcLQ9TLR427e8GbHcQA==
X-Received: by 2002:a17:902:f68b:b0:1e2:8ec0:90c4 with SMTP id l11-20020a170902f68b00b001e28ec090c4mr2621403plg.2.1712150381396;
        Wed, 03 Apr 2024 06:19:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b001e00e17c6e2sm13430178pll.138.2024.04.03.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:40 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 00/15] Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:21 -0700
Message-Id: <20240403131936.787234-1-linux@roeck-us.net>
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

Changes since v2:
- Rebased to v6.9-rc2
- Added comments to drm warning suppression explaining why it is needed.
- Added patch to move conditional code in arch/sh/include/asm/bug.h
  to avoid kerneldoc warning
- Added architecture maintainers to Cc: for architecture specific patches
- No functional changes

----------------------------------------------------------------
Guenter Roeck (15):
      bug/kunit: Core support for suppressing warning backtraces
      kunit: bug: Count suppressed warning backtraces
      kunit: Add test cases for backtrace warning suppression
      kunit: Add documentation for warning backtrace suppression API
      drm: Suppress intentional warning backtraces in scaling unit tests
      net: kunit: Suppress lock warning noise at end of dev_addr_lists tests
      x86: Add support for suppressing warning backtraces
      arm64: Add support for suppressing warning backtraces
      loongarch: Add support for suppressing warning backtraces
      parisc: Add support for suppressing warning backtraces
      s390: Add support for suppressing warning backtraces
      sh: Add support for suppressing warning backtraces
      sh: Move defines needed for suppressing warning backtraces
      riscv: Add support for suppressing warning backtraces
      powerpc: Add support for suppressing warning backtraces

 Documentation/dev-tools/kunit/usage.rst |  30 ++++++++-
 arch/arm64/include/asm/asm-bug.h        |  29 ++++++---
 arch/arm64/include/asm/bug.h            |   8 ++-
 arch/loongarch/include/asm/bug.h        |  38 ++++++++----
 arch/parisc/include/asm/bug.h           |  29 ++++++---
 arch/powerpc/include/asm/bug.h          |  37 +++++++++---
 arch/riscv/include/asm/bug.h            |  38 ++++++++----
 arch/s390/include/asm/bug.h             |  17 +++++-
 arch/sh/include/asm/bug.h               |  28 +++++++--
 arch/x86/include/asm/bug.h              |  21 +++++--
 drivers/gpu/drm/tests/drm_rect_test.c   |  16 +++++
 include/asm-generic/bug.h               |  16 ++++-
 include/kunit/bug.h                     |  56 +++++++++++++++++
 include/kunit/test.h                    |   1 +
 include/linux/bug.h                     |  13 ++++
 lib/bug.c                               |  51 ++++++++++++++--
 lib/kunit/Kconfig                       |   9 +++
 lib/kunit/Makefile                      |   7 ++-
 lib/kunit/backtrace-suppression-test.c  | 104 ++++++++++++++++++++++++++++++++
 lib/kunit/bug.c                         |  42 +++++++++++++
 net/core/dev_addr_lists_test.c          |   6 ++
 21 files changed, 524 insertions(+), 72 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/backtrace-suppression-test.c
 create mode 100644 lib/kunit/bug.c

