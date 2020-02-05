Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68F3152867
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 10:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBEJe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 04:34:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgBEJe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 04:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hHxC7J53MNK6iW1lpEIGr4piDFA6tzTijRpDpls5rq0=; b=V3PJHOktMTtcTZr19q5/Az669r
        aP0RjMFriRSY90WCO2nR6DeKbV7tUr2iu8FIOM9v6VgrHwIAIpzJhsmd2Z6H8xPLfh/xGPdriky5q
        0+JhcL3yZWivFPN7F1rgg6nRVhKuD45/2vrCVtNXbrcJLvTq160tCgQa+dESgzp8zHPFEBBdF2EgU
        BPr9tNMmrPM6uKsjRa6k/W25FauvSqWeYdhkK+Fjdqs/1upbchEDgqFvTDBE06BBgr8GxLmUNyVso
        0WBKtLJ6P735k3N8ZrfYB6OTiljSzClS97B92PJPNrBdbNu5QXQ5nwnRAxni/QdnX0OnlRzzD5Btm
        /pH2w7pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izH5F-0003ae-28; Wed, 05 Feb 2020 09:34:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA97E3011C6;
        Wed,  5 Feb 2020 10:33:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAAC42B76A662; Wed,  5 Feb 2020 10:34:54 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:34:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Message-ID: <20200205093454.GG14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
> From: Octavian Purdila <tavi.purdila@gmail.com>
> 
> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> are not compiled due to type conflict of atomic64_t defined in
> linux/type.h.
> 
> This commit fixes the issue and allow using generic atomic64 ops.
> 
> Currently, LKL is only the user which defines GENERIC_ATOMIC64
> (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
> issues before this commit.

Uhhhhh, no.

Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.

Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.

Please explain more.

