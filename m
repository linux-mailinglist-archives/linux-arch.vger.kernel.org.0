Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35A9430BC6
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhJQTlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 15:41:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJQTlR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 15:41:17 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrgcU-1n5yqT0VTo-00ni29; Sun, 17 Oct 2021 21:39:05 +0200
Received: by mail-wr1-f48.google.com with SMTP id u18so37357903wrg.5;
        Sun, 17 Oct 2021 12:39:05 -0700 (PDT)
X-Gm-Message-State: AOAM530CGSPmo09aVMZhGeme50XGUj6xDIOMG+QOO2C6MxAsNc0y3y9S
        5MuObOif4hBsMCNUboLGaBNNWhDrCrDo6BkxdkI=
X-Google-Smtp-Source: ABdhPJz5+Je/J0Is5f2zcgCsNreFzyPUIKhSX6FNRyl+A6AdSx8zttNwbnS/mVxRD1V43yOgwRrFUisC7cXMxa19sXc=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr30368956wra.428.1634499544806;
 Sun, 17 Oct 2021 12:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211017174905.18943-1-rdunlap@infradead.org> <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
 <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org> <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
 <fec67616-f1d0-08da-f393-489233210cbd@infradead.org>
In-Reply-To: <fec67616-f1d0-08da-f393-489233210cbd@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 17 Oct 2021 21:38:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2PuTe2h49n72Z-GHnn_wyq-naPm55LJJG+OnCdSLz5tw@mail.gmail.com>
Message-ID: <CAK8P3a2PuTe2h49n72Z-GHnn_wyq-naPm55LJJG+OnCdSLz5tw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VGrMYAheBxWuNlCK6yWFhBa/u90vqPVtv4NhMj3sZFEheWbVlZS
 I5QPKygZX4h4cs1SpehcTXK6r4gXvEzRHY1Kkc5JqJr1zoeSoiNWvXnsGOnebz6EwL6ZY59
 Qw+36KeNLybll3nS/tD1NpvIYbdtJ2j+3WoM8d+CXjmyYbT80JifRLO861iBnFrs/ZRIYvD
 YBHLbft30a/Y7mr2LqLKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1LpyX8E0Ui4=:1bVMabMYnIgLx/EagjCUGQ
 Q23HJFJawgL/6pfn0epNxB2yUwY7VOcwuanJqYEPRy/65BLE3ossmRSv1NPYcqkzlntNmktJN
 XZSnXIL30+OHaZZrjvf4N/wE+wgmexgGJKcW2OeIp0mrlHUd0g1BoPUtlXlCR8dxzvgE7XVBn
 WFRqLPFI0+1JOqA9hjKoxOQqBBwX/B4qTSy6Fv2bJT6y09HSVzgfuTFHqG8PjfUI1bHoCn0ek
 HuXZp4rXdm6ceSG2e14+YhnKpPIAYhJOiMId2V531/MAdAXNqUEK5gJYTHpbygGd97B3PD3Vz
 Q3GEdjuQrGk+JIjkR9gRZda4Xv9xrEYVdAmretjPEIqM+KQNkQb6bP4RyoyauJfnf2pNvX6Ty
 nfdVrWJRIl2due6s7V57YYBCIKCiQNGn95Wi0cXj2crhMsLinf7knwSV0bPMII7G0Fb/pefx4
 1IrnHaFTJqsG2/QTUewdr9R0HAIiJXs1rIuOWeTDCM+dVqlj0YK3BV/IjghH2eHJ2lffjojGr
 HPjaMSXt+9fEdq0M9XXvtwLjdHIm6Onpp/Ra27Js4Vuh5lYfMh+0CUbJe2AbhXVTpbZVnHjfW
 5esvBs/UowencSvGwBMK9DZ1nmDoOWjwmqIi9f4S/xfOt446rwOj+vC8sM0xK+VW1FbzG7NnH
 JB7ueUaMANLJtHaOFBFkn5fFHL4+NydjMooHDEd99N/6LE7WWcZdOavwqIuDag3f5jDs4wKb6
 y3iAF9ejkM7K5RQCVuBr8aH+Kv4xyY+zUPscFMkqbASf1AuR+9ybnVV/6z1Qbnjs7yRtsZ580
 gFnbg8KYwzDQoFLPCnN8JXz5XB2Y591fnv+6txqlu1pOHByhECU+9EuXLkZLZogAQ4YUczNvA
 2sDGPolvqFa4bRZVC3Tw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 17, 2021 at 9:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/17/21 12:24 PM, Arnd Bergmann wrote:
> > On Sun, Oct 17, 2021 at 9:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 10/17/21 12:09 PM, Arnd Bergmann wrote:
> >>> On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >>> Did you see any other issues like this one on m68k, or the
> >>> same one on another architecture?
> >>
> >> No and no.
> >
> > Ok, maybe before we waste too much time on it, just add an extra
> > return statement to afs_dir_set_page_dirty()?
>
> I think that patch has already been rejected a few times...

Indeed, this is one I had looked at before:

https://lore.kernel.org/all/CAK8P3a3L6B9HXsOXSu9_c6pz1kN91Vig6EPsetLuYVW=M72XaQ@mail.gmail.com/

It seems that this version:

+#define BUG() do {                                             \
+               do {} while (1);                                \
+               unreachable();                                  \
+       } while (0)

ended up being one that didn't see any objections.

        Arnd
