Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9D4C0F2B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiBWJ1h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 04:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiBWJ1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 04:27:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA632AE58;
        Wed, 23 Feb 2022 01:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA406169C;
        Wed, 23 Feb 2022 09:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF46C340F9;
        Wed, 23 Feb 2022 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645608427;
        bh=D2jUPs6ryRSFqPbSylqUkNdDZuOthbzsmeMEmvziyjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qprkztvt/vehYNHRcEK8aqRshRS+P9DBpcRom+Ea4pnSLocGv1eBVL2v483vi1brP
         yniMjXK/S41L4Xb5GxmMolqLanH2PfdtLhr4aslEr3qRf3FRgZXiElzFJkvdC4w2nN
         JS6y8Uxpo3q6QV2cYcl6Kk1+VLa3u1w7dstKq6JdbSKRuvb7qsDfR1olUXgTRiM4lW
         h9gXptbf8SQ/Kn95+tqUCiEvk6NU1742fRGNTdgV5FXZ+Nd86Q2w5JlwL02OxgP5C1
         +ol87y0DUBe7bzeKEkX3OWQML5KSSUNMqefzAhTnHd6BCu3L5B6sV9dAoeIrCnSrMr
         hGVco4bZ15heQ==
Received: by mail-wm1-f51.google.com with SMTP id p4so3139192wmg.1;
        Wed, 23 Feb 2022 01:27:07 -0800 (PST)
X-Gm-Message-State: AOAM533rjH2d5XuwiAcxoxjxPHchWShU53/wM3Yax8XoRhTZ4LMUtHmz
        eSTAI3Q94+vqKovfLZNqqD5cgnhheiiFvMqGvbc=
X-Google-Smtp-Source: ABdhPJwtMkGkHNVPhtWq1LOTi2OcT9JVNmxiOoaUyabWMpAtHbaXvG0B+oJZMTvLmHy/MuDTQEaSkGsJ6B3oEOPptXw=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr6779098wms.82.1645608425823; Wed, 23
 Feb 2022 01:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220223074127.GA8287@alpha.franken.de>
In-Reply-To: <20220223074127.GA8287@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 23 Feb 2022 10:26:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nM3yPhjhMtUQyd5srgB99OkUvmapWv13KCuJXsf=euw@mail.gmail.com>
Message-ID: <CAK8P3a1nM3yPhjhMtUQyd5srgB99OkUvmapWv13KCuJXsf=euw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 8:41 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > index db9a8e002b62..d7c89dc3426c 100644
> > --- a/arch/mips/include/asm/uaccess.h
> > +++ b/arch/mips/include/asm/uaccess.h
> > @@ -19,6 +19,7 @@
> >  #ifdef CONFIG_32BIT
> >
> >  #define __UA_LIMIT 0x80000000UL
> > +#define TASK_SIZE_MAX        __UA_LIMIT
>
> using KSEG0 instead would IMHO be the better choice. This gives the
> chance to remove __UA_LIMIT completly after cleaning up ptrace.c

Ok, changed now.

      Arnd
