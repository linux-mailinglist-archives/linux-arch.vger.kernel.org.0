Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0B23481F
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jul 2020 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgGaPAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 11:00:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbgGaPAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 11:00:31 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplTn-1kXnTk3Bm9-00qAKt; Fri, 31 Jul 2020 17:00:29 +0200
Received: by mail-qt1-f175.google.com with SMTP id e5so9099225qth.5;
        Fri, 31 Jul 2020 08:00:29 -0700 (PDT)
X-Gm-Message-State: AOAM530kJqh/uBPlz+0h/6gXvGLDfMocQXbevDbSmuid1LGnzijd5BJJ
        tytiamJ6CuvqaLfq/xUKxzmP7WWnN9U3zmTjxCI=
X-Google-Smtp-Source: ABdhPJzO/erL08bCGwMduOM/V0DeqInBOr6E8Io9U9J6HsgWZw3VlesVETo5I46uVVvCLprU6rHevJnFSzTp7PNQoVU=
X-Received: by 2002:ac8:5195:: with SMTP id c21mr4078600qtn.304.1596207628426;
 Fri, 31 Jul 2020 08:00:28 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Jul 2020 17:00:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Message-ID: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Subject: [TECH TOPIC] Planning code obsolescence
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R3dzn0u/Cd3SGlckPr69i1hze7Sij8F+F4cJtVcQQJX7RIecFRV
 JLchhzub3y8jChdZ/pkrxWadkHsxSwmuDIpLKOH4Mvk02VQHPcQBkMFqq1c9WnNMuh+c45i
 bouL7OjOxs7gAbA0A+YPOyBqgBFljQL5thSvn//rEFlsex1WeKZyL/Bv8bbrOiOv54n4Pv8
 p8w+QNnBEUceq2mScju6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1eAfryoAUxQ=:78/KI1B6k3qbqS8jeGx8Yh
 +wrv4KgMtaVEbMm9899DGxEl5FgPqAJtBERZj4bcXqzINyGPwuSZlkWd9wpxEhPuXSHBzDXfD
 U/qaMQpigwpgWy2tOBoeGU340YYBlnSGKoh94gSCUY9nuGnMePZRUhZzxqcxlOXpvTQ1z1jVj
 9qs8sTIE1lZAgnk7DivAgRHJuLRxEMo/HOXW63MCYiR/z3+O7C2yZAgMw/XfnbFa24PBUHYYE
 FHdX3yWRYhjK8RzaIwOyEgbcVbiByAlqGSquu9qMS2QCzxTRc2v2UuTRZmjy7g9FFA6M4mxnf
 D13viQRUj4yUClAoXhiXF6pbbK+rQ61In4wNjIuhAtTkycZh/uhqGKOMXRV4NzSdJ0LvHiFzD
 /4iquJFKSnp5OIgWV2cY58YUgtW6fqx5NVxz26XfZvlPuz196KJugE8UAMVzT7m9D9yHRAm41
 7G4fANCjLqN+1LF2xvPKJ4r+XGDaxST+h4+UVtUcGo20bjNR0XayMKDVUCvFybFrmW8uKFVL6
 0ZjKDvvj/0jdq/W12dAOEJPLRDFmq8vbSviGUagOCoFr3Y6iCfGiDU6DZNSruPBDGEUmaY8a4
 DKiJ5ZLokwzh6RU0igNRIRJs7RdzhhYWfZl4DgiTNPsVuvbnTjDUQxxcSN63k/ofjneq754+t
 RkT97YeQLusme7lNEl3litAd+ScIuUpVGEBzUU+RxLj0YzbrWJjDfqsReF+PCd3jQpxhIpCY6
 3IrU8m+rOcL0s/SU9x/w0FeDpqPkt7HVEaEH604+HS+B24q66vvGYY9TXkNiBs8S9wCcGXf7e
 UVmsnflDKkZSzSd8V83WJY/G0Zietc5/e6ozBNxFkTigRG3yoTzdYjqnahC7j+pUo1DDsu1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I have submitted the below as a topic for the linux/arch/* MC that Mike
and I run, but I suppose it also makes sense to discuss it on the
ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
even if we don't discuss it at the main ksummit track.

     Arnd

8<---
The majority of the code in the kernel deals with hardware that was made
a long time ago, and we are regularly discussing which of those bits are
still needed. In some cases (e.g. 20+ year old RISC workstation support),
there are hobbyists that take care of maintainership despite there being
no commercial interest. In other cases (e.g. x.25 networking) it turned
out that there are very long-lived products that are actively supported
on new kernels.

When I removed support for eight instruction set architectures in 2018,
those were the ones that no longer had any users of mainline kernels,
and removing them allowed later cleanup of cross-architecture code that
would have been much harder before.

I propose adding a Documentation file that keeps track of any notable
kernel feature that could be classified as "obsolete", and listing
e.g. following properties:

* Kconfig symbol controlling the feature

* How long we expect to keep it as a minimum

* Known use cases, or other reasons this needs to stay

* Latest kernel in which it was known to have worked

* Contact information for known users (mailing list, personal email)

* Other features that may depend on this

* Possible benefits of eventually removing it

With that information, my hope is that it becomes easier to plan when
some code can be removed after the last users have stopped upgrading
their kernels, while also preventing code from being removed that is
actually still in active use.

In the discussion at the linux/arch/* MC, I would hope to answer these
questions:

* Do other developers find this useful to have?

* Where should the information be kept (Documentation/*, Kconfig,
MAINTAINERS, wiki.kernel.org, ...)

* Which information should be part of an entry?

* What granularity should this be applied to -- only high-level features
like CPU architectures and subsystems, or individual drivers and machines?
