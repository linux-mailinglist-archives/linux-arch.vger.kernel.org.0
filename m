Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06784B886E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiBPNHB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:07:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiBPNG5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:06:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D310FCA;
        Wed, 16 Feb 2022 05:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526246165D;
        Wed, 16 Feb 2022 13:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFCC340FC;
        Wed, 16 Feb 2022 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645016803;
        bh=XpyXyO6XeLPMFwMT57AZNzNQgXnMBZ2Ni2r+dAXZ1s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m86IV6YQZzHRJuDux3taFbaRjn+w9RuI6vh4wtLv8qscNybLMG9S7+2rm1PNzrb20
         Dd5S6VsCYA0xUl1vOFFn3tNcP5kMF/3okjlp1F0h2o1Xvta1epkmZYCJUZnDs3yLoA
         VzYx4F/n1Ow3YwU1D9VL3p/ZapRwreq4wU2F2zdBEZVDPHlhJZ5UCirUITvqXKP03u
         mjPPXaT5ZCAExBhxPZs+6x/NgZOCXftC+3jOhCw6lYUHk202K2WWgJTp7zViNeOTI3
         d6qcX+NrilxdmbmnVfKB2lTecLHUYHmjxyqYH1gVkIK8Gk+2LbSYNZnzPmnsXhuwAQ
         I1fP9Rg2mGbLg==
Received: by mail-wm1-f43.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so3733479wml.0;
        Wed, 16 Feb 2022 05:06:43 -0800 (PST)
X-Gm-Message-State: AOAM533suSpGIPZFo6azCEQzN6a4sWKCfT6uZn8ZqdIqnaHa/7jtM2Qg
        XgW6pdas+HRdBq2uY66T9weLH2VaAJuntcNtlvg=
X-Google-Smtp-Source: ABdhPJz2fGQt4XBj3ZPZmmV0DF3C11Wmt7pFZ5Wv5cMpV0NQk32vVK4/Sp5p4cooe9t3m3i9Hn5C5g4DuBewCt15hb0=
X-Received: by 2002:a1c:21c5:0:b0:37d:40d0:94c7 with SMTP id
 h188-20020a1c21c5000000b0037d40d094c7mr1551416wmh.1.1645016801710; Wed, 16
 Feb 2022 05:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-12-arnd@kernel.org>
 <YgqMLYJs0RMecMck@infradead.org>
In-Reply-To: <YgqMLYJs0RMecMck@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 16 Feb 2022 14:06:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PwjB+KE+j3_sknZuiuY-kUe_J76nYac-mx82dccA3Rw@mail.gmail.com>
Message-ID: <CAK8P3a0PwjB+KE+j3_sknZuiuY-kUe_J76nYac-mx82dccA3Rw@mail.gmail.com>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> >  void prom_world(int enter)
> >  {
> > -     if (!enter)
> > -             set_fs(get_fs());
> > -
> >       __asm__ __volatile__("flushw");
> >  }
>
> The enter argument is now unused.

Right, good point. I'll add a comment, but I think I will leave that
as this seems
too hard to change the callers in assembly code for this. If any
sparc64 developer
wants to clean that up, I'm happy to integrate the cleanup patch in my series.

         Arnd
