Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1E186F08
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgCPPsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 11:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbgCPPsm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 11:48:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D217C2051A;
        Mon, 16 Mar 2020 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584373721;
        bh=hgo1mJoERylQnqXK/Qzm4LRDUpgAiG0+pmKFSvZomaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za6mh7KDdv9dR38PI076BNUhiopaZCf0+hr79++iIoZYWraYO/CUHmaixd7xgv8Le
         yueJN2TPyLFVFJfjUaPpJyEFNje6v5oiYHwgY2t9gCshrsIrjDkyUmxmvBOzDxW5dQ
         h2cofCD3g2K0Xmafbqbs+gf8bKMoav5gNbUAF3/g=
Date:   Mon, 16 Mar 2020 15:48:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Message-ID: <20200316154835.GA13004@willie-the-truck>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
 <20200309090650.GF12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309090650.GF12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 09, 2020 at 10:06:50AM +0100, Peter Zijlstra wrote:
> On Sun, Mar 08, 2020 at 08:56:15PM +0100, Jonathan Neuschäfer wrote:
> > Hi,
> > 
> > this is a short series of unrelated fixes that make the atomic
> > operations documentation look and read a bit better.
> > 
> > Jonathan Neuschäfer (3):
> >   docs: atomic_ops: Remove colons where they don't make sense
> >   docs: atomic_ops: Move two paragraphs into the warning block above
> >   docs: atomic_ops: Steer readers towards using refcount_t for reference
> >     counts
> > 
> >  Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------
> 
> FWIW, I consider this a dead document. I've written
> Documentation/atomic_t.txt and Documentation/atomic_bitops.txt as a
> replacement. If there is anything in atomic_ops you feel is missing from
> those two, please tell as I'm planing to delete atomic_ops soon.

For the deletion:

Acked-by: Will Deacon <will@kernel.org>

Will
