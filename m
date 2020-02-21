Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74E167F2C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBUNup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgBUNuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5AyjO8/p/IHAiXYU/C/ytpA6Kvh8M/Wo2RCxkIwu+aM=; b=Zps7KEfOo5wH1Jp8lzw/3np0Mm
        XIxKMt3m4sMgaGCL11Y98df3Y46lun4vaK0jUQsSYeWQFjwQhCVvhDZBri4TpDlJiHOllzDFU7Q+O
        zeRXYQNIr6GgmfXs9snhm0ndtDWvGq9EoxcfCS2QH/B1aQxhPzNOwkKPpdHO5nnhq/VUJIXZ857OE
        cxi9m+eyAA4cwqeIBff72SGjZozv/9020e7ptzo8+HOJkGZ6svEVdiquslFaWYM2kR2fRUB2rYtEH
        dAeRuegamTKm3HXhtTg+f/vRGTiCER4brs7qpXT8YhfVAyokfEi0CbMmajM0JbdZzfdCm3K9uHH2t
        jjZ22XgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0006VI-Vq; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C1FD307842;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 419AA29D740B8; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.747377168@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 25/27] lib/bsearch: Provide __always_inline variant
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For code that needs the ultimate performance (it can inline the @cmp
function too) or simply needs to avoid calling external functions for
whatever reason, provide an __always_inline variant of bsearch().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    9 ++++-----
 include/linux/bsearch.h       |   26 ++++++++++++++++++++++++--
 lib/bsearch.c                 |   22 ++--------------------
 3 files changed, 30 insertions(+), 27 deletions(-)

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
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
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
+	return __bsearch(key, base, num, size, cmp);
 }
 EXPORT_SYMBOL(bsearch);
 NOKPROBE_SYMBOL(bsearch);


