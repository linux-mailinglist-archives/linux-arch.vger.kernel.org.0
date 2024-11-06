Return-Path: <linux-arch+bounces-8880-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D456C9BF2FF
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C805284DCA
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0A205E18;
	Wed,  6 Nov 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg69Z4SE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE781E0084;
	Wed,  6 Nov 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909706; cv=none; b=bcDXmsA4LsZlx3Ohxi2tA0g+b0iY2jnIb/gK2Pv5fsCfa/m8hDIDDGJEH6k7DkM5IiuLoJC/KaQyNZxGV6PYdIirgdfPOVlnBl1dUt9fAhsKdkCXwxo3SAtgunEW3Is7pBf3NX1OkI8W/qvjF+7y4xIPXTllopJGv7XRofkAV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909706; c=relaxed/simple;
	bh=L1fz5ifwL7RtYFeEDpd0ry1pl5RXPpuE7qAe8htztHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqLvCwsp2aCU0yMzlpUFKORYjuiqz2DjI09/1JgV5Z8Ds2zjthsmzHKrDicvYj3vK/VPCOl6MWris5ij45cC5APdsysZ8X4Twb3HeB1FP6SwGXG1z0bbx+HKmahwxv0YLkFhn5x4tDAUEr4tTTqe0NhMz+0elYrukCRZzs0TI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg69Z4SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C388C4CECC;
	Wed,  6 Nov 2024 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909705;
	bh=L1fz5ifwL7RtYFeEDpd0ry1pl5RXPpuE7qAe8htztHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rg69Z4SEgjr14uUSm8raG4/pBqR96KcGJKeZyT1jCty/ybLeUUY9kVlJ9WxpuGvY2
	 JVRAz0Ve5o8Nq/tPBv1cQl0geGUfCQuoUOrwYQBrrNuZb0yIgNnSKolkr54p0mp8U+
	 8Mmk58lGjlXIssQ9vVRy2gYIkG7r+951nC1RDlfMVEwKE46+OyDmI+qoghj4KnyykC
	 zTcOfB2jVEA1HfGxTCRhm04xEmDuh9sRBn+M0XWXlOGjF2L8iBNtGtUmNqjwO8cEd3
	 QW5s5t+fzIbVXEELqgNo2T/VLiwWgZAOeO2smOMhC90WaFISTshS7lhTEl5JJ6KPW0
	 imFjIcT+ySYeA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] Rename .data.once to .data..once to fix resetting WARN*_ONCE
Date: Thu,  7 Nov 2024 01:14:41 +0900
Message-ID: <20241106161445.189399-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106161445.189399-1-masahiroy@kernel.org>
References: <20241106161445.189399-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b1fca27d384e ("kernel debug: support resetting WARN*_ONCE")
added support for clearing the state of once warnings. However,
it is not functional when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION or
CONFIG_LTO_CLANG is enabled, because .data.unlikely matches the
.data.[0-9a-zA-Z_]* pattern in the DATA_MAIN macro.

Commit cb87481ee89d ("kbuild: linker script do not match C names unless
LD_DEAD_CODE_DATA_ELIMINATION is configured") was introduced to suppress
the issue for the default CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n case,
providing a minimal fix for stable backporting. We were aware this did
not address the issue for CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y. The
plan was to apply correct fixes and then revert cb87481ee89d. [1]

Seven years have passed since then, yet the #ifdef workaround remains in
place. Meanwhile, commit b1fca27d384e introduced the .data.once section,
and commit dc5723b02e52 ("kbuild: add support for Clang LTO") extended
the #ifdef.

Using a ".." separator in the section name fixes the issue for
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and CONFIG_LTO_CLANG.

[1]: https://lore.kernel.org/linux-kbuild/CAK7LNASck6BfdLnESxXUeECYL26yUDm0cwRZuM4gmaWUkxjL5g@mail.gmail.com/

Fixes: b1fca27d384e ("kernel debug: support resetting WARN*_ONCE")
Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/mmdebug.h           | 6 +++---
 include/linux/once.h              | 4 ++--
 include/linux/once_lite.h         | 2 +-
 include/net/net_debug.h           | 2 +-
 mm/internal.h                     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3c9dc1fd094d..54504013c749 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -359,7 +359,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
 	__start_once = .;						\
-	*(.data.once)							\
+	*(.data..once)							\
 	__end_once = .;							\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 39a7714605a7..d7cb1e5ecbda 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -46,7 +46,7 @@ void vma_iter_dump_tree(const struct vma_iterator *vmi);
 		}							\
 	} while (0)
 #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
-	static bool __section(".data.once") __warned;			\
+	static bool __section(".data..once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
 									\
 	if (unlikely(__ret_warn_once && !__warned)) {			\
@@ -66,7 +66,7 @@ void vma_iter_dump_tree(const struct vma_iterator *vmi);
 	unlikely(__ret_warn);						\
 })
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)	({			\
-	static bool __section(".data.once") __warned;			\
+	static bool __section(".data..once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
 									\
 	if (unlikely(__ret_warn_once && !__warned)) {			\
@@ -77,7 +77,7 @@ void vma_iter_dump_tree(const struct vma_iterator *vmi);
 	unlikely(__ret_warn_once);					\
 })
 #define VM_WARN_ON_ONCE_MM(cond, mm)		({			\
-	static bool __section(".data.once") __warned;			\
+	static bool __section(".data..once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
 									\
 	if (unlikely(__ret_warn_once && !__warned)) {			\
diff --git a/include/linux/once.h b/include/linux/once.h
index bc714d414448..30346fcdc799 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -46,7 +46,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE(func, ...)						     \
 	({								     \
 		bool ___ret = false;					     \
-		static bool __section(".data.once") ___done = false;	     \
+		static bool __section(".data..once") ___done = false;	     \
 		static DEFINE_STATIC_KEY_TRUE(___once_key);		     \
 		if (static_branch_unlikely(&___once_key)) {		     \
 			unsigned long ___flags;				     \
@@ -64,7 +64,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE_SLEEPABLE(func, ...)						\
 	({									\
 		bool ___ret = false;						\
-		static bool __section(".data.once") ___done = false;		\
+		static bool __section(".data..once") ___done = false;		\
 		static DEFINE_STATIC_KEY_TRUE(___once_key);			\
 		if (static_branch_unlikely(&___once_key)) {			\
 			___ret = __do_once_sleepable_start(&___done);		\
diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
index b7bce4983638..27de7bc32a06 100644
--- a/include/linux/once_lite.h
+++ b/include/linux/once_lite.h
@@ -12,7 +12,7 @@
 
 #define __ONCE_LITE_IF(condition)					\
 	({								\
-		static bool __section(".data.once") __already_done;	\
+		static bool __section(".data..once") __already_done;	\
 		bool __ret_cond = !!(condition);			\
 		bool __ret_once = false;				\
 									\
diff --git a/include/net/net_debug.h b/include/net/net_debug.h
index 1e74684cbbdb..4a79204c8d30 100644
--- a/include/net/net_debug.h
+++ b/include/net/net_debug.h
@@ -27,7 +27,7 @@ void netdev_info(const struct net_device *dev, const char *format, ...);
 
 #define netdev_level_once(level, dev, fmt, ...)			\
 do {								\
-	static bool __section(".data.once") __print_once;	\
+	static bool __section(".data..once") __print_once;	\
 								\
 	if (!__print_once) {					\
 		__print_once = true;				\
diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..a23f7b11b760 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -48,7 +48,7 @@ struct folio_batch;
  * when we specify __GFP_NOWARN.
  */
 #define WARN_ON_ONCE_GFP(cond, gfp)	({				\
-	static bool __section(".data.once") __warned;			\
+	static bool __section(".data..once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
 									\
 	if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && !__warned)) { \
-- 
2.43.0


