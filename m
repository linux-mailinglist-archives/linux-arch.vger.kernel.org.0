Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8785F2F495A
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbhAMLBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 06:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbhAMLBL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C344235E4;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=7SV1Wf2cFeBmyKYHN4PvxFbldMRcWaVnyyuX1AnarXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaTx/lCPLSeff37VJI9Yr0ga83qchFGKD7Df8bbk6VmWbWcoOXlEzQaqmiliPvGmJ
         OMAqdjH6KH6IytBqX5JIVRdTVvYpO9l8f4yL9oiVEHf0KEtITHY/kwV/Vzp+KNbZhI
         uiIzgQ+HPREo63B5roTTnOlzvxeg+1X4EMvnj91ESRAGRdYK7fb49fao/56VsKeJ3a
         M6r9dwMKQ8+u2eMKkzTgvJNv20AejljQ6EruRZo0qZlceQIjsgPFh1Ipg9cuaDyEYV
         O17ofYv0bFFtYitmmkRHfg07C/8PwUhCr8ELzz8T2H7WwM5N9nt1xHjeZ53k5f3FQx
         Zqr6hmOS5G4SA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGh-PF; Wed, 13 Jan 2021 11:59:27 +0100
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
Subject: [PATCH 19/24] doc: update rcu_dereference.rst reference
Date:   Wed, 13 Jan 2021 11:59:20 +0100
Message-Id: <e2293b68eefdd00ea0f4795bc0672ef70f8627e2.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
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
2.29.2

