Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F056630C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGEGWK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 02:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEGWJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 02:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB52BCA5;
        Mon,  4 Jul 2022 23:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAAD61426;
        Tue,  5 Jul 2022 06:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E04EC341D7;
        Tue,  5 Jul 2022 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657002128;
        bh=Zaf7DjhcD3ZxfJHUz1tOGgDGa4JYJfrWSDwsbtdTNwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6923plIqslsbqyEgJGkAr8COlwhQHlzqDOMUImf0zNEq9HfBY7kyJ31P00pKVrG7
         y7sOCX7KFkZaKbXr1TBsB4bdPWDPbdUss/s+YWLl5peIIfTQnNr2M9MJNM8bwnRZW4
         pBP1mWfqbYSTfbLQr0IfiTFeIF0vLC+jWt2IFvckuj94X5lLXreY0OPKMdqj4JP0Ql
         smnsWL54j9bAu/0Q6bfOaMqEB5kKVAhMB4U0bMIbAk2LT3svlb0Axbi55/JXgywmOj
         gLpT9G8YpXf0KUjDyEO/m/I2r9HiqXWMGXjvdGjetJDbeHeFEekkqecyZHbQLOGFi+
         XCBAa5kvP21lg==
Received: by mail-vs1-f54.google.com with SMTP id h184so8559vsc.3;
        Mon, 04 Jul 2022 23:22:08 -0700 (PDT)
X-Gm-Message-State: AJIora8X3yQoioVtRiEwhFu6BMNxFuI66FFq4PuuPsdJy+YonYSJ3S7w
        3MJnwATXj1IvnxZrPwXOwTEwgenwzm+1qlsaZjM=
X-Google-Smtp-Source: AGRyM1uR3kDpQ/MbyXcNWqnHFpFRoA+f7XpzR2mn61Kf/oGLc1bqoMRFlPTGI0x9k49ir5CWsNuWr5PQo6T9BiLh8ww=
X-Received: by 2002:a67:6fc3:0:b0:356:18:32ba with SMTP id k186-20020a676fc3000000b00356001832bamr18421067vsc.43.1657002126922;
 Mon, 04 Jul 2022 23:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-5-chenhuacai@loongson.cn> <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2XBGtJMB=Z-W56MLREAr3sAYKqDHo3yg=4hJ4T6x+QdQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 5 Jul 2022 14:21:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
Message-ID: <CAAhV-H5djQOzRsW-JaRPzaAnh64WgHiGvHxc1UdAUV43tirukg@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Jul 4, 2022 at 8:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 4, 2022 at 1:25 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > To avoid the following build error on LoongArch we should include linux/
> > static_key.h in page-flags.h.
> >
> > In file included from ./include/linux/mmzone.h:22,
> > from ./include/linux/gfp.h:6,
> > from ./include/linux/mm.h:7,
> > from arch/loongarch/kernel/asm-offsets.c:9:
> > ./include/linux/page-flags.h:208:1: warning: data definition has no
> > type or storage class
> > 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> > | ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> > declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
> > ./include/linux/page-flags.h:209:26: warning: parameter names (without
> > types) in function declaration
>
> I wonder if page_fixed_fake_head() should be moved out of line to avoid
> this, it's already nontrivial here, and that would avoid the static key
> in a central header.
I have some consideration here. I think both inline function and
static key are instruments to make things faster, in other words,
page_fixed_fake_head() is a performance critical function. If so, it
is not suitable to move it out of line.

Huacai
>
>        Arnd
>
