Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F223D18C3
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhGUU3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 16:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhGUU33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 421DE61222;
        Wed, 21 Jul 2021 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901805;
        bh=en754w73iFqTn89Z6AhHNd60Ce4arYxw9aIjHkrE69E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4Zlh6JurAtz9AhlNdCGTi6AfqUYPMmN9j9MovAScPSW8OxO3v95wsNVzNU7oJzJO
         l6r8Bmf49Bg4iB2SQkYmOyoHD+boLQH8cRwwcCjgLXuy0hSlisQIc9b8cAeE+Rh/wp
         vlIL/RPvZn1XDVicv+/rgMmyctMulQ/hTEbkqI0fM8w/8B1pBQHz7DCLz/n/A4jWSo
         ibp0AWw3z7BcDhXp40J/DFTeQyeZmEmbxpVlFnG3cdrRytLkXd8B5yCN+9cu1vxMTL
         btckhySf3apIZ53v+5zH/rMaebAaPpk9Ello2GfU/WJYEGjt5vTEEKD+4N4ZUZ67c4
         FIv2s2bdpn1LA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 127345C0A03; Wed, 21 Jul 2021 14:10:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Manfred Spraul <manfred@colorfullife.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/4] tools/memory-model: Heuristics using data_race() must handle all values
Date:   Wed, 21 Jul 2021 14:10:02 -0700
Message-Id: <20210721211003.869892-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>

Data loaded for use by some sorts of heuristics can tolerate the
occasional erroneous value.  In this case the loads may use data_race()
to give the compiler full freedom to optimize while also informing KCSAN
of the intent.  However, for this to work, the heuristic needs to be
able to tolerate any erroneous value that could possibly arise.  This
commit therefore adds a paragraph spelling this out.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index be7d507997cf8..fe4ad6d12d24c 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -126,6 +126,11 @@ consistent errors, which in turn are quite capable of breaking heuristics.
 Therefore use of data_race() should be limited to cases where some other
 code (such as a barrier() call) will force the occasional reload.
 
+Note that this use case requires that the heuristic be able to handle
+any possible error.  In contrast, if the heuristics might be fatally
+confused by one or more of the possible erroneous values, use READ_ONCE()
+instead of data_race().
+
 In theory, plain C-language loads can also be used for this use case.
 However, in practice this will have the disadvantage of causing KCSAN
 to generate false positives because KCSAN will have no way of knowing
-- 
2.31.1.189.g2e36527f23

