Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850E5A2DC4
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiHZRoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 13:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZRoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 13:44:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FC927B05;
        Fri, 26 Aug 2022 10:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46568B8320B;
        Fri, 26 Aug 2022 17:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE658C433D6;
        Fri, 26 Aug 2022 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661535840;
        bh=LLwqHI85y/+GxaK6vW19+U7CAFcsPtYk7pvwQU3KP2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8ZZpJ4Gl3aT3tooSeX1grJEq1dDXnzsptm50eVO29+Y/Z2W46kzZtNeCd7QxcOiO
         NG0jb9fWyrFZ7UZ1GGa7PVDnP1UWnMrZGVTFrvF5zYk3rHFtx0q1NrCHDqbxZTZgk2
         YVL5tNzunifprLBH8dybidRdhSASplsyc1iIj/RpoHCLUFZZE+4phGeWwWQdHzt79c
         262HIT4+TqUo7nMA2OjIwdRTTWCfoV76CfWcJg3OmwDLAra230/t+XICOB0fy0LM8h
         4nlNXSp5jgLrVOLabWho00LOecHd4g3UfTPL+rzAaGqx7nNVuQo70vtKsJYteK1DB2
         s0QAIyevYu+bg==
Date:   Fri, 26 Aug 2022 18:43:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
Message-ID: <20220826174352.GA20386@willie-the-truck>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <20220826112327.GA19774@willie-the-truck>
 <alpine.LRH.2.02.2208260727020.17585@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208261003590.27240@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 10:08:42AM -0400, Mikulas Patocka wrote:
> On Fri, 26 Aug 2022, Mikulas Patocka wrote:
> > On Fri, 26 Aug 2022, Will Deacon wrote:
> > > On Thu, Aug 25, 2022 at 05:03:40PM -0400, Mikulas Patocka wrote:
> > > > For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all 
> > > > (with or without this patch), so I only compile-tested it on arm64. I have 
> > > > to bisect it.
> > > 
> > > It's working fine for me and I haven't had any other reports that it's not
> > > booting. Please could you share some more details about your setup so we
> > > can try to reproduce the problem?
> > 
> > I'm bisecting it now. I'll post the offending commit when I'm done.
> 
> So, the bad commit is aacd149b62382c63911060b8f64c1e3d89bd405a ("arm64: 
> head: avoid relocating the kernel twice for KASLR").

Thanks. Any chance you could give this a go, please?

https://lore.kernel.org/r/20220826164800.2059148-1-ardb@kernel.org

Will
