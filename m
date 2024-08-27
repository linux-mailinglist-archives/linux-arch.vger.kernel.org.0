Return-Path: <linux-arch+bounces-6650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9400D9604A4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED172B24158
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595119755A;
	Tue, 27 Aug 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QygvRznO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20B14A90;
	Tue, 27 Aug 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748050; cv=none; b=T/zOGLvn7vmhWmRhJr+E0zO5RRGbpfJC0hWR6gVp92NcBW+oU6Aksz5ZsO6Ky8w/rQDDvI9knjPN1HTGx3r5n1pjyw0GCAIL9BWInvZNztxGiAOshoGJXwZlnBoAWo1xZM1emdksSsgVBeUfbsEbX9zDHYrsYkaV4cV3dIQGkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748050; c=relaxed/simple;
	bh=c3GGmSCC/rL+BwfSkV/oF2FhLSOXAKTYTvBpBFXr7hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAp/drilor1A+sHMc3Q+nKWswg5e0Eo1NDmm+Ze/m1fXlWhEpxXr78hh9wAZ9ctYrA2tmlgvfkarWbsy4cSXZKfr5V+3uIZ9dpVS4vZkvK69upNsb1r+P65IXzrRHoRMLo3ul5XZX2Fj8Q3kQSQ/1bpcxhTFaGTr65W+G9k2aUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QygvRznO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E622C8B7AA;
	Tue, 27 Aug 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QygvRznO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724748047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IW+Vsw4CmRgVYu00hgtvuoWLEc9DazJelQLIisOKBM=;
	b=QygvRznOzjb6ammlW/OkHzqQLTdHDvM064QgWZqagqk/HdrFfR7M5tRYoUI4fk9bMp2/pj
	alXklZBSTDzpHVtD6oTy20hZ8DlwO9UHqKCqgE2R5ETBlHUTYlofrDAA4cAPp18XCeLzHI
	54gsHRdK5uRCTiz8RGh9hP0Nrow3//Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70296b46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 08:40:47 +0000 (UTC)
Date: Tue, 27 Aug 2024 10:40:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
Message-ID: <Zs2RCfMgfNu_2vos@zx2c4.com>
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>

I don't love this, but it might be the lesser of evils, so sure, let's
do it.

I think I'll combine these header fixups so that the whole operation is
a bit more clear. The commit is still pretty small. Something like
below:

From 0d9a3d68cd6222395a605abd0ac625c41d4cabfa Mon Sep 17 00:00:00 2001
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Tue, 27 Aug 2024 09:31:47 +0200
Subject: [PATCH] random: vDSO: clean header inclusion in getrandom

Depending on the architecture, building a 32-bit vDSO on a 64-bit kernel
is problematic when some system headers are included.

Minimise the amount of headers by moving needed items, such as
__{get,put}_unaligned_t, into dedicated common headers and in general
use more specific headers, similar to what was done in commit
8165b57bca21 ("linux/const.h: Extract common header for vDSO") and
commit 8c59ab839f52 ("lib/vdso: Enable common headers").

On some architectures this results in missing PAGE_SIZE, as was
described by commit 8b3843ae3634 ("vdso/datapage: Quick fix - use
asm/page-def.h for ARM64"), so define this if necessary, in the same way
as done prior by commit cffaefd15a8f ("vdso: Use CONFIG_PAGE_SHIFT in
vdso/datapage.h").

Removing linux/time64.h leads to missing 'struct timespec64' in
x86's asm/pvclock.h. Add a forward declaration of that struct in
that file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/pvclock.h  |  1 +
 include/asm-generic/unaligned.h | 11 +----------
 include/vdso/helpers.h          |  1 +
 include/vdso/unaligned.h        | 15 +++++++++++++++
 lib/vdso/getrandom.c            | 13 ++++++++-----
 5 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 include/vdso/unaligned.h

diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index 0c92db84469d..6e4f8fae3ce9 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -5,6 +5,7 @@
 #include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>

+struct timespec64;
 /* some helper functions for xen and kvm pv clock sources */
 u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
 u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src);
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index a84c64e5f11e..95acdd70b3b2 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -8,16 +8,7 @@
  */
 #include <linux/unaligned/packed_struct.h>
 #include <asm/byteorder.h>
-
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
-})
-
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
-} while (0)
+#include <vdso/unaligned.h>

 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 73501149439d..3ddb03bb05cb 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -4,6 +4,7 @@

 #ifndef __ASSEMBLY__

+#include <asm/barrier.h>
 #include <vdso/datapage.h>

 static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
new file mode 100644
index 000000000000..eee3d2a4dbe4
--- /dev/null
+++ b/include/vdso/unaligned.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_UNALIGNED_H
+#define __VDSO_UNALIGNED_H
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#endif /* __VDSO_UNALIGNED_H */
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 1281fa3546c2..938ca539aaa6 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -4,15 +4,18 @@
  */

 #include <linux/array_size.h>
-#include <linux/cache.h>
-#include <linux/kernel.h>
-#include <linux/time64.h>
+#include <linux/minmax.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
+#include <vdso/unaligned.h>
 #include <asm/vdso/getrandom.h>
-#include <asm/vdso/vsyscall.h>
-#include <asm/unaligned.h>
 #include <uapi/linux/mman.h>
+#include <uapi/linux/random.h>
+
+#undef PAGE_SIZE
+#undef PAGE_MASK
+#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
+#define PAGE_MASK (~(PAGE_SIZE - 1))

 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
--
2.46.0

