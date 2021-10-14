Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE442D2F6
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhJNGzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:55:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNGy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 02:54:59 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7zJj-1mn5qo1Amp-0151RQ; Thu, 14 Oct 2021 08:52:53 +0200
Received: by mail-wr1-f41.google.com with SMTP id e12so16114157wra.4;
        Wed, 13 Oct 2021 23:52:53 -0700 (PDT)
X-Gm-Message-State: AOAM532SSmm+Qy6hmryfXy4iRaQxrz89Aof84vWpQM2oiqBX4YHzylxw
        olecC/1hWvTeHg4RYAHGLZMpjnc8xD/eR+Ds68E=
X-Google-Smtp-Source: ABdhPJzeBTr+3DEnjaiwNy7gvQWkqUGAIbkSnDvR5fWNapib2lyvZarNpPFQYOoReWXwS6roLyGXQKeyYYuevT3SsXg=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr17137447wmi.173.1634194372923;
 Wed, 13 Oct 2021 23:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634190022.git.christophe.leroy@csgroup.eu> <dbc9a149826eaa18f524635e64c207c85560c2aa.1634190022.git.christophe.leroy@csgroup.eu>
In-Reply-To: <dbc9a149826eaa18f524635e64c207c85560c2aa.1634190022.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Oct 2021 08:52:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3yAcU0JAri0f9q6HVrZwX_4i6Y9X4P8MebN_Krt-SLQA@mail.gmail.com>
Message-ID: <CAK8P3a3yAcU0JAri0f9q6HVrZwX_4i6Y9X4P8MebN_Krt-SLQA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: Define 'func_desc_t' to commonly
 describe function descriptors
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GVSGgJiBksGwahR6via+uTOHllsOF/uR48aaioKXUVo5muUi86y
 yCN5ivqvdV4uUz5JxfV/NcRBn398jwcZhXW11DDdNs/Gy4d55lDPG++yH0CRfR8q00+wf0B
 XXgnejkjArd2AaETviuSMDfbwngEpEuYXAkWYG8D/h4Cn66FD+W5T8oQRBa4AU/ehEw6no6
 yakjErJEf9GAMbQSNm1tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f/1wSMe7Fcw=:iTBAfeF4uNz4SjiqMlV46I
 fbBOujh8EeXlE9EDcdGcf0abOfLsb6KRQvt+tk2pgGXtrO7LjtHZ73FQqGU7pryE2kjedJ9aJ
 mWk0wSUZxgOILKB0/FCWJRKBv4Q3ywkt43NFK5LiDAw7zXFMQHobtAtym4gt8Q8BJIWryGgGC
 SVSjsihi5aewrvNO/87FcO73Q1eJDMWWfWeIc6WKPR+zmo2biTveWXh+P40e1gGdXpbGF6uOV
 lxkdytf+qQDU1smOXuq3oxUXL7lGsFfcyw/r7v1uJIn3TxWwEga6Z7NRcO4neFOqAVQspQbGe
 L2ERtZ5c6Y8MpXEA5TjauCU7PP8C+0gWcoMnLe3DH6eEeNWu/HoXLdlicfak9xViSgZT+ZA6O
 XTKWmwz+z7jaNo4ay1Xaprtr6DfW8QxHjacTgIVwZz3ejCCGwxygLSEBWEnuYMvaXN0q05qiI
 9ea8GAS3fkdunHdSIDk7tWY0W8ve1qpWwSxfvgYrwuvTxURPBEpwjtY5vFfndjvpkjJ8dgyQT
 fPaDWSW8e1NBdaYtPJEBF8744hpVh1XjOhollQBExdU84LLPQDQfBEUy9X71wRRcMbFcNZMFf
 JvvYVGwO2v9LquCoZlZ5Yp0c89z8BIp/tFocQybtEE++39f2KRaavuNAdq7UO64NjqrJ1czL8
 3gVt7mddX8YPPU1D1yCuWPtU6QAgRTVrlcrNsJyEfofJV9sNG9/V8bXv0BySQLEoIAGZhEcXi
 KIu/H2m1r3wx5VbY+QY8QF/GWx3UMgyuGtniruNGgOdzsF891H30CmEmn0m41Oc246butwLow
 Wh95Sq82W2J3GsIokeG70X4XXErjB7vYjKUgXYNGevbEgCzdN6SuPsQC9f3pSi77vYRihPSZL
 3uJmFsIaW++YMsyIusNA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 7:49 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> We have three architectures using function descriptors, each with its
> own name.
>
> Add a common typedef that can be used in generic code.
>
> Also add a stub typedef for architecture without function descriptors,
> to avoid a forest of #ifdefs.
>
> It replaces the similar func_desc_t previously defined in
> arch/powerpc/kernel/module_64.c
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Arnd Bergmann <arnd@arndb.de>
