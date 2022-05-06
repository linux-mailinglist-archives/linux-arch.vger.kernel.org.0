Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C051DB46
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442527AbiEFPA4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347797AbiEFPAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 11:00:54 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6855D66D;
        Fri,  6 May 2022 07:57:11 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id o18so6148249qtk.7;
        Fri, 06 May 2022 07:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFKDqxAl8kAhgchSspFlV1jC/a94gKje1e9uHi6vXps=;
        b=Sxg80agDa7tTqUp3W7rKa3hzSGeUm0htCDCMpdxBfSW0Sl6vkmAldg8nkZeY+t+3Qw
         Td/DgDcz6zLCnOJd0yh8vgClck/yq5IggwtZvuTvHDZ47dC27m5GSKZichMdjR7TxiGd
         1ukA5wVzWnyDoJ+4gput1p1ZUfzV92SaHyMhBQf0TiFt73clt/7q3vj0Olv4dPaoAHej
         r80vHBT02YVWB6Wie5tECcwOp7jfuHkvszD4FdwE9KPSd+VEVZTgLob5zt5NWUktU3O9
         GpHRbAy9ot+bdATuL/Cgb378IejVLTVfZNkDjRgB2IvwQdY3Pfb2EoR9FWtH2SSLRYGp
         TMKA==
X-Gm-Message-State: AOAM530FkhTo3eQXUQwXcQTBWzoZecZ2RoLv3DUj68jTR7w5GJPhkh4m
        k/Y+jnv1uvtXHxZWFxHacveZfP6ig/XtWQ==
X-Google-Smtp-Source: ABdhPJyl9inILtiiUaqhn5+Zn+N7rFGA5s6hayF71VOrk/V+P992tPXwAN2jICQyiuOzEoI1mGTdcQ==
X-Received: by 2002:a05:622a:3c8:b0:2f3:7231:913e with SMTP id k8-20020a05622a03c800b002f37231913emr3168671qtx.212.1651849030333;
        Fri, 06 May 2022 07:57:10 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87764000000b002f39b99f6a2sm2504428qtu.60.2022.05.06.07.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 07:57:09 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id w17so13293397ybh.9;
        Fri, 06 May 2022 07:57:08 -0700 (PDT)
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr2500583ybs.365.1651849027963; Fri, 06
 May 2022 07:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas> <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk> <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
 <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk> <5239892986c94239a122ab2f7a18a7a5@AcuMS.aculab.com>
 <alpine.DEB.2.21.2205061412080.52331@angie.orcam.me.uk> <3669a28a055344a792b51439c953fd30@AcuMS.aculab.com>
 <alpine.DEB.2.21.2205061440260.52331@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205061440260.52331@angie.orcam.me.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 May 2022 16:56:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsjRUKYqS0nkKsT08A4a4ipuhn7AG+ZqcHBqZvVX02OQ@mail.gmail.com>
Message-ID: <CAMuHMdVsjRUKYqS0nkKsT08A4a4ipuhn7AG+ZqcHBqZvVX02OQ@mail.gmail.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Rich Felker <dalias@libc.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Maciej,

On Fri, May 6, 2022 at 4:44 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Fri, 6 May 2022, David Laight wrote:
> > >  It was retrofitted in that x86 systems already existed for ~15 years when
> > > PCI came into picture.  Therefore the makers of the CPU ISA couldn't have
> > > envisaged the need for config access instructions like they did for memory
> > > and port access.
> >
> > Rev 2.0 of the PCI spec (1993) defines two mechanisms for config cycles.
> > #2 is probably the first one and maps all of PCI config space into
> > 4k of IO space (PCI bridges aren't supported).
>
>  This one is even more horrid than #1 in that it requires two separate
> preparatory I/O writes rather than just one, one to the Forward Register
> (at 0xcfa) to set the bus number, and another to the Configuration Space
> Enable Register (at 0xcf8) to set the function number, before you can
> issue a configuration read or write to a device.  So you need MP locking
> too.
>
>  NB only peer bridges aren't supported with this mechanism, normal PCI-PCI
> bridges are, via the Forward Register.
>
> > #1 requires a pair of accesses (and SMP locking).
> >
> > Neither is really horrid.
>
>  Both are.  First neither is MP-safe and second both are indirect in that
> you need to poke at some chipset registers before you can issue the actual
> read or write.
>
>  Sane access would require a single CPU instruction to read or write from
> the configuration space.  To access the conventional PCI configuration
> space in a direct linear manner you need 256 * 21 * 8 * 256 = 10.5MiB of
> address space.  Such amount of address space seems affordable even with
> 32-bit systems.

Won't have fit in the legacy 1 MiB space ("640 KiB...").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
