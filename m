Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CC7BB30E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjJFIZL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjJFIZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 04:25:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E4E10F;
        Fri,  6 Oct 2023 01:24:57 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qog8g-0002lR-00; Fri, 06 Oct 2023 10:24:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8F72FC0148; Fri,  6 Oct 2023 10:05:28 +0200 (CEST)
Date:   Fri, 6 Oct 2023 10:05:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, arnd@arndb.de,
        jiaxun.yang@flygoat.com, mpe@ellerman.id.au, geert@linux-m68k.org,
        mcgrof@kernel.org, hch@infradead.org, f.fainelli@gmail.com,
        deller@gmx.de, Huacai Chen <chenhuacai@kernel.org>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mips: add <asm-generic/io.h> including
Message-ID: <ZR+/yGbLoNYgdi/r@alpha.franken.de>
References: <20230921110424.215592-1-bhe@redhat.com>
 <20230921110424.215592-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921110424.215592-3-bhe@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 21, 2023 at 07:04:22PM +0800, Baoquan He wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
> 
> We also massaged various headers to avoid nested includes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h      | 96 +++++++++++++++++++++++----------
>  arch/mips/include/asm/mmiowb.h  |  4 +-
>  arch/mips/include/asm/smp-ops.h |  2 -
>  arch/mips/include/asm/smp.h     |  4 +-
>  arch/mips/kernel/setup.c        |  1 +
>  arch/mips/pci/pci-ip27.c        |  3 ++
>  6 files changed, 75 insertions(+), 35 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
