Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4334BB2EC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 08:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiBRHLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 02:11:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBRHLC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 02:11:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FB25B2F8;
        Thu, 17 Feb 2022 23:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB5AB820CC;
        Fri, 18 Feb 2022 07:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237BC340E9;
        Fri, 18 Feb 2022 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168243;
        bh=U1L1tXaxAPzHw25B4dwwR3MsazfLjv3b5y7cZc7Ajbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/ULvY2AEs1Y/Cc/kxwc99BmTDI+sKjegZezPUNxSiAEgZoi3zk3NcwNR6gaBuKas
         ddOX6bcsBLpCq/CBjJ7fKtrT9/0HR0zijquw1D+JV3/CePEugqsvEvUkh3c2rryUAn
         iGdWuSivzeB2X8B9lLMG5e/Ou+Jo88syE3wWjxK1CzqmTDy9Kpz5pQaOvGvZ4Wakvb
         r2oj8Wg46rfzApWhTiI1Sn7A5OPlL8MF46bCOLGSHQojALsR9kKZLx5uSZ2etiSHig
         HpB0AaGds98PKUvmte4NxXYBZGTza7B9MIYk8zB/lrmjqqbOX6/VfwhTTbMSwZXuXj
         no9lcx5EiWBUg==
Received: by mail-wr1-f48.google.com with SMTP id o24so12951351wro.3;
        Thu, 17 Feb 2022 23:10:43 -0800 (PST)
X-Gm-Message-State: AOAM531mn9P3QF+lQIfaFKXfcQh6+LrmaCkhG1TkIfS7F9oPg8skN9rf
        RQLrGwaISSeghjE2ck226TZXH2okWvZj2SHTboI=
X-Google-Smtp-Source: ABdhPJyoMw4CwWZhykLaKIetnvcgd+UId8rsi1OwYV9K65APKYAe4q4e2o9Z+APv3B5OF6xZqiLLay/ZUVAPiuS2n+0=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr4956866wri.219.1645168241615; Thu, 17
 Feb 2022 23:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-19-arnd@kernel.org>
 <20220218063714.GL22576@lst.de>
In-Reply-To: <20220218063714.GL22576@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 08:10:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ac9Wo6fs+Wbdw3-WHfzF9vu_CZs5EUUTX-1iALUr54w@mail.gmail.com>
Message-ID: <CAK8P3a3ac9Wo6fs+Wbdw3-WHfzF9vu_CZs5EUUTX-1iALUr54w@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 18, 2022 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> s/maining/remaining/ ?
>
> Or maybe rather:
>
> uaccess: remove CONFIG_SET_FS
>
> because it is all gone now.
>
> > With CONFIG_SET_FS gone, so drop all remaining references to
> > set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
>
> And this sentence does not parse.

Both fixed now, thanks!

       Arnd
