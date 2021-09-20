Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB3412AF0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Sep 2021 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhIUCD6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 22:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhIUBpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 21:45:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21645C05937A;
        Mon, 20 Sep 2021 14:14:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so17470304pff.3;
        Mon, 20 Sep 2021 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wJbe26PbHhpGOrBm34WfP3EQpBDDdiCtuFeJHFErXao=;
        b=XsOg/+RTS1dlQNb9LQapBJTEFbCTAMTz0fxmiMQT2IuwKXO/HGmAf4Tv+771pP9njY
         nMxicCI6TJ7kfiCsL1P9Iq9ia/ZdNxasSfvohF+q+MAN/DS82gHpFxtGPjZ2VVFzOSMB
         qFKTjVaN6yM9ZYqWlNSs8iqKIhrcc902zTIgS3z/24bT9yGe6DQpfxbfjfW/sH7chB8w
         hwgxBaJWDPs//QlPZB/rbFStytxNc8xWs+xR8cuUN2HsumNl5VkD7mI713EsofTW81i7
         q8WkCNTCpbd5NXvqfelOHpsKEV6NKhzoLcqcVsiXPz52vQCKD9vOQ3xesM06Sh4fahOQ
         vN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJbe26PbHhpGOrBm34WfP3EQpBDDdiCtuFeJHFErXao=;
        b=pAB9PV995tNH42WiD5igGo40ltmnpk9Xv91Q3pAF63CML4jxpOugaNr5qWKywhGRvA
         VDKu0I1V6LIKWqiT3kVJZv5YCtbJZ39nIQXIRD3NzhRIiUedu4KK4YpHZb3WnF+T+7xJ
         by1KLMFNzRO8GcVO3/lmXK5UPhb7Giw416PwcLGYmk8y9r+VXjsUJBXMPJMwqSZiJGAl
         6BcX0zoCA8G1ExPpySukgItKqMy+y7QwUORUyqMhywJJEAPsk0fN1UyO3yjzsgo9i54M
         UNqvjgwRBEjOAxqQZVZ3pwy5aWruqgpkAzb8vSWNBeW0yNSdbBrcLZGtrc9N9bQliU45
         wqIQ==
X-Gm-Message-State: AOAM5301iSS+dii+GIlmAo3nNVUDSOEVboQCHrY3kfo3/aoRHLiV7as/
        6rokvisuVeFjGwoMlqM82jU=
X-Google-Smtp-Source: ABdhPJxT+Kq7mMohFE4vU+4/4A3kHTJgOAReFUeXiGCwjRSGFhNml42MoQBZbYpHGt5HUM9KI8UGng==
X-Received: by 2002:a05:6a00:c3:b0:43d:e6be:b2a6 with SMTP id e3-20020a056a0000c300b0043de6beb2a6mr27203762pfj.34.1632172453197;
        Mon, 20 Sep 2021 14:14:13 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.134.125])
        by smtp.googlemail.com with ESMTPSA id p24sm14925238pfh.136.2021.09.20.14.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 14:14:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
Subject: Re: [PATCH V3 14/22] LoongArch: Add signal handling support
To:     Huacai Chen <chenhuacai@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-15-chenhuacai@loongson.cn> <87tuii52o2.fsf@disp2133>
 <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com>
 <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
 <CAAhV-H7A=C3Tujt2YNv1np9pEP_Hxc-chGnOdmDCzx5tUt7F5g@mail.gmail.com>
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <a0fb870d-3b79-ca77-305f-6178974729e4@twiddle.net>
Date:   Mon, 20 Sep 2021 14:14:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7A=C3Tujt2YNv1np9pEP_Hxc-chGnOdmDCzx5tUt7F5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/19/21 7:36 PM, Huacai Chen wrote:
> Hi, Arnd,
> 
> On Sun, Sep 19, 2021 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Sat, Sep 18, 2021 at 9:12 AM Huacai Chen <chenhuacai@gmail.com> wrote:
>>> On Sat, Sep 18, 2021 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>> For example does LoongArch have a version without built in floating
>>>> point support?
>>>
>>> Some of these structures seems need rethinking, But we really have
>>> LoongArch-based MCUs now (no FP, no SMP, and even no MMU).
>>
>> NOMMU Linux is kind-of on the way out as interest is fading, so I hope you
>> don't plan on supporting this in the future.
>>
>> Do you expect to see future products with MMU but no FP or no SMP?
> OK, we will not care no-MMU hardware in Linux, but no-FP and no-SMP
> hardware will be supported.

Please consider requiring the FP registers to be present even on no-FP hardware.

With this plus the FP data movement instructions (FMOV, MOVGR2FR, MOVFR2GR, FLD, FST), it 
is possible to implement soft-float without requiring a separate soft-float ABI.  This can 
vastly simplify compatibility and deployment.


r~
