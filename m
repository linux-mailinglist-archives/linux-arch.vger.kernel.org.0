Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6E3D250E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhGVNVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 09:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhGVNVX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 09:21:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2101B6128A;
        Thu, 22 Jul 2021 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626962518;
        bh=RmFOlaV6cy8f6I9NP3ukwHIYeNH7OwEP2FaF3KMVtFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAJNHnFo1L7vDVOiC5UpRkaDx4pid4TNdNlKZLrXeCR+FFSWM3S5SOfKHU3NBCcgi
         x/mbKRZuCP5sBZWLRH0QyC3jTezIcTdgPNuJkn722HgIPBdCNBSTL40ELD6XBnTs/y
         1ZjVc7/Oq6j6jnQceie9Da0nul67XzXgLTZj2GmS3GDKLgwa7unHRN+n/B9s9iygfR
         gHGpjMzt0PFMYc3FrdBQF57NRhZXStlwHBGM47znuAnJK24bV4xEdnVgYTuM2O9Q9l
         cPPu7vcO0sT3ruel4hr978oxdF6OQbMo96r5w0ZtG5V3ocVCUbJ85hWT9lKdyIIY8o
         uhvj1YnfZDenA==
Received: by mail-wr1-f42.google.com with SMTP id c15so6078609wrs.5;
        Thu, 22 Jul 2021 07:01:58 -0700 (PDT)
X-Gm-Message-State: AOAM531dTsLBoyXY46jXwvz5czFANrce3/1ohs2mSfcIRgYYh2V2YWfX
        anOKN93+gKWUubFcGJ5kbFbKeL8DFH7/BeQeBE0=
X-Google-Smtp-Source: ABdhPJwKEmOULt07FXrSo8OqydMhW6AyGqw3Y4ZL7MXTHJEhxOwFXM5UwB4aLTKy+iIlhqkT2HtTedqadCpqLwCc8hw=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr49853wrq.99.1626962516717;
 Thu, 22 Jul 2021 07:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-10-arnd@kernel.org>
 <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
In-Reply-To: <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 22 Jul 2021 16:01:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com>
Message-ID: <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
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

On Thu, Jul 22, 2021 at 3:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> >
> > The remaining architectures at the moment are: ia64, mips, parisc,
> > s390, um and xtensa. We should probably convert these as well, but
>
> I'm not sure it makes sense to convert um, the implementation uses
> strncpy(), and that should use the libc implementation, which is tuned
> for the actual hardware that the binary is running on, so performance
> wise that might be better.
>
> OTOH, maybe this is all in the noise given the huge syscall overhead in
> um, so maybe unifying it would make more sense.

Right, makes sense. I suppose if we end up converting mips and s390,
we should just do arch/um and the others as well for consistency, even
if that adds some overhead.

      Arnd
