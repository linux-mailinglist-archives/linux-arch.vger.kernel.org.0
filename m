Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A855FA81
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiF2I1p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 29 Jun 2022 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiF2I1b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 04:27:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E592D3D1C7
        for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2022 01:27:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-87-5EtqUqn2NCqq8mpFHFTvfw-1; Wed, 29 Jun 2022 09:27:20 +0100
X-MC-Unique: 5EtqUqn2NCqq8mpFHFTvfw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 29 Jun 2022 09:27:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 29 Jun 2022 09:27:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'guoren@kernel.org'" <guoren@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary
 atomic_read
Thread-Topic: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary
 atomic_read
Thread-Index: AQHYispbyiGvvAChcUmlft7kGYjTZ61mDYUQ
Date:   Wed, 29 Jun 2022 08:27:19 +0000
Message-ID: <8eaf85d4e4d9401ea187366de12e7269@AcuMS.aculab.com>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-2-guoren@kernel.org>
In-Reply-To: <20220628081707.1997728-2-guoren@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: guoren@kernel.org
> Sent: 28 June 2022 09:17
> 
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> because the value has been in lock. This patch could prevent
> arch_spin_value_unlocked contend spin_lock data again.

I'm confused (as usual).
Isn't atomic_read() pretty much free?

..
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..f1e4fa100f5a 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> 
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
> -	return !arch_spin_is_locked(&lock);
> +	u32 val = lock.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));

That almost certainly needs a READ_ONCE().

The result is also inherently stale.
So the uses must be pretty limited.

	David

>  }
> 
>  #include <asm/qrwlock.h>
> --
> 2.36.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

