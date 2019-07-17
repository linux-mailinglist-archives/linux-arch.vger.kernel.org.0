Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8F6B874
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfGQIkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 04:40:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfGQIkB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 04:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k3SygQrVYGRxIr8/Ey1B5LfPQh62hunNBAFxIxNx0uo=; b=Sn8ZMHe7TPDK3LeiyU0p8YDyYE
        hQ8umtlgXoLUK2rhJ/07RgbpoQlHOwWua9liOHQkJrKQ5SuYGn/c19YbTWdxL9Tl1qtfYYUFL/e+y
        rFuWzMRT1cWmHeR7lMOmDiNRaFRxWvzGJKuhAPMr0pRFizfmcThOeRuy/+qeezNufBrfjpQI9OY7/
        pXkJ5Bz9jAfFwattW9W80S+Ak3itmeoyXasleKQMbqSMpQSvg33T9Xh+M7P0Dspzt2HLY33rJ4L0H
        VdD+jHmC0/cAkBE2KSuPsjyWCD6CA9jkgplZzQrT14HuAP0bCpUfF7KTjrZwbVHV52v0vHr7mzVWo
        aQ3Um6kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnfTW-0000SX-DN; Wed, 17 Jul 2019 08:39:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF02420B15D60; Wed, 17 Jul 2019 10:39:44 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:39:44 +0200
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
Message-ID: <20190717083944.GR3463@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716184724.GH3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 16, 2019 at 08:47:24PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 01:19:16PM -0400, Alex Kogan wrote:
> > > On Jul 16, 2019, at 11:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > static void cna_move(struct cna_node *cn, struct cna_node *cni)
> > > {
> > > 	struct cna_node *head, *tail;
> > > 
> > > 	/* remove @cni */
> > > 	WRITE_ONCE(cn->mcs.next, cni->mcs.next);
> > > 
> > > 	/* stick @cni on the 'other' list tail */
> > > 	cni->mcs.next = NULL;
> > > 
> > > 	if (cn->mcs.locked <= 1) {
> > > 		/* head = tail = cni */
> > > 		head = cni;
> > > 		head->tail = cni;
> > > 		cn->mcs.locked = head->encoded_tail;
> > > 	} else {
> > > 		/* add to tail */
> > > 		head = (struct cna_node *)decode_tail(cn->mcs.locked);
> > > 		tail = tail->tail;
> > > 		tail->next = cni;
> > > 	}
> > > }
> > > 
> > > static struct cna_node *cna_find_next(struct mcs_spinlock *node)
> > > {
> > > 	struct cna_node *cni, *cn = (struct cna_node *)node;
> > > 
> > > 	while ((cni = (struct cna_node *)READ_ONCE(cn->mcs.next))) {
> > > 		if (likely(cni->node == cn->node))
> > > 			break;
> > > 
> > > 		cna_move(cn, cni);
> > > 	}
> > > 
> > > 	return cni;
> > > }
> > But then you move nodes from the main list to the ‘other’ list one-by-one.
> > I’m afraid this would be unnecessary expensive.
> > Plus, all this extra work is wasted if you do not find a thread on the same 
> > NUMA node (you move everyone to the ‘other’ list only to move them back in 
> > cna_mcs_pass_lock()).
> 
> My primary concern was readability; I find the above suggestion much
> more readable. Maybe it can be written differently; you'll have to play
> around a bit.

static void cna_splice_tail(struct cna_node *cn, struct cna_node *head, struct cna_node *tail)
{
	struct cna_node *list;

	/* remove [head,tail] */
	WRITE_ONCE(cn->mcs.next, tail->mcs.next);
	tail->mcs.next = NULL;

	/* stick [head,tail] on the secondary list tail */
	if (cn->mcs.locked <= 1) {
		/* create secondary list */
		head->tail = tail;
		cn->mcs.locked = head->encoded_tail;
	} else {
		/* add to tail */
		list = (struct cna_node *)decode_tail(cn->mcs.locked);
		list->tail->next = head;
		list->tail = tail;
	}
}

static struct cna_node *cna_find_next(struct mcs_spinlock *node)
{
	struct cna_node *cni, *cn = (struct cna_node *)node;
	struct cna_node *head, *tail = NULL;

	/* find any next lock from 'our' node */
	for (head = cni = (struct cna_node *)READ_ONCE(cn->mcs.next);
	     cni && cni->node != cn->node;
	     tail = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
		;

	/* when found, splice any skipped locks onto the secondary list */
	if (cni && tail)
		cna_splice_tail(cn, head, tail);

	return cni;
}

How's that?
