Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0826E8041
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjDSRX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjDSRXZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 13:23:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90A659B;
        Wed, 19 Apr 2023 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681924974; i=deller@gmx.de;
        bh=C5yrQi1O5H/ZJ6i2wZhc9S+TYhhPSe8koYmOSkrsxpg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=refzFEX/nVgK8/0c/yNY2CyfC3AdkpdTH+IYk+xIV5Q+38dlY1vRhZEFTmpMyUDc/
         9kvkEZP0kVR01Hn28FwdYcvQkmsX1L9UWL+i8vZhz0goEWhOLvIAIfwTtlVmCjbgUD
         u0lHmNPk61xpVh/6OWDJbveUXhuyj8lAjtP3C/VV7CHk+16/4VihPYwuUHEvivlYBw
         UlL1VdmKWD8uIdo0Aoh5XASGCGmlY7GyOYsX3ffFnBo5KedAYvGh4FHhvglxT+KgCd
         xQN6ABCnavylRmWcBFmE/lQHqF7hO3CioLhryov1vpJhVvImQ4wtSXMt4z9yTImXug
         5i3ajdU7cJ5LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1qRYCj0P8t-00cRzi; Wed, 19
 Apr 2023 19:22:54 +0200
Message-ID: <b1f90fa4-85c7-e785-ba14-f32962f87d5e@gmx.de>
Date:   Wed, 19 Apr 2023 19:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/19] arch: Consolidate <asm/fb.h>
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>
 <5fa98536-a4b0-7b71-7342-9ba05158062f@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <5fa98536-a4b0-7b71-7342-9ba05158062f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H9qZXkCOPDN+3vsO7z+9ttDKPCRSFaiF/4cDmiO5ovofGlBxTzT
 kMlRPG3r4Q6KYGeHBb//fU40kwtmWj1gVkdx7p7FELLCFOD5Nql8qYPGjnWefhzsS88zNIK
 xaqD2s84khdceDbFsitlOpU2HidQYYXlykQQ9SD+p1IgyfdLRLZnqUmFoBDr2Oq3uB/Hpmu
 vy6bniwylk05WNGd4sCJg==
UI-OutboundReport: notjunk:1;M01:P0:5ox/8AYo9cY=;DXfWBLw0Wfb00Me5ctwgZzfIUZ/
 1GcLaW7zyF+rDR6gv5OFGKt/ECtMI2VLnGHaGgup0zhzHr7BbEMURzdNk4ut1hQ/I1Ur1dsc0
 1JvQBABCmnEIVKxSHIzxSDISBJC4Qap+OiyTLFMWZ9un0xA1yRdsUs2M1yt+a2EqGcCluQlae
 19JYqGAwJcB9zy4M2luWaDfLR+ZKhj9ZKj8YSY34zxXwBPDgYmXrjwHYmJ4VTpPq9lQoP7XYz
 zFNmrhEsoPBmtBzXWAha6jdgOhp/DgbHDRiAP61aoHFFNbzRmhAGM4NsKuWZgVMGEWTXl21UX
 RWqLtp/2wf2qeOu3egFZaXc8jYCWg1NlAIcF9HZ3295DdF25gExyuV9did7VXP77oNQQ+QXPc
 fhCOeNGtft8Mand8MEWSS+3kWNhuIfz07igr9+fsGtxP3ysYKTaY3WPhXV0YMVT8Bep0brJsz
 it0ElaUn+GMQsDuKpgWJIn6dE2RbkRjrP0KTWEny7DHSk8JEWgia6+A8qE0EY++w+1sCntVun
 q6L6YvL6bob4Q1BUg6FQGSTaWbEOj1aXk0c3aEh6x+vXVvTOLaLYYUvW1lFtPoRMygYgZx4wQ
 rJN3kennM/9oLujbd5BqjhpxyFEKAHVCVXS45wO+oSJnirRTWt+IU+XGjNEY0ptfkn3mN4x/q
 kvGcY6cnurtogkHbIzoeA9JDtK7wJr1dYuVhIbxaw4ROiwNGBzb/BR3lIpmxi2xnCf7zxwLP8
 po9pTOMtKhkJLo/DaIoVdM7R07TLStHRQWeCtVEbKyLKDvKxPjppGZ6s5Tz5A6AXYgiSFhuW4
 cGKpK8tRgRhTmcAGp6W5xqVoysF2XWyW46xmjytoEwKEd8r8g4J//wzQ3dLfMvZ9GduabVyKy
 Tq5+OYpXodvPTj/P2JbKEivhf9ZtS7PrHr8f0DO4nsV7nYIV9I/xwMZ3jymGdPYzWNpnTiyox
 UXVSng==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

> Am 17.04.23 um 16:12 schrieb Arnd Bergmann:>> On Mon, Apr 17, 2023, at 1=
4:56, Thomas Zimmermann wrote:
>>> Various architectures provide <asm/fb.h> with helpers for fbdev
>>> framebuffer devices. Share the contained code where possible. There
>>> is already <asm-generic/fb.h>, which implements generic (as in
>>> 'empty') functions of the fbdev helpers. The header was added in
>>> commit aafe4dbed0bf ("asm-generic: add generic versions of common
>>> headers"), but never used.
>>>
>>> Each per-architecture header file declares and/or implements fbdev
>>> helpers and defines a preprocessor token for each. The generic
>>> header then provides the remaining helpers. It works like the I/O
>>> helpers in <asm/io.h>.
>>
>> Looks all good to me,
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks a lot. I know that Helge wants to test the PARISC changes, so
> I'll keep this series pending for a bit longer. I'd like to merge the
> patches through the DRM tree, if no one objects.

Yes, patch is good and I've tested it on parisc. Thanks!

You may add:
Acked-by: Helge Deller <deller@gmx.de>
to the series and take it through the drm tree.

Helge
