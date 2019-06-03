Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA61332B6
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfFCOy1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 10:54:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41046 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfFCOy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 10:54:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so10765635pfq.8
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6lhL0v3oBSXinZLkQu4SCQBSiJPYgQaRBquGwb8hr4s=;
        b=JP4co7cZmFmnKQk4jwMFldCrWamfwn0wrK2Zgum9GLuxfcGxIHwr+bK8btGXjtqkOQ
         INUU9IR3eDGonQOoBXToZmCjp0asrN5boxuVO/9LKETJgJ059b6Rz4AIsfWNcd6MRstF
         U4n2fJCnxwi9n/ASVbiLo8YDrw7/6Dp2bSKKcY2cB8P3YbIhO/KICn/o1TJ1bWxI1Otx
         rsuFDBSrdzd+d2SA9qUQVcNQiLOtWmrZWMf7QpRzp3Cdtw6sYuljY8SLCdqhgYPSNuZm
         0YIRlF4eoXKyeefYTcEDpuyXZEn9rPaHakIwCzdbhk2iC9jgtlDjsUVa9fHNT6dtJhf2
         iZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6lhL0v3oBSXinZLkQu4SCQBSiJPYgQaRBquGwb8hr4s=;
        b=HBuOhV3HXOIaoM/8InMiQWDG+n881lAoLN6hpmtp2Q2q2+960TkQh42G/ll2avug3W
         YuyfPQxy5na94k8Unio99gNkWgEvwS/RSkzAV57vUq5JTVYb1UamQzOCi5cxNkj/PmRf
         v9rRXdQzHCC24As497HeAGKTGqAdMhRV4It25Alo2RthqpGgjBVl7Q+21k8RIMwM+XqI
         h2yQ3p4tofYpMDIk+a6fPy/Z5nlYeCFK6k2UQIozcmSjSunUilGhQxoBQeFq+qdTLY8E
         QTbpUiNjkFbJNT5MBCARBxM7SlTsbTFHUJKPqVZNkd+oYo7oNvLYkrWeFMy8asCCzfps
         OpuQ==
X-Gm-Message-State: APjAAAVhTFraw0Hg2z9r3rl3ZMscKVQ+otVSXG9FlYm6ruAX01OUoArQ
        Azhtm+cGQZPDXrz9Qwrq6SJmkw==
X-Google-Smtp-Source: APXvYqzDnrConxyCVmHEqEUUREoAEXInrsPuUrnuomzsJu558QdDsWXO0FVxu80xfw+MBrqY+K/lEQ==
X-Received: by 2002:a62:ac1a:: with SMTP id v26mr9082092pfe.184.1559573666749;
        Mon, 03 Jun 2019 07:54:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id n2sm13736019pgp.27.2019.06.03.07.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:54:26 -0700 (PDT)
Subject: Re: [PATCH v6 17/19] mips: Add support for generic vDSO
To:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-18-vincenzo.frascino@arm.com>
 <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <200c39f5-3bff-cacb-57c9-e11c57df70f5@android.com>
Date:   Mon, 3 Jun 2019 07:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/31/2019 01:34 AM, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>
>> --- a/arch/mips/vdso/vdso.lds.S
>> +++ b/arch/mips/vdso/vdso.lds.S
>> @@ -99,6 +99,10 @@ VERSION
>>          global:
>>                  __vdso_clock_gettime;
>>                  __vdso_gettimeofday;
>> +               __vdso_clock_getres;
>> +#if _MIPS_SIM != _MIPS_SIM_ABI64
>> +               __vdso_clock_gettime64;
>> +#endif
>>   #endif
>>          local: *;
>>          };
> Same comment as for the corresponding arm change: I'd leave the ABI
> changes to a separate patch, and probably not add __vdso_clock_getres
> at all.

Removing this would break ABI (would it really, it just replaces the 
syscall ... so it is more of a user space expectation)? already present 
in arm64 before this series.

-- Mark
