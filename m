Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795A6C994C
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 03:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjC0BTS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 21:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC0BTR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 21:19:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91C6E4EFD;
        Sun, 26 Mar 2023 18:19:14 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.241])
        by gateway (Coremail) with SMTP id _____8DxEzQQ7yBkgQMSAA--.27501S3;
        Mon, 27 Mar 2023 09:19:12 +0800 (CST)
Received: from [192.168.100.131] (unknown [112.20.109.241])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx97wO7yBk7K4NAA--.6575S3;
        Mon, 27 Mar 2023 09:19:11 +0800 (CST)
Message-ID: <92ec8165-90c4-366f-94de-d7ab731b4058@loongson.cn>
Date:   Mon, 27 Mar 2023 09:19:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] docs: zh_CN: create the architecture-specific
 top-level directory
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alex Shi <alexs@kernel.org>
References: <20230323221948.352154-1-corbet@lwn.net>
 <20230323221948.352154-2-corbet@lwn.net>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230323221948.352154-2-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx97wO7yBk7K4NAA--.6575S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZrykWFW5Zr17Cw15ArWrXwb_yoW8Cr1DpF
        y0kr93K3WfZr1UC34IgF1UGryUGa1xCa17WFWYqw1Fqrn8ZF4ktFn8tryDKF97trWfZFZ7
        Xa1FgFWUuryjkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 3/24/23 06:19, Jonathan Corbet 写道:
> This mirrors commit 4f1bb0386dfc ("docs: create a top-level arch/
> directory"), creating a top-level directory to hold architecture-specific
> documentation.
>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng
> ---
>   .../translations/zh_CN/{arch.rst => arch/index.rst}  | 12 ++++++------
>   Documentation/translations/zh_CN/index.rst           |  2 +-
>   2 files changed, 7 insertions(+), 7 deletions(-)
>   rename Documentation/translations/zh_CN/{arch.rst => arch/index.rst} (72%)
>
> diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/translations/zh_CN/arch/index.rst
> similarity index 72%
> rename from Documentation/translations/zh_CN/arch.rst
> rename to Documentation/translations/zh_CN/arch/index.rst
> index 690e173d8b2a..aa53dcff268e 100644
> --- a/Documentation/translations/zh_CN/arch.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -8,12 +8,12 @@
>   .. toctree::
>      :maxdepth: 2
>   
> -   mips/index
> -   arm64/index
> -   riscv/index
> -   openrisc/index
> -   parisc/index
> -   loongarch/index
> +   ../mips/index
> +   ../arm64/index
> +   ../riscv/index
> +   ../openrisc/index
> +   ../parisc/index
> +   ../loongarch/index
>   
>   TODOList:
>   
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 7c3216845b71..299704c0818d 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -120,7 +120,7 @@ TODOList:
>   .. toctree::
>      :maxdepth: 2
>   
> -   arch
> +   arch/index
>   
>   其他文档
>   --------

