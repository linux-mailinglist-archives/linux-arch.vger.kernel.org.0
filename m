Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A230A7C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgG1Mmh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 08:42:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1Mmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 08:42:37 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9MlI-1ko7Me0HB6-015Jcv; Tue, 28 Jul 2020 14:42:36 +0200
Received: by mail-qk1-f180.google.com with SMTP id d14so18383589qke.13;
        Tue, 28 Jul 2020 05:42:35 -0700 (PDT)
X-Gm-Message-State: AOAM532xR0yaFjd4bosS3E+dYU04hNP8IkCcgmVok0kYRbiwIHINxnnf
        xmdE6V7iPPKM9YjSwocgy3tiYQMTxBIC+r5YH+M=
X-Google-Smtp-Source: ABdhPJw3K3lvAgYAGemxdtvcTTa313hHGShCGNtpEv9UT2n69gfyTUSK1mtIz0h/zUJQYI9RNcSKyp+FbIUCGKG3RCM=
X-Received: by 2002:a37:b484:: with SMTP id d126mr27679043qkf.394.1595940154887;
 Tue, 28 Jul 2020 05:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 14:42:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
Message-ID: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
Subject: [GIT PULL] asm-generic: bugfix for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:x3nttk669UjzwEn2hDNj3i4LS8B8RF+s+pHwbjCJLlNvssgNla+
 oSVCg+hPM33wPIM/ff53c+YmNcMp7v21JnHRNoiPiujLS0/NrY7eJ8NJ9zTDlw/uKbc4zlH
 jBnFsgBJ4/Mab5HZYiDBzgFxDqOJhQfMIWRz7RyQDAkgLN32nIghrtsax1NaxrqTt34Lucm
 I+sWzcDczCtbcB3k4Xr/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2PRq9Nw7vY=:dZI4iNpszFeu1srXpxZJiW
 PUEM+SFWHJovNF+lu5oFfQ7FtljQACstGq4+9wAxbGE18MupWtS83lFOPZg0WQm5MgKsaGzQb
 yuX37eM0FaL37cuvX70bTqmtASp1EwqYsWBu8CubKn/+IW3jVPzTMPs2n7UBqnpJSR/TfX0eM
 V3HEyyHW//zSvtItuemGwc6aGQLBgIAcmN2ir0QHcePREm0v4ta8a2L7fsjL+YXDsg6FEb8lb
 sq9vU7uqAcAYIzy8SSVGL5W8MiXFRcH0VwM7o9qQ3f5dqCMVA+ZVuewmyG6u0fTPjGikATAYl
 ojc+f3LZiQWwxf3KbHS1djdfrhWBRNr+AdDBhj2Mh4w6JCq81GX4XBoR2lTmqyPmvl6r/WYSW
 0WLHIyfWdUiWClBNIBDQ7s6pPStd/tY5tOXYzgRrnEhx2trvZQdfFvO5v1gpKxvG62gzndPVz
 QxcLXvQamL36Sw40bHtzQGgdIliDjn6Kg+JY43TOi0dZqOxJ1r05XmD3w4+iGEb2tLBpar4SM
 znaVqOGpk4t8KRGsiCZu+7t8ZGbxF9eQd0iu7Br0Nircdm2Tj5DGr3kbpqT1J4vnGHjtDr5wO
 yeOMRtKQ1qnq2G8sCtidXqWwHDmdU3yglpK7C5Prr5DjidUQiRvOK7UlReh0FXZJ/z9MqNS4s
 BEMGob92yrI3i2SylLWclvQhktPmvcgftnVjFRrBleZpeXRA/RIgOvijsRG3aLdhCGvaBnadX
 hByHUvjzPqZq+iNkHKAxKMTvOutAtJx7QApHXkYmFvQhq5EFBFGGYtgE1WS5XugZsljIP48iv
 LJB4ROIsXQCp8zuKvDemXqis8col09drndUl/nSg5LKQgGj6Atq7FS3RRv1u1gi0YpxLrAS5+
 5NVvQi0oHnN+qFFwRbJBcDqIFTQHgCAEzrjmAegX7KoyEg2H31eGwB5rP0kTh53gSA0FKGvZk
 OX/Dt4kh7DyGOOhXTt4d2g0pWiCjD+6GgnhKOc1J9N2wo99Z4DuQY
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.8

for you to fetch changes up to 214ba3584b2e2c57536fa8aed52521ac59c5b448:

  io: Fix return type of _inb and _inl (2020-07-27 10:32:29 +0200)

----------------------------------------------------------------
asm-generic: bugfix for v5.8

This is a single bugfix for a regression introduced through a
typo in the v5.8 merge window, leading to incorrect data
returned from inl() on some architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Stafford Horne (1):
      io: Fix return type of _inb and _inl

 include/asm-generic/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
