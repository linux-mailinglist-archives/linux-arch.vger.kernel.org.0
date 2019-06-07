Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA1392C2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfFGRFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 13:05:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbfFGRFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 13:05:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so1521113pfg.10
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgtSX/H6NfPgrhihV60ypaHNzH2XLKDDtBMwkkXJEQM=;
        b=K15lDwrHU+QByMLUcGsPxdOnNlJhavwl5vzG6kxYPkx7YmYvZeW1ck5JO0OoObB5Xa
         bYOzIyKVQ7hz1tKrFJw+d10DsxIcYUogKFKziY6bC49Z4sqMZGz+GKrut1kqgjD9iqnD
         Iy7yuXdRlEQo1JJypK02SCFJ3fiU6aXucnVYHIUhOl0FC0rrAuLNGfNaBUSjjY0SJP0O
         g+9/YMoWXJmfYyZUowSn5eE6XZng5m+uDKaxwLeh1WtwbitTB4KCIgvTiJtDprK4A3Nl
         yGxKspKE+tdnIrdwE1lKLqeXOSavRevLlFIkM3wUJcLjFBoUe06Q+MLv/g4yKH03/nvj
         qypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DgtSX/H6NfPgrhihV60ypaHNzH2XLKDDtBMwkkXJEQM=;
        b=Sxpev2ruXEK99elE56Jqr1LHuIwIpnJ9TZhEagLOOPuD5xSRom7qGq3YyTWMOTEPB3
         Sr50sr4vzV8Mj3ROvSgMpYhSHm21VrcugXGFr2i5p03DsoRCT5K8yU4YE2be9nsHj9T9
         e4fKhFC7IAoDwZNJQsBzXCGUW2+li+DolE1jWOt3fPGYIE/v/bLfvb3nqti4NjsEQb0Y
         EtcZz2qkHlldEizXRboymj5HUGrvTt4ua/y7b+dAZdjBVTd5ZKsUMeyADCCiowsG7aYe
         yHCw9flWfXG6RNZPAApxnp6Se9pZRMCeXIEcFQHBUbChCL7slp5eFcKopx1Y55SefmuN
         7KYg==
X-Gm-Message-State: APjAAAXu61LXCghjoohbhailEmXa4Yg7xroNlZ7/cTOpRaLNa7RUHazD
        wDfPQBR69clZB9bp3/MwSnRRUg==
X-Google-Smtp-Source: APXvYqxpIAgK6uMLd/KqHPohBW13L8/VruBdBF59jsPIJ7TQYnlh4WNEPsdSIs+GfxOtnM3FSmF/iQ==
X-Received: by 2002:a17:90a:24e4:: with SMTP id i91mr7053557pje.9.1559927117889;
        Fri, 07 Jun 2019 10:05:17 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id b2sm2609638pgk.50.2019.06.07.10.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:05:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <ac8827d7b516f4b58e1df20f45b94998d36c418c.camel@intel.com>
Date:   Fri, 7 Jun 2019 10:05:13 -0700
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
Message-Id: <A495EEB4-F05F-4AB3-831A-0F15B912A7EC@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com> <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net> <ac8827d7b516f4b58e1df20f45b94998d36c418c.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org




> On Jun 7, 2019, at 9:45 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
> On Fri, 2019-06-07 at 09:35 -0700, Andy Lutomirski wrote:
>>> On Jun 7, 2019, at 9:23 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>=20
>>>>> On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
>>>>> On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
>>>>> Indirect Branch Tracking (IBT) provides an optional legacy code bitmap=

>>>>> that allows execution of legacy, non-IBT compatible library by an
>>>>> IBT-enabled application.  When set, each bit in the bitmap indicates
>>>>> one page of legacy code.
>>>>>=20
>>>>> The bitmap is allocated and setup from the application.
>>>>> +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
>>>>> +{
>>>>> +    u64 r;
>>>>> +
>>>>> +    if (!current->thread.cet.ibt_enabled)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    current->thread.cet.ibt_bitmap_addr =3D bitmap;
>>>>> +    current->thread.cet.ibt_bitmap_size =3D size;
>>>>> +
>>>>> +    /*
>>>>> +     * Turn on IBT legacy bitmap.
>>>>> +     */
>>>>> +    modify_fpu_regs_begin();
>>>>> +    rdmsrl(MSR_IA32_U_CET, r);
>>>>> +    r |=3D (MSR_IA32_CET_LEG_IW_EN | bitmap);
>>>>> +    wrmsrl(MSR_IA32_U_CET, r);
>>>>> +    modify_fpu_regs_end();
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>=20
>>>> So you just program a random user supplied address into the hardware.
>>>> What happens if there's not actually anything at that address or the
>>>> user munmap()s the data after doing this?
>>>=20
>>> This function checks the bitmap's alignment and size, and anything else i=
s
>>> the
>>> app's responsibility.  What else do you think the kernel should check?
>>>=20
>>=20
>> One might reasonably wonder why this state is privileged in the first pla=
ce
>> and, given that, why we=E2=80=99re allowing it to be written like this.
>>=20
>> Arguably we should have another prctl to lock these values (until exec) a=
s a
>> gardening measure.
>=20
> We can prevent the bitmap from being set more than once.  I will test it.
>=20

I think it would be better to make locking an explicit opt-in.=
