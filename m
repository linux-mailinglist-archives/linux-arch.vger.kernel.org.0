Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E36AC8DF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFQ7b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 6 Mar 2023 11:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCFQ73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 11:59:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716FA2915E
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 08:58:57 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-eKtrbf90My6ZKBR6Hk0zIA-1; Mon, 06 Mar 2023 16:58:01 +0000
X-MC-Unique: eKtrbf90My6ZKBR6Hk0zIA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 6 Mar
 2023 16:57:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Mon, 6 Mar 2023 16:57:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Huacai Chen' <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Subject: RE: [PATCH V3] LoongArch: Provide kernel fpu functions
Thread-Topic: [PATCH V3] LoongArch: Provide kernel fpu functions
Thread-Index: AQHZUBJ45VTcAaETSEKOkFhUUQ2cwq7t95nA
Date:   Mon, 6 Mar 2023 16:57:57 +0000
Message-ID: <5171500c01604a70b55529d8cd780a57@AcuMS.aculab.com>
References: <20230306095934.609589-1-chenhuacai@loongson.cn>
In-Reply-To: <20230306095934.609589-1-chenhuacai@loongson.cn>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Huacai Chen
> Sent: 06 March 2023 10:00
> 
> Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> to use fpu. They can be used by some other kernel components, e.g., the
> AMDGPU graphic driver for DCN.
> 
...
> +void kernel_fpu_end(void)
> +{
> +	if (!this_cpu_read(in_kernel_fpu))
> +		return;

Shouldn't it be better for that to be a counter?
Not sure what anyone else does.

> +
> +	if (!is_fpu_owner())
> +		disable_fpu();
> +	else
> +		_restore_fp(&current->thread.fpu);

Does that actual do the restore?
You really don't need to do it until 'return to user'.
That will speed up a subsequent kernel_fpu_begin().

If fact, couldn't kernel_fpu_end() just be preemt_enable()?

	David

> +
> +	this_cpu_write(in_kernel_fpu, false);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(kernel_fpu_end);
> --
> 2.39.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

