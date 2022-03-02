Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DE4CA1C5
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiCBKG0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 2 Mar 2022 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbiCBKGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2022 05:06:25 -0500
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10053BB0BB;
        Wed,  2 Mar 2022 02:05:42 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id n10so582188vkm.10;
        Wed, 02 Mar 2022 02:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EYfrVL/3Fk55o7PeesHa/rcefVwDuQvh3Zqyw9HxNck=;
        b=rfWplJha9OKbeEVMLVHvc8rfeL+90OqRyjDeiEL/ZoPX2hQ5gdKG3ZdtG+no/w4F+p
         OnguJezzxM2tDIkfu1wvm2DfJRPrDRQr+9dIj348wHFbVdfWsWq4UEHhIsbJ8M5qq+rY
         T0+IVcjW+3EY7tfnpDp4D8s2pJtgN0TqTF4RBrGDR0FtCm8VG7XU0yQin/3Om5lUrUzb
         N3djNJdP97HV32MoCk0IhuR4hvvrWy+ywGypsp4+ciBVA8CDr+JgpSQqTDgdtHt3muXg
         cgleyiUIrB0N5oy34xDlLF4+68k0iZ4dE07rk7frYjfclPZxWRUnZBvLEMgX/58zOUey
         m+NQ==
X-Gm-Message-State: AOAM531o0G2Djd/8Zgphb7GQSW/tsaoMuU8BSPxT1dw0D9lCU7dl1/B+
        lsoWCluAgjxYpAv9CEX7JSW9C+gaczEH1Q==
X-Google-Smtp-Source: ABdhPJx8+0YbfUdGRM/EUcSE7UvnFBBDPOp01Ea6jnM2+VzIJfhR/ksKn/oJ3xxsMx6XoqeDOUdR7g==
X-Received: by 2002:a05:6122:549:b0:319:88bd:bd17 with SMTP id y9-20020a056122054900b0031988bdbd17mr13555360vko.37.1646215540836;
        Wed, 02 Mar 2022 02:05:40 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id q23-20020a056102127700b0031c108bb5b6sm2161432vsg.23.2022.03.02.02.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 02:05:40 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id j3so1248743vsi.7;
        Wed, 02 Mar 2022 02:05:39 -0800 (PST)
X-Received: by 2002:a67:c499:0:b0:320:2cd8:9e1a with SMTP id
 d25-20020a67c499000000b003202cd89e1amr266158vsk.38.1646215539723; Wed, 02 Mar
 2022 02:05:39 -0800 (PST)
MIME-Version: 1.0
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk> <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
 <Yh1pYAOiskEQes3p@shell.armlinux.org.uk> <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
 <c3b60de0-38cd-160a-aa15-831349e07e23@arm.com> <52866c88-59f9-2d1c-6f5a-5afcaf23f2bb@csgroup.eu>
 <9caa90f5-c10d-75dd-b403-1388b7a3d296@arm.com>
In-Reply-To: <9caa90f5-c10d-75dd-b403-1388b7a3d296@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Mar 2022 11:05:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU11kaOzanhHZRH+mLTJzaz-i=PnKdK7NF9V-qx6kp8wg@mail.gmail.com>
Message-ID: <CAMuHMdU11kaOzanhHZRH+mLTJzaz-i=PnKdK7NF9V-qx6kp8wg@mail.gmail.com>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Wed, Mar 2, 2022 at 10:51 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 3/2/22 12:35 PM, Christophe Leroy wrote:
> > Le 02/03/2022 à 04:22, Anshuman Khandual a écrit :
> >> On 3/1/22 1:46 PM, Christophe Leroy wrote:
> >>> Le 01/03/2022 à 01:31, Russell King (Oracle) a écrit :
> >>>> On Tue, Mar 01, 2022 at 05:30:41AM +0530, Anshuman Khandual wrote:
> >>>>> On 2/28/22 4:27 PM, Russell King (Oracle) wrote:
> >>>>>> On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> >>>>>>> This defines and exports a platform specific custom vm_get_page_prot() via
> >>>>>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> >>>>>>> macros can be dropped which are no longer needed.
> >>>>>>
> >>>>>> What I would really like to know is why having to run _code_ to work out
> >>>>>> what the page protections need to be is better than looking it up in a
> >>>>>> table.
> >>>>>>
> >>>>>> Not only is this more expensive in terms of CPU cycles, it also brings
> >>>>>> additional code size with it.
> >>>>>>
> >>>>>> I'm struggling to see what the benefit is.
> >>>>>
> >>>>> Currently vm_get_page_prot() is also being _run_ to fetch required page
> >>>>> protection values. Although that is being run in the core MM and from a
> >>>>> platform perspective __SXXX, __PXXX are just being exported for a table.
> >>>>> Looking it up in a table (and applying more constructs there after) is
> >>>>> not much different than a clean switch case statement in terms of CPU
> >>>>> usage. So this is not more expensive in terms of CPU cycles.
> >>>>
> >>>> I disagree.
> >>>
> >>> So do I.
> >>>
> >>>>
> >>>> However, let's base this disagreement on some evidence. Here is the
> >>>> present 32-bit ARM implementation:
> >>>>
> >>>> 00000048 <vm_get_page_prot>:
> >>>>         48:       e200000f        and     r0, r0, #15
> >>>>         4c:       e3003000        movw    r3, #0
> >>>>                           4c: R_ARM_MOVW_ABS_NC   .LANCHOR1
> >>>>         50:       e3403000        movt    r3, #0
> >>>>                           50: R_ARM_MOVT_ABS      .LANCHOR1
> >>>>         54:       e7930100        ldr     r0, [r3, r0, lsl #2]
> >>>>         58:       e12fff1e        bx      lr
> >>>>
> >>>> That is five instructions long.
> >>>
> >>> On ppc32 I get:
> >>>
> >>> 00000094 <vm_get_page_prot>:
> >>>         94: 3d 20 00 00     lis     r9,0
> >>>                     96: R_PPC_ADDR16_HA     .data..ro_after_init
> >>>         98: 54 84 16 ba     rlwinm  r4,r4,2,26,29
> >>>         9c: 39 29 00 00     addi    r9,r9,0
> >>>                     9e: R_PPC_ADDR16_LO     .data..ro_after_init
> >>>         a0: 7d 29 20 2e     lwzx    r9,r9,r4
> >>>         a4: 91 23 00 00     stw     r9,0(r3)
> >>>         a8: 4e 80 00 20     blr
> >>>
> >>>
> >>>>
> >>>> Please show that your new implementation is not more expensive on
> >>>> 32-bit ARM. Please do so by building a 32-bit kernel, and providing
> >>>> the disassembly.
> >>>
> >>> With your series I get:
> >>>
> >>> 00000000 <vm_get_page_prot>:
> >>>      0:     3d 20 00 00     lis     r9,0
> >>>                     2: R_PPC_ADDR16_HA      .rodata
> >>>      4:     39 29 00 00     addi    r9,r9,0
> >>>                     6: R_PPC_ADDR16_LO      .rodata
> >>>      8:     54 84 16 ba     rlwinm  r4,r4,2,26,29
> >>>      c:     7d 49 20 2e     lwzx    r10,r9,r4
> >>>     10:     7d 4a 4a 14     add     r10,r10,r9
> >>>     14:     7d 49 03 a6     mtctr   r10
> >>>     18:     4e 80 04 20     bctr
> >>>     1c:     39 20 03 15     li      r9,789
> >>>     20:     91 23 00 00     stw     r9,0(r3)
> >>>     24:     4e 80 00 20     blr
> >>>     28:     39 20 01 15     li      r9,277
> >>>     2c:     91 23 00 00     stw     r9,0(r3)
> >>>     30:     4e 80 00 20     blr
> >>>     34:     39 20 07 15     li      r9,1813
> >>>     38:     91 23 00 00     stw     r9,0(r3)
> >>>     3c:     4e 80 00 20     blr
> >>>     40:     39 20 05 15     li      r9,1301
> >>>     44:     91 23 00 00     stw     r9,0(r3)
> >>>     48:     4e 80 00 20     blr
> >>>     4c:     39 20 01 11     li      r9,273
> >>>     50:     4b ff ff d0     b       20 <vm_get_page_prot+0x20>
> >>>
> >>>
> >>> That is definitely more expensive, it implements a table of branches.
> >>
> >> Okay, will split out the PPC32 implementation that retains existing
> >> table look up method. Also planning to keep that inside same file
> >> (arch/powerpc/mm/mmap.c), unless you have a difference preference.
> >
> > My point was not to get something specific for PPC32, but to amplify on
> > Russell's objection.
> >
> > As this is bad for ARM and bad for PPC32, do we have any evidence that
> > your change is good for any other architecture ?
> >
> > I checked PPC64 and there is exactly the same drawback. With the current
> > implementation it is a small function performing table read then a few
> > adjustment. After your change it is a bigger function implementing a
> > table of branches.
>
> I am wondering if this would not be the case for any other switch case
> statement on the platform ? Is there something specific/different just
> on vm_get_page_prot() implementation ? Are you suggesting that switch
> case statements should just be avoided instead ?
>
> >
> > So, as requested by Russell, could you look at the disassembly for other
> > architectures and show us that ARM and POWERPC are the only ones for
> > which your change is not optimal ?
>
> But the primary purpose of this series is not to guarantee optimized
> code on platform by platform basis, while migrating from a table based
> look up method into a switch case statement.
>
> But instead, the purposes is to remove current levels of unnecessary
> abstraction while converting a vm_flags access combination into page
> protection. The switch case statement for platform implementation of
> vm_get_page_prot() just seemed logical enough. Christoph's original
> suggestion patch for x86 had the same implementation as well.
>
> But if the table look up is still better/preferred method on certain
> platforms like arm or ppc32, will be happy to preserve that.

I doubt the switch() variant would give better code on any platform.

What about using tables everywhere, using designated initializers
to improve readability?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
