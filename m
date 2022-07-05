Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2D5664CE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGEIGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 04:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiGEIGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 04:06:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149613D74;
        Tue,  5 Jul 2022 01:06:12 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N9dkD-1nVbxn2Wtp-015YvG; Tue, 05 Jul 2022 10:06:10 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31c8a1e9e33so48551507b3.5;
        Tue, 05 Jul 2022 01:06:10 -0700 (PDT)
X-Gm-Message-State: AJIora99c3Zf7JZrnq6blIdcUaVQfm7mYNFHSuTeSL0kULf4zLEggbE2
        rvr6wMQJJT4FRM4yTStKNmEfgaKm4dSA3/LKViU=
X-Google-Smtp-Source: AGRyM1siFTQxWWzBOhd/CS5tY6dinBjb/3v8JI3nSeDseCJdiuCqCTqoFZco5yyHdSdSX4iHxr4392vEVjGUym3EjqY=
X-Received: by 2002:a81:1e4d:0:b0:31c:86f1:95b1 with SMTP id
 e74-20020a811e4d000000b0031c86f195b1mr14599301ywe.42.1657008369140; Tue, 05
 Jul 2022 01:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-5-chenhuacai@loongson.cn> <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
 <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com> <CAMZfGtXLxPO3jmkKpF7n9Scb=542yrf1taWHZGdPwK-tZsJXgQ@mail.gmail.com>
In-Reply-To: <CAMZfGtXLxPO3jmkKpF7n9Scb=542yrf1taWHZGdPwK-tZsJXgQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Jul 2022 10:05:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a14VTkTjRNTWsGmwLDuVm=QPL17_VZ8QkcCYnyQzBjXHA@mail.gmail.com>
Message-ID: <CAK8P3a14VTkTjRNTWsGmwLDuVm=QPL17_VZ8QkcCYnyQzBjXHA@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:wQ6H6ktuzw/4t4NBK/WuLQKF9PmjwQ32PesGzPz6lLrNFsXyBPc
 I1+h0RP+vP3761aOpiLyXlo6KFCWMvofqLX/8SKOwQZRHSbjtjI7iqHBZAnxdl4wlQHSnFw
 EWvsGb30v8xkj4IVuvxUw1BecTyi7XyP0WjdCRfrRRcZsmVn0+BJUBEmEhfbnLn1K4olYBh
 Na8g3POW4XMvhu+3MqP6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+ywZWDksVo=:eL1HtXEG4haoMUL28FihJA
 azuc08ivJ0oY2uGsD3L5i/cWnL9nd/+UI6VG1aRjLjp+oBAg4qS34N5KZYwp9yQQMg3QHOkqX
 I1TpcrJkkjUtQZpMiHQXkERRN314/J9lBxyXr+E3FVbStRz85Vl9iVojI2m5AefDA/+3x5HGH
 L7hn296ksGhGjt7QYkmx4dCo+u9FE87sNG1+kNt4vhJh4hqJVRTAUIcT3yj+RCjN+tqSmduNY
 uhgEwFRj3+wNTJYCuPFneRQNBzfVdCfqwsc4tSmTivmuSNAk5m8tSe/If7K3d35VZLiF3JKHG
 U59qQsBPyoP9+RhdcDWjZibkjcmu+ZS0wNJMUVhIri7sU8ScSghYQmtnB8Xk/Yd2cOIrDJb7G
 9BU06nPtKvy1StTB8NrP2f7BjLtHMf3wN+FOTGRsnVO9hBROHMbaTCT/wynuqjwL+abzgw3z+
 vuvAHVdMDfGiTOc08yvWbF+QwDHmPuDONI/LcOXumWeeC3xjSVSCUZAwo7a7X0hfov18IpOOZ
 MASe0sPdkKMwjGr4GmeizAnhfupof63zZKAhXJCy+Zf5lt9BBogebcmJj5hrsltY7Z50a/lhn
 F6UVwwNODGqa9/sR8w0MqDyxdHCmJAEX3aCTV0AOM0Rtkh21doM/N4D45e1mWMrdPmWlhjNHO
 AOD+gvKGM1sWR2KPdEacfTPcZeSBXXoDhr1ZdyveH2m3uPiddNQ9TOH0brf74poAA124vRwHi
 363MDytyheK7ZoDyFv2j5YuYSO9eE/PCoRZ/E8C0F0w8SxrEYYX3msM+ZQYQWKTFtF2rKrLH3
 t4C5ZM84RL2VNKfLDDziBY2et26FXUE81OowkM2VMMYUCw3IuHa7/tfzRT2WvB8sq0FJ+W+Ua
 ZX4yRABith+zZhbS4e3A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 5, 2022 at 9:51 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Jul 5, 2022 at 2:22 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Arnd,
> >
> > On Mon, Jul 4, 2022 at 8:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Jul 4, 2022 at 1:25 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > To avoid the following build error on LoongArch we should include linux/
> > > > static_key.h in page-flags.h.
> > > >
> > > > In file included from ./include/linux/mmzone.h:22,
> > > > from ./include/linux/gfp.h:6,
> > > > from ./include/linux/mm.h:7,
> > > > from arch/loongarch/kernel/asm-offsets.c:9:
> > > > ./include/linux/page-flags.h:208:1: warning: data definition has no
> > > > type or storage class
> > > > 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> > > > | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> > > > declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
> > > > ./include/linux/page-flags.h:209:26: warning: parameter names (without
> > > > types) in function declaration
> > >
> > > I wonder if page_fixed_fake_head() should be moved out of line to avoid
> > > this, it's already nontrivial here, and that would avoid the static key
> > > in a central header.
> > I have some consideration here. I think both inline function and
> > static key are instruments to make things faster, in other words,
> > page_fixed_fake_head() is a performance critical function. If so, it
> > is not suitable to move it out of line.
>
> +1
>
> The static key is an optimization when HVO is disabled.

How about splitting up linux/page_flags.h so the static_key header is
only included
in those places that use one of the inline functions that depend on it?

       Arnd
