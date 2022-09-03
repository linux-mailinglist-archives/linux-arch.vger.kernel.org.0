Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8ED5AC185
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiICWDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICWDx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 18:03:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF955070A
        for <linux-arch@vger.kernel.org>; Sat,  3 Sep 2022 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=U9dsdD9qqwlZ8b7AI29WXyQh7gcYJ6Pm2kKhDtUST74=; b=ddyH0oIhik5ygDu2PxTS98mw9i
        DoyTzVda/DHbD5Z1mfvrSDeE8YhU2RRYwkqeUPuNQ8UT8QP+6ChxEDD3zHKkvfHvphj905H0m3xac
        u+riMym2pLLcgSG9jYReVJO29gNZjCJ7xifDrfzNK1No2M70mf3b1PPaxJ832DIdQjN+HAsrwjbZA
        4CfDWH8e6xPfRyb6NFDrr1VOTOwxvEVOiQddF2Dtx6qYJqWTvVrx0ChZLyoq7UMxCzzpoge1Cm3Fz
        tgBflcLQ2EzXREz6nA9whfHZgbyRJaEC+XMS9weaknvF3Nx1AHwMmkCrcMmGEONqQUkTHZOSibc+h
        aC5BEFiw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUbEz-004bEQ-9t; Sat, 03 Sep 2022 22:03:49 +0000
Message-ID: <a8f4cf90-8ae7-0542-8363-d425dfdecb0a@infradead.org>
Date:   Sat, 3 Sep 2022 15:03:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Fwd: [PATCH] tools/headers: Fix undefined behaviour (34 << 26)
Content-Language: en-US
To:     =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>,
        linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <CA+X7ob9QaUxiusEBC2eW8Wk+2FnGVATeC8pmb9pdU0Tg7-XfyA@mail.gmail.com>
 <CA+X7ob-XeKwM0r=6e+O=Se=pGQFjKVGZVihHC-Mc6YoRFf=6SQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+X7ob-XeKwM0r=6e+O=Se=pGQFjKVGZVihHC-Mc6YoRFf=6SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi--

[adding linux-mm mailing list]

On 9/2/22 23:59, Matthias Görgens wrote:
> Hello,
> 
> This is my first patch to the Linux kernel.  I hope sending it via
> gmail is OK?  I have attached the git-generated patch file.
> 
gmail's web UI won't do it AFAIK.
And most people won't accept patches as attachments.
(more difficult to review and reply with comments to them)


The easiest fix for that (IMO) while continuing to use gmail is to
use 'git send-email'.

> This is a simple fix to a problem I encountered when I tried to build
> CPython.  Some digging suggested that the problem is actually with
> kernel header files.
> 
> Basically the problem is that when calculating
> `HUGETLB_FLAG_ENCODE_16GB` we essentially run (34 << 26).  That's
> undefined behaviour in C, because C tries to do these calculations as
> signed ints, but signed signed ints don't have enough bits.
> 
> The fix is to cast to unsigned first: ((unsigned) 32 << 26).  Unsigned
> ints have enough bits, at least on 32 bit systems and above.

Instead of casting to (unsigned), can you use a constant suffix format,
like 34U << 26 ?

> I suspect the way the kernel build uses GCC and Clang this is probably
> not a problem, but the headers are used by outside projects (like
> CPython), and for that it's probably best to stick to the C standard,
> when it's easy to do so.
> 
> Thanks,
> Matthias.
> 
> P.S. Please pardon, if you received this email a second time, I had
> some trouble getting GMail to send in plain text.

-- 
~Randy
