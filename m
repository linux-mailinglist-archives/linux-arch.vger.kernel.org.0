Return-Path: <linux-arch+bounces-14112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EABBDCB52
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA24A4EB014
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550030FF39;
	Wed, 15 Oct 2025 06:24:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6E3101A0;
	Wed, 15 Oct 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509444; cv=none; b=JkqJXJtfC5FUAK5zS5samqj1cVjySFlMi6FR/4508iX3wX5D39QIEhTesc0mUvy7wlA5p40e/kRb03iYe8uE64+oJJEohBzoNG5zGScZ1/nI+hvv3j/JJsApcYyBkSSxwjEU+Ug7/r5XlDrztckIDZeBtH4rs+nMxJpeQ7ZeJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509444; c=relaxed/simple;
	bh=OdcQpDjnY6Vkmboyo/9JHZoVVOgKF3OwQ6+J+yCUZ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow/wtuikGWQcyontC0NJE/L8WL16qCuN4qvutsSTbcm22rVxbyBXstcMQq1sxYe7XXA7zl6kCPxCuMMcVduFFRenqDCAQUKjKGoDDqJ5ECEuYfshuNqRHFYZR8pObovEtLWs7/h2Kmv1PL0BOQ1T7GLxb8zg6lKPu9kUU/2nr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpsz17t1760509347t6c7396dc
X-QQ-Originating-IP: +rvgJOymfhQGSFW+gyMHV9XEE53HaMbisGq3cCwjcu8=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:22:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14340811432135975756
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 7/8] vmlinux.lds.h: support conditional KEEP() in linker script
Date: Wed, 15 Oct 2025 14:22:15 +0800
Message-ID: <8BFF520DF61C1BB6+096017ae9362c21b090c1f3c97bbd0fdf305bd27.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MyirvGjpKb1jdp298dlRfLmn+nbhEczkj6ZLOKa2DAhtqOK96soFsuPw
	KAqB/9oS27tYnWz9f2RTJIXuxj17H1envL6I09Ui8Ph603WM54p3wOUFun8ztMV5IweTLWD
	B/gTO3QxAON7LbZqsDbEWboqcQcZi0ce6tLugF81A2eJjezbBBhu0oKXMGC1EZ4k2HuJCoD
	KhCe5TcF6NW3SqGGpWImKhhyPrSPsQsQ+LDX00kLDyKMaOx7vtUA7f8aPDKXIxU0iRFdM8B
	d79UFU56muabpxQMAblM5jo81KJIpGBWOE6Ywt9pseeUd1Bmi60EGsTtTpr0SFtIbHcdwL4
	uMzbWlPwlj3U3MB3+5n19Wxq8v0UMwGpDoX5rDa2PCMGKPFL3kPxZj252SNNQW2iuHfVmOj
	xMP7p7Fw4d1A69+B6m+fSTaI1u4lW4aojvclhoTDuD2Q9kKywqG3pv/b+jR5NQqG1NqMCAc
	fllNA04l3og57zAPpvziRGOhA9QyVwwZjWT4thUxYkQF9RU3ZfXoT3xIxsy+SdeQwu7Vrh0
	2s4Ssxy8ZAhqKAKYDjkjds50THGtR1xsVABsvoOXFbNubhszxOznAcDN2ceK3xwoAeGlZis
	M+sTttGCMq1HE+mC5sDiZI8XyVHNXVAEDTAOQ/2eKX6Yj9QgjgYcxYcuq6sdLoJn4OqbPk5
	R29DODxEj2lzP3FGDwYhcKUUO4RV8hsVUg1mI+OzMT4OErzrqV7R3oxHrwFWcaylB/I9n1k
	GsChY/J7EQelCRm2IrmE482sBsLfqWORgciaNhY/jQ2p6G1EUdOU+8KVCELW9EWcXh+qdAQ
	HrkyUoNRJysImnsBhPQ3ZJc/e8OyBYxd3F21ZsErNiJw7uDQG4MWvMOzHTU+Ue8Mxv+sS+P
	P9b+1E/Ed90w13XbJ4jabDSvV5SBlAtjbMRQv58dLNPNuXYSC0+lFYkSTOwT6adXXWX1ATU
	fG6asPYfbXMPT103mClG0s6M0bcpPWRoT9HiCX7mXefBdlKpip46bWVjgHqYq+loq46hWNl
	hNMlILbryjIKPHmu56
X-QQ-XMRINFO: MYTJVxP1dBxwZFBmm3GDYp0=
X-QQ-RECHKSPAM: 0

Introduce a conditional KEEP() helper, COND_KEEP(), that allows a
section to be kept only if a corresponding NOKEEP_<sec> macro is not
defined. This provides a finer-grained mechanism to control which
sections are protected from garbage collection.

Traditionally, many sections — for example, the exception table and jump
table — are created by .pushsection and wrapped with KEEP() in
vmlinux.lds.h to prevent them from being discarded by the linker, even when
they are not actually referenced. This can block dead code and data
elimination (DCE) when the section is known to be safe to drop.

With COND_KEEP(), architectures or subsystems can safely remove the KEEP()
in cases where the section can be safely garbage-collected.

The implementation adds:
  - __KEEP_ACT_0() / __KEEP_ACT_1() helpers for macro expansion
  - BSEC_MAIN() to handle possible sub-section patterns, such as
    __ex_table.18
  - COND_KEEP() macro, which wraps KEEP() conditionally based on
    __is_defined(NOKEEP_<sec>)

Example usage:

COND_KEEP(alternative, *(.alternative*))

Additionally, move the ___PASTE()/__PASTE() definitions in
include/linux/compiler_types.h out from under the '#ifndef __ASSEMBLY__'
guard so that they are visible to assembly.

No functional change unless NOKEEP_<sec> is defined.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++--
 include/linux/compiler_types.h    |  8 ++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8a9a2e732a65..8bb411ace863 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -51,6 +51,7 @@
  */
 
 #include <asm-generic/codetag.lds.h>
+#include <linux/compiler_types.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -113,14 +114,21 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
+#define BSEC_MAIN(sec) sec sec##.[0-9a-zA-Z_]*
 #else
 #define DATA_MAIN .data .data.rel .data.rel.local
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
 #define BSS_MAIN .bss
 #define SBSS_MAIN .sbss
+#define BSEC_MAIN(sec) sec
 #endif
 
+#define __KEEP_ACT_0(sec) KEEP(sec)
+#define __KEEP_ACT_1(sec) sec
+
+#define COND_KEEP(sec, list) __PASTE(__KEEP_ACT_, __is_defined(NOKEEP_##sec))(list)
+
 /*
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
  * Except GCC 4.9, that feels the need to align on 64 bytes.
@@ -196,12 +204,12 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
 	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
+	COND_KEEP(_sec_, *(BSEC_MAIN(_sec_)))				\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
 	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
+	COND_KEEP(_sec_, *(BSEC_MAIN(_sec_)))				\
 	_label_##_END_ = .;
 
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 59288a2c1ad2..680ba4afbe7d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -79,10 +79,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a,b) a##b
-#define __PASTE(a,b) ___PASTE(a,b)
-
 #ifdef __KERNEL__
 
 /* Attributes */
@@ -425,6 +421,10 @@ struct ftrace_likely_data {
 
 #endif /* __ASSEMBLY__ */
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a, b) a##b
+#define __PASTE(a, b) ___PASTE(a, b)
+
 /*
  * The below symbols may be defined for one or more, but not ALL, of the above
  * compilers. We don't consider that to be an error, so set them to nothing.
-- 
2.43.0


