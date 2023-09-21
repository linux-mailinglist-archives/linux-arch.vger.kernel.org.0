Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7127AA162
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjIUVB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjIUVAp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 17:00:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91360CED;
        Thu, 21 Sep 2023 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VKJKCEoQ1nLjQTGj7aDgXUUoO0zX5xQmBknHqQ6BznE=; b=baKpYuHLSmJ9uYf4K8v6oWKO7Y
        G65KSJ77kjdyX2mFBZf5Y7c6NFgdRZ6791S1Kp0AUwc9UhOBiJ8HL0N3SS9YHYm0n4fhOEjaPi1vr
        ZOWeeo7i/0BHA3TN69fHpw67Kd2U1qgOyQcO3HQP6Ma8iof5/CefvtyQajf4LWtcrEZBmPKvvwCw5
        JYU6nsPgT5YBRWiHU8Qkemsm7JNKI832z6usnWl1C3miAT4UdGsfqXCZblUK1I5UclwJ9RiBplshu
        bqZAXJjBGyRuLDii4mdLgTimTmVYrxwBWRXil+QYC6JViXcO35MXwe8Xi3pNYAtv/6M1s1wNsftXW
        0ya/YDfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjHQK-00BToR-Lr; Thu, 21 Sep 2023 11:00:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id D2EEC3002E3; Thu, 21 Sep 2023 13:00:42 +0200 (CEST)
Message-Id: <20230921104505.717750284@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:05 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v3 00/15] futex: More futex2 bits
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

New version of the futex2 patches. Futex2 is a new interface to the same 'old'
futex core. An attempt to get away from the multiplex syscall and add a little
room for extentions.

Changes since v2:
 - Rebased to v6.6-rc
 - New FUTEX_STRICT flag (Andre)
 - Reordered futex_size() helper (tglx)
 - Updated some comments (tglx)
 - Folded some tags

My plan is to push the first 10 patches (all the syscalls) into
tip/locking/core this afternoon. All those patches have plenty review tags
including from Thomas who is the actual maintainer of this lot :-)

This should be plenty for Jens to get a move on with the io-uring stuff.

I'm holding off on the NUMA bits for now, because I want to write some
userspace for it since there is some confusion on that -- but I seem to keep
getting side-tracked :/

Patches also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/futex

Where the locking/core thing is the first 10 patches only, and barring Link
tags (which I'll harvest from this posting), will be what I'll push out to tip.

