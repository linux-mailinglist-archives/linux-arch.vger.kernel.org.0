Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4025228CE11
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 14:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgJMMQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 08:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgJMMO5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FF722267;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=+icd9iFPfE9J69QdGJrm2iSgwufEUYZ3m5WGuFBDVpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDw8yCvtLiM/RembAAMMAuxGs0XaIYzWjgBMGQ9wHi2ZCAclrmvx/cqKwdiy11z0y
         wazBRry5r9/H1DvO0P8BBnfq3QSGt6FFwyKKf+ym2OasG4UswI4dzp+luJb6cw0sHg
         JCCH0x5Vd0eKeo9TIt22OwhnNdkcqqsHb3hbiqKo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006Cnt-NS; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Subject: [PATCH v2 02/24] tools: docs: memory-model: fix references for some files
Date:   Tue, 13 Oct 2020 14:14:29 +0200
Message-Id: <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

- The sysfs.txt file was converted to ReST and renamed;
- The control-dependencies.txt is not at
  Documentation/control-dependencies.txt. As it is at the
  same dir as the README file, which mentions it, just
  remove Documentation/.

With that, ./scripts/documentation-file-ref-check script
is now happy again for files under tools/.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/memory-model/Documentation/README       | 2 +-
 tools/memory-model/Documentation/ordering.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 16177aaa9752..004969992bac 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -55,7 +55,7 @@ README
 Documentation/cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 
-Documentation/control-dependencies.txt
+control-dependencies.txt
 	A guide to preventing compiler optimizations from destroying
 	your control dependencies.
 
diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
index 3d020bed8585..629b19ae64a6 100644
--- a/tools/memory-model/Documentation/ordering.txt
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -346,7 +346,7 @@ o	Accessing RCU-protected pointers via rcu_dereference()
 
 	If there is any significant processing of the pointer value
 	between the rcu_dereference() that returned it and a later
-	dereference(), please read Documentation/RCU/rcu_dereference.txt.
+	dereference(), please read Documentation/RCU/rcu_dereference.rst.
 
 It can also be quite helpful to review uses in the Linux kernel.
 
-- 
2.26.2

