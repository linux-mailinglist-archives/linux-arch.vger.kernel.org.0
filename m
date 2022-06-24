Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBCB559D77
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiFXPic (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiFXPiZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 11:38:25 -0400
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15BE1E3F8;
        Fri, 24 Jun 2022 08:38:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 36ABB61F0C;
        Fri, 24 Jun 2022 15:38:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo09-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo09-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E8sVpuImiYNQ; Fri, 24 Jun 2022 15:38:22 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id E956B61EFC;
        Fri, 24 Jun 2022 15:38:21 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 146083EE4C;
        Fri, 24 Jun 2022 09:38:21 -0600 (MDT)
Message-ID: <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
Date:   Fri, 24 Jun 2022 09:38:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: khalid@gonehiking.org
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
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
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
 <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
From:   Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/23/22 08:47, Arnd Bergmann wrote:
> 
> 
> Can you test it again with this patch on top?
> 
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> index d057abfcdd5c..9e67f2ee25ee 100644
> --- a/drivers/scsi/BusLogic.c
> +++ b/drivers/scsi/BusLogic.c
> @@ -2554,8 +2554,14 @@ static void blogic_scan_inbox(struct
> blogic_adapter *adapter)
>          enum blogic_cmplt_code comp_code;
> 
>          while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
> -               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
> adapter->next_inbox);
> -               if (comp_code != BLOGIC_CMD_NOTFOUND) {
> +               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
> next_inbox);
> +               if (!ccb) {
> +                       /*
> +                        * This should never happen, unless the CCB list is
> +                        * corrupted in memory.
> +                        */
> +                       blogic_warn("Could not find CCB for dma
> address 0x%x\n", adapter, next_inbox->ccb);
> +               } else if (comp_code != BLOGIC_CMD_NOTFOUND) {
>                          if (ccb->status == BLOGIC_CCB_ACTIVE ||
>                                          ccb->status == BLOGIC_CCB_RESET) {

Hi Arnd,

Driver works with this change. next_inbox is the correct pointer to pass.

Thanks,
Khalid
