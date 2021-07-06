Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2398F3BCB3F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhGFLDY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:03:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhGFLDX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 07:03:23 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mf0Ru-1lYneD1X4c-00gZjw for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 13:00:43 +0200
Received: by mail-wm1-f54.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1940798wmj.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:00:43 -0700 (PDT)
X-Gm-Message-State: AOAM533+1d9Vh2sKUYJvkQmf9jkty7IFA6A+g1KI1K/TJU/KcdcBU4UV
        vUOUI7YBwL8S+7ZA//mqJfNey1a9hLr6pKvNnpE=
X-Google-Smtp-Source: ABdhPJwfPsE0HJ0CRgOYXcjW9DwzJiD8gAKdr6d763+cI8UE14T5mhZdaI1frCtPCihOOyX8X2wDbirb/b4ppRmI184=
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr4163125wmi.84.1625569243018;
 Tue, 06 Jul 2021 04:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-14-chenhuacai@loongson.cn> <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 13:00:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1OMgEb5kyWDgDR6_C+9m9d-be_rXgKoJVXK+oaO+bFJA@mail.gmail.com>
Message-ID: <CAK8P3a1OMgEb5kyWDgDR6_C+9m9d-be_rXgKoJVXK+oaO+bFJA@mail.gmail.com>
Subject: Re: [PATCH 13/19] LoongArch: Add some library functions
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ei7I/N/2UXEFjGdR7KGN7fpfmRE3Er8Uwu49MsCbhxXFoJXlKWr
 KH7MpcgqP6XJWKBy461a2D8Ra1baSrwIE+pAkeh+YvpVaTmbR5ymtxYP3ROuSCVvAVxcrpy
 W04BCSOF8kCTBVg+a5vhE0d/NjdoTOaYkJRV3GDv2VZu1nN0VXtyy8KUqQQ9v98dU/4DEFo
 2tBoweXs9kP7Xm8ssJPhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnfhZR/vz7g=:oEA+h/a6HhgG15oyLnss9I
 8R0KiUMWXSLUfzTBfo7/jmKJNDIsoqC8+Z2WPobgH+KNpdRJTnrjcf7lgwseDQe7IdaDmo4Z6
 5d0YDh8fOEPrqFgX3tiO26hVuEKhz0jgKaTJUlzsC0qxsRcB8hW2yV3+StmqIfRi+XX4bLL3h
 fr7OIEhtYy89slhNi/J2R1oNc8t6763Wd55QHyMbiXwQsnltsV2HUkO9Brx9k3pNJPr2xLSB4
 8mEQQHRTq5rsY/W304zreoIa9Y0wD04v0aGr5UZjGg+Fn7o6frmTRlUKu7Awn008O4j93YG+6
 IlG9o8nXV28h8Qg+uNLVyGoDM5WrLrsk0CaC59w1kWcFS4OsZ1WO06mUZtKPbZo8XkftLNR/8
 qw+Z9F6Aa1YzoTCtVgAkso2mOedA1WrfLmB4sLGQC22csd8/X9j4HUxxzGKkMqCoZjsf7g9JR
 FAzhPzYOUd8QmeePzOaTV9VyYbdjeYr/y1os0XOrIj0t/3fCM3/ltKwYtBqUhlVZxqDqO79AO
 wcElxkHZsoddp92NG9np9OGY6R8NhC2wQUsRbZl9mvPgvoSvHe54KTfvqnY0EFmfVyVHcMUG7
 qrHle4TRRcpBs8HX+ZYZ1zF7Shp8gOvrcJXQBQdMtYDcEZ+LWFiscWPLMBCu+FvpUwVOXMNnD
 +ZDOvMR+RAQDkKIdXUULQXee8JRR0DzB/5zRwoHaaI8ROmKg2IesV+7L5PecISOdz6lxfrKwJ
 75sxQZq1QTu31Ya+202F3/Qn+kAmSOQA+w91ikmMtGAouYmK+pl6hyNVPyW67VOrriOA9nvV1
 ZJlY/QVXae9ExP+cI+Sx+NsmlvTXhHaDoOwztYqDj2TjI51kDWsuP98Zf0Iy4BGAznTc7GH2y
 E0ueeNDFF14QfgI8tsasklWrKaof8lob64K8zfQQSZyrJhzSE0AYVnb5NSi8V7DwsI/wdwp/T
 vrC+rOtRNnAFG4zQAWiEZK6Wra5ak2jTPm1igLUhmNOjaWp8xjHAm
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> +/*
> + * long __strncpy_from_user(char *to, const char *from, long len)
> + *
> + * a0: to
> + * a1: from
> + * a2: len
> + */
> +SYM_FUNC_START(__strncpy_from_user)
> +       move    a3, zero
> +

I doubt this is better than the C version in lib/strncpy_from_user.c

> diff --git a/arch/loongarch/lib/strnlen_user.S b/arch/loongarch/lib/strnlen_user.S
> new file mode 100644
> index 000000000000..9288a5ad294e
> --- /dev/null
> +++ b/arch/loongarch/lib/strnlen_user.S
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */

Same here.

Have you done any measurement to show that the asm version actually helps
here? If not, just use the generic version.


       Arnd
