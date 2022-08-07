Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3B58BCC6
	for <lists+linux-arch@lfdr.de>; Sun,  7 Aug 2022 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiHGTpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Aug 2022 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGTpE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2022 15:45:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F86595;
        Sun,  7 Aug 2022 12:45:01 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MF39M-1o9npk0ViK-00FQaf; Sun, 07 Aug 2022 21:45:00 +0200
Received: by mail-wr1-f43.google.com with SMTP id j15so8756237wrr.2;
        Sun, 07 Aug 2022 12:45:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo0A+KoRx3q3Wp/u2DQDlVnMtbPEDHPR7gb4N4F5390/sXawfe4c
        ecdat8i37xRFnJ/V8EEZVv8QTP+orA2unLgOGfE=
X-Google-Smtp-Source: AA6agR7WvYipqruEUqI3FozO1bMoMLoFg3gTNr1wJxvZ4oY3kYpws83YatqbI24HkVKiWoEkfQMs1s6P8NVFSqcphg4=
X-Received: by 2002:adf:f5c7:0:b0:220:6871:de96 with SMTP id
 k7-20020adff5c7000000b002206871de96mr9685215wrp.516.1659901499836; Sun, 07
 Aug 2022 12:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220807172854.12971-1-rdunlap@infradead.org>
In-Reply-To: <20220807172854.12971-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 7 Aug 2022 21:44:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FR2ySLXAMGR1ZmaAQMbVwB4MFBPvBw4py_pbgtQSfgA@mail.gmail.com>
Message-ID: <CAK8P3a0FR2ySLXAMGR1ZmaAQMbVwB4MFBPvBw4py_pbgtQSfgA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: unistd.h: make 'compat_sys_fadvise64_64' conditional
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4scA+1HwMxDmsAX+s/8yE08CJcWhocK0NJmrHYrCpksk6iGwgOD
 5axZLbkneWAJ20I64jSecMw8LlnWyOKmpoAlvnvyMb2gK1b3niEqIGieJk+v7d1VBlfSyi1
 S+W8DyS6RYG/D/NhQqqbYxjNvvAhvBNmiXf82gxk6zjPlI414jB04P276Mk+PQ3mF2+7keB
 CyojIQ+S4qxh0c91zlh3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ND8riM6tqxA=:4nk58cscHxwtirsnEDOI9t
 xYH46FZr912/XmSU4u+4YMibpTlCFm8NdT1jV+zu9980mNgQLU5LHQ5Gwsh2s726LMbIzXiSB
 bGvSr9tW/ryZ5Szn3giGKms0gAaYGUMEuLXgLfWKFLaSHhZJMKf/dl3DOwKMR9kkekDOxJhmq
 MpLTRWnR8tEpqX6BYPrfBsknsjWAt/lyOU2sLUP8zLtwkFsD3+3E4xIWPSe1etI4dOxHy9za2
 ydAuiPtE8Bm+3XTNSJhqbjxIhh2DAeFGYxE0mLphgsRoUIYGGPYZFTm39VvPrxWMFF/tH7iOi
 +0G+Lu+qGAaG4k02v6hHceBf/KMPGar12BlrisXvr7kkd2lsVbBF0J8zm6GdrKY38Pg/O2zUu
 QuPLXWRFP34L3qWCTxg4UzD0Rik1770NpWsVnflyh7RnDLrtqyklX8Avwy7SWzFf2h9WPo9oX
 3j/9tt6ASjJUY9/aWAMxqVpBlDnoqPjP+EZF8S5fBXPGF/tcpkNKZTb2P9MLOm/Dcl0yLEKnp
 tiG9zPBF8RmsT13dTHVSolDWTFIntAwaygaPLIIVSc83eg4twgJ0UIeHrL5DaSw7XY+wuPjYn
 lRuKq4AwpUm05YNert8dUglAcmZNpY617zw+DI0MCT3xXBvLKBfy7VirnjDRjRxfp/dNOTH2B
 cQeLD2sNjHsaa4oj41Lk7+0QLj+tPeaaFUqPIcMdZ2tw+l8/WwrqF8PhYGe5px7mESyCmggTb
 ZFhUNKcJFWOBN7ykDIe/PBOh1wcat2oIKnIirWHlb5ppOl2I3p5FSURiqRC1TLPxGL8c97XmC
 l1ISFFjcVN8Ler/MELOYlGEPhntDCu9X38QbLlO+nvA/x+kIsIqLJzHQMpVI4VSgOaiUMRNQB
 mMaHpfZB6WCcreMVv+6w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 7, 2022 at 7:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Don't require 'compat_sys_fadvise64_64' when
> __ARCH_WANT_COMPAT_FADVISE64_64 is not set.
>
> Fixes this build error when CONFIG_ADVISE_SYSCALLS is not set:
>
> include/uapi/asm-generic/unistd.h:649:49: error: 'compat_sys_fadvise64_64' undeclared here (not in a function); did you mean 'ksys_fadvise64_64'?
>   649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
> arch/riscv/kernel/compat_syscall_table.c:12:42: note: in definition of macro '__SYSCALL'
>    12 | #define __SYSCALL(nr, call)      [nr] = (call),
> include/uapi/asm-generic/unistd.h:649:1: note: in expansion of macro '__SC_COMP'
>   649 | __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  include/uapi/asm-generic/unistd.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -645,8 +645,10 @@ __SC_COMP(__NR_execve, sys_execve, compa
>  #define __NR3264_mmap 222
>  __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
>  /* mm/fadvise.c */
> +#ifdef __ARCH_WANT_COMPAT_FADVISE64_64
>  #define __NR3264_fadvise64 223
>  __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
> +#endif
>

This does not work: __ARCH_WANT_COMPAT_FADVISE64_64 is defined in
arch/riscv/include/asm/unistd.h, which is not a UAPI header. By making the line
conditional on this, user space no longer sees the macro definition.

It looks like you also drop the native definition on all architectures other
than riscv here. What we probably want is to just make all the
declarations in include/linux/compat.h unconditional and not have them
depend on architecture specific macros. Some of these may have
incompatible prototypes depending on the architecture, but if we run
into those, I would suggest we just give them unique names.

       Arnd
