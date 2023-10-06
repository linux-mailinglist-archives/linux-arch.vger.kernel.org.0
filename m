Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D417BB30D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJFIZK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjJFIZE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 04:25:04 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46660112;
        Fri,  6 Oct 2023 01:24:57 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qog8g-0002lV-00; Fri, 06 Oct 2023 10:24:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CBB03C01C1; Fri,  6 Oct 2023 10:06:02 +0200 (CEST)
Date:   Fri, 6 Oct 2023 10:06:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, arnd@arndb.de,
        jiaxun.yang@flygoat.com, mpe@ellerman.id.au, geert@linux-m68k.org,
        mcgrof@kernel.org, hch@infradead.org, f.fainelli@gmail.com,
        deller@gmx.de, Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mips: io: remove duplicated codes
Message-ID: <ZR+/6lm+huWH3vuk@alpha.franken.de>
References: <20230921110424.215592-1-bhe@redhat.com>
 <20230921110424.215592-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921110424.215592-5-bhe@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 21, 2023 at 07:04:24PM +0800, Baoquan He wrote:
> By adding <asm-generic/io.h> support, the duplicated phys_to_virt
> can be removed to use the default version in <asm-gneneric/io.h>.
> 
> Meanwhile move isa_bus_to_virt() down below <asm-generic/io.h> including
> to fix the compiling error of missing phys_to_virt definition.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
