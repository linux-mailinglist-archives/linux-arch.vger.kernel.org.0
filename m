Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A7693E62
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 07:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBMGhY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 01:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBMGhW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 01:37:22 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF76580;
        Sun, 12 Feb 2023 22:37:20 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id r192-20020a4a37c9000000b00517677496d0so1098684oor.13;
        Sun, 12 Feb 2023 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r+mD21wjZ7sbz4e4MxBS6xbK/1FhjAg9+awm6A789ww=;
        b=k6tlOEQZNhmHTa+ZCajRLjNoXOkqSfo4mR8OrWgNmaL2MKywaTjKPH0ulYH6V9boxY
         52UWHSIcC8rNsw1dQfTkq/COZKRQGSqbB6Kc2G15s3DFFoFMZdeK0fle1rX83pU7KJ4L
         ++BO1fcXWC7mjkIEb9evuvP+OSvCviMd3N1ZHNescW7Lpv6a0HL6BarepuSkif6zPqmJ
         C0miEzpiGke8zc2vSBRq5eRVJsUX8UcbybG0D55ni/6ICUXuIpztwVcd4DNb/6z3a9gS
         0Q6J9mDHSQbj/EfASGYAa6yP1HnW6//0d7Bxm++QcZv8+DAFF4S+17znkvYeLv4XlC8U
         Iyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+mD21wjZ7sbz4e4MxBS6xbK/1FhjAg9+awm6A789ww=;
        b=SKpbPDYMVyorkv/a/af6u40LX2liZzE9SKbxgLPWvwBlTL45sZCqe7BF851CN+5ZsN
         Z8Q/YJqB8F/U9MDDLe3TY4dUV6kO0hYT9GyTdRQMzhqa9aGv8awTsGLj+/rzGq8JTC+p
         79vcU5vrijQ9iPLWDAvYqv7TNhoos5wU/8a5Xw4nP4dEeJYpkNhlCRoWrvowFymNgXj7
         IhoA1XiwVe9fr6dZNHMeYkIO+zN3H9bl6LqE3McHJ0qDMowb17CIc07/JYqCAimNvDE0
         KWINHbPaZI7CIFb29aon2ubQAchlnkbbi57k7oOTvRQL+BH/H6muMEO2jClMc3Qb410g
         zndg==
X-Gm-Message-State: AO0yUKV2i43yd1ISuGT9u3slolAqiCBRrqeQiMSgwdAEOCGcSSqr1k2Q
        HqkgaOh9F56EWZzrWdTeeLI=
X-Google-Smtp-Source: AK7set8CrGfl+FsDAT8ZOxZzNC5b1OZaQkksHfF8KDK4IpXQlQWLkqRaCxpy9jhC5xUjdOk1jrrITw==
X-Received: by 2002:a4a:d623:0:b0:512:2016:53e5 with SMTP id n3-20020a4ad623000000b00512201653e5mr12513885oon.6.1676270240292;
        Sun, 12 Feb 2023 22:37:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15-20020a4ad88f000000b004fc4000ae48sm4528998oov.15.2023.02.12.22.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 22:37:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <15a2c023-fdfa-9543-ac36-a846e5f8a000@roeck-us.net>
Date:   Sun, 12 Feb 2023 22:37:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net> <Y+mRz6Wfocopv9jw@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+mRz6Wfocopv9jw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/12/23 17:26, Mike Rapoport wrote:
> On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> Every architecture that supports FLATMEM memory model defines its own
>>> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>>>
>>> Use mips/powerpc version implemented as static inline as a generic
>>> implementation of pfn_valid() and drop its per-architecture definitions.
>>>
>>
>> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
>> Reverting this patch fixes the problem.
> 
> This should be a better fix than a revert:
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 506784702430..bf1b54055316 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -301,6 +301,7 @@ void __init paging_init(void)
>   	 */
>   	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>   	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
> +	set_max_mapnr(max_low_pfn - min_low_pfn);
>   
>   	nodes_clear(node_online_map);
>   

Confirmed, this fixes the problem for me.

Thanks,
Guenter

>   
>> Guenter
>>
>> ---
>> # bad: [6ba8a227fd19d19779005fb66ad7562608e1df83] Add linux-next specific files for 20230210
>> # good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
>> git bisect start 'HEAD' 'v6.2-rc7'
>> # good: [94613f0efc69ed41f9229ef5c294db3ec37145da] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect good 94613f0efc69ed41f9229ef5c294db3ec37145da
>> # good: [19e62c715fe70dae4582c2874ed3e66715d09af6] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>> git bisect good 19e62c715fe70dae4582c2874ed3e66715d09af6
>> # good: [5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6] Merge branch 'for-next' of https://gitlab.com/peda-linux/mux.git
>> git bisect good 5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6
>> # good: [c349bf6ec83903b20fe570c5609b9a864a64e09c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
>> git bisect good c349bf6ec83903b20fe570c5609b9a864a64e09c
>> # good: [5a06a9f17454df38f35672be522ff5eb9b4277d2] selftest: add testing unsharing and counting ksm zero page
>> git bisect good 5a06a9f17454df38f35672be522ff5eb9b4277d2
>> # bad: [f5d115a7b06e5661ed5218ffa9a2644c4ff1c135] Merge branch 'mm-nonmm-unstable' into mm-everything
>> git bisect bad f5d115a7b06e5661ed5218ffa9a2644c4ff1c135
>> # bad: [acb018d6ea0c055381fba7dddaef386ee28f8075] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
>> git bisect bad acb018d6ea0c055381fba7dddaef386ee28f8075
>> # good: [1a5d9782ac969dc6e61c6786500b5160603188ea] mm/mmap: remove __vma_adjust()
>> git bisect good 1a5d9782ac969dc6e61c6786500b5160603188ea
>> # good: [4b32363697de957dcc890b6245bec3f58903639a] arm: include asm-generic/memory_model.h from page.h rather than memory.h
>> git bisect good 4b32363697de957dcc890b6245bec3f58903639a
>> # bad: [328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8] mm/migrate: convert isolate_movable_page() to use folios
>> git bisect bad 328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8
>> # bad: [b704c765b08cabe82adf76a4d1a74f3688eee410] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
>> git bisect bad b704c765b08cabe82adf76a4d1a74f3688eee410
>> # bad: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
>> git bisect bad e5734c8b0edfd2a053a5c256189586a3b1e9f63d
>> # good: [ad8aecea034c591b9754bc5908da9719853aa7fa] mips: drop definition of pfn_valid() for DISCONTIGMEM
>> git bisect good ad8aecea034c591b9754bc5908da9719853aa7fa
>> # first bad commit: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
> 

