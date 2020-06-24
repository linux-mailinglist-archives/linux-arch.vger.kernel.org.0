Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA373207AE8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405741AbgFXRxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405519AbgFXRxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 13:53:34 -0400
Received: from localhost.localdomain (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D472078E;
        Wed, 24 Jun 2020 17:53:32 +0000 (UTC)
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
Subject: [PATCH v5 20/25] fs: Handle intra-page faults in copy_mount_options()
Date:   Wed, 24 Jun 2020 18:52:39 +0100
Message-Id: <20200624175244.25837-21-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624175244.25837-1-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The copy_mount_options() function takes a user pointer argument but no
size. It tries to read up to a PAGE_SIZE. However, copy_from_user() is
not guaranteed to return all the accessible bytes if, for example, the
access crosses a page boundary and gets a fault on the second page. To
work around this, the current copy_mount_options() implementation
performs two copy_from_user() passes, first to the end of the current
page and the second to what's left in the subsequent page.

On arm64 with MTE enabled, access to a user page may trigger a fault
after part of the buffer has been copied (when the user pointer tag,
bits 56-59, no longer matches the allocation tag stored in memory).
Allow copy_mount_options() to handle such intra-page faults by returning
-EFAULT only if the first copy_from_user() has not copied any bytes.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Notes:
    v4:
    - Rewrite to avoid arch_has_exact_copy_from_user()
    
    New in v3.

 fs/namespace.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d..5b6a9c459674 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3074,7 +3074,7 @@ static void shrink_submounts(struct mount *mnt)
 void *copy_mount_options(const void __user * data)
 {
 	char *copy;
-	unsigned size;
+	unsigned size, left;
 
 	if (!data)
 		return NULL;
@@ -3085,12 +3085,30 @@ void *copy_mount_options(const void __user * data)
 
 	size = PAGE_SIZE - offset_in_page(data);
 
-	if (copy_from_user(copy, data, size)) {
+	/*
+	 * Attempt to copy to the end of the first user page. On success,
+	 * left == 0, copy the rest from the second user page (if it is
+	 * accessible). copy_from_user() will zero the part of the kernel
+	 * buffer not copied into.
+	 *
+	 * On architectures with intra-page faults (arm64 with MTE), the read
+	 * from the first page may fail after copying part of the user data
+	 * (left > 0 && left < size). Do not attempt the second copy in this
+	 * case as the end of the valid user buffer has already been reached.
+	 * Ensure, however, that the second part of the kernel buffer is
+	 * zeroed.
+	 */
+	left = copy_from_user(copy, data, size);
+	if (left == size) {
 		kfree(copy);
 		return ERR_PTR(-EFAULT);
 	}
 	if (size != PAGE_SIZE) {
-		if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
+		if (left == 0)
+			/* return not relevant, just silence the compiler */
+			left = copy_from_user(copy + size, data + size,
+					      PAGE_SIZE - size);
+		else
 			memset(copy + size, 0, PAGE_SIZE - size);
 	}
 	return copy;
