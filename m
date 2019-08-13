Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793348C4E3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfHMXtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 19:49:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHMXtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 19:49:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so49979445plb.9
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL2GiSxONyR1+wf+cPEJ785qgYB8kzY/mss0H7pGC9M=;
        b=Wt6ztQ2X+fWJO0FTPgcX9A+51Mq8+dTZ9Ad+A3iCM8ClCkHgqKWJ2Drcvb3RRKr7tY
         erf0TC5YpqS2Portj7ZVBheih5czwyWoynvvG+OcmmO4kYKcTGfe2f3XrwTEAsq4mi21
         F50sQEzYTRfQKIDH+vxbJVarJg8gOG8ti6o2Fc+g1ZQKwAv93sQYllOrj4oWJ0zUPD+X
         OhZHWL3rBvb7RYeJg5DrjtfulYBGFzk0abwLsjlwIA2YbLnzPETAHKm0OIYnmu8wnuCN
         S6zZGySHxEitvDXRzvENqoZpHDohSYEySTt2GO05uL68b4/lXRsTldj/46PsM5r7KGQH
         nhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL2GiSxONyR1+wf+cPEJ785qgYB8kzY/mss0H7pGC9M=;
        b=ZDW8OIgXXxixo/x0gy3dDWUFJwoCybnX6970IqOrjU8roGuysa/gMXVIMp0mIcFAid
         /3XRhF9+qG+W/2fASC+eBBXl14KNRpbE1JVlEdLJIUCINf2XcrMdoj9AasX2FxoQJYql
         MinEJXY5gGRx7Z4Z0/WRhZ1HHRF0V+E3chtHL5lE5Z2N20XBRjMrCBcPtqfPYxidahs5
         5epQketDcfPBLvDgRK9VvscetPJQBbce1JO1AzbkG8MnrvxYB48aA+kUfFkBiJnTTWAa
         O06JMe813evi1MKMQo04DGwkpbvQsB9s7QUzyOY5RG6pHJpsoY/Xzg60Suc94L/zcRSs
         7w+g==
X-Gm-Message-State: APjAAAWXiKEG9TqJnBq3AnAYezCQ+93L/s9q+FQ2kqa1tBjisUcsoXYY
        9T6ywidyhXsCRGbPzbLUjS7eHQ==
X-Google-Smtp-Source: APXvYqziYoxNMLaC/s1uQ9IVzw788DhInlAx7eBm4/seDB4Szhev8YYMyLyUEb33esQFu71+edIwvw==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr40372077plb.242.1565740171253;
        Tue, 13 Aug 2019 16:49:31 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6cf1:fbba:cb42:db60? ([2601:646:c200:1ef2:6cf1:fbba:cb42:db60])
        by smtp.gmail.com with ESMTPSA id bt18sm3110564pjb.1.2019.08.13.16.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 16:49:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Date:   Tue, 13 Aug 2019 16:49:29 -0700
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08A983E6-7B9C-4BDF-887A-F57734FADC9E@amacapital.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com> <20190813205225.12032-12-yu-cheng.yu@intel.com> <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Aug 13, 2019, at 4:02 PM, Dave Hansen <dave.hansen@intel.com> wrote:

>>=20
>> static inline pte_t pte_mkwrite(pte_t pte)
>> {
>> +    pte =3D pte_move_flags(pte, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
>>    return pte_set_flags(pte, _PAGE_RW);
>> }
>=20
> It also isn't clear to me why this *must* move bits here.  Its doubly
> unclear why you would need to do this on systems when shadow stacks are
> compiled in but disabled.

Why is it conditional at all?  ISTM, in x86, RO+dirty has been effectively r=
epurposed. To avoid having extra things that can conditionally break, I thin=
k this code should be unconditional.=20

That being said, I=E2=80=99m not at all sure that pte_mkwrite on a shadow st=
ack page makes any sense.

> <snip>
>=20
> Same comments for pmds and puds.

Wasn=E2=80=99t Kirill working on a rework if the whole page table system to j=
ust have integer page table levels?=
