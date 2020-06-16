Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB21FA82A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jun 2020 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFPFYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 01:24:31 -0400
Received: from foss.arm.com ([217.140.110.172]:59462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgFPFYb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jun 2020 01:24:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934931F1;
        Mon, 15 Jun 2020 22:24:29 -0700 (PDT)
Received: from [10.163.80.105] (unknown [10.163.80.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9105F3F6CF;
        Mon, 15 Jun 2020 22:24:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/pgtable: Move extern zero_pfn outside
 __HAVE_COLOR_ZERO_PAGE
To:     linux-mm@kvack.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <ca40ed5d-62e9-dff6-ef94-0ae4069ff84b@arm.com>
Date:   Tue, 16 Jun 2020 10:54:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/16/2020 09:38 AM, Anshuman Khandual wrote:
> zero_pfn variable is required whether __HAVE_COLOR_ZERO_PAGE is enabled
> or not. Also it should not really be declared individually in all functions
> where it gets used. Just move the declaration outside, which also makes it
> available for other potential users.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Applies on 5.8-rc1. If the earlier motivation was to hide zero_pfn from
> general visibility, we could just put in a comment and update the commit
> message that my_zero_pfn() should always be used rather than zero_pfn.
> Build tested on many platforms and boot tested on arm64, x86.
> 
>  include/linux/pgtable.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 32b6c52d41b9..078e9864abca 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1020,10 +1020,11 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
>  extern void untrack_pfn_moved(struct vm_area_struct *vma);
>  #endif
>  
> +extern unsigned long zero_pfn;
> +
>  #ifdef __HAVE_COLOR_ZERO_PAGE
>  static inline int is_zero_pfn(unsigned long pfn)
>  {
> -	extern unsigned long zero_pfn;
>  	unsigned long offset_from_zero_pfn = pfn - zero_pfn;
>  	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
>  }
> @@ -1033,13 +1034,11 @@ static inline int is_zero_pfn(unsigned long pfn)
>  #else
>  static inline int is_zero_pfn(unsigned long pfn)
>  {
> -	extern unsigned long zero_pfn;
>  	return pfn == zero_pfn;
>  }
>  
>  static inline unsigned long my_zero_pfn(unsigned long addr)
>  {
> -	extern unsigned long zero_pfn;
>  	return zero_pfn;
>  }
>  #endif
> 

The CC list is incomplete. Adding Andrew, Mike and Kirill.

+Cc: Andrew Morton <akpm@linux-foundation.org>
+Cc: Mike Rapoport <rppt@linux.ibm.com>
+Cc: Kirill A . Shutemov <kirill.shutemov@linux.intel.com>

Will update the CC list next time around.

- Anshuman
