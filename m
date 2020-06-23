Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4A1204A45
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgFWG4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 02:56:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgFWG4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 02:56:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M5fdC-1jm0260U2c-007CHn for <linux-arch@vger.kernel.org>; Tue, 23 Jun
 2020 08:56:40 +0200
Received: by mail-qk1-f172.google.com with SMTP id e11so8631318qkm.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 23:56:39 -0700 (PDT)
X-Gm-Message-State: AOAM530QUi46V4ewTmF60yy/U8paIoc5iluM4l2Va/Z2XFivfwsR0T12
        RcwNcH6ArYGHxcCFVgOdq4vp0Ct0z3p+z0zUyug=
X-Google-Smtp-Source: ABdhPJxa2+TOpjWSNBFQh4ORnAOuczjafwO1hp+G7ubyZxE7unsIrvQLxmB043A7QKCJDsh4ytyvqfKIAY/I2ZdTRog=
X-Received: by 2002:a37:a496:: with SMTP id n144mr6451690qke.286.1592895399018;
 Mon, 22 Jun 2020 23:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200623135714.4dae4b8a@canb.auug.org.au>
In-Reply-To: <20200623135714.4dae4b8a@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Jun 2020 08:56:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34mMnZa3FWaZ6tCRZBEQuhUNNaHsFjXZC+Xe_hnoxdxw@mail.gmail.com>
Message-ID: <CAK8P3a34mMnZa3FWaZ6tCRZBEQuhUNNaHsFjXZC+Xe_hnoxdxw@mail.gmail.com>
Subject: Re: [PATCH] make asm-generic/cacheflush.h more standalone
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XngcjERjIeCcgfQF8aOjZywZ1/FdemzJjeu+9rIURn3R2PJY/MX
 7bA7ov50fk/ifWiJCOv6Ok93GHAcpNor9Cm6uyXAGPF3LwsidYC7/dMx7YcfxzIKiI0nGv/
 8OLCsGskea/0Kq7Jm+5tcnv/4KIML5cECWWHwfnP9slajWJRS4KXf2nI+28yt4CD9ieYEKM
 uRQKVaj5BPWjl1PNXTRbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGCSUJ2HeuQ=:wGt44gb1EWkO6hVyHwmWGh
 X3Vh5q678Rt1HGfoSYy1WGXno2GOf/OLUfHOmH7u3OsM5+dwEDTycVaU4t0Gww2XNn2fpWQI9
 CsG74+xxaLGDyeIseRO1acYOinCCVwjOzTfuFgOWNxc+e3E427gbu93QkjfsUpj5rD8ow1Gjf
 SG92umlncRNK35n9czzYblPZi3BYaDKzdstL4oX35jbrkvcJ6tGnxl7kZDWYLnW0tX9bTPRZE
 YJqiOi55DHTmwH2NrpJSHbAH2qwO/rSvGNuL5Vq+0zm9iYWeZESitXmsL81kVuC8gNxpdf0m5
 FfRG+IIRYw+7XyH/36SAxg3YiGjoD/9Iqohgs7035Zta2h2MI7zoJOkxGgY3LW0qSyAlay2MA
 V9qFSaA7DuT+IJlwP3hedMI91BpPHrsecxEJp5DLDy5wQNRr6cTvznx2/lXA+HPF6JFXKoLwc
 3m/TOHsJsDq4vPvqrLWh3VOLJS6qKTXoQxR/XjQM9vOdrsv7cFX895pMrGepylTEzFoh7JuQQ
 EcMxABYPP8hwzhja1xH//0wy6EnlgkABsvR+d9bCVWYa3LmBBRRxhpGchfifObJA/jZHyqs93
 yHepdmSpTb/JaXXFV77km4/6X3UlwCtlVGM58kgPu0TcCGTZ2YNo2mHEXIcKOKZxKBqmXlfzy
 F98GbrsoQxMKCF9f9hOoPlohY/Rnz74LW6Hf3GRhP7u8P0XvEHyKUx9Qh/jtf/4mAnfXywzuQ
 glr2PrQLw7pQ1koUiyfgW+RpYVaPIcf9RAmkMFvL1wTdnSNn9WAPVCz9AzaQ5MQdHqs0J+jRQ
 u4DiIlOhhry+WbJ1fRpWyZI5w+r6QtO5wCVlmryQy4J+aApqZA=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 5:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Some s390 builds get these warnings:
>
> include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:22:46: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:28:45: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:36:44: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:44:45: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:52:50: warning: 'struct address_space' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:58:52: warning: 'struct address_space' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:75:17: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:74:45: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:82:16: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
> include/asm-generic/cacheflush.h:81:50: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration
>
> Forward declare the named structs to get rid of these.
>
> Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
