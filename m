Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B323F37B7A7
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhELIQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 May 2021 04:16:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA29C061574
        for <linux-arch@vger.kernel.org>; Wed, 12 May 2021 01:15:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f24so33682213ejc.6
        for <linux-arch@vger.kernel.org>; Wed, 12 May 2021 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ofYbiesQgwQaEexlewrml7cRxApQkWB2Nx460iDcnyo=;
        b=cHIOWKyzF0AfFHiktnENLignESiqbB75M/2S8bNYGwb4UmCWst1kzfVRtHWBUILKXs
         c7eSZ9hehTk8NLHKdrT9XYNXDarjEYNKlTulZQDt9ENuebCRNglJRbSanTXy8bx1NlVm
         YW7PRTEc6U7mjbRYuKiT9exW6nbvZazhgiCk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ofYbiesQgwQaEexlewrml7cRxApQkWB2Nx460iDcnyo=;
        b=GPDtqcHGaBXudp+RpqtGiy/Z9u8bd5cGq8kg7zcjCVFR9DTnYD4UYCUGHRptHlJPei
         RC4WKbf02DFrsLdzkCjAjirHmHVYuge52h7dnj5Wri3Sx8HhXiYqlllrZROGx7RWIxDv
         FKztaeaY3JxqzOTeral9Qfrt2smV8aozxcTYMCFsUkmZWb/dHP358iZG3dlxW48JLqt5
         iyKH7RciFLzcKQMuN0hL6BbuIZPCJShZujlNJzyetxmLqMJvA2ueVMCCXiL2ukliHZNj
         Wbfr0C5Uel6ilwHGcAqxUA/dJHn26NA+u+tWWvP26C5P1iET42DCv1t8ofe8Hu5O8yvH
         wSAA==
X-Gm-Message-State: AOAM533GCGnp60mDEeCp2TT/Iv6hrDHqaC8/lbXELmlLzFybrfM6OfKv
        Nwp1jH5uKlpspf7mQxFq07G1lQ==
X-Google-Smtp-Source: ABdhPJzRky2jZTiXS/jGvK3y0xATQ4vtskLl8aSJ36xGqYFwRVDIZS1+rKVRogxxKQkuc5o4q2jaog==
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr37200326ejj.317.1620807339603;
        Wed, 12 May 2021 01:15:39 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id um28sm13885567ejb.63.2021.05.12.01.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 01:15:39 -0700 (PDT)
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Arnd Bergmann <arnd@arndb.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard> <YJoyMrqRtB3GSAny@smile.fi.intel.com>
 <YJpePAHS3EDw6PK1@rikard>
 <151de51e-9302-1f59-407a-e0d68bbaf11c@i-love.sakura.ne.jp>
 <YJrrJhvwq7RUvDXD@rikard>
 <CAK8P3a02qNHcksJ8DahHgLtbM9ZOydGjE3__3GoxgJFiWrAT0w@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <030ae370-967c-22d4-56f8-cb0435be7540@rasmusvillemoes.dk>
Date:   Wed, 12 May 2021 10:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a02qNHcksJ8DahHgLtbM9ZOydGjE3__3GoxgJFiWrAT0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/05/2021 09.48, Arnd Bergmann wrote:
> On Tue, May 11, 2021 at 10:39 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
>> On Tue, May 11, 2021 at 08:53:53PM +0900, Tetsuo Handa wrote:
> 
>>> #define GENMASK_INPUT_CHECK(h, l) \
>>>      (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>>>           __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>>>
>>> __GENMASK() does not need "h" and "l" being a constant.
>>>
>>> Yes, small_const_nbits(size) in find_next_bit() can guarantee that "size" is a
>>> constant and hence "h" argument in GENMASK_INPUT_CHECK() call is also a constant.
>>> But nothing can guarantee that "offset" is a constant, and hence nothing can
>>> guarantee that "l" argument in GENMASK_INPUT_CHECK() call is also a constant.
>>>
>>> Then, how can (l) > (h) in __builtin_constant_p((l) > (h)) be evaluated at build time
>>> if either l or h (i.e. "offset" and "size - 1" in find_next_bit()) lacks a guarantee of
>>> being a constant?
>>>
>>
>> So the idea is that if (l > h) is constant, __builtin_constant_p should
>> evaluate that, and if it is not it should use zero instead as input to
>> __builtin_chose_expr(). This works with non-const inputs in many other
>> places in the kernel, but apparently in this case with a certain
>> compiler, it doesn't so I guess we need to work around it.
> 
> I have a vague memory that __builtin_constant_p() inside of
> __builtin_choose_expr()
> always evaluates to false because of the order in which the compiler processes
> those: If constant-folding only happens after __builtin_choose_expr(), then
> __builtin_constant_p() has to be false.

It's more complicated than that. __builtin_constant_p on something which
is a bona-fide Integer Constant Expression (ICE) gets folded early to a
1. And then it turns out that such a __builtin_constant_p() that folds
early to a 1 can be "stronger" than a literal 1, in the sense that when
used as the controlling expression of a ?: with nonsense in the false
branch, the former is OK but the latter fails:

https://lore.kernel.org/lkml/c68a0f46-346c-70a0-a9b8-31747888f05f@rasmusvillemoes.dk/

Now what happens when the argument to __builtin_constant_p is not an ICE
is a lot more complicated. The argument _may_ be so obviously
non-constant that it can be folded early to a 0, hence still be suitable
as first argument to __b_c_e. But it is also possible that the compiler
leaves it unevaluated, in the "hope" that a later optimization stage
could prove the argument constant. And that's the case where __b_c_e
will then break, because that can't be left unevaluated for very long -
the very _type_ of the result depends on which branch is chosen.

tl;dr: there's no "order in which the compiler processes those", __b_c_p
can get evaluated (folded) early, before __b_c_e inspects it, or be left
for later stages.

Rasmus
