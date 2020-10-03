Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFA28244A
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgJCNWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Oct 2020 09:22:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38425 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725781AbgJCNWN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Oct 2020 09:22:13 -0400
Received: (qmail 319931 invoked by uid 1000); 3 Oct 2020 09:22:12 -0400
Date:   Sat, 3 Oct 2020 09:22:12 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201003132212.GB318272@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001213048.GF29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To expand on my statement about the LKMM's weakness regarding control 
constructs, here is a litmus test to illustrate the issue.  You might 
want to add this to one of the archives.

Alan

C crypto-control-data
(*
 * LB plus crypto-control-data plus data
 *
 * Expected result: allowed
 *
 * This is an example of OOTA and we would like it to be forbidden.
 * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
 * control-dependent on the preceding READ_ONCE.  But the dependencies are
 * hidden by the form of the conditional control construct, hence the 
 * name "crypto-control-data".  The memory model doesn't recognize them.
 *)

{}

P0(int *x, int *y)
{
	int r1;

	r1 = 1;
	if (READ_ONCE(*x) == 0)
		r1 = 0;
	WRITE_ONCE(*y, r1);
}

P1(int *x, int *y)
{
	WRITE_ONCE(*x, READ_ONCE(*y));
}

exists (0:r1=1)
