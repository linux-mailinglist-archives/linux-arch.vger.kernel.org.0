Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2598B52BF4F
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiERPcv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiERPcu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 11:32:50 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2E6F483;
        Wed, 18 May 2022 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652887964; bh=jtNi2NeVOSeOeSM5DRWYGfIc1hN3q1pdVPN90ETCm+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RoAKEdx/QcKNiph+1XEKZGmCQ4RZfWI4ZvsH5WBQAjZHNQfUAB5hWlLlwlwzz3ciS
         jrf6A3XZxVf1lTA8gKK2LFycBV7sWrjBp2jpNfLCG6ZM/1u93N4dzdpSjhcel4f/K3
         j7NqEEFaNt4AeCr8aNTFKuzoaquam0O0ok7vvTZw=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 668A860691;
        Wed, 18 May 2022 23:32:44 +0800 (CST)
Message-ID: <e02d11bd-d516-12bd-8a29-80458e8206fa@xen0n.name>
Date:   Wed, 18 May 2022 23:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 02/22] Documentation/zh_CN: Add basic LoongArch
 documentations
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Shi <alexs@kernel.org>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-3-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/22 17:25, Huacai Chen wrote:
> Add some basic documentation (zh_CN version) for LoongArch. LoongArch is
> a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch includes a
> reduced 32-bit version (LA32R), a standard 32-bit version (LA32S) and a
> 64-bit version (LA64).
>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   Documentation/translations/zh_CN/index.rst    |   1 +
>   .../translations/zh_CN/loongarch/features.rst |   8 +
>   .../translations/zh_CN/loongarch/index.rst    |  26 ++
>   .../zh_CN/loongarch/introduction.rst          | 351 ++++++++++++++++++
>   .../zh_CN/loongarch/irq-chip-model.rst        | 167 +++++++++
>   5 files changed, 553 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
>   create mode 100644 Documentation/translations/zh_CN/loongarch/irq-chip-model.rst

Most of my comments back in v10 have been addressed, and the text now 
reads much better than previously.

Reviewed-by: WANG Xuerui <git@xen0n.name>

