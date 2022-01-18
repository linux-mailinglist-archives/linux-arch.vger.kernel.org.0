Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F234920F5
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiARIJD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 03:09:03 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiARIJC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2022 03:09:02 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnJQq-1mQjd93nCG-00jLy4; Tue, 18 Jan 2022 09:09:00 +0100
Received: by mail-ot1-f45.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso23176086otr.6;
        Tue, 18 Jan 2022 00:08:58 -0800 (PST)
X-Gm-Message-State: AOAM532fK7b9r2MQpFYeHxUhEZWuwrAtssHkw2podjFcPSr4466Mo9BB
        ODCbufzb+b+yNetPHpg0G/w9K3nUrghvsNYorWk=
X-Google-Smtp-Source: ABdhPJydwgmux0eMV8HI8b9BdklNP+7LV2ch1rDgfPNeEtqq30DY58YS5CzATVJf7L4CaVG1qsRotI3Rplk0R7Z1cCo=
X-Received: by 2002:a05:6830:2095:: with SMTP id y21mr17140172otq.368.1642493337643;
 Tue, 18 Jan 2022 00:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20220118044323.765038-1-walt@drummond.us> <20220118044323.765038-2-walt@drummond.us>
In-Reply-To: <20220118044323.765038-2-walt@drummond.us>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jan 2022 09:08:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ohW+w8_A8qMNqxpTmFcvxQr+z9YR96RAu5-wtdG_5+g@mail.gmail.com>
Message-ID: <CAK8P3a0ohW+w8_A8qMNqxpTmFcvxQr+z9YR96RAu5-wtdG_5+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] vstatus: Add user space API definitions for VSTATUS,
 NOKERNINFO and TIOCSTAT
To:     Walt Drummond <walt@drummond.us>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, ar@cs.msu.ru,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>, linux-ia64@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jroLeFEX00jpZO68/IoXmOXHzWxP7+RGfe7zZU/LWVRAmJVnGNv
 gfoJ7rRgSe65YOQp/O3YEeGDAfFcsSjHHsUjkcqrszvHWg5gBHfk3A3YFhGq/FHJpavxKjU
 roGZKdTzpl8vLd/uu2J1imMm3MThe3zqsntL/I34IuX5wJpdmQaX9h4PjCqbe58qz7w1Fkf
 7f/exEH7NfiMcGfZ1sIcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wB2+zO+N3vY=:/xxomx9nt6MxOycubjZZYy
 xJGx9bTbvBhoDW38MMyjlL1FygVKIiNX15B07KZWwWYDLLJz5Qku+J61UsgVvA+NZ2ybs0GTy
 ZThv/7qJhh1Vo6vVUeLE8qwK7QH7nwP+SBbe43yzNoQTwN3N8h8UYUxFBjFCWb0LFypjiGskc
 39NNBA/L6Cz+Ch+Kv1bGxsBLTIW7DpcqdijUrHfO3A8J9eTXT2MizvislYR3E4y2HF7kgBLDz
 wUz7d5vMGdv//PxHcmbDb69S1gpg32Ztb/INYb5oKX3vdo/xe5ynUS6QCFDDQuWw3JMgGl6IN
 GyICh17QWiGK/CU10BoUnaW9B7RXdZrlQZ4WrNPR5uGj1J62hRhk28AGveSizBc/tsOfjSFiN
 j++m5AIktQRGC+4mdSYmKzkcb3/zOpuYyygnk901obnlGL/eJ58/svq1M1oRu5sPVqj2RW+46
 qjNYKZs0TWBWBGIMcqjYhKGufFKxKkktY+7FKDVBB+I3lFTANKXbAQE6BJEiqDm1AWzFwoGRP
 9oiyqtz8/3RlWgmHFlnI/gDVMQN4dXCkzuZD2kYsbvljhXqNrk7JPpOd3NWdNlGEQsTMvW+ll
 ovhpX0MuYPTEH0ZtZHoH4XloLH7cKpCTNPod40yg8aU55seCw2dAOv0K8/reVbpYyH5qxBQdW
 a23XMaPEBbU95U38zuZOC4N70hkYFlj0a+ViEb3T/N/WUSxHE6GtWsiGkaqeSZnZgxSHWJ6Dd
 6HcU+2t0DTvSOTzpVKcEKtgtPYyOPizbAv8lWFtKKwYyHhzUMEO2yEX/Kb3AjoAUIbzr6ecKV
 T6BJ/0OKJ+D9Hlbef17QLHHCP5aDTXghnUzlddHSLWeuiHhpJQ=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 18, 2022 at 5:43 AM Walt Drummond <walt@drummond.us> wrote:

> diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
> index cdc9f4ca8c27..eafb662d6a0e 100644
> --- a/include/uapi/asm-generic/ioctls.h
> +++ b/include/uapi/asm-generic/ioctls.h
> @@ -97,6 +97,7 @@
>
>  #define TIOCMIWAIT     0x545C  /* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT    0x545D  /* read serial port inline interrupt counts */
> +#define TIOCSTAT        0x545E /* display process group stats on tty */
>
>  /*
>   * Some arches already define FIOQSIZE due to a historical

I don't see any advantage in using the old-style ioctl command definitions
here, and looking through the history of this file, all recent additions used
the now normal _IOWR() style macros, so please use those as well.

       Arnd
