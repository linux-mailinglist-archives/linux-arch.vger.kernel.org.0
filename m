Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05FA356679
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347449AbhDGIV0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 04:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244822AbhDGIVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F298561404;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783663;
        bh=njIc+20sXj+3VPI2zRcVud7gtlaSQFSwAA+rzuTprv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHVumoxZ9ldx7bpNpiJo8wRAn+KwA75NjUvMlIpCpN8VWh0YHfx6DB/4aDgrlHxDe
         NlBvgHBH5zYPFM0D2dKo9pzFq/0PHKtFgewluwb2sj5YfVgArcfGsrv9MpV3UFEKok
         c/nXVb7sOAPQ/ds6CizBU1MqV59S5lvUJJRA+EMfNuyCMowzkgqL6ogfLxNreSEDeO
         xNiZ9Cxlx4yOE8OfS7USgZPUCtM2sST1d1gPorxEhYMj9IqCX1YxXyIQoCPm3ZIePX
         N9mtYIKIfJIazP2aHylPpJLT2Iz36zboYaK3ty06EmV6Tlb7qHm2wocvo5Ha41kuz9
         NzuxPW/P90TQQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2e-Q7; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Amol Grover <frextrite@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/19] docs: update rcu_dereference.rst reference
Date:   Wed,  7 Apr 2021 10:20:54 +0200
Message-Id: <ea2236875b0f5159ab07853d78f1e3c2f565a5e7.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changeset b00aedf978aa ("doc: Convert to rcu_dereference.txt to rcu_dereference.rst")
renamed: Documentation/RCU/rcu_dereference.txt
to: Documentation/RCU/rcu_dereference.rst.

Update its cross-reference accordingly.

Fixes: b00aedf978aa ("doc: Convert to rcu_dereference.txt to rcu_dereference.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index b2da6365be63..6f3d16dbf467 100644
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
2.30.2

