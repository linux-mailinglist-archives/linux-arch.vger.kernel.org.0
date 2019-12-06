Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC371151D8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLFODy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 09:03:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41293 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFODy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 09:03:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so2791139pjb.8;
        Fri, 06 Dec 2019 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wIrvhx8JUqZ1A5Y/qZAw3J3FP6nnjrOWQ5P/LuZL9M=;
        b=GK/e2Q9AV7ulM8ubyjDOu23Kfo4nJwYsSVMncffTSorVKl7aRdeGiWeHx6Oa2Zorfd
         GKGAr1ncvXwGbStpwGs/H4Fj28Kn1wOiy8dgRscKZjtwT/nmh6w4EQHRlzjSk94u1lmu
         W55DfVsxejQJZnT9TSZYWBYGsV9+NZKtRipaVi0zdMwXJC9Jw4ziUHBuu+cCxZYULETt
         iyM0JES4zX3gcCbS2IXBVZazLOGZHg1Q1S8hFXFXknRs0S8rhPuWmM4I0KcHq88dQ2zT
         HnlqVZZ4baF9lXNUmMpqvqbDY0iZr1hrO2PqoBgBWz0pD13MnjAgVasWUa8XNrmyI+H3
         bWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wIrvhx8JUqZ1A5Y/qZAw3J3FP6nnjrOWQ5P/LuZL9M=;
        b=QDOZdj6tai3wtVvqus6jW/1UhPpI5u9civzq26tu/FLQhQLcPz4Bvl0eAUszjQcfTv
         L9wZ/fsMc7F4nNt3oQ6T14I71KeRNTxCtkeLP8i/hPPPVIjRU8wVue+EslOrtDXc6yev
         /lS0a6hlHLYHnEOkJKQHRHh7Y7vQi1t28CN1W3PuXl963ZQ1YiatHrubTMs75G4m2KHW
         xhRHwTczRD4wY0Di/7ZvF1kUoDpj9PN/XAwm9ny/m4TwbBt8RVOHkQC4JdWqAdcTYtFo
         JbrzGCcPw9w4ZG9kR7OgShMqFajCCCHjcFvMIlqRYJ3qkFXZFT8CCG/Yp07jYiEWb/FJ
         XMOQ==
X-Gm-Message-State: APjAAAUoU+IS1ytEfmBhHOHYkga1sQhAfh/D7z5pAN54ZstwmYOiXilj
        HWpj9rFT7Nx25qTWIIOVqHUCOsVe
X-Google-Smtp-Source: APXvYqxvKaJM6EDjuu/uqW8Ut6UxmtOSbcT1Y9insDdQ+O5F3RBBmvjvsJJLADCR00rQ/nwCHagfXw==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr14707267pla.108.1575641033225;
        Fri, 06 Dec 2019 06:03:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l66sm15350513pga.30.2019.12.06.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 06:03:52 -0800 (PST)
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
 <20191205225610.GB2532@roeck-us.net>
 <a188f905-bb08-db98-0b8a-e31bec1dfa31@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4f959f9b-9b8c-c880-0f55-172db732b783@roeck-us.net>
Date:   Fri, 6 Dec 2019 06:03:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a188f905-bb08-db98-0b8a-e31bec1dfa31@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/6/19 5:38 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 12/5/19 11:56 PM, Guenter Roeck wrote:
>>> I have to admit, I have been very lazy with kernel updates. I have been
>>> planning to upgrade to a much more recent release on my boards for a while
>>> now, I have just been postponing it since the machines run very stable
>>> with the current kernel I am using.
>>>
>>
>> Hey, if you write a qemu emulation, I'll be happy to run it on a regular
>> basis :-)
> 
> There is working SH emulation in QEMU. I have been wanting to prepare a
> current Debian/sh4 test image for that purpose for a while now.
> 

I do run this emulation in my tests. It does not support the affected CPU,
unfortunately.

Guenter

> For the time being, you can use the image by Aurelien Jarno:
> 
>> https://people.debian.org/~aurel32/qemu/sh4/
> 
>> Problem is really that the architecture doesn't get as much attention as
>> it needs. The backtrace pointed to by Rob has been seen for a long time,
>> but either there is no one with the knowledge to fix it, or they are all
>> busy with other stuff.
> 
> I fully agree. I'm mostly busy with the userland stuff, i.e. Debian packages
> for sh4 and not so much with the kernel.
> 
> Adrian
> 

