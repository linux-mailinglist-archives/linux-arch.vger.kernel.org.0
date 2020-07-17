Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76A9224081
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQQWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 12:22:52 -0400
Received: from mail.efficios.com ([167.114.26.124]:43290 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQQWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 12:22:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 420DC2C8FB5;
        Fri, 17 Jul 2020 12:22:50 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DrMZ3PK9QUvm; Fri, 17 Jul 2020 12:22:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E70C52C8CB5;
        Fri, 17 Jul 2020 12:22:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E70C52C8CB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1595002969;
        bh=SI5wUypTRLM5H8MPVlD9dpid26u5Bm0FCC72XQP4wSs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YOiv6ozxu4E6A5foQYmqBv+qNQXDkOPxMiTdoBYTzfQkc/ObGjUFdJzRTGNPcEAr1
         lUBBs0tfgyeEtGvPbVbpNKLDLR2NcnWYAQ3fbTM2Jjv2+/K9OQVZwcolRJ+weQMgSw
         Tr5O6JxmjIzYAdS7ta4wex86s9+HpeI8V+9kT3trf6Pk2OrQl3kxr6QSju4QZjD8V5
         Kj2ALcAIToCll1QYChYjzqCBuLNeaywR/i/IV+BY5RQcc1pEzBxwE/p72Bk90Vc53m
         CwsWAQ+kV7ZcU1QOZRkZIs44jSEHC/bES7rgw2BgUqr81nSLGdjdvrrqCMdG0ExOHl
         AuVcHb9PyJLdA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F1yIO4N-dRQg; Fri, 17 Jul 2020 12:22:49 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D3F542C8F1B;
        Fri, 17 Jul 2020 12:22:49 -0400 (EDT)
Date:   Fri, 17 Jul 2020 12:22:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Nicholas Piggin <npiggin@gmail.com>, paulmck <paulmck@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Message-ID: <12700909.18968.1595002969773.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200717161145.GA1150454@rowland.harvard.edu>
References: <20200710015646.2020871-1-npiggin@gmail.com> <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com> <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com> <20200716212416.GA1126458@rowland.harvard.edu> <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com> <20200717145102.GC1147780@rowland.harvard.edu> <1697220787.18880.1595000348405.JavaMail.zimbra@efficios.com> <20200717161145.GA1150454@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: 0YKEfKGIYUqxyDBXMitHDrNBdhjyuQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 17, 2020, at 12:11 PM, Alan Stern stern@rowland.harvard.edu wrote:

>> > I agree with Nick: A memory barrier is needed somewhere between the
>> > assignment at 6 and the return to user mode at 8.  Otherwise you end up
>> > with the Store Buffer pattern having a memory barrier on only one side,
>> > and it is well known that this arrangement does not guarantee any
>> > ordering.
>> 
>> Yes, I see this now. I'm still trying to wrap my head around why the memory
>> barrier at the end of membarrier() needs to be paired with a scheduler
>> barrier though.
> 
> The memory barrier at the end of membarrier() on CPU0 is necessary in
> order to enforce the guarantee that any writes occurring on CPU1 before
> the membarrier() is executed will be visible to any code executing on
> CPU0 after the membarrier().  Ignoring the kthread issue, we can have:
> 
>	CPU0			CPU1
>				x = 1
>				barrier()
>				y = 1
>	r2 = y
>	membarrier():
>	  a: smp_mb()
>	  b: send IPI		IPI-induced mb
>	  c: smp_mb()
>	r1 = x
> 
> The writes to x and y are unordered by the hardware, so it's possible to
> have r2 = 1 even though the write to x doesn't execute until b.  If the
> memory barrier at c is omitted then "r1 = x" can be reordered before b
> (although not before a), so we get r1 = 0.  This violates the guarantee
> that membarrier() is supposed to provide.
> 
> The timing of the memory barrier at c has to ensure that it executes
> after the IPI-induced memory barrier on CPU1.  If it happened before
> then we could still end up with r1 = 0.  That's why the pairing matters.
> 
> I hope this helps your head get properly wrapped.  :-)

It does help a bit! ;-)

This explains this part of the comment near the smp_mb at the end of membarrier:

         * Memory barrier on the caller thread _after_ we finished
         * waiting for the last IPI. [...]

However, it does not explain why it needs to be paired with a barrier in the
scheduler, clearly for the case where the IPI is skipped. I wonder whether this part
of the comment is factually correct:

         * [...] Matches memory barriers around rq->curr modification in scheduler.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
