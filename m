Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A2B1B2C03
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDUQM5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 12:12:57 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42832 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUQM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 12:12:57 -0400
X-Greylist: delayed 150238 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 12:12:55 EDT
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 03LGCekp020474;
        Wed, 22 Apr 2020 01:12:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 03LGCekp020474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587485561;
        bh=BOK4GJk6lNAkiI6IDH+s6d6MtXYf70lyowyocUXT72c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mw32Y8mKjVvb7z4EktZyDrmoyglbEDKnp13uCbKcWcnJddeET/eVNTheVoA9YnIHf
         TMdIlZGv7Cmr7ovsKz8cuJvOv/O7uJ4fZXgcGLG/5dW2fxO+Dhkjoe6+9FGFlOiGyt
         pUZtAL+8BYzAzERzHvmPfk3XQhCLR5SBl2nzz5QjKJiQX0L8hTqWQRqiq7Oxb7Rffh
         aNaKsh5fERspl8K4rqoSSxVRQLBxRJgtKXg6svOnkMFnIP0Ls/aGuFVFPecrPTGJ53
         SpgdLSbcT280wSRBzJM1H0VoPcHbWBgGmHjl0wG1j6FzAIz/0U7ITdybuSj8j/v7+J
         f0X+9RVumY2rw==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id f7so1606230vkl.6;
        Tue, 21 Apr 2020 09:12:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZfexYeb1AtTpiXxBITOvGY13L9ovqnjzDRn7ILC0BiDCatKqri
        F52zHP1fqFS/y6+thiIA15YokbCzOS+UX1r5nuM=
X-Google-Smtp-Source: APiQypJI+pUyv3Bc1PqCLhSPKkJ8B/Zvm2eRwcJb4kn/U1qeaRikieZ17KGnPDYDyNAabqKt/aIKsKB1iHXajx/yjew=
X-Received: by 2002:a1f:d182:: with SMTP id i124mr15305782vkg.26.1587485560166;
 Tue, 21 Apr 2020 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200419222804.483191-1-masahiroy@kernel.org> <202004212303.QGojecQx%lkp@intel.com>
In-Reply-To: <202004212303.QGojecQx%lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 01:12:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKocVHOSSiEJ4BH+YQcoEt1-p8yXdRwsesGUoQwU8+OQ@mail.gmail.com>
Message-ID: <CAK7LNASKocVHOSSiEJ4BH+YQcoEt1-p8yXdRwsesGUoQwU8+OQ@mail.gmail.com>
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 12:56 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.7-rc2 next-20200421]
> [cannot apply to arm/for-next arm64/for-next/core ia64/next powerpc/next jeyu/modules-next arc/for-next tip/x86/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/arch-split-MODULE_ARCH_VERMAGIC-definitions-out-to-asm-vermagic-h/20200421-194238
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ae83d0b416db002fe95601e7f97f64b59514d936
> config: nios2-3c120_defconfig (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=nios2
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/vermagic.h:6,
>                     from net/ethtool/ioctl.c:20:
> >> ./arch/nios2/include/generated/asm/vermagic.h:1:10: fatal error: asm-generic/vermagic.h: No such file or directory
>        1 | #include <asm-generic/vermagic.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>


Thanks.
include/asm-generic/vermagic.h is a new file.

I forgot to do "git add include/asm-generic/vermagic.h"



-- 
Best Regards
Masahiro Yamada
