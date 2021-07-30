Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB293DC00A
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 22:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhG3Uuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 16:50:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3Uuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 16:50:39 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTigN-1mbFMj379x-00U1oJ for <linux-arch@vger.kernel.org>; Fri, 30 Jul
 2021 22:50:32 +0200
Received: by mail-wr1-f44.google.com with SMTP id b7so12862469wri.8
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 13:50:32 -0700 (PDT)
X-Gm-Message-State: AOAM533qIE9ewxlJemQmgkToup7H/bAoLsRqOKbZcNTBP1eiMk32MmIK
        K5n6T9fuajuPETM8Bkluu8mIH95SssfvtrfiOcc=
X-Google-Smtp-Source: ABdhPJw6WSmttc95b2x6DQ9hXdSmmaa82QFTWnPh5f3dzt776aMKtNL+al5JEBjLenAr6HTIME5mHl2rfpF2eMTpNpg=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr5269445wrr.286.1627678232366;
 Fri, 30 Jul 2021 13:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com>
 <CAAhV-H7Cq10OcQMAGCODoByy+3z7_TQv9vASH0AMt+v2dtrp9A@mail.gmail.com>
 <CAK8P3a2a8R+pMZykCP5zFCPUzRqdPiBpJuCkmQdMuzL+34DFuw@mail.gmail.com> <CAAhV-H7BYczyM4Eor5T2i9M5j-xRumQwKmb9T+UH+eHt9QY58A@mail.gmail.com>
In-Reply-To: <CAAhV-H7BYczyM4Eor5T2i9M5j-xRumQwKmb9T+UH+eHt9QY58A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Jul 2021 22:50:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ccmVm9Dtv_8=NHyPfLGdpFg-C2y16nCaaT_yJAE5EMQ@mail.gmail.com>
Message-ID: <CAK8P3a3ccmVm9Dtv_8=NHyPfLGdpFg-C2y16nCaaT_yJAE5EMQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:67kjGOHZyCFtS8Yp6rpPteA2fRIUzPLxgaIsuTqDJGo6ws/iryv
 ef9ycpWl2r6F/4TO2jgJ0ut2UpX/4AcF50ToNS9afT9OZPy27T+fe04dYDLc4tsjcoZkXEz
 f8oh2p8m2/CuAjJmTffQLvf3uNk/TbYTgiuIfqVS6bc0qQUA8wBv5JxQ4iDkPBohbkaF+bv
 d89qRomtthfgdA/BLbLdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cXZcGsB3AvQ=:ELiYN8VTxPeFHT/QS8qRHE
 Pa6a1lk8aW6hzZF9nkpXVBszI55MRouvBdmtsvPdsgFUE6Vg2UZ44VXDxRtqZEb3uqHJ7hZdC
 3j+tzFcd4t+aWlwgwpZcFzVxFDxGf3PC4aFqQruh9Y4jgs2bC37gvOGM1n2urS4hPhbdYtvOv
 dKD0xQueCz852DmR+QJTC1uyk+jseUJ7NWgORARm1zcIBCD/1kLiXxfjiUNvg26Eq4Pwq9QlG
 7LzN2ADsG7+PZMZ6st4yQJ/ExwVUxOZVJokFnvATaB7/n55ArVrZ1oEf8tGrlOh0Cz+LxYJwx
 qQoe+MbiAqaN/ttFBhuaWbxLW7UxBN2RZe2tDXhfc+bcyzjkSjbcOhTMPsX/Ii3PXLQseAdGf
 9CrgjvqXte9o6vB8/SZKfk7NgJvM1sjKwPq44v6/49bLVLE22UAIdrADeOKvYj9BZiCCKNtbV
 lBl+/WAtONzNW3S/XlHCxkG/MtN1W4jQhrIH09d9V4euAF7XJsTXhSKfieifCa4bU9wk2K7Wh
 NIvdfLGAuyxrq9ZqXfeK/NBVPG175tHH1KNY9k+BAtZihmnd7s+FFTSx2nWutmLigi7MKsRdu
 9+SjpQtOfVFMPb4u7qkePTiDAxcn4CQ+T0TVQMoe83RFCDdehN0U2l9J+k6eLfCWZBmMpr77A
 740AJ88do00ZUAOZobMBtkDKpFq/eNlbT+TjVrgOtFD4K8QmLnJcljerW4bUae6uUMFb/3CTM
 bKAErDmeAmA4WHL3KupkbYyLzvJd8ZkE2lwQ5IYSKS8auP831lBlTHLqx40iVQQkB0jO/NOf3
 EqxgHJfWv8xGZm2Jvq5EC19DbPvsKUviDIBrMARTtXSHJouhwvkWBZONF3r81Tm4XiI5qs/fj
 hV6RrOfxCmf4KrvS7quXxsRzmLfIbYTHw6x/PGuYQWZEUoBNwe0MB22ipLL4c1/1pJT6ISTby
 Tky1nz6owT+lQ2pjs46vPWKH8kWgRL3J/5BnhSxH6WGam90+0mq30
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 6:48 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Wed, Jul 7, 2021 at 3:28 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Now toolchain of LoongArch is open, please take a look at it. I think
> there are also something need to change. In order to reduce
> compatiability problems in future, please focus on those things
> interactive with Linux kernel. Thank you very much!
>
> https://github.com/loongson/glibc/tree/loongarch_2_33
> https://github.com/loongson/binutils-gdb/tree/loongarch-2_37
> https://github.com/loongson/gcc/tree/loongarch-12

Thanks a lot for letting me know. I won't actually review the code since I'm
not familiar with the code base, but having gcc and binutils available
is definitely
a requirement for the kernel merge.

Conversely, the glibc bits should just follow whatever we do for the kernel
in the syscall ABI. I have not built any gcc-12 binaries for
https://mirrors.edge.kernel.org/pub/tools/crosstool/ yet, but when we get
closer to merging the loongarch kernel portions, I can take your latest
snapshot and build that for all target architectures to publish there.

       Arnd
