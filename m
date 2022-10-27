Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F71610005
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiJ0SQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiJ0SPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 14:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FB7C1D9;
        Thu, 27 Oct 2022 11:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C7E662415;
        Thu, 27 Oct 2022 18:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762B8C433C1;
        Thu, 27 Oct 2022 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666894503;
        bh=3HRxhPs5aRt82sCmtdzYduN3y/fgPE5EeF7WhWyHiY8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hFJ+ssifG3lbRsDRrGmIkez0dIzYs35PZPUPHi0U1U9DUeEdL9l/mnLbDIfrRq+Pj
         q+52SJhDqKNPbcnD9oOghksA6ntCzMn37u5K15XynJPuyPDS8EteUI6sZUtpc3J4QH
         R10oDECCio5GMwpCK7VPk0fQ4rEFuFPTZZ9+TQLdMjd5qoMU5bSlNTv2bzJlTImWi7
         6Pib7X9nweO0JkPmiOJC0L2ScJtinkOGB8prXWU7gMY0IPVtPOClNmwdQHX6/BtpXB
         pLgioVILGA/hXEmrK8a47EwAuy1XvhqNIU5y6fgY6KZ/r9KE0h7kqnfwq44xNHS5uW
         YT0+kb4NEU7DQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1EDC95C0A59; Thu, 27 Oct 2022 11:15:03 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:15:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation
 for writel() example
Message-ID: <20221027181503.GE5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <20221018100554.GA3112@willie-the-truck>
 <20221018174907.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR12MB54810CA260159E805D448375DC289@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54810CA260159E805D448375DC289@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 18, 2022 at 08:33:08PM +0000, Parav Pandit wrote:
> Hi Paul, Will,
> 
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Tuesday, October 18, 2022 1:49 PM
> > 
> > On Tue, Oct 18, 2022 at 11:05:55AM +0100, Will Deacon wrote:
> > > On Mon, Oct 17, 2022 at 10:55:00PM +0200, Arnd Bergmann wrote:
> > > > On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
> > > > > The cited commit describes that when using writel(), explcit wmb()
> > > > > is not needed. wmb() is an expensive barrier. writel() uses the
> > > > > needed platform specific barrier instead of expensive wmb().
> > > > >
> > > > > Hence update the example to be more accurate that matches the
> > > > > current implementation.
> > > > >
> > > > > commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA
> > vs.
> > > > > MMIO ordering example")
> > > > >
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > > I have no objections, though I still don't see a real need to change
> > > > the wording here.
> > >
> > > FWIW, I also don't think this change is necessary. If anything, I'd
> > > say we'd be better off _removing_ the text about writel from this
> > > section and extending the reference to the "KERNEL I/O BARRIER
> > > EFFECTS" section, as you could make similar comments about e.g.
> > > readb() and subsequent barriers.
> > >
> > > For example, something like the diff below.
> > 
> > I do like this change, but we might be dealing with two different groups of
> > readers.  Will and Arnd implemented significant parts of the current
> > MMIO/DMA ordering infrastructure.  It is thus quite possible that wording
> > which suffices to remind them of how things work might or might not help
> > someone new to Linux who is trying to figure out what is required to make
> > their driver work.
> > 
> > The traditional resolution of this sort of thing is to provide the
> > documentation to a newbie and take any resulting confusion seriously.
> > 
> > Parav, thoughts?
> 
> I am ok with the change from Will that removes the writel() description.
> However, it removes useful short description from the example of "why" writel() is used.
> This is useful for newbie and experienced developers both.
> 
> So how about below additional change on top of Will's change?
> This also aligns to rest of the short C comments in this example pseudo code.
> 
> If ok, I will take Will's and mine below change to v5.
> 
> index 4d24d39f5e42..5939c5e09570 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1919,7 +1919,9 @@ There are some more advanced barrier functions:
>                 /* assign ownership */
>                 desc->status = DEVICE_OWN;
> 
> -               /* notify device of new descriptors */
> +               /* Make descriptor status visible to the device followed by
> +                * notify device of new descriptors
> +                */
>                 writel(DESC_NOTIFY, doorbell);

Hearing no objections, please proceed.

							Thanx, Paul
