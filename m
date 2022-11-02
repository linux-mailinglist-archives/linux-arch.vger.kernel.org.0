Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B19616B4E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiKBRzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKBRzl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 13:55:41 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CF2EF16
        for <linux-arch@vger.kernel.org>; Wed,  2 Nov 2022 10:55:39 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bef14ea06so21140230fac.3
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tfgl/2wz1H/8UpZUR1BGxO9QY8fMwSWN8ozNgnnwNo=;
        b=NeK0NeRjuTAZUtHhMjgNyr6bYudXXk6DWAHX3bTjmN4JSWdzL6JeZGWMcTF+HKB1jh
         MxgfTRp94CqtCSRHcGW+QimC0eY6cr+M+yV1ssIcn+3APuGyZYLufIf07JWzaUc4957/
         eUOIf2N32qzKN+9Hwta9aX6xiuqzbYaFCmZks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tfgl/2wz1H/8UpZUR1BGxO9QY8fMwSWN8ozNgnnwNo=;
        b=El5XIfos76bDwhVq5Dqygbui3IDZxIRZwq8nPQqMKg4mtzCYoVEeQbXS7s/xIZ6F6B
         EZA3P91tzw5pVZBERtuMhYHVAiWIfbgbc5S+gRyxj2rMVyxpywd/QXfn+tGtbIfFypUe
         nk8E512BbdfuGsOsJCBwq2EBeEeoVRg/yr50MJZfwLzdpaTQRgyaDf4VLLLFRH8lyUEq
         tqkQiJ0zTiuIX1/SOhTr3ZkH/E0ENFwAWxB42WZ5RIYRWhHsXY3josFbNCf3oB0HxKE5
         RHxDgzwCPayQzJOZhlDPwLCHUYbFxzPojHApJ4e/xDaR7KFJEPn79Qjc4u0456y7EoRE
         ZdRQ==
X-Gm-Message-State: ACrzQf0/aDMN8jyB5XW+NakSyqbXl3VmVSL6OTr3OkutX7pJiB24uqqB
        Kivxm+VZpSuu9yh+/86PwApv3Kip49g6kg==
X-Google-Smtp-Source: AMsMyM4x7pyZV1/Qtp6rk7xAviWkAXBP2V8zvdARmfndelNbxoBvQ76hQk13tOZHdtwNLE4IEmhBpQ==
X-Received: by 2002:a05:6870:a7a5:b0:125:76da:1bc1 with SMTP id x37-20020a056870a7a500b0012576da1bc1mr26465170oao.272.1667411738251;
        Wed, 02 Nov 2022 10:55:38 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id o195-20020a4a2ccc000000b00480816a5b8csm4681982ooo.18.2022.11.02.10.55.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:55:37 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 16-20020a9d0490000000b0066938311495so10692285otm.4
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 10:55:37 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr25201108ywr.58.1667411726040; Wed, 02
 Nov 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
In-Reply-To: <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Nov 2022 10:55:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
Message-ID: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
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

On Wed, Nov 2, 2022 at 2:15 AM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> It certainly needs a build fix for s390:
>
> In file included from kernel/sched/core.c:78:
> ./arch/s390/include/asm/tlb.h: In function '__tlb_remove_page_size':
> ./arch/s390/include/asm/tlb.h:50:17: error: implicit declaration of function 'page_zap_pte_rmap' [-Werror=implicit-function-declaration]
>     50 |                 page_zap_pte_rmap(page);
>        |                 ^~~~~~~~~~~~~~~~~

Hmm. I'm not sure if I can add a

   #include <linux/rmap.h>

to that s390 asm header file without causing more issues.

The minimal damage would probably be to duplicate the declaration of
page_zap_pte_rmap() in the s390 asm/tlb.h header where it is used.

Not pretty to have two different declarations of that thing, but
anything that then includes both <asm/tlb.h> and <linux/rmap.h> (which
is much of mm) would then verify the consistency of  them.

So I'll do that minimal fix and update that branch, but if s390 people
end up having a better fix, please holler.

                Linus
