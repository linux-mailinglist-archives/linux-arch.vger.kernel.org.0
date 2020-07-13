Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF221D873
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgGMO2E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 10:28:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18609 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgGMO2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 10:28:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6f390000>; Mon, 13 Jul 2020 07:27:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:28:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jul 2020 07:28:02 -0700
Received: from [10.26.72.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:27:52 +0000
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
To:     Zhenyu Ye <yezhenyu2@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
Date:   Mon, 13 Jul 2020 15:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710094420.517-3-yezhenyu2@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594650425; bh=HKOHpLE5QAbthKg1avx0uHfseiNDsGrp0ztSIZ7XjfM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZrupG7lsamJd5qBWDiVu5tanfnOkChiY7EMX9otXKowsejZA/Qj+d97asaCg7R8Vt
         5RjhO/9DQmvleGFJj9NOcFhX48dyvrryPU9Vte5BqWjLb5aSQxoTmLR1GtIqmlkLDm
         LKDhzoQU9vFrK6tfVqURsr+W5JueRjnxzJUCvuOhBbXWWGcLyhywRmPFH/8eXPYcyK
         8mVtpmTLCm+0YlDVaTNLb2ECKb4G26OSRplUFEnTlN5XQOgf+QGkB4Efid+rFXg9L4
         Ym9ZsQjaMzwAQ0l5XtI8BVo9dnZm024Ihb4H3cb/M7Q7RpABZEjWI+Qk0W6reqK3ys
         TY6PyGYX+IRAg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/07/2020 10:44, Zhenyu Ye wrote:
> Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().
> 
> When cpu supports TLBI feature, the minimum range granularity is
> decided by 'scale', so we can not flush all pages by one instruction
> in some cases.
> 
> For example, when the pages = 0xe81a, let's start 'scale' from
> maximum, and find right 'num' for each 'scale':
> 
> 1. scale = 3, we can flush no pages because the minimum range is
>    2^(5*3 + 1) = 0x10000.
> 2. scale = 2, the minimum range is 2^(5*2 + 1) = 0x800, we can
>    flush 0xe800 pages this time, the num = 0xe800/0x800 - 1 = 0x1c.
>    Remaining pages is 0x1a;
> 3. scale = 1, the minimum range is 2^(5*1 + 1) = 0x40, no page
>    can be flushed.
> 4. scale = 0, we flush the remaining 0x1a pages, the num =
>    0x1a/0x2 - 1 = 0xd.
> 
> However, in most scenarios, the pages = 1 when flush_tlb_range() is
> called. Start from scale = 3 or other proper value (such as scale =
> ilog2(pages)), will incur extra overhead.
> So increase 'scale' from 0 to maximum, the flush order is exactly
> opposite to the example.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>


After this change I am seeing the following build errors ...

/tmp/cckzq3FT.s: Assembler messages:
/tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
/tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
/tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
/tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
make[2]: *** [arch/arm64/mm] Error 2

Cheers
Jon

-- 
nvpublic
