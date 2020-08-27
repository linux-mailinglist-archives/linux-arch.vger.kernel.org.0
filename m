Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C5254B43
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0Q42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0Q42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:56:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF85C061264;
        Thu, 27 Aug 2020 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SSi0PB6QbtM1yaYhFUwqIMkjIT1n3Q2GuDY4HbN7Kf0=; b=vEHF2QGsi2DpyHej0MA5sep7Ur
        C1S7/f467o3G2ZmbX8x+/9E5sZAebKOacqzgM8MmipjMRGOOqDFepAB/D0jC5C5MdQqI0GAO41OCI
        /19RpLSJmY1OZig5zNLCmElzmIPx0bQd/p9QESlVb+JMBBl5BmfuGJ1s0A6ul9tIwaNTwhBR3rtjR
        nl/eKTc3ih3ot2uYnODMT2fiD1IZw0OOVBqUte38vQwJt451IYELo8Ei6XxJUe0aOWDvFlsiA6OLv
        VfKkym3Iz3XRrAfHMFaiWjNn+pJMiGjTCIrOYXD7TBoRINzWXRXyxmKZcWJnxXgx4DJRoGQA8CUki
        xkXwWD2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBLC3-00075E-NI; Thu, 27 Aug 2020 16:56:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15792301A66;
        Thu, 27 Aug 2020 18:56:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C21B52C42F07A; Thu, 27 Aug 2020 18:56:05 +0200 (CEST)
Date:   Thu, 27 Aug 2020 18:56:05 +0200
From:   peterz@infradead.org
To:     Cameron <cameron@moodycamel.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200827165605.GL1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
 <20200827163755.GK1362448@hirez.programming.kicks-ass.net>
 <CAFCw3doX6KK5DwpG_OB331Mdw8uYeVqn8YPTjKh_a-m7ZB9+3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCw3doX6KK5DwpG_OB331Mdw8uYeVqn8YPTjKh_a-m7ZB9+3A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:49:20PM -0400, Cameron wrote:
> For what it's worth, the freelist.h code seems to be a faithful adaptation
> of my original blog post code. Didn't think it would end up in the Linux
> kernel one day :-)

Hehe, I ran into the traditional ABA problem for the lockless stack and
asked google, your blog came up.

I'll try and actually think about it a little when the current (virtual)
conference is over.

Are you Ok with the License I put on it, GPLv2 or BDS-2 ?

> I'm just wondering if the assumption that "nodes are never freed until
> after the free list is destroyed" will hold true in the intended use case?

It does, the nodes are only deleted once the whole freelist object is
discarded.
