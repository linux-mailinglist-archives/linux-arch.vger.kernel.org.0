Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05DC52BF12
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiERPyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiERPyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 11:54:10 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11011CC98B;
        Wed, 18 May 2022 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652889244; bh=hMCggXS20k24Moq7wq290Pu/SOhpPn396QOC64WwdqI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SxZy8PzQ4+GMVnv56cYEsr8OB28rSz1WUAyequjrtQxAxAS6S2JnqeJ3DjfEjgtVm
         LbAUe5iS3Z521gk53GogRUthr83+fJdQTXzPHiGy9XlK5wv5f7KUfmZo4P0iKma3in
         OCN6PtCsAhh3SVmDN3a2MF0wFbpLCZS8HG5d/U+c=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5709F60691;
        Wed, 18 May 2022 23:54:04 +0800 (CST)
Message-ID: <9b9df6a3-099f-4368-207f-5fe330e7f166@xen0n.name>
Date:   Wed, 18 May 2022 23:54:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 07/22] LoongArch: Add atomic/locking headers
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
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-8-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-8-chenhuacai@loongson.cn>
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

On 5/18/22 17:26, Huacai Chen wrote:
> Add common headers (atomic, bitops, barrier and locking) for basic
> LoongArch support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/atomic.h  | 358 +++++++++++++++++++++++++++
>   arch/loongarch/include/asm/barrier.h |  51 ++++
>   arch/loongarch/include/asm/bitops.h  |  33 +++
>   arch/loongarch/include/asm/bitrev.h  |  34 +++
>   arch/loongarch/include/asm/cmpxchg.h | 121 +++++++++
>   arch/loongarch/include/asm/local.h   | 138 +++++++++++
>   arch/loongarch/include/asm/percpu.h  |  20 ++
>   7 files changed, 755 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/atomic.h
>   create mode 100644 arch/loongarch/include/asm/barrier.h
>   create mode 100644 arch/loongarch/include/asm/bitops.h
>   create mode 100644 arch/loongarch/include/asm/bitrev.h
>   create mode 100644 arch/loongarch/include/asm/cmpxchg.h
>   create mode 100644 arch/loongarch/include/asm/local.h
>   create mode 100644 arch/loongarch/include/asm/percpu.h

No major problems here so:

Reviewed-by: WANG Xuerui <git@xen0n.name>

