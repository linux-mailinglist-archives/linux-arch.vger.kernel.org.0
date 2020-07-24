Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29422BB7D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGXB0v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgGXBZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30465C0619E6;
        Thu, 23 Jul 2020 18:25:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT4-001GcZ-UO; Fri, 24 Jul 2020 01:25:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 06/20] csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
Date:   Fri, 24 Jul 2020 02:25:32 +0100
Message-Id: <20200724012546.302155-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Preparation for the change of calling conventions; right now all
callers pass 0 as initial sum.  Passing 0xffffffff instead yields
the values comparable mod 0xffff and guarantees that 0 will not
be returned on success.

Note that this relies upon the correct behaviour with arbitrary
initial sum and the above pretty much says "it's been untested
with anything other than 0".  Analysis is unpleasant, to put it
mildly, but the suckers _are_ handling it correctly, surprisingly
enough.  Perhaps not too surprisingly, since most of the instances
share the code with csum_partial_copy_nocheck(), which used to get
some testing due to icmp_push_reply()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7405922caaec..d5b7e204fea6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1451,7 +1451,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, 0, &err);
+					       v.iov_len, ~0U, &err);
 		if (!err) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
@@ -1493,7 +1493,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, 0, &err);
+					       v.iov_len, ~0U, &err);
 		if (err)
 			return false;
 		sum = csum_block_add(sum, next, off);
@@ -1539,7 +1539,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 		int err = 0;
 		next = csum_and_copy_to_user((from += v.iov_len) - v.iov_len,
 					     v.iov_base,
-					     v.iov_len, 0, &err);
+					     v.iov_len, ~0U, &err);
 		if (!err) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
-- 
2.11.0

