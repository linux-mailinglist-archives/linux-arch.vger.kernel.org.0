Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578D2654EF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 00:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgIJWSI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 18:18:08 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2148 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWSH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 18:18:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5aa60d0000>; Thu, 10 Sep 2020 15:17:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 15:18:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Sep 2020 15:18:02 -0700
Received: from [10.2.54.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 22:17:55 +0000
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>,
        "Richard Weinberger" <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
 <20200910221116.GQ87483@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7188221f-37db-9792-4885-d2fa14ff894d@nvidia.com>
Date:   Thu, 10 Sep 2020 15:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910221116.GQ87483@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599776269; bh=iwRoz1y5O8TbYdNUszhiA+vAQr7U9YxF7ekZoQ5W1Yk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pf7Gb/6YBDTqOCEDJuZ+rf4BfPFTGAk8OcLbOb7K+v6FIaG9RzNB0J3T6fe9quopL
         Z+ZPOoYzy+CPdC8eNfwxG52K013+7dFLb6XoB+71dt5jaaUjgW3/Yd+Qa0g/akV9fA
         tQooYBDWtKesVkRQCkYEkicElTFs+3GtpIu0ue7DQtpJI1f7AfE94uKLP6KsjC8rjc
         gBnPKFdEZZjBDt9zvqWyzMyouKLws8HP3qsfGIVfi7dffxmHX6EBFD/EhSz445AfW2
         xdXCwOn/c+CRugCswXB9NnGL9VhGOiW9DFF76qT//6Pd4taPGNhkyd7b8sw4GeB8yW
         gUNk5AGewIISQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/10/20 3:11 PM, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 02:22:37PM -0700, John Hubbard wrote:
> 
>> Or am I way off here, and it really is possible (aside from the current
>> s390 situation) to observe something that "is no longer a page table"?
> 
> Yes, that is the issue. Remember there is no locking for GUP
> fast. While a page table cannot be freed there is nothing preventing
> the page table entry from being concurrently modified.
> 

OK, then we are saying the same thing after all, good.

> Without the stack variable it looks like this:
> 
>         pud_t pud = READ_ONCE(*pudp);
>         if (!pud_present(pud))
>              return
>         pmd_offset(pudp, address);
> 
> And pmd_offset() expands to
> 
>      return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> 
> Between the READ_ONCE(*pudp) and (*pud) inside pmd_offset() the value
> of *pud can change, eg to !pud_present.
> 
> Then pud_page_vaddr(*pud) will crash. It is not use after free, it
> is using data that has not been validated.
> 

Right, that matches what I had in mind, too: you can still have a problem
even though you're in the same page table. I just wanted to confirm that
there's not some odd way to launch out into completely non-page-table
memory.


thanks,
-- 
John Hubbard
NVIDIA
