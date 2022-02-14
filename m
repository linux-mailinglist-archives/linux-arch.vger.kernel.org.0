Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D54B5BD3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 22:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiBNVBT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 16:01:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBNVBS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 16:01:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABAA7A9A0;
        Mon, 14 Feb 2022 13:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85B276114B;
        Mon, 14 Feb 2022 19:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7E9C36AE5;
        Mon, 14 Feb 2022 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644867970;
        bh=kZ0Ha+ZttRWbRYErkpKyuJC1dyK+QrO2i6Uu5KgHMvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y0tFdEItPyIpX9Q57aljIliTeAqJEjfsGhV5sRnV7cHDKUAHBtZxnjnJQ0aG/E0DY
         ntmMdawRiR6T8SjqmJRkg+eiX9WIai06zkYCR7faiov+1eO6KA28Xd0WJ3G4HzZ7Ki
         PswrJdfwevWrM+GcXzzieldjGJJj+F38X56atyYmYHaGjvacQFUxk+Q3y53FA51+T8
         ZklKna1hQALqex7ucGzH+u+kKR6+AMMF6Gi34rWhxaWoueN0V5gBdQpdknscuvJdj6
         4dVyfkX9O/n11Gjix37hL+YmaFTxTy2u9mOy0+3ugdzfzd4uf88HSfSBljtkByDhnd
         ubPSK5lCMcVZQ==
Received: by mail-wr1-f41.google.com with SMTP id u1so14852926wrg.11;
        Mon, 14 Feb 2022 11:46:09 -0800 (PST)
X-Gm-Message-State: AOAM530+hUo7NYph3CoxZKeAS43/bo2W3QPt8WJJKe7U6Fn0KDR5F9k4
        RArsrLOi1yqH17m35h1qJUJXZtctpKBtOdHzC0c=
X-Google-Smtp-Source: ABdhPJyfeYwWpAfp1t9O1z8BIiteD6oMiQUhUFLNHvAQyjgPbxD0FyJauHtAzbL5TNr8UyIGWRM1U9VPuoeyXIyyYo0=
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr445399wrp.219.1644867968239;
 Mon, 14 Feb 2022 11:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org>
In-Reply-To: <YgqLFYqIqkIsNC92@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Feb 2022 20:45:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
Message-ID: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
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
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Mon, Feb 14, 2022 at 6:02 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:42PM +0100, Arnd Bergmann wrote:
> > +#define __range_not_ok(addr, size, limit)    (!__access_ok(addr, size))
> > +#define __chk_range_not_ok(addr, size, limit)        (!__access_ok((void __user *)addr, size))
>
> Can we just kill these off insted of letting themm obsfucate the code?

As Al pointed out, they turned out to be necessary on sparc64, but the only
definitions are on sparc64 and x86, so it's possible that they serve a similar
purpose here, in which case changing the limit from TASK_SIZE to
TASK_SIZE_MAX is probably wrong as well.

So either I need to revert the original definition as I did on sparc64, or
they can be removed completely. Hopefully Al or the x86 maintainers
can clarify.

         Arnd
