Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73171A35B5
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH3Lcf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 07:32:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3Lcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 07:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YGyzX7o+0kt4KwDAVePl6jt5JfthEYZLjGAK6qAsuCg=; b=V2r8Xy3yxoPkd6XGDjTOp8joX
        RhTqwqBI37l5VwDVnTCed//97hYrKG4mr3jynHcCXCDzScrt5BdUke4p4ysRn8CrVZ/prUsZrF27K
        JZrflsUbI+kUw68BZ67TIx03i81RN/sjF5XVDMkPO0Co6LXgY29k8Q7bXo+p4G1uSjDv0s8wnJpSN
        t5tBIq3puLcZaSFlSmGMv8rPY9nKbo7RbjLUbyo09ghwrxOFGxBgQAy4BPnUhyvB+H5vkfRDH6M0n
        06wB/A0Vs5rKK30DHv81Sig6dfjGVEZ6fIHShsOWYmjL4D29V5ST265og9WYvgj0n83qFyIvLFdbY
        yjA+4XRMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3f8f-0000vu-Ui; Fri, 30 Aug 2019 11:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F259B300489;
        Fri, 30 Aug 2019 13:31:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B238200AB64F; Fri, 30 Aug 2019 13:32:16 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:32:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Message-ID: <20190830113216.GE2369@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
 <cb9785b7-ed43-b91a-7392-e50216bd5771@gmail.com>
 <20190731202517.GF5913@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731202517.GF5913@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 31, 2019 at 01:25:17PM -0700, Paul E. McKenney wrote:
> Looks like a pretty clear consensus thus far.  Any objections to keeping
> these .txt for the time being?

Obviously I'm a huge proponent of abandoning RST and an advocate for
normal .txt files ;-)
