Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463FF56123A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiF3GHC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 02:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiF3GHB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 02:07:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FBE9C;
        Wed, 29 Jun 2022 23:07:00 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9nhF-1o0zuJ380D-005t6Q; Thu, 30 Jun 2022 08:06:58 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ef5380669cso168880597b3.9;
        Wed, 29 Jun 2022 23:06:58 -0700 (PDT)
X-Gm-Message-State: AJIora8E4iPU24jKIAaCkfHY82+uODOzfo+pws1HGDvfa6ODJfOk3Dep
        D+nF5nHBL3yCwAuQ5mXakO5+pkzxUc4XFF6vVA0=
X-Google-Smtp-Source: AGRyM1si8Xct+Du/ZHF969rBnPY4ejd78bmjSd2IBZVFQkb9/WgScc4xVPKj47Mi/RxJU38P5FHTJWTl4A4/3M+aGx4=
X-Received: by 2002:a81:230c:0:b0:31b:f368:d0b0 with SMTP id
 j12-20020a81230c000000b0031bf368d0b0mr8380804ywj.249.1656569217193; Wed, 29
 Jun 2022 23:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220630043237.2059576-1-chenhuacai@loongson.cn> <20220630043237.2059576-5-chenhuacai@loongson.cn>
In-Reply-To: <20220630043237.2059576-5-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jun 2022 08:06:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1x=ZX+W0XL-=MkZebHdbvB0Ngam5LxXJUnm7USpMaFMA@mail.gmail.com>
Message-ID: <CAK8P3a1x=ZX+W0XL-=MkZebHdbvB0Ngam5LxXJUnm7USpMaFMA@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
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
X-Provags-ID: V03:K1:EqufN3JL2pynIVinIv30vDp/9hKO6kuVwaT2r/RqjU44rejbmPr
 TVBI+96t/cAIQ88fsIgR52MaCIiVWNhQUtVJJh2pofinDQnr+N6asTdFS2kTqiyIsQPSr2w
 Y6x9267us0LNGa+gkGHN2j+FhU6c0Zn3yBmhJyA+CGAaMdxonZV54KLRL7c3ofikLkQI4l3
 0yFOk2VOUgOdQFL2tXbSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q2wajwpiJFk=:5lYrLbbaJeLJd/nnzcawf6
 /bNi8LfS9I4hY5ubK8Iw2g7Xl9BC6Kas5G8L/GwjdV1qmPbpb7VKGmFC8K7a2WUnPwTkK60ub
 jAbcsuCOiy8GxaNfDzYGqZOgKqpdvk78zD9DLtNMrBYSXL5heXG9vNRelFLBBOVyFqapTs9Of
 lR6ObsGa88h7Cf5aVH4/AShssqr64olZNQf8SaHrvy8dNZWx2eq7VeTrnJ1eLF0pvhPKaAKxP
 UPztPq2rMtd2ssLWw0FqckVDiCAk9NSG6cLp0fjP8y+GPA4pcahCtiWnQNyYCCrYKOjVZnsR9
 fOl93O8g6YEJxFlN6UGLfg3OOhVPaVv9pCl9cA+HuCKvHbM10ejNkUxk7KOPfcu98jzZXafif
 5ff+SvzbtPVNJZ0vY6bam9JtR0JmqlPiY4S/m/4TG/0ftuxYVUKT5sm1dbIYdJDbUkuShbF5+
 WIG5t/HYL4kzgThjdZ1rYvpYYhMN2xmTIOXyg9ZGk9qxh0RXSKFKPZsX30L78bfjsb1Pt2fS4
 51YsjagDMHNZ8HMvEvc2f8+7pPJCU5TYbE+DxVeAVQirGapv7Z74pOr4+iBzKgEeBPC46/Fw1
 rJZyQZBl9CrTtacYUZd++PPGqVl92PWc+wrhN+zCYTmvqOCDGseJjYxYN4LuD4eEdCcAolvRC
 /bwgxcuAImtGcBhgMnJ+0L466948XSmZ9fJmNBHkV6vtS2aPvvnyqSPW36xvc9KiZ5wGE8XQ5
 0+c2GR/lMbLsXgWw1IFAHKgqzynm1LZfQI+TC3Ef6g/WJSSUTXsucvxzXa+aWRv7aCeAb4nKi
 Ajjyl4SKrOKR/uVshVRddv+9fGuTpj/s2cJTboMeEGhv6mGGOvBBH5C9qwX7kYYm0r0vD/ib9
 JadLleHU8SGAVunx7Q8vmZ4Ls+61x5+vm88EpbwbQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 30, 2022 at 6:32 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> To avoid build error on LoongArch we should include linux/static_key.h
> in page-flags.h.

This is an expensive change in terms of compile speed, as static_key.h has
lots of dependencies, and page-flags.h is included in a lot of places. What
it is actually needed for?

         Arnd
