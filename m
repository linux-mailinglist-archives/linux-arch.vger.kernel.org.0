Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3C5AD458
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiIEN4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIEN4w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 09:56:52 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412405A157
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 06:56:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 2B9B21B7B47D
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 15:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1662386208;
        bh=TOuoIKyBN61xxuE2n8si6OSlHX9WoO9y5LMUW3ZwGrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C4DuzLRU977dllvg9V53/+xTU6JNYHn3NN/BDRZzLGq59J6tYWb1ncf67YCdGGj6U
         cNTrvPJ0JAuo8rXuY5ugDoYgNuCw0teTl/VFRd8kB5UmvtwQ4kbyJJF9Z2Apx7dJDy
         VV4kHdrLNm4oEn8SkSTqqTUsxTSETzdr+dmwS+vU=
Received: from fx408 (localhost [127.0.0.1]) by fx408.security-mail.net
 (Postfix) with ESMTP id BE6FC1B7B41A; Mon,  5 Sep 2022 15:56:47 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 20BE51B7B395; Mon,  5 Sep
 2022 15:56:47 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 0274527E032A; Mon,  5 Sep 2022
 15:56:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id DD25427E03D4; Mon,  5 Sep 2022 15:56:46 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 O4A4ZkI6VIGd; Mon,  5 Sep 2022 15:56:46 +0200 (CEST)
Received: from [192.168.37.161] (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id C855327E032A; Mon,  5 Sep 2022
 15:56:46 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <aa98.6316001f.1f6c7.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu DD25427E03D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1662386206;
 bh=2eRA2XpjgTGrVrcGfQ5A9KiIo69tGgexBgv88zL7GhE=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=rCB37hWNJT7d+nBXA7osdnhDbrfLuKGN+rg7V2UI1cnZ2tcwhGRDy6F5xrOWzUpKa
 nuekbVNMM3sy6+NIG19ohlOBVt2E1Na0sb8lOGLLmw0Zz6IgqQyc7TXMkWtfyaOekZ
 KiJzbGT8y6SDnmO8x6h3M4I041detgr1+VC3EXg4=
Message-ID: <56080169-c1e1-0b3c-3e04-01d269eb21cb@kalray.eu>
Date:   Mon, 5 Sep 2022 15:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
Content-Language: en-us
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20220817161438.32039-2-ysionneau@kalray.eu>
 <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
 <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
 <CAK7LNARfwLjoEeJ=s5VSi9tbA0wBSzR93--OnZh0oGfvuvw_9w@mail.gmail.com>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <CAK7LNARfwLjoEeJ=s5VSi9tbA0wBSzR93--OnZh0oGfvuvw_9w@mail.gmail.com>
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

On 8/28/22 15:59, Masahiro Yamada wrote:
> On Thu, Aug 25, 2022 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
>> Hello Ard,
>>
>> On 25/08/2022 14:12, Ard Biesheuvel wrote:
>>> On Thu, 25 Aug 2022 at 14:10, Yann Sionneau <ysionneau@kalray.eu> wrote:
>>>> Forwarding also the actual patch to linux-kbuild and linux-arch
>>>>
>>>> -------- Forwarded Message --------
>>>> Subject:        [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
>>>> Date:   Wed, 17 Aug 2022 18:14:38 +0200
>>>> From:   Yann Sionneau <ysionneau@kalray.eu>
>>>> To:     linux-kernel@vger.kernel.org
>>>> CC:     Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
>>>> <masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian
>>>> Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>
>>>>
>>>>
>>>>
>>> What happened to the commit log?
>> This is a forward of this thread: https://lkml.org/lkml/2022/8/17/868
>>
>> Either I did something wrong with my email agent or maybe the email
>> containing the cover letter is taking some time to reach you?
>>
>>>> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
>>>> ---
>>>> include/linux/export-internal.h | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/export-internal.h
>>>> b/include/linux/export-internal.h
>>>> index c2b1d4fd5987..d86bfbd7fa6d 100644
>>>> --- a/include/linux/export-internal.h
>>>> +++ b/include/linux/export-internal.h
>>>> @@ -12,6 +12,6 @@
>>>> /* __used is needed to keep __crc_* for LTO */
>>>> #define SYMBOL_CRC(sym, crc, sec) \
>>>> - u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
>>>> + u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4)
>>> __aligned(4) is the default for u32 so this should not be needed.
>> Well, I am not completely sure about that. See my cover letter, previous
>> mechanism for symbol CRC was actually enforcing the section alignment to
>> 4 bytes boundary as well.
>>
>> Also, I'm not sure it is forbidden for an architecture/compiler
>> implementation to actually enforce a stronger alignment on u32, which in
>> theory would not break anything.
>>
>> But in this precise case it does break something since it will cause
>> "gaps" in the end result vmlinux binary segment. For this to work I
>> think we really want to enforce a 4 bytes alignment on the section.
>
>
> Please teach me a bit more about the kvm compiler.
>
>
>
> How does it get access to an array of u32?
>
> u32 foo[2] = { 1, 2 };
>
>
> Does the compiler insert padding between each element
> so that both of &foo[0] and &foo[1] are 8-byte aligned?
>
> Or, no padding, and the address of &foo[1] is  8 n + 4?

Here is what's happening: https://godbolt.org/z/Yz74W7jGY

unsignedintfoo[2] = { 1, 2};
intget_foo_sum(unsignedint*foo) {
returnfoo[0] + foo[1];
}
gets compiled to:
get_foo_sum:
lwz$r1=0[$r0]
;; # (end cycle 0)
lwz$r0=4[$r0]
;; # (end cycle 1)
addw$r0=$r1, $r0
ret
;; # (end cycle 4)
foo:
.long1
.long2
So it seems that no padding is inserted. Which looks sane ^^




