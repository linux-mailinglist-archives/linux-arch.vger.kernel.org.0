Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC23418D24F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 16:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCTPDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 11:03:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56655 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726829AbgCTPDb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 11:03:31 -0400
Received: (qmail 29349 invoked by uid 500); 20 Mar 2020 11:03:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2020 11:03:30 -0400
Date:   Fri, 20 Mar 2020 11:03:30 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        <linux-arch@vger.kernel.org>, Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
In-Reply-To: <20200320065552.253696-2-joel@joelfernandes.org>
Message-ID: <Pine.LNX.4.44L0.2003201101060.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:

> This adds an example for the important RCU grace period guarantee, which
> shows an RCU reader can never span a grace period.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> 
> diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> new file mode 100644
> index 0000000000000..73557772e2a32
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus

Do these new tests really belong here?  I thought we were adding a new 
directory under Documentation/ for litmus tests that illustrate parts 
of the LKMM or memory-barriers.txt.

By contrast, the tests under tools/memory-model are merely to show 
people what litmus tests look like and how they should be written.

Alan

