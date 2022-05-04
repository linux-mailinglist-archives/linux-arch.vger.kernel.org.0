Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1F51B119
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiEDVji (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379237AbiEDVjN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 17:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF052E62;
        Wed,  4 May 2022 14:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5327161A94;
        Wed,  4 May 2022 21:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD914C385B3;
        Wed,  4 May 2022 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651700107;
        bh=Ag6z4UsMQi45DT6LEixpyNi3v4/oCDHforErc0WKpkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jT9J069rPUQBqanuRgdVPUVzvqR76Z3AXmb1hQ28qWhElNA1xUTHs3Wg7OhG9knRF
         nYE2UWXrL/ob801JQe8XQgqI1Kr5RsyzXhwyetM1ZZi0rIbPnGzwearHlnR6Qfquff
         tmzjarVjC3PqWuwS80M3Fd5InHZ68Hp3bwCF1etSdQ0MSnbYYriGQX+NLsE9AfqkdH
         7/EKJkbQAEr+iIvA+6iLOrTHR9aqBtmxjAtueAdO8QW1Z6FnqbYc4rxI0pUpNJ5tRE
         JvlHkOYjKrKaoI1CEiBVPrDKFlt4LVaM2/XCtNdPH7opp1rdAmnJW6mfXH2/uOHTQ2
         cu2b9KpQuuzpw==
Received: by mail-wr1-f49.google.com with SMTP id e2so3664216wrh.7;
        Wed, 04 May 2022 14:35:07 -0700 (PDT)
X-Gm-Message-State: AOAM530pBHbnZSOSTyUCza1fPiWVN2lBZNR4lkAY/EgAC4I4P/05qMG+
        frBHMNGA7bvWwmagJhQ0r1SM6Wvq+3RFipji/AE=
X-Google-Smtp-Source: ABdhPJyJdqNhgHXeC5+qWnrrqqXwN5Jjvbj+o5B4nexQNKTcbVdNE9ExlHhPkDOn3OnkIrCgsPdFpKkMocrgnUpCXpM=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr17567886wrz.219.1651700105974; Wed, 04
 May 2022 14:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220429135108.2781579-54-schnelle@linux.ibm.com> <20220504204231.GA463295@bhelgaas>
In-Reply-To: <20220504204231.GA463295@bhelgaas>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 May 2022 23:34:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=HgkkSJ2edZxMDbyuTyNZK98oSi4rc6CL_b6RHAQ-OQ@mail.gmail.com>
Message-ID: <CAK8P3a0=HgkkSJ2edZxMDbyuTyNZK98oSi4rc6CL_b6RHAQ-OQ@mail.gmail.com>
Subject: Re: [RFC v2 30/39] scsi: add HAS_IOPORT dependencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:MEGARAID SCSI/SAS DRIVERS" 
        <megaraidlinux.pdl@broadcom.com>
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

On Wed, May 4, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 29, 2022 at 03:50:51PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
>
> Some of these drivers support devices using either I/O ports or MMIO.
> Adding the HAS_IOPORT dependency means MMIO devices that *could* work
> on systems without I/O ports, won't work.
>
> Even the MMIO-only devices are probably old and not of much interest.
> But if you want to disable them even though they *could* work, I think
> that's worth mentioning in the commit log.

I think this would again make more sense with the original CONFIG_LEGACY_PCI
conditional than the generic HAS_IOPORT one. I don't remember what the
objection was to that symbol.

I think the presence of inb()/outb() is a good indication that a driver is for
obsolete hardware, though of course there are important exceptions to this
that instead need to have the conditional in the code itself (8250,
vga, ipmi, ...)

       Arnd
