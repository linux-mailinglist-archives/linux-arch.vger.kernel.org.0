Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6732C870
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhCDAtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453109AbhCDAqZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 19:46:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50B1664E68;
        Thu,  4 Mar 2021 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818745;
        bh=9gdwnfqsC2457dBQy8GQaMstZlLOSamyaKUpu7JI2VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQI2316GZDnn+TcyHzKC6n8RES8Jp2dZd5tXWsoIVI5qotJZn6uXmRFiHI9sj9t6M
         wJSC31nOIuLv2EJnO9+QiUFQ6hzg5JwR8ZXSn/csRWJ/moUB4xZxJsPvtFQ2zCFZL6
         r6MgkCRM+0WuNNyY2UyPNj3cK3BwX1DezBufg6f5LTaktOBTC6pARgDF/qjbiDVuvJ
         NUgvpi4TK2cXgzzJd85HKPItX9thyrvL+0l5pmcQ8KyN7xp+3mtgMRz2vtSbDWHlkh
         F0nHsvcUHAL38aoCLehArTUgPUeoZ16Yd9I1Crr3CHT8uGlC/IItaFcHPyFsb4UAq5
         F3iFZlvmerAxw==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/3] tools/memory-model: Remove reference to atomic_ops.rst
Date:   Wed,  3 Mar 2021 16:45:42 -0800
Message-Id: <20210304004543.25364-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304004438.GA25271@paulmck-ThinkPad-P72>
References: <20210304004438.GA25271@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

atomic_ops.rst was removed by commit f0400a77ebdc ("atomic: Delete
obsolete documentation").
Remove the broken link in tools/memory-model/Documentation/simple.txt.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/simple.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 81e1a0e..4c789ec 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -189,7 +189,6 @@ Additional information may be found in these files:
 
 Documentation/atomic_t.txt
 Documentation/atomic_bitops.txt
-Documentation/core-api/atomic_ops.rst
 Documentation/core-api/refcount-vs-atomic.rst
 
 Reading code using these primitives is often also quite helpful.
-- 
2.9.5

