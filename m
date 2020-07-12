Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884121CAB8
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGLReA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 13:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLReA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 13:34:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791BC061794;
        Sun, 12 Jul 2020 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VjG5zlgh34sBQ3QQEiUxzk4P+1+7+KnailD04PiPvJU=; b=hm2EhBt4w/7UBueo8WsEQhva8L
        medldEYPyasGvpj/2yk9mZzvcRZx2Cw9Yj6lS8n0Cy93tRlCGT1UPPLfpHcFx1hZzDNgBLPX816Lq
        iTQB5zSZWlrnpVD3eTW2IvVWIVMB8DtlIYMLQw/+LV+6OzH+y49yfxb+tTEJwAWnusCpVCJ9rKQxl
        bQVoEZjAjLIy23S3dP4Q/cFP/6a3z103W5VjTFilkBimCsb8j94AdXwmMTcJ2j7Ok3bNXIRieeV8o
        2v6n815aYrT6RQKYkiAZ4Mm42z9Og6OxCYnpFIO5jgBxeoaVviOYun1bdQvCvMiMHjitUdpInupze
        uLaNJeLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jufrL-0002dD-A9; Sun, 12 Jul 2020 17:33:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC53D300F7A;
        Sun, 12 Jul 2020 19:33:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EF8D201C9154; Sun, 12 Jul 2020 19:33:48 +0200 (CEST)
Date:   Sun, 12 Jul 2020 19:33:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/2] locking/qspinlock: Store lock holder cpu in lock if
 feasible
Message-ID: <20200712173348.GA10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711182128.29130-2-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 11, 2020 at 02:21:27PM -0400, Waiman Long wrote:

> +static DEFINE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval) = _Q_LOCKED_VAL;
>  
>  /*
>   * We must be able to distinguish between no-tail and the tail at 0:0,
> @@ -138,6 +139,19 @@ struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
>  
>  #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
>  
> +static __init int __init_pcpu_lockval(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		u8 lockval = (cpu + 2 < _Q_LOCKED_MASK - 1) ? cpu + 2
> +							    : _Q_LOCKED_VAL;
> +		per_cpu(pcpu_lockval, cpu) = lockval;
> +	}
> +	return 0;
> +}
> +early_initcall(__init_pcpu_lockval);

> +	u8 lockval = this_cpu_read(pcpu_lockval);

Urgh... so you'd rather read a guaranteed cold line than to use
smp_processor_id(), which we already use anyway?

I'm skeptical this helps anything, and it certainly makes the code more
horrible :-(
