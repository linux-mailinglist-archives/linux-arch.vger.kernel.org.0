Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DF4B6D2C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiBONRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 08:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiBONRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 08:17:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D2D10A6;
        Tue, 15 Feb 2022 05:17:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2493B819C2;
        Tue, 15 Feb 2022 13:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75858C340FA;
        Tue, 15 Feb 2022 13:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644931028;
        bh=yV4ORJd5b6IZao4Zu1H2u9bAD/0nkvfeGMC8j+boEO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1UbQDYKVd/W55uCfVo2WGlgo3dfDZUC0yTFtlZUY0DOBzt83pgV9/7gMxh05e3AH
         lgukd8DqmxPwxja7mK4vtMYnDC6X4AvagIoktla5uPG7vSSfPBtEQFLrXn9FMcdgHH
         E1qEJeHLjvJUuBL6dqkrwsbxdH4jW8atiF/scjZBMC9lLF7Ype1WGnPRnqUer24JD8
         tu4gGKuwZtD0+Nibza1Ys9PPtyZzsqg7g90GGNebDRKc+NU4HRCxVmDtvM0+9S5mSP
         qhfZT5HIgJ8aWSTxW8hfUnfgxShZHe3y/AzzhEX87Jyr/ToKwZr4yc1EXWSuI0q6BQ
         u0/dxkrR5dDfA==
Received: by mail-wm1-f52.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so1379952wml.5;
        Tue, 15 Feb 2022 05:17:08 -0800 (PST)
X-Gm-Message-State: AOAM531nWLz2K8rL/bc46tYq+Deksn/ZiXUMR8HxJ4KV/G/F9pyHwQOj
        z0x5V3QvmmSWc4VSjahm5CFqvuHjNvNkD91335I=
X-Google-Smtp-Source: ABdhPJzhbiTSvbv50mQWSJ7smaLZnr2q978YJ0F6+MeQ3SrwEp5s0NrkvRE5+WnWUVexqYiFblH5E9BGGqHgxsxWGyI=
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr3088436wmq.98.1644931026534;
 Tue, 15 Feb 2022 05:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-6-arnd@kernel.org>
 <Ygr0eAA+ZR1eX0wb@zeniv-ca.linux.org.uk>
In-Reply-To: <Ygr0eAA+ZR1eX0wb@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Feb 2022 14:16:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2+qG=Q9Si_2D7wjM7Qao2JCnYqKgU=W-SFwoG+fT-U3A@mail.gmail.com>
Message-ID: <CAK8P3a2+qG=Q9Si_2D7wjM7Qao2JCnYqKgU=W-SFwoG+fT-U3A@mail.gmail.com>
Subject: Re: [PATCH 05/14] uaccess: add generic __{get,put}_kernel_nofault
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
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

On Tue, Feb 15, 2022 at 1:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:43PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > All architectures that don't provide __{get,put}_kernel_nofault() yet
> > can implement this on top of __{get,put}_user.
> >
> > Add a generic version that lets everything use the normal
> > copy_{from,to}_kernel_nofault() code based on these, removing the last
> > use of get_fs()/set_fs() from architecture-independent code.
>
> I'd put the list of those architectures (AFAICS, that's alpha, ia64,
> microblaze, nds32, nios2, openrisc, sh, sparc32, xtensa) into commit
> message - it's not that hard to find out, but...

done.

> And AFAICS, you've missed nios2 - see
> #define __put_user(x, ptr) put_user(x, ptr)
> in there.  nds32 oddities are dealt with earlier in the series, this
> one is not...

Ok, fixed my bug in nios2 __put_user() as well now. This one is not nearly
as bad as nds32, at least without my patches it should work as expected.

Unfortunately I also noticed that __get_user() on microblaze and nios2
is completely broken for 64-bit arguments, where these copy eight bytes
into a four byte buffer. I'll try to come up with a fix for this as well then.

         Arnd
