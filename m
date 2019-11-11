Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1EF724C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKKgn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:36:43 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKKKgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:36:43 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqbI0-1i8CQi2iKu-00mc2H; Mon, 11 Nov 2019 11:36:40 +0100
Received: by mail-qv1-f46.google.com with SMTP id f12so4660079qvu.3;
        Mon, 11 Nov 2019 02:36:39 -0800 (PST)
X-Gm-Message-State: APjAAAUT3Qdeiri2nf/a9hZxYA+s9YglrpYjjU1hn5ZWkyA7i5p8Vrcc
        QA30I7QFw7jV+rFcmPGwSBM33hztJ/+dGvx7o1E=
X-Google-Smtp-Source: APXvYqwG9UjDI7BT4/zArLXJROi41Jfl0ozvIqGD8Z6sQp9Psd5jWuuWMeGtnWBnULPRq767xF7AmE4x/PyrFGraS9U=
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr4580319qvb.222.1573468598676;
 Mon, 11 Nov 2019 02:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-4-hch@lst.de>
In-Reply-To: <20191029064834.23438-4-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:36:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3k2KRyhCy4OWJkToNBiw_mw0e_A=Ta6UANMMF3EXnhmA@mail.gmail.com>
Message-ID: <CAK8P3a3k2KRyhCy4OWJkToNBiw_mw0e_A=Ta6UANMMF3EXnhmA@mail.gmail.com>
Subject: Re: [PATCH 03/21] ia64: rename ioremap_nocache to ioremap_uc
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
X-Provags-ID: V03:K1:1JhgznTD+nxQakSYexEK5Pk7b21gJFc2WwU/VhlwbME8N3jGV/+
 TpZ37rg3qW3B4NpO67un+1fSQwj7nJ9WZxTx4tTw9EKEbeJLwQT1TG9P/3xrMgCSPaMoGDW
 4OmMhZWar6tNBwoASHsSKmwJI7CPx497+h8ii4N2nIjzGmy0KJ0TV9vHBlIGb31rRCksOx9
 aTZ8Ir7FbCAiPNKD11llg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ine2h7iyM1A=:qlrnOzki59DM0rGyHbF8c+
 4c41xr+Pjp3dv6qx5neQvKwVeJxerBsQ4cZwqUg3qKbbDEFa2ZPC0yEa1cbl7oJWJAwRcsdz6
 3MUPWCBNg96i3H6LWIf2LY64tTEzAwU6ta+wRDArNRsNPjb+cOcAHdO9J5cipKKooXSwfqh8z
 hdrlf+Webj14QrpswR0AwC+8hKtzWd3i0xF+aE+nK/v+b1TtFw3PWqR0yiKat86EI4zUEaq5S
 blnI1BhSm9FhHUQnRQYPCyh9wiNRLDsep8swNKAMT9kFtEYbcXHeA956UAKOL55rHOLQlxqd3
 lAXOyepCNVYPFNUyMmMo6uXZePmp/F+60qeAs/Tm928lA24mSrrR1jN4Nq8m3JqUpjKhlZFaU
 fvOcUxdsAUUjwEiE4xSEhPoEtQb+DOGjhCuWsoZrvcZ1CjJd2pnmp6FLV3FPDrayCN2FUB0+D
 dmLJySIAVE94FRl52KFtqFt9/TBA0a2L4yS7XNw+74hbWZJzUFOsB1zH2ZnS90kPa5a1S22XM
 mkuCB+Ze2kLOtqiQGKJqc0RlyWnS+sMOkWAdvTX+Rk1hGH5fKf0QbR6Le5fYNxtQWuM0JMh+f
 By832HCI9AAhEwsUgCfxQCimkThZsEgsisrp/yb11zuIdHEeLX16avpzV0hyWrAt6yeKP7XrG
 yjSzxrZhvOP87R/igp1n2UpO7GVNOVggicvQugamDUOVh3NDT+rQXzKcV4LH3yIkPIKuSINHm
 GaoL/XXgPWkF56Qx6lsBsgXfh3dciBTkAIu4nPZV5+fqR9kZ2QN3jAM4eo2Ub3HntQ9Kbyv/a
 ZDdBgC236xAnxPORQfWGJIrWohqntO0L5vDv2H4PTweI1FuenAFOsrx0PeMpr05WJvpzkeNBM
 RntzRq/h+i22XaPj8kSJZuypgHi3M6gwdd2H+7uFpgi5116lXuTPt2gZhmC4RNHOAUMyt7F6w
 EKVOtQp2bdxVDZZvAy6BtKT5EprzcuH1RFRAxRb4YPU7spR+xJPQCgbGgWu5JDdYB+aa/+plM
 NJyOttaoY33T+C7Iqkgauu6DDMOdPDodJFayhYpF7V4oCFsaUB1Qh4zXbOtQenYMLA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On ia64 ioremap_nocache fails if attributes don't match.  Not other
> architectures does this, and we plan to get rid of ioremap_nocache.
> So get rid of the special semantics and define ioremap_nocache in
> terms of ioremap as no portable driver could rely on the behavior
> anyway.
>
> However x86 implements ioremap_uc in a similar way as the ia64
> version of ioremap_nocache, in that it ignores the firmware tables.
> Switch ia64 to override ioremap_uc instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Good idea,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
