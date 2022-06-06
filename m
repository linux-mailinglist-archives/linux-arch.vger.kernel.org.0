Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8053E9C6
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiFFQlG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbiFFQk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:40:59 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 09:40:55 PDT
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F914642F;
        Mon,  6 Jun 2022 09:40:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id F0673E0E57;
        Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hhyNN48mX6Hb; Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id 87721E0E2D;
        Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 689583EF5B;
        Mon,  6 Jun 2022 10:35:28 -0600 (MDT)
Message-ID: <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
Date:   Mon, 6 Jun 2022 10:35:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: khalid@gonehiking.org
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-6-arnd@kernel.org>
From:   Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <20220606084109.4108188-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/6/22 02:41, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> The BusLogic driver is the last remaining driver that relies on the
> deprecated bus_to_virt() function, which in turn only works on a few
> architectures, and is incompatible with both swiotlb and iommu support.
> 
> Before commit 391e2f25601e ("[SCSI] BusLogic: Port driver to 64-bit."),
> the driver had a dependency on x86-32, presumably because of this
> problem. However, the change introduced another bug that made it still
> impossible to use the driver on any 64-bit machine.
> 
> This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> 64-bit system enumeration error for Buslogic"), 8 years later.
> 
> The fact that this was found at all is an indication that there are
> users, and it seems that Maciej, Matt and Khalid all have access to
> this hardware, but if it took eight years to find the problem,
> it's likely that nobody actually relies on it.
> 
> Remove it as part of the global virt_to_bus()/bus_to_virt() removal.
> If anyone is still interested in keeping this driver, the alternative
> is to stop it from using bus_to_virt(), possibly along the lines of
> how dpt_i2o gets around the same issue.
> 
> Cc: Maciej W. Rozycki<macro@orcam.me.uk>
> Cc: Matt Wang<wwentao@vmware.com>
> Cc: Khalid Aziz<khalid@gonehiking.org>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
>   Documentation/scsi/BusLogic.rst   |  581 ---
>   Documentation/scsi/FlashPoint.rst |  176 -
>   MAINTAINERS                       |    7 -
>   drivers/scsi/BusLogic.c           | 3727 --------------
>   drivers/scsi/BusLogic.h           | 1284 -----
>   drivers/scsi/FlashPoint.c         | 7560 -----------------------------
>   drivers/scsi/Kconfig              |   24 -
>   7 files changed, 13359 deletions(-)
>   delete mode 100644 Documentation/scsi/BusLogic.rst
>   delete mode 100644 Documentation/scsi/FlashPoint.rst
>   delete mode 100644 drivers/scsi/BusLogic.c
>   delete mode 100644 drivers/scsi/BusLogic.h
>   delete mode 100644 drivers/scsi/FlashPoint.c

I would say no to removing BusLogic driver. Virtualbox is another 
consumer of this driver. This driver is very old but I would rather fix 
the issues than remove it until we do not have any users.

Thanks,
Khalid
