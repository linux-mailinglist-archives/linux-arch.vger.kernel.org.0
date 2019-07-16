Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F506A6F0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfGPLFk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 07:05:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfGPLFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 07:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fux26hSK6N/9ocpE4mp37kRWsTev3GkG0XekvAc9mQo=; b=gGQl2JTtF4VUZZ30B5L84YFLM
        Azsyc9AnKpIYkrwKWTZhBkO2FloOBu+5+Zc8F4D3NAym2kpGI5tNQlTUO4dNdQXfy0rx3En/e4KqK
        lz0Iab8H5qPJLQtzr7GM4TL2t+xAhTjwCyxL/U/I8lnh+TVWNKCfIkYbfMoKtHlgritiHx2L7NYOH
        +epNAPr+2tnJK4esn6CIc9fn73LJIGxvE0xCsnRqnrvoH6kQcyvOELKoUVoDXoZUhJIq3BeeAKRC3
        Yf6jDJItiqY3qnMlAUHy80nNMaL/d5FcPbQ0lmXZTlTqzqojDtwqg/iQzzp81Nje+CE1Z7jct4uoY
        +ESQoKVXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnLGq-00065u-06; Tue, 16 Jul 2019 11:05:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D4D520A4C82D; Tue, 16 Jul 2019 13:05:18 +0200 (CEST)
Date:   Tue, 16 Jul 2019 13:05:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
> +/**
> + * find_successor - Scan the main waiting queue looking for the first
> + * thread running on the same node as the lock holder. If found (call it
> + * thread T), move all threads in the main queue between the lock holder
> + * and T to the end of the secondary queue and return T; otherwise, return NULL.
> + */
> +static struct cna_node *find_successor(struct mcs_spinlock *me)

Either don't use a kernel doc comment, but if you must, you have to
stick to their format, otherwise we'll get endless stupid patches fixing
up the stupid comment.
