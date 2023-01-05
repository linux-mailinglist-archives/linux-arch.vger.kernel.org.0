Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4814065E246
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAEBKN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAEBJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765A3056A;
        Wed,  4 Jan 2023 17:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1971AB81980;
        Thu,  5 Jan 2023 01:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB55FC433EF;
        Thu,  5 Jan 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880994;
        bh=BWqPFUcOzk3zqc4HLeT1toRCy9Bsr94f5R2Iqirtebc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/wrTquJO/00KnE4aRJv/uuk255e9SoNQo3kEftNS6bcXNTmMJwU4SLRUtEtsvPdX
         L+u1oK5mfuEVpwQuQ27KHy/KFEylNCmMI9lAAfA0JuFkZCnWBWZJ1BR9thARpyq5VJ
         sdThFfSlSalFjgjHb9wJkGQ3orPKgQV91McRyBvwcO2Ji9QQ+7tbwg4nv624yxtXpJ
         LPAhHa1VTdE6FAXxMXwtmiT209uYQ1KSXgZaGzyS3a0ZAbm3Til+fDuTsATfvWTVYm
         r/5jcPpIjUacqgzoGUhSdNvGNdImBGruPSwHOAAFN9LM+cTssuUlguazBGKQdMGusK
         f3/Fm0yLXboVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62CEC5C05CA; Wed,  4 Jan 2023 17:09:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Parav Pandit <parav@nvidia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/4] locking/memory-barriers.txt: Improve documentation for writel() example
Date:   Wed,  4 Jan 2023 17:09:49 -0800
Message-Id: <20230105010952.1774272-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

The cited commit describes that when using writel(), explicit wmb()
is not needed. wmb() is an expensive barrier. writel() uses the needed
platform specific barrier instead of wmb().

writeX() section of "KERNEL I/O BARRIER EFFECTS" already describes
ordering of I/O accessors with MMIO writes.

Hence add the comment for pseudo code of writel() and remove confusing
text around writel() and wmb().

commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Co-developed-by: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index cc621decd9439..06e14efd8662a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1910,7 +1910,8 @@ There are some more advanced barrier functions:
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
-     DMA capable device.
+     DMA capable device. See Documentation/core-api/dma-api.rst file for more
+     information about consistent memory.
 
      For example, consider a device driver that shares memory with a device
      and uses a descriptor status value to indicate if the descriptor belongs
@@ -1931,22 +1932,21 @@ There are some more advanced barrier functions:
 		/* assign ownership */
 		desc->status = DEVICE_OWN;
 
-		/* notify device of new descriptors */
+		/* Make descriptor status visible to the device followed by
+		 * notify device of new descriptor
+		 */
 		writel(DESC_NOTIFY, doorbell);
 	}
 
-     The dma_rmb() allows us guarantee the device has released ownership
+     The dma_rmb() allows us to guarantee that the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
-
-     See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-     more information on consistent memory.
+     a dma_wmb().
+
+     Note that the dma_*() barriers do not provide any ordering guarantees for
+     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
+     subsection for more information about I/O accessors and MMIO ordering.
 
  (*) pmem_wmb();
 
-- 
2.31.1.189.g2e36527f23

