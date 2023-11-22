Return-Path: <linux-arch+bounces-408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B777F5338
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11D11F20C74
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CB1F947;
	Wed, 22 Nov 2023 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4Yov3+O"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052781F60A;
	Wed, 22 Nov 2023 22:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A14C433C8;
	Wed, 22 Nov 2023 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691504;
	bh=OEYsi17tOKR7Yn0RX96OmFEl8yOfWLgmEUuZLjzMjVw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d4Yov3+O5pJZYtO+vAquTnBX0iikeSqBxlGU2Gli2xi78IA03yNmk9fyQbbo1bUKy
	 USXCZ0TgaqwsYqNgrN9RxOE/iLncTbx6jFokMFv7xi/puqkUnVBny2fLDJBlzBjEgd
	 VNMknv62dWvQ4bduSYJIvxhYEqiyoAS68ikNdyJpKg5B1sqD0cEJntPOZX6eTEuKXm
	 H4LAl9o7KqFrHVXUFXpSkYn/yymkDBfZhVFzA4Aj9+5xP4PT/dZK6VG4Q6yJvGVmw5
	 PMhCtOZQzVPwHjoc+itTW0E6Qq+o2h8hFh4Yxo+ORbInR5eRhdlSP8Xw7NPsKYQ9MW
	 im5YtndDD/e3Q==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] vmlinux.lds.h: Fix alignment for __ksymtab*, __kcrctab_* and .pci_fixup sections
Date: Wed, 22 Nov 2023 23:18:13 +0100
Message-ID: <20231122221814.139916-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
(e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
64-bit pointers into the __ksymtab* sections.
Make sure that the start of those sections is 64-bit aligned in the vmlinux
executable, otherwise unaligned memory accesses may happen at runtime.

The __kcrctab* sections store 32-bit entities, so make those sections
32-bit aligned.

The pci fixup routines want to be 64-bit aligned on 64-bit platforms
which don't define CONFIG_HAVE_ARCH_PREL32_RELOCATIONS. An alignment
of 8 bytes is sufficient to guarantee aligned accesses at runtime.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 include/asm-generic/vmlinux.lds.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..fa4335346e7d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -467,6 +467,7 @@
 	}								\
 									\
 	/* PCI quirks */						\
+	. = ALIGN(8);							\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_early,  __start, __end) \
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_header, _pci_fixups_header, __start, __end) \
@@ -484,6 +485,7 @@
 	PRINTK_INDEX							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
+	. = ALIGN(8);							\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
@@ -491,6 +493,7 @@
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
+	. = ALIGN(8);							\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
 		__start___ksymtab_gpl = .;				\
 		KEEP(*(SORT(___ksymtab_gpl+*)))				\
@@ -498,6 +501,7 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
+	. = ALIGN(4);							\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
@@ -505,6 +509,7 @@
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
+	. = ALIGN(4);							\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
 		__start___kcrctab_gpl = .;				\
 		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-- 
2.41.0


