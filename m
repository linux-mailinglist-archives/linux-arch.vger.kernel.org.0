Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7840272B186
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFKLLv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jun 2023 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKLLu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2023 07:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0B10FB
        for <linux-arch@vger.kernel.org>; Sun, 11 Jun 2023 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686481862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgXm+AiFJcRmjwuY2Z+gDuIRL5r60V1wcsJLPwSbtVk=;
        b=biVYJIK6fcRWMn1AqdrFOjYw8t0cAXP7GbVBE0UndTMs0gxsP3MywUnv/nsAWNfVEZgAAM
        NjbyjEhxViSloIzHfo/lfieVD02ss7hDX7k81h/AAPXMLq2Aq/xSNUtyhci8tYSVc0+L7V
        wfUID4jWCYh1yE9JPH+uEsMa9VDARFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-YfFmB5m3O6qTxAx_kQjAkw-1; Sun, 11 Jun 2023 07:10:59 -0400
X-MC-Unique: YfFmB5m3O6qTxAx_kQjAkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E0F9811E85;
        Sun, 11 Jun 2023 11:10:58 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3BB10DF8;
        Sun, 11 Jun 2023 11:10:55 +0000 (UTC)
Date:   Sun, 11 Jun 2023 19:10:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZIWrtFMUnRfVP5h0@MiWiFi-R3L-srv>
References: <20230609075528.9390-11-bhe@redhat.com>
 <202306100105.8GHnoMCP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306100105.8GHnoMCP-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/10/23 at 01:42am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230609-160014
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230609075528.9390-11-bhe%40redhat.com
> patch subject: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20230610/202306100105.8GHnoMCP-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch akpm-mm mm-everything
>         git checkout akpm-mm/mm-everything
>         b4 shazam https://lore.kernel.org/r/20230609075528.9390-11-bhe@redhat.com
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/
> 

Thanks for reporting.

I tried to reproduce with above steps, while failed with below message.
Later I got a s390x machine to reproduce the failure, and made a fix in
below patch.

[root@dell-pem620-01 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
Compiler will be installed in /root/0day
lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz
/root/linux                                                                                          
tar Jxf /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz -C /root/0day
Please update: libc6 or glibc
ldd /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc
/root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.36' not found (required by /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc)
setup_crosstool failed


From 26aedf424dac7e58dd1389e554cfe0693e2b371f Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Sun, 11 Jun 2023 18:37:43 +0800
Subject: [PATCH] s390: mm: fix building error when converting to
 GENERIC_IOREMAP
Content-type: text/plain

We should always include <asm/io.h> in ARCH, but not <asm-generic/io.h>
directly. Otherwise, macro defined by ARCH won't be seen and could cause
building error.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306100105.8GHnoMCP-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 7ef72f5ff52e..b0269f3881aa 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -22,7 +22,7 @@
 #include <asm/irq.h>
 #include <asm/debug.h>
 #include <asm/timex.h>
-#include <asm-generic/io.h>
+#include <asm/io.h>
 
 /* Minimum number of sample-data-block-tables:
  * At least one table is required for the sampling buffer structure.
-- 
2.34.1

