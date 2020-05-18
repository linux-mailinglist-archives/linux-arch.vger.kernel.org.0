Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67D1D78A1
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERM3u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 08:29:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbgERM3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 08:29:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DD1DE0E47021E1364E8;
        Mon, 18 May 2020 20:29:49 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 18 May 2020
 20:29:41 +0800
Subject: Re: [RFC PATCH v3 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE
 feature
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiangyou@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <prime.zeng@hisilicon.com>,
        <kuhn.chenqun@huawei.com>, <linux-arm-kernel@lists.infradead.org>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-2-yezhenyu2@huawei.com>
 <20200505101405.GB82424@C02TD0UTHF1T.local>
 <cb9d32b6-a9d8-3737-e69d-df4191b7afa9@huawei.com>
 <4d8cb48c-4f47-d966-f29b-3343bd966c5f@arm.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <9189159f-0df8-ef9a-5216-adc030856439@huawei.com>
Date:   Mon, 18 May 2020 20:29:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4d8cb48c-4f47-d966-f29b-3343bd966c5f@arm.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On 2020/5/18 12:22, Anshuman Khandual wrote:
>>>>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>>>>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>>>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLBI_RANGE_SHIFT, 4, 0),
> 
> Hello Zhenyu,
> 
> This is already being added through another patch [1] in a series [2] which primarily
> has cpufeature changes. I will soon update the series making this feature FTR_HIDDEN.
> 
> [1] https://patchwork.kernel.org/patch/11523881/
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=281211
> 
> I am planning to respin the series (V4) based on arm64 tree (for-next/cpufeature). So
> could you please rebase this patch (probably dropping cpufeature related changes) on
> upcoming V4, so that all the changes will be based on arm64 tree (for-next/cpufeature).
> 
> - Anshuman
> 

OK, I will rebase my patch based on your V4.

Zhenyu

