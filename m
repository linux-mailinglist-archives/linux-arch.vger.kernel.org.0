Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531AC21D8D9
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgGMOo2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 10:44:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9541 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMOo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 10:44:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c72dc0000>; Mon, 13 Jul 2020 07:42:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:44:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 07:44:28 -0700
Received: from [10.26.72.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:44:18 +0000
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
 <4040f429-21c8-0825-2ad4-97786c3fe7c1@nvidia.com>
 <cee60718-ced2-069f-8dad-48941c6fc09b@huawei.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7237888d-2168-cd8b-c83d-c8e54871793d@nvidia.com>
Date:   Mon, 13 Jul 2020 15:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cee60718-ced2-069f-8dad-48941c6fc09b@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594651356; bh=GMqdGNMQAH4AHg5hTa7waqJrHwyKyA4TXJmzHNKG13w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X0D1DS8Q43SgE5F9IDdU432zVIipKfOXH09pQUdZ9nwA/5YJw5NgTcaeOTeDp1MbU
         ZtFrObX3/F6AItK2Kaz/Jdj5ln5HbEbuqjOpJwaB97qoVpRmi4eRHG0RAgY/w+qBO6
         O83/VWEQOAHYks9bxeUkSDB0FMoXhXsn4MX9rmJ2TcqXT1xdefUZgAVlGNDLe2vAMI
         LHblN/7vNqKTDmUaPDmThJlWenrobGwK1npattjHleKBjjVrwIU8LIRTbCPFjgveeQ
         ljgVMQFJWxJBsbLsK8mvDDjQE2jrZ6uET1MeXoy3Vy2Y3ZM78D81s9qTAwEGsOEGbC
         E7AzNNZBDWqDw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 13/07/2020 15:39, Zhenyu Ye wrote:
> Hi Jon,
> 
> On 2020/7/13 22:27, Jon Hunter wrote:
>> After this change I am seeing the following build errors ...
>>
>> /tmp/cckzq3FT.s: Assembler messages:
>> /tmp/cckzq3FT.s:854: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:870: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1095: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1111: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1964: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:1980: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:2286: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:2302: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x7'
>> /tmp/cckzq3FT.s:4833: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:4849: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:5090: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:5106: Error: unknown or missing operation name at operand 1 -- `tlbi rvae1is,x6'
>> /tmp/cckzq3FT.s:874: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:1115: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:1984: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:2306: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:4853: Error: attempt to move .org backwards
>> /tmp/cckzq3FT.s:5110: Error: attempt to move .org backwards
>> scripts/Makefile.build:280: recipe for target 'arch/arm64/mm/hugetlbpage.o' failed
>> make[3]: *** [arch/arm64/mm/hugetlbpage.o] Error 1
>> scripts/Makefile.build:497: recipe for target 'arch/arm64/mm' failed
>> make[2]: *** [arch/arm64/mm] Error 2
>>
>> Cheers
>> Jon
>>
> 
> The code must be built with binutils >= 2.30.
> Maybe I should add  a check on whether binutils supports ARMv8.4-a instructions...

Yes I believe so.

Cheers
Jon

-- 
nvpublic
