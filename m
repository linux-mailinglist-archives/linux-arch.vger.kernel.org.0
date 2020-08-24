Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DD250794
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHXS27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgHXS25 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:57 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C12720767;
        Mon, 24 Aug 2020 18:28:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v8 23/28] fs: Handle intra-page faults in copy_mount_options()
Date:   Mon, 24 Aug 2020 19:27:53 +0100
Message-Id: <20200824182758.27267-24-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The copy_mount_options() function takes a user pointer argument but no
size and it tries to read up to a PAGE_SIZE. However, copy_from_user()
is not guaranteed to return all the accessible bytes if, for example,
the access crosses a page boundary and gets a fault on the second page.
To work around this, the current copy_mount_options() implementation
performs two copy_from_user() passes, first to the end of the current
page and the second to what's left in the subsequent page.

On arm64 with MTE enabled, access to a user page may trigger a fault
after part of the buffer in a page has been copied (when the user
pointer tag, bits 56-59, no longer matches the allocation tag stored in
memory). Allow copy_mount_options() to handle such intra-page faults by
resorting to byte at a time copy in case of copy_from_user() failure.

Note that copy_from_user() handles the zeroing of the kernel buffer in
case of error.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---

Notes:
    v6:
    - Simplified logic to fall-back to byte-by-byte if the copy_from_user()
      fails.
    
    v4:
    - Rewrite to avoid arch_has_exact_copy_from_user()
    
    New in v3.

 fs/namespace.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713..32a0b9146757 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3075,7 +3075,7 @@ static void shrink_submounts(struct mount *mnt)
 void *copy_mount_options(const void __user * data)
 {
 	char *copy;
-	unsigned size;
+	unsigned left, offset;
 
 	if (!data)
 		return NULL;
@@ -3084,16 +3084,27 @@ void *copy_mount_options(const void __user * data)
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
 
-	size = PAGE_SIZE - offset_in_page(data);
+	left = copy_from_user(copy, data, PAGE_SIZE);
 
-	if (copy_from_user(copy, data, size)) {
+	/*
+	 * Not all architectures have an exact copy_from_user(). Resort to
+	 * byte at a time.
+	 */
+	offset = PAGE_SIZE - left;
+	while (left) {
+		char c;
+		if (get_user(c, (const char __user *)data + offset))
+			break;
+		copy[offset] = c;
+		left--;
+		offset++;
+	}
+
+	if (left == PAGE_SIZE) {
 		kfree(copy);
 		return ERR_PTR(-EFAULT);
 	}
-	if (size != PAGE_SIZE) {
-		if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
-			memset(copy + size, 0, PAGE_SIZE - size);
-	}
+
 	return copy;
 }
 
