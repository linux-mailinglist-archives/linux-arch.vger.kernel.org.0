Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E45A103F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiHYMVY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbiHYMVW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 08:21:22 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499B7823B
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 05:21:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 0121F2FF9A
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661430079;
        bh=o8R4B63uq1QbRSvfgf9wDZJ3Ynl7jP+8WRb2sSP9xgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qfYfT8kJqT0UdpIc28FzcF0VDg89eH9a8dGbZ1Vu6ioBWDkv3OPOkPA+bpfFRWhEQ
         0Qj2MVgCqgpbU540WukpruO3/HjVBK7exbNxGKaasa5jAmVuw+rRTfhOI7yHLIYei/
         QsTJy43/OCzM1qMz+CDPOpxgYzKdWJYM5wwpwi60=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 357072FF56; Thu, 25 Aug 2022 14:21:18 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id EC9C72FF03; Thu, 25 Aug
 2022 14:21:16 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id CD04127E038A; Thu, 25 Aug 2022
 14:21:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id B604027E0394; Thu, 25 Aug 2022 14:21:16 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 yEvvU8VAQQ2c; Thu, 25 Aug 2022 14:21:16 +0200 (CEST)
Received: from [127.0.0.1] (unknown [192.168.37.161]) by zimbra2.kalray.eu
 (Postfix) with ESMTPSA id 81E7127E038A; Thu, 25 Aug 2022 14:21:16 +0200
 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <f30.6307693c.ebaf3.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B604027E0394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661430076;
 bh=DUsgQwgfLGikW2pKP8tTI/jYAz/3lejDToYVwIdzPIQ=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=qVG4qhaTWSNaLu9/dGYgT4tclpjfRdnTbKG2mMxMhu4j2zfQAe25whxpaGYySvr6a
 qYte/kQF7Rzo9KfCDYjjk8FV6kjF5reFZUJznUDYtTs1vS3B/4SriN+DOkEwyvotDj
 Rz09X2dg3ZkTcHAQz4cqMHNTvv4HBEeV+QAznndk=
Message-ID: <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
Date:   Thu, 25 Aug 2022 14:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
Content-Language: en-us
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
References: <20220817161438.32039-2-ysionneau@kalray.eu>
 <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Ard,

On 25/08/2022 14:12, Ard Biesheuvel wrote:
> On Thu, 25 Aug 2022 at 14:10, Yann Sionneau <ysionneau@kalray.eu> wrote:
>> Forwarding also the actual patch to linux-kbuild and linux-arch
>>
>> -------- Forwarded Message --------
>> Subject:        [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
>> Date:   Wed, 17 Aug 2022 18:14:38 +0200
>> From:   Yann Sionneau <ysionneau@kalray.eu>
>> To:     linux-kernel@vger.kernel.org
>> CC:     Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
>> <masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian
>> Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>
>>
>>
>>
> What happened to the commit log?

This is a forward of this thread: https://lkml.org/lkml/2022/8/17/868

Either I did something wrong with my email agent or maybe the email 
containing the cover letter is taking some time to reach you?

>
>> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
>> ---
>> include/linux/export-internal.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/export-internal.h
>> b/include/linux/export-internal.h
>> index c2b1d4fd5987..d86bfbd7fa6d 100644
>> --- a/include/linux/export-internal.h
>> +++ b/include/linux/export-internal.h
>> @@ -12,6 +12,6 @@
>> /* __used is needed to keep __crc_* for LTO */
>> #define SYMBOL_CRC(sym, crc, sec) \
>> - u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
>> + u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4)
> __aligned(4) is the default for u32 so this should not be needed.

Well, I am not completely sure about that. See my cover letter, previous 
mechanism for symbol CRC was actually enforcing the section alignment to 
4 bytes boundary as well.

Also, I'm not sure it is forbidden for an architecture/compiler 
implementation to actually enforce a stronger alignment on u32, which in 
theory would not break anything.

But in this precise case it does break something since it will cause 
"gaps" in the end result vmlinux binary segment. For this to work I 
think we really want to enforce a 4 bytes alignment on the section.

>
>
>> __crc_##sym = crc
>> #endif /* __LINUX_EXPORT_INTERNAL_H__ */
>>
>> --
>> 2.37.2

Thanks for your review :)

-- 

Yann





