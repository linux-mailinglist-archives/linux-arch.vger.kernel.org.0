Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B58753CD8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjGNOQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjGNOQf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76D1989;
        Fri, 14 Jul 2023 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HW8jsz2GyXNfhVb1jlu8VDTtcMIZFa9q1VNsHdld6PQ=; b=lRL7aZNYsMs5HiLE4UqIN1R97i
        vKfGxMyqrryTTEI+qzS9LkdJoPNbQeg72+9sa5ovK3ExIDXqvzwSkbeNXaSLMax+T88zUzqbx2DAw
        UaIFG0v2ZxZ9TI3k3FfjCn6fc7mzlK3sfR6loxZMbgS3bB/1sm+QPnlEe67Gt+9mLN1Cr+7qw/cfo
        FBt4vU7r/+D/kzdgQqdkRZcHAlcrIC2IznD6JhS5OaYkFQ4uz4rR6hBPx0rPe40ccz1JyxD/ExSBM
        1XgGDYiydelOnL3AHefER6uBgKSDBLvWA/z+lh3IdqvSmB676INv57o+5q7JwovFwcJPNIxcpsK8s
        23w8K6Sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKJah-0016z1-3R; Fri, 14 Jul 2023 14:16:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D1DB3001FD;
        Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 590FE21372892; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714133859.305719029@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:38:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 00/10] futex: More Futex2 bits
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Reviewing Jens' series to add io_uring futex support got me looking at futex
again, and I realized the current flags situation is a mess. After cleaning
that up I decided to continue and implement most of the missing flags for
futex2.

I initially also wanted to add a futex_wait() syscall, but given the amount and
kind of arguments that needs, that's just not going to work on 32bit.
futex_waitv() will have to do for now.

I've not yet done futex_requeue(), that's even worse than futex_wait() and I
think the only option is to do something like:

  sys_futex_requeue(struct futex_waitv __user futexes[2], unsigned int flags, int nr_wake, int nr_requeue)

Where we use struct futex_wativ to specify the two futexes (addr and flags) and
cmp value.

Additionally, robust futexes can fundamentally only support 32bit unless we go
make more lists.

The 'small' futex support is very limited, esp. when combined with FUTEX2_NUMA
mixing sizes is really not an option. The requeue variant above would be able
to specify different sizes for each futex and might just do.

The whole series is *very* lightly tested, as in, it builds and boots, but I've
not yet written a single line of user code to trigger any of the new paths.

Please handle with care etc.. ;-)


Jens, given you do a completely new futex interface, it probably makes more
sense if you use FUTEX2 flags and a u64 value and mask.

I'm hoping this series clarifies that situation a little instead of making it a
worse mess. Many of these things have been brewing over the past several years
but nobody put it all together before.


