Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5E1AAECF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410499AbgDOQxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410496AbgDOQxA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:00 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE4820857;
        Wed, 15 Apr 2020 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969580;
        bh=XpbKApHWYMc5/QzVBiMD1ies30gMGiNifJYoWGWxCgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vE6Qg9+U9QSoa/pH3npc1gJMA7o/Z0/taFmWB2Xwep44SEXhrR+m9/SJr/xickOPs
         NHdHB7hnR8Ur/oxMG7SK18wPe3l8IJf1aZIOUDRINncA8smrujVm0IIk4Hj11Xcgpt
         rrAo42qgZo/WQT3OrkNrZ0d//yzMVHBBGgYGyxXA=
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
Subject: [PATCH v3 04/12] fault_inject: Don't rely on "return value" from WRITE_ONCE()
Date:   Wed, 15 Apr 2020 17:52:10 +0100
Message-Id: <20200415165218.20251-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
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
2.26.0.110.g2183baf09c-goog

