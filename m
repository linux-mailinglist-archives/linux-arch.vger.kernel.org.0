Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754173318F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjFPMre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 08:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjFPMrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 08:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9C30ED
        for <linux-arch@vger.kernel.org>; Fri, 16 Jun 2023 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686919601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oE/aox+P5EI2fK8L6+t8Yc5hZ1jrOyHxepshYMemZM=;
        b=ABUTU/IMiiFo4ghpdHUARouHkRqfscJB/9GZnDSqQ43wh8J2hWoxhj9YNZtMIKwdhlp870
        1wgH3NhIk3S9vAfKCZj4VYo19elbNN2O4vG8R67JMCWXdLArt5oel5IvvIjHFUmh9Av5SO
        K+yop5ncsjFJKOCQ1RyABwJjdsvWPZw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-Xd0nxM93NbKbzl57Q992Hw-1; Fri, 16 Jun 2023 08:46:38 -0400
X-MC-Unique: Xd0nxM93NbKbzl57Q992Hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86E31280D588;
        Fri, 16 Jun 2023 12:46:37 +0000 (UTC)
Received: from localhost (ovpn-13-2.pek2.redhat.com [10.72.13.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6140A422DE;
        Fri, 16 Jun 2023 12:46:36 +0000 (UTC)
Date:   Fri, 16 Jun 2023 20:46:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v6 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZIxZqd85xWRriAW4@MiWiFi-R3L-srv>
References: <20230609075528.9390-3-bhe@redhat.com>
 <202306091859.NhlW2nny-lkp@intel.com>
 <ZIQzrRo0JhfBLDes@MiWiFi-R3L-srv>
 <20230611054019.GL52412@kernel.org>
 <ZIV+bD1ksJz0CTz2@MiWiFi-R3L-srv>
 <20230612160237.GA199007@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612160237.GA199007@dev-arch.thelio-3990X>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/12/23 at 09:02am, Nathan Chancellor wrote:
> On Sun, Jun 11, 2023 at 03:57:32PM +0800, Baoquan He wrote:
> > On 06/11/23 at 08:40am, Mike Rapoport wrote:
> > > Hi Baoquan,
> > > 
> > > On Sat, Jun 10, 2023 at 04:26:21PM +0800, Baoquan He wrote:
> > > > On 06/09/23 at 07:09pm, kernel test robot wrote:
> > > > > Hi Baoquan,
> > > > > 
> > > > > kernel test robot noticed the following build errors:
> > > > > 
> > > > > [auto build test ERROR on akpm-mm/mm-everything]
> > > > > 
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230609-160014
> > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > > > patch link:    https://lore.kernel.org/r/20230609075528.9390-3-bhe%40redhat.com
> > > > > patch subject: [PATCH v6 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
> > > > > config: hexagon-randconfig-r041-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091859.NhlW2nny-lkp@intel.com/config)
> > > > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > > > reproduce (this is a W=1 build):
> > > > >         mkdir -p ~/bin
> > > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >         chmod +x ~/bin/make.cross
> > > > >         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
> > > > >         git fetch akpm-mm mm-everything
> > > > >         git checkout akpm-mm/mm-everything
> > > > >         b4 shazam https://lore.kernel.org/r/20230609075528.9390-3-bhe@redhat.com
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
> > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon prepare
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202306091859.NhlW2nny-lkp@intel.com/
> > > > 
> > > > Thanks for reporting. I reproduced them on my local machine. Below patch
> > > > can fix them. And by the way, I also saw the clone3 warning, and have to 
> > > > made change in scripts/checksyscalls.sh to mute it, wondering how you
> > > > handle it in your testing.
> > > 
> > > I think the warning kbuild reported is rather this one:
> > > 
> > > >> include/asm-generic/io.h:1078:6: error: conflicting types for 'iounmap'
> > >     1078 | void iounmap(volatile void __iomem *addr);
> > >          |      ^
> > 
> > This one is reported as error. The old iounmap() declaration has a const,
> > while the standard one doesn't have. So I just remove the old one to use
> > the standard one.
> > 
> > Another one is warning about PCI_IOBASE. Because inb/w/l and outb/w/l is
> > redefined in asm-generic/io.h, and it uses PCI_IOBASE which is defniend
> > as NULL in asm-generic/io.h if ARCH doesn't have its own PCI_IOBASE
> > definition. Then the warning is triggered. So I define macro to override
> > the standard inb/w/l and outb/w/l.
> > 
> > #ifndef PCI_IOBASE
> > #define PCI_IOBASE ((void __iomem *)0)
> > #endif
> 
> I believe that this series [1] by Niklas Schnelle should take care of
> the PCI_IOBASE warnings (which are not Hexagon specific), so there is no
> need to worry about them when they show up in build reports.
> 
> [1]: https://lore.kernel.org/20230522105049.1467313-1-schnelle@linux.ibm.com/

That's great, then I can skip the fixing of PCI_IOBASE warnings, only
wrap the fixing of iounmap() declaration issue into the new post. Thanks
a lot for the information, Nathan.

Thanks
Baoquan

