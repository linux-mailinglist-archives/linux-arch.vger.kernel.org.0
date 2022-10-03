Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091BA5F3825
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 23:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJCVyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 17:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJCVyr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 17:54:47 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7C65AF
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 14:54:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id m14so2369492ilf.12
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B9z/9SQNxbpWjvmm/wRDVvjtOvq9DNKsvNJ7C0aaLM0=;
        b=qkgELbA88YoJdu4NDU/eZjukcJBQUua5vbUOpqJZO+6P5Ox9LwRbghDc2G52DKQCZb
         XadYlJx6N9UigaTBKr2gZBGqmm/u6EBox1eysnEqKczkPt1VpfNu96zO8f5KjwBEVOTj
         rRjNyET1Spa98kAaOa8zY1x3h1MEWEihJZWsU3kzCz3U47r5Kvy+gtjpArdM7eVWoTJp
         TFXfwMYJCnsDbkwvzY4tcfZNE5vDSbw6sLgtcUTCzp95mgpwWDmNLmWXjHsNlKUmZdrK
         /F5XheAdLo6w+yhK0394q+fqmzw1c6qwXBl6WF66CB1cytg0ftAtThrRJLZfgiibFo3s
         n43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B9z/9SQNxbpWjvmm/wRDVvjtOvq9DNKsvNJ7C0aaLM0=;
        b=U7WbkdQcMRaInXvONAdYwNS8WBVPJkWs055+TJd4+r00xCXvdwEfv1/S3UBjW6GtCQ
         5R0pP4/r+PrbuBRb8OZ+YZrgpYKaAq0VDmyfSvqxkxdisCqaxchQX4ujNtShgnZIw5zF
         2YUbuKnCPPvLrDvMg2XLKusxQgb2nR/cLioFAFhSYVygw1aQ+H9RFIE1H1VZXxe7y5oK
         xunuNHcfKJGpm0l0eTa1UrXbARImWZeo/O/olkNg1+eGX1H8roxVsvo+3Y0ty87Nyjac
         fa+fnSBlqrDITfDRvKU0g7ZaqV0lAcXiumXJnew3wCJC4VHG4M8d/QG1hLIbF7fPjqJq
         6jeA==
X-Gm-Message-State: ACrzQf1IYIXvFp11uJC1KAfAWmOr47qfTc0xet0oPqNwh8ufyrXu+cNZ
        7+RclDjormhyYlkzbmsT4FwFzJrx5c/5GU4HE+ez6g==
X-Google-Smtp-Source: AMsMyM7Lwn5JTYtwxSYRtSvhpSISgiKk0FRQjsyMwSmKYMtj3PZV1xsCNnSr0tYCqZod5/YNjy4u6ARcikVLiWlyv+M=
X-Received: by 2002:a05:6e02:930:b0:2f9:9d1b:2525 with SMTP id
 o16-20020a056e02093000b002f99d1b2525mr4355276ilt.173.1664834083749; Mon, 03
 Oct 2022 14:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com> <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
 <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
In-Reply-To: <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Oct 2022 23:54:07 +0200
Message-ID: <CAG48ez1S+zN1tLKYuPL-yBu-ZxT7AMm5faWypi3J-XtnQCUiEg@mail.gmail.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022 at 11:36 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Mon, 2022-10-03 at 19:26 +0300, Kirill A . Shutemov wrote:
> > On Thu, Sep 29, 2022 at 03:29:07PM -0700, Rick Edgecombe wrote:
> > > +/*
> > > + * Normally the Dirty bit is used to denote COW memory on x86. But
> > > + * in the case of X86_FEATURE_SHSTK, the software COW bit is used,
> > > + * since the Dirty=1,Write=0 will result in the memory being
> > > treated
> > > + * as shaodw stack by the HW. So when creating COW memory, a
> > > software
> > > + * bit is used _PAGE_BIT_COW. The following functions pte_mkcow()
> > > and
> > > + * pte_clear_cow() take a PTE marked conventially COW (Dirty=1)
> > > and
> > > + * transition it to the shadow stack compatible version of COW
> > > (Cow=1).
> > > + */
> > > +
> > > +static inline pte_t pte_mkcow(pte_t pte)
> > > +{
> > > +     if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > > +             return pte;
> > > +
> > > +     pte = pte_clear_flags(pte, _PAGE_DIRTY);
> > > +     return pte_set_flags(pte, _PAGE_COW);
> > > +}
> > > +
> > > +static inline pte_t pte_clear_cow(pte_t pte)
> > > +{
> > > +     /*
> > > +      * _PAGE_COW is unnecessary on !X86_FEATURE_SHSTK kernels.
> > > +      * See the _PAGE_COW definition for more details.
> > > +      */
> > > +     if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> > > +             return pte;
> > > +
> > > +     /*
> > > +      * PTE is getting copied-on-write, so it will be dirtied
> > > +      * if writable, or made shadow stack if shadow stack and
> > > +      * being copied on access. Set they dirty bit for both
> > > +      * cases.
> > > +      */
> > > +     pte = pte_set_flags(pte, _PAGE_DIRTY);
> > > +     return pte_clear_flags(pte, _PAGE_COW);
> > > +}
> >
> > These X86_FEATURE_SHSTK checks make me uneasy. Maybe use the
> > _PAGE_COW
> > logic for all machines with 64-bit entries. It will get you much more
> > coverage and more universal rules.
>
> Yes, I didn't like them either at first. The reasoning originally was
> that _PAGE_COW is a bit more work and it might show up for some
> benchmark.
>
> Looking at this again though, it is just a few more operations on
> memory that is already getting touched either way. It must be a very
> tiny amount of impact if any. I'm fine removing them. Having just one
> set of logic around this would make it easier to reason about.
>
> Dave, any thoughts on this?

But the rules wouldn't actually be universal - you'd still have to
look at X86_FEATURE_SHSTK in code that wants to figure out whether a
PTE is shadow stack (on a newer CPU) or readonly dirty (on an older
CPU that can set dirty bits on non-present PTEs), right?
