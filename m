Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F516164BC7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSRUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:20:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QTd8tp07eNhPjbukKA+LEnzzWa9t43kN5uiLpBUNZb0=; b=KFt4lYhlQgjwiExZP6P3uJQ+Kt
        CTuZ71CrDD++r8agKV/9Ljd0JZ30+Frn4xz3zuFHSFCE2Sf/wOwde00DlAPgQ0OF1o84zx8jBLYuC
        QjtuBY8Uh9UTXcC3rB3ZWmtr4qhYk0p519g19Oyah7110/yIyUpb+aZYwfaNUDWXGBRvFKHup/Sg6
        w31QqIbgVm1C71s0QtZONoliwaatfWJ9oy1LT/OmggSIJS1KxwNqmnGq8HNOToq1UtGkpXu/REWzB
        MXJkzRcToXoSQmRMBdOY4zmmdWG6XwLr7hKcv2NWP1wDkmLD0vEk7WuMbYsgqz/XgSeVCm6pWchcI
        W08aR/EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4T1E-0006Lh-1T; Wed, 19 Feb 2020 17:20:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4845300606;
        Wed, 19 Feb 2020 18:18:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17DA920AFA9B7; Wed, 19 Feb 2020 18:20:14 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:20:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is
 not sanitized
Message-ID: <20200219172014.GI14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163025.GH18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:

> By inlining everything in poke_int3_handler() (except bsearch :/) we can
> mark the whole function off limits to everything and call it a day. That
> simplicity has been the guiding principle so far.
> 
> Alternatively we can provide an __always_inline variant of bsearch().

This reduces the __no_sanitize usage to just the exception entry
(do_int3) and the critical function: poke_int3_handler().

Is this more acceptible?

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
 	return _stext + tp->rel_addr;
 }
 
-static int notrace __no_sanitize patch_cmp(const void *key, const void *elt)
+static __always_inline int patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -989,7 +989,6 @@ static int notrace __no_sanitize patch_c
 		return 1;
 	return 0;
 }
-NOKPROBE_SYMBOL(patch_cmp);
 
 int notrace __no_sanitize poke_int3_handler(struct pt_regs *regs)
 {
@@ -1024,9 +1023,9 @@ int notrace __no_sanitize poke_int3_hand
 	 * Skip the binary search if there is a single member in the vector.
 	 */
 	if (unlikely(desc->nr_entries > 1)) {
-		tp = bsearch(ip, desc->vec, desc->nr_entries,
-			     sizeof(struct text_poke_loc),
-			     patch_cmp);
+		tp = __bsearch(ip, desc->vec, desc->nr_entries,
+			       sizeof(struct text_poke_loc),
+			       patch_cmp);
 		if (!tp)
 			goto out_put;
 	} else {
--- a/include/linux/bsearch.h
+++ b/include/linux/bsearch.h
@@ -4,7 +4,29 @@
 
 #include <linux/types.h>
 
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp);
+static __always_inline
+void *__bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
+{
+	const char *pivot;
+	int result;
+
+	while (num > 0) {
+		pivot = base + (num >> 1) * size;
+		result = cmp(key, pivot);
+
+		if (result == 0)
+			return (void *)pivot;
+
+		if (result > 0) {
+			base = pivot + size;
+			num--;
+		}
+		num >>= 1;
+	}
+
+	return NULL;
+}
+
+extern void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp);
 
 #endif /* _LINUX_BSEARCH_H */
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -28,27 +28,9 @@
  * the key and elements in the array are of the same type, you can use
  * the same comparison function for both sort() and bsearch().
  */
-void __no_sanitize *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp)
+void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
 {
-	const char *pivot;
-	int result;
-
-	while (num > 0) {
-		pivot = base + (num >> 1) * size;
-		result = cmp(key, pivot);
-
-		if (result == 0)
-			return (void *)pivot;
-
-		if (result > 0) {
-			base = pivot + size;
-			num--;
-		}
-		num >>= 1;
-	}
-
-	return NULL;
+	__bsearch(key, base, num, size, cmp);
 }
 EXPORT_SYMBOL(bsearch);
 NOKPROBE_SYMBOL(bsearch);
