Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB12F7208
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKKaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:30:02 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKKaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:30:01 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mbj7g-1huV1U45Ak-00dCLj; Mon, 11 Nov 2019 11:29:59 +0100
Received: by mail-qv1-f46.google.com with SMTP id q19so4644495qvs.5;
        Mon, 11 Nov 2019 02:29:57 -0800 (PST)
X-Gm-Message-State: APjAAAXVlRKVBuB0v2UROjYwO1s3CSlJzruUafA8sebho1Z8+BzL9XRl
        LUfh+JG7TXsaf/t9bNG5dda3OJjKps2Q81DSJDc=
X-Google-Smtp-Source: APXvYqx3dRDA2rmaPEW4UpY0UEoKLtstJlcCKLowXnTab550quUX1o9OqysLm43EJTh/MA4389FmX1Acn21s2dCCBDI=
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr23068710qvh.197.1573468197026;
 Mon, 11 Nov 2019 02:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-12-hch@lst.de>
In-Reply-To: <20191029064834.23438-12-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:29:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36-afn--XqG0ddj6VSPCzA_cfZqRxQXDuan7yk8CKg4w@mail.gmail.com>
Message-ID: <CAK8P3a36-afn--XqG0ddj6VSPCzA_cfZqRxQXDuan7yk8CKg4w@mail.gmail.com>
Subject: Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:igOphroMEFpMnMkrn23J291od0DWjU1aaJH47OrINMfH2gQoQzj
 wswLmUODv8L5V0ZNS9C2vEmrWUVg+qfsgcjOowE/M+AMr3tjjJARCovdc3zW7eZSc52MaNn
 B8zIQScI6XPXtCZ/2AwugNF73ontdS4Nl5G9zwfcfOenNk2be0dlSUdQbpujpEDBcXtnfSa
 XEzpJADBTSkFvOEUrL4LQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cuSoAWXZmVg=:LRwo+EdjvwPeGuS9lQdNp8
 DnQAkXW0tf/bZkz+3Uuwxu9Pdj+SF9Suk6NUgZldkZU7NsN5A9Sp5kp8X1q+owzDlSnHBCnA2
 reicSGJClSm1yQDQTlvHBnaDGBt6i6cHu2ovNDWI9LDSbj8/yUSaYa9HI3qpunSQ2ZmPircNB
 a5ZbFbmP4KW5IcG8SmrbdtmX56a5ulik8/5ZK1SASqZ/z3UkOHjzu5IEfDAqHq+StbMqDRi1E
 uewNmboOTDnGVermO75HwWDlI9TUPcdKGsX8HwDtAmwVHZ8Yh2Chs+kfdGLfTTIjdeCFJDj6d
 E8JnwMt9MfGFletNBP7f/5RMgZv5AfBReuxfYMPEUUwCejHcNNWnVOyGVzGkOGEiJzRpWS+q7
 izgNe2yLHj7duCP/hDdsRct1hQaVaaHFEnYLoz4d8DX1BK2q+AnvvAqEg4wU54rLTY/1hDrRb
 r8VD8AfKhsOHK1xGwzLiZM/tmPXYkZNHhHQJKMZuKq/LLLA/wTfFIOw3Il3U0pSQEkkAhrMyD
 BMgyWqfDmkdcrPNN6UWuVqhQGHvUGXsFWWE44UrWvf5pIr3LqLO4fO9yIydWnjah2WYjDEl4f
 +VmOl6qTHDPm9mETIz/49fnCXo2TVyrxwPiu7zpoZVzXY2tb+Z+f5gHoanfOuPSozT2RRJpRI
 TjTUTjg5iBKiCdYi+hMLPvezFIyuBNLoTkoKXKaJiAUZJiSFBBBUOsvHnHuFQ0rTvl3JHCXVL
 JheC7k+G0pzN985/q+BE516gWETbGZNuV0wuTwh65OgYEBClWS0uUP4RFNmwwJh/fXDCD7tF1
 pnYja0kjlOQ8WTbMtC5/GjWUuSkoQKSXiu9hUp4J2WzCZYL4dExwgugU4O+DXUvx1FlI4pzUH
 +sMohm92opK8jaRnuUiA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> All MMU-enabled ports have a non-trivial ioremap and should thus provide
> the prototype for their implementation instead of providing a generic
> one unless a different symbol is not defined.  Note that this only
> affects sparc32 nds32 as all others do provide their own version.
>
> Also update the kerneldoc comments in asm-generic/io.h to explain the
> situation around the default ioremap* implementations correctly.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
