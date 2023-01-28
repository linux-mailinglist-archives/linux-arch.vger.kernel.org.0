Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57C67F68A
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jan 2023 10:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjA1JCU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Jan 2023 04:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjA1JCT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Jan 2023 04:02:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EA6DFCF;
        Sat, 28 Jan 2023 01:02:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso47524wms.5;
        Sat, 28 Jan 2023 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7ARCz3cVaBFOjYkC77qL/HBEniL1qdQHS5E6K6GFOY=;
        b=aqbRojTHRCVjzGUAj7OwNNFidQtZRaRDHHmAjBWeAFhAl4EP6lU/HQ+DT3lz3ORLRs
         krDbFNMyaAoPDNNbr2Us4LfdqxvtQoKw/VqPFwWdtmeZaX2Yr/xMNSAvUp0bHiLiSOj3
         SN1iYBMZrJW6Tuoe05d5ixjoXDQyxOx+hHgkYRdk2YredIT5D868vyI7+JtGnCIwsINP
         AC8gyFLqm6XouHJKilNfBj6iNxK7cGu1Nhc9VlLOm0nqQCpyycdmijDtgityKjfCFibc
         kBECjMNCFbqcxj8dsEQrghcf75B90yP81hRDkvCSROQeKfuHc3hus0w8nNDlJyMcHou/
         rQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7ARCz3cVaBFOjYkC77qL/HBEniL1qdQHS5E6K6GFOY=;
        b=K/g0NVKqOEQIrhvafWdRvrjURipII3R7wZsomoncfvYxOaVsjxBB4GDtgjn1rX1MtO
         KnY0l5JrvoLJvI7FX5LmggUrjXSISAK7DhqusGl6ORvy1tgnHzaBtrzy/+5DLIG3uF8P
         lef2XfYvHcPw/UhMCNXBZF/FmVKfSZujzuKe+DvSSWACEhbvMhK9klK7GEp0ph2XKBUP
         FSRIeXTua9Fs6dy+8P49dTlLlb3I+Hlxpk5CylXLBf14ePJ7EAXAfsx3dOTsbkqT13W6
         135KB/lW487LBZjy5pAqw4JyLZ1S2JICUGNRKrM2DbK6tzk5uKReWuLp3qwHAX0Xuqwz
         L8mg==
X-Gm-Message-State: AFqh2koU+Pl3pQgtBSHxJ3WksDASjXOPbguqlLD3Odb34RoxJ7wn82bA
        xeVo3OD529xv6CQsEwfTAho=
X-Google-Smtp-Source: AMrXdXshtli+OqZ9VwFCdRpOAvHTMs/09zG9TMwa0gaZMZJ8uG1JiJOtVlF/BhmQxoXBbhlR7WJAkg==
X-Received: by 2002:a05:600c:5116:b0:3db:1a8:c041 with SMTP id o22-20020a05600c511600b003db01a8c041mr42453030wms.17.1674896535134;
        Sat, 28 Jan 2023 01:02:15 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm6212824wrd.39.2023.01.28.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 01:02:14 -0800 (PST)
Date:   Sat, 28 Jan 2023 18:02:13 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
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
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid()
 for FLATMEM
Message-ID: <Y9TklS4v8oHCvCu2@antec>
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023 at 09:07:57PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/page.h      |  4 ----
>  arch/arc/include/asm/page.h        |  1 -
>  arch/csky/include/asm/page.h       |  1 -
>  arch/hexagon/include/asm/page.h    |  1 -
>  arch/ia64/include/asm/page.h       |  4 ----
>  arch/loongarch/include/asm/page.h  | 13 -------------
>  arch/m68k/include/asm/page_no.h    |  2 --
>  arch/microblaze/include/asm/page.h |  1 -
>  arch/mips/include/asm/page.h       | 13 -------------
>  arch/nios2/include/asm/page.h      |  9 ---------
>  arch/openrisc/include/asm/page.h   |  2 --
>  arch/parisc/include/asm/page.h     |  4 ----
>  arch/powerpc/include/asm/page.h    |  9 ---------
>  arch/riscv/include/asm/page.h      |  5 -----
>  arch/sh/include/asm/page.h         |  3 ---
>  arch/sparc/include/asm/page_32.h   |  1 -
>  arch/um/include/asm/page.h         |  1 -
>  arch/x86/include/asm/page_32.h     |  4 ----
>  arch/x86/include/asm/page_64.h     |  4 ----
>  arch/xtensa/include/asm/page.h     |  2 --
>  include/asm-generic/memory_model.h | 12 ++++++++++++
>  include/asm-generic/page.h         |  2 --
>  22 files changed, 12 insertions(+), 86 deletions(-)
> 
[...] 
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index aab6e64d6db4..52b0d7e76446 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -80,8 +80,6 @@ typedef struct page *pgtable_t;
>  
>  #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
>  
> -#define pfn_valid(pfn)          ((pfn) < max_mapnr)
> -
>  #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
>  
>  #endif /* __ASSEMBLY__ */

For OpenRISC

Acked-by: Stafford Horne <shorne@gmail.com>
