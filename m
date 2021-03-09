Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D8331FF4
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 08:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCIHgh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 02:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCIHgU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 02:36:20 -0500
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39BC061763
        for <linux-arch@vger.kernel.org>; Mon,  8 Mar 2021 23:36:19 -0800 (PST)
Received: (qmail 20754 invoked from network); 9 Mar 2021 07:35:49 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:45468 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.37dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <david@redhat.com>; Tue, 09 Mar 2021 08:35:49 +0100
MIME-Version: 1.0
Date:   Tue, 09 Mar 2021 08:35:44 +0100
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFCv2] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to
 prefault/prealloc memory
In-Reply-To: <20210308164520.18323-1-david@redhat.com>
References: <20210308164520.18323-1-david@redhat.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6ecd754406fffe851be6543025203b6b@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> diff --git a/mm/internal.h b/mm/internal.h
> index 9902648f2206..a5c4ed23b1db 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -340,6 +340,9 @@ void __vma_unlink_list(struct mm_struct *mm,
> struct vm_area_struct *vma);
>  #ifdef CONFIG_MMU
>  extern long populate_vma_page_range(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, int *nonblocking);
> +extern long faultin_vma_page_range(struct vm_area_struct *vma,
> +				   unsigned long start, unsigned long end,
> +				   bool write, int *nonblocking);
>  extern void munlock_vma_pages_range(struct vm_area_struct *vma,
>  			unsigned long start, unsigned long end);
>  static inline void munlock_vma_pages_all(struct vm_area_struct *vma)

The parameter name does not match the one in the implementation.

Otherwise the implementation looks fine AFAICT.

Eike
