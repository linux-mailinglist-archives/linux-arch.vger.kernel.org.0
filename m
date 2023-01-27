Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D367E8C5
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjA0O77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 09:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjA0O76 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 09:59:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF46184;
        Fri, 27 Jan 2023 06:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E2661CC5;
        Fri, 27 Jan 2023 14:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7FDC4339B;
        Fri, 27 Jan 2023 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674831597;
        bh=6A3bg177CZCGpr4mKIGL57gyFua0Tc3JibyHOd77gOk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YUGFTY+79tYm0nI1wWJvWX5NArv7J756eUPQwJIiCFEMmfEM0LIHeIDeO27RnvYrx
         rkFbnHwt7aLgMZzeFLniDr09wPSixi+N9Plw+VK36aCysIhwZ2CVlGafOKINJnF4vk
         eJQ9k60tEYT98ks+7DbsfcJSXPBlkjSB1IW0DYILhu+Pb2/AJVw2dhVPdPDzCGeTpF
         CSeNdxd1ZEUs7uoy7lTddtHZ61uWJY+/wZmVOjsgdbsMjuyg5toS61xAe+MjU5g2oZ
         uuy6k8GdcBKOXMu3+a8ScSdKSM+00ijPWpCRiPYwTTCh9ezlVbGjYvdqzWPvilArv4
         O4e84N14Lv4fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B09A55C010C; Fri, 27 Jan 2023 06:59:56 -0800 (PST)
Date:   Fri, 27 Jan 2023 06:59:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 15/35] Documentation: litmus-tests: correct spelling
Message-ID: <20230127145956.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230127064005.1558-16-rdunlap@infradead.org>
 <20230127064005.1558-1-rdunlap@infradead.org>
 <2919161.1674802748@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2919161.1674802748@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 06:59:08AM +0000, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > Correct spelling problems for Documentation/litmus-tests/ as reported
> > by codespell.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: linux-arch@vger.kernel.org
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> 
> Reviewed-by: David Howells <dhowells@redhat.com>

Queued for v6.4, thank you both!

							Thanx, Paul
