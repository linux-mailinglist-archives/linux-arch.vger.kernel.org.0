Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27A2580DA
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgHaSUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbgHaSUk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:40 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51F720E65;
        Mon, 31 Aug 2020 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898040;
        bh=SNSttJdpfWdR+2Zv+5g7ieu37LT228fIydquiaTZ/J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfzYkun2rT/QlYb0e3d7Ta1/lcsK/EqOjrfeCCLPR/5mz9mtG3e76E8an/K0zBFTk
         AeQBMhI/iAKiYCWEHUwkt1+BCCXSLjb1D8ZDIAMD3kZki6uRPOxY7QI00W9CLZgDhE
         ERJxZAK+KdWgzuBq0zeG4GONHgc9i8+UQcm6fRO4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/9] Replace HTTP links with HTTPS ones: LKMM
Date:   Mon, 31 Aug 2020 11:20:30 -0700
Message-Id: <20200831182037.2034-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/references.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ecbbaa5..c5fdfd1 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -120,7 +120,7 @@ o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
 
 o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
 	semantics of the weak consistency model specification language
-	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
+	cat". CoRR abs/1608.07531 (2016). https://arxiv.org/abs/1608.07531
 
 
 Memory-model comparisons
-- 
2.9.5

