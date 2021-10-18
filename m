Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13A54329E7
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJRWz0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 18:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJRWzZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 18:55:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E01DF60F25;
        Mon, 18 Oct 2021 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634597593;
        bh=cd1w558ZQg8mGCOSS14Qu5F4ixQ6qKcRBoypDdPa/4M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t1Dk0yGWdK/QgJfW5CWF7VpsSUSV57+QvmRbj1n4yWgjvFdIxvYY6l94vq1fy8xZP
         AYuSh3HrTDV3NtOmEvey8u971GMTPXLe2pPlsebTFcxi672LPIK6txMGR7j/bG5k4Y
         lIvXmE9JuELbW4fgDGY+BrZfM5prT5g9gIKErGYxP6DBoKzc/UGOBmBtL8vwNSoC3m
         fE3KSjkQlOdhb8Y7qzsSDXb6fcjyT4oT1GN21L24aKjfh4GvUmRHjwl79745ZOde4X
         U/G4TDnnOyPJ5LP00zCid04zxeKA3hb5MMXeAcFkpy4r7q2PW8cgHP9YyJSbFCPHOg
         s1b1I5PVRKOKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ACAD05C1044; Mon, 18 Oct 2021 15:53:13 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:53:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Another possible use for LKMM, or a subset (strengthening)
 thereof
Message-ID: <20211018225313.GA855976@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 07, 2021 at 01:56:21PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> On the perhaps unlikely chance that this is new news of interest...
> 
> I have finally prototyped the full "So You Want to Rust the Linux
> Kernel?" series (as in marked "under construction").
> 
> https://paulmck.livejournal.com/62436.html

And this blog series is now proclaimed to be feature complete.

Recommendations (both short- and long-term) may be found in the last post,
"TL;DR: Memory-Model Recommendations for Rusting the Linux Kernel",
at https://paulmck.livejournal.com/65341.html.

Thoughts?

							Thanx, Paul
