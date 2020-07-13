Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303F421D808
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGMONX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 10:13:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:37366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMONW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 10:13:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0BA312A2098;
        Mon, 13 Jul 2020 10:13:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id S1h_oqHPAlK4; Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A10902A2097;
        Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A10902A2097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594649601;
        bh=XqbvFKyVtrLGiel3RNeXGdRx+Uy0i/kVfU8B2yF1Vps=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Qd1+LkijOFRpXZ/hXeFVcIG1XDUyqXzMXheUxr4ymNDATWBtzeRngQgvcgj1UN/wQ
         a9IWntemPvANBJkCv+ERziZWUMAWLW9cP3K2yHa0C4iZse4IBq+mcswHdB4yV1Cg8K
         6D/h9sOILkANM3IpHWbJhPJIf2sPpUglCT5mgqXufzzgoLEtwLI2fVzhds7D2JYmJ2
         kozUnFllcUdECvQnMyCBRLCcx80bHdl0oKGXL1s1m8v++a/xNb2jFnua9X23Kw4kta
         KoKqnpbNCDTT6DbG6m+7xwuBBzaT9X3McZ5iKcLDXTeNqD4ZRR/bwS+QaU/QuK5WWE
         H81CVMOQJRUDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gnjQutJ2gIVJ; Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 91AC42A2095;
        Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
Date:   Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Message-ID: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
In-Reply-To: <1594647408.wmrazhwjzb.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com> <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com> <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: T7nLE24o9VdoF/eNvu+hhgTHKlctBA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrote:

> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>> serialize.  There are older kernels for which it does not promise to
>>> serialize.  And I have plans to make it stop serializing in the
>>> nearish future.
>> 
>> You mean x86's return from interrupt? Sounds fun... you'll konw where to
>> update the membarrier sync code, at least :)
> 
> Oh, I should actually say Mathieu recently clarified a return from
> interrupt doesn't fundamentally need to serialize in order to support
> membarrier sync core.

Clarification to your statement:

Return from interrupt to kernel code does not need to be context serializing
as long as kernel serializes before returning to user-space.

However, return from interrupt to user-space needs to be context serializing.

Thanks,

Mathieu

> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214171.html
> 
> So you may not need to do anything more if you relaxed it.
> 
> Thanks,
> Nick

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
