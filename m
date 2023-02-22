Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93069FD02
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 21:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjBVUcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 15:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjBVUcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 15:32:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 13E0936FDA
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 12:32:12 -0800 (PST)
Received: (qmail 1219409 invoked by uid 1000); 22 Feb 2023 15:32:12 -0500
Date:   Wed, 22 Feb 2023 15:32:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: Re: [PATCH] tools/memory-model: Add details about SRCU read-side
 critical sections
Message-ID: <Y/Z7zIGNUIxymLRO@rowland.harvard.edu>
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu>
 <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
 <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
 <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
 <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 22, 2023 at 11:50:51AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 20, 2023 at 04:06:13PM -0500, Alan Stern wrote:
> > On Sun, Feb 19, 2023 at 12:13:14PM -0500, Joel Fernandes wrote:
> > > On Sun, Feb 19, 2023 at 12:11 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > Even though it may be redundant: would it be possible to also mention
> > > > (after this paragraph) that this case forms an undesirable "->rf" link
> > > > between B and C, which then causes us to link A and D as a result?
> > > >
> > > > A[srcu-lock] ->data B[once] ->rf C[once] ->data D[srcu-unlock].
> > > 
> > > Apologies, I meant here, care must be taken to avoid:
> > > 
> > > A[srcu-lock] ->data B[srcu-unlock] ->rf C[srcu-lock] ->data D[srcu-unlock].
> > 
> > Revised patch below.  I changed more than just this bit.  Mostly small 
> > edits to improve readability, but I did add a little additional 
> > material.
> 
> Looks good to me, thank you!
> 
> Would you like to send a formal patch, or are you thinking in terms
> of making other changes first?

I'll send a formal patch when I find time to write an appropriate 
Changelog description.

I also have in mind making other changes along the lines Joel suggested, 
but they will be separate patches.

Alan
