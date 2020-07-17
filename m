Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E600223D1E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgGQNmo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 09:42:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:50558 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 09:42:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5F54929F2A7;
        Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jN3jsl16ovkH; Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 268FE29EE7D;
        Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 268FE29EE7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594993363;
        bh=GC3ddsIx6YDC8lre9W0wbffnyhB0KFZu7j1u1JF1RP4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ma1zH3Z6Oeo1HyVTHrIgYu0S5+/f5NlI5oZGjrclUDdUk18Tg4/VuFnjycHtN9Vhl
         sHyN6b0BIuUNyIiFUSS1MpzDqQKdTtspMfIhcqr+R5J0T95VclTBCmJaHvTXKKbS2p
         QJcy0KLegYDbAsdBWn3aNfC3XZun9bz247aORtgXdbBzyO9mQvEhzU3crDU29vaYB8
         GH+77edaFwX31CtCGmKZdb7O6ZUa9Z7muSP11UDvBtwWQohm8m1qDbiyDakxGyYlZO
         WpjPpFk77z+zr2V190Qr197qyRK0Y+ftgdEnM+B/+RFJUG48nt09inMjQ9ndQ7P1Nk
         s6Vt4gmCzqQOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nr_pEIWotEQc; Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 13F0629F31E;
        Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
Date:   Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Message-ID: <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
In-Reply-To: <1594906688.ikv6r4gznx.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net> <20200716085032.GO10769@hirez.programming.kicks-ass.net> <1594892300.mxnq3b9a77.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net> <1594906688.ikv6r4gznx.astroid@bobo.none>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: tih2wG5S7/k8ds/ZwlGdEfhVUfBRJg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wrote:
[...]
> 
> membarrier does replace barrier instructions on remote CPUs, which do
> order accesses performed by the kernel on the user address space. So
> membarrier should too I guess.
> 
> Normal process context accesses like read(2) will do so because they
> don't get filtered out from IPIs, but kernel threads using the mm may
> not.

But it should not be an issue, because membarrier's ordering is only with respect
to submit and completion of io_uring requests, which are performed through
system calls from the context of user-space threads, which are called from the
right mm.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
