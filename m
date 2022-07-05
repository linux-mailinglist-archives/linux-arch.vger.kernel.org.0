Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE36566482
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiGEHvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiGEHvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 03:51:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122D13D68
        for <linux-arch@vger.kernel.org>; Tue,  5 Jul 2022 00:51:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b85so7180516yba.8
        for <linux-arch@vger.kernel.org>; Tue, 05 Jul 2022 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8cdnnptoSm5AJC45vIjlcJ8J1DipiYnWtE0ruW2rxs=;
        b=hrW9cMR7Z3PxWD/FtQwAajFkdScrx1WIecOy3tNPSPFj7ZpT3MS6GjAIcWTagfEmKJ
         gkd2p1YtA2R+Hh+5XgkXthXfwg2R5jG2gKm0g6phV8Lrz5F4whqrhU83Dj4tyPwZFMtM
         uh781jvQ7OZBXq+KPR5Hc8P02RQW8jmkhPaUJ/ZwYrOawwLL/FrmV28X7ASFhZjVAiDC
         4PMU4qslIoAXQOx4rSi7700OVzBPHPOTQk+OIii9voMpdvQNDRlo5aNm95xeq1Ki2eBG
         hdoFAWundROhfmqT1kj2LM1sDGiWNawV/jwFpZ3ps+48699ORO58C04c2n4NkdSQvBX9
         lJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8cdnnptoSm5AJC45vIjlcJ8J1DipiYnWtE0ruW2rxs=;
        b=poE7Sy+TL88g9cxh8zR9j8kdV1oWiOdLyspcXylmr+btBC0oQ05FI659IhrYWljaUI
         xngwXuGsPOtQK8sLZJrlQVRIF++ravj0OEvZTvdqfgO/8CfVmtwrq92SGwSQooUoPY7l
         CUYPTi1mrN2U4Q5H7fFwg7f/baivF8/rrw8C6j6SN6ZRBH/v11/sInGkyu8oUaJbl7pB
         //KwKXW8cWRvRbdGQh8xcFgbUbdOTWq82J4VZvXRqMBrA9jL8cknoSw7Zn5iC/OkwZ42
         bizNA53un1b6F+laFdfHIo6u2IK3nnSRc5LxQHW3Ja3+JqsCW6T6PGMHJOa86X5riD9k
         qTFQ==
X-Gm-Message-State: AJIora9Ii9R6dcBeADfCLk4Qh8TPadrV2UaHkFKDmxPpF9FxzxgiMw7P
        tcEVPEYCmo3xw6f+ZK7BVZr2KptBVhBnHI2pkDZ/8w==
X-Google-Smtp-Source: AGRyM1tcec4ZVozLeG3AHgF0JBmdcEQv61u7/2ayYABYM50nQefJuIIBRyMGNOqvt0ngm0odO3V8Tx51FRXcuMYED+M=
X-Received: by 2002:a25:4290:0:b0:66e:53b2:56ed with SMTP id
 p138-20020a254290000000b0066e53b256edmr7670009yba.254.1657007503251; Tue, 05
 Jul 2022 00:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-5-chenhuacai@loongson.cn> <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
 <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
In-Reply-To: <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jul 2022 15:51:06 +0800
Message-ID: <CAMZfGtXLxPO3jmkKpF7n9Scb=542yrf1taWHZGdPwK-tZsJXgQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 5, 2022 at 2:22 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Arnd,
>
> On Mon, Jul 4, 2022 at 8:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Jul 4, 2022 at 1:25 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > To avoid the following build error on LoongArch we should include linux/
> > > static_key.h in page-flags.h.
> > >
> > > In file included from ./include/linux/mmzone.h:22,
> > > from ./include/linux/gfp.h:6,
> > > from ./include/linux/mm.h:7,
> > > from arch/loongarch/kernel/asm-offsets.c:9:
> > > ./include/linux/page-flags.h:208:1: warning: data definition has no
> > > type or storage class
> > > 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> > > | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> > > declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
> > > ./include/linux/page-flags.h:209:26: warning: parameter names (without
> > > types) in function declaration
> >
> > I wonder if page_fixed_fake_head() should be moved out of line to avoid
> > this, it's already nontrivial here, and that would avoid the static key
> > in a central header.
> I have some consideration here. I think both inline function and
> static key are instruments to make things faster, in other words,
> page_fixed_fake_head() is a performance critical function. If so, it
> is not suitable to move it out of line.

+1

The static key is an optimization when HVO is disabled.

Thanks.

>
> Huacai
> >
> >        Arnd
> >
