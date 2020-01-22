Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D21451D6
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgAVJ4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 04:56:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgAVJ4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mn6+IrA1OMHHWbypsNWVR2N6HpOhrjkcIFslmxed/eo=; b=HsXlNynEa7rAEPUuseLjSSMDy
        Q2ZIa+JF/SWMm8NTGS8kjTYTm7k0lmwRA2N26GdpaTOKT7x6Rl74bbquaC31sEv1UEuVdTeoACjpE
        haJLzgbT37Mo4QRNy5zwDjdV2PVjIiJD8NA5dTQzxG9CxVJjPsTgT85KxGpC3f1ErrKC+g93uNeCb
        fMuc+IqdAHHLniSmW61yM4llntPLgFo+BhqrJ2PXXNxJVoEUBE4qmEH5qhabFL0skPb+Q4VfLPqiW
        uvadfmJBWkox6SFdYK2MSEmSql0HHYH9azJA1+tZSF5HROGmtQK6z/OpK1WAz7jom9SSmk3lhOCzq
        6UpyNdydA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuCkL-00026Y-Ic; Wed, 22 Jan 2020 09:56:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C2543060D3;
        Wed, 22 Jan 2020 10:54:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE68D20983E31; Wed, 22 Jan 2020 10:56:22 +0100 (CET)
Date:   Wed, 22 Jan 2020 10:56:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 5/5] locking/qspinlock: Introduce the shuffle
 reduction optimization into CNA
Message-ID: <20200122095622.GS14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-6-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-6-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 30, 2019 at 02:40:42PM -0500, Alex Kogan wrote:
> @@ -251,8 +281,11 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
>  	struct cna_node *cn = (struct cna_node *)node;
>  
>  	cn->pre_scan_result =
> -		cn->intra_count == intra_node_handoff_threshold ?
> -			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);
> +		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> +			PASS_LOCK_IMMEDIATELY :
> +			cn->intra_count == intra_node_handoff_threshold ?
> +				FLUSH_SECONDARY_QUEUE :
> +				cna_scan_main_queue(node, node);
>  
>  	return 0;
>  }

Let me just, once again, remind people that the Linux Kernel is not part
of the Obfuscated C code contest.

> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Seriously, in what universe is that actually readable code? Steve quick,
say what it does.
