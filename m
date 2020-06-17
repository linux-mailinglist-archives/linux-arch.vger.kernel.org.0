Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4271FC309
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 02:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQAyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 20:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2020 20:54:52 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE9C061573;
        Tue, 16 Jun 2020 17:54:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mmn31DRrz9sRR;
        Wed, 17 Jun 2020 10:54:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592355289;
        bh=Tt4ck1L8nY61ACyfCaQSk9IvU7WHJrdCNXj+0siSSyg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X9ymJOnvys9Xta0MkoWBUczKpvqc1UyN/Q9aQyWmLXe1VKUTEmNDQSj0rsR9Q534F
         p6Cep2OQrqfnlebt9PQxQzVrQBhhGf8vxbnkZ2KkloITdv6wE3e3fWf2KzjAQ/3rHv
         4Rf2KtyRVAUQ0TfXasgP2KtS5MyWwwXfSxOEHZFxwBGwJ77QG/uKkxjIM9la7HY3Yo
         s6mWsZ+5Aa9gVpDy6HW9lFlvnILbbuGiSBVRHnfji5SIv8PgYQDi4XcBz//pG5rD8Z
         yHLXPGR8ugwb3hM4yDbup0N8aruEnPrwavrRY0cCsW8tvoiEuDekDUjg2hB93vQcq9
         r0IQCg06h+QGQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
In-Reply-To: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
References: <20200615221607.7764-1-peterx@redhat.com> <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Date:   Wed, 17 Jun 2020 10:55:14 +1000
Message-ID: <87imfqecjx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
>> This series tries to address all of them by introducing mm_fault_accounting()
>> first, so that we move all the page fault accounting into the common code base,
>> then call it properly from arch pf handlers just like handle_mm_fault().
>
> Hmm.
>
> So having looked at this a bit more, I'd actually like to go even
> further, and just get rid of the per-architecture code _entirely_.

<snip>

> One detail worth noting: I do wonder if we should put the
>
>     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>
> just in the arch code at the top of the fault handling, and consider
> it entirely unrelated to the major/minor fault handling. The
> major/minor faults fundamnetally are about successes. But the plain
> PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> things that never even get to this point at all.

Yeah I think we should keep it in the arch code at roughly the top.

If it's moved to the end you could have a process spinning taking bad
page faults (and fixing them up), and see no sign of it from the perf
page fault counters.

cheers
