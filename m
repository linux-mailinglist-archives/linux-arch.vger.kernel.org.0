Return-Path: <linux-arch+bounces-2940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A187999B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC7E1F2158B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAA137C3F;
	Tue, 12 Mar 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOCjO/h9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B0137C28;
	Tue, 12 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262998; cv=none; b=dd6FZzC/jU2GbwxXnqtNclNQWNH7myJyAJqymL4P91eqZul4x3Xur8Zlv4FsNWmuGassPRGjgpazwdVgYBBsVWCMRDtn+2QSAuk81Mlhs6VHw/jrSjieZVm0PESol4WYGlkGncBxJ/FEbJN7uTRVvnPTHucejZBz5qycQhhLnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262998; c=relaxed/simple;
	bh=8n/02f2SOXoK5vgtrzv7GEjJRgXi58830FC1dkrTfl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cspjrz/V1wd1iESPhgf3JPYLRBPUVI/nTUtOgcgCDjv1Ez8elNwV6Vj/gKOTiHFt4pfg6Pws/rix64YuxPm25NQBmByGdCHwqHgItYO6udmO6pJZ2TS4x8UKdWyn70jyDSDgfK8PS0+lib62/H0iq8pckV1QAKIf0wy/hqtOj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOCjO/h9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd6412da28so941115ad.3;
        Tue, 12 Mar 2024 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710262995; x=1710867795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WLftE/7MjlMuOSj897HlMQUMVZbmkOmcm7ijw8JWvLk=;
        b=TOCjO/h9j9/oYEuEyo3YGECfbtb4ILdLfL2GJrPbCRaaDbbueU0XyC3+kQ6dn4Rnno
         zUSiLazMocmjTPTFkSQ3/wsG7aYVEPSQp9vwmoudsBziwtM/akbrWDxDa+GYNzNm5zLy
         EoT5Q62zoH/o4CaFAY/A+wiF04OaCxoFgrpFKoErVhX+ZUWpYcGBtMH0hqGAOXa2w9o4
         mi1wNtb5WAJm+Cr5qsyOr15E6svu28i20WlE76pynyeYVSg5COfku99ck9V2tp5OhKwO
         xqkNZ7JnkoRddCjlyho4GTy4rs26uWNMai0FbG1WCgtrKwm7XVA7BLz8FVZSQTaavzxa
         Uvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262995; x=1710867795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLftE/7MjlMuOSj897HlMQUMVZbmkOmcm7ijw8JWvLk=;
        b=OQLiNhl/xFcKq096rVn8/mb/3cAUPfgx4aoE49rfbQch+g6xo+S34OFJnRdq29799U
         i4kGmdHmx54b02YevxIHiyq9Tp3MUVWMsBSVMZ77f2+9BIYyYTcj0MWCxY1+4crUcJ4j
         0GHubYei88bFYm09jbNAVQxkjqwz6hpFbfrETNk6FZNk0LAXDQHG+s1cq/lkmNYdc0Vm
         ZRBmvSJ+JVOjMm5BUx08ALDi8WWtHyyf12+nI+6VROjDt1R0aPeeGhWrZc4jQunTn+BM
         nUol+Gy0V47p7wjNKZ0wOalBzUl8+Uk4DFGn62wnS58IeoKVKZ93vMpYMnoYxOECQQ+O
         sLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnLYG8h4c9VVjLmlpewox7F6DiwN/nx/43kLSfvBL3Gb6w/9MTboKtobxJCmkNdFlZCGb/MHlwth1AH7+sK9gyGKEEIlGOiVcKYFQK7/WP5YAg21jpiv3HFfF7Z791XI9o4aYCzPvOf0slv2ogVry7mTjlJ+YJbD1MUoDdcOcj2Q9cCCX0RkJRn9dGSBJkK+yjv848s5iiWBsf0lsm36RbUa2wpU/stGT0Bp7V7EWnGb2QpZJRcfzvBeLwIGVuVQFGr52XZEjDaz9sxPFP2amvYmdaVAlkFQ==
X-Gm-Message-State: AOJu0Yw2f5OruTwvVgd1DktL6ntLNN5/1hQGEKOCWQmFVcgGi7Hqsy0a
	KQ371PIH06O8aoKysDCL3ZaOHjBwNq6ksnznxeWt7UKFoBdAL/MZZOBfxSgG
X-Google-Smtp-Source: AGHT+IGoSNJSdzshXUinY0deqrpWSsXfjdp27VpnRBXFH0xqKuZltMGKwFFXD7x5fWGnOCLrPfDYHw==
X-Received: by 2002:a17:902:7ec9:b0:1dd:b681:990e with SMTP id p9-20020a1709027ec900b001ddb681990emr2092458plb.36.1710262994820;
        Tue, 12 Mar 2024 10:03:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902c61400b001dd02f4c8fcsm6942533plr.139.2024.03.12.10.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:13 -0700 (PDT)
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
Subject: [PATCH 00/14] Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:02:55 -0700
Message-Id: <20240312170309.2546362-1-linux@roeck-us.net>
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

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

Design note:
  Function pointers are only added to the __bug_table section if both
  CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled to avoid image
  size increases if CONFIG_KUNIT=n. There would be some benefits to
  adding those pointers all the time (reduced complexity, ability to
  display function names in BUG/WARNING messages). That change, if
  desired, can be made later.

Checkpatch note:
  Remaining checkpatch errors and warnings were deliberately ignored.
  Some are triggered by matching coding style or by comments interpreted
  as code, others by assembler macros which are disliked by checkpatch.
  Suggestions for improvements are welcome.

Changes since RFC:
- Minor cleanups and bug fixes
- Added support for all affected architectures
- Added support for counting suppressed warnings
- Added unit tests using those counters
- Added patch to suppress warning backtraces in dev_addr_lists tests

