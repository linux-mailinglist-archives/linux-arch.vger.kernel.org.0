Return-Path: <linux-arch+bounces-12367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB1ADED07
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 14:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0D316803B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F62E54A5;
	Wed, 18 Jun 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPe9HjW+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A32E54AA
	for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251059; cv=none; b=KQNOkSAPa5GNF53nZCP28+6Y8FKU523PIF+sEOfFLGOk+cdDCrg8otAcRVgwhpIdIHpnCy0qdC7IXW3AHUJYxm9FJGSLkAX3W7TEKi1/EaZMtRtunQvPGkNgTBjywbqEDf9G+Mh6nQQ2R62XurJBtLU/MMAPjeIEWuOS2myvxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251059; c=relaxed/simple;
	bh=tYOMqDbBl4oLeXidO5nb93lks+dyLJ+aBvItgw9rtgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuUW5z9/Wn3zzL92/BQoYuKx6eTTwgtTU8UywME6eCRpBoCG3GOVWXR8rYdPT0RzIYC4/0ArPaFWyJvmeDIAOBPJ9sTEmso0t2Y093q8sBPNT8DX2fdEHJyJKpeeBB2YESRP9HaNJOZRt9PqNq23lmWIRNON04IFuK4CEnEh9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPe9HjW+; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a5123c1533so3908860f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750251054; x=1750855854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NbQn0+rtk9R9UQB3ZjUl1RmfRkgy76SQGVXPRmwvTI=;
        b=UPe9HjW+MI5cyVjjpsICuwdZ2B5jBGdvbqYjo4twPlv6+X6SoV2cBale59/gdLYETv
         FnVxCS2nBlDCPMPcZGRkVhfScnQ2yynWP5pSEyOLWVQbz4Kj/Dtb2IHmswwSa+X+7ZYz
         5ImjUD0lWFXU16l/co3EqkpoDwrJDdLwEOiJ/8dVCkS2gpgQureiVNGls/WqfaNIbVHF
         Q8KblZ+uIIDKwZs0LtG1sDgnk2BzTtA6V4GF7s8vVFXqRyLEHm8+goArXxuEiSRBsxS2
         cil4qfKe+Z5kYcq2+jrhRbZotmdf/tIRUE/iYjaKfswyRUIfZ9LxNN6q1+j9cKDQB69P
         bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251054; x=1750855854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NbQn0+rtk9R9UQB3ZjUl1RmfRkgy76SQGVXPRmwvTI=;
        b=uWtBDin1ApPowU3Ov2i2fch7+K/ImUuI1SwmvDIPx8dFO3uvaCef8GlUWdik56RQ4q
         0/E4M+7DUJeT5fpkwu1Fal+Oek+kL1T+tq46ZMGgQZuBUCINIOVsZAnlBSaizUUkNVu4
         OpHxg31zr5yQck16YS57qKZJqnYdjJ9QtNYOo2pILwCqbiV2BXFHFFQbHN96Zg26Bm9U
         LR5LnhQLXtX56ihJtZ1E9vBhtGK2SNO7gZY5hdseMKOXe5yQzeVBoju4lxarwVPqEQ3V
         Etuxc1wdHQqU0OAbwwddzSJRwlYyEjqvn/Dw7DNZHA/qtJhkK5wAk3mV//3ZI9y3a5Qm
         kCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipq2LSbOf7NR06vRLNLKhb+fPuXCCZcs944JtYWcX6iIrteJvbd+GzCV6ekCj1fbTiCNu/4QtJ5lj@vger.kernel.org
X-Gm-Message-State: AOJu0YzxeHiuD10WMTbEXFupSj6YZ945CM/aU6pB6dqGN+pqdkcnDKgl
	131vwBrV6Dunz107tHpGhBZFYGh/isfO40kCBH6784Tau3FlrrJYzSn02N9Z/D7gGRU=
X-Gm-Gg: ASbGnctGp9EDbv8tniX4mV0p7VrBJ6O8Z/NCSHgqld4iGKUso5cMiEAXV+7HXr6sHwS
	m4VR6AfcTp8Hnl8k031XqtfjCq4X0MJXzF1GwSFJ+ymWtB4EdE8ycW5PPXdrmeicCGyM1S4x9Ck
	Pu7TpmaIf9yOhGl08vG0Dv6RR8pbK9tZ5Voxrn4jWYZevy3fywGH2yLLu7LZUTbI3B/WuRWjg81
	slEOR0winhbpOE2epgC1I/4NqAMuzuNC+EfVmvHUUtJKYg/d5FMuqJpXcYefRiQeKPDmzVJau0X
	Nn+GtFxsOcHDnDto6bwvymbYBLS+r2Qh5XI2k9bWujxjEp6v6UuU0/2NoUCzmg==
X-Google-Smtp-Source: AGHT+IFEWHAu8VwBRrGTbvGEGcd39Os4PAnx0WLvaMN2iQm+8pQRf6KkKity1k65/583ahjCju2ddw==
X-Received: by 2002:a05:6000:1a88:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a5723a2928mr14371409f8f.17.1750251054051;
        Wed, 18 Jun 2025 05:50:54 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453599c9854sm13143435e9.1.2025.06.18.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:50:53 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Chen <cachen@purestorage.com>,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2] codetag: Avoid unused alloc_tags sections/symbols
Date: Wed, 18 Jun 2025 14:50:35 +0200
Message-ID: <20250618125037.53182-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
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
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---

Changes since v1 [1]:
- Trivially rebased the patch on top of "alloc_tag: remove empty module tag
  section" [2].

[1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/all/20250610162258.324645-1-cachen@purestorage.com/

 include/asm-generic/codetag.lds.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index a45fe3d141a1..a14f4bdafdda 100644
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
 
 #define MOD_SEPARATE_CODETAG_SECTION(_name)	\
 	.codetag.##_name : {			\
@@ -22,6 +28,6 @@
  * unload them individually once unused.
  */
 #define MOD_SEPARATE_CODETAG_SECTIONS()		\
-	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
 
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */

base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
prerequisite-patch-id: acb6e2f6708cd75488806308bfecf682b2367dc9
-- 
2.49.0


