Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9146DC73D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Apr 2023 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDJN1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Apr 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDJN1S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Apr 2023 09:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68294198C;
        Mon, 10 Apr 2023 06:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FBD612A3;
        Mon, 10 Apr 2023 13:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B1C433EF;
        Mon, 10 Apr 2023 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681133236;
        bh=qbhnpwDlmVtxwvw/RVYbW5QTCvdBnkOBdvaZ/fGpiyc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bsImvCGAWL2UL+gnYUhMqPnnZ9+BlqehqzQaqruXhWc4+bQKHYlUbaCFfkd1uyJJV
         LRFpPOXn1df1cy5s3N2I/hXVNdYoG41K2Cu580+7E/t0yvVzBlhr52ct3Bd9/5aFuJ
         sGzi38Tm5fwwqwKJSnHs7rpJGL+2BllqNAg7v88j7cP+TTYoBD1T0+hP8o//bq/0OQ
         z/w8abW2UoIjOdIaO9uWZJwyYiZ/rcPfaAnT2GF8qCusE5snH1GVfXuNY5qKN+ddrU
         xSgeUHbwft0aWYL9C8rkmHlXf+ykBxJS+A7ZK1lQPdbQevTXHqlMbPklMz7rkTA3pv
         usHd9irM2hZRA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CC4C01540478; Mon, 10 Apr 2023 06:27:15 -0700 (PDT)
Date:   Mon, 10 Apr 2023 06:27:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Alan Stern' <stern@rowland.harvard.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <494d0375-8f8f-42a3-ae9d-468c3be5aadd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
 <470b82a5fca84521a1ae903c15ef992b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470b82a5fca84521a1ae903c15ef992b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 10, 2023 at 10:43:52AM +0000, David Laight wrote:
> From: Alan Stern
> > Sent: 06 April 2023 22:36
> > 
> > Paul:
> > 
> > I just saw that two of the files in tools/memory-model/litmus-tests have
> > almost identical names:
> > 
> > 	Z6.0+pooncelock+pooncelock+pombonce.litmus
> > 	Z6.0+pooncelock+poonceLock+pombonce.litmus
> > 
> > They differ only by a lower-case 'l' vs. a capital 'L'.  It's not at all
> > easy to see, and won't play well in case-insensitive filesystems.
> 
> Change the 'L' to a '1' - that'll be ok on case-insensitive
> filesystems :-)

Or just name them all using SHA-1 of the file contents?  ;-)

							Thanx, Paul
