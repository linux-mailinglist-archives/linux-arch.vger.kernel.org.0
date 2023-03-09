Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BE6B270E
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCIOhN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 09:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjCIOgt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 09:36:49 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB4FAF4D9E;
        Thu,  9 Mar 2023 06:36:43 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1paHNg-000885-00; Thu, 09 Mar 2023 15:36:32 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6CA12C123A; Thu,  9 Mar 2023 15:36:21 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:36:21 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <20230309143621.GA12350@alpha.franken.de>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308130710.368085-4-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 08, 2023 at 09:07:09PM +0800, Baoquan He wrote:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior. So remove the ioremap_uc() definition in architecutures
> other than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
> 
> This changes the existing behaviour, while no need to worry about
> any breakage because in the only callsite of ioremap_uc(), code
> has been adjusted to eliminate the impact. Please see
> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
> 
> If any new invocation of ioremap_uc() need be added, please consider
> using ioremap() intead or adding a ARCH specific version if necessary.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  Documentation/driver-api/device-io.rst | 9 +++++----
>  arch/alpha/include/asm/io.h            | 1 -
>  arch/hexagon/include/asm/io.h          | 3 ---
>  arch/m68k/include/asm/kmap.h           | 1 -
>  arch/mips/include/asm/io.h             | 1 -
>  arch/parisc/include/asm/io.h           | 2 --
>  arch/powerpc/include/asm/io.h          | 1 -
>  arch/sh/include/asm/io.h               | 2 --
>  arch/sparc/include/asm/io_64.h         | 1 -
>  9 files changed, 5 insertions(+), 16 deletions(-)

this doesn't apply to v6.3-rc1... what tree is this based on ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
