Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91676D2EC3
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDAGnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Apr 2023 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDAGnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 02:43:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBB7E192;
        Fri, 31 Mar 2023 23:43:38 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.241])
        by gateway (Coremail) with SMTP id _____8Axu5eZ0idkVy4VAA--.32734S3;
        Sat, 01 Apr 2023 14:43:37 +0800 (CST)
Received: from [192.168.100.131] (unknown [112.20.109.241])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxwOSS0idk2aoSAA--.51534S3;
        Sat, 01 Apr 2023 14:43:30 +0800 (CST)
Message-ID: <17ecd97e-a750-55ca-a067-986890a8d494@loongson.cn>
Date:   Sat, 1 Apr 2023 14:43:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] docs: move parisc documentation under
 Documentation/arch/
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Alex Shi <alexs@kernel.org>
References: <20230330195604.269346-1-corbet@lwn.net>
 <20230330195604.269346-4-corbet@lwn.net>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230330195604.269346-4-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxwOSS0idk2aoSAA--.51534S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3WrWUuF1kWw1xJF1kXrWkJFb_yoWxXF1xp3
        Z7Kr1Ig3WSvryUC348WF17GFy7Ca4xua13WF4Utw10qFn8W39Yyr4UK3s0gFn3XrW0yFWk
        uF4fKrW5uw1qywUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 3/31/23 03:56, Jonathan Corbet 写道:
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.  Move
> Documentation/parisc into arch/ and fix all in-tree references.
>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   Documentation/arch/index.rst                                    | 2 +-
>   Documentation/{ => arch}/parisc/debugging.rst                   | 0
>   Documentation/{ => arch}/parisc/features.rst                    | 0
>   Documentation/{ => arch}/parisc/index.rst                       | 0
>   Documentation/{ => arch}/parisc/registers.rst                   | 0
>   Documentation/translations/zh_CN/arch/index.rst                 | 2 +-
>   .../translations/zh_CN/{ => arch}/parisc/debugging.rst          | 2 +-
>   Documentation/translations/zh_CN/{ => arch}/parisc/index.rst    | 2 +-
>   .../translations/zh_CN/{ => arch}/parisc/registers.rst          | 2 +-
>   MAINTAINERS                                                     | 2 +-
>   10 files changed, 6 insertions(+), 6 deletions(-)
>   rename Documentation/{ => arch}/parisc/debugging.rst (100%)
>   rename Documentation/{ => arch}/parisc/features.rst (100%)
>   rename Documentation/{ => arch}/parisc/index.rst (100%)
>   rename Documentation/{ => arch}/parisc/registers.rst (100%)
>   rename Documentation/translations/zh_CN/{ => arch}/parisc/debugging.rst (97%)
>   rename Documentation/translations/zh_CN/{ => arch}/parisc/index.rst (88%)
>   rename Documentation/translations/zh_CN/{ => arch}/parisc/registers.rst (99%)
>
> diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
> index 77e287c3eeb9..6839cd46850d 100644
> --- a/Documentation/arch/index.rst
> +++ b/Documentation/arch/index.rst
> @@ -18,7 +18,7 @@ implementation.
>      ../mips/index
>      nios2/index
>      openrisc/index
> -   ../parisc/index
> +   parisc/index
>      ../powerpc/index
>      ../riscv/index
>      ../s390/index
> diff --git a/Documentation/parisc/debugging.rst b/Documentation/arch/parisc/debugging.rst
> similarity index 100%
> rename from Documentation/parisc/debugging.rst
> rename to Documentation/arch/parisc/debugging.rst
> diff --git a/Documentation/parisc/features.rst b/Documentation/arch/parisc/features.rst
> similarity index 100%
> rename from Documentation/parisc/features.rst
> rename to Documentation/arch/parisc/features.rst
> diff --git a/Documentation/parisc/index.rst b/Documentation/arch/parisc/index.rst
> similarity index 100%
> rename from Documentation/parisc/index.rst
> rename to Documentation/arch/parisc/index.rst
> diff --git a/Documentation/parisc/registers.rst b/Documentation/arch/parisc/registers.rst
> similarity index 100%
> rename from Documentation/parisc/registers.rst
> rename to Documentation/arch/parisc/registers.rst
> diff --git a/Documentation/translations/zh_CN/arch/index.rst b/Documentation/translations/zh_CN/arch/index.rst
> index 7e59af567331..908ea131bb1c 100644
> --- a/Documentation/translations/zh_CN/arch/index.rst
> +++ b/Documentation/translations/zh_CN/arch/index.rst
> @@ -12,7 +12,7 @@
>      ../arm64/index
>      ../riscv/index
>      openrisc/index
> -   ../parisc/index
> +   parisc/index
>      ../loongarch/index
>   
>   TODOList:
> diff --git a/Documentation/translations/zh_CN/parisc/debugging.rst b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
> similarity index 97%
> rename from Documentation/translations/zh_CN/parisc/debugging.rst
> rename to Documentation/translations/zh_CN/arch/parisc/debugging.rst
> index 68b73eb57105..9bd197eb0d41 100644
> --- a/Documentation/translations/zh_CN/parisc/debugging.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/parisc/debugging.rst
> +:Original: Documentation/arch/parisc/debugging.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/parisc/index.rst b/Documentation/translations/zh_CN/arch/parisc/index.rst
> similarity index 88%
> rename from Documentation/translations/zh_CN/parisc/index.rst
> rename to Documentation/translations/zh_CN/arch/parisc/index.rst
> index 0cc553fc8272..848742539550 100644
> --- a/Documentation/translations/zh_CN/parisc/index.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/index.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/parisc/index.rst
> +:Original: Documentation/arch/parisc/index.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/parisc/registers.rst b/Documentation/translations/zh_CN/arch/parisc/registers.rst
> similarity index 99%
> rename from Documentation/translations/zh_CN/parisc/registers.rst
> rename to Documentation/translations/zh_CN/arch/parisc/registers.rst
> index d2ab1874a602..caf5f258248b 100644
> --- a/Documentation/translations/zh_CN/parisc/registers.rst
> +++ b/Documentation/translations/zh_CN/arch/parisc/registers.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/parisc/registers.rst
> +:Original: Documentation/arch/parisc/registers.rst
>   
>   :翻译:
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c515abc269f2..02720bc91481 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15834,7 +15834,7 @@ W:	https://parisc.wiki.kernel.org
>   Q:	http://patchwork.kernel.org/project/linux-parisc/list/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jejb/parisc-2.6.git
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
> -F:	Documentation/parisc/
> +F:	Documentation/arch/parisc/
>   F:	arch/parisc/
>   F:	drivers/char/agp/parisc-agp.c
>   F:	drivers/input/misc/hp_sdc_rtc.c

