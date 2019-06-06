Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7663938039
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfFFWEq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 18:04:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFFWEp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 18:04:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so2344908pfq.0
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gywlfm9Yoih0bMD6ifzxFpYzXhaSqNtZ3Vx41KnjrlA=;
        b=KdSuc6qUwutVqZM2bBUwnBVByiqJN/DKQJSosVOKivdyswe1dj1OAQfWDjDK5YJqE1
         3t/oHHgHgs+xW+fdWxVOLNWJCnOHYy0LQGMB6JmAUG7IXoYQOym9OJyHHhJSkOCWAnhx
         8ZyvTJDobg2BeY5W4nGvYAgDyNSaNV7cPjuqETuPpAL/hFFP94VqLDOOhRHizSEdYNbX
         rKoG4vr6XTyxTWKCztg7TkQKMD0hCuWqA7q9AZ+TyVE1Pp1fsVn2MY93Iie5UNcgJ7RK
         cwWcCP2/TdvUQakRROAWM6UmzRJhH+2vJHzQ8AEnKylWm8x9WUlTp6jAtdEEDQmMH5ut
         jTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gywlfm9Yoih0bMD6ifzxFpYzXhaSqNtZ3Vx41KnjrlA=;
        b=guctpoXW52WnOLSXSZpoLaM9Sw8Mvn/5QxIOETB0krCYyaXFRa7hXIAneBehZBBHvI
         vO2D8LrvTV8elEgI3HUbZal3al/C1sUQDlNEkjF4kIS8c5tXDH3N0e2+hrDhIyLiQtwu
         f7RbFkV1WjQFfOhGvLjD11wJCdwlBEQAmd05NTA6kj8i2rOTjdURrMRAbWT50QbBUhNB
         q2QKl0PYtHObI0lwsPHDoDjGCH8d+UXzfuqH6HdlEPb/kuVBHRZ7wFLIhC1fn/iZt4R5
         4IfB4YeBwicEfXgkfHyTI7i/qF3+2j2ogzky7l9s1TpHSH4O4Kgze5pwB02JbTsU/HV9
         5zVg==
X-Gm-Message-State: APjAAAXaj0PlZb5zf3LhmlObfIE/Ixa49vyO3QSW1B48R6GeuXOEwLSd
        UV5tpRAVRWlGo1fV/lrqaJZ2rw==
X-Google-Smtp-Source: APXvYqyk9QmRHSJ+vGdphw2yaxfTPiy05mkf3a1uNeH7r3/M6ySs3Tt2nDTXY7uEDRPl7vLLEP5vrg==
X-Received: by 2002:a62:1456:: with SMTP id 83mr3919945pfu.228.1559858685103;
        Thu, 06 Jun 2019 15:04:45 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:95e1:658b:ab88:7a44:1879? ([2600:1010:b02c:95e1:658b:ab88:7a44:1879])
        by smtp.gmail.com with ESMTPSA id s12sm68142pjp.10.2019.06.06.15.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 15:04:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 04/27] x86/fpu/xstate: Introduce XSAVES system states
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <0a2f8b9b-b96b-06c8-bae0-b78b2ca3b727@intel.com>
Date:   Thu, 6 Jun 2019 15:04:41 -0700
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
Message-Id: <5EE146A8-6C8C-4C5D-B7C0-AB8AD1012F1E@amacapital.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com> <20190606200646.3951-5-yu-cheng.yu@intel.com> <0a2f8b9b-b96b-06c8-bae0-b78b2ca3b727@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Jun 6, 2019, at 2:18 PM, Dave Hansen <dave.hansen@intel.com> wrote:

>> +/*
>> + * Helpers for changing XSAVES system states.
>> + */
>> +static inline void modify_fpu_regs_begin(void)
>> +{
>> +    fpregs_lock();
>> +    if (test_thread_flag(TIF_NEED_FPU_LOAD))
>> +        __fpregs_load_activate();
>> +}
>> +
>> +static inline void modify_fpu_regs_end(void)
>> +{
>> +    fpregs_unlock();
>> +}
>=20
> These are massively under-commented and under-changelogged.  This looks
> like it's intended to ensure that we have supervisor FPU state for this
> task loaded before we go and run the MSRs that might be modifying it.
>=20
> But, that seems broken.  If we have supervisor state, we can't always
> defer the load until return to userspace, so we'll never?? have
> TIF_NEED_FPU_LOAD.  That would certainly be true for cet_kernel_state.

Ugh. I was sort of imagining that we would treat supervisor state completely=
 separately from user state.  But can you maybe give examples of exactly wha=
t you mean?

>=20
> It seems like we actually need three classes of XSAVE states:
> 1. User state

This is FPU, XMM, etc, right?

> 2. Supervisor state that affects user mode

User CET?


> 3. Supervisor state that affects kernel mode

Like supervisor CET?  If we start doing supervisor shadow stack, the context=
 switches will be real fun.  We may need to handle this in asm.

Where does PKRU fit in?  Maybe we can treat it as #3?

=E2=80=94Andy
