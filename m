Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA240146CF2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAWPeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWPeA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:34:00 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9210720684;
        Thu, 23 Jan 2020 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793640;
        bh=h5auAc194P3VII8mHQgj1IfjCspjOIf9RyAgRwfabPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ss67dAAOtvy22KIhAjhOBbyGg+Tw748SW/UJMDq2y7trHkfcNalTtYkIjPMPBxT4m
         8TUAMTGTZJUX8yGmCG74zSxEJYGVHBwNwTti8jZkZc7+aLr4+3FHG0VcjeRtp+N62r
         j89mILXS7z5C1jdTv6zk0jPpw/a3tRKLgeG0sacE=
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
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 03/10] fault_inject: Don't rely on "return value" from WRITE_ONCE()
Date:   Thu, 23 Jan 2020 15:33:34 +0000
Message-Id: <20200123153341.19947-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
References: <20200123153341.19947-1-will@kernel.org>
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
2.25.0.341.g760bfbb309-goog

