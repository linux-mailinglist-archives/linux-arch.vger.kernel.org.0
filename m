Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63C16108E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgBQLCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 06:02:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgBQLCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Feb 2020 06:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N2KaWUW3ojsaIAWy3SDFA2ekcPzSJz1io3iUAiK0snA=; b=gmLivW0OFBNi55bZx67RzylSSS
        JWNzLtb2M3xL25Gkxs9hnoHV4znUSqr2RxWiIeSXqtdJHx72CjLeripuiKieBhZk/Ui6PJOdcNL0c
        5/mmA9YIhidKIJezIIS+GUyRVqtrdZu91OmGcVN0gBvWqD0GDSLPUbSWJXEfT0+zTTlmo6aC+jJr5
        Zs/tjrIUYq7GLwGxcXY+5yVzGnkE8RZCsdV2udFACanGo/VYRy+vDhwfx2XRvxT98vJa0qNuGq5HV
        wHzVsPUiVDmWuryfnmN5g5tSgzJ0SQzv7IW8hR1k3Pf5AAeJLYoFlt/+lDNJGz7/222bu/ZDt7ZSo
        rJmWaI+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3eA7-0001BX-8W; Mon, 17 Feb 2020 11:02:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC75D300EBB;
        Mon, 17 Feb 2020 12:00:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1682A29E09C0A; Mon, 17 Feb 2020 12:02:00 +0100 (CET)
Date:   Mon, 17 Feb 2020 12:02:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200217110200.GO14914@hirez.programming.kicks-ass.net>
References: <20200214040132.91934-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
 <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 15, 2020 at 07:52:15AM +0800, Boqun Feng wrote:
> I agree, and thanks for the suggestion! And I change the sentence in
> atomic_t.txt with:
> 
> 	A note for the implementation of atomic_set{}() is that it
> 	cannot break the atomicity of the RMW ops.
> 
> , since I think that part of the doc is more about the suggestion to
> anyone who want to implement the atomic_set(). Peter, is that OK to you?

Sure.
