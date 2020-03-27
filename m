Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6195196203
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgC0Xbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35906 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKO-Ge; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 05/14] ia64: csum_partial_copy_nocheck(): don't abuse csum_partial_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:08 +0000
Message-Id: <20200327233117.1031393-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Just inline the call and use memcpy() instead of __copy_from_user() and
note that the tail is precisely ia64 csum_partial().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/lib/csum_partial_copy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index bf9396b1ed32..9ab570d0f756 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -134,8 +134,8 @@ EXPORT_SYMBOL(csum_partial_copy_from_user);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 {
-	return csum_partial_copy_from_user((__force const void __user *)src,
-					   dst, len, sum, NULL);
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
 }
 
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-- 
2.11.0

