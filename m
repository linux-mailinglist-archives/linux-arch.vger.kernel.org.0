Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0039C21B260
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJJgQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJgP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 05:36:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8EC08C5CE;
        Fri, 10 Jul 2020 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pz3n/bmDz0/TOVCscTPa/2tvCyIHBk++33SZIn5QfrE=; b=qOccywes3VQXkn+HfWcUHh55kG
        MBOf7pYpA0zeOdJZRzb8sneDHo+1Q3OHPGdPY2ldjVM4B0dbh+9It/saBEg0oROqO4ei9uPf3QKzC
        oFUwOUawlzbiFkl2L7vbe/Hdpf0GwTPaLwZ1X6QXqxGfEYYscRVeZu90wbFsSX3RFtfhxuzmnQ6TL
        qX1W81Z3c4irF3kbpp/6qIevZa+30MiN383Fmau66CgysGMLTDGqiO4GbofMgSIrBD9+0H+cicSm4
        gm/mnvE5MHLhWI+5T35OceZPl6zIEQzoRSsyByeQivEfIKZI+ZoOHtDKTj5QsaGVCK7eljKXWc6N2
        JHJnfJsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtpRl-0001Ay-M5; Fri, 10 Jul 2020 09:35:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96A0F3013E5;
        Fri, 10 Jul 2020 11:35:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 837652B5130C4; Fri, 10 Jul 2020 11:35:56 +0200 (CEST)
Date:   Fri, 10 Jul 2020 11:35:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Message-ID: <20200710093556.GY4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-8-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 11:56:46AM +1000, Nicholas Piggin wrote:
> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
> 
> Abandoning lazy tlb slows switching down quite a bit in the important
> user->idle->user cases, so so instead implement a non-refcounted scheme
> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> any remaining lazy ones.
> 
> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second. After this patch it goes up to 118 million.

That's mighty impressive, however:

> +static void shoot_lazy_tlbs(struct mm_struct *mm)
> +{
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
> +		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
> +		do_shoot_lazy_tlb(mm);
> +	}
> +}

IIRC you (power) never clear a CPU from that mask, so for other
workloads I can see this resulting in massive amounts of IPIs.

For instance, take as many processes as you have CPUs. For each,
manually walk the task across all CPUs and exit. Again.

Clearly, that's an extreme, but still...


