Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2E149529
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 12:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgAYLUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 06:20:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgAYLUJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 06:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OP0jUwmmVf5k5VHaoyszroM7/NftdfADwRXKDwwLdIk=; b=ptV38WIPx+l6Yf6WtjGHgCfGFe
        AgMWOXh+dtKIvzf9sJr2QFX8KIPn567Cren4byAkUNCrELh2bnIGEhnjrzg4/VSpoBhaqJpz0wJdW
        v3WCYrq8Cj34EhWxdi0ImmM+Fxd5B5HQa9YqOZtpfsEwsMO0DtrC2ZmGNSZSEab7GSNSclh4zPLRt
        Mq/0W4rMTgG2ErY6PRFSi97BOwYqRryRjFWkt/r3EHJfqfHW/tRHlXM4uHxdB9NB+YDM/K1A5jThf
        3GZY6UrKeKkFaEVrSzVzYPsqKPd0dKhxiReYfqGxATtZYQXzMJJwE86yhsNd/oWDiEhTTKjOX4PFU
        Wmw+TCmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivJTS-0004yl-Ip; Sat, 25 Jan 2020 11:19:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C885F980BB0; Sat, 25 Jan 2020 12:19:31 +0100 (CET)
Date:   Sat, 25 Jan 2020 12:19:31 +0100
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
Message-ID: <20200125111931.GW11457@worktop.programming.kicks-ass.net>
References: <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 01:19:05PM -0500, Alex Kogan wrote:

> Is there a lightweight way to identify such a “prioritized” thread?

No; people might for instance care about tail latencies between their
identically spec'ed worker tasks.

In general it turns out that priority is a dynamic concept, not a static
one.
