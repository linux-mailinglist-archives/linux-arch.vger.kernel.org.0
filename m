Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8D530084
	for <lists+linux-arch@lfdr.de>; Sun, 22 May 2022 06:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiEVESi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 May 2022 00:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiEVESh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 May 2022 00:18:37 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79942EF9;
        Sat, 21 May 2022 21:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1653193110; bh=gg8YddmRkOsQykiQRV5c6FjMjg21WjjVj3sWpwCECMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Iam6Cd7xPBBS7liumcmuG+p/7fi/TUEoxf1Z0lGNbt0OKopUbTr8AxPUDslwgvpgG
         MVU8gidpp8Pdyxwko6M3Cgy1k8zt/aS+eWhguH/ddGWeHcHN6HYjZOrWBphqbwnlbz
         lPHJ85GHyzr+4zMo9gonHR4OG8Ijsn0AfiXzGHs8=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6400860074;
        Sun, 22 May 2022 12:18:30 +0800 (CST)
Message-ID: <bb9536df-748d-5fc6-bc04-78cfd28a24e0@xen0n.name>
Date:   Sun, 22 May 2022 12:18:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 00/22] arch: Add basic LoongArch support
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
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/22 17:25, Huacai Chen wrote:
> [snip]
>
> V10 -> V11:
> 1, Rebased on asm-generic tree;
> 2, Fix fpreg macros definition;
> 3, Fix ELF ABI macros definition;
> 4, Fix magic number definition in efi header;
> 5, Remove unneeded swab.h, bitfield.h and rtc.c;
> 6, Remove __ARCH_WANT_NEW_STAT (glibc need update);

Regarding the syscall ABI change taking out fstat and newfstatat, I've 
done the following to ensure a clean path forward:

- Sent glibc patch [1] for upstream review;
- Filed [2] on Loongson's glibc fork for them to test, and incorporate 
the 2nd patch in their port;
- Updated my tool [3] for the small number of end users already on the 
previous ABI (me included, actually), to easily check if their systems 
are compatible before moving to newer kernels.

[1]: https://sourceware.org/pipermail/libc-alpha/2022-May/138958.html
[2]: https://github.com/loongson/glibc/pull/29
[3]: https://github.com/xen0n/shengloong

> 7, Improve documents as WANG Xuerui suggested;
> 8, Some other minor fixes and improvements.
