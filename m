Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03657BBC1D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjJFPtq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFPtp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 11:49:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B019E;
        Fri,  6 Oct 2023 08:49:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C46C433C7;
        Fri,  6 Oct 2023 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696607381;
        bh=ZSSuoEGwh0wklx+z8o5WHFA0QtphImYanv8ABNIK/8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tuO3Y2W5PsjSMEZRDLGecoGa7oOleaX/e1R1yanf5hxicHanZORSw7BmSLHYdGHLt
         xI+Mvs8Xf1luIHBceSvSF9DAjvLaZjuNX9hqcHDmp+RAqqMCJ4WMDRrH9Cv3HTnQ+G
         DVJO36mEU5J5YuDAz+sgeJ5YL8NU6nwfS9rYB9PtCSTbjjv2bBiT5f78j4XJ98/fqE
         SvNSE7DQzAweFZXNZwdXAekkk8tfUnm/awUeDDKgo1/eW8zydSVtKWaY0GpubCZNQK
         Kn6GwvDq4/+qGbgP1l2wBOsEHbBt5DgdFtM0p49NH/9h5cfsYop8Ine6XxXm5oAlj/
         P8JQaAhMLLKtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E4A9CE0976; Fri,  6 Oct 2023 08:49:41 -0700 (PDT)
Date:   Fri, 6 Oct 2023 08:49:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <aa60ff7d-b66f-4d6e-9624-15efa12fdf41@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <ZSAYplkpVlmcL1bb@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAYplkpVlmcL1bb@andrea>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 06, 2023 at 04:24:38PM +0200, Andrea Parri wrote:
> On Thu, Oct 05, 2023 at 09:53:12AM -0700, Paul E. McKenney wrote:
> > The compiler has the ability to cause misordering by destroying
> > address-dependency barriers if comparison operations are used. Add a
> > note about this to memory-barriers.txt in the beginning of both the
> > historical address-dependency sections and point to rcu-dereference.rst
> > for more information.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Thank you, and I will apply on my next rebase.

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 06e14efd8662..d414e145f912 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
> >  
> >  
> >   (2) Address-dependency barriers (historical).
> > +     [!] This section is marked as HISTORICAL: For more up-to-date
> > +     information, including how compiler transformations related to pointer
> > +     comparisons can sometimes cause problems, see
> > +     Documentation/RCU/rcu_dereference.rst.
> >  
> >       An address-dependency barrier is a weaker form of read barrier.  In the
> >       case where two loads are performed such that the second depends on the
> > @@ -556,6 +560,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
> >  
> >  ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
> >  ----------------------------------------
> > +[!] This section is marked as HISTORICAL: For more up-to-date information,
> > +including how compiler transformations related to pointer comparisons can
> > +sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
> >  
> >  As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
> >  DEC Alpha, which means that about the only people who need to pay attention
