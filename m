Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0930BD5C
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhBBLr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:47:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12065 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBBLr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:47:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVNKq0sXyzMSry;
        Tue,  2 Feb 2021 19:45:35 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 19:47:04 +0800
Subject: Re: [PATCH v12 01/14] ARM: mm: add missing pud_page define to 2-level
 page tables
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210202110515.3575274-1-npiggin@gmail.com>
 <20210202110515.3575274-2-npiggin@gmail.com>
 <20210202111319.GL1463@shell.armlinux.org.uk>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <d1f661f2-f473-1dd8-94cc-fe76714249b5@huawei.com>
Date:   Tue, 2 Feb 2021 19:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20210202111319.GL1463@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021/2/2 19:13, Russell King - ARM Linux admin wrote:
> On Tue, Feb 02, 2021 at 09:05:02PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>> index c02f24400369..d63a5bb6bd0c 100644
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
>>  
>>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>>  
>> +#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
>> +#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
> 
> As there is no PUD, does it really make sense to return a valid
> struct page (which will be the PTE page) for pud_page(), which is
> several tables above?
> 
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h

+static inline int pud_none(pud_t pud)
+{
+          return 0;
+}

I think it could be fix like this.

Ding
