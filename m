Return-Path: <linux-arch+bounces-10736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB837A5F853
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F97819C4AAA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFB269882;
	Thu, 13 Mar 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXe5bN+z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF72269827
	for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876230; cv=none; b=bd5p9IZDPNlyrUFIIlFYh25mn8xXSC47V1oZ6re2gUq8cHqfwHfvtLwPJtPAnznn/US0wjtjy9Gc5IcXfNyzwOY+FrJb25fDzVCEiXg5XEc5C3Pdl46UBScOvQrMO41oS8SLMRdAnbQHg/Hc1aer25xzyfsPkVRFPcewQwFPTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876230; c=relaxed/simple;
	bh=juS07XMDjJAxWXr5mwzvAA1WxJHnGjWPahThOCqacTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+FH+WpinTSF5LVa8NymDeV5UlyI42HBqVk3VqHDuLnSJc1QwKYK5WlHoZWAmVPpMZuboCKo/aBwJEM+Ft7hgrmEVbmpJ7MAnR9cbwp3SeM/eh6r7NKlMoyQiVRH6JMT027kUYxgIjLHJVskU9M6OT+qRIu0Y/8PvlSql0y6Igc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXe5bN+z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f2f391864so592829f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 13 Mar 2025 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741876226; x=1742481026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrGk+0H2Ku6XJRdKx9mhOvfZypDyUlcvla1YtjtXmlo=;
        b=IXe5bN+zLxkm7J/fSMLyukI796Fj0+3dDQajNX7kgSfLC/HUxwSMcF5RVC9Z7ijLQp
         HqcRfR5RJD0aRkL0wpBCkCxn/uKqjx8eS5SOAKQ5cGSsCIPNWDMRkSWUZhFPTAyciuow
         JhGd+TPJj2H3YqVnNcmD/3nAmI6ZWDUSCv0VG1OIV6biejsiCRkHHybttJ08wSdstjdL
         d14jhOM8VUaPVcvClVdy8G35f3bIhrvSdspXjyIldNpXxRV3qaTDLY5zOLhmSjMkkf8y
         VWySkES6HI4QVs/ZJeQo+YpeZc+C4EE3P1YUuluORVPzDk31OsrGM7tAZ51fykmLofxR
         U2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876226; x=1742481026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrGk+0H2Ku6XJRdKx9mhOvfZypDyUlcvla1YtjtXmlo=;
        b=I6JMqC2dg92a5xqHoTzxkx+kNpZzQLOhjoyCeYwzFB3+ew0Ns3SCMj1hx5EDQgbomF
         1QQ5nTYcCkNXczAM251I6DVPVbvT21is6usi3RN/bp9RnNi+jf+VKV3oABnmWqwEIvwk
         C3faoIF6OgjpZ8+T+jgFjrBp83btPxzIUCO+U1XBdVj+pT3uZbdWjViG1BMCCsP0KkI3
         WhRPjqzeZpAD3hzmBLtVGWj9NuF1wcu+yBhoEfMMkSScNdBzGDYDqBs5+ctfkeC/C7AL
         x0A+p5IhAfPXI0Xbe/Sa4nT885NkclrKR3h+o7CNmBWdcAUX7Vsy+kf5EjhWw9FMRUUR
         VNag==
X-Gm-Message-State: AOJu0Yx4OlvO9htkIPq5cQjiRaARc/fWUw8wWxRo/ty/fIk207H9eiJy
	BKLe/J14NocmKC48p+fy9tCdyzLu8OcgIaehxssNS0xr81NwuaNEZbkKB4r+C7U=
X-Gm-Gg: ASbGncsrMMXczgAuLsUi146ebCqG7udylq04R24QlT7iMYHMUUy6OSNye9sysyyMlYX
	5yL3br0zDYxEie/yEZMHqxDZwB535+ufJHCuBH7kMC2exlpixwp3IuD6LddN1okr4EQPLQe45ex
	o0goCQAkfxiIdg7pcP2PigMUgySVMBmhetSx5tgGJqKMjoUoSQgNl5gVqy6m9GbH3GjsOG5BecL
	wZHOausqChLuIeqfks5q9hFaGcWFuQ1ZxEG4oXfEPvflCnVXu1Vdija59uWq0TMG6tzkHcV+NzU
	tjHFTnBEbSQg4+qlcojoLYx7H3QBhPH6eJ8vde/mqeI1dOIV
X-Google-Smtp-Source: AGHT+IEopD2BOlwvkpG1x6M74L7kpnMA958szdTdn2Obv0FJ9/lT9q7aHbu7ZV55PrVSeCNR56WDNg==
X-Received: by 2002:a5d:64cd:0:b0:390:f2f1:2a17 with SMTP id ffacd0b85a97d-39132da9d2amr21115722f8f.53.1741876226568;
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm2324196f8f.33.2025.03.13.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] codetag: Avoid unused alloc_tags sections/symbols
Date: Thu, 13 Mar 2025 15:29:20 +0100
Message-ID: <20250313143002.9118-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_MEM_ALLOC_PROFILING=n, vmlinux and all modules unnecessarily
contain the symbols __start_alloc_tags and __stop_alloc_tags, which define
an empty range. In the case of modules, the presence of these symbols also
forces the linker to create an empty .codetag.alloc_tags section.

Update codetag.lds.h to make the data conditional on
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/codetag.lds.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index 372c320c5043..0ea1fa678405 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_GENERIC_CODETAG_LDS_H
 #define __ASM_GENERIC_CODETAG_LDS_H
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
+#else
+#define IF_MEM_ALLOC_PROFILING(...)
+#endif
+
 #define SECTION_WITH_BOUNDARIES(_name)	\
 	. = ALIGN(8);			\
 	__start_##_name = .;		\
@@ -9,7 +15,7 @@
 	__stop_##_name = .;
 
 #define CODETAG_SECTIONS()		\
-	SECTION_WITH_BOUNDARIES(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
 
 /*
  * Module codetags which aren't used after module unload, therefore have the
@@ -28,6 +34,6 @@
  * unload them individually once unused.
  */
 #define MOD_SEPARATE_CODETAG_SECTIONS()		\
-	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
 
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.43.0


