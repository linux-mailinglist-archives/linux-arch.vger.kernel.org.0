Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F15AD66D
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiIEP2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiIEP2G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 11:28:06 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1761D6F
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 08:27:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id C75743238BE
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 17:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1662391620;
        bh=zdy2QXF7MZMFGNyk77sQ05u9I4p5QqpNO9Ia4s+hDvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AXcm/nmFxH8TUUKqYSFjvRnYsMNU3NaVbFNpv3LPleibs8OOuAxfN0n0ZT3++UW8X
         ZSPVjZ+fc4LZekPaI+xnwY+xIvgHZbCfxuu39/QtV5hyKFl0elK9YMETVsgG04ZxWA
         mNrdIyYYNkKnK922fQ4/J0oDSfnhBng7l1wC4AWU=
Received: from fx405 (localhost [127.0.0.1]) by fx405.security-mail.net
 (Postfix) with ESMTP id D55B8323760; Mon,  5 Sep 2022 17:26:59 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id B90BC3236DA; Mon,  5 Sep
 2022 17:26:58 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 9615027E03D4; Mon,  5 Sep 2022
 17:26:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 7CCD727E03D5; Mon,  5 Sep 2022 17:26:58 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 7zYpXFzw6Yh4; Mon,  5 Sep 2022 17:26:58 +0200 (CEST)
Received: from [192.168.37.161] (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 5F3AE27E03D4; Mon,  5 Sep 2022
 17:26:58 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <ca03.63161542.b7743.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 7CCD727E03D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1662391618;
 bh=5fVZGOTj7NTj14wWTuioM5QqJkWBjEEHl0LCCfYjenk=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=BVGjM7pFF/BzkKhEFeQiJPX3OTXMNiUAs8qaR5XLHNYA6q32olrrOa8QYFX1+7Pof
 /LfU7AGxseqOWxcjbECHEgg2yt2vhmnNqNF5MpNA5v2+d88DVAM0fUllNkBLTtFs6P
 57M/8hdaI1qaQCns7niXF8tGeFaQlZ//QszaINJQ=
Message-ID: <ebec96c9-4ac8-50a3-1b30-92e1f41523fb@kalray.eu>
Date:   Mon, 5 Sep 2022 17:26:58 +0200
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
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Masahiro,

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

I can confirm that this patch solves my kernel module CRC issues on kvx 
port.

Thanks,

-- 

Yann





