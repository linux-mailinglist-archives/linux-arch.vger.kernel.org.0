Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437D4DCA33
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409128AbfJRQDN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408951AbfJRQDN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEB5E3071D94;
        Fri, 18 Oct 2019 16:03:12 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250A95D71C;
        Fri, 18 Oct 2019 16:03:11 +0000 (UTC)
Subject: Re: [PATCH v5 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191016042903.61081-1-alex.kogan@oracle.com>
 <20191016042903.61081-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6ce50aeb-6b87-5d1c-9011-4329e8dadfec@redhat.com>
Date:   Fri, 18 Oct 2019 12:03:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191016042903.61081-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 18 Oct 2019 16:03:13 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/16/19 12:29 AM, Alex Kogan wrote:
> +static inline void cna_pass_lock(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +	struct mcs_spinlock *next_holder = next, *tail_2nd;
> +	u32 val = 1;
> +
> +	u32 scan = cn->pre_scan_result;
> +
> +	/*
> +	 * check if a successor from the same numa node has not been found in
> +	 * pre-scan, and if so, try to find it in post-scan starting from the
> +	 * node where pre-scan stopped (stored in @pre_scan_result)
> +	 */
> +	if (scan > 0)
> +		scan = cna_scan_main_queue(node, decode_tail(scan));
> +
> +	if (!scan) { /* if found a successor from the same numa node */
> +		next_holder = node->next;
> +		/*
> +		 * make sure @val gets 1 if current holder's @locked is 0 as
> +		 * we have to store a non-zero value in successor's @locked
> +		 * to pass the lock
> +		 */
> +		val = node->locked + (node->locked == 0);

node->locked can be 0 when the cpu enters into an empty MCS queue. We
could unconditionally set node->locked to 1 for this case in qspinlock.c
or with your above code. Perhaps, a comment about when node->locked will
be 0.

It may be easier to understand if you just do

    val = node->locked ? node->locked : 1;

Cheers,
Longman
