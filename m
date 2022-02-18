Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6784BB30D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 08:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiBRHQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 02:16:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiBRHQs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 02:16:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BF65A8;
        Thu, 17 Feb 2022 23:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C91CCE30E4;
        Fri, 18 Feb 2022 07:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8D4C340F8;
        Fri, 18 Feb 2022 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168588;
        bh=q+jKWrJ4jJZ2v7I08P11+5fwNrVng4vZR8KgCaGgNp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E7Qj225LkHl4vakpp/86Clw8A8aYCNcpfLrBP+VCQdOQM5BITuaFC8aajiIPA17sq
         QsQL+tpQFefxmctximGZjJghHIgDs0+5uBmhr8xxAaHPynJ3FAz/VvdJ7A4yiUcYzD
         cvOPc8xsA1RVRdeBpZvu7iuJPB2dq0pqYhhG0eac2ra/YlTXeM+fTnsQjW5NHDOU4h
         cinPsKBHoi0lD++02CV6Px7pd6xZwvcPqjj04/ifU1PciDsuXI0NkC0Bbm1nyirKYP
         OBBXTMFOAcsBgbQTb4NkJ7ZQ5y+D67DT81A8imqE8C6wMfM2VmNDYRx0F0jR7hwP1U
         QI8LFbE7ThFyQ==
Received: by mail-wr1-f49.google.com with SMTP id u2so11800679wrw.1;
        Thu, 17 Feb 2022 23:16:28 -0800 (PST)
X-Gm-Message-State: AOAM530sQq6ZE/FpybFbLJnHlqIh6oA16GB+v9iGa/uFpB4J+PGKTGoZ
        yb7tIC8BPN7oXsrpXUWxyzYBylNsZXJjxCUQhrs=
X-Google-Smtp-Source: ABdhPJzrsD9ZegAYWxopB2Dqyhs5CbptDH37N4ZCxM0ghQnmxjYRVare/kFAwMrZOPIITOhmBYHifd3MXTFISbjy0gQ=
X-Received: by 2002:adf:c406:0:b0:1e4:a5ae:34a3 with SMTP id
 v6-20020adfc406000000b001e4a5ae34a3mr5120080wrf.407.1645168587142; Thu, 17
 Feb 2022 23:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
In-Reply-To: <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 08:16:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2r3zB2G7CjCdXB6cDx1Q7jdOnA8YcCHM+3Q3CybnZ=hQ@mail.gmail.com>
Message-ID: <CAK8P3a2r3zB2G7CjCdXB6cDx1Q7jdOnA8YcCHM+3Q3CybnZ=hQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
To:     Andy Lutomirski <luto@amacapital.net>
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

On Thu, Feb 17, 2022 at 8:15 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Wed, Feb 16, 2022 at 5:19 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are many different ways that access_ok() is defined across
> > architectures, but in the end, they all just compare against the
> > user_addr_max() value or they accept anything.
> >
> > Provide one definition that works for most architectures, checking
> > against TASK_SIZE_MAX for user processes or skipping the check inside
> > of uaccess_kernel() sections.
> >
> > For architectures without CONFIG_SET_FS(), this should be the fastest
> > check, as it comes down to a single comparison of a pointer against a
> > compile-time constant, while the architecture specific versions tend to
> > do something more complex for historic reasons or get something wrong.
>
> This isn't actually optimal.  On x86, TASK_SIZE_MAX is a bizarre
> constant that has a very specific value to work around a bug^Wdesign
> error^Wfeature of Intel CPUs.  TASK_SIZE_MAX is the maximum address at
> which userspace is permitted to allocate memory, but there is a huge
> gap between user and kernel addresses, and any value in the gap would
> be adequate for the comparison.  If we wanted to optimize this, simply
> checking the high bit (which x86 can do without any immediate
> constants at all) would be sufficient and, for an access known to fit
> in 32 bits, one could get even fancier and completely ignore the size
> of the access.  (For accesses not known to fit in 32 bits, I suspect
> some creativity could still come up with a construction that's
> substantially faster than the one in your patch.)
>
> So there's plenty of room for optimization here.
>
> (This is not in any respect a NAK -- it's just an observation that
> this could be even better.)

Thank you for taking a look!

As you can see in the patch that changes the algorithm on x86 [1],
it was already using TASK_SIZE_MAX as the limit, only the order
in which the comparison is done, hopefully leading to better code
already. I have looked at trivial examples on x86 that showed an
improvement for constant sizes, but only looked at arm64 in detail
for the overall result.

It may be worth checking if using LONG_MAX as the limit produces
better code, but it's probably best to do the optimization in the
common code in a portable way to keep it from diverging again.

       Arnd

[1] https://lore.kernel.org/lkml/20220216131332.1489939-7-arnd@kernel.org/
