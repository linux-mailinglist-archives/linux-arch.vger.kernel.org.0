Return-Path: <linux-arch+bounces-9250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF69E5685
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB11883F3F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F862219A6D;
	Thu,  5 Dec 2024 13:21:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CE218AD3
	for <linux-arch@vger.kernel.org>; Thu,  5 Dec 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404864; cv=none; b=pZ4v6YhzXa4uWVVt02o8TmXm5bNoHFVmCsJOT7HkTtJyS1JEnd5KzRsU2ERF0T/tjGfszK1uPsxYgBKacemPf0I1/FyAO2sa+AZTkk4dXOEOhdJM3aQ5Pyx872SVMmsxv9S+vRJrISO1jpH9dBNQlkleCxwBEaeB1Gr5GHN/img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404864; c=relaxed/simple;
	bh=ouJue5tjFCDF8EpWHp3/+sWbDClK41wBU4/Q5wdnFyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqzR72AWMFTmgHJnZrayuU7y/J2ahNf1AM4vICtUhKgmwvv350Luv8SNiNA8VHKj32DVshYXB4cj7aBv1xR+9RFk27OyYiOiVijIcHVNNgxJteoVZWeC+DS3kB5syPXO8pCGW26QAZdlUCxuK+HMZqHSVykAjZslSHlrxvD8HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by baptiste.telenet-ops.be with cmsmtp
	id l1Lo2D00E3EEtj2011Lol3; Thu, 05 Dec 2024 14:20:53 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBmh-000LQu-JF;
	Thu, 05 Dec 2024 14:20:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBmi-00EQdW-Bj;
	Thu, 05 Dec 2024 14:20:48 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Oleg Nesterov <oleg@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] include: Update references to include/asm-<arch>
Date: Thu,  5 Dec 2024 14:20:44 +0100
Message-Id: <541258219b0441fa1da890e2f8458a7ac18c2ef9.1733404444.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733404444.git.geert+renesas@glider.be>
References: <cover.1733404444.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
time ago.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/asm-generic/syscall.h | 2 +-
 include/linux/bitmap.h        | 2 +-
 include/linux/types.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 5a80fe728dc8b6e1..182b039ce5fa100c 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -5,7 +5,7 @@
  * Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
  *
  * This file is a stub providing documentation for what functions
- * asm-ARCH/syscall.h files need to define.  Most arch definitions
+ * arch/ARCH/include/asm/syscall.h files need to define.  Most arch definitions
  * will be simple inlines.
  *
  * All of these functions expect to be called with no locks,
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 262b6596eca5eafe..2026953e2c4ed368 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -23,7 +23,7 @@ struct device;
  *
  * Function implementations generic to all architectures are in
  * lib/bitmap.c.  Functions implementations that are architecture
- * specific are in various include/asm-<arch>/bitops.h headers
+ * specific are in various arch/<arch>/include/asm/bitops.h headers
  * and other arch/<arch> specific files.
  *
  * See lib/bitmap.c for more details.
diff --git a/include/linux/types.h b/include/linux/types.h
index 2d7b9ae8714ce522..1c509ce8f7f616e1 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -43,7 +43,7 @@ typedef unsigned long		uintptr_t;
 typedef long			intptr_t;
 
 #ifdef CONFIG_HAVE_UID16
-/* This is defined by include/asm-{arch}/posix_types.h */
+/* This is defined by arch/{arch}/include/asm/posix_types.h */
 typedef __kernel_old_uid_t	old_uid_t;
 typedef __kernel_old_gid_t	old_gid_t;
 #endif /* CONFIG_UID16 */
-- 
2.34.1


