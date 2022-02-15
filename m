Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAE4B68AC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiBOKCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 05:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiBOKCj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 05:02:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF89196;
        Tue, 15 Feb 2022 02:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CC16126D;
        Tue, 15 Feb 2022 10:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D8BC340F5;
        Tue, 15 Feb 2022 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644919348;
        bh=6OaJO5k8UStns9fCBustiYnW4Ue2uRRTBF363T6I8Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k2alkJqCK4tThaquDhNMTCGzfSPJoQ/+kF6M31KhrupjfCY12mmaxZXQGDR3lVlkH
         I3AKKVuIX4a/FRC22RpWas1peagK6eMoDIlyq/ClCx3eqN7pdZO4RnCoXP+Rla8Qps
         u0DMrsVXgSMbwt/E4fMYfx0BtSveveP9mpXMJ3ArTH8wBnn2Y+sb+V+b2EIOmZT06Q
         pqY4i7TzPYRkDpl6oeg7C5aWzjOIEZQJwAOn1lGP06V+D6ioRPTC25sJYFiILImHhL
         qmhL3MzhySo3dCg7GZz660sn4LBcHXU/aI3EOc+V67irk32eHunmx+R8h5+ABBl4dy
         P5O52Q7zn4hlg==
Received: by mail-wm1-f43.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so1084170wme.1;
        Tue, 15 Feb 2022 02:02:28 -0800 (PST)
X-Gm-Message-State: AOAM532qqzCeQzcec0sQIYk1ABbpPvp/JSvMDHclGOr0VoAwlTqsh8cU
        gINZBJM5+GYCcBrV/wZSgZNPMlowy1jq3qxvuxU=
X-Google-Smtp-Source: ABdhPJxXhF5oN8HK5+/UBfeNSuYxeBNAH3pN7Z2cMEK019oVoVAxn2dH7YUg+eieAXhNWJaJdsC0aGcEXS3C4UXMT34=
X-Received: by 2002:a05:600c:2108:b0:34e:870:966e with SMTP id
 u8-20020a05600c210800b0034e0870966emr2332972wml.173.1644919346591; Tue, 15
 Feb 2022 02:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-10-arnd@kernel.org>
 <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk> <20220215062942.GA12551@lst.de> <YgtSpk0boDjsyjFK@zeniv-ca.linux.org.uk>
In-Reply-To: <YgtSpk0boDjsyjFK@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Feb 2022 11:02:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0t-dnJXvXH0Mx5L-AeVQe1mYzRi0sQjYxzMQw-mVPv0Q@mail.gmail.com>
Message-ID: <CAK8P3a0t-dnJXvXH0Mx5L-AeVQe1mYzRi0sQjYxzMQw-mVPv0Q@mail.gmail.com>
Subject: Re: [PATCH 09/14] m68k: drop custom __access_ok()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tue, Feb 15, 2022 at 8:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Feb 15, 2022 at 07:29:42AM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 15, 2022 at 12:37:41AM +0000, Al Viro wrote:
> > > Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
> > > (and trim the comment down to "coldfire and 68000 will pick generic
> > > variant")?
> >
> > I wonder if we should invert CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> > select the separate address space config for s390, sparc64, non-coldfire
> > m68k and mips with EVA and then just have one single access_ok for
> > overlapping address space (as added by Arnd) and non-overlapping ones
> > (always return true).
>
> parisc is also such...  How about
>
>         select ALTERNATE_SPACE_USERLAND
>
> for that bunch?

Either of those works for me. My current version has this keyed off
TASK_SIZE_MAX==ULONG_MAX, but a CONFIG_ symbol does
look more descriptive.

>  While we are at it, how many unusual access_ok() instances are
> left after this series?  arm64, itanic, um, anything else?

x86 adds a WARN_ON_IN_IRQ() check in there. This could be
made generic, but it's not obvious what exactly the exceptions are
that other architectures need. The arm64 tagged pointers could
probably also get integrated into the generic version.

> FWIW, sparc32 has a slightly unusual instance (see uaccess_32.h there); it's
> obviously cheaper than generic and I wonder if the trick is legitimate (and
> applicable elsewhere, perhaps)...

Right, a few others have the same, but I wasn't convinced that this
is actually safe for call possible cases: it's trivial to construct a caller
that works on other architectures but not this one, if you pass a large
enough size value and don't access the contents in sequence.

Also, like the ((addr | (addr + size)) & MASK) check on some other
architectures, it is less portable because it makes assumptions about
the actual layout beyond a fixed address limit.

        Arnd
