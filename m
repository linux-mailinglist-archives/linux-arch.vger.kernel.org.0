Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FB6028FF
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRKGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJRKGH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 06:06:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DBFB2740;
        Tue, 18 Oct 2022 03:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 200F7B81BDD;
        Tue, 18 Oct 2022 10:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F743C433D7;
        Tue, 18 Oct 2022 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666087562;
        bh=Se4Y+0TeENbXtpHzHARFA8PQcUdH2gUw3vZ9M5htukM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFaZ3006EUDZS/Nn2aZ9WFWcp+ADli6qdlNbUXQn6mB6PNOFK0LgXws/HpXEkqlQ/
         OksjTVHBP5LinFtuojNpH03nLz/T2WipdZNu+LbCKZOZshvJaur+1eFlNdNPUzsaTc
         H+D7V5vao1FJjfnVXBHnHlIJa+tNYTrnFW+TS7+qya8SmDcF6lwZPKzvunUIbR2Ts+
         rAj8DF2ciWicyO5SSRU2PB3r7A1PlGSlpAOb5+At0SNIREQPwIsnryIvX/CQJbCduE
         LHdWOKJJJ2RLNz5p6hiIi9q40mIxZYYs8u9ot2ktivoeXkQYsr/fcfJ8tNaw20Ubz/
         3W3YBWrATVSAw==
Date:   Tue, 18 Oct 2022 11:05:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Parav Pandit <parav@nvidia.com>, bagasdotme@gmail.com,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221018100554.GA3112@willie-the-truck>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 17, 2022 at 10:55:00PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> > The cited commit describes that when using writel(), explcit wmb()
> > is not needed. wmb() is an expensive barrier. writel() uses the needed
> > platform specific barrier instead of expensive wmb().
> >
> > Hence update the example to be more accurate that matches the current
> > implementation.
> >
> > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. 
> > MMIO ordering example")
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> I have no objections, though I still don't see a real need to change
> the wording here.

FWIW, I also don't think this change is necessary. If anything, I'd say
we'd be better off _removing_ the text about writel from this section and
extending the reference to the "KERNEL I/O BARRIER EFFECTS" section,
as you could make similar comments about e.g. readb() and subsequent
barriers.

For example, something like the diff below.

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06f80e3785c5..93d9a90b7cfa 100644
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
@@ -1935,18 +1936,15 @@ There are some more advanced barrier functions:
                writel(DESC_NOTIFY, doorbell);
        }
 
-     The dma_rmb() allows us guarantee the device has released ownership
+     The dma_rmb() allows us to guarantee that the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
-
-     See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-     more information on consistent memory.
+     can see it now has ownership.  dma_mb() implies both a dma_rmb() and
+     a dma_wmb().
+
+     Note that the dma_*() barriers do not provide any ordering guarantees for
+     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
+     subsection for more information about I/O accessors and MMIO ordering.
 
  (*) pmem_wmb();
 

