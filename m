Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860BA1376E5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgAJTYT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 14:24:19 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:35603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgAJTYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 14:24:19 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ml6du-1jWmM93TQ4-00lUgy; Fri, 10 Jan 2020 20:24:18 +0100
Received: by mail-qv1-f41.google.com with SMTP id o18so1273662qvf.1;
        Fri, 10 Jan 2020 11:24:17 -0800 (PST)
X-Gm-Message-State: APjAAAXfCtqtVZa3zweztH807mcxq5nVQsUoitn16oXtfVsKebOMzTrf
        szWHIc2WM5zytaE3TI9HaOfEazifq1jEusyoX7w=
X-Google-Smtp-Source: APXvYqzd2hmstZ9l10zTYEs+f7uDdN5MQZM9KWvb/cNLE8AYGII20Ive9ghFbtq0MLUH74D2qPmefmOPczx/DA0uGUI=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr152872qvi.211.1578684256605;
 Fri, 10 Jan 2020 11:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-6-will@kernel.org>
In-Reply-To: <20200110165636.28035-6-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 20:24:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
Message-ID: <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/8] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ev8K4YMvcdYPml3GY3aO/4/vuWKU7cZbfJmipe8dfz3JyngSvju
 Wv4NNUmZTSTTyU0E16+aJt3syYAiNy3NWp4ERPkdTDo0mcHbhhZZv7mzbn+HbP40vcFYe1Y
 KyQDlk1l2GqNLVtLXUi6HllsgidHr0AqBMLVu3JZuM6p9cQHJ/ZWPq0VndUsN5NcUld4iox
 S0AHYQQR99ROxBuMmdKMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wpkyqc6zofw=:ToNUCGqkTCirKuUdME33UK
 IhZ/Fkyf/Ux8dK5ivs4y0WMR76cYYUvMGSzo0GAV8rLea90c05nx/SWquKF3LtZ2glH2xfhLI
 kAPTK7CR1X6RoQQMU59O45BGJwyFnTR/BKF5sKjfoopx/hnTLeQYQGRvn13Wza3ikm0vtxHKJ
 fps6FiEoW45Vf3LGu5B00LiwN/k2pzFCMY0O5X++CXTaVA5lrCEtyzvM0m/7YgaszGwvtJphO
 jrlGo2YNinYzumLXEYjAHxavFHLZoSp/1/X++lEcGUsJqOpbPbEvkBMjo9gcnVzhePTv3NqBF
 uV3l/C6odOTgdyWJ8ThVJLd02EVEWLCNTV2TpFzZnEE77yCxjlO9UoQ0GBII1zLtKa3Ah2zlm
 9XdyEJ5x2C1vz07TsIdTBC05j8kgm4plJsw4Q1bgVNh0UuiI+Tdhxtxyg9jhc9CZprmgdBzKM
 zy+EzZaoEV9U7aSkRQXr+tepXgNU7ZaMIDz+X6dpTrPVT8Tl44q7meUf+Flv1BMSjzoi4gTGd
 jlc6G/RJB+CDa1XNux+SN1VTYnB+vqNMFfnb5xGkFNLIiS1YvzTroupdI7AaBHz/PlOsbC8Ss
 VrBwj1Y+rV5ra7k0cYfT/0Y2cCZiJ4xlXi17jk0CA4ooH8YRCagawtftvS5jFoKeI/iwbd/Yr
 hX07tjd+pRUtWpNF/OJM/7taBcDcvdwjKE+ruyQvdbctR1F2oH51k4U6zLSx/yqWEAkJiB3Zd
 VZDHwBswTCCzW+D/PTdQcsPUP/1wbXi0h1Xn4dU4x5GjnqKW3dl7iTpZi6fRiD/02LosMgiev
 ZdqNQV4UlnOUA31tU/tGLzXuuHGlIyRA0D3Q6KN+1K8MT+sGke4itjh/JndDYKlHhb5BjnZpb
 MYZvSJlBKUu2g6XzrbCg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:

> +/*
> + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> + * atomicity or dependency ordering guarantees. Note that this may result
> + * in tears!
> + */
> +#define __READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> +

This probably allows writing

       extern int i;
       __READ_ONCE(i) = 1;

and not get a warning for it. How about also casting to 'const'?

        Arnd
