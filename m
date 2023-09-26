Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3777AEFA4
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjIZP1S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjIZP1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 11:27:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC0124;
        Tue, 26 Sep 2023 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1695741991; bh=QsqRgvKUnL6W0NEHrtVeuczEAWjiUjF19Ug8WTjaTXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dkRllyLpdnpiqce7rLwaswg120DWfCzh/EDuHTOHdQSkNDgloICRzpypSge7K6Ljr
         B7rDry8mGd/OtmEqvoCiZoUL4HjortUwuXJAqnQIF94l8jqQjqXSpN3ytFfZhojO6v
         IWn5Nem208jOWslFl47iaXp7DvBBnc/q8VJr1YsA=
Received: from [IPV6:240e:388:8d29:7200:439e:6305:2d94:4764] (unknown [IPv6:240e:388:8d29:7200:439e:6305:2d94:4764])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5A225600B5;
        Tue, 26 Sep 2023 23:26:31 +0800 (CST)
Message-ID: <4abf8ddb-ff93-436f-a834-39e7f4d7a503@xen0n.name>
Date:   Tue, 26 Sep 2023 23:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: numa: Fix high_memory calculation
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org, Chong Qiao <qiaochong@loongson.cn>
References: <20230926121031.1901760-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230926121031.1901760-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/26/23 20:10, Huacai Chen wrote:
> high_memory is the virtual address of the 'highest physical address' in
> the system. But __va(get_num_physpages() << PAGE_SHIFT) is not what we
> want because there may be holes in the physical address space. On the
> other hand, max_low_pfn is calculated from memblock_end_of_DRAM(), which
> is exactly corresponding to the highest physical address, so use it for
> high_memory calculation.
>
> Cc: <stable@vger.kernel.org>
Which commit is this patch intended to amend? A "Fixes:" tag may be 
helpful for stable backporting.
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/kernel/numa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index c7d33c489e04..6e65ff12d5c7 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -436,7 +436,7 @@ void __init paging_init(void)
>   
>   void __init mem_init(void)
>   {
> -	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
> +	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
>   	memblock_free_all();
>   }
>   

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

