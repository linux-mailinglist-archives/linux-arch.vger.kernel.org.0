Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C552465B69
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 01:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbhLBAyk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Dec 2021 19:54:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33804 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354948AbhLBAyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2021 19:54:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E5FACE2134;
        Thu,  2 Dec 2021 00:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD60C53FAD;
        Thu,  2 Dec 2021 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638406273;
        bh=UlbTNDEHF+C3yuIFi46Cz29GHjLpNa7mrhwXPFaqKHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpNmicEM3kXcWnFfrzOXwa/MZzAkpnmwCa7Zzf0dIpSKWn02Fg/tdP9uc7hovjPEj
         5RZP2ZfgzxZiJUSSKeeBMbKe3iMH/qR6b6t0Pt4hvhUlwI0bVunmAHDDLIGkwFHsNq
         tVToEEbG58mglGVW2oWIBxPz4PvAGR0aahOPBRg/dUuxJjB747+5II1XdTkmfHRksn
         A031cmpn+dkQLDr7ywCftouh0ZNOWfcRMu/Fd5mmFdtiAkejhrhMT6zfvFXNkPbpQ7
         0ZN0PoY6/n8SWjqt/f5vRYBaXxKyIAcgtXAvuutkYPJQ/hV5SanR6VNUQcJwBZmyNU
         iCpoZ+zIbFsuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E1D95C100F; Wed,  1 Dec 2021 16:51:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/3] tools/memory-model: doc: Describe the requirement of the litmus-tests directory
Date:   Wed,  1 Dec 2021 16:50:52 -0800
Message-Id: <20211202005053.3131071-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
References: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

It's better that we have some "standard" about which test should be put
in the litmus-tests directory because it helps future contributors
understand whether they should work on litmus-tests in kernel or Paul's
GitHub repo. Therefore explain a little bit on what a "representative"
litmus test is.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/README | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9a84c45504ab6..9edd402704c4f 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -195,6 +195,18 @@ litmus-tests
 	are listed in litmus-tests/README.  A great deal more litmus
 	tests are available at https://github.com/paulmckrcu/litmus.
 
+	By "representative", it means the one in the litmus-tests
+	directory is:
+
+		1) simple, the number of threads should be relatively
+		   small and each thread function should be relatively
+		   simple.
+		2) orthogonal, there should be no two litmus tests
+		   describing the same aspect of the memory model.
+		3) textbook, developers can easily copy-paste-modify
+		   the litmus tests to use the patterns on their own
+		   code.
+
 lock.cat
 	Provides a front-end analysis of lock acquisition and release,
 	for example, associating a lock acquisition with the preceding
-- 
2.31.1.189.g2e36527f23

