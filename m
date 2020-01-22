Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3432014512A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 10:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgAVJwQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 04:52:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgAVJwQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5abJ1QnasX2RGu56JYvUsjvfRt1I9ljUh2ZesPKbuT0=; b=p8YLls2HIIhVbHUeXOH91k+ND
        OvNM0vHGgLEU4LoIC4sR30p/ug+nv96bSBCBWjq8l93N+i9prze9knLA4/p35cqdr3nJQVBUSp+o/
        oUb4PFxfkOIi69TOwLODpt8DvaMCrmoHePkSZYiGnOT4b5TFC6j6SvtAyJND2jVQVASGGJNtJCk8H
        gzTGEqoI1YWFAoID4SKv/vHa+Yh53KIJBrWIJ3QAChO4kVLOyCCHkhHMCI5F4q6HBoFWvKKAE7KwI
        8ItWBXpUMuC6Py0PqUk4h0mY62cq7XZWizzuJ2415jg0iVSKoh6kc9brledLrHGOTx5Fu1UCakadr
        mCdZZvQsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuCfb-0003jg-MM; Wed, 22 Jan 2020 09:51:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25F9A3079DF;
        Wed, 22 Jan 2020 10:49:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B47B20983E31; Wed, 22 Jan 2020 10:51:27 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200122095127.GC14946@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> 
> various notes and changes in the below.

Also, sorry for replying to v7 and v8, I forgot to refresh email on the
laptop and had spotty cell service last night and only found v7 in that
mailbox.

Afaict none of the things I commented on were fundamentally changed
though.
