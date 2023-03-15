Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521026BC1F1
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 00:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCOX7A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjCOX6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 19:58:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26A6153B
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678924720; x=1710460720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kgkn81sm7NRXOWlx9WugG0VfUhPksFZvAliPQZFpRVQ=;
  b=AEw+9Yt+3/wroJWxgx7vv/EVTnmNcXQ9BWyckGM8CMKZoEZBI3PlIcdo
   ofz0DGgZh3reJWJW04ZQGrj69Ykt1QtWAEPBT9Yfwo3w8leMdsScvE8bS
   CKQuFpds6we5PO9o+hS3/wH7qnKeoyPKP1HzJX87toLMgfmlVCA4SS0Qh
   i6CrptkZUglVVlsEZELo0z412B4X7f0IiAEpEdf5Z0BgpK5PjqeCtx0t7
   9VN5g/X2Ezoh64VJ/fnUil8colEVgY/ofZr9OBG9Jp3ohipuRnwKHJqz1
   fE3rtAH2z7G1W7LI8e8yDlkb9DnXduclN/KgbsdNBIp7ASA3Dj43S0UYq
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="230684079"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:57:46 +0800
IronPort-SDR: 9dnefkx6RrTVgOMeAWRj2yP3kEtb0gFTm0zbsF0HGk4Y0LhhrZTxO5Ex/Gj42mjMuH4QDEsFYR
 5MGEVYe5D4JSQAyhgW1TdEYGMSJvdVOznqF3ZQZs6eDZndqjb6IjCbYF5z4p/Jn+DmGoVdjfR0
 /vX5zsOiZZuSsNDDpSzLsbHaKN1A0+bsYoYuMCoox6E50PbavwQpBz/LDuKCzFJJ8/Mi+3NqK7
 FD/K0ckUkkVC/sW43NyCCGnLyVm/0r23UoAo64UYPdzNeM5jRtSOAZvHyfPmq23hCBM9+klLsv
 xF8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:14:12 -0700
IronPort-SDR: /O7QfXgdT228L10qrQqm1/2OiTK6dXKqZQov+EWmHEYw5WSVzE0YRrRuufhkRF6Qr7gyRIdRS/
 IE/nhQKFCLRqIUGVbjvGqB2YiLx88VdzZlSupExGNpp8KV9UTDSm3eEWnJc/0faMdGXpUOnCz1
 brxtoTfIAwjkEk3/onokxcEhG8o/arclz4UJDtWPZFg9Rx1k0R7m+UWATmBA6VsaNeXJve7ynu
 ZxqsUWjjUWgj2OnWMTI5JsPuJNLq4wo0UlLuH13VwrlBghfeuiOUiRQQTPhIdaFvntkG7ACAlp
 4CA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:57:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcS4n6Vsfz1RtW1
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2023 16:57:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678924664; x=1681516665; bh=Kgkn81sm7NRXOWlx9WugG0VfUhPksFZvAli
        PQZFpRVQ=; b=IJtu4gmgw/ynZRHEPjr86PzZEB+9IZ6sFhO3BWek4topABF4AL6
        v3GWhfKBe54UfpGLOFp+QZ0207SarBzrk31qIPDeSsCcTa1sVE9ZQ2bmJGtFKrQD
        FTxO22grvCPJxXI7W2DeuOYT8tAJsT0Ehs3tnsW/CNixYYLG4uGJQYpmZPWIICSm
        jZ/bMPo0r6g5G1+7XnM0IvrxSu5M39QdCyQrQKQ7lNJQd6/WQ/pI30xDh1byrzFN
        HtEWyRNwRo0z0eh3wHvYGoB+TqsYLrPr0WwsolzG75dRQ5uqCaymbGeWw1+QmoEM
        kajt4jFnk5yN3q/hsvMJwI3BTonbXZ3jdig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QTN9X7zl_XGB for <linux-arch@vger.kernel.org>;
        Wed, 15 Mar 2023 16:57:44 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcS4k216nz1RtVm;
        Wed, 15 Mar 2023 16:57:42 -0700 (PDT)
Message-ID: <9a1c49b0-2271-53c7-7f48-039f83d39e82@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 08:57:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
 <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
 <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
 <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/03/15 20:36, Geert Uytterhoeven wrote:
> Hi Damien,
>=20
> On Wed, Mar 15, 2023 at 10:12=E2=80=AFAM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>> On 3/15/23 17:39, Geert Uytterhoeven wrote:
>>> On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@lin=
ux.ibm.com> wrote:
>>>> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fri=
ends
>>>> not being declared. We thus need to add HAS_IOPORT as dependency for
>>>> those drivers using them.
>>>>
>>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/ata/Kconfig
>>>> +++ b/drivers/ata/Kconfig
>>>> @@ -342,6 +342,7 @@ endif # HAS_DMA
>>>>
>>>>  config ATA_SFF
>>>>         bool "ATA SFF support (for legacy IDE and PATA)"
>>>> +       depends on HAS_IOPORT
>>>>         default y
>>>>         help
>>>>           This option adds support for ATA controllers with SFF
>>>
>>> ATA_SFF is a dependency for lots of (S)ATA drivers.
>>> (at least) The following don't use I/O port access:
>>>
>>>     CONFIG_SATA_RCAR (arm/arm64)
>>>     CONFIG_PATA_FALCON (m68k/atari and m68k/q40)
>>>     CONFIG_PATA_GAYLE (m68k/amiga)
>>>     CONFIG_PATA_BUDDHA (m68k/amiga)
>>>
>>> (at least) The following can use either MMIO or I/O port accesses:
>>>
>>>     CONFIG_PATA_PLATFORM (m68k/mac)
>>
>> But for these arch/platforms, would there be any reason to not have HA=
S_IOPORT ?
>> It is supported right now, so we should have HAS_IOPORT for them.
>=20
> That's the point: on Amiga and Atari, HAS_IOPORT is optional, and
> not related to IDE support. On Mac, it is never present.

Ah. OK. I see now. So indeed, applying the dependency on the entire ATA_S=
FF
group of drivers is very coarse.

Niklas,

Can you change this to apply the dependency per driver ?


--=20
Damien Le Moal
Western Digital Research

