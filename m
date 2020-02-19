Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0216480F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBSPOV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=casfs64rdN02B8bwPH1BuCjWJwS6nggyXOFM8ewlVdw=; b=X/c5nIaS7FIp07Oojm9We05S74
        qbM+ZZ5zFQd12phtWbP/rE6wiCi3WjvsTc637+akXf+EvvUvzQec9ejFz++adF/vD7rZG9M1Et0i1
        ZO6yPkx4OUJxTppQyy0JjoJMZg3ZBXtFAIVkpazPi7ly4B3AJwQxBa3Q8wWQMgfz9/UWad82zEOzm
        1fbKW3O37hZ6RXOO0YQ2kAYIs6ZSCEYTPA1dwm2RQ1/hQ2v8XJkItGXd4xcv3HRYU1XjVntcylbGp
        1zfjJwn9VGRF0E4dq0H/Si/XhPkH/8xBh2kHgnSakmMQa/PxC7HOzl8PqueBoX4K9ASwaUfsQfQu9
        5wT5W8/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R3B-00011M-0A; Wed, 19 Feb 2020 15:14:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DFBC30794C;
        Wed, 19 Feb 2020 16:12:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D3DE32B4D7B8D; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.651901321@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is not sanitized
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to ensure poke_int3_handler() is completely self contained --
we call this while we're modifying other text, imagine the fun of
hitting another INT3 -- ensure that everything is without sanitize
crud.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c       |    4 ++--
 arch/x86/kernel/traps.c             |    2 +-
 include/linux/compiler-clang.h      |    7 +++++++
 include/linux/compiler-gcc.h        |    6 ++++++
 include/linux/compiler.h            |    5 +++++
 include/linux/compiler_attributes.h |    1 +
 lib/bsearch.c                       |    2 +-
 7 files changed, 23 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
 	return _stext + tp->rel_addr;
 }
 
-static int notrace patch_cmp(const void *key, const void *elt)
+static int notrace __no_sanitize patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -991,7 +991,7 @@ static int notrace patch_cmp(const void
 }
 NOKPROBE_SYMBOL(patch_cmp);
 
-int notrace poke_int3_handler(struct pt_regs *regs)
+int notrace __no_sanitize poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -496,7 +496,7 @@ dotraplinkage void do_general_protection
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
+dotraplinkage void notrace __no_sanitize do_int3(struct pt_regs *regs, long error_code)
 {
 	if (poke_int3_handler(regs))
 		return;
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -24,6 +24,13 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_feature(undefined_sanitizer)
+#define __no_sanitize_undefined \
+		__atribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -145,6 +145,12 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_attribute(__no_sanitize_undefined__)
+#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#else
+#define __no_sanitize_undefined
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -199,6 +199,7 @@ void __read_once_size(const volatile voi
 	__READ_ONCE_SIZE;
 }
 
+#define __no_kasan __no_sanitize_address
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
@@ -274,6 +275,10 @@ static __always_inline void __write_once
  */
 #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
+#define __no_ubsan __no_sanitize_undefined
+
+#define __no_sanitize __no_kasan __no_ubsan
+
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -41,6 +41,7 @@
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 # define __GCC4_has_attribute___fallthrough__         0
+# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
 #endif
 
 /*
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -28,7 +28,7 @@
  * the key and elements in the array are of the same type, you can use
  * the same comparison function for both sort() and bsearch().
  */
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
+void __no_sanitize *bsearch(const void *key, const void *base, size_t num, size_t size,
 	      cmp_func_t cmp)
 {
 	const char *pivot;


