Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0A65C6F8
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjACTJG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjACTI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:08:59 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2E13E2E
        for <linux-arch@vger.kernel.org>; Tue,  3 Jan 2023 11:08:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c11so25263096qtn.11
        for <linux-arch@vger.kernel.org>; Tue, 03 Jan 2023 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dfSqSd0mxRLyCP4JPwoGgPSv4V5DgFE+NWQibLY7nHY=;
        b=LQt5OMztUt6H+6pe/VIHwx3Jz4d08J1ZZ7gv40yLS2RfQ9FYAN2BdqaHFaDSeqruh5
         UdriUa0s5l2hHmuDgCVQyqdP1mZma/3SqbLGsgMr+3W5DNoGaGK3GwMdoJI3ZUgmswPc
         hfRjTsp+o7b/O9CFRqovudaZXidsusavosKQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfSqSd0mxRLyCP4JPwoGgPSv4V5DgFE+NWQibLY7nHY=;
        b=Ppr/F23QBN/eeKk5+uC5Z2YYUMLKurO7CS9CeBhp0DFWjm08Q3baOCQqScn16rVJjp
         G7UKqCAlG9K+bT068A8jtenMGmfBDKnBSnSWU9RZbFVtXMZbdSrSKZrGb2tCQwCCsejH
         INv6FkG2bn9ykXnv5kt7WKoCsn2JvTMj3gZZLVkngUUr2BzLFeQjzHYQgVckTmkMshjO
         QmROEdX3uKBgdmtd/WgdshydbnXml++Zsv1pOS5o8AFx32LkHqOepARvYxpoHnvcaDUB
         QUei2XYMO8nxeH01kXpAHbeoh0kQDffcENJvLK/mr/sJRJkH7uktuDjDjzIuJK9NOARS
         Ms1A==
X-Gm-Message-State: AFqh2krV9CSUwhcZMHBEnuREX+OsbccQ+gOyDCWN1xsJ3y8R7B0DWijE
        jGPZ+qWm2PJ1aGd+m4rKLlQe4we2mRnIbr8e
X-Google-Smtp-Source: AMrXdXu+dDGC0dPWUcraqhCcqYBwDtRKv1qPlDgPgKy9fZYSkQnAE9lRd2aHJbpa7NIDc6iYER7z9Q==
X-Received: by 2002:a05:622a:a0b:b0:3a6:a7f6:701d with SMTP id bv11-20020a05622a0a0b00b003a6a7f6701dmr72618209qtb.36.1672772937549;
        Tue, 03 Jan 2023 11:08:57 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id t22-20020ac87616000000b003a82ca4e81csm19378602qtq.80.2023.01.03.11.08.56
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:08:56 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id g7so25315206qts.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Jan 2023 11:08:56 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr1650146qkl.216.1672772925520; Tue, 03
 Jan 2023 11:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris>
In-Reply-To: <Y7Ri+Uij1GFkI/LB@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 11:08:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
Message-ID: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 3, 2023 at 9:17 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Mon, Dec 19, 2022 at 04:35:36PM +0100, Peter Zijlstra wrote:
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/slub_def.h |   12 ++-
> >  mm/slab.h                |   41 +++++++++++--
> >  mm/slub.c                |  146 ++++++++++++++++++++++++++++-------------------
> >  3 files changed, 135 insertions(+), 64 deletions(-)
>
> Does this actually work? Just wondering since I end up with an instant
> list corruption on s390. Might be endianness related, but I can't see
> anything obvious at a first glance.

I don't see anything that looks related to endianness, because while
there is that 128-bit union member, it's always either used in full,
or it's accessed as other union members.

But I *do* note that this patch seems to be the only one that depends
on the new this_cpu_cmpxchg() updates to make it just automatically do
the right thing for a 128-bit value. And I have to admit that all
those games with __pcpu_cast_128() make no sense to me. Why isn't it
just using "u128" everywhere without any odd _Generic() games?

I could also easily see that if the asm constraints are wrong (like
the "cast pointer to (unsigned long *) instead of keeping it pointing
to a 128-bit type" thing discussed earlier), then code like this:

+       freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
+       freelist_aba_t new = { .freelist = freelist_new, .counter =
next_tid(tid) };
+
+       return this_cpu_cmpxchg(s->cpu_slab->freelist_tid.full,
+                               old.full, new.full) == old.full;

would easily make the compiler go "the second word of 'old' is never
used by the asm, so I won't initialize it".

But yeah, that patch is hard to read, so hard to say. Does everything
leading up to it work fine?

                 Linus
