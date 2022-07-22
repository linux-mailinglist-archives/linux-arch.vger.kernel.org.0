Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD6D57E54B
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiGVRUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiGVRUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 13:20:08 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB373A8;
        Fri, 22 Jul 2022 10:20:05 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31e64ca5161so54758317b3.1;
        Fri, 22 Jul 2022 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwjsumdCiO7MFSI3afGerr0VW+El1okPUiaXC43WKJY=;
        b=NY647TNC75N3upT6RTGTYTuGOaNATextgu6ELzUOfTiUFgHPYRc/jbPTr1g9rnGASz
         /W5l5qAZD1cXap+WLq1MFgOlxWrr7ZEgM+W/d9UFp5RFIEfB/Y05r5TfJaB81/hgGqL2
         /knHIRPnmqWovsQ9YWu3xVW78VpeVrh3nqkTKhlaZ7ILXbfeWUZBq37eiimMsF5skh9L
         S1fgeWJaMdn3bNdYqXCk1p/tpgDNW7rbMY8kp+H/U+9zBZmk505MUObtHh+sPMhELqkE
         bF69/mkdSyi/cu71X38APcNlF04kgTJ5z6FPEqHl3cpnT/4jJo3p+iAFJbtqtbA6qCoH
         9tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwjsumdCiO7MFSI3afGerr0VW+El1okPUiaXC43WKJY=;
        b=W2zlXMQDnwGd1T0hmfTeoNYqanRkfabHx4+wXnFieysws83pNnz/TwLYvI5Ys7kNi+
         EsSskbOkLCJcElcH8kN/Ikx0JK4O8ei7iNfCCzBJCeKrvQUjzqIN22lthEHqy1aylVwO
         ssXfJ9rMqEq7QqLYinb/ae7RrUEoLaCNck/MqNn/DaNGmmGDDXCHG+ZSnjaLFpflHaTV
         TaAzqJwyQfMUP5BSfGiWStVVZ57SOLOTuQYmIOHcsDAmKXM/6dvpkOq1GOd7zyTkzKHm
         BgcXjPp/DsntiRxdk8kTKe/hSZpouswgDaZNN8CrnfQGSE+Hqp4B/dCsdxENOLpmXytI
         /xCA==
X-Gm-Message-State: AJIora/6ewKCae2K9XElSZNpzJnbcUy1Q9OOuIHNCglZQ1EFAKj46kda
        gf4OBoJJsIt/L7tecL0I0C5NizAyV1+jwlO3X9Munap7
X-Google-Smtp-Source: AGRyM1tGXpwrWnWUTQJfj/RAu+7VNP5B42DnmWBAOjXMp7+Of+SgeMhLLnqQ37/Xf/dxu7Hn3nvOUjMklVY2qW/k2FI=
X-Received: by 2002:a81:83d2:0:b0:31e:64f5:91be with SMTP id
 t201-20020a8183d2000000b0031e64f591bemr696430ywf.233.1658510404702; Fri, 22
 Jul 2022 10:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <YtpXh0QHWwaEWVAY@debian> <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wipavrPuNPqiZ_zMP8EdbLKnnTkFukVCWm8FmCTUth4gQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 22 Jul 2022 18:19:28 +0100
Message-ID: <CADVatmPkXQ3mJpdTvaHxN4qmacYBhvzz=nxduQn-y+QUz4Pu2Q@mail.gmail.com>
Subject: Re: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 5:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 22, 2022 at 12:53 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > The latest mainline kernel branch fails to build for alpha allmodconfig
> > with the error:
>
> Gaah. It's the odd MMU_GATHER_NO_RANGE architectures - alpha, m68k,
> microblaze, nios2 and openrisc.
>
> We should probably get rid of that oddity, and force everybody to have
> the ranged tlb flush functions, but for now the trivial patch is to
> just remove the left-over dummy tlb_update_vma_flags() from that case,
> I think.
>
> Trivial patch attached. I don't have any cross-compiler for those
> architectures on my machine, but I suspect I'll just commit it as-is
> even without testing, since it can't be worse than what the situation
> is right now with that "redefinition of 'tlb_update_vma_flags'"

That fixes the alpha build failure.
If you commit it today then my nightly builds can test other
combinations of all other arch also.


-- 
Regards
Sudip
