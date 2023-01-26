Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732ED67C280
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 02:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAZBpR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 20:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAZBpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 20:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877E4B1B2;
        Wed, 25 Jan 2023 17:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B0D6172A;
        Thu, 26 Jan 2023 01:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32671C433D2;
        Thu, 26 Jan 2023 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674697514;
        bh=7RpoJrPZS6SJcilZwJlgfOcy8VI5bDbkm1rwJIiWgGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QrUq5ATjY2oqR+jEAeForg1RvYMYo+bDZxJkpPvGEAQMtF9Wex3AsF6pj45qmjarD
         FkXgKw35BmzCytgE7GIRGvCG25LoCH1q8w/sqjuafA+hP0s/EWoOXsqZwbktTsZyRq
         n3OCsv9RwqATlbboWAh4Ya/cfUooerJ2jtkrgbTo=
Date:   Wed, 25 Jan 2023 17:45:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux--csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid()
 for FLATMEM
Message-Id: <20230125174512.ce5aed444cc8b8870825d8c2@linux-foundation.org>
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
References: <20230125190757.22555-1-rppt@kernel.org>
        <20230125190757.22555-4-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 25 Jan 2023 21:07:57 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions

arm allnoconfig:

./include/asm-generic/memory_model.h:23:19: error: static declaration of 'pfn_valid' follows non-static declaration
   23 | static inline int pfn_valid(unsigned long pfn)
      |                   ^~~~~~~~~
./arch/arm/include/asm/page.h:160:12: note: previous declaration of 'pfn_valid' with type 'int(long unsigned int)'
  160 | extern int pfn_valid(unsigned long);
      |            ^~~~~~~~~


I thought of doing

--- a/arch/arm/include/asm/page.h~mm-arch-add-generic-implementation-of-pfn_valid-for-flatmem-fix
+++ a/arch/arm/include/asm/page.h
@@ -156,10 +156,6 @@ extern void copy_page(void *to, const vo
 
 typedef struct page *pgtable_t;
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
-extern int pfn_valid(unsigned long);
-#endif
-
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
_

but I'm seeing a pfn_valid declaration in arch/arc/include/asm/page.h
which might be a problem.

v2, please ;)
