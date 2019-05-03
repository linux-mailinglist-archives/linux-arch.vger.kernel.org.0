Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8285312C0F
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 13:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfECLL7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 3 May 2019 07:11:59 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50555 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLL6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 07:11:58 -0400
Received: from xps13 (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9D4FF100005;
        Fri,  3 May 2019 11:11:53 +0000 (UTC)
Date:   Fri, 3 May 2019 13:11:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 05/11] mtd: rawnand: vf610_nfc: add
 initializer to avoid -Wmaybe-uninitialized
Message-ID: <20190503131152.57b4ce25@xps13>
In-Reply-To: <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
        <20190423034959.13525-6-yamada.masahiro@socionext.com>
        <20190502161346.07c15187@xps13>
        <CAK7LNAQH8v8_HG6-cytT4qe05W9iiYwEP1mud4zG2NxxYcFptQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri, 3 May
2019 19:36:35 +0900:

> Hi Miquel,
> 
> On Thu, May 2, 2019 at 11:14 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 23 Apr
> > 2019 12:49:53 +0900:
> >  
> > > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > > place. We need to eliminate potential issues beforehand.
> > >
> > > Kbuild test robot has never reported -Wmaybe-uninitialized warning
> > > for this probably because vf610_nfc_run() is inlined by the x86
> > > compiler's inlining heuristic.
> > >
> > > If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
> > > and vf610_nfc_run() is not inlined, the following warning is reported:
> > >
> > > drivers/mtd/nand/raw/vf610_nfc.c: In function ‘vf610_nfc_cmd’:
> > > drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >    vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >             nfc->regs + NFC_MAIN_AREA(0) + offset,
> > >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >             trfr_sz, !nfc->data_access);
> > >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> >
> > IMHO this patch has no dependencies with this series.  
> 
> 
> This patch is the prerequisite for 11/11.
> https://lore.kernel.org/patchwork/patch/1064959/
> 
> 
> Without the correct patch order,
> the kbuild test robot reports the warning.
> 
> 
> > Would you mind sending it alone with the proper Fixes tag?  
> 
> 
> I do not think Fixes is necessary.

IMHO it is. Even if today the warning does not spawn, there is a
real C error which might already be an issue.

> 
> Nobody has noticed this potential issue before.
> Without 11/11, probably we cannot reproduce this warning.
> 
> 
> BTW, this series has been for a while in linux-next.

Missed that. Ok, nevermind.


Thanks,
Miquèl
