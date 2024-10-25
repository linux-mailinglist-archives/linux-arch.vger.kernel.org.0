Return-Path: <linux-arch+bounces-8540-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C09AFE83
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E65285885
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC11DE2C2;
	Fri, 25 Oct 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHf3VaB+"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B51D90B4;
	Fri, 25 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849279; cv=none; b=fbdrSYqf4iiGeW3vi6NGAsWoQ4QPLuK9S8I2qPen0sT32MxmKh6ApGOyS75Dx/Y8PgBF4YRPTRG3B85k7LiZA4EEd0lxtELL6MnQGD3/RvNp69+TSX78sUd9mq5jxp96g/8Zvjbi4mQJ97a1/77aj8oyhFdclB9+n6jbnSekE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849279; c=relaxed/simple;
	bh=WKchFVXnj6SKM18yijVrqOA+u2bmi/cCI+xywo0KwFk=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=URTjYbtGYGr/TxY6vKJqLq9U3ysXyfjcSaWFWw/9Tdl11Hgmlas7Zt9OCJyFbLq/tTOJ48ot10zXLPQnwhWFsGdM7ptpBRZ9qlQcaTZc6lREhtDb2hxok45pdqNeDIXqwsHmJ4xJ11WB/qwWqTadQJMCQ6GJ60rPJNrZw+eGLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mHf3VaB+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=U0D/97Jan/1h5/mHQt4BdsZRHtXtzjdUFE/GVa1R21M=; b=mHf3VaB+HmQHmxesCbnKkAMi2d
	sZG3k9IRWCQW3O2HIyPWhAEPdZw/T3W1b/yG1wTuewo6QaSkAYvR++sMpfAZVuGx3gAFXcYqQzSQT
	j4xVtIecla88uLIdFVu1LiFvwB4Cq782IvCH+uJzMi+7MndvdPq+OAGDQKLipcXDSxxMKBmDn/vdg
	hZG4GTC4vYB7tQPNZKR62OMPaydbPwqbxB3+jfYTpnV+ZwwlH3kRgwWBYGKfLduwn6uwoNeHSNsHi
	bSqf1vVyNKE51O8hMxkxgID8XJZpxqWOz/FjDNFHXb7tgBbBOe6zscEWeuaj1ox6NMer/4J3zvV/9
	pd4m9big==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoU-00000008sa8-1mSU;
	Fri, 25 Oct 2024 09:40:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D5DAD301171; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025093944.598921704@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:50 +0200
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
Subject: [PATCH 3/6] futex: Propagate flags into futex_get_value_locked()
References: <20241025090347.244183920@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to facilitate variable sized futexes propagate the flags into
futex_get_value_locked().

No functional change intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/core.c     |    4 ++--
 kernel/futex/futex.h    |    2 +-
 kernel/futex/pi.c       |    8 ++++----
 kernel/futex/requeue.c  |    4 ++--
 kernel/futex/waitwake.c |    4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -528,12 +528,12 @@ int futex_cmpxchg_value_locked(u32 *curv
 	return ret;
 }
 
-int futex_get_value_locked(u32 *dest, u32 __user *from)
+int futex_get_value_locked(u32 *dest, u32 __user *from, unsigned int flags)
 {
 	int ret;
 
 	pagefault_disable();
-	ret = __get_user(*dest, from);
+	ret = futex_get_value(dest, from, flags);
 	pagefault_enable();
 
 	return ret ? -EFAULT : 0;
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -239,7 +239,7 @@ extern void futex_wake_mark(struct wake_
 
 extern int fault_in_user_writeable(u32 __user *uaddr);
 extern int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32 uval, u32 newval);
-extern int futex_get_value_locked(u32 *dest, u32 __user *from);
+extern int futex_get_value_locked(u32 *dest, u32 __user *from, unsigned int flags);
 extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *key);
 
 extern void __futex_unqueue(struct futex_q *q);
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -240,7 +240,7 @@ static int attach_to_pi_state(u32 __user
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -359,7 +359,7 @@ static int handle_exit_race(u32 __user *
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (futex_get_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -527,7 +527,7 @@ int futex_lock_pi_atomic(u32 __user *uad
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (futex_get_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -750,7 +750,7 @@ static int __fixup_pi_state_owner(u32 __
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
 
-	err = futex_get_value_locked(&uval, uaddr);
+	err = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 	if (err)
 		goto handle_err;
 
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -275,7 +275,7 @@ futex_proxy_trylock_atomic(u32 __user *p
 	u32 curval;
 	int ret;
 
-	if (futex_get_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex, FLAGS_SIZE_32))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -453,7 +453,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = futex_get_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1, FLAGS_SIZE_32);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -453,7 +453,7 @@ int futex_wait_multiple_setup(struct fut
 		u32 val = vs[i].w.val;
 
 		hb = futex_q_lock(q);
-		ret = futex_get_value_locked(&uval, uaddr);
+		ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 		if (!ret && uval == val) {
 			/*
@@ -621,7 +621,7 @@ int futex_wait_setup(u32 __user *uaddr,
 retry_private:
 	*hb = futex_q_lock(q);
 
-	ret = futex_get_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr, FLAGS_SIZE_32);
 
 	if (ret) {
 		futex_q_unlock(*hb);



