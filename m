Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29596B773
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfGQHpG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 03:45:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQHpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 03:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a+w5j6eHYvJzioLr+1nRU4VPj/HkjhXiSU4Y9J8b7R8=; b=YbNCb/0gjQZL0XpBqEiPAwf+A9
        3CgD9+vHlITW3ap2VMwt3sgVkwTzhRuRP/kgyZkGXM4XSu0z6A6ofUZh7f//Sux0TTeqwycROgOyW
        mLxn1uh9uXpCSJnqhfhbJdGj+v0bNg1lHzvz/yqDdsRlq+uKC9Ugrjw8MjS6FdMQsWpzu6XKr18uv
        WaT+N+4woH/KJYWFG573iBJIz5dq7RZjKNF11vp/WY7jPjvztxxaroPXOZPOogzOFYZazsr/lMDfq
        Cr6oTbCR8umH6TQpwxREIHsW/uUlzeCDHYQiMnCyPBHR0Af3bvNHEZk/DterF+Yju8ZMnXLDyTUoc
        J3NLOz9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnec8-0008Nx-I5; Wed, 17 Jul 2019 07:44:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 148B02059DEA3; Wed, 17 Jul 2019 09:44:35 +0200 (CEST)
Date:   Wed, 17 Jul 2019 09:44:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 10:16:29PM -0400, Waiman Long wrote:
>  A simple graphic to illustrate those queues will help too, for example

Very much yes!

> /*
>  * MCS lock holder
>  * ===============
>  *    mcs_node
>  *   +--------+      +----+         +----+
>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>  *   | locked | -+   +----+         +----+
>  *   +--------+  |
>  *               |   +----+         +----+
>  *               +-> |next| -> ...  |next| -> X     [Secondary queue]
>  *    cna_node       +----+         +----+
>  *   +--------*                       ^
>  *   | tail   | ----------------------+
>  *   +--------*   

Almost; IIUC that cna_node is the same as the one from locked, so you
end up with something like:

>  *    mcs_node
>  *   +--------+      +----+         +----+
>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>  *   | locked | -+   +----+         +----+
>  *   +--------+  |
>  *               |   +---------+         +----+
>  *               +-> |mcs::next| -> ...  |next| -> NULL     [Secondary queue]
>  *                   |cna::tail| -+      +----+
>  *                   +---------+  |        ^
>  *                                +--------+
>  *
>  * N.B. locked = 1 if secondary queue is absent.
>  */
