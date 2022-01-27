Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05EE49ECD9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 21:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiA0UtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 15:49:16 -0500
Received: from mail-out2.in.tum.de ([131.159.0.36]:49089 "EHLO
        mail-out2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235860AbiA0UtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 15:49:16 -0500
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mail-out2.informatik.tu-muenchen.de (Postfix) with ESMTP id 2FDFC240086;
        Thu, 27 Jan 2022 21:49:14 +0100 (CET)
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 2D1AAFDD; Thu, 27 Jan 2022 21:49:14 +0100 (CET)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 0A005FDC;
        Thu, 27 Jan 2022 21:49:14 +0100 (CET)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 0502F592;
        Thu, 27 Jan 2022 21:49:14 +0100 (CET)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id F2C494A040E; Thu, 27 Jan 2022 21:49:13 +0100 (CET)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 0AE414A0238;
        Thu, 27 Jan 2022 21:49:12 +0100 (CET)
        (Extended-Queue-bit xtech_em@fff.in.tum.de)
Date:   Thu, 27 Jan 2022 21:49:07 +0100
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Re: [PATCH] tools/memory-model: Clarify syntactic and semantic
 dependencies
Message-ID: <YfMFQ5IZiGBRw7SH@Pauls-MacBook-Pro.local>
References: <20220125172819.3087760-1-paul.heidekrueger@in.tum.de>
 <YfBk265vVo4FL4MJ@rowland.harvard.edu>
 <YfJ7Rr9Kdk4u78lt@Pauls-MacBook-Pro.local>
 <YfLQmgsXp6pg0XIy@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfLQmgsXp6pg0XIy@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 27, 2022 at 12:04:26PM -0500, Alan Stern wrote:
> On Thu, Jan 27, 2022 at 12:00:22PM +0100, Paul Heidekrüger wrote:
> > On Tue, Jan 25, 2022 at 04:00:11PM -0500, Alan Stern wrote:
> > > That's a very abstract way of describing the situation; it doesn't do a 
> > > good job of getting the real idea across.  It also mixes up two separate 
> > > ideas: behaviors being unaffected by a syntactic dependency and 
> > > behaviors being undefined.  They should be described separately. 
> > 
> > Many thanks for the feedback! I agree, the explanation works a lot
> > better once readers have been introduced to data, addr and ctrl
> > relations. 
> > 
> > > I would prefer something along these lines...
> > 
> > Shall I resubmit the patch with you as co-developer, or, given that it's
> > arguably your work now, would you like to submit the patch yourself?
> 
> I'll submit it myself, with Suggested-by: you.  How does that sound?

Sounds good! 

Many thanks,
Paul
