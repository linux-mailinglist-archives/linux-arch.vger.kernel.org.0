Return-Path: <linux-arch+bounces-8538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A49AFE7D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B5285183
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76A1DD0C3;
	Fri, 25 Oct 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oToK9ZTc"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297C1D3633;
	Fri, 25 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849278; cv=none; b=eNp/6kIeYXIPt8IvBRnminlSrw5TRnvPau+jLwiMwDa9Aix/WpldB35vy/Bq+uw8upMnVIokkgewTi0enwcxGRq6Z4qSZvrnih31IAgfK688sjwMZWCPuNaXRzju9F69B2LJtfiiAVHmwY0CbG2//PsqGr4blKBb6qCcRO64IoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849278; c=relaxed/simple;
	bh=sXXkT7pRvKDIBsE6m3hBBKOdqF8sUJ05K7oWBaA6SwI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EqQxQP8rHC+bBBrG2AypXsQjZlU/tM8lkwIbH+XklkSZexsMcNVdzD4QkK5DgikVCs8+AyDek96v6Wg0rxQbZ4VSCiSlMjOdF0ca4JHqOWrFAM198tG9N64PGjcuNMhGtdtFCxEJMAAB/hqz545W9zcugAsbF+HoyicB/3ZaFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oToK9ZTc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=dbMjdL9P+u2qdFG5YZQzJ7hdT9tBr5pG921aWEix044=; b=oToK9ZTcwKqnYN5RC0kkFefevU
	u8/ilYOenOsPM+FVeWvDHPVxcg4GGhL6k6STW5NP7C9ct6oVDyUl76zIlqlnzLWUBUkJwh89WFj7Q
	5XoeELdhk1ILEt2BpbvKy9ZschyFkZsKVD1/SWt707/NGdhazJYXZP7lmTBDuBWBZX+dxZghMUjIu
	soy3pCQ3Jo0kqETLQTyhcOX7TsZEFBb6dJhn04uR/LOTn/nyWxdHHxFlw8/P6zSIBS+wVR6aqZu6z
	ReO4sVqRqBLg0ND9nBe1PXNugWLsBasiG0DRiZKxiKN/M5TGkEehurCM7uqSL5D9qs1MXVLEGrose
	SG7oVy5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoU-00000008sa9-1l5D;
	Fri, 25 Oct 2024 09:41:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DA229301D03; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025093944.707639534@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com,
 hch@infradead.org,
 lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>,
 linux-api@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arch@vger.kernel.org,
 malteskarupke@web.de,
 cl@linux.com,
 llong@redhat.com
Subject: [PATCH 4/6] futex: Enable FUTEX2_{8,16}
References: <20241025090347.244183920@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

When futexes are no longer u32 aligned, the lower offset bits are no
longer available to put type info in. However, since offset is the
offset within a page, there are plenty bits available on the top end.

After that, pass flags into futex_get_value_locked() for WAIT and
disallow FUTEX2_SIZE_U64 instead of mandating FUTEX2_SIZE_U32.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/futex.h   |   11 ++++++-----
 kernel/futex/core.c     |    9 +++++++++
 kernel/futex/futex.h    |    4 ++--
 kernel/futex/waitwake.c |    5 +++--
 4 files changed, 20 insertions(+), 9 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -16,18 +16,19 @@ struct task_struct;
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
  *
- * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
- * We use the two low order bits of offset to tell what is the kind of key :
+ * offset is the position within a page and is in the range [0, PAGE_SIZE).
+ * The high bits of the offset indicate what kind of key this is:
  *  00 : Private process futex (PTHREAD_PROCESS_PRIVATE)
  *       (no reference on an inode or mm)
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
  *       (but private mapping on an mm, and reference taken on it)
-*/
+ */
 
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    (PAGE_SIZE << 0)
+#define FUT_OFF_MMSHARED (PAGE_SIZE << 1)
+#define FUT_OFF_SIZE	 (PAGE_SIZE << 2)
 
 union futex_key {
 	struct {
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -313,6 +313,15 @@ int get_futex_key(void __user *uaddr, un
 	}
 
 	/*
+	 * Encode the futex size in the offset. This makes cross-size
+	 * wake-wait fail -- see futex_match().
+	 *
+	 * NOTE that cross-size wake-wait is fundamentally broken wrt
+	 * FLAGS_NUMA.
+	 */
+	key->both.offset |= FUT_OFF_SIZE * (flags & FLAGS_SIZE_MASK);
+
+	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
 	 * virtual address, we dont even have to find the underlying vma.
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -81,8 +81,8 @@ static inline bool futex_flags_valid(uns
 			return false;
 	}
 
-	/* Only 32bit futexes are implemented -- for now */
-	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
+	/* 64bit futexes aren't implemented -- yet */
+	if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
 		return false;
 
 	/*
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -449,11 +449,12 @@ int futex_wait_multiple_setup(struct fut
 
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
+		unsigned int flags = vs[i].w.flags;
 		struct futex_q *q = &vs[i].q;
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+		ret = futex_get_value_locked(&uval, uaddr, flags);
 
 		if (!ret && uval == val) {
 			/*
@@ -621,7 +622,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
+	ret = futex_get_value_locked(&uval, uaddr, flags);
 
 	if (ret) {
 		futex_q_unlock(*hb);



