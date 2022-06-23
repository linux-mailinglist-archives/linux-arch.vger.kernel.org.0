Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD06D557E13
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiFWOr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 10:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9DB4B9;
        Thu, 23 Jun 2022 07:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F3B61E61;
        Thu, 23 Jun 2022 14:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4615AC341CC;
        Thu, 23 Jun 2022 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655995675;
        bh=au8iIbHJe6C0t5TRQVq0kBytOZGBWB60SJOjT91kNOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TXilrHjwW0ul/jGd3QfygDh1CU4HiF0PU/EzK46nAvJvTnB7XphH5wugAHMs1fdlT
         NAqqU76jOfKTik60xczB0waviSzFdqWuwhXl1/AJhpUVqBXnxgXh+rXRWUZbyIAIfT
         MXY+AAkp/4isrf3wbF/41a4O47pIx0lhHdXXqUpgU3G/wIwHtQ9t7Z0SBnWqXB2wSB
         iVcAM5tuh7hr5MsxeuvRowsH5pMrEP17+mia0+1+NCIgkbthZnCKNQsM5UYKAXvnlK
         6Z4gx88v1vU1izvEInQc+fAMFcfSjnqLgreLl5trAdnQyTagdfqFujQuJEru0fKMmB
         zdJiyNlat54Ng==
Received: by mail-yb1-f170.google.com with SMTP id p69so24515307ybc.5;
        Thu, 23 Jun 2022 07:47:55 -0700 (PDT)
X-Gm-Message-State: AJIora/VpLiuVOdYZ9lBsN//S6hmZuKCpktmeebNhFmtw7cyONVC/SjA
        taw3uF57vBykX2Rbb7/4+PEk5MrA12TTjZeL9IU=
X-Google-Smtp-Source: AGRyM1ts0XQnj28PXnyZfJ+lmwDmSBI5jCCoOoZ4U4DnpJA2vL/8Iy7f05Xa3tSfeBpkphX7+GgcnVPiJZGvgoh27MU=
X-Received: by 2002:a25:e808:0:b0:669:7fcf:5f82 with SMTP id
 k8-20020a25e808000000b006697fcf5f82mr9435202ybd.550.1655995674287; Thu, 23
 Jun 2022 07:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
In-Reply-To: <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 23 Jun 2022 16:47:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Message-ID: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
To:     Khalid Aziz <khalid@gonehiking.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 11:56 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> >       while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
> > -             /*
> > -                We are only allowed to do this because we limit our
> > -                architectures we run on to machines where bus_to_virt(
> > -                actually works.  There *needs* to be a dma_addr_to_virt()
> > -                in the new PCI DMA mapping interface to replace
> > -                bus_to_virt() or else this code is going to become very
> > -                innefficient.
> > -              */
> > -             struct blogic_ccb *ccb =
> > -                     (struct blogic_ccb *) bus_to_virt(next_inbox->ccb);
> > +             struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter, adapter->next_inbox);
>
> This change looks good enough as workaround to not use bus_to_virt() for
> now. There are two problems I see though. One, I do worry about
> blogic_inbox_to_ccb() returning NULL for ccb which should not happen
> unless the mailbox pointer was corrupted which would indicate a bigger
> problem. Nevertheless a NULL pointer causing kernel panic concerns me.
> How about adding a check before we dereference ccb?

Right, makes sense

> Second, with this patch applied, I am seeing errors from the driver:
>
> =====================
> [ 1623.902685]  sdb: sdb1 sdb2
> [ 1623.903245] sd 2:0:0:0: [sdb] Attached SCSI disk
> [ 1623.911000] scsi2: Illegal CCB #76 status 2 in Incoming Mailbox
> [ 1623.911005] scsi2: Illegal CCB #76 status 2 in Incoming Mailbox
> [ 1623.911070] scsi2: Illegal CCB #79 status 2 in Incoming Mailbox
> [ 1651.458008] scsi2: Warning: Partition Table appears to have Geometry
> 256/63 which is
> [ 1651.458013] scsi2: not compatible with current BusLogic Host Adapter
> Geometry 255/63
> [ 1658.797609] scsi2: Resetting BusLogic BT-958D Failed
> [ 1659.533208] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533331] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533333] sd 2:0:0:0: Device offlined - not ready after error recovery
> [ 1659.533342] sd 2:0:0:0: [sdb] tag#101 FAILED Result:
> hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=35s
> [ 1659.533345] sd 2:0:0:0: [sdb] tag#101 CDB: Read(10) 28 00 00 00 00 28
> 00 00 10 00
> [ 1659.533346] I/O error, dev sdb, sector 40 op 0x0:(READ) flags 0x80700
> phys_seg 1 prio class 0
>
> =================
>
> This is on VirtualBox using emulated BusLogic adapter.
>
> This patch needs more refinement.

Thanks for testing the patch, too bad it didn't work. At least I quickly found
one stupid mistake on my end, hope it's the only one.

Can you test it again with this patch on top?

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index d057abfcdd5c..9e67f2ee25ee 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2554,8 +2554,14 @@ static void blogic_scan_inbox(struct
blogic_adapter *adapter)
        enum blogic_cmplt_code comp_code;

        while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
-               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
adapter->next_inbox);
-               if (comp_code != BLOGIC_CMD_NOTFOUND) {
+               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
next_inbox);
+               if (!ccb) {
+                       /*
+                        * This should never happen, unless the CCB list is
+                        * corrupted in memory.
+                        */
+                       blogic_warn("Could not find CCB for dma
address 0x%x\n", adapter, next_inbox->ccb);
+               } else if (comp_code != BLOGIC_CMD_NOTFOUND) {
                        if (ccb->status == BLOGIC_CCB_ACTIVE ||
                                        ccb->status == BLOGIC_CCB_RESET) {
