Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA355DB63
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiF1D1I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 23:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiF1D0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 23:26:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CD26557;
        Mon, 27 Jun 2022 20:26:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so14470128pjl.5;
        Mon, 27 Jun 2022 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=98ncMEofZ3ypmUWB7oKUkuT/bpmjStGksJuUcGKTVGc=;
        b=fMfCg/HOqcbPVSdVNElbV526+23+XdN3LylNezJqkrHb6fVXmxpkunVG3rLT9XcFXw
         HpCMyB7KDRKw245t+OJHw3FQL2gH2icNy1tzXFhyTeE+J9RLZswjB9T1T9XiFFpbERR5
         lCNa01DtHAYHMiVGjinDg8S0v2LUYuJPChTK5IuIdjUFD4GA99cW8qKKeB++ss8Vw+os
         RLW9bmiojBFFCdkwOuQe/CgRlLJtBdmK9G50X0mwzZYxHK7Dxb7Wga9rrrBIp9c5MIyG
         9Sx9MkBVwQuwC4cT7mj+YhgLxFUe+8+CDN6etZdDn0xnYNIAkilvA9GHP+xPdmO3Dj67
         /XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=98ncMEofZ3ypmUWB7oKUkuT/bpmjStGksJuUcGKTVGc=;
        b=EcWVGBCmlA3WZgUyDpUCKrnx1k3+EnJ+7OAACYFG4QOUbp0+tvJT3NkuUBLTsgqe0G
         XqwmHXz84MIVYBWDpPQWfUVD2Za0TIMKQZYiMgdN+qCKBIM/riMU2r0jYOV+AMYl8STD
         CvPyIHDdoY27KCWfSSBn7oJh0ZYgSFKZMZM947w3mAJVaCagDjqgeqBR1uJxIcRZWSUz
         nmKPYLLpSd1yobLzYcgWi9LpPTj6gkvIEjBlxJSD8nfR2r3bzyM7AC4EP2kDq/A0e6xT
         ptEFv4lZJS5LtKXLIV5qE01W85TtCO7AcexX0W2MrIhI9DiMOrvTmTeu6Hn2FZyvnBRF
         6h7g==
X-Gm-Message-State: AJIora8y46PJnmx4boilrxCuHw6OQGs50xIbx/eUuki0Rf/NzKPGy05Y
        1UhGE2oDU8qNMCOu+qkhlSM=
X-Google-Smtp-Source: AGRyM1uIBHaYKcir3w/b3B00SjBhXm7WkQIigMVOjBeds6D7ImU2LcUjsBGcJ8ZGhoTIiYdSDKQhjw==
X-Received: by 2002:a17:903:283:b0:16a:6db9:3f02 with SMTP id j3-20020a170903028300b0016a6db93f02mr2700935plr.173.1656386771103;
        Mon, 27 Jun 2022 20:26:11 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a08cd00b001ec932d7592sm8040238pjn.9.2022.06.27.20.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:26:10 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
Date:   Tue, 28 Jun 2022 15:25:58 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------EF1F8A9B021AD1B88577153E"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF1F8A9B021AD1B88577153E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hii Geert

Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
> Hi Geert,
>
> On 27/06/22 20:26, Geert Uytterhoeven wrote:
>> Hi Michael,
>>
>> On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com>
>> wrote:
>>> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> All architecture-independent users of virt_to_bus() and bus_to_virt()
>>>> have been fixed to use the dma mapping interfaces or have been
>>>> removed now.  This means the definitions on most architectures, and the
>>>> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>>>>
>>>> The only exceptions to this are a few network and scsi drivers for m68k
>>>> Amiga and VME machines and ppc32 Macintosh. These drivers work
>>>> correctly
>>>> with the old interfaces and are probably not worth changing.
>>> The Amiga SCSI drivers are all old WD33C93 ones, and replacing
>>> virt_to_bus by virt_to_phys in the dma_setup() function there would
>>> cause no functional change at all.
>> FTR, the sgiwd93 driver use dma_map_single().
>
> Thanks! From what I see, it doesn't have to deal with bounce buffers
> though?

Leaving the bounce buffer handling in place, and taking a few other 
liberties - this is what converting the easiest case (a3000 SCSI) might 
look like. Any obvious mistakes? The mvme147 driver would be very 
similar to handle (after conversion to a platform device).

The driver allocates bounce buffers using kmalloc if it hits an 
unaligned data buffer - can such buffers still even happen these days? 
If I understand dma_map_single() correctly, the resulting dma handle 
would be equally misaligned?

To allocate a bounce buffer, would it be OK to use dma_alloc_coherent() 
even though AFAIU memory used for DMA buffers generally isn't consistent 
on m68k?

Thinking ahead to the other two Amiga drivers - I wonder whether 
allocating a static bounce buffer or a DMA pool at driver init is likely 
to succeed if the kernel runs from the low 16 MB RAM chunk? It certainly 
won't succeed if the kernel runs from a higher memory address, so the 
present bounce buffer logic around amiga_chip_alloc() might still need 
to be used here.

Leaves the question whether converting the gvp11 and a2091 drivers is 
actually worth it, if bounce buffers still have to be handled explicitly.

Untested (except for compile testing), un-checkpatched, don't try this 
on any disk with valuable data ...

Cheers,

	Michael

--------------EF1F8A9B021AD1B88577153E
Content-Type: text/x-diff;
 name="0001-scsi-convert-m68k-WD33C93-drivers-to-DMA-API.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-scsi-convert-m68k-WD33C93-drivers-to-DMA-API.patch"

From e8c6aa068d27901c49dfb7442d4200cc966350a5 Mon Sep 17 00:00:00 2001
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 28 Jun 2022 12:45:08 +1200
Subject: [PATCH] scsi - convert m68k WD33C93 drivers to DMA API

Use dma_map_single() for gvp11 driver (leave bounce buffer logic unchanged).

Compile-tested only.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/scsi/a3000.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index dd161885eed1..3c62e8bafb8f 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -7,6 +7,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 
 #include <asm/page.h>
@@ -25,8 +26,11 @@
 struct a3000_hostdata {
 	struct WD33C93_hostdata wh;
 	struct a3000_scsiregs *regs;
+	struct device *dev;
 };
 
+#define DMA_DIR(d)   ((d == DATA_OUT_DIR) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
+
 static irqreturn_t a3000_intr(int irq, void *data)
 {
 	struct Scsi_Host *instance = data;
@@ -49,12 +53,16 @@ static irqreturn_t a3000_intr(int irq, void *data)
 static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 {
 	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
+	unsigned long len = scsi_pointer->this_residual;
 	struct Scsi_Host *instance = cmd->device->host;
 	struct a3000_hostdata *hdata = shost_priv(instance);
 	struct WD33C93_hostdata *wh = &hdata->wh;
 	struct a3000_scsiregs *regs = hdata->regs;
 	unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
-	unsigned long addr = virt_to_bus(scsi_pointer->ptr);
+	dma_addr_t addr;
+
+	addr = dma_map_single(hdata->dev, scsi_pointer->ptr, len, DMA_DIR(dir_in));
+	scsi_pointer->dma_handle = addr;
 
 	/*
 	 * if the physical address has the wrong alignment, or if
@@ -79,7 +87,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
 			       scsi_pointer->this_residual);
 		}
 
-		addr = virt_to_bus(wh->dma_bounce_buffer);
+		addr = virt_to_phys(wh->dma_bounce_buffer);
 	}
 
 	/* setup dma direction */
@@ -166,6 +174,10 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 			wh->dma_bounce_len = 0;
 		}
 	}
+	dma_unmap_single(hdata->dev, scsi_pointer->dma_handle,
+			 scsi_pointer->this_residual,
+			 DMA_DIR(wh->dma_dir));
+
 }
 
 static struct scsi_host_template amiga_a3000_scsi_template = {
@@ -193,6 +205,11 @@ static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
 	wd33c93_regs wdregs;
 	struct a3000_hostdata *hdata;
 
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+		dev_warn(&pdev->dev, "cannot use 32 bit DMA\n");
+		return -ENODEV;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -216,6 +233,7 @@ static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
 	wdregs.SCMD = &regs->SCMD;
 
 	hdata = shost_priv(instance);
+	hdata->dev = &pdev->dev;
 	hdata->wh.no_sync = 0xff;
 	hdata->wh.fast = 0;
 	hdata->wh.dma_mode = CTRL_DMA;
-- 
2.17.1


--------------EF1F8A9B021AD1B88577153E--
