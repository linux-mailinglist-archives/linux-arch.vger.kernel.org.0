Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E96A14FB
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 03:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBXCg4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 21:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBXCgz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 21:36:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D87E95EEC9
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 18:36:54 -0800 (PST)
Received: (qmail 22524 invoked by uid 1000); 23 Feb 2023 21:36:54 -0500
Date:   Thu, 23 Feb 2023 21:36:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tools/memory-model: Add documentation about SRCU
 read-side critical sections
Message-ID: <Y/gixo29Uky+3YP3@rowland.harvard.edu>
References: <20230213015506.778246-1-joel@joelfernandes.org>
 <Y/JS5SYKPeeDQErL@rowland.harvard.edu>
 <CAEXW_YQrFSiDEM9cuhkTT2_1+CZoGbg7vC9oL-D-Wd5OQ2mm2w@mail.gmail.com>
 <CAEXW_YR6eKDCv+E8Xv2aX=Eo=H0667cqrXkMqKhc_QMZ4Vf59A@mail.gmail.com>
 <Y/PgxRorDQZ7wPKU@rowland.harvard.edu>
 <20230222195051.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/bRFNrzjIRjFgxz@rowland.harvard.edu>
 <73baee18-802e-f694-a3d7-9ae776e6fd69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73baee18-802e-f694-a3d7-9ae776e6fd69@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 24, 2023 at 11:32:49AM +0900, Akira Yokosawa wrote:
> Hi Alan,
> 
> One minor nit.  Please find inline comment below.

> > +The LKMM models uses the srcu-rscsi relation to model SRCU read-side
> 
> I think you mean either:
> 
>    The LKMM models the srcu-rscsi relation ...
> 
> or: 
> 
>    The LKMM uses the srcu-rscsi relation ...

Oops!  Thanks for spotting that.  Yes, I meant the second one.

> With this fixed,
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

I'll add this to the next version.

Alan

> > +critical sections.  They are different from RCU read-side critical
> > +sections in the following respects:
> > +
> [...]
> 
>         Thanks, Akira
