Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77B3D18C1
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhGUU33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGUU33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 485756124C;
        Wed, 21 Jul 2021 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901805;
        bh=K0FZkmUcEZ4/fCLtNhjbMKfDZH5fd8ksaaC0kfTu25I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvAPEYLHTI+7ew1wudLdNWzDhDaSyIOMxl+HH7KhZFHAJ39BqN0bSL8+A5wYFrACd
         H4T6HdKsi+htQ3m44zCMyNB01Uc+LOjzYIoBWozMtgVUZM3OB8xpLt77mpJxOkut2C
         nmdWbep1jt45N7JuiFAZiU4Nh5ON8GzkAlqhejJxqN7e0B/jJ8eETDpaoNeB0dlHg5
         BW4Ft4JgO99TVIqQaHBPr1esIb9TFEi5VV404j/8UIQo905mOLSUDfAUH3sbM8FA6C
         PgZvDM8du/Adv9SosYMN7828FqJEddUhUqy4T71cVreR6qek05iSA/+w5Sq7jI4m+i
         dhCfk42fGFCeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 166675C0A11; Wed, 21 Jul 2021 14:10:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/4] tools/memory-model: Document data_race(READ_ONCE())
Date:   Wed, 21 Jul 2021 14:10:03 -0700
Message-Id: <20210721211003.869892-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is possible to cause KCSAN to ignore marked accesses by applying
__no_kcsan to the function or applying data_race() to the marked accesses.
These approaches allow the developer to restrict compiler optimizations
while also causing KCSAN to ignore diagnostic accesses.

This commit therefore updates the documentation accordingly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Documentation/access-marking.txt          | 49 +++++++++++++------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index fe4ad6d12d24c..a3dcc32e27b44 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -37,7 +37,9 @@ compiler's use of code-motion and common-subexpression optimizations.
 Therefore, if a given access is involved in an intentional data race,
 using READ_ONCE() for loads and WRITE_ONCE() for stores is usually
 preferable to data_race(), which in turn is usually preferable to plain
-C-language accesses.
+C-language accesses.  It is permissible to combine #2 and #3, for example,
+data_race(READ_ONCE(a)), which will both restrict compiler optimizations
+and disable KCSAN diagnostics.
 
 KCSAN will complain about many types of data races involving plain
 C-language accesses, but marking all accesses involved in a given data
@@ -86,6 +88,10 @@ that fail to exclude the updates.  In this case, it is important to use
 data_race() for the diagnostic reads because otherwise KCSAN would give
 false-positive warnings about these diagnostic reads.
 
+If it is necessary to both restrict compiler optimizations and disable
+KCSAN diagnostics, use both data_race() and READ_ONCE(), for example,
+data_race(READ_ONCE(a)).
+
 In theory, plain C-language loads can also be used for this use case.
 However, in practice this will have the disadvantage of causing KCSAN
 to generate false positives because KCSAN will have no way of knowing
@@ -279,19 +285,34 @@ tells KCSAN that data races are expected, and should be silently
 ignored.  This data_race() also tells the human reading the code that
 read_foo_diagnostic() might sometimes return a bogus value.
 
-However, please note that your kernel must be built with
-CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n in order for KCSAN to
-detect a buggy lockless write.  If you need KCSAN to detect such a
-write even if that write did not change the value of foo, you also
-need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.  If you need KCSAN to
-detect such a write happening in an interrupt handler running on the
-same CPU doing the legitimate lock-protected write, you also need
-CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these Kconfig
-options set properly, KCSAN can be quite helpful, although it is not
-necessarily a full replacement for hardware watchpoints.  On the other
-hand, neither are hardware watchpoints a full replacement for KCSAN
-because it is not always easy to tell hardware watchpoint to conditionally
-trap on accesses.
+If it is necessary to suppress compiler optimization and also detect
+buggy lockless writes, read_foo_diagnostic() can be updated as follows:
+
+	void read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", data_race(READ_ONCE(foo)));
+	}
+
+Alternatively, given that KCSAN is to ignore all accesses in this function,
+this function can be marked __no_kcsan and the data_race() can be dropped:
+
+	void __no_kcsan read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", READ_ONCE(foo));
+	}
+
+However, in order for KCSAN to detect buggy lockless writes, your kernel
+must be built with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n.  If you
+need KCSAN to detect such a write even if that write did not change
+the value of foo, you also need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.
+If you need KCSAN to detect such a write happening in an interrupt handler
+running on the same CPU doing the legitimate lock-protected write, you
+also need CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these
+Kconfig options set properly, KCSAN can be quite helpful, although
+it is not necessarily a full replacement for hardware watchpoints.
+On the other hand, neither are hardware watchpoints a full replacement
+for KCSAN because it is not always easy to tell hardware watchpoint to
+conditionally trap on accesses.
 
 
 Lock-Protected Writes With Lockless Reads
-- 
2.31.1.189.g2e36527f23

