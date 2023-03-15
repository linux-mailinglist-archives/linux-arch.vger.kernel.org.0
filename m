Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6E6BA484
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 02:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCOBXr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCOBXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 21:23:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B322125
        for <linux-arch@vger.kernel.org>; Tue, 14 Mar 2023 18:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843425; x=1710379425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X8UKkBh1V1RorkgsXH+xOkeiIn0TdvaVPn4IWxodiyw=;
  b=hdjfNzdoriXJKDHUBHUJUME7S3NAAHnq+NgAkTfi7Of43Y2J2UP7Ng6Q
   l8bS12xA/TOsieZO5eqbRgNJdGPZSvT/kIdZBn07lBXz9IcF/1rvr2axw
   ohJHfOfOCJrWbukZkIFyd/o6u+s5EsmQTVlvYbpVHxmA7agggIHbe/Y+i
   WZscNjrpZ1xg7QRddqlVGK4Rqs4V3EkoyNLmRRPNLf3WlVBB3oY4xbUWw
   +EOG4PCYRPulZSjfcmbT6yk6JJRVB0/j2V72An61Uai7TkUABB6mQxQ2I
   i7yQ0oplns5fEkH1dPDHtPVFQxTyuUXTPPzBIJdfDrXpbr9ymY0zBLfF5
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="225433065"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:23:43 +0800
IronPort-SDR: rtEJVDmg0SnXYK0w2gkKyS+JhKRDegydgXq0P7B6+VDD5/eit7EGZ440JGKH6MTkW93AJSvE2e
 q/gDcQrwOZhnG/ZSFBPAeAXLEX+R0Sd8rYNWG6ZRwnopVAqY970J6gnR3WaFY4ancXpWrotasn
 4hQIxD3cHKEMhqUTurbbjvNF8X08rAn+6aiQoBmtsuQgf0HNCVzvWC13YTNcS+kvPRu32sm2uQ
 MXF2j0qvyz2O0+c1bYy72uhboAQ00wGMkknFwhzv9tWnAlpFIOgIx6BfajYMVuhYKR/DQuPvrl
 krU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:34:30 -0700
IronPort-SDR: IR9ILPBgno6ffqQcvNtsWbz0x0RmpvR/2sknPHuMpMzVfGfhu7hN8Z97N2hnrLzV5NSUbTc9Mq
 gEueVLIouAzdPDjX9V3v88E+UhMx63IPI801rDeIFOh7vcO65M26rnOlPYtrUE4RVdBOHPs7QB
 6+G2p6ZMA7lG7Tn7ur9h9q6iWDy2VTZTlmG774s3wqdYEs/oWJo2OeYP/POMZlg9NVeeAdQ8Ih
 lQJV8avphotdvT30dmG6JmSNZ98GWOU/TzKUxdxHmbki6lZ95wNp5JaFBUeVaeusttrbyUhsB4
 alM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:23:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt2R203Mz1RtVw
        for <linux-arch@vger.kernel.org>; Tue, 14 Mar 2023 18:23:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843422; x=1681435423; bh=X8UKkBh1V1RorkgsXH+xOkeiIn0TdvaVPn4
        IWxodiyw=; b=bP6jbEKa2LNYrQ3e2NilGHdksmnc/IQsbBc+wU7S6SEmh0bR14o
        jUoM4OkcwGn6CJSOfiLj7omJ37O3WflH2smKKwby8OecIU9bS+scfEFuatS+5YSo
        btf1DwxXuMgoYlEkDcHu0bG4P8Myae0M+2qX9XcONMEwigtdRRYJj1Mk+dxKzft3
        NzEEK6GZ9eThmQNJAZ2qwKqE3RQnIgdi5bzritBbeL8k7Z4uaqvRBgs7nC//ELG0
        +8keKTfSIAlsvvLmQgqzjSIX4oG9R5B1zvxJyEKE/5iGt1mdm+pQO+2SoDl12O3M
        j5krO7MQQgFns5Rd6rXn7bEuC5UGnEofB2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GeTeiPCJAdDY for <linux-arch@vger.kernel.org>;
        Tue, 14 Mar 2023 18:23:42 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt2M4kD6z1RtVm;
        Tue, 14 Mar 2023 18:23:39 -0700 (PDT)
Message-ID: <7453aba3-9f2a-4723-3039-a85652883b48@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:23:38 +0900
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

I do not see HAS_IOPORT=y defined anywhere in 6.3-rc. Is that in linux-next ?
There is a HAS_IOPORT_MAP, but I guess it is different.

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

-- 
Damien Le Moal
Western Digital Research

