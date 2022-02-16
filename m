Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6D4B907D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 19:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiBPSla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 13:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiBPSl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 13:41:29 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014282AF902
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 10:41:15 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 0f791715-8f58-11ec-b2df-0050568cd888;
        Wed, 16 Feb 2022 18:41:32 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id B2BEB194B1C;
        Wed, 16 Feb 2022 19:41:12 +0100 (CET)
Date:   Wed, 16 Feb 2022 19:41:09 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v2 15/18] sparc64: remove CONFIG_SET_FS support
Message-ID: <Yg1FRZcrhlh5C//V@ravnborg.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-16-arnd@kernel.org>
 <Yg1D08+olCSGmnYU@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg1D08+olCSGmnYU@ravnborg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Wed, Feb 16, 2022 at 07:34:59PM +0100, Sam Ravnborg wrote:
> Hi Arnd.
> 
> On Wed, Feb 16, 2022 at 02:13:29PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > sparc64 uses address space identifiers to differentiate between kernel
> > and user space, using ASI_P for kernel threads but ASI_AIUS for normal
> > user space, with the option of changing between them.
> > 
> > As nothing really changes the ASI any more, just hardcode ASI_AIUS
> > everywhere. Kernel threads are not allowed to access __user pointers
> > anyway.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/sparc/include/asm/processor_64.h   |  4 ----
> >  arch/sparc/include/asm/switch_to_64.h   |  4 +---
> >  arch/sparc/include/asm/thread_info_64.h |  4 +---
> >  arch/sparc/include/asm/uaccess_64.h     | 20 +-------------------
> >  arch/sparc/kernel/process_64.c          | 12 ------------
> >  arch/sparc/kernel/traps_64.c            |  2 --
> >  arch/sparc/lib/NGmemcpy.S               |  3 +--
> >  arch/sparc/mm/init_64.c                 |  7 ++++---
> >  8 files changed, 8 insertions(+), 48 deletions(-)
> 
> I think you somehow missed the Kconfig change, and also the related
> sparc32 change which continue to have set_fs() after this patch.
I now notice the sparc32 bits are in the last patch.
To avoid breaking bisect-ability on sparc64 I think you need to merge
the sparc32 changes with this patch, unless the sparc64 changes can
coexist with CONFIG_SET_FS continue to be set.

	Sam
