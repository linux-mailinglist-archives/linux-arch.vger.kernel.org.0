Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448F111B01
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBONy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 2 May 2019 10:13:54 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54991 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBONy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2019 10:13:54 -0400
X-Originating-IP: 90.88.149.145
Received: from xps13 (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BC10960015;
        Thu,  2 May 2019 14:13:47 +0000 (UTC)
Date:   Thu, 2 May 2019 16:13:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mathieu Malaterre <malat@debian.org>, x86@kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v3 05/11] mtd: rawnand: vf610_nfc: add
 initializer to avoid -Wmaybe-uninitialized
Message-ID: <20190502161346.07c15187@xps13>
In-Reply-To: <20190423034959.13525-6-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
        <20190423034959.13525-6-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 23 Apr
2019 12:49:53 +0900:

> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
> 
> Kbuild test robot has never reported -Wmaybe-uninitialized warning
> for this probably because vf610_nfc_run() is inlined by the x86
> compiler's inlining heuristic.
> 
> If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
> and vf610_nfc_run() is not inlined, the following warning is reported:
> 
> drivers/mtd/nand/raw/vf610_nfc.c: In function ‘vf610_nfc_cmd’:
> drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             nfc->regs + NFC_MAIN_AREA(0) + offset,
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             trfr_sz, !nfc->data_access);
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~

IMHO this patch has no dependencies with this series.
Would you mind sending it alone with the proper Fixes tag?

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
>   - split into a separate patch
> 
>  drivers/mtd/nand/raw/vf610_nfc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index a662ca1970e5..19792d725ec2 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -364,7 +364,7 @@ static int vf610_nfc_cmd(struct nand_chip *chip,
>  {
>  	const struct nand_op_instr *instr;
>  	struct vf610_nfc *nfc = chip_to_nfc(chip);
> -	int op_id = -1, trfr_sz = 0, offset;
> +	int op_id = -1, trfr_sz = 0, offset = 0;
>  	u32 col = 0, row = 0, cmd1 = 0, cmd2 = 0, code = 0;
>  	bool force8bit = false;
>  

Thanks,
Miquèl
