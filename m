Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDBC424A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfJAVGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 17:06:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAVGc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:06:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so14855047lje.9;
        Tue, 01 Oct 2019 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9L27m8MsIoj3QMvk1OHmCkQODcTde/pPqDz59ZpNOo=;
        b=YXMTzPqYi2F6GPiJPok4ntRFtf+wtxTRc+vx2Q5VpFju2r4XEHLeQEUXt2wp5Bx8jr
         NUDD/P3jnTe/vkgNwsf0EeLEvfy7bAo+W6cQAuwuB/+xTUyH//f8tfEx5Z8D0CrDR4tJ
         LLyjpQoCF2v+bQwcVG06RtUrDYqUTkkji6A2ikG11BnsfvXQ6usFBQEqs3enMbTT+/8V
         o/ick0nxVayCnmbd0DDXZL3sbNG7hX1IkC4EGwDuZIFg2as7HRMxLLsj5ile6bs4vRDJ
         MqCSZhBkYmIjh67N4pAvZIr5HJkRJTtVi6mRQ+hR7tMDBJU/08/MhyyEOIVP8iWmhVFG
         iWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9L27m8MsIoj3QMvk1OHmCkQODcTde/pPqDz59ZpNOo=;
        b=MQJBjnVqvQvKpJWO9L1E5QGsoF3qqrXrhgH7/Uh8dF2edliNzPIV5JBvLIKCcCCw/U
         XJjDMB5nTgGFUH+PmmJki7udEnD190vJR3DNLFq2QpUlIbkD9ala0KcASEih6vhUSfaF
         ugIFcK6E54lqpImmUymr2+5xjom0igkuroLRNiVyzmpPhzhm0UXcVJymmfZWznpeYgwT
         ahgKsn4qpNm3r1GnJnai/XTrUgZMBTWM5/4iomcgAlUm7qNcnVvGTl04gXtCQOIXYIpC
         mWz5G2C8Nz5hQ48P6lQqhlE/FtVcAD9UOqOAwyR4Vm7fk3nqFz5PfK5agm08fjlpzdF6
         Tr5w==
X-Gm-Message-State: APjAAAWDaTnJMTMb/m5XKFzJHEBXoD3J6Cz3FSsyw9jv98IrqpK++9iX
        l8J7pKhjashiBkh1k9tD9ecb2gelIK9SQ1XfIjE=
X-Google-Smtp-Source: APXvYqwGJ03vItZTcQ9vvLhKW0RtUqsM+5DGTkngherlXinfjpYeqZCqjoCKDSF1PlmL3NKC0VSObjO46aYCAZLaiUA=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr16942430lja.203.1569963989972;
 Tue, 01 Oct 2019 14:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com>
In-Reply-To: <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Oct 2019 23:06:18 +0200
Message-ID: <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 1, 2019 at 10:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 1. is clearly the most common case, but there is also
>
> 4. Some compiler version (possibly long gone, possibly still current)
> makes bad inlining decisions that result in horrible but functionally
> correct object code for a particular function, and forcing a function to
> be inlined results in what we had expected the compiler to do already.

There is also 5. code that does not even compile without it, e.g.
_static_cpu_has() in x86_64 which requires
__attribute__((always_inline)), at least on GCC 9.2.

For x64_64 it is the only one case I found, though. If you disable
__always_inline everything else compiles and links (in a defconfig).

Cheers,
Miguel
