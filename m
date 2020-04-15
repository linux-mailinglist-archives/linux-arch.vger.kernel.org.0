Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E851D1AB13F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411784AbgDOTIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416864AbgDOStt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005B221582;
        Wed, 15 Apr 2020 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976589;
        bh=fIORlCQbxBxgk9voZ1LkLthTTqwXiwUQiuX5p9e4JlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcRlQFeqt483Xm7uouJHrzfgYsFxlmBy049Ay8Q8CPa6F2sUgOOamMvv5SApXu/ZY
         D5IQDTBUJY6WzgSGlkfc5CdcmnafzWC3NvjDOoIYLS+8O0HeBYoEm4AxMDckDg9u3b
         +Vo/U9k3+TVQibMHkyaw+zT6Lw7V+YpNMjJB/qFs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lkmm tip/core/rcu 08/10] Documentation/litmus-tests: Introduce atomic directory
Date:   Wed, 15 Apr 2020 11:49:43 -0700
Message-Id: <20200415184945.16487-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Although we have atomic_t.txt and its friends to describe the semantics
of atomic APIs and lib/atomic64_test.c for build testing and testing in
UP mode, the tests for our atomic APIs in real SMP mode are still
missing. Since now we have the LKMM tool in kernel and litmus tests can
be used to generate kernel modules for testing purpose with "klitmus" (a
tool from the LKMM toolset), it makes sense to put a few typical litmus
tests into kernel so that

1)	they are the examples to describe the conceptual mode of the
	semantics of atomic APIs, and

2)	they can be used to generate kernel test modules for anyone
	who is interested to test the atomic APIs implementation (in
	most cases, is the one who implements the APIs for a new arch)

Therefore, introduce the atomic directory for this purpose. The
directory is maintained by the LKMM group to make sure the litmus tests
are always aligned with our memory model.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/atomic/README | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 Documentation/litmus-tests/atomic/README

diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
new file mode 100644
index 0000000..ae61201
--- /dev/null
+++ b/Documentation/litmus-tests/atomic/README
@@ -0,0 +1,4 @@
+This directory contains litmus tests that are typical to describe the semantics
+of our atomic APIs. For more information about how to "run" a litmus test or
+how to generate a kernel test module based on a litmus test, please see
+tools/memory-model/README.
-- 
2.9.5

