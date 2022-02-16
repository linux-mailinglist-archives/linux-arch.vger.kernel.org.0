Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798554B887E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiBPNHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:07:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBPNHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:07:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDF12858A;
        Wed, 16 Feb 2022 05:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C32B81EDA;
        Wed, 16 Feb 2022 13:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2436C340FA;
        Wed, 16 Feb 2022 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645016838;
        bh=1AijW/WQHr1DB1sxEAf5u6qv337FtGM78rBteqtJsFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iN729W8eTzLUmDGyJvEI0HE0OkfEC9ALEUXFXgdGhQXPvSwBAbGx4Bm4JUzW2PC8s
         BUMcbAlGBg1oLv2VeML280237jVmEo5gaC6UDs56p3vjvFXfFS/uKYdSKjDuePRk1L
         ktHY4DZBfIfbMM+DZtBJsD1tLcjqddiWlefZ3tjDhL0ZaU2r/dIUVsti11RXTBoqeV
         Fv+44VNG8OJe97by5ltQ4+nZVecfzeBcTyXFP1Nn1XVJH9wwXssVksGeqND4hscY9C
         RdLVWj/y1SlCH/eoBwY9xia343UtnPrsFJT6xH3Aw2TalwP1wcgKbcKqShewHfbFGA
         MgV75zhrtRvrQ==
Received: by mail-wm1-f54.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so3698012wme.3;
        Wed, 16 Feb 2022 05:07:18 -0800 (PST)
X-Gm-Message-State: AOAM5313k6us+SjiT6l/QYoYSQj7CpHbnSMbdaqLH+8TbhtBWeAt+bOx
        J7/aSvJdNAsjrY9EEFSBwBH6pyX39LSPgGMQUeY=
X-Google-Smtp-Source: ABdhPJwloTGuyJt/Hdm31OFklwbHVE+n23OzkTYnWy+HDNvimUM0g1FM9pYMdMLaGtlr03PBtziLgSkYqMH3Naa88b4=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr1594630wms.82.1645016837028; Wed, 16
 Feb 2022 05:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-12-arnd@kernel.org>
 <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
In-Reply-To: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 16 Feb 2022 14:07:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30supB-MNzhoELOerOemxwTfDFFqZrzmNDQA=WW+VLbw@mail.gmail.com>
Message-ID: <CAK8P3a30supB-MNzhoELOerOemxwTfDFFqZrzmNDQA=WW+VLbw@mail.gmail.com>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
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

On Tue, Feb 15, 2022 at 1:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:
>
> > -/*
> > - * Sparc64 is segmented, though more like the M68K than the I386.
> > - * We use the secondary ASI to address user memory, which references a
> > - * completely different VM map, thus there is zero chance of the user
> > - * doing something queer and tricking us into poking kernel memory.
>
> Actually, this part of comment probably ought to stay - it is relevant
> for understanding what's going on (e.g. why is access_ok() always true, etc.)

Ok, I've put it back now.

       Arnd
