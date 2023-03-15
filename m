Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C06BA8D5
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 08:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCOHQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCOHQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 03:16:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0E23135
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678864566; x=1710400566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gzn4utLc8E9+krBxKFICMItFLGvLZcLSUim2ZyjAkIc=;
  b=QsK5D0dXST9brBnqRrMCCuTbJaJyGdUpz/QhFZ9lxxJ6odapM1f2hH3+
   cjRshYV3AEn+XBvgiqltwiOdeY3c8AmCSWcfI8MUdD1JU9pElIaiVN8Xf
   2C7RApMM/UDEhbBuN4eoQK42p+gwDQI0900Annlw2rmYKXQidFjbHQSwd
   EiV53wfA2H7ScJ0eSrz0sH0Xl52/cqc241MwikG+73fGzUF7Z+raDWhyN
   f0QUF1hkSQ7j4rXJYYd+SNLIBr5dTUJWus79FNOxr7g2RhiIs7ZXiEWNF
   3bSvRh55DAOUoEjOzu5LtZDxuMcQmLCG6/kIfDL4Oyos0Q/9lCucHzaku
   w==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="330050560"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 15:16:02 +0800
IronPort-SDR: 3Ku6jwCz8d4IKEQPmePNZ0xrZwN6GRbhIF8FHoylt+MgGAEzUkJH0To8bvq2WxRi2NF/OBTkfI
 eMnsfaPJdc7nVzIu9pq6M5vhsjTZ96qqK0UgEqAnwUAYbHlZir7YplArX4YPPMx2O+JaOYg5dJ
 0KjbTq0sSR8QTEX5QsMhx4I0VzDwCFnLAxL8itF7B8IghF1Lg48hN9FmxG7upfNKnnGfdEoLhT
 kHHb+u4rr/TTNVmVLpO91FD1Rz2K7r0Y42a7p2A+r90lHn5I3tGpLnScNTqFPAL1pey9r0zqUD
 NtY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 23:32:29 -0700
IronPort-SDR: DtiXV2lOoCtypN97qnqUuuXI728IKBxrHxXNM6iXjDU7c+lJ2IcpZJ6DM/iioiwBHSlFW5RIF4
 jPRoCOaJGFI2iNxPlLiRhYbUtQbrvjlMdVpH7t41eIHe0s7P4PLDKbqmAC2xJCUNlJkwVseLIA
 vURC51GugtHavCRoJFmn3dxvUhGfRAY0b0rqVpakEl8p0Dg+QO/9sHl8R1UcBfPkIj3IZd+ksY
 cRj0YUDRohnqnJCTdmiwsRz6RA9B2DZISvFbrIQdkzO0dnuj0VYWJ2Ux8wxeH2NHpsVN6zdio4
 CgQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 00:16:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc1ry1fKCz1RtVy
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 00:16:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678864561; x=1681456562; bh=gzn4utLc8E9+krBxKFICMItFLGvLZcLSUim
        2ZyjAkIc=; b=QcmorQfZXKnxA0EP7lHE6ez2ReFY9lPT4JMif04usI6gdah0wx0
        vjPLeQsGOm7rbfUi5HB5svALBY5VWJJkskyIm0D8SDfyog00LnyDo6LIvaBdF+/u
        nw+QcWIBu1sfkqAtZydHxTg80DmhPgDoxAf5m/TzXMgey4VBJ7Ef+m8cogq4hmvB
        w8xwcrKWp7hG4x91n1SD5kzj0evVdg4TfLQwgH8+8e3TkBW4S4IdhrKBCqlg+D1F
        y4g6c7QkY0h9fbJHVs9V53ydftmGFvQMHgvwAY3Al0s00S/nKtFWGhIgui0OwsSB
        adBv0xdYIQ6zHwM7JXVrIPTKFiTLYjOyxEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nJpDdEa9QcxY for <linux-arch@vger.kernel.org>;
        Wed, 15 Mar 2023 00:16:01 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc1rt5qrVz1RtVm;
        Wed, 15 Mar 2023 00:15:58 -0700 (PDT)
Message-ID: <d9cdb235-4cd6-5ff3-31c2-85e893e25794@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 16:15:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314121216.413434-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/14/23 21:11, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b56fba76b43f..e5e67bdc2dff 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -342,6 +342,7 @@ endif # HAS_DMA
>  
>  config ATA_SFF
>  	bool "ATA SFF support (for legacy IDE and PATA)"
> +	depends on HAS_IOPORT
>  	default y
>  	help
>  	  This option adds support for ATA controllers with SFF

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

