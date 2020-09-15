Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A798926A420
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIOL1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIOL10 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 07:27:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6EAC06174A;
        Tue, 15 Sep 2020 04:26:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BrLXQ46X3z9sTN;
        Tue, 15 Sep 2020 21:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600169192;
        bh=4esK02AyElAnyDXkxcmOZ58SrlxD5sLeYfaYLnFksAA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EqW4ku7Y8V1CrYGyOReTmatCQO246pQi3XD9hK8QImXa+8kAvrroYZZVLIhB5Cv/L
         1HEJZtQS+acKXCy5mMNetAonLI2gIKpEbZxxPKtbRyxAhp7DbXfXGjBEQew0/9IUzn
         uRXbt4CCQ1FGVyJHUik+SPO4pM7Ori2zZ2q8Sd+rd7hSHtcrPmjcbc39dwb8ouGs30
         Ogk0REO3vpcreFt7pS/TdkFGqXscY4gN+KJ+bOxq48bkRgo6e0daxPDJKsbboli0bK
         vt48IMrpUsOzMpDaqIlp3QryBj7HBTRa4U3hJ9O+w+fwBRbfp40WWPlE48hxMPs7KN
         n614Pr2VN9Jeg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, peterz@infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org,
        "linux-mm \@ kvack . org" <linux-mm@kvack.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
In-Reply-To: <1600137586.nypnz3sbcl.astroid@bobo.none>
References: <20200914045219.3736466-1-npiggin@gmail.com> <20200914045219.3736466-2-npiggin@gmail.com> <20200914105617.GP1362448@hirez.programming.kicks-ass.net> <1600137586.nypnz3sbcl.astroid@bobo.none>
Date:   Tue, 15 Sep 2020 21:26:29 +1000
Message-ID: <87lfhbp9ga.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from peterz@infradead.org's message of September 14, 2020 8:56 pm:
>> On Mon, Sep 14, 2020 at 02:52:16PM +1000, Nicholas Piggin wrote:
>>> Reading and modifying current->mm and current->active_mm and switching
>>> mm should be done with irqs off, to prevent races seeing an intermediate
>>> state.
...
>>> 
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> 
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> 
>> I'm thinking we want this selected on x86 as well. Andy?
>
> Thanks for the ack. The plan was to take it through the powerpc tree,
> but if you'd want x86 to select it, maybe a topic branch? Although
> Michael will be away during the next merge window so I don't want to
> get too fancy. Would you mind doing it in a follow up merge after
> powerpc, being that it's (I think) a small change?

Or get akpm to take the series, including the x86 change.

cheers
