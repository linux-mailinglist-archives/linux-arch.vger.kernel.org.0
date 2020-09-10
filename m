Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75531264B60
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJRgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgIJRgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 13:36:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63138C061573
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 10:35:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so9227181ljg.9
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV9NvYryEbzez94zd9hdsCWt3FfBuGGawTOfDap0eBk=;
        b=CyoQUM+SKXH6085O6WtByg3nDuki2CTSBORvYvwm25BqShZutFnNs6mSZACayZwSEH
         qcd6gDs3XmrAOcCBysWWLpsCbEXmLRDCQnQxo0ENK46fWC+ppV/l5rSOr47qH79HuDsY
         BAC6cJAHl7u65bYmrM5WLZPBZBfoI7ltEXEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV9NvYryEbzez94zd9hdsCWt3FfBuGGawTOfDap0eBk=;
        b=psYXBPgOrfhRoA+A0OtwD+g2Z01SSL7VfII3oSIqZYiS/1rz82l9Vgn/TmY0C+t+/P
         ZYWRH+WI926Rf9cplFlDyvax/dlXJKoh5tsOBptwjzzjmmg7lsp6LfMxxdXzHkOcVma0
         285JuHWzdzBr4sEbxI9i9UcMqDBdhSo2RroxYvitIrON/GsOyoLd9Z6ewJpA/MhfF59D
         GS8Ii3fz8qknSYgw98u2uAigMALVbVWRU+wm6lmIHl7aRFUJvMJji4ZToYAX7nTBIL3e
         oxawf8rdHn/aSl9dRgkSYHcdS7jMx8VvyH6ELeku0N4G7tH8qDmJWIYGbDToAhIiCY8f
         uVBw==
X-Gm-Message-State: AOAM53294MqafqEf5ef6+/JbzDpqXT2yDAMNMSP7QKgau+jPdkSXcuEh
        1c/+lpVrUnK6exqN2INsX/Wh+8i+e0upNg==
X-Google-Smtp-Source: ABdhPJwZam9yUiua5KXr33/pg5Nmdm95xtBCculjq6PUAXSP7HWcgCtkHTn8n+G+7k40iC3S7fHLQA==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr5250715ljj.229.1599759355468;
        Thu, 10 Sep 2020 10:35:55 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t1sm1755269ljt.21.2020.09.10.10.35.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 10:35:55 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b22so482853lfs.13
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 10:35:54 -0700 (PDT)
X-Received: by 2002:a19:7d8b:: with SMTP id y133mr4765702lfc.152.1599759354367;
 Thu, 10 Sep 2020 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca> <20200910093925.GB29166@oc3871087118.ibm.com>
In-Reply-To: <20200910093925.GB29166@oc3871087118.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 10:35:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
Message-ID: <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 2:40 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> It is only gup_fast case that exposes the issue. It hits because
> pointers to stack copies are passed to gup_pXd_range iterators, not
> pointers to real page tables itself.

Can we possibly change fast-gup to not do the stack copies?

I'd actually rather do something like that, than the "addr_end" thing.

As you say, none of the other page table walking code does what the
GUP code does, and I don't think it's required.

The GUP code is kind of strange, I'm not quite sure why. Some of it
unusually came from the powerpc code that handled their special odd
hugepage model, and that may be why it's so different.

How painful would it be to just pass the pmd (etc) _pointers_ around,
rather than do the odd "take the address of local copies"?

                  Linus
