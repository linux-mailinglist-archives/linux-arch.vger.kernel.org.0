Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5646B8C1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfGQI7R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 04:59:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQI7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 04:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vAzlqx/lFVlfT0a1qLbPZP1qhezVl/F0oinXuzJi9bw=; b=TZHdWNwIYTCWJ0RxqxfUHlLnY
        +VupZBhYjL0yeFleSwLYphjW1QXBSWIICBb+KSaGFTiwWOggj3RhUN625816vNXK7uoNQ47B+2ZpZ
        wMASf51aAidNJUjJ+canyxQaoERvd9jp756ri2gktddwKXCyNvopDH+wQB460WWdHHoVSvOP7v1VR
        e2nsKG+TkQxEkWjD68U6VLfpVVTmYpOtRZQ/f250DhY3iZlpAOjlOieTOTVH0597OeNRrz+xqvv1O
        lO/C1lxkKAek/pVup0GljJKgl1EqXJvyi+8pPEfKhaEd9ogK/lrInlgCOQ1BufObG8QxjtBhOdAQ+
        GN5WjTSNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnfmA-0001zi-SN; Wed, 17 Jul 2019 08:59:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D667720B51F57; Wed, 17 Jul 2019 10:59:00 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:59:00 +0200
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
Message-ID: <20190717085900.GS3463@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717083944.GR3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 17, 2019 at 10:39:44AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:

> > My primary concern was readability; I find the above suggestion much
> > more readable. Maybe it can be written differently; you'll have to play
> > around a bit.
> 
> static void cna_splice_tail(struct cna_node *cn, struct cna_node *head, struct cna_node *tail)
> {
> 	struct cna_node *list;
> 
> 	/* remove [head,tail] */
> 	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
> 	tail->mcs.next = NULL;
> 
> 	/* stick [head,tail] on the secondary list tail */
> 	if (cn->mcs.locked <= 1) {
> 		/* create secondary list */
> 		head->tail = tail;
> 		cn->mcs.locked = head->encoded_tail;
> 	} else {
> 		/* add to tail */
> 		list = (struct cna_node *)decode_tail(cn->mcs.locked);
> 		list->tail->next = head;
> 		list->tail = tail;
> 	}
> }
> 
> static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> {
> 	struct cna_node *cni, *cn = (struct cna_node *)node;
> 	struct cna_node *head, *tail = NULL;
> 
> 	/* find any next lock from 'our' node */
> 	for (head = cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
> 	     cni && cni->node != cn->node;
> 	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> 		;

I think we can do away with those READ_ONCE()s, at this point those
pointers should be stable. But please double check.

> 	/* when found, splice any skipped locks onto the secondary list */
> 	if (cni && tail)
> 		cna_splice_tail(cn, head, tail);
> 
> 	return cni;
> }
> 
> How's that?
