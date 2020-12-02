Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761D32CB2ED
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 03:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgLBCun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 21:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgLBCum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 21:50:42 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF26C0613D4;
        Tue,  1 Dec 2020 18:50:02 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id r2so301299pls.3;
        Tue, 01 Dec 2020 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=cQulqwTG5/+FKQNusgjvEPfQ8LJuFbT6VbTDryDflxw=;
        b=gswJVu4rOSQ8N4hID+k14MxofbGrn5oUbk4d+sSDWLmSmpTKLtWi+wskJUT4fc7hTC
         LeY6if6Fh6DblFlCGLNq24vdipRHhKBkzdyk76Zh0EAiLjC4PJ2TX/ZnZgp9VnKXJI22
         BYXUeYA/o38Ik42izjE7nN3DDJcO7dMThBErfVvlf1CIe2agS2ZZBLb9g01E00o4n4A1
         itDLc51pNSjHuLF8gQYRTM0xJs+Fga0hsGUJbxfdM6zdAo/2C2crcRVk/lKqVzk5HrJh
         uHpGzUvQHbeAC4DyFaPk/aKY2B6+npKJkwFyL0Oqfy1rH96rWPrWFzrbsEjZGAXEUsF1
         im8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=cQulqwTG5/+FKQNusgjvEPfQ8LJuFbT6VbTDryDflxw=;
        b=DDbzF9iB2KNF9ejf2BIB7VBCs1HvuWRiFxGV4Rca4mc/Llta/PO5vbDbgbSKK3Ld2A
         H1A1IZPdCF4/XZr9isgsNr8ySMY5PSy+TfnZ2NJjbDCU9wwbvw/j04GJvCczHVu3aKt3
         kXmd5G9xn1HyKuWHz43ijsfmhRB9sHLcTWYMqau9vioqXAr+zug8XOCq3Ly0MClB4usf
         tPQHg1euCA4fon3oBkE73Kp8XHpSmqqVIefh/xcuFQ8EvWsFLxJgAzFenw5D58gRb0ES
         4H34mfyxocliu0vGZ730Foq/GGkkrvR8ZEDQr56SZrH/5UdaqWpfYoCz7V9gwEGBslfS
         +8Mg==
X-Gm-Message-State: AOAM5300sdfcPee5MkA080DKoz+XdwaQIOpB//dDAzfVRHxo3m9s2AJI
        oB120+k09t+vYoNcC+1jACk=
X-Google-Smtp-Source: ABdhPJwgLHQbFa4c6y7A2FXBrGv4J5hKeX6Te1QlRRdopHTV/3PR/OFLgCF3bk/OzO6mk4nBSzftsA==
X-Received: by 2002:a17:902:e787:b029:d9:f88d:c32d with SMTP id cp7-20020a170902e787b02900d9f88dc32dmr603516plb.79.1606877401804;
        Tue, 01 Dec 2020 18:50:01 -0800 (PST)
Received: from localhost ([1.132.177.56])
        by smtp.gmail.com with ESMTPSA id u24sm290208pfm.51.2020.12.01.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 18:50:00 -0800 (PST)
Date:   Wed, 02 Dec 2020 12:49:53 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20201128160141.1003903-1-npiggin@gmail.com>
        <20201128160141.1003903-3-npiggin@gmail.com>
        <CALCETrXYkbuJJnDv9ijfT+5tLQ2FOvvN1Ugoh5NwOy+zHp9HXA@mail.gmail.com>
In-Reply-To: <CALCETrXYkbuJJnDv9ijfT+5tLQ2FOvvN1Ugoh5NwOy+zHp9HXA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1606876327.dyrhkih2kh.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of November 29, 2020 3:55 am:
> On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> And get rid of the generic sync_core_before_usermode facility. This is
>> functionally a no-op in the core scheduler code, but it also catches
>>
>> This helper is the wrong way around I think. The idea that membarrier
>> state requires a core sync before returning to user is the easy one
>> that does not need hiding behind membarrier calls. The gap in core
>> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
>> tricky detail that is better put in x86 lazy tlb code.
>>
>> Consider if an arch did not synchronize core in switch_mm either, then
>> membarrier_mm_sync_core_before_usermode would be in the wrong place
>> but arch specific mmu context functions would still be the right place.
>> There is also a exit_lazy_tlb case that is not covered by this call, whi=
ch
>> could be a bugs (kthread use mm the membarrier process's mm then context
>> switch back to the process without switching mm or lazy mm switch).
>>
>> This makes lazy tlb code a bit more modular.
>=20
> I have a couple of membarrier fixes that I want to send out today or
> tomorrow, and they might eliminate the need for this patch.  Let me
> think about this a little bit.  I'll cc you.  The existing code is way
> to subtle and the comments are far too confusing for me to be quickly
> confident about any of my conclusions :)
>=20

Thanks for the head's up. I'll have to have a better look through them=20
but I don't know that it eliminates the need for this entirely although
it might close some gaps and make this not a bug fix. The problem here=20
is x86 code wanted something to be called when a lazy mm is unlazied,
but it missed some spots and also the core scheduler doesn't need to=20
know about those x86 details if it has this generic call that annotates
the lazy handling better.

I'll go through the wording again and look at your patches a bit better
but I think they are somewhat orthogonal.

Thanks,
Nick
