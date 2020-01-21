Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA4143E8B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUNsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 08:48:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgAUNsv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 08:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZRFLHsIXPNKN7m2gKwGNqmIbjCAilF0DyWkBc02k/Q=; b=VQ2GyazjXuHrCqFKzsJNA2QDs
        P5nH0yFV/Hn6G9/KQmZg8eMTGBQAt8r3njxkVnwk8JOwgZY62zUX19a1eUrJLrQVXH72beBy3bYe9
        zMau88tQQ/QPDHOA2F++2UHTujH+vU25sHFCbE2w72HYFRGpi5di1qhJcxrnlqF1huBv413LLaGlZ
        pm76QGlCihYNBFN7VoTGyLVF4D6HCcpRmQP2QLx32d222SoJk+/Fbt9Qf+Uz98XotT++Pl0PAI7N/
        4PtbFlyCHhkGiauiLTtDqDw+v2MZ7GiZ6nhZfSAqCy3k42D/l5M+jBufXwVejtghPYJUSd4EKQjHn
        VbUacaoyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itttS-0002LK-WA; Tue, 21 Jan 2020 13:48:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EACC73060ED;
        Tue, 21 Jan 2020 14:46:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 185EF20983FC0; Tue, 21 Jan 2020 14:48:31 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:48:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200121134831.GM14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 30, 2019 at 02:40:40PM -0500, Alex Kogan wrote:
> +#define try_clear_tail			cna_try_change_tail

That's inconsistent; please run
's/cna_try_change_tail/cna_try_clear_tail/g' on your patch.
