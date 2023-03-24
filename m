Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FC6C752C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 02:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCXBnp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 21:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 21:43:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71295CC27;
        Thu, 23 Mar 2023 18:43:41 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.241])
        by gateway (Coremail) with SMTP id _____8Axkk5LAB1kRI4QAA--.25172S3;
        Fri, 24 Mar 2023 09:43:39 +0800 (CST)
Received: from [192.168.100.131] (unknown [112.20.109.241])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxprxGAB1kCM8KAA--.2585S3;
        Fri, 24 Mar 2023 09:43:35 +0800 (CST)
Message-ID: <271b00b7-fa10-fc2c-3929-c533a41bb22a@loongson.cn>
Date:   Fri, 24 Mar 2023 09:43:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] docs: move openrisc documentation under
 Documentation/arch/
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Alex Shi <alexs@kernel.org>
References: <20230323221948.352154-1-corbet@lwn.net>
 <20230323221948.352154-6-corbet@lwn.net>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230323221948.352154-6-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxprxGAB1kCM8KAA--.2585S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WrWUuF13ZFyrKF45JFW7XFb_yoWxAr18pa
        yvka4Ig3W3Zr1DK348KF17Kry7CF1xGa13Gas7X34vqFn0qw4jvr43t3s8KFn7JrW0vayk
        uFsagFy5tr12ywUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU2NB_UUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 3/24/23 06:19, Jonathan Corbet 写道:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/openrisc into arch/ and fix all in-tree references.
>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   Documentation/arch/index.rst                                  | 2 +-
>   Documentation/{ => arch}/openrisc/features.rst                | 0
>   Documentation/{ => arch}/openrisc/index.rst                   | 0
>   Documentation/{ => arch}/openrisc/openrisc_port.rst           | 0
>   Documentation/{ => arch}/openrisc/todo.rst                    | 0
>   Documentation/translations/zh_CN/arch/index.rst               | 2 +-
>   .../translations/zh_CN/{ => arch}/openrisc/index.rst          | 4 ++--
>   .../translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst  | 4 ++--
>   Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst | 4 ++--
>   MAINTAINERS                                                   | 2 +-
>   10 files changed, 9 insertions(+), 9 deletions(-)
>   rename Documentation/{ => arch}/openrisc/features.rst (100%)
>   rename Documentation/{ => arch}/openrisc/index.rst (100%)
>   rename Documentation/{ => arch}/openrisc/openrisc_port.rst (100%)
>   rename Documentation/{ => arch}/openrisc/todo.rst (100%)
>   rename Documentation/translations/zh_CN/{ => arch}/openrisc/index.rst (79%)
>   rename Documentation/translations/zh_CN/{ => arch}/openrisc/openrisc_port.rst (97%)
>   rename Documentation/translations/zh_CN/{ => arch}/openrisc/todo.rst (88%)
>
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 792f58e30f25..65945daa40fe 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -17,7 +17,7 @@ implementation.
>      ../m68k/index
>      ../mips/index
>      ../nios2/index
> -   ../openrisc/index
> +   openrisc/index
>      ../parisc/index
>      ../powerpc/index
>      ../riscv/index
> diff --git a/Documentation/openrisc/features.rst b/Documentation/arch/openrisc/features.rst
> similarity index 100%
> rename from Documentation/openrisc/features.rst
> rename to Documentation/arch/openrisc/features.rst
> diff --git a/Documentation/openrisc/index.rst b/Documentation/arch/openrisc/index.rst
> similarity index 100%
> rename from Documentation/openrisc/index.rst
> rename to Documentation/arch/openrisc/index.rst
> diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
> similarity index 100%
> rename from Documentation/openrisc/openrisc_port.rst
> rename to Documentation/arch/openrisc/openrisc_port.rst
> diff --git a/Documentation/openrisc/todo.rst b/Documentation/arch/openrisc/todo.rst
> similarity index 100%
> rename from Documentation/openrisc/todo.rst
> rename to Documentation/arch/openrisc/todo.rst
> diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
> index aa53dcff268e..7e59af567331 100644
> --- a/Documentation/translations/zh_CN/arch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -11,7 +11,7 @@
>      ../mips/index
>      ../arm64/index
>      ../riscv/index
> -   ../openrisc/index
> +   openrisc/index
>      ../parisc/index
>      ../loongarch/index
>   
> diff --git a/Documentation/translations/zh_CN/openrisc/index.rst b/Documentation/translations/zh_CN/arch/openrisc/index.rst
> similarity index 79%
> rename from Documentation/translations/zh_CN/openrisc/index.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/index.rst
> index 9ad6cc600884..da21f8ab894b 100644
> --- a/Documentation/translations/zh_CN/openrisc/index.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/index.rst
> @@ -1,8 +1,8 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/openrisc/index.rst
> +:Original: Documentation/arch/openrisc/index.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> similarity index 97%
> rename from Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> index b8a67670492d..cadc580fa23b 100644
> --- a/Documentation/translations/zh_CN/openrisc/openrisc_port.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
> @@ -1,6 +1,6 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/openrisc/openrisc_port.rst
> +:Original: Documentation/arch/openrisc/openrisc_port.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/openrisc/todo.rst b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
> similarity index 88%
> rename from Documentation/translations/zh_CN/openrisc/todo.rst
> rename to Documentation/translations/zh_CN/arch/openrisc/todo.rst
> index 63c38717edb1..1f6f95616633 100644
> --- a/Documentation/translations/zh_CN/openrisc/todo.rst
> +++ b/Documentation/translations/zh_CN/arch/openrisc/todo.rst
> @@ -1,6 +1,6 @@
> -.. include:: ../disclaimer-zh_CN.rst
> +.. include:: ../../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/openrisc/todo.rst
> +:Original: Documentation/arch/openrisc/todo.rst
>   
>   :翻译:
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf4eb913ea12..64ea94536f4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15638,7 +15638,7 @@ S:	Maintained
>   W:	http://openrisc.io
>   T:	git https://github.com/openrisc/linux.git
>   F:	Documentation/devicetree/bindings/openrisc/
> -F:	Documentation/openrisc/
> +F:	Documentation/arch/openrisc/
>   F:	arch/openrisc/
>   F:	drivers/irqchip/irq-ompic.c
>   F:	drivers/irqchip/irq-or1k-*

