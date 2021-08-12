Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0B3EA4E9
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhHLMvo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:51:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhHLMvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:51:43 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqrsF-1mrdju0mC9-00mtkW for <linux-arch@vger.kernel.org>; Thu, 12 Aug
 2021 14:51:15 +0200
Received: by mail-wm1-f52.google.com with SMTP id f10so1294197wml.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:51:15 -0700 (PDT)
X-Gm-Message-State: AOAM533h5IDv5h1Ubgl4zsBZEvDRPE5ganA7BoQteGMPkOd41ke8FRBa
        LDiNzK6y13blbhcQLmBsotBarqmzU6T20AmtYJ4=
X-Google-Smtp-Source: ABdhPJzy7rdTuQffGjVtpqv4ervMJO5Rg0XP9IWb30hpDi0yZfpShhKxp936NQoFC06rYgeoVnboGKmUq4oKX7gmfU8=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr14965600wmc.75.1628772674836;
 Thu, 12 Aug 2021 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-20-chenhuacai@loongson.cn> <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
 <CAAhV-H7y7z6HsxMYbzAmtjfEOHLcP2+emm__9ZjNoy2Hk2xjkw@mail.gmail.com>
In-Reply-To: <CAAhV-H7y7z6HsxMYbzAmtjfEOHLcP2+emm__9ZjNoy2Hk2xjkw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Aug 2021 14:50:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Wx3+cVdMBqYEdcQbvs91SQVUVvuSDeTD9wxAAe4XaoQ@mail.gmail.com>
Message-ID: <CAK8P3a0Wx3+cVdMBqYEdcQbvs91SQVUVvuSDeTD9wxAAe4XaoQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] LoongArch: Add Loongson-3 default config file
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R6DFK3RYehXGmpXG3P8mx2fCYELupdhQ83AZGJqmeZH8GrbyUil
 Q1Tr1OgTV0gthyBxkT4B71MLCPlsjgMNMg3hFfkFioMEsXJ8tDjYFNBpQNoz+hC8i+I0f8n
 YCxPW/E9TDOUxWC61XiaYOsEmoMhi3XBmf60zkASLRX68sCxba+m4LcUprgguL2gc11XPNo
 uJ1vtgbW1YbwKKHOykXZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u3WawHQRrZA=:mgd0ho/zj47k5GOnoHjKsv
 ekvJpSsg77buRV3fEaWqJ7E1Z6kAqLjw45y0qrlFpTugrkkobkIJpox/7o1dMi6Lu0jwOHlmw
 DvVpblBsqGSUB10UvLnpJtUQ7qeRNxq4ZLqXUpKHw36UNKbpLIkjpq0e8UxsxOpJrvqMgxdKT
 2T5o8ww7NMRMXegRgoy3K198aVDqH2B+Ur52th+c9Di/yz4kRNmceHsh/cwNTbE4n7g2B+xiy
 7Fg/zEqbIe/rFK/3Cqxllt1HUp8gKDXPDuU1rM0fsBvFF8SDnQOY6r87rUiddx4/pR6KvmMBz
 NrytO4DXIN1CPgE+6c8+CCkuT+/6PuhMKbtEtQoXrOCAizYoPk+Dn2j9DuBK00IDIJ5xy1h7A
 KP496Njeo8h3H7IFxDoCwaru24+wmOXNkToMUA43osX/KIHi0Co8U1DEhMlMRUjop1UCWG1LT
 oT0hdVEWAJ3WYoLef7WHsFN7v8JKFbJEctt8LxpR9tgw8gH+CbjbdytmhYSwOlaZItUig3hyt
 4KFHBCy3SzdqrJIOkTuEEMaX8JRzn/E8/rrq2vAMaW5lFqvCuv7l2a73WJWQ1Wp7O4lRGD6WX
 LkqlnD9kph/LmJJIEIhY3prfApmar68D3As/zjbfKkljU9FN9W7C9bb7wgDITW2fRpmEyZa3G
 G1Gw/I/V0bP4lJ8LEKDaeB8VqW+ZMgU3ZGM4rpUusiKVdZeuJkNwpFrj9zOpcd4CKqpxEmjJ8
 6U6UFzZOIjX/2+dbtVpWG3N59EeIm5uz0KZnmy7s7j80mqsUNZPzGFasoiwsp3RdiKQtvHmug
 XcOZdgk5HRcM3DGqyAj85OsxgIyl+E/j/xuHGEKAjgX10HZY5BxlljgxW/OFwphex/QQpu6Ui
 q+ed0wWfLT1pSK0vmTK1bav9JfehllDTt88rHeBjhm0xnJDhltpckf77Dj183iINgh1NgHSq0
 2QOItWM0BZ7I23oSOVjEQRBVkec7RXbCWGof8SaeGCuZSH5RhQTQK
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 12, 2021 at 1:58 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On 64-bit platforms, you probably want to increase this a bit,
> > otherwise you get extra warnings about code that works as
> > intended. The default is 2048, but you should be able to get by
> > with 1280, if that lets you build a defconfig kernel without warnings.
>
> Most of your suggestions here will be accepted,

Ok, good

> but PARPORT and PCMCIA will be keeped, we use some legacy devices
> with superio.

I'm not sure I understand yet. Do you mean you have a superIO chip that
can support parport and pcmcia, or that you actually want to support
devices plugged into the legacy connectors?

In the former case, I would still recommend not turning on those
subsystems, it's easy to just ignore the capability of the hardware
if nothing uses it.

       Arnd
