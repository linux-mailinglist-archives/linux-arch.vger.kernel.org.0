Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98EA32C871
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhCDAtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453108AbhCDAqZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 19:46:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21EAB64E46;
        Thu,  4 Mar 2021 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818745;
        bh=vY63ALyHnCU3yIchUivHVRlQm2FBgsf0ZMsWNzYWYNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsuCQnuBa9AAyugWDPWEuZzkaHeYsQ9oiZqT/mJYbooy8kNXR4c7rRgMosXIyYD0X
         a332T0F0ftDDKXqjJ9kHvmbf/M6Rl1D8Xmf5UyV42X/YqIIreoGkYFjYb6yR2RFrB6
         4HsN5v2vdsLAEZs+JDlWp4wIRHkzrho8N+xaA0s4QwdHrKg039z0GArhR8SptfMxhO
         cCmdxUCEdueq/ww2ZmNAXL8AIxWcmYwucVgJT4t7yN8BvOFSRhVgfCkR/Bbcocx9MN
         pvsamwe4/IMPGjhjVCKCJOwPGka7AGB9VgGnT0aj8jpoVrhaPlr0bYRSLLTl4MOuXt
         8uKFboUwt/ouw==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/3] doc: Update rcu_dereference.rst reference
Date:   Wed,  3 Mar 2021 16:45:41 -0800
Message-Id: <20210304004543.25364-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304004438.GA25271@paulmck-ThinkPad-P72>
References: <20210304004438.GA25271@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Changeset b00aedf978aa ("doc: Convert to rcu_dereference.txt to rcu_dereference.rst")
renamed: Documentation/RCU/rcu_dereference.txt
to: Documentation/RCU/rcu_dereference.rst.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index b2da636..6f3d16d 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -19,7 +19,7 @@ Address Dependency:  When the address of a later memory access is computed
 	 from the value returned by the rcu_dereference() on line 2, the
 	 address dependency extends from that rcu_dereference() to that
 	 "p->a".  In rare cases, optimizing compilers can destroy address
-	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
+	 dependencies.	Please see Documentation/RCU/rcu_dereference.rst
 	 for more information.
 
 	 See also "Control Dependency" and "Data Dependency".
-- 
2.9.5

