Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DD22ADE4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGWLkU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 07:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWLkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 07:40:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763DC0619DC;
        Thu, 23 Jul 2020 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kdvkLlB0WIqKZ1XY1QVM6XMLE4+I3RIvWx6RmMkENUQ=; b=WXaqbpyDkFyXzYWsaKmxUO6XOJ
        NHsi5kiF8SRTNR0efEuOMP5FTHTzkRIaNCVFEdC5pHGcz/+eMpoPOelGZxPcLn0+/n3RGFhPV/HrR
        YTFn/Bcrr9RL4JHs0NpbYeXnb+iYXKEEXzWvkTHy3eo3Wm1hYnCDil4KbawSbsyUH7BuvckQ9wQOl
        JSZcc0IE8OqaY3/6zoC8D8rSkfQSpObAfunyAuqz8Ee5zQrEnks0ZVf8k5oHHgWkNt2Zqjias8Kci
        5yzCJpOVEsqPUYYaaXTvQIU99DSjitCb13t7fPHUI6CwDAFcq8M7sdabKU1Fr63w/nwpKj/sPvYUM
        in7glj0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyZa8-0005JF-MA; Thu, 23 Jul 2020 11:40:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 988F49821EE; Thu, 23 Jul 2020 13:40:10 +0200 (CEST)
Date:   Thu, 23 Jul 2020 13:40:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200723114010.GO5523@worktop.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 3a0db7b0b46e..35060be09073 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>  #define powerpc_local_irq_pmu_save(flags)			\
>  	 do {							\
>  		raw_local_irq_pmu_save(flags);			\
> -		trace_hardirqs_off();				\
> +		if (!raw_irqs_disabled_flags(flags))		\
> +			trace_hardirqs_off();			\
>  	} while(0)
>  #define powerpc_local_irq_pmu_restore(flags)			\
>  	do {							\
> -		if (raw_irqs_disabled_flags(flags)) {		\
> -			raw_local_irq_pmu_restore(flags);	\
> -			trace_hardirqs_off();			\
> -		} else {					\
> +		if (!raw_irqs_disabled_flags(flags))		\
>  			trace_hardirqs_on();			\
> -			raw_local_irq_pmu_restore(flags);	\
> -		}						\
> +		raw_local_irq_pmu_restore(flags);		\
>  	} while(0)

You shouldn't be calling lockdep from NMI context! That is, I recently
added suport for that on x86:

  https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
  https://lkml.kernel.org/r/20200623083721.216740948@infradead.org

But you need to be very careful on how you order things, as you can see
the above relies on preempt_count() already having been incremented with
NMI_MASK.
