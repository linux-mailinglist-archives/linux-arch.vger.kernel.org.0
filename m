Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1374E0F8
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGJWX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGJWXz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:23:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE61AC;
        Mon, 10 Jul 2023 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dPWeqUV2nbxdMmDXUdYDVmVK+WUDj06hyZkrsOP55J8=; b=p9SovpNCqjVAhA7FtfkCz964zU
        DdETtbc++pMzSjOgVYrQGbuh6s9doejhkCP0XJAt4/hYssXDPdgXS4pf1XlrgpQmyX+Nxl4iUsnYX
        ljOqVi5hXNDzqoZ0+XeTWe5WqmYsR507x78hv7EFkkCSciURwbuFt0bSWD/SWffuo3HIH3vOjUUYv
        xjT6leEEtraXUIvPSXiuYXlJhYddEJ1m0mi7dru0PkfMB61j+9aYwDyjA/VF2j5LM3DkvlxRH4L9Q
        D+h1AG8R1unBcUoQYxyj7knFiQoxkd3B3+ARjGRvcjBLmJS+N0M2ca/JyZfnOoYvnsbkbvNOf+OM/
        hemsppEg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzIM-00Cqau-2h;
        Mon, 10 Jul 2023 22:23:50 +0000
Message-ID: <ecd6b6cf-07a3-79b9-76af-dccac4295977@infradead.org>
Date:   Mon, 10 Jul 2023 15:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 03/38] mm: Add generic flush_icache_pages() and
 documentation
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-4-willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710204339.3554919-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/10/23 13:43, Matthew Wilcox (Oracle) wrote:
> -5) ``void update_mmu_cache(struct vm_area_struct *vma,
> -   unsigned long address, pte_t *ptep)``
> +5) ``void update_mmu_cache_range(struct vm_fault *vmf,
> +   struct vm_area_struct *vma, unsigned long address, pte_t *ptep,
> +   unsigned int nr)``
>  
> -	At the end of every page fault, this routine is invoked to
> -	tell the architecture specific code that a translation
> -	now exists at virtual address "address" for address space
> -	"vma->vm_mm", in the software page tables.
> +	At the end of every page fault, this routine is invoked to tell
> +	the architecture specific code that translations now exists

	                                                     exist

> +	in the software page tables for address space "vma->vm_mm"
> +	at virtual address "address" for "nr" consecutive pages.

-- 
~Randy
