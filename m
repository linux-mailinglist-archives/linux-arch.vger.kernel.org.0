Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A864327C0
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhJRTe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 15:34:57 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:34120 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhJRTe5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 15:34:57 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4634D92009D; Mon, 18 Oct 2021 21:32:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 42D5492009B;
        Mon, 18 Oct 2021 21:32:43 +0200 (CEST)
Date:   Mon, 18 Oct 2021 21:32:43 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Feiyang Chen <chris.chenfeiyang@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
In-Reply-To: <8a6f5c78-62c0-5d58-1386-dabfcacc112a@wanyeetech.com>
Message-ID: <alpine.DEB.2.21.2110182128090.31442@angie.orcam.me.uk>
References: <cover.1631583258.git.chenfeiyang@loongson.cn> <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com> <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com> <20210921155708.GA12237@alpha.franken.de> <ef429f0f-7cc9-2625-3700-47dc459ee681@wanyeetech.com>
 <8a6f5c78-62c0-5d58-1386-dabfcacc112a@wanyeetech.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 13 Oct 2021, Zhou Yanjie wrote:

> > > can people, who provided performance numbers for v1 do the same for v2 ?
> > 
> > 
> > Sure, I will test the v2 in the next few days.
> 
> 
> Sorry for the delay, It took a lot of time to migrate the environment to my
> new computer, here is the results:
> 
> 
> Score Without Patches  Score With Patches  Performance Change SoC Model
>        105.9                102.1              -3.6%  JZ4775
>        132.4                124.1              -6.3%  JZ4780(SMP off)
>        170.2                155.7             -8.5%  JZ4780(SMP on)
>        101.3                 91.5              -9.7%  X1000E
>        187.1                179.4              -4.1%  X1830
>        324.9                314.3              -3.3%  X2000(SMT off)
>        394.6                373.9              -5.2%  X2000(SMT off)
> 
> 
> Compared with the V1 version, there are some improvements, but the performance
> loss is still a bit obvious

 The MIPS port of Linux has always had the pride of having a particularly 
low syscall overhead and I'd rather we didn't lose this quality.

 FWIW,

  Maciej
