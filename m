Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AF13743A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgAJQ4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 11:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgAJQ4u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:50 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BFA2072E;
        Fri, 10 Jan 2020 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675409;
        bh=135J+SSbyQIAXby29osr73Ejb0gbQ2jsQHGnN98q/YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=He2XFOmKXv4Q9/l2imLkHmPFwEHXREZbY98P5xTPghu6u6GNU03Tn8ZEUBLgd68m9
         e1Ns8tF5aEwCFAjMmX5sgNlFsejRJbP65wBUi0Qq6z+yoLcoW7SIZmsxMjOh1MOcY/
         DZSwnMe2a6deePG2j8EDW3ljbV4O6TbIKWC+QnXs=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [RFC PATCH 3/8] fault_inject: Don't rely on "return value" from WRITE_ONCE()
Date:   Fri, 10 Jan 2020 16:56:31 +0000
Message-Id: <20200110165636.28035-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's a bit weird that WRITE_ONCE() evaluates to the value it stores and
it's different to smp_store_release(), which can't be used this way.

In preparation for preventing this in WRITE_ONCE(), change the fault
injection code to use a local variable instead.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/fault-inject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca84910b..ce12621b4275 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -106,7 +106,9 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
-			if (!WRITE_ONCE(current->fail_nth, fail_nth - 1))
+			fail_nth--;
+			WRITE_ONCE(current->fail_nth, fail_nth);
+			if (!fail_nth)
 				goto fail;
 
 			return false;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

