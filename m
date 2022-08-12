Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24D59179D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 01:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiHLXWm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Aug 2022 19:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHLXWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2022 19:22:41 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5EA3478;
        Fri, 12 Aug 2022 16:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 27CNLclP771159
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 12 Aug 2022 16:21:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 27CNLclP771159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1660346502;
        bh=a9ddSviliS23TcDabYjsFwvn9niNE8rduQteZQoYXyc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Q4m6p7cmO1JH9bpaMR0s5IdhftlYiBd37ns40oMzBHvKqO4OJLwb1k0D/4cueNjJD
         fC+DA2UQ0/V1/bOT4v9PTrzwhxnmg+XzPZ2qb6j+vidqIHsA7nNTpokYqUyHqnGf5I
         XiWmupArPOwFXE8R4x9rTDVLRoXoV1CSLdwf5HL8g6iQLL8w8xG+Aw/8s6V+z2/QWL
         mHU4X69K2x5aFb1YuCsJSvXNCCTK9068S29ZoYfXDYeLUiRAi9qfwuwunqibefUPDp
         CFqxAyyCWy5qHdqLPCo15C9FcNjkU9SXyJcFfLumAsG+zS6myyg4VrA8RfHGdaGBCL
         77XvyLayu1eQw==
Date:   Fri, 12 Aug 2022 16:21:36 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHp75VfFQe3Ce-Si1sax8CCG1-rq+Y=8JhwH=82d3XgytCAmOQ@mail.gmail.com>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu> <C1886F9A-1799-4E3D-9153-579D31488695@zytor.com> <CAHp75VfFQe3Ce-Si1sax8CCG1-rq+Y=8JhwH=82d3XgytCAmOQ@mail.gmail.com>
Message-ID: <B4A6C65C-1480-4D20-9A0C-D97BEABC838F@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On August 12, 2022 2:58:36 PM PDT, Andy Shevchenko <andy=2Eshevchenko@gmail=
=2Ecom> wrote:
>On Thu, Aug 11, 2022 at 11:12 PM H=2E Peter Anvin <hpa@zytor=2Ecom> wrote=
:
>>
>> On August 9, 2022 3:40:38 AM PDT, Christophe Leroy <christophe=2Eleroy@=
csgroup=2Eeu> wrote:
>> >At the time being, the default maximum number of GPIOs is set to 512
>> >and can only get customised via an architecture specific
>> >CONFIG_ARCH_NR_GPIO=2E
>> >
>> >The maximum number of GPIOs might be dependent on the number of
>> >interface boards and is somewhat independent of architecture=2E
>> >
>> >Allow the user to select that maximum number outside of any
>> >architecture configuration=2E To enable that, re-define a
>> >core CONFIG_ARCH_NR_GPIO for architectures which don't already
>> >define one=2E Guard it with a new hidden CONFIG_ARCH_HAS_NR_GPIO=2E
>> >
>> >Only two architectures will need CONFIG_ARCH_HAS_NR_GPIO: x86 and arm=
=2E
>> >
>> >On arm, do like x86 and set 512 as the default instead of 0, that
>> >allows simplifying the logic in asm-generic/gpio=2Eh
>
>=2E=2E=2E
>
>> This seems very odd to me=2E GPIOs can be, and often are, attached to p=
eripheral buses which means that the *same system* can have anything from n=
one to thousands of gpios =2E=2E
>
>Basically this setting should give us a *minimum* GPIO lines that are
>present on the system=2E And that is perfectly SoC dependent=2E The real
>issue is that the GPIO framework has these global arrays that (still?)
>can't be initialized from the heap due to too early initialization (is
>it the true reason?)=2E
>

Ok that makes more sense=2E=2E=2E but in that case, it would also be good =
to reclaim excess storage that turns out to not be needed=2E

I am a bit skeptical, though =E2=80=93 we get basic memory allocation very=
 early=2E
