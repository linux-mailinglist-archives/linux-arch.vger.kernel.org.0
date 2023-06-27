Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E7D73F409
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 07:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjF0Frx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 01:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0Frw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 01:47:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F62199A;
        Mon, 26 Jun 2023 22:47:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55ae2075990so878589a12.0;
        Mon, 26 Jun 2023 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687844871; x=1690436871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjTPMlxWt9nC/sXrGsrew1h8LID7KP4FRrxfXfknacs=;
        b=CKCXCuWl0gYpQ4q8YGqBYIHt4kiR1AhHpEiDPYQrq6u+C1EcCN199Rf+TEI2yZgN+R
         yHF4vksLQaZZNCW1AKLUCeBUhO/zz1T+Q9/6Dn0kQ15ZW6K5TqPmtUB9rSpHUKgxZgiA
         HSTUVKDZ4xM6L9+zGQEVzY8EH5rZJBCsvXHjcbbzvbKrE2StJxwwReSDEN5b3GfPvLfH
         eqtt0xPcEOboGwjNakJZJtyOpw0n8CltvqJLvaWUUnjMuBH5yNe38AlJDiG6mzZTOhDy
         hB/teSyin+eBzVwUgFatWumtP7LykGuBvZNNj+IJUNFfPVWNZBZUcFVQKEBMH4tHKOww
         HTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844871; x=1690436871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjTPMlxWt9nC/sXrGsrew1h8LID7KP4FRrxfXfknacs=;
        b=GYVx6PWmU+/VmvNJ8sqNuHVis88KHPHnEOcYeAbmUKT9xM9Rls2xsi5t3N3jA0Qfib
         rZol5NRrr7TLoIvhypjUBHs2zgJ4u9Sw+63P+jZ+TCVNonmPnj69un6cqurgfW/NcS/4
         zipBcXQYerAxnbGgSi4EGKiXNNeZykYdXOOIxR46gPdO3X6Fe9+E3AVWn0HiYzgLYzw/
         RAVxfFgi6gAqstPvHsm5rb136eG/KkAHVIMOltLGkR+S15InXR/C26ZxaLfIdreP1MOR
         OZa/cH1NAtThikPyfUrT7vCIUSSPz0ag0fyrIh72qnYGOYdIvpTlVxcy7qU2uFDaJDzx
         Keng==
X-Gm-Message-State: AC+VfDzCEArQfB+fV3qnQDN9zOm1V5uhJuk2AriRZ28InydskPHV7JQC
        b3ZG6xhcaLKQObwYrYicvhk=
X-Google-Smtp-Source: ACHHUZ7JjW8b6fgOe+JthCsQbs9/NjABXgCew6ba8g3n2m02um8mxuD9LeyNll8XOwuywhMwRgh5kw==
X-Received: by 2002:a05:6a20:7491:b0:126:8ddd:d786 with SMTP id p17-20020a056a20749100b001268dddd786mr5575003pzd.46.1687844870738;
        Mon, 26 Jun 2023 22:47:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001b8004ff609sm3033756plb.270.2023.06.26.22.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:47:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Jun 2023 22:47:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Message-ID: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622205745.79707-27-vishal.moola@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

This patch causes all nios2 builds to fail.

Building nios2:allnoconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from mm/memory.c:85:
mm/memory.c: In function 'free_pte_range':
arch/nios2/include/asm/pgalloc.h:33:17: error: implicit declaration of function 'pagetable_pte_dtor'; did you mean 'pgtable_pte_page_dtor'? [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                 ^~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:33:36: error: implicit declaration of function 'page_ptdesc' [-Werror=implicit-function-declaration]
   33 |                 pagetable_pte_dtor(page_ptdesc(pte));                   \
      |                                    ^~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);
      |         ^~~~~~~~~~~~
arch/nios2/include/asm/pgalloc.h:34:17: error: implicit declaration of function 'tlb_remove_page_ptdesc'; did you mean 'tlb_remove_page_size'? [-Werror=implicit-function-declaration]
   34 |                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
      |                 ^~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/tlb.h:666:17: note: in expansion of macro '__pte_free_tlb'
  666 |                 __pte_free_tlb(tlb, ptep, address);             \
      |                 ^~~~~~~~~~~~~~
mm/memory.c:193:9: note: in expansion of macro 'pte_free_tlb'
  193 |         pte_free_tlb(tlb, token, addr);

> ---
>  arch/nios2/include/asm/pgalloc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index ecd1657bb2ce..ce6bb8e74271 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  
>  extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  
> -#define __pte_free_tlb(tlb, pte, addr)				\
> -	do {							\
> -		pgtable_pte_page_dtor(pte);			\
> -		tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)					\
> +	do {								\
> +		pagetable_pte_dtor(page_ptdesc(pte));			\
> +		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  	} while (0)
>  
>  #endif /* _ASM_NIOS2_PGALLOC_H */
> -- 
> 2.40.1
> 
> 
