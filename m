Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21AD20D1C4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgF2Snu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EFBC033C2F;
        Mon, 29 Jun 2020 11:26:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUE-002DyO-De; Mon, 29 Jun 2020 18:26:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 41/41] regset: kill user_regset_copyout{,_zero}()
Date:   Mon, 29 Jun 2020 19:26:28 +0100
Message-Id: <20200629182628.529995-41-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no callers left

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/regset.h | 67 --------------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index d82bb32e434c..facfaf300b44 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -238,44 +238,6 @@ struct user_regset_view {
  */
 const struct user_regset_view *task_user_regset_view(struct task_struct *tsk);
 
-
-/*
- * These are helpers for writing regset get/set functions in arch code.
- * Because @start_pos and @end_pos are always compile-time constants,
- * these are inlined into very little code though they look large.
- *
- * Use one or more calls sequentially for each chunk of regset data stored
- * contiguously in memory.  Call with constants for @start_pos and @end_pos,
- * giving the range of byte positions in the regset that data corresponds
- * to; @end_pos can be -1 if this chunk is at the end of the regset layout.
- * Each call updates the arguments to point past its chunk.
- */
-
-static inline int user_regset_copyout(unsigned int *pos, unsigned int *count,
-				      void **kbuf,
-				      void __user **ubuf, const void *data,
-				      const int start_pos, const int end_pos)
-{
-	if (*count == 0)
-		return 0;
-	BUG_ON(*pos < start_pos);
-	if (end_pos < 0 || *pos < end_pos) {
-		unsigned int copy = (end_pos < 0 ? *count
-				     : min(*count, end_pos - *pos));
-		data += *pos - start_pos;
-		if (*kbuf) {
-			memcpy(*kbuf, data, copy);
-			*kbuf += copy;
-		} else if (__copy_to_user(*ubuf, data, copy))
-			return -EFAULT;
-		else
-			*ubuf += copy;
-		*pos += copy;
-		*count -= copy;
-	}
-	return 0;
-}
-
 static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
 				     const void **kbuf,
 				     const void __user **ubuf, void *data,
@@ -301,35 +263,6 @@ static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
 	return 0;
 }
 
-/*
- * These two parallel the two above, but for portions of a regset layout
- * that always read as all-zero or for which writes are ignored.
- */
-static inline int user_regset_copyout_zero(unsigned int *pos,
-					   unsigned int *count,
-					   void **kbuf, void __user **ubuf,
-					   const int start_pos,
-					   const int end_pos)
-{
-	if (*count == 0)
-		return 0;
-	BUG_ON(*pos < start_pos);
-	if (end_pos < 0 || *pos < end_pos) {
-		unsigned int copy = (end_pos < 0 ? *count
-				     : min(*count, end_pos - *pos));
-		if (*kbuf) {
-			memset(*kbuf, 0, copy);
-			*kbuf += copy;
-		} else if (clear_user(*ubuf, copy))
-			return -EFAULT;
-		else
-			*ubuf += copy;
-		*pos += copy;
-		*count -= copy;
-	}
-	return 0;
-}
-
 static inline int user_regset_copyin_ignore(unsigned int *pos,
 					    unsigned int *count,
 					    const void **kbuf,
-- 
2.11.0

