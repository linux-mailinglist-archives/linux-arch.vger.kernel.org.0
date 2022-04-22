Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC050B55F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiDVKnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446845AbiDVKmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 06:42:46 -0400
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B09554A8;
        Fri, 22 Apr 2022 03:39:39 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 293454C046E;
        Fri, 22 Apr 2022 12:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1650623977;
        bh=OziXpZopIYxb3f1gE+uPznYxZhbuOzdu2g8U5ipdPbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhS15dFSGztpvzsMkJ6qayNPHMOkYoV7DK/EMamtJDzraoIvQ/98HH1s7aHKTgE+q
         hOf7aS9sYP2Vy3xhUMhbMp2SOrWpez7VIwkvqDOTwgHFNPLey1EqsGo7cKDz1bM3a0
         fIy7nyzGK7M8R9ZjDkPLwE7q4bwA44Q0Di5kNt6hEqWrFaYIlOKtquCINJsvT9VtIb
         Ok5QIXNXAK2GRBE4G3MzvgOBTen8VKRahCJ8KvJ882BqMLSD3TH57JMi1qcKqD+KLL
         KVuX+GaYr0hW4BACi63hugHoNubFG7Gjcw6zMvNe8of4gEUL4oOY0RcAIOrzEEy4tf
         LBpWNEvRodfZA==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 23BA86D8; Fri, 22 Apr 2022 12:39:37 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id F24156D7;
        Fri, 22 Apr 2022 12:39:36 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id ECF6C55F;
        Fri, 22 Apr 2022 12:39:36 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id E7B524A037C; Fri, 22 Apr 2022 12:39:36 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 83A464A01EC;
        Fri, 22 Apr 2022 12:39:35 +0200 (CEST)
        (Extended-Queue-bit xtech_ad@fff.in.tum.de)
Date:   Fri, 22 Apr 2022 12:39:34 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Re: Dangerous addr to ctrl dependency transformation in
 fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
Message-ID: <YmKF5tiH4W8AVdXe@Pauls-MacBook-Pro.local>
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
 <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 14, 2022 at 02:21:25PM -0700, Nick Desaulniers wrote:
> On Thu, Apr 7, 2022 at 8:22 AM Paul Heidekrüger
> <paul.heidekrueger@in.tum.de> wrote:
> >
> > Hi all,
> >
> > work on my dependency checker tool is progressing nicely, and it is
> > flagging, what I believe is, a harmful addr to ctrl dependency
> > transformation. For context, see [1] and [2]. I'm using the Clang
> > compiler.
> > [1]: https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > [2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pro/T/#u
> 
> Hi Paul,
> Thanks for the report and your (and your team's) work on this tool.
> Orthogonal to your report, Jose (cc'ed) and I are currently in the
> planning process to put together a Kernel+Toolchain microconference
> track at Linux Plumbers Conference [0] this year (Sept 12-14) in
> Dublin, Ireland.  Would you or someone from your group be able and
> interested in presenting more information about your work to an
> audience of kernel and toolchain developers at such an event?
> 
> Would others be interested in such a topic? (What do they say in
> Starship Troopers...?...Would you like to know more?)
> 
> [0] https://lpc.events/event/16/
> -- 
> Thanks,
> ~Nick Desaulniers

Hi Nick and Jose, 

Many thanks for inviting us! I would love to do a talk at LPC! Hopefully
in person too.

Given that there have been several talks around this topic at LPC
already, it seems very fitting, and we'll hopefully have more to share
by then. Actually we have more to share already :-)

https://lore.kernel.org/all/YmKE%2FXgmRnGKrBbB@Pauls-MacBook-Pro.local/T/#u

I assume we will have to submit an abstract soon? 

Many thanks,
Paul

