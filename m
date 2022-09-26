Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A095E9C6A
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiIZIso (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 04:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiIZIs3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 04:48:29 -0400
Received: from fx301.security-mail.net (smtpout30.security-mail.net [85.31.212.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92003C8DB
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 01:48:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id E08FF24BD118
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 10:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1664182106;
        bh=NhdN4X2rJAjNwMFvV5i0ZCxVGsFvSLAwOMfe3tyVvP4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ErNVj95STC4oGgOAoazE+hTr+BLTG0JXk1QkBx8XM53S8IOYrkTaT8NfjXSuac/ZG
         C/y47mzxjC7piGtroqQbq5Y+Q+u4NskJTHuBGsOgYGFAIY5wNEqDG1P5Y0KV/SGiP9
         81Fwm78HLYNvuewWuuODkFs1Z5JVFdKsHFoPog7E=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 8CDF024BD119; Mon, 26 Sep 2022 10:48:25 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx301.security-mail.net (Postfix) with ESMTPS id D95C624BD11B; Mon, 26 Sep
 2022 10:48:24 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id B4DBE27E042B; Mon, 26 Sep 2022
 10:48:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 9B33027E0430; Mon, 26 Sep 2022 10:48:24 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 ElWjOXGInmPY; Mon, 26 Sep 2022 10:48:24 +0200 (CEST)
Received: from [192.168.37.161] (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 830AE27E042B; Mon, 26 Sep 2022
 10:48:24 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <8417.63316758.d8444.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9B33027E0430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1664182104;
 bh=+oh7OesxMW2QIgyF4sMQoAESyP9oZENY6yeIPTgQmRM=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=R/AWeJLr7/Whjf8JKEa241CYkIYIbscdP8OEDWItPXZhXuMu4DBhoJP2fUy36vamI
 sOjmdZVxKhVtuzkiGCOcYDK5LR1KUGhu+LZUg1qUFVdrEh+zB/9pP3KMx+UQG+jPgT
 MU0nDNinl9eu7YH9ODuoCt3FFJyPWpibFdfB1htU=
Message-ID: <197eb354-2fc8-1712-3c83-34be9391efa8@kalray.eu>
Date:   Mon, 26 Sep 2022 10:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
Content-Language: en-us
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <20220817161438.32039-2-ysionneau@kalray.eu>
 <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
 <CAMj1kXHeSemLqAhbBLMGkK4G1225NZbaQvnR3wAWYfJr4AReaw@mail.gmail.com>
 <CAMuHMdUJZBPuD1=3SMg4G1-UoBr5Evd8mBfhxxuAaoh=K6Rm+w@mail.gmail.com>
 <CAMj1kXF6TchD4g0qO1OeEwt8QYU_TZEriE=1yaCxXrNGBYjmCA@mail.gmail.com>
 <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <CAK7LNAQ0wiBZB7XDZVodXWtP5m_H-e_xQ78z_eJ82W3pFrKWfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/28/22 16:05, Masahiro Yamada wrote:
> On Fri, Aug 26, 2022 at 7:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Thu, 25 Aug 2022 at 20:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> Hi Ard,
>>>
>>> On Thu, Aug 25, 2022 at 2:56 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>> On Thu, 25 Aug 2022 at 14:21, Yann Sionneau <ysionneau@kalray.eu> wrote:
>>>>> Well, I am not completely sure about that. See my cover letter, previous
>>>>> mechanism for symbol CRC was actually enforcing the section alignment to
>>>>> 4 bytes boundary as well.
>>> Yes, because else it may become 2-byte aligned on m68k.
>>>
>>>>> Also, I'm not sure it is forbidden for an architecture/compiler
>>>>> implementation to actually enforce a stronger alignment on u32, which in
>>>>> theory would not break anything.
>>>>>
>>>> u32 is a Linux type, and Linux expects natural alignment (and padding).
>>> Is it? You probably mean its alignment should not be larger than
>>> 4 bytes? Less has been working since basically forever.
>>>
>> You are quite right. of course. And indeed, the issue here is padding
>> not alignment.
>>
> I do not know if __align(4) should be used to avoid the padding issue.
>
>
>
> Do you think it is a good idea to use an inline assembler,
> as prior to 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b ?
>
>
> This patch:
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> index c2b1d4fd5987..fb90f326b1b5 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -12,6 +12,9 @@
>
>   /* __used is needed to keep __crc_* for LTO */
>   #define SYMBOL_CRC(sym, crc, sec)   \
> -       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> +       asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""     "\n" \
> +           "__crc_" #sym ":"                                   "\n" \
> +           ".long " #crc                                       "\n" \
> +           ".previous"                                         "\n")
>
>   #endif /* __LINUX_EXPORT_INTERNAL_H__ */

Ping on this topic, should we "fix our toolchain"?

Or should Linux code be modified to add either __align(4) or use the 
inline assembler? (I've tried your inline asm patch and it seems to fix 
the issue I'm having).

Or both?

Thanks,

Yann





