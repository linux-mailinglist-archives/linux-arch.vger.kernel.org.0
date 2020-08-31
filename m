Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039572580D9
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgHaSUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgHaSUk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:40 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14FC2065F;
        Mon, 31 Aug 2020 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898039;
        bh=KTPkncW8zb6koUc0JEX9NBbqnPetDY1epb9U8s2iJJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glvRwh1uOgP+ajrKwGh+7jTI9YD4KAxmOW97GR2rE6AarWXqyH5GGW8pxqGh/0G01
         288YMZfcsJPD67qwr8M1NRqq9K9kzjarV1EaWlydrGaVGCZ/hjqPabygVDUqSVeqJ9
         WXOtwgXo7CA6IZnPnQfzEn/44kMgNwY+pJDYIGEE=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/9] docs: fix references for DMA*.txt files
Date:   Mon, 31 Aug 2020 11:20:29 -0700
Message-Id: <20200831182037.2034-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831182012.GA1965@paulmck-ThinkPad-P72>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we moved those files to core-api, fix references to point
to their newer locations.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 9618633..39a5115 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -546,8 +546,8 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	[*] For information on bus mastering DMA and coherency please read:
 
 	    Documentation/driver-api/pci/pci.rst
-	    Documentation/DMA-API-HOWTO.txt
-	    Documentation/DMA-API.txt
+	    Documentation/core-api/dma-api-howto.rst
+	    Documentation/core-api/dma-api.rst
 
 
 DATA DEPENDENCY BARRIERS (HISTORICAL)
@@ -1932,7 +1932,7 @@ There are some more advanced barrier functions:
      here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for more
      information on consistent memory.
 
  (*) pmem_wmb();
-- 
2.9.5

