Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13259814B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiHRKI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiHRKI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 06:08:28 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2F2A95A;
        Thu, 18 Aug 2022 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1660817302;
        bh=8XW81CUn2oeQJ4cm15WgLH7GNC5QLoHNIYDR+6XISNU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bvUQrlmnwhrMixyBCL1Q6QI5Bx1R75U3r4PHSaMgBT1vhtrmrlGBt9VH92LsUMAJI
         gCLmGSorCp21DCm75QUeyv9utHj+zYcxQ6yDXE0xF0lAj/v74cMAxija89s/WXS7oS
         IhWcSQNp3cTLjQbzPvaaQDaCOmgf9edsrM/Dif8U=
Received: from [IPv6:240e:358:11b1:ee00:dc73:854d:832e:3] (unknown [IPv6:240e:358:11b1:ee00:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 94BF066956;
        Thu, 18 Aug 2022 06:08:15 -0400 (EDT)
Message-ID: <ce96bcc9bf0aa24d1be5a91d07e6e7515c4d0c33.camel@xry111.site>
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Thu, 18 Aug 2022 18:08:09 +0800
In-Reply-To: <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn>
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
         <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2022-08-18 at 15:08 +0800, Jianmin Lv wrote:
> I don't think we need the driver any more, we have thermal zone based=20
> acpi which implemented more functions include the function here.
>=20
> And, the driver will conflict with acpi thermal=20
> driver(drivers/acpi/thermal.c), which leads to confusion with users.

Hmm... I reverted this in my local tree then the CPU temperature
disappeared from /sys/class/hwmon.  I have CONFIG_ACPI_THERMAL=3Dy.  Am I
doing something wrong or we need to wait for a firmware update for the
ACPI thermal zone device?


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
