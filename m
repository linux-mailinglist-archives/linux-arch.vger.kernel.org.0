Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA733A1B0
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 23:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhCMWfX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 17:35:23 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhCMWfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Mar 2021 17:35:19 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MnqbU-1m61rL1EV8-00pL7m; Sat, 13 Mar 2021 23:35:17 +0100
Received: by mail-ot1-f44.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so3304081ote.6;
        Sat, 13 Mar 2021 14:35:16 -0800 (PST)
X-Gm-Message-State: AOAM533WI9i5zO7Xh7Al8BdWsD+1YmOGiCE2rbhSTxMrGSvBndYGMNcF
        W7ChQaG+G50w8gF5+vJX6CHqFgkJRoWQZVZPk1o=
X-Google-Smtp-Source: ABdhPJy1hCZSOZgjWjUIiV7y81YWmhIh+++bR5CYo5jf0Rk/VdQv1W4rLs5PJp++TQ7iq07uGhi7ibXsnePfk6JNHFs=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr8850529otq.251.1615674915810;
 Sat, 13 Mar 2021 14:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20210225080453.1314-1-alex@ghiti.fr> <20210225080453.1314-3-alex@ghiti.fr>
 <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com> <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
 <CAK8P3a3mVDwJG6k7PZEKkteszujP06cJf8Zqhq43F0rNsU=h4g@mail.gmail.com>
 <236a9788-8093-9876-a024-b0ad0d672c72@ghiti.fr> <CAK8P3a1+vSoEBqHPzj9S07B7h-Xuwvccpsh1pnn+1xJmS3UdbA@mail.gmail.com>
 <50109729-9a86-6b49-b608-dd5c8eb2d88e@ghiti.fr>
In-Reply-To: <50109729-9a86-6b49-b608-dd5c8eb2d88e@ghiti.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 13 Mar 2021 23:34:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Nh4KUD85Fg_vFHf2fLMOqZThBgzyduLgfEtjGf-pm4g@mail.gmail.com>
Message-ID: <CAK8P3a1Nh4KUD85Fg_vFHf2fLMOqZThBgzyduLgfEtjGf-pm4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:V+OHT2A8p0Alfk/QhAkFqphd5ZJSQR+7XtNqCvKUrqFy2NdWyll
 1qyVMptACR8kGCItDWu42EsGarUVRu8pIE0ZnUB5cSZvEkKQqFXcnrKz134USgs+viQbWKJ
 mMi0e7LRvnelcW0IYeLDMb0vWcJDxKzl5IxVCwaUT3kvkekMBcgcAAIwpQVPjAEjUPtfeCN
 XO18VFbP/Qi3B4xjXJa3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+AUsDVhfPHQ=:49MT2eZT6ouNXqMnB8iHch
 g6HuERmaOBO5ydi+3dCNx8RQZ/gtCCjBIXcSLuh4Ce9kslxhjrtn7kWiGfdQBY2S+/0PU77jz
 HUyzKdvaHO9onY7RR3/lZtnqZgu+TMuzlzeIRDPy7JPGli5wpvJa3VF9CD0awg6kfa3GFJjBp
 EQ//N4tkMTnvVxLBKyleHspaeFxLgmKcmbJr8fzAzOEnyJ6W/nbIIJ3+6WWQZmwWXFb+StVSf
 krVUQVWBicfTwN6Kj9dL2nT2+GPjhCs3zDN1QtV0WAsVLQfHdSpxtFcyxdM2F7qMowRuoFtb3
 rWq+T5rEwu4DaqTXzroO4n+ry75VL9VjRYzpqFEf58teCKhA4tauHy4lcXvyfERJSjDDsf8BJ
 EG/mGZ6VYcmmbfhSDC0sX+/cTKhydnk811OBHTPPV9vH91YEmJJB9S+Grs09LDprdRoT/AqU8
 +Bg9hvkoYsoTHdValZBTyIluWUwUKD9+TU9l2zxWqO3Fz2lx0fjd5TTKJ4ZOOrm8koJuag95D
 PC1JQsD+MPB0HGDnDcu/po2UnUmIWhvYgX8xZSm0/ujvUnsHnZOr96/JToFOHAKHA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 13, 2021 at 9:23 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Yes I considered it...when you re-proposed it :) I'm not opposed to your
> solution in the vmalloc region but I can't find any advantage over the
> current solution, are there ? That would harmonize with Linus's work,
> but then we'd be quite different from x86 address space.
>
> And by the way, thanks for having suggested the current solution in a
> previous conversation :)

Ah, I really need to keep track better of what I already commented on...

      Arnd
