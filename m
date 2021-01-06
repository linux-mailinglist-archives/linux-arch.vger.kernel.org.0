Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4179B2EC26F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbhAFRh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 12:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbhAFRhV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Jan 2021 12:37:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E40B23135;
        Wed,  6 Jan 2021 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954601;
        bh=iu80oI6b2rx6Js3W6vmo0zpakpZ5wNCa6WZk/+mlLSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRBVzM66xVwW4T83qIZ5qil/RjIVBQ9ESR3+52Xj32KGoghLhHqlpyM2KYpMI6xAj
         qD34lk+LjnCl1bzxaIsN1aaqTGzb3MivUecQCjgvSlzyVi2pyD4NnuaW5o36AJlZVH
         t45ykGoXKYwipyMPUa2qpLg+nQ6qcUPbY/baiNXyGHwvHJMAzJTs/Yac5eq4gC3KZ5
         FC3hC80lgf6KzOwinCUoMoA/DXP/W6efnEbKoLcDy+wUXNoeO3vTQgnPlIUKr570+P
         k9Tl8xDVx/QCPqNen22J79sqFG09PIcTjsFteyoz91StKIrm/fd7XpfsBS8Y/Dcmqv
         JBdc84TbfrOPQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] tools/memory-model: Fix typo in klitmus7 compatibility table
Date:   Wed,  6 Jan 2021 09:36:38 -0800
Message-Id: <20210106173638.23741-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173548.GA23664@paulmck-ThinkPad-P72>
References: <20210106173548.GA23664@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

klitmus7 of herdtools7 7.48 or earlier depends on ACCESS_ONCE(),
which was removed in Linux v4.15.
Fix the obvious typo in the table.

Fixes: d075a78a5ab1 ("tools/memory-model/README: Expand dependency of klitmus7")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 39d08d1..9a84c45 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -51,7 +51,7 @@ klitmus7 Compatibility Table
 	============  ==========
 	target Linux  herdtools7
 	------------  ----------
-	     -- 4.18  7.48 --
+	     -- 4.14  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
 	5.6  --       7.56 --
-- 
2.9.5

