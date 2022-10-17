Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21D600FFA
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJQNLe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 17 Oct 2022 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJQNLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 09:11:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDA26E7
        for <linux-arch@vger.kernel.org>; Mon, 17 Oct 2022 06:11:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-pP_sGcqFMfKL-aotPu7y3w-1; Mon, 17 Oct 2022 14:11:26 +0100
X-MC-Unique: pP_sGcqFMfKL-aotPu7y3w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct
 2022 14:11:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 17 Oct 2022 14:11:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Huacai Chen' <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] LoongArch: Add unaligned access support
Thread-Topic: [PATCH V3] LoongArch: Add unaligned access support
Thread-Index: AQHY4ieF1YXwdHBLG0is9Yy/swO7xa4SjkhQ
Date:   Mon, 17 Oct 2022 13:11:24 +0000
Message-ID: <39ea2a6fee654b68974ef38237a61e80@AcuMS.aculab.com>
References: <20221017125209.2639531-1-chenhuacai@loongson.cn>
In-Reply-To: <20221017125209.2639531-1-chenhuacai@loongson.cn>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Huacai Chen
> Sent: 17 October 2022 13:52
> 
> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> Loongson-3C5000) are configurable whether support unaligned access in
> hardware. This patch add unaligned access emulation for those LoongArch
> processors without hardware support.
> 
.....
> +	} else if (insn.reg2i12_format.opcode == fstd_op ||
> +		insn.reg3_format.opcode == fstxd_op) {
> +		value = read_fpr(insn.reg2i12_format.rd);
> +		res = unaligned_write(addr, value, 8);
> +		if (res)
> +			goto fault;
> +	} else if (insn.reg2i12_format.opcode == fsts_op ||
> +		insn.reg3_format.opcode == fstxs_op) {
> +		value = read_fpr(insn.reg2i12_format.rd);
> +		res = unaligned_write(addr, value, 4);
> +		if (res)
> +			goto fault;

Are those right?
Shouldn't something be converting from 'double' to
'float' in there?
And generating SIGFPE (?) if the exponent is out of range.

(And the same for write_fpr().)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

