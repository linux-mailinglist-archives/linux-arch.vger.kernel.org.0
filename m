Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727A6137431
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgAJQ4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 11:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgAJQ4p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:45 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B9920721;
        Fri, 10 Jan 2020 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675404;
        bh=4nVI30gKryW63hLtZQ4pIBrmPzl/yd4sdMuuHmRHkD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubqczTcX2w73nHNzdZZqcmMn1Bl482OS8axtgQHMS9EalHO7PdFYszzyYDhn7MjSO
         6cMFkzD6bOSEqBIEeFyqmxH/sKhjzlY10OTQF6c2NXk8dmVmQWNhKC4TGQgEkREkkh
         KQdzij/G1jPYzm2m6R7Twb+zXyE4MT/j2wavyDTE=
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
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC prior to version 4.8
Date:   Fri, 10 Jan 2020 16:56:29 +0000
Message-Id: <20200110165636.28035-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
discarding the 'volatile' qualifier:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

We've been working around this using some nasty hacks which make
READ_ONCE() both horribly complicated and also prevent us from enforcing
that it is only used on scalar types. Since GCC 4.8 is pretty old for
kernel builds now, emit a warning if we detect it during the build.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..62afe874073e 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -14,6 +14,10 @@
 # error Sorry, your compiler is too old - please upgrade it.
 #endif
 
+#if GCC_VERSION < 40800
+# warning Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.
+#endif
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
-- 
2.25.0.rc1.283.g88dfdc4193-goog

