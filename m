Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B931507A9
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2020 14:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBCNqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Feb 2020 08:46:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgBCNqW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 08:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ydJSIlzM2hfUd3hl9T8tzcAmF2kYDsfmAnSpEAfBJFE=; b=Ifgv49xEstpI6IK+7zuM3iAvmJ
        jr82lguHcDCP1cXc5T81M5VxnAYuFDas9953pxIHOCtEMmJ43fiGkeyF5+hY1TOStG3WChXAhdu6M
        4bVDMfZkJo3oib3cWXIwf99ZG4eOFvzz9UTYlQB+6ZmTi7lOUJYvzrW3Gewcz/1GI3YuwmF/1zfCB
        WDbZYc43ExER/r5rjtWqf6hxqhSyOu3QU/xD6Zhgcc8P8SgPg7BA7VOhYR4+tk0xtGx2ypu41t1Id
        ht8N7MaR+waqTk32jUpD1OYtU/VURox040tiS7juhC4s045+nmg4kGNNZWIvu7JPUlqWEKGTC0QWo
        c3w0IGbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyc2p-0004pA-2r; Mon, 03 Feb 2020 13:45:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53105305803;
        Mon,  3 Feb 2020 14:43:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F4B82B63D250; Mon,  3 Feb 2020 14:45:40 +0100 (CET)
Date:   Mon, 3 Feb 2020 14:45:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200203134540.GA14879@hirez.programming.kicks-ass.net>
References: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 30, 2020 at 05:05:28PM -0500, Alex Kogan wrote:
> 
> > On Jan 25, 2020, at 6:19 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Fri, Jan 24, 2020 at 01:19:05PM -0500, Alex Kogan wrote:
> > 
> >> Is there a lightweight way to identify such a “prioritized” thread?
> > 
> > No; people might for instance care about tail latencies between their
> > identically spec'ed worker tasks.
> 
> I would argue that those users need to tune/reduce the intra-node handoff
> threshold for their needs. Or disable CNA altogether.

I really don't like boot time arguments (or tunables in generic) for a
machine to work as it should.

The default really should 'just work'.

> In general, Peter, seems like you are not on board with the way Longman
> suggested to handle prioritized threads. Am I right?

Right.

Presumably you have a workload where CNA is actually a win? That is,
what inspired you to go down this road? Which actual kernel lock is so
contended on NUMA machines that we need to do this?
