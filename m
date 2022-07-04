Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64366565509
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGDMTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiGDMTU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 08:19:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7221261A;
        Mon,  4 Jul 2022 05:18:35 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6t3Z-1nXZSg2Gml-018KQ1; Mon, 04 Jul 2022 14:18:33 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31bf3656517so79990977b3.12;
        Mon, 04 Jul 2022 05:18:33 -0700 (PDT)
X-Gm-Message-State: AJIora9MnvG+ZCrnuUPyPV61A9EoXWDkuxJcOz0NRctoTUQZyCHGfl0z
        yGFiKtL9/dsdmvgS4rJQ83HTI+1BMU26nMByuio=
X-Google-Smtp-Source: AGRyM1t524xzXaLIHc9+YLKm6ZLrM8h13HdFno4gZgaj1dmGgvuhogt+hY7ItAhxUJF6ZzYWUGTcd5U54H4EPHTirlY=
X-Received: by 2002:a81:7742:0:b0:318:35e9:728b with SMTP id
 s63-20020a817742000000b0031835e9728bmr32899958ywc.209.1656937112121; Mon, 04
 Jul 2022 05:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn> <20220704112526.2492342-5-chenhuacai@loongson.cn>
In-Reply-To: <20220704112526.2492342-5-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Jul 2022 14:18:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
Message-ID: <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
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
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vy96//DNY04FWech7fVmoPA9D6M9r6k9yAKwRXWgXl6fGdf0uKD
 VvF0SHeIfNRpNsnuTqRXGfCzXECXkmBGwYHZTqoIVjWjt35sbcug/N/4vpyEbAcyw9XlhJH
 wW+0IUyEAX6GVPUOQnq1TIWI+zLciGkeqeb+LsUeCInrH461Zjf1A1yO6bg8LTcFJ4fK4HF
 mTQpz40NIU8v71zMfQgSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AK2V9EDb880=:HVyuk9RZGtMxTOt6QEKmPF
 l/vGJeiLx1UoWWVWlskohq/dP7eLQ02Vv//2t1ZP6xcKBImNFStqtKealNpTTB0+n/npx3LuN
 JD97PGqwoqV4j1WH/fChLBU4YvcDUvbOwf94X+2hTNvLXMsOhyoKc73rbals/abbEWdKSis4/
 6mHBIHzEvzSEnM4zWCGozKgsi3yEyoxXAkWs5Lq0Swr9NBIeFXf7NU2y4zf5zsVUL4pBPMrQI
 yz0v8a6SPqxCqYN6DU5RUWUFpdCjnwAHlutyePMbortdLERGEBwduqfxGaSl/4oSrTAEwFNoy
 IEm7Kj+Xjo8N6dOLzCkmQx4/BCH7ISCSRARUIlWrNF0bu9R5s6z/8PHbj96KjEXl7BjNq69hb
 SUEkz/QD16PHXN6TyjBFg8BKUDw76cl9NfTaz7nmuH1ja1Mxp9o0/W7W5cwxrN3NTirO8J4HC
 t65zS62qrUOzeDsST4+T7ADt5ThG0ksImsxkELmzDwudZ9bbcOoVZVq5JLtwa3w6ozqCM3x5V
 4b0CAIjVcRT3cBI+2levtRLBRxVCJWSGqjqvUIlm4R1mmtz9O5yniSXSVRmy37IXpKYetGip7
 jtm6ZSc8P39bS7kxKdKLQiZ9BG41JhwqPj6ojNVEWHBZYFGNaYnI0f2NgjK0wHReAzWlefDpX
 4lDIWQTXBmGlcou7pytIk4PIWsC//gq2Nxaj2tIKqWHNgDE1N+OQyZzLVzJ75Y6lDj3Ac5zD0
 S1c7Ugn/ksGZ+XqApccDb76xrkX3g2W14/R3n7S3H0Y/qnkt+N/IJyodIS/vjDa+962K5QKJY
 HsrT9apte7p8onGi5u/DRIBinlIOJQ1H7xcyS9JRWoI6oLiQv4vzgf5kI8imelafCyoanCBIO
 /MYrYtEdHPIecj6oQxCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 1:25 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> To avoid the following build error on LoongArch we should include linux/
> static_key.h in page-flags.h.
>
> In file included from ./include/linux/mmzone.h:22,
> from ./include/linux/gfp.h:6,
> from ./include/linux/mm.h:7,
> from arch/loongarch/kernel/asm-offsets.c:9:
> ./include/linux/page-flags.h:208:1: warning: data definition has no
> type or storage class
> 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
> ./include/linux/page-flags.h:209:26: warning: parameter names (without
> types) in function declaration

I wonder if page_fixed_fake_head() should be moved out of line to avoid
this, it's already nontrivial here, and that would avoid the static key
in a central header.

       Arnd
