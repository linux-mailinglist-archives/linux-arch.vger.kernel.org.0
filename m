Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2635C50E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhDLL0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 07:26:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbhDLL0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 07:26:36 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Movrq-1ltfTa2lXK-00qUJw; Mon, 12 Apr 2021 13:26:16 +0200
Received: by mail-wr1-f45.google.com with SMTP id s7so12420841wru.6;
        Mon, 12 Apr 2021 04:26:16 -0700 (PDT)
X-Gm-Message-State: AOAM5323SZB/5C97kuwT92PB6TfwI9kQSSxviIBzSwo/OBKlNl/Zd+bz
        TOrvQMXSUKuceqA2ASb3AYksfeR6qRF3vqSCovY=
X-Google-Smtp-Source: ABdhPJy46sI91TDF91SxINRlLS3vYTwc1YeMRJCymXnpPG5ap8cTdjbAP71XB76ODq1s/TL2YmK09N0XG1Vr80EDjdY=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr31632710wrg.165.1618226776291;
 Mon, 12 Apr 2021 04:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085545.2595431-1-hch@lst.de> <20210412085545.2595431-6-hch@lst.de>
 <15be19af19174c7692dd795297884096@AcuMS.aculab.com> <5c3635a2b44a496b88d665e8686d9436@AcuMS.aculab.com>
In-Reply-To: <5c3635a2b44a496b88d665e8686d9436@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 13:26:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JZ=JerasdkntzX_ApaCF7C29ZS1E31aPQATOts0ZiLw@mail.gmail.com>
Message-ID: <CAK8P3a1JZ=JerasdkntzX_ApaCF7C29ZS1E31aPQATOts0ZiLw@mail.gmail.com>
Subject: Re: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ry5qE36iTjjdSwzAcL8h8BXii7Lhlh98QV8EyNEqwW+LuSKlGh4
 8NBpO+ZKGIKdQ6RR1HuFLLQggTJPjETQbl0Rt0gsezdbZs/2uY1hZmO25GbYsJOVCwi4MG0
 c+FdeGvY6HY6K4phyVjGP15zuM514kYs4+j448yQXSg2kYBIqo3YphmyjFVflKaW49pbLEi
 Jyz4TnRH0bzl7LDE7JPAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FHKdfwr0Mls=:H46YUUEUGTT9Qoa9VQtGun
 RuMFYLKVnW8xBofB+zmI0u56rIjfmCyL30LMEE2Fd6UzlCyJ4oBnBVGdVz+wQ9DDNk2yMxz+i
 /Gdshu4u0ewFe5o+i8GzjWPKK2sfIgIiq2afIuvL+SQzfpgLcD9ILbFi5AAuobdu/9ySvpoGv
 04kcB2mwbfYu9yiwPK6tPtcaGEoax7pa/LfRLVIMv2xhQryRT7VZVE4bt8HpACEYKruO3hbXe
 bnQg6eNaHWgrKDp8nW1ixIyN3gQBPGq/QibUWg/9uwGtNiJBRtEQJ+VsGboPAcWYt8bGTuozb
 +uaafmgm5GfuSMh8YuRUyWZM34lMwjLSPEPRRSrxe0beVFTfJK7yHsb4H/H48BsKa/qxbpn/4
 rqMaj6WJU3rQSYwd766LtLoveS2Tjlue2aA6QeyLOid3HGt1p6iMNZ8Lh4YvUvIYGklumxGXd
 T9iZYLVuFIBbotcZ/lMEwEe48u8DHCBxO2tVP/9VZLRGk6LX5BkeeSpZG5a5hl97qwAXgl/FH
 wv2PjUEuyUj4ulnlvJ+WTmWmgCGo1XoOcAnvAOD1N8JBHueEyh924AaiOIloaHWVcHpK+Bp6A
 yKxwEO3ykjARw9Hv/iUAWjW/yBqj8nzTV7
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 12:54 PM David Laight <David.Laight@aculab.com> wrote:
> From: David Laight > Sent: 12 April 2021 10:37
> ...
> > I'm guessing that compat_pid_t is 16 bits?
> > So the native 32bit version has an unnamed 2 byte structure pad.
> > The 'packed' removes this pad from the compat structure.
> >
> > AFAICT (apart from mips) the __ARCH_COMPAT_FLOCK_PAD is just
> > adding an explicit pad for the implicit pad the compiler
> > would generate because compat_pid_t is 16 bits.
>
> I've just looked at the header.
> compat_pid_t is 32 bits.
> So Linux must have gained 32bit pids at some earlier time.
> (Historically Unix pids were 16 bit - even on 32bit systems.)
>
> Which makes the explicit pad in 'sparc' rather 'interesting'.

I saw it was there since the sparc kernel support got merged in
linux-1.3, possibly copied from an older sunos version.

> oh - compat_loff_t is only used in a couple of other places.
> neither care in any way about the alignment.
> (Provided get_user() doesn't fault on a 8n+4 aligned address.)

Ah right, I also see that after this series it's only used in to other
places:  compat_resume_swap_area, which could also lose the
__packed annotation, and in the declaration of
compat_sys_sendfile64, where it makes no difference.

      Arnd
