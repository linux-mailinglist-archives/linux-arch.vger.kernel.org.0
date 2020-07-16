Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04A92227BF
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGPPqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 11:46:24 -0400
Received: from mail.efficios.com ([167.114.26.124]:41972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGPPqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 11:46:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 159EB295C14;
        Thu, 16 Jul 2020 11:46:23 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ync1L2q1T9lv; Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CA374295C12;
        Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CA374295C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594914382;
        bh=vp71nmZTDnneRvjCieT0x9SqYt8j1qCXpo2gjxlL3so=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=K0GdpyhCRtALmYLXIh6DsJqf5JNfl+RI9XMaZP0aXJxChWcSX9OVVieyRrXb0RdNF
         /Jipc4A5/RnMwjqyEEjMbVvPgdIyqg6mfSDPHwU7+bVACA16/s7rBD/5S9Ry3GzbYz
         zozOXqGhRXMR7LQsMhcMdCiJxv4UqQcKzv23U33hh7+oS3VAGnpLQ7djUioTHcUXDS
         rK/z3rkvdslH/xm8AnVlglCB7mUKCwPJ2Wa5dCSeWU5gFMxAxZAqzIFqfrTeE61LmU
         I7C30UDlbJOPkIN+i5Daj+lxxaCposb7B788MeCho+Z3GlA44nFE/aH+PkU8QPciwE
         N4uKpWyshlp+Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LKw2bNJbhb-0; Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BE0E2295C10;
        Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
Date:   Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Message-ID: <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com>
In-Reply-To: <1594873644.viept6os6j.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com> <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com> <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none> <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com> <1594868476.6k5kvx8684.astroid@bobo.none> <1594873644.viept6os6j.astroid@bobo.none>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: cb6zdS0KPjkbq8hxmgetruE+ExgftQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
> I should be more complete here, especially since I was complaining
> about unclear barrier comment :)
> 
> 
> CPU0                     CPU1
> a. user stuff            1. user stuff
> b. membarrier()          2. enter kernel
> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
> d. read rq->curr         4. rq->curr switched to kthread
> e. is kthread, skip IPI  5. switch_to kthread
> f. return to user        6. rq->curr switched to user thread
> g. user stuff            7. switch_to user thread
>                         8. exit kernel
>                         9. more user stuff
> 
> What you're really ordering is a, g vs 1, 9 right?
> 
> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
> etc.
> 
> Userspace does not care where the barriers are exactly or what kernel
> memory accesses might be being ordered by them, so long as there is a
> mb somewhere between a and g, and 1 and 9. Right?

This is correct. Note that the accesses to user-space memory can be
done either by user-space code or kernel code, it doesn't matter.
However, in order to be considered as happening before/after
either membarrier or the matching compiler barrier, kernel code
needs to have causality relationship with user-space execution,
e.g. user-space does a system call, or returns from a system call.

In the case of io_uring, submitting a request or returning from waiting
on request completion appear to provide this causality relationship.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
