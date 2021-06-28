Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31AE3B5921
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhF1GcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 02:32:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12082 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1GcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 02:32:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GCyLR1SLNzZkht;
        Mon, 28 Jun 2021 14:26:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 14:29:43 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 14:29:43 +0800
Subject: Re: [PATCH 9/9] dma-debug: Use memory_intersects() directly
To:     Christoph Hellwig <hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-10-wangkefeng.wang@huawei.com>
 <20210628061123.GA23316@lst.de>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <bfdf4359-d98d-a675-b6d9-56280200ea81@huawei.com>
Date:   Mon, 28 Jun 2021 14:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210628061123.GA23316@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2021/6/28 14:11, Christoph Hellwig wrote:
> You've sent me a patch 9 out of 9 without the previous 8 patches.  There
> is no way I can sensibly review this series.

The full patches is 
https://lore.kernel.org/linux-arch/20210626073439.150586-1-wangkefeng.wang@huawei.com/T/#t

This patch is not very relevant about the above 8 patches, only use the 
existing function to simplify code.

