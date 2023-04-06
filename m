Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCD6DA5D9
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbjDFWe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjDFWe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 18:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AB7ED0;
        Thu,  6 Apr 2023 15:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DF264CE7;
        Thu,  6 Apr 2023 22:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A7FC433D2;
        Thu,  6 Apr 2023 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680820495;
        bh=vBLIz7ZskpOa4TmmFIjmguzsaYx53b28m5xn+F8JkR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BnSW6D2qutMf6jzRK5iD9c23LkECG1g2oOGKgbzjcXgxLBflo+Z/iTCEujfwnRNKG
         HMeYeieP35iGl70FfNN6xWoIg7K0N56bsxiBZyibnnWLpDjoJqZtaHRggruD5xw6Ww
         f9TCvQZrwepmUp9dkjsbDvj4fYfTTD8kWftzmKQPkLaz1E2iCETNQDZbC0sD75VX8S
         g3fGr9kzFM4LOWDTVP2N9jmS9iVZj8OoMU5pv5N12p5eUu2jxmfkDUQDZD46XjSg6y
         rCF5NiABDXkiUdP1WiI0WjBrIxgo/jhtM1HxZ1kN1/V+FZvFaHp0tY39kybQjYC6yl
         ky9o674HJjaSQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AFFDB154047D; Thu,  6 Apr 2023 15:34:54 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:34:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
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
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
> Paul:
> 
> I just saw that two of the files in tools/memory-model/litmus-tests have 
> almost identical names:
> 
> 	Z6.0+pooncelock+pooncelock+pombonce.litmus
> 	Z6.0+pooncelock+poonceLock+pombonce.litmus
> 
> They differ only by a lower-case 'l' vs. a capital 'L'.  It's not at all 
> easy to see, and won't play well in case-insensitive filesystems.
> 
> Should one of them be renamed?

Quite possibly!

The "L" denotes smp_mb__after_spinlock().  The only code difference
between these is that Z6.0+pooncelock+poonceLock+pombonce.litmus has
smp_mb__after_spinlock() and Z6.0+pooncelock+pooncelock+pombonce.litmus
does not.

Suggestions for a better name?  We could capitalize all the letters
in LOCK, I suppose...

							Thanx, Paul
