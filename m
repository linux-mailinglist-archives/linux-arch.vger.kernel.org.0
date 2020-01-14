Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77513B3C4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANUmf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 15:42:35 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:51325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANUmf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 15:42:35 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mt71D-1jgYIj3jsP-00tQxz; Tue, 14 Jan 2020 21:42:33 +0100
Received: by mail-qt1-f172.google.com with SMTP id e5so13721910qtm.6;
        Tue, 14 Jan 2020 12:42:32 -0800 (PST)
X-Gm-Message-State: APjAAAVUgLu3KybUBRWgZOQT87aqrWe4uGWtrdo3h15KL1osIR27b+Ee
        XwO52/C8wYUZjJqAr635xsaJiE6VMkpbRTp4nGw=
X-Google-Smtp-Source: APXvYqzxLn1Nj4qYcObdVSAkUm2fmRRi+xa7YXncyT2LEy7rE/VbjtJMaqfRb4R8TsrdH0c4vNhly9VoEeEnfkmz8pY=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr422257qtr.7.1579034551663;
 Tue, 14 Jan 2020 12:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-5-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-5-vgupta@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 21:42:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
Message-ID: <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P0Yk7cRWAwOVl1R8QACurohhrN3Yw6BNjXW7/LXkaI/xQ3EEAan
 kK17hFITTMb1B7LSGKhrxVaMHSq08OLC//dtMZVunX2xQrxNQ2y9WrbMubS1I7KgILdFZPR
 VT+l99twvmuutCmlvEPDqfwXhzY1dO2SUdVa/aAkX9Jq0ayR4YYkS9MA3UsQ/Zqp81P/i9V
 n8K5bO2ouBi+Zt+cttTzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Et35N60v8/0=:4cFfVfH3vHhOjgmeYnWMlM
 k7hPuGQGyDrxVcOFGX4/Uiv3WeTvPmMeDuv8hbfGUx3fUh4B8LAGWZxpY3lhybfZlDBbaA5A7
 V2MB0JP0BUTZD+BmXfH782UO4JnvZhD1yJ1MzzB/uyrbZKIDRpTm9IUAYP2+5jT7jkr4N1vzr
 jVu3fWijUeFSSfsAXzwya7YJhTlp1gJjWdtk4MBnwp8eWzPGCAQE+tx5st7B9Ye/hUnA603kc
 1WiScPtXlF28+hcGyUYErzHkl+kfj8T2cUSQd7XkxSxY5jZjhCUK9Fhd5o6nOtY50vxcV4vXb
 w4LLGfsTwh5rfALr8LtCwhxKRNh7kxYkUtcUKZeL8eQz5HiDxyjEk6RDIy1E8GewR6/wuTCRh
 9Xf7gzYmMs635A+OuzxzobhyqqKvpFuG42phTFPvUMtda1j6VCytlCG5XvNWqZ/UJ/fXuxUjd
 EeuLIEmFj6W9vnNhAcICQSIqNeqU87EzsQ0nO/cF+h1vitXq1nAQFssCPIOdpfjaGJtSEANC4
 YI5Kb0PBMVEgTOj3qenlO1GzRKA+7PpQn8Bdak1R0cNVPigBHnCjTNmqphQvd/cw+0RhTeUJG
 WGl5E3e4PARxcydezPLWBmXqljo/J+0AzDQfLzbT2NR3T2OWqPcVKHNjcalCyxSbOhMc1/bED
 lx8wPUlIMJwAkotKkDkheCnJKxLbX0LzT6Fhz4WzQtxKK9q4aP2h1hZ2/x1uT6213r71vlXHl
 TeIZkraj51SB0nYbwNQbX7KG844z/eGfnq66PSIzeubVPzq/5iafldlej3JO/6JWYLhK7cE/g
 rGfh5Vwmw42u3ZRotHrzb/t9kqJcWyw6Kq5MXN3UpPiccxM8gfjW9nglfrk7alsulmJfhI6RS
 QcYhV0+c38v4uDQIhGVw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 9:08 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> diff --git a/arch/arc/include/asm/word-at-a-time.h b/arch/arc/include/asm/word-at-a-time.h
> new file mode 100644
> index 000000000000..00e92be70987
> --- /dev/null
> +++ b/arch/arc/include/asm/word-at-a-time.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Synopsys Inc.
> + */
> +#ifndef __ASM_ARC_WORD_AT_A_TIME_H
> +#define __ASM_ARC_WORD_AT_A_TIME_H
> +
> +#ifdef __LITTLE_ENDIAN__
> +
> +#include <linux/kernel.h>
> +
> +struct word_at_a_time {
> +       const unsigned long one_bits, high_bits;
> +};

What's wrong with the generic version on little-endian? Any
chance you can find a way to make it work as well for you as
this copy?

> +static inline unsigned long find_zero(unsigned long mask)
> +{
> +#ifdef CONFIG_64BIT
> +       return fls64(mask) >> 3;
> +#else
> +       return fls(mask) >> 3;
> +#endif

The CONFIG_64BIT check not be needed, unless you are adding
support for 64-bit ARC really soon.

       Arnd
