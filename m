Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62192EDB51
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKDJMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 04:12:12 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Nov 2019 04:12:12 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M3lgJ-1iQj3i3Iv5-000sp1; Mon, 04 Nov 2019 10:12:10 +0100
Received: by mail-qk1-f176.google.com with SMTP id m16so16558841qki.11;
        Mon, 04 Nov 2019 01:12:09 -0800 (PST)
X-Gm-Message-State: APjAAAXmZY2oZXu1SK+A1vfM3JX/V8z2QkzgxiP5wbArRRO6us1+iRNV
        pnVhilIsSqtQxkd4P5FbcNyhK6QXDsUT9S9j9Ak=
X-Google-Smtp-Source: APXvYqxFWfC/pRRphyl2sEqUGu4g2hW8Ws8h+GoExMAObfzyIMrknTzY4xbMka/8WJkNHFwlq+X2sKNUp3jxigxtutU=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr1192533qkb.138.1572858728295;
 Mon, 04 Nov 2019 01:12:08 -0800 (PST)
MIME-Version: 1.0
References: <1572850587-20314-1-git-send-email-rppt@kernel.org> <1572850587-20314-14-git-send-email-rppt@kernel.org>
In-Reply-To: <1572850587-20314-14-git-send-email-rppt@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Nov 2019 10:11:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
Message-ID: <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and include/asm-generic/4level-fixup.h
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xypYB7MfMvOgznrhvKhllgOOWUTROK6RFsV7jczDvJ/v9Wnj6Ze
 eecmYacDgpkTxZk7bq5TERRyr9ud4iKtPbKYBzMkNfiConTZpDY0+V03MuhiiH2U7gSATOL
 ++7O2hcWPFZG7p+FKEN4l5tSd8BXqQSIILXTdi2NZiXc5eh/BfnYKWmF4zXY0nRyRFICTDK
 DkHnSvUmLFzXphiN3f1Lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i8sE3XxhxL0=:3BsHhMGb+73Ml+/9ZdBkgh
 goiI0C/RDeSocWGT2AlOTjuOumMzR3qTp7IKDA/BUBwRXEh+BdWkya4Vm9OgkB2ZtEQIV5rto
 IwPs8rXFxLWKFGXBTcDkdndveGBdhEb53xfoWW89db44yXOUMTI8L/gmB2EeU4Hm2P9pmupTR
 zMTTnpqPJKDmOJygjdvCYrKbGWHLqsWJzLTNeWe75Pd91pGZDTX5uUb45b8iWUhDU3P4HbLsb
 oqiciI1bjtDW4nvgb3xJpNFpInHp3LyVZVHt1SjAJMGbMxd6u8RMG+1YIsqPEn6KiP/SUIkm5
 YiC/XKF3ax9pNpHUzeFIGbAHSkPhAPlAZYoT7pFBRqndD/VJF1orwpJ72XxO0DMoJSoTe0GE0
 jSNvmRSMrb1NK+0JT8BvslkByzNNh80QJRQo6pSgbTDB5ePgzrQWfKFsG6bp96kS1t6e+m6H2
 3uuESm3cqYJdZrR9+Mc0QBPcW+YIPrAmCYMjiB0n+POo3TcBfibWHxqdQoR88uSpVU+20x/6/
 HaQzTWdmn/0P2qMX9qliruHN1TIoaZERWt5FBNVnMZhVQe/JLB736Gvo94TNkNs3UcsWMhdfZ
 4HJH+CV5momj+MMXorJLKA1qi+w6iTzvkEvYfFQHg3Dal0jx/vLfEOXiMaN6CfdD8Y5Wez84b
 JD9K34KMMVtUeSbWnF/cgvBlhCi5hjALbGNcvkTwoJJRCGQdXnTHlrTdcY/viEkuSbfmTLKN3
 NIs2DT63WteMZt5q5Gjh3GeumRksgmC9dHXODzgDe+skbSHqiKy9rfo2m4lW2qxJQ/xcPNsf+
 wu00QLv2mlKq9v58ARQUaLUdIU6QTfUfQR7btTyVi0CPMl3D2DTy8ED+kOwHayFDPEUouqrJQ
 JYDLi/5o/KQwbyulnq9w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 4, 2019 at 7:58 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> There are no architectures that use include/asm-generic/4level-fixup.h
> therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Have you discussed how the series should get merged? I assume an initial
set of patches can just go through architecture maintainer trees, but
whatever patches don't get picked up that way would go through either
Andrew's -mm tree (for memory management) or my asm-generic tree
(for cross-architecture cleanups).

Since there is still at least one regression, I expect not to do anything
for now. Please let me know when/if you expect me to merge the
remaining patches.

      Arnd
