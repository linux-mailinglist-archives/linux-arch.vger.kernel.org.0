Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522436B147F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 22:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHVuW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 16:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHVuV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 16:50:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FA52F55;
        Wed,  8 Mar 2023 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678312190; i=deller@gmx.de;
        bh=jgoW+riUHZiigAYb6wOad0OH+0PbUiPGc0lsDkfOFMQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CleEgxdgNqecF8/8u0t0m5mUC58mAQ4g7NYlPyknZ3H+4jKTKhedF8OmEE9NhCMCD
         9wuhH6oaUGI0SwNlyturO96w47AmsBdZRlGx5zCiLaAFLyVpGF1/kXdTYyKG8IKj0+
         JXVSS3k2yQZr24iTa6bJc/tIvr21JwjXXTL0uD04dMH/KcQx1EiH/P0ZUOHhtTZphr
         Q+QWal7T6dNozoOYvHdMr5YIV9kVQ3f93d3wI8/JxDEKGvPCOuInjAiueIbp+lBd3B
         ywaRFOLb+cJYzpOEeZcWTCeL+Dqh0d1PKCl21ENtVNh6RgQJOJ7LqzUJ1BbwpNWhHn
         myGADBgO6D4YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1qM4W01P5i-00qRAh; Wed, 08
 Mar 2023 22:49:50 +0100
Message-ID: <8b04ebe9-4073-dcd9-8d42-1e84093e1633@gmx.de>
Date:   Wed, 8 Mar 2023 22:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/4] video: fbdev: atyfb: only use ioremap_uc() on i386
 and ia64
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-2-bhe@redhat.com>
 <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
 <74915109-446a-4c1f-91bc-95dc6e3be200@app.fastmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <74915109-446a-4c1f-91bc-95dc6e3be200@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G75vQn6FwHhJiWr7cH1dVaVr5agnStDlmXhWFLJtvLq98ls7AoI
 RPhQq752jqv0SnRUVTDmjFt69rNbvlLOyvpORcjf2/cPbSJYQp83Sj7XbozrMYJlPsajDBX
 QCgzq2rXNHLuVo8f011/PeV9rWMyKXZJYVZcXc/7e4O6DauED6Ig5FyJRVsh3nJKxEd3lpc
 8d/W3S1XHOGMut2uvZ8Hw==
UI-OutboundReport: notjunk:1;M01:P0:613HBZ7HvUE=;hryudKXNhFIoRc2i8iFTI9XC0UK
 4b6kMoUr1wHO19IjfCXiPfh3vaxOR5+X5/vvv/4Mp3QkLv8u0e3zwBxZ9JgY36ok2t2o3KYv+
 PAyAkNb9MUxgxaYWqdkGAUlkLdDn8tl6LwNC8psLfK+wB4yz7+OxfgWgQJNQMEhYq26p9KbZ9
 dwhbN6KR8ChJYzU76Aq7EWT6rK3Vnu9/84QXBUeGBenPcxgoQwfo+3B/S1+jEzeaqQQa5MBLV
 3q7bGUtFoU3sR8j+O5Jxr021tF53TX0I0jso67pRi+mqErKs8IPEtcJyJ75AWMOKec7OV/Ll5
 Vvix5I2GIMznk1dc/iWgN7OiNDyNzGHUdDJlcXopNR6pGIn73EhBDlZk6dt6ldJS/FA+L0vst
 ZdFOANLDG20pwy+4GFDabgrhzm9+BOXVYUzU0i9E9ZF6+fn5u75P7a/TM8XuHrJlC3elGEb6m
 f7/L3OGuSpehl6YriqPh1dPae4IE/cWdWvZddVOgZH4Vwdm+mS6Y2g3CmXgAd6q/P8PbXe1r1
 6rK2GQRn2SUs4sFyxJWPEwCCsZVS5vw2PZhxlX78GyyPHM3lbkXzSmKmGJKCxbLoi1R6hFott
 jwihGtwy1sshx7XBqoOLnpUiyv3yw0zZuJut+ZbHjFBsv/q5RtU2Et5oB9RRu7kfjaGHsWdfL
 IuRJ7r3b9sL8CDVdLGHlanAUXJxiXqVnkQq8LLNVAb/KO/GbdqBm/T65PC+zG0ayJtLsIx7cu
 6H3scyv/s8BcSSiR7U1vlaoPA47d+KcMD7kvEC2UXhqL3dPZtjzis1fxcdxKCY/EBZGqDlTp+
 RKnwqwBN2raSeMEs/Z117F1mYdW0mJUOOUCJA03Tb/bnB7+/dkI96GbZCM+ggJmQUYSnDLKeN
 awdOQQoMISAgFIV3zvbwVoMA0ommjqq9la2X1P+vu2DnislHhxNKqWNyIgD6/dUPrgs7PfU55
 igV9VBkFlFINvuA17XazpY4UIRM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/8/23 22:34, Arnd Bergmann wrote:
> 0On Wed, Mar 8, 2023, at 21:01, Luis Chamberlain wrote:
>> On Wed, Mar 08, 2023 at 09:07:07PM +0800, Baoquan He wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
>>> extension, and on ia64 with its slightly unconventional ioremap()
>>> behavior, everywhere else this is the same as ioremap() anyway.
>>>
>>> Change the only driver that still references ioremap_uc() to only do s=
o
>>> on x86-32/ia64 in order to allow removing that interface at some
>>> point in the future for the other architectures.
>>>
>>> On some architectures, ioremap_uc() just returns NULL, changing
>>> the driver to call ioremap() means that they now have a chance
>>> of working correctly.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> Cc: Helge Deller <deller@gmx.de>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: dri-devel@lists.freedesktop.org
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>
>> Is anyone using this driver these days? How often do fbdev drivers get
>> audited to see what can be nuked?
>
> Geert already mentioned that this one is likely used on old
> powermac systems.

and the latest generation of parisc machines use it too.

In addition, on parisc machines it's also important to map all io-space
memory uncacheable. Since ioremap() takes care of it anyway, the ioremap_u=
c()
was simply referencing the call to ioremap().

Helge

> I think my arm boardfile removal orphaned
> some other fbdev drivers though. I removed the ones that can
> no longer be enabled, but think a bunch of other ones
> are still selectable but have no platform_device definition
> or DT support: FB_PXA168, FB_DA8XX, FB_MX3, and MMP_FB.
>
> These four platforms are all still supported with DT, but
> over time it gets less likely that anyone is still interested
> in adding DT support to the fbdev drivers.
>
>      Arnd

