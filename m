Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D244D73CDBF
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 03:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFYBP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jun 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFYBP6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2023 21:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED17180
        for <linux-arch@vger.kernel.org>; Sat, 24 Jun 2023 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687655713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiamuhZaAd4YgPQ9PfX/2grjHw3MqsEpAzaxP15cekg=;
        b=KRczND47c5a25E3MUM9+NLhMXAy8IkgKUuny3Rg2+4pPuhFzUjYc1xg96RHQ5Blb0ps9Jq
        aJB/cF6XMio8swNctYnrQaiVIjxPoWBnjdhUx2gFfmKOAU+x8DwprIjd0hBYK/s6jz1IAI
        /777F2DZbDalYXJesMbutnLnpgy0Gu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-6J9cT1aAMAOGf3KidcVA5Q-1; Sat, 24 Jun 2023 21:15:10 -0400
X-MC-Unique: 6J9cT1aAMAOGf3KidcVA5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AE398E44F9;
        Sun, 25 Jun 2023 01:15:09 +0000 (UTC)
Received: from localhost (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0978B200BA8B;
        Sun, 25 Jun 2023 01:15:08 +0000 (UTC)
Date:   Sun, 25 Jun 2023 09:15:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        glaubitz@physik.fu-berlin.de, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJeVGTRuSGfiz0C5@MiWiFi-R3L-srv>
References: <20230620131356.25440-3-bhe@redhat.com>
 <202306211030.DioMEPhl-lkp@intel.com>
 <ZJK57Uw5ZYQZY3d+@MiWiFi-R3L-srv>
 <20230621190834.GA842758@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621190834.GA842758@dev-arch.thelio-3990X>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/21/23 at 07:08pm, Nathan Chancellor wrote:
> On Wed, Jun 21, 2023 at 04:50:53PM +0800, Baoquan He wrote:
> > Hi,
> > 
> > On 06/21/23 at 10:15am, kernel test robot wrote:
> > > Hi Baoquan,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20230620131356.25440-3-bhe%40redhat.com
> > > patch subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
> > > config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config)
> > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202306211030.DioMEPhl-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported
> > 
> > I followed steps in your reproduce link, didn't reproduce the error as
> > above line reported. I can still see those PCI_IOMAP warning, however
> > they will disappear when rebuilding. The clone3 warning can always ben
> > seen. I didn't see the symbol ioremap error. Could you double check if
> > anything missed in steps?
> > 
> > [root@dell-pem620-01 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> > Compiler will be installed in /root/0day
> > make --keep-going LLVM=1 CROSS_COMPILE=hexagon-linux- LLVM_IAS=1 --jobs=48 W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> > make[1]: Entering directory '/root/linux/build_dir'
> >   GEN     Makefile
> > ld.lld: /lib64/libtinfo.so.6: no version information available (required by ld.lld)
> 
> Hmmm, seems like a dynamic linking issue, likely because either libtinfo
> is not available or the version on your system is older or newer than
> the one that the compiler was built with.
> 
> Intel folks, you can opt out of this particular library dependency with
> '-DLLVM_ENABLE_TERMINFO=OFF' to cmake, which will make it easier for
> others to use it; the compiler can still output color on most terminals
> even without libtinfo.
> 
> > tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
> > tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files
> >   CALL    ../scripts/checksyscalls.sh
> > clang: /lib64/libtinfo.so.6: no version information available (required by clang)
> > <stdin>:1519:2: warning: syscall clone3 not implemented [-W#warnings]
> >  1519 | #warning syscall clone3 not implemented
> >       |  ^
> > 1 warning generated.
> > make[1]: Leaving directory '/root/linux/build_dir'
> > [root@dell-pem620-01 linux]# 
> > 
> > 
> 
> I am able to reproduce this with the kernel.org LLVM builds that I do,
> which should not have that library dependency:
> 
> https://mirrors.edge.kernel.org/pub/tools/llvm/
> 
> $ curl -LSso .config https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config
> 
> $ make -skj"$(nproc)" ARCH=hexagon LLVM=$(realpath llvm-16.0.6-x86_64/bin)/ olddefconfig all
> ...
> make[5]: *** No rule to make target 'arch/hexagon/mm/ioremap.o', needed by 'arch/hexagon/mm/built-in.a'.
> ...
> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported
> ...
> 
> The first issue is resolved with:
> 
> diff --git a/arch/hexagon/mm/Makefile b/arch/hexagon/mm/Makefile
> index 49911a906fd0..ba4b04d962d6 100644
> --- a/arch/hexagon/mm/Makefile
> +++ b/arch/hexagon/mm/Makefile
> @@ -3,5 +3,5 @@
>  # Makefile for Hexagon memory management subsystem
>  #
>  
> -obj-y := init.o ioremap.o uaccess.o vm_fault.o cache.o
> +obj-y := init.o uaccess.o vm_fault.o cache.o
>  obj-y += copy_to_user.o copy_from_user.o vm_tlb.o

Ah, right, arch/hexagon/mm/ioremap.c is removed, I forgot change that in
Makefile. Thanks.

> 
> For the second issue, it seems that ioremap is exported in
> arch/hexagon/kernel/hexagon_ksyms.c but ioremap() is a static inline
> function with CONFIG_GENERIC_IOREMAP. I think we can just remove the
> ioremap and iounmap exports now, as ioremap() calls ioremap_prot(),
> which is exported, and iounmap() is exported in mm/ioremap.c.
> 
> diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
> index ec56ce2d92a2..36a80e31d187 100644
> --- a/arch/hexagon/kernel/hexagon_ksyms.c
> +++ b/arch/hexagon/kernel/hexagon_ksyms.c
> @@ -14,12 +14,10 @@
>  EXPORT_SYMBOL(__clear_user_hexagon);
>  EXPORT_SYMBOL(raw_copy_from_user);
>  EXPORT_SYMBOL(raw_copy_to_user);
> -EXPORT_SYMBOL(iounmap);
>  EXPORT_SYMBOL(__vmgetie);
>  EXPORT_SYMBOL(__vmsetie);
>  EXPORT_SYMBOL(__vmyield);
>  EXPORT_SYMBOL(empty_zero_page);
> -EXPORT_SYMBOL(ioremap);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memset);
>  
> 
> With those two diffs, the randconfig the robot provides builds and links
> without any errors.

Thanks a lot, I will add this into patch 02/19 of v8 post.

