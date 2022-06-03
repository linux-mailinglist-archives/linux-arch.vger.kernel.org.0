Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCE53CBA0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbiFCOgJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiFCOgF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 10:36:05 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CA75046C;
        Fri,  3 Jun 2022 07:36:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y17so6838967ilj.11;
        Fri, 03 Jun 2022 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grXyfamOfZ9pzFDeR6krf55MYVqi5D3RRk27kJIFMrA=;
        b=D+wggy4yN83jO+X0j6lEgqxBqbWmTOQid65J1mQccB4CcHtLZfesqtLwcU2uQC5F2H
         ku5kiXdomks6sp4kBvnd/1nXSew5phehLhOYzMVMeMLURIe8txblWYtCjl9wlEi8Kq3i
         UM2Y5V/BmN2YjTkqmw0geNnwnU+5lsL/2AFPr93TrDIoOtb3l7RmBtleknJ7QSN7PY/+
         CKD9N6N439g0IEegMLDn0bnqyU1XrzNwGkdGGIalQU5POwwoqxZu8bWdaSOn8xps8nPP
         cGg4K+Qp68f8kaS+nMH3cJ6SUuzb+vEhJTkIOdYJKNzaK21E3fff6RRaI0lOmp1xn5Lz
         YQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grXyfamOfZ9pzFDeR6krf55MYVqi5D3RRk27kJIFMrA=;
        b=LpIZ4Y1rUvKIjTUTJI/TexS2dL4qyb7jYupCyZbmnsZdnRZALu6CbFedYGSpDGyfRd
         A19ehh7a03rnWAgwTsevBDkr767sbawMfR/x8JlrCSVe9TpQIbFzO106wcE6UnUVaY0G
         OVVA5z/0g+i7JpF3YNfKC6TQ8QnMjfKW2T1SkJ5tQS+3wLMIYCOA0PANVt9pi8DO5dNV
         YErv2bLWjxFsTz6d++p4JYe2TS+qflGvw3HmQE5U2P+v/3IttYAG0JhJ9xyQcI5H3OXx
         io9Hh/cPgAeuoDD8U0uASLlu6r29pTapJNoGO7QZVAVrkAU94b0RcKIiw9ZWBswPKFdi
         XXSQ==
X-Gm-Message-State: AOAM533mKxX5Nzi/Hn/ZMcmd6W0mPs2cv0r07XGTI7b9SBC4GCITHRUk
        gvdQu4Y9IR4Sj7XtGEc5gJlc+r3qhLeRsJUscDg=
X-Google-Smtp-Source: ABdhPJw5ssQ+R5VYy3YUI4pnQbxxgBljJhU7SRHCKVbgviDqBk6fsHqVpJ8MAS2mq+ckGrmNbZvRiJLhQXTLzGn2dQk=
X-Received: by 2002:a5d:9d8c:0:b0:664:afc8:64df with SMTP id
 ay12-20020a5d9d8c000000b00664afc864dfmr4973409iob.42.1654266959848; Fri, 03
 Jun 2022 07:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn> <YpoPZjJ/Adfu3uH9@zx2c4.com>
 <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
 <YpoURwkAbqRlr7Yi@zx2c4.com> <e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name>
In-Reply-To: <e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Jun 2022 22:35:47 +0800
Message-ID: <CAAhV-H6wMBV4rgbEx01+Zm+CPQxQYbe1CTuwB95B_JYwGaytFw@mail.gmail.com>
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Jason,

On Fri, Jun 3, 2022 at 10:14 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/3/22 22:01, Jason A. Donenfeld wrote:
> > Hi Arnd,
> >
> > On Fri, Jun 03, 2022 at 03:55:27PM +0200, Arnd Bergmann wrote:
> >> On Fri, Jun 3, 2022 at 3:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>> On Fri, Jun 03, 2022 at 03:20:39PM +0800, Huacai Chen wrote:
> >>>> diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> >>> "Currently only used on SMP for scheduling" isn't quite correct. It's
> >>> also used by random_get_entropy(). And anything else that uses
> >>> get_cycles() for, e.g., benchmarking, might use it too.
> >>>
> >>> You wrote also, "we know that all SMP capable CPUs have cycle counters",
> >>> so if I gather from this statement that some !SMP CPUs don't have a
> >>> cycle counter, though some do. If that's a correct supposition, then
> >>> you may need to rewrite this file to be something like:
> >> The file is based on the mips version that deals with a variety of
> >> implementations
> >> and has the same comment.
> >>
> >> I assume the loongarch chips all behave the same way here, and won't need
> >> a special case for non-SMP.
> > Oh good. In that case, the code is fine and I suppose the comment could
> > just be removed.
>
> In addition, the rdtime family of instructions is in fact guaranteed to
> be available on LoongArch; LoongArch's subsets all contain them, even
> the 32-bit "Primary" subset intended for university teaching -- they
> provide the rdtimeh.w and rdtimel.w pair of instructions that access the
> same 64-bit counter. So I think the comments are probably just leftovers
> from a very early port; the LoongArch development started way before it
> was publicized.
>
> And yes, the comment block re get_cycles usage can be removed altogether.
Thanks for catching this; what Arnd and Xuerui said is right, and I
agree it would be better to remove the comment.

As the PR has already been tagged before your reply, this will get
fixed in rc2. Thanks for your review again.

Huacai
>
