Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9C566557
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 10:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGEIp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGEIp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 04:45:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0DDECC;
        Tue,  5 Jul 2022 01:45:25 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXop2-1o7QHA1EQ0-00YCeN; Tue, 05 Jul 2022 10:45:24 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31caffa4a45so30156327b3.3;
        Tue, 05 Jul 2022 01:45:23 -0700 (PDT)
X-Gm-Message-State: AJIora/XzEhenTRMGdha5lqfxogTSxdsC9Wy6l+vIEFkj8dsdRcJOSVs
        IESEEuRtm+5skir372T2QVApA6x9TjdsiZO8Olo=
X-Google-Smtp-Source: AGRyM1uYOtyfJXKuzgeWcPon6/rt8pxK0qL+mbZnG1H+QlCtBup1RqkQZxF1vAGhyIUYZLMpsbPW6k5+SWmkY5+yibA=
X-Received: by 2002:a81:230c:0:b0:31b:f368:d0b0 with SMTP id
 j12-20020a81230c000000b0031bf368d0b0mr38196589ywj.249.1657010722935; Tue, 05
 Jul 2022 01:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-5-chenhuacai@loongson.cn> <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
 <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
 <CAMZfGtXLxPO3jmkKpF7n9Scb=542yrf1taWHZGdPwK-tZsJXgQ@mail.gmail.com>
 <CAK8P3a14VTkTjRNTWsGmwLDuVm=QPL17_VZ8QkcCYnyQzBjXHA@mail.gmail.com> <CAMZfGtU0n_-Bq95X+_rZjcyeK3QhKSq2t5HRvx5Kw5+tR9h+oA@mail.gmail.com>
In-Reply-To: <CAMZfGtU0n_-Bq95X+_rZjcyeK3QhKSq2t5HRvx5Kw5+tR9h+oA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Jul 2022 10:45:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1K9fmLK=dh8shHX2y=fOYzr02D9Ek9uQri-u_2MsBXdQ@mail.gmail.com>
Message-ID: <CAK8P3a1K9fmLK=dh8shHX2y=fOYzr02D9Ek9uQri-u_2MsBXdQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
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
X-Provags-ID: V03:K1:EnsaWfygFsYED2VEMER1GCpT36IPqbLGUyAeHSH10vaMeYbtZlj
 QcJ7HQfrOoDhUV1Bn3CS1BJImiGSfPwXmnfFUKJ6eVxMyOj4rGLjt7/mFLogTsy0hWsEXw7
 n2QkDSIW3xl44L7ZBM/D9IsRJ9+2o0tPjE7469tgCKMH73wCUCa9WiDwE1ToaXrAe0+X3TT
 aYGeL/IyO2Y3IRC1ZWkjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwcPxKF5Bpc=:OO7AZYaHclQTKf+Nw0trsX
 AaJb7BHZuSa2Ffz+bowEUm8X9nlc2JK5FWE50PO69tdZM7/Lf17nl5+3KeltRfYKK0b+7b/kh
 cNYEtr6/8df0QwYZz9PIu5bxhTJnf2I8yZjS13rxlSyh5XCbZ1RA5zokxs9ayV//TEeQljmTj
 8JTIgmaZZ1WQJnSQ3D0p+2oPj03EGX7q/qf4rCk3AW7S0XYi1hjdamD4E+/O3R4BmQj9hhttW
 rd+RzVbLFHBlH3yUYoTPVHvHsvcAvlp2eDowjcq7EqGKU1eXSd/Bdl/fPRrECkANLRHKyK4sT
 Ox9C1Q84JE5iyWn4iFEl3EDog2V8YTyS0qHuvXkqYdLovl15wxh+Jv97Ms0wDfY+z1HcQeIoq
 SZxaSHRYD8zRPLpEFMU4Vbn4yiIVLImonshHgqraQG0XHK+iTbqs36e19/ExE6qWl6KN+MzGr
 hEC0J1851AdemC/tkuqrboVCsdZg8TdfYIxB5qAxdKOHe2eEaSfM+k28YldblQfp1CRdXX8Dj
 /kMzi8KI0AWhtirl1GI4FdvYVme5NFQPw2lrPkjPG4kA1ymxkeZuO7QrPPA5N/llbNm0/x9GZ
 eXKYlsgEtsnoT8PGgpFif0qlVvc6O8GfnNlRYXZ43YlVVffcQyM2I3/rLJR+loYAw4CfjBavo
 rfvHxZXwnnhSA5H/TLjouwYSP6XRkWKwjGKnuaKtTwN1e5uDs+LISLsMfJuoIqY8zMO/kFLwY
 9GmRkmqNCa9rh5vez8s2wGYF8Vqjcf5uHPYNpQbpkRHalTqtmpo+w7SUuNZLtanIbdwFx+zNF
 GoteDXKrgO5WritMLcPvD/9eFNf046fVop/2aSbO81ZDn5Ha4jLOgmnwnGUla4+DQpDXf3n+C
 oNiva/UCXFcXypKQp0+9ir41TwVbDth78z50pi60E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 5, 2022 at 10:38 AM Muchun Song <songmuchun@bytedance.com> wrote:
> On Tue, Jul 5, 2022 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 5, 2022 at 9:51 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> How about including the static key header in the scope of
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP?

That helps a little, but it means we still pay for it on x86 and
arm64, which are the
most common architectures.

       Arnd
