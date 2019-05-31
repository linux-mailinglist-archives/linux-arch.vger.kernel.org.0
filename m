Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B430A89
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEaIrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:47:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35926 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:47:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id u12so10426447qth.3;
        Fri, 31 May 2019 01:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=musdmvMfmuFle9U6pm5zoVH2cKv9Sr+Vl2GKNkM9WAw=;
        b=gYqtS2HG6ZQRVl7/7pdr+r5ZBPMQxniM2Cbc069KZAktOKdkXWhS6/sU8bMDvk/Z7s
         4IUuWYQVt3ci0/8uONbSCA6yxzttN9mvGKZgc3HjQ0gMahbLPQwQuAKjOpm4hG7c+362
         dn+440liUtymlQHhT8iaPCOTXUEMV4Afad9YBArh4ru+1fbmEls4X4RMbl8BdeB/W90I
         jZB+Fl0IuZGkoNtgwVD+KFWp28umuCO/VC/pm0y73o4cAfWUDYGU/Yn20QG4qWoPm3TQ
         0qtUrzbz4LSubxqzhW4AR31b+7vvT0NiBq/Q6nQa/8ao29xJbdQA1FAUCVrMnyXvMSBi
         m0Rg==
X-Gm-Message-State: APjAAAVaszc0EsFeQs67waBEife+V4tcRYFzhBHEq0ZKyhK69UBJbR9u
        aUPHvGXjVa3vWz4BwbB9h2KJykuHhOfCt13b0gE=
X-Google-Smtp-Source: APXvYqxSrOECMcfl+h+gsYyFe6RMvJn3OIE0E1mWVu+ZeZ78o7tzQsJyOmKpAbm439V51yw3EWIWq4QnzKJ/LfAWdno=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr2866079qtf.204.1559292419933;
 Fri, 31 May 2019 01:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:46:43 +0200
Message-ID: <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
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
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> This is possible because certain syscalls like gettimeofday() do
> not write any data and return one or more values that are stored
> in the kernel, which makes relatively safe calling them directly
> as a library function.

Hi Vincento,

I've very happy with how this turned out overall, and as far as I can
tell you have addressed all my previous comments. I had another
look through the series and only noticed a few very minor issues.

I hope Thomas can have another look soon, he probably also finds
a few things, and then it should be ready for inclusion in linux-next
and the coming merge window.

One open question I touched in my review is whether we want to
have a vdso version of clock_getres() in all architectures or not.
I'd prefer to leave it out because there is very little advantage to
it over the system call (the results don't change at runtime and
can easily be cached by libc if performance ever matters), and
it takes up a small amount of memory for the implementation.

We shouldn't just need it for consistency because all callers
would require implementing a fallback to the system call
anyway, to deal with old kernels.

If anyone comes up with a good reason why it should be added
after all, let me know and I'll stop mentioning it.

      Arnd
