Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2F265E32
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIKKhB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 06:37:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbgIKKg7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Sep 2020 06:36:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 273E96F4DAA04124E783;
        Fri, 11 Sep 2020 18:36:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.19) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 18:36:48 +0800
Subject: Re: [PATCH v7 05/12] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20200825145753.529284-1-npiggin@gmail.com>
 <20200825145753.529284-6-npiggin@gmail.com>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <534a0d5e-3a6f-c8e5-38f9-7e24662acb31@huawei.com>
Date:   Fri, 11 Sep 2020 18:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200825145753.529284-6-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.19]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/8/25 22:57, Nicholas Piggin wrote:
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot);
>  {
>  	/*
>  	 * Only 4k granule supports level 1 block mappings.
> @@ -1319,9 +1319,9 @@ int __init arch_ioremap_pud_supported(void)
>  	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>  }

There is a compilation error because of the redundant semicolon at arch_vmap_pud_supported().

