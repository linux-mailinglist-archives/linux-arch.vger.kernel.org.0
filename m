Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2D4BB301
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 08:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiBRHQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 02:16:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiBRHQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 02:16:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EAE30F77;
        Thu, 17 Feb 2022 23:16:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F80661EF9;
        Fri, 18 Feb 2022 07:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C26C340EF;
        Fri, 18 Feb 2022 07:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168560;
        bh=vgWt8lxnjYZUPlvwCFWcIBvafVy+fWmkyAOoKRaWgHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dip1NFffCT7YD3qzSAr1Fin/GwmOB5NYBJTOzrs7U7/Bvm4XqaiPYE0m5TfZQusca
         MRbcrmTm5/SvvBBwJ6d+gM/F4x3xTDVRaN3NXTeg29thtPCJZj5ucrkgu2KYOhOcca
         YYG79UlIdYrQmh318MnQPoMOhj/pzpg3ySf0sXzNhV4tmppW8ULCqS+V4JeMQrhHjy
         P04kRQs0VFG/iaOGrdUQTVs7nOgPxJrBYQnBTVPJQ7UmXqpZWxnZi6pNAeXqxk5wFh
         MnH6liRJL8MC6e3VLCid/+t09EHzhk77W8JdtjJAyk2DbefTP4jt0D08fEK2pcAo0U
         1wdZA3S0EkbnQ==
Received: by mail-wr1-f42.google.com with SMTP id i14so12917264wrc.10;
        Thu, 17 Feb 2022 23:15:59 -0800 (PST)
X-Gm-Message-State: AOAM531nY9Ox06r5eRWMCbN4lrTxjl/ZMTy6NvJjCKWGuUsVtvf2QNTi
        a3VNJRV0/il9NJ27IVbdcWWaKHPixUEPP7gfRyU=
X-Google-Smtp-Source: ABdhPJyN/H83BSKKeXJGtgECPVgYv1w4NoilhoSCj+92CRqaoOjPXRtnkFYRBhAzB91QtgFwdj4YRtpnThbImHSlPPw=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr4972052wri.219.1645168558306; Thu, 17
 Feb 2022 23:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-15-arnd@kernel.org>
 <20220218063549.GJ22576@lst.de>
In-Reply-To: <20220218063549.GJ22576@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 08:15:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a31_zG7npZbPHGixOYL0p28dGzs3f9ku_RB4p1tiEY0Tw@mail.gmail.com>
Message-ID: <CAK8P3a31_zG7npZbPHGixOYL0p28dGzs3f9ku_RB4p1tiEY0Tw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] lib/test_lockup: fix kernel pointer check for
 separate address spaces
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

On Fri, Feb 18, 2022 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 16, 2022 at 02:13:28PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > test_kernel_ptr() uses access_ok() to figure out if a given address
> > points to user space instead of kernel space. However on architectures
> > that set CONFIG_ALTERNATE_USER_ADDRESS_SPACE, a pointer can be valid
> > for both, and the check always fails because access_ok() returns true.
> >
> > Make the check for user space pointers conditional on the type of
> > address space layout.
>
> What is this code even trying to do?  It looks extremly broken.

As I understand it, this is only meant for debugging, and the module contains
intentionally broken lock usage to test whether the watchdog and lockup
detection in the kernel is able to find them.

I did not try that hard to understand how it works though.

      Arnd
