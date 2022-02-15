Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D824B67C9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiBOJkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 04:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiBOJkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 04:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CECE3881;
        Tue, 15 Feb 2022 01:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D11C2B8185C;
        Tue, 15 Feb 2022 09:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D751C340F9;
        Tue, 15 Feb 2022 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644918004;
        bh=hv8AUuEMkapI1zY2x6Wj+fHd7ew8TaKYgsOBPTPrxmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qgz5FlPpKWsWGCSKlOreQeA49RzB47Yb61DpdQGkSqCvpQXhd/1xrVzA6HxgVkOAv
         HM/bWEouCkOrFRfLVSWs2TAF8Lvnm82Q7ljXZwaQBoSUgr63Phu8Xh5sdVnTyJI/ON
         lHIubRtLqY287IV/RrnG/iEcxILMQsa62F1uuyYy08GpnMfCYeG+01yyQZZn7UnJv7
         021LqbfWi1zld4k8/8Wmx6fnGfR5no+iR4l8Y+N7e700ePaO67g4IaN0y0Orgs7STR
         gYOAdpNAvnxBHFJPJ1WrXSLgaxHaPAb+pRZVWsShzWY/LNUX3cgIy9+U52JoF4j03G
         HEN4j4yjmnzVQ==
Received: by mail-wm1-f49.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso1024782wmq.4;
        Tue, 15 Feb 2022 01:40:04 -0800 (PST)
X-Gm-Message-State: AOAM531J5BbA2tq+ZrO2lMXu1GyShx/RoveGKKoSQ3d4y/40vJp0pF5k
        5RSVmhlT3A9RLcg1FrOEAGhO7GBLSr55OHQcjeQ=
X-Google-Smtp-Source: ABdhPJxpFSyo2tIfVZXx6xnWqAN7kXzL0SfiKGeaqLH7fIF3GRmujo8Iug1QC1Z1ypgNgRnGoRSGx0exr14yXtWS6QY=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr2314325wms.82.1644918002508; Tue, 15
 Feb 2022 01:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
 <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com> <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Feb 2022 10:39:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0NTqK_m7q909d8FN6is8k4_u3zeckC9XOrjEi7kqSvmg@mail.gmail.com>
Message-ID: <CAK8P3a0NTqK_m7q909d8FN6is8k4_u3zeckC9XOrjEi7kqSvmg@mail.gmail.com>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
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
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Robin Murphy <robin.murphy@arm.com>
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

On Tue, Feb 15, 2022 at 10:21 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 15 Feb 2022 at 10:13, Arnd Bergmann <arnd@kernel.org> wrote:
>
> arm64 also has this leading up to the range check, and I think we'd no
> longer need it:
>
>     if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
>         (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>             addr = untagged_addr(addr);

I suspect the expensive part here is checking the two flags, as untagged_addr()
seems to always just add a sbfx instruction. Would this work?

#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
#define access_ok(ptr, size) __access_ok(untagged_addr(ptr), (size))
#else // the else path is the default, this can be left out.
#define access_ok(ptr, size) __access_ok((ptr), (size))
#endif

       Arnd
