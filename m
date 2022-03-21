Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506164E2396
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiCUJsu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346025AbiCUJsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 05:48:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AD1350A4;
        Mon, 21 Mar 2022 02:47:14 -0700 (PDT)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOzjW-1niHLI2G8y-00PQYd; Mon, 21 Mar 2022 10:47:12 +0100
Received: by mail-wr1-f48.google.com with SMTP id h4so1886414wrc.13;
        Mon, 21 Mar 2022 02:47:12 -0700 (PDT)
X-Gm-Message-State: AOAM532fABBkxkanJAfZPCNauoHejVllUnZlaKMU87qgQmjA3xaeECVh
        PqqRJBS6PxAlByq8h+x1icqAue1KP/fwoNz2JZc=
X-Google-Smtp-Source: ABdhPJyOugVZs0WuLZGA5S5fvh4E/SZOrX2XaObUjw113bg3VATG3qE5f/uf70NlJtAeFLbVSJkTwKN5RI+nUV2zcU0=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr17167113wrq.192.1647852867006; Mon, 21
 Mar 2022 01:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
In-Reply-To: <20220319143817.1026708-6-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 09:54:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
Message-ID: <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rCdFpqmPfHoRNRNaxUfc7r0fQcv9wGvASDzi0v1Tk9Btj28/S55
 G4RecOA35Q8EeyTP6FMkSBtB3yoxWpgQ4SyAzfpm9nOCoBWBdgYWYEy0+31VkMMx61HN1s/
 yYP+Mqrvd/SiAz4zPg5weyXLGuLlyxT4vjPQ0mvvi+b0z3DPKtYtgCj2xj68uvVVhztSW4x
 FCNi15ETYUXu6smuqmf8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sxg/epg92uQ=:ue5eF+gDBmWW08+qFfFcXf
 h83T+kssmzjynZ90jvgxYSD0o7DLi8Z2MXjo7fWY1RocC1iefr29urjy0iZAGIcqlez2win+0
 jgSswiKGZPDWEexrAlLxrrtpHb7Je4UOvs8VkqflJB7OT32gtPby6b+UxVFkJByH/xxk+Em1H
 IXoLzJurcMvjOIU6QREsMwJy0yIBSObf6GfK/vBNsvi+I4MQNlCZYK1DOvDO61XlzWGD6BgjY
 I4/KcjFGTqlNphgQ4ZFUEPNJZzTtS+CHJ0slSx5xZxn3nX1feVXNz3zDWRZO4q+NvHpoE5qKM
 PLC6sGYt+egiQ+vU5OXUCgWD6I8aRUmVlpwDHMtJ7HzwoxhhERdwwmUYCoS8U0xUvrC/vXPj+
 nnzayW9BEqsuItYZNp38NqLSMJIeAnQSdi0x7doN0/nH0ZsPzomUwL9fFw/khXCcp/GSkCq9+
 65XURyCCN+1ZtEsA/6Mh5yPZCnZMY/OeuPWBqUhaNrETThdBBM/bJvMxA8+snJXq54LhOve0b
 rRsLZc2BOt9fb8+3RcFqfWtI9q1VUHUz4dnFC4Zxj0p18yV3AHgdHtocoJndSdvjNu3a4ulz1
 AlelrsUTFDTgVlPdlDO4Q1yXeKkNeIyUP/X33z4X8JmJfm9IAiTC6BUXsKEGm/yUgbJaowyFF
 MF6r+gvDxeSfg5OpiPQ9a88OGEh6FDUNPmh1/162ceKoaO8qAQgSU6GelmLD8n7CwHo/8LlDJ
 QlhXlwf1hkhlEcEIv+6JESi/YMRiGl6eZDFhRXhduGxJ8cImQGibR/BvVMHupUbf6nDqmzulx
 EHvViHDD/BI1PA9ymfsczDFwPaz89pkDxU+YRYHJox8FWlTeXk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> This patch adds system call support and related uaccess.h for LoongArch.
>
> Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> A: Until the latest glibc release (2.34), statx is only used for 32-bit
>    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
>    bit platforms still use newstat now.
>
> Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> A: The latest glibc release (2.34) has some basic support for clone3 but
>    it isn't complete. E.g., pthread_create() and spawni() have converted
>    to use clone3 but fork() will still use clone. Moreover, some seccomp
>    related applications can still not work perfectly with clone3.

Please leave those out of the mainline kernel support though: Any users
of existing glibc binaries can keep using patched kernels for the moment,
and then later drop those pages when the proper glibc support gets
merged.

> +#define __ua_size(size)                                                        \
> +       ((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
> +
> +/*
> + * access_ok: - Checks if a user space pointer is valid
> + * @addr: User space pointer to start of block to check
> + * @size: Size of block to check
> + *
> + * Context: User context only. This function may sleep if pagefaults are
> + *          enabled.
> + *
> + * Checks if a pointer to a block of memory in user space is valid.
> + *
> + * Returns true (nonzero) if the memory block may be valid, false (zero)
> + * if it is definitely invalid.
> + *
> + * Note that, depending on architecture, this function probably just
> + * checks that the pointer is in the user space range - after calling
> + * this function, memory access functions may still return -EFAULT.
> + */
> +static inline int __access_ok(const void __user *p, unsigned long size)
> +{
> +       unsigned long addr = (unsigned long)p;
> +       unsigned long end = addr + size - !!size;
> +
> +       return (__UA_LIMIT & (addr | end | __ua_size(size))) == 0;
> +}
> +
> +#define access_ok(addr, size)                                  \
> +       likely(__access_ok((addr), (size)))

I rewrote this bit a series that is currently queued for 5.18, so you
will have to adapt it to the new version, by just removing your
custom definitions.

> +#define __get_user(x, ptr) \
> +({                                                                     \
> +       int __gu_err = 0;                                               \
> +                                                                       \
> +       __chk_user_ptr(ptr);                                            \
> +       __get_user_common((x), sizeof(*(ptr)), ptr);                    \
> +       __gu_err;                                                       \
> +})

It would be good to also provide a
__kernel_kernel_nofault()/__put_kernel_nofault()
implementation, as the default based on __get_user()/__put_user is not
ideal.

        Arnd
