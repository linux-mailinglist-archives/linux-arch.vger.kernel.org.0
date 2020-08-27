Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58308254D50
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgH0S4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0S4u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 14:56:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207C7C061264
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:56:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q93so3037151pjq.0
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qvX+0t4taP46QXZOUzH9jS+RyGYBYFHPCCevAMrrHDg=;
        b=1qJZF1j7aP9/gm8JJKCOiOmY8yDhder5SBu4XDeJXypfw+jqz30KJKC2TixCvPVViK
         xlyPbT0mk9IkEZAohEpohg9pTxIu+yU+8I99UYuFfB2+W6d1yn9K/s/ZEdAeYNwEFrh7
         uIEw6O9Sv5M7d82YW0k2n7hJ42sUVJ+0AyoHw/pBvsJg0JfJkhZLOV0kygxS5bRK7lwp
         hnZ4sJgY33aokxqI9jOqk7Ssge/vXqhthQtrILVuuzdVHv1aHxPjsnxK2HiRQfrXnTEO
         n/GkIFN8FvZ2rmUMRWcnfMJIwbR8JUj0xzI1/BNVZ2o8q0vatriR3W41ZXJSnyJeurqg
         8wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qvX+0t4taP46QXZOUzH9jS+RyGYBYFHPCCevAMrrHDg=;
        b=sn4/2KA9XsjsMrEoRcZYfhsf5XaWW1pVBeuYOi5i4Nyc1kRSOKVD1AxT2CVlq1NC9c
         dpB0+sr5kzIxFcLVmdHSb9OtHTBWEmSzYSCXa9rdlr+KrvGY6waBe6NyN14HAYQQjNox
         INHcPsFdbn17w1HzovTzhl6Ik/q0AG9r79KaP+QAmrmapa63eN4lCXYOOnTn4EDUgb9T
         iHIfr8PzfPZFyVaIn75iypKQQzitJdtVRYlNVHRXcQAekE/XhunVeZEgHxrL7Vlaj86h
         L17cYlNHClbH6gcEHbqgyZHm3xFSXFgg76ytESTuUwvvhfrOP5vVjRAH21f9zsKFdZPY
         ts0w==
X-Gm-Message-State: AOAM530DASz4uciir0l9/GWd8aOFQBcNaxHw+43B0iYxTnN91Za9EP/2
        j4a6aKhuBZef/Bl/h2aGkhyvvg==
X-Google-Smtp-Source: ABdhPJw0Il7nyzGXecauI/EFZTlrviyvlwdNvPHCgqm8m/VXXhnhoQ1jf2Ta5Mdp8f616+x7S9BSZw==
X-Received: by 2002:a17:90a:ec03:: with SMTP id l3mr200548pjy.193.1598554609609;
        Thu, 27 Aug 2020 11:56:49 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:f108:b6a3:155e:4f99? ([2601:646:c200:1ef2:f108:b6a3:155e:4f99])
        by smtp.gmail.com with ESMTPSA id y203sm3847139pfb.58.2020.08.27.11.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:56:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
Date:   Thu, 27 Aug 2020 11:56:44 -0700
Message-Id: <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
In-Reply-To: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (17G80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Aug 27, 2020, at 11:13 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn 8/27/2020 6:36 AM, Florian Weimer wrote:
>> * H. J. Lu:
>>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wro=
te:
>>>>>=20
>>>>> * Dave Martin:
>>>>>=20
>>>>>> You're right that this has implications: for i386, libc probably pull=
s
>>>>>> more arguments off the stack than are really there in some situations=
.
>>>>>> This isn't a new problem though.  There are already generic prctls wi=
th
>>>>>> fewer than 4 args that are used on x86.
>>>>>=20
>>>>> As originally posted, glibc prctl would have to know that it has to pu=
ll
>>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
>>>>> then the u64 argument is a problem for arch_prctl as well.
>>>>>=20
>>>=20
>>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
>> The commit message and the C source say otherwise, I think (not sure
>> about the C source, not a kernel hacker).
>=20
> H.J. Lu suggested that we fix x86 arch_prctl() to take four arguments, and=
 then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags and siz=
e are all in registers, this also solves problems being pointed out earlier.=
  Without a wrapper, the shadow stack mmap call (from user space) will be:
>=20
> syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).

I admit I don=E2=80=99t see a show stopping technical reason we can=E2=80=99=
t add arguments to an existing syscall, but I=E2=80=99m pretty sure it=E2=80=
=99s unprecedented, and it doesn=E2=80=99t seem like a good idea.
