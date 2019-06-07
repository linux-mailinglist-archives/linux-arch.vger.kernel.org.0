Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31FB39231
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfFGQfb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 12:35:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43720 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfFGQfa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 12:35:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so1020537plb.10
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wvMqjnLfHeibHfnd5Vo60J3T+kOUBskArwKAN9PGMQ=;
        b=Z1ujcUSObY84r0pQw1gBEgavn3UDkEJ73l7OoeuHJ7dTxxtAWA5cFzGd2tv+bDLXFZ
         ZUSH8lkopmuRZXxnqwLbFKFylazXfmK1Yd06ZaFH3sphoqD6YxdLCXKJjTeZ/46olgLw
         cLkrGYT/rNrgSGRUpMNUrvuX5u7UwSAvEWwn4hAgbhrWtbQEXPMkYf5cSf3rXHCCI2yO
         oxKvbLtHVB4ymsJqzauKbObHwXVJGq0nRHyzLloNX1EQW9P9evaYW8zYcNjTEP4aI/WM
         V69MI12MFr6S0MbwLenZ5QYptjGPavTIFQ1xi2XagjAAyleNVcloUFwKXdfWiK7WVJUO
         LbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wvMqjnLfHeibHfnd5Vo60J3T+kOUBskArwKAN9PGMQ=;
        b=ZNa5gehd3ffLryrLSPl2qfFgeTUhMLZwdFF+LToy8ppJDLjp6irWkBfUQ8Evw2NRCr
         Q3UMFQfs6xheBjYvCXjYZpL61RDLgc4Q6edjAuoTGYhw7UNiU8Yw8U04tzmjPs5tWHvn
         RkGD1XtglX149/VVVu/j6BomhQsAtYd4ooBe1dPdEG3kgPHy66kCHlUNeqSwzrXuVy3c
         BR0I87NqmtR+Iu56HZMCYTnx7KFwdchMhPcf6JfTmswNeOiPg+Unz8wo5xQp6R/0PQqZ
         dEYw9hrV50kvVI7pl2Ee+109suCNLXCveRDrkR2Km6oh1W0/WGyMoInzcyaflMI9xyyA
         I1ow==
X-Gm-Message-State: APjAAAVcu+GzpSnP+5NhSUTjwap26c4gekppWXzAYC4rU+2XL1aq8UJf
        hwJkDtQgw+1vIT9Ah3VlJaot8A==
X-Google-Smtp-Source: APXvYqxYfU9YVziUJO0vNHvuNseZrHbxK2V0LHuxNzSafUXNPN+YeoYV3SImF7zgnh5F5HqBc8Gomg==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr48583188plm.237.1559925330160;
        Fri, 07 Jun 2019 09:35:30 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id f2sm2240019pgs.83.2019.06.07.09.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:35:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
Date:   Fri, 7 Jun 2019 09:35:27 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 7, 2019, at 9:23 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
>> On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
>>> On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
>>> Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
>>> that allows execution of legacy, non-IBT compatible library by an
>>> IBT-enabled application.  When set, each bit in the bitmap indicates
>>> one page of legacy code.
>>>=20
>>> The bitmap is allocated and setup from the application.
>>> +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
>>> +{
>>> +    u64 r;
>>> +
>>> +    if (!current->thread.cet.ibt_enabled)
>>> +        return -EINVAL;
>>> +
>>> +    if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
>>> +        return -EINVAL;
>>> +
>>> +    current->thread.cet.ibt_bitmap_addr =3D bitmap;
>>> +    current->thread.cet.ibt_bitmap_size =3D size;
>>> +
>>> +    /*
>>> +     * Turn on IBT legacy bitmap.
>>> +     */
>>> +    modify_fpu_regs_begin();
>>> +    rdmsrl(MSR_IA32_U_CET, r);
>>> +    r |=3D (MSR_IA32_CET_LEG_IW_EN | bitmap);
>>> +    wrmsrl(MSR_IA32_U_CET, r);
>>> +    modify_fpu_regs_end();
>>> +
>>> +    return 0;
>>> +}
>>=20
>> So you just program a random user supplied address into the hardware.
>> What happens if there's not actually anything at that address or the
>> user munmap()s the data after doing this?
>=20
> This function checks the bitmap's alignment and size, and anything else is=
 the
> app's responsibility.  What else do you think the kernel should check?
>=20

One might reasonably wonder why this state is privileged in the first place a=
nd, given that, why we=E2=80=99re allowing it to be written like this.

Arguably we should have another prctl to lock these values (until exec) as a=
 gardening measure.=
