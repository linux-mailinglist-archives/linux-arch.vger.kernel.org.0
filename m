Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689462D206F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 03:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgLHCAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 21:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2020 21:00:09 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6BC0613D6;
        Mon,  7 Dec 2020 17:59:28 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id 2so11040642ilg.9;
        Mon, 07 Dec 2020 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d/TF5gux6apsclckzpVTNaKxAFLEA9dis+4frk1pq8=;
        b=Lp3xZOvnU90orEelwO5jiL8/6ZcLYxUY5HmTT0MabClYEMaThhrQT0PUIUzNC3Ntef
         XpSh3JHDvN9nJHkxpu0CSw6yq/E/JVpEfEyjHVIoUiuduwri5B9ERA4ItuBmHR5JPojZ
         tiSn9N5+lYcDrF16JgX4M7f4LTvCmA5CMefNcclMS0sUEJCOop6A2rb62mK89Zi64mDt
         BlQFOnuebuUa1m/U8JtQkBYG/AdE7lrtHV4PcnRdWO7USgeS+Y9q3in+8kreBoOGBINS
         kdoX4B17Ku6ATHnPwN0FCNw57rt6aXb8UpCMdCvTeI2CuIwC9225T01WBNGrtFtXs70W
         WSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d/TF5gux6apsclckzpVTNaKxAFLEA9dis+4frk1pq8=;
        b=bSWxDb36LVY28Xik8KjbtJRZ4GGtYIA+iBjEUKRYUIA6ox5M6+pWC1LEwNluQRejND
         luaYBf78G0H96Co4ctkfHUaW0M6K3Y1VwPbd3etLFekRP+R67aFy8oDgNqmoNxrBgdZX
         uk2l21ZyrE3puhVcL0o3EWCcuyEzT61KdxRiAPAAZQqOM/eyOzQcupkuxR02QKebfiwQ
         rmIgFkUgJzkqL3oGJSC+PQU1vCvjvE0XUzyHhd4tA8Gn7E90KddUxj1RPuApliluH+F4
         RHLlw0XZTnQd7xidMQY+fTa1bzAsvOwhVNsNhvLMLJF8azjbXvF8InIhCU0kOejNeXAS
         Gm1w==
X-Gm-Message-State: AOAM530DS1Z22Jj7fcWhghaAqyD8BnKybAc9YnrUuhXdb91J1iy24tYJ
        tBlnul0odflRI+Yf6QRA5tWQpQBCVf80J6m4ZGs=
X-Google-Smtp-Source: ABdhPJxVBZe0/eJBKhC3CvpaB90PFYjlxh7ptPAxywB6RSg4QrOcGO7IncZMYZYiAhn5DQBYJqg7etlPXO7Q/g3LfaE=
X-Received: by 2002:a92:9881:: with SMTP id a1mr24994868ill.238.1607392768219;
 Mon, 07 Dec 2020 17:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20201205165406.108990-1-yury.norov@gmail.com> <20201207112530.GB4379@willie-the-truck>
In-Reply-To: <20201207112530.GB4379@willie-the-truck>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 7 Dec 2020 17:59:16 -0800
Message-ID: <CAAH8bW-fb0wPwwvo8P8VW33zV=Wi_LPWxdJH8y2wdGGqPE+3nA@mail.gmail.com>
Subject: Re: [PATCH] arm64: enable GENERIC_FIND_FIRST_BIT
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(CC: Alexey Klimov)

On Mon, Dec 7, 2020 at 3:25 AM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Dec 05, 2020 at 08:54:06AM -0800, Yury Norov wrote:
> > ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> > enable it in config. It leads to using find_next_bit() which is less
> > efficient:
>
> [...]
>
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1515f6f153a0..2b90ef1f548e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -106,6 +106,7 @@ config ARM64
> >       select GENERIC_CPU_AUTOPROBE
> >       select GENERIC_CPU_VULNERABILITIES
> >       select GENERIC_EARLY_IOREMAP
> > +     select GENERIC_FIND_FIRST_BIT
>
> Does this actually make any measurable difference? The disassembly with
> or without this is _very_ similar for me (clang 11).
>
> Will

On A-53 find_first_bit() is almost twice faster than find_next_bit(),
according to
lib/find_bit_benchmark. (Thanks to Alexey for testing.)

Yury

---

Tested-by: Alexey Klimov <aklimov@redhat.com>

Start testing find_bit() with random-filled bitmap
[7126084.864616] find_next_bit:                 9653351 ns, 164280 iterations
[7126084.881146] find_next_zero_bit:            9591974 ns, 163401 iterations
[7126084.893859] find_last_bit:                 5778627 ns, 164280 iterations
[7126084.948181] find_first_bit:               47389224 ns,  16357 iterations
[7126084.958975] find_next_and_bit:             3875849 ns,  73487 iterations
[7126084.965884]
                 Start testing find_bit() with sparse bitmap
[7126084.973474] find_next_bit:                  109879 ns,    655 iterations
[7126084.999365] find_next_zero_bit:           18968440 ns, 327026 iterations
[7126085.006351] find_last_bit:                   80503 ns,    655 iterations
[7126085.032315] find_first_bit:               19048193 ns,    655 iterations
[7126085.039303] find_next_and_bit:               82628 ns,      1 iterations

with enabled GENERIC_FIND_FIRST_BIT:

               Start testing find_bit() with random-filled bitmap
[   84.095335] find_next_bit:                 9600970 ns, 163770 iterations
[   84.111695] find_next_zero_bit:            9613137 ns, 163911 iterations
[   84.124143] find_last_bit:                 5713907 ns, 163770 iterations
[   84.158068] find_first_bit:               27193319 ns,  16406 iterations
[   84.168663] find_next_and_bit:             3863814 ns,  73671 iterations
[   84.175392]
               Start testing find_bit() with sparse bitmap
[   84.182660] find_next_bit:                  112334 ns,    656 iterations
[   84.208375] find_next_zero_bit:           18976981 ns, 327025 iterations
[   84.215184] find_last_bit:                   79584 ns,    656 iterations
[   84.233005] find_first_bit:               11082437 ns,    656 iterations
[   84.239821] find_next_and_bit:               82209 ns,      1 iterations

root@pine:~# cpupower -c all frequency-info | grep asserted
  current CPU frequency: 648 MHz (asserted by call to hardware)
  current CPU frequency: 648 MHz (asserted by call to hardware)
  current CPU frequency: 648 MHz (asserted by call to hardware)
  current CPU frequency: 648 MHz (asserted by call to hardware)
root@pine:~# lscpu
Architecture:                    aarch64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
CPU(s):                          4
On-line CPU(s) list:             0-3
Thread(s) per core:              1
Core(s) per socket:              4
Socket(s):                       1
Vendor ID:                       ARM
Model:                           4
Model name:                      Cortex-A53
Stepping:                        r0p4
CPU max MHz:                     1152.0000
CPU min MHz:                     648.0000
BogoMIPS:                        48.00
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Spec store bypass: Not affected
Vulnerability Spectre v1:        Mitigation; __user pointer sanitization
Vulnerability Spectre v2:        Not affected
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected
Flags:                           fp asimd evtstrm aes pmull sha1 sha2
crc32 cpuid
