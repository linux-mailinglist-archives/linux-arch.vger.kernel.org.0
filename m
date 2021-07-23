Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17623D3A67
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhGWMD6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 08:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWMD5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 08:03:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4AD260F36;
        Fri, 23 Jul 2021 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627044271;
        bh=I8EG8KvdkCZRoKrlaYWdZuQlSurV1+XMVadCAjX5YV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nVxmkMHvcnPo9v2E4P0wQkD5Ik+U5FdrwPKUZdVAwInoplBd5SiBtgDftaE8WbUSd
         BzDFLWC46eIel1r1PDWlUs6Aa7qRa4QBxa4elUzKQ+IZiE/8G95d/2F9hgXMYEZdbj
         sMg3Wb+lKhTRCHN7stY+1Hm1oedJnMmb/UTzIC/Vk8Wp7DpG0reeVfShYalWOAASME
         GM9qN4Fvf0xu0543uk/BuTpand2x7kIefBwqsjbqNcc4Yj9KqV03mrOAWGUpjW9/0z
         6728tFNaWvzzzLYtTMR2BbywvcxIJp5tfi5cQRx10e2gbHJ+GgD00wTQ9Gtzrcn5RS
         PPsrAmO3PGAhw==
Received: by mail-wm1-f41.google.com with SMTP id b128so727887wmb.4;
        Fri, 23 Jul 2021 05:44:30 -0700 (PDT)
X-Gm-Message-State: AOAM530pEiLHbtrp3jdZkPLGXMKufU3nLI1ESMmpJg/iRvkMLuEpgQqI
        +7whXfT1cGOA3uT552r5OrFDJeASxj74HubVceU=
X-Google-Smtp-Source: ABdhPJybmE1yWKNDIQhUELIEmJrbg4IG3VwSlneVoVTxcOHKvr1IKdvANRWVax10Jjs87DppXb3M6ypgcLHba74gdzk=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr13900636wmh.120.1627044269416;
 Fri, 23 Jul 2021 05:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-10-arnd@kernel.org>
 <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
 <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com> <YPnQAksI2+YBivHb@osiris>
In-Reply-To: <YPnQAksI2+YBivHb@osiris>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 23 Jul 2021 14:44:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VDtatPx93FAa4ZUszZbcHPyX+aQWnZ2aTuL-dHZ_x5A@mail.gmail.com>
Message-ID: <CAK8P3a0VDtatPx93FAa4ZUszZbcHPyX+aQWnZ2aTuL-dHZ_x5A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 10:07 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Feel free to add the s390 patch below on top of your series.

Thanks a lot, added now.

> However one question: the strncpy_from_user() prototype now comes everywhere
> without the __must_check attribute. Is there any reason for that?
>
> At least for s390 I want to keep that.

Makes sense, I'll add a patch for that as well.

        Arnd
