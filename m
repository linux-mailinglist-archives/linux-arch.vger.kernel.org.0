Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF172AA3F
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jun 2023 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjFJI1b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjFJI11 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 04:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F98359C
        for <linux-arch@vger.kernel.org>; Sat, 10 Jun 2023 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686385598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvArk9hcrOiQbHygnyJk41fy5YrA+5LXHt7YDXtAp2Y=;
        b=UKty3M9nBsonjDdqeOgGfu7Q54aefBlQSF5Hf5exvhFzEGqaZU28ixJgShBN2BhPJlvsls
        yyMNomZGRf9sDc60anp1gDavkLAiOaByWkV4m8Q/bhmwln6nlEIcci1m77bKXUXUze03If
        Nfo4anRjessKc9XnA0x3a2KxnIz17x4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-AEWV5vKOPumHdPA80TVoSw-1; Sat, 10 Jun 2023 04:26:30 -0400
X-MC-Unique: AEWV5vKOPumHdPA80TVoSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150CF8002BF;
        Sat, 10 Jun 2023 08:26:29 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD8AAC0004B;
        Sat, 10 Jun 2023 08:26:27 +0000 (UTC)
Date:   Sat, 10 Jun 2023 16:26:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v6 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZIQzrRo0JhfBLDes@MiWiFi-R3L-srv>
References: <20230609075528.9390-3-bhe@redhat.com>
 <202306091859.NhlW2nny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306091859.NhlW2nny-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On 06/09/23 at 07:09pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230609-160014
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230609075528.9390-3-bhe%40redhat.com
> patch subject: [PATCH v6 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
> config: hexagon-randconfig-r041-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091859.NhlW2nny-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch akpm-mm mm-everything
>         git checkout akpm-mm/mm-everything
>         b4 shazam https://lore.kernel.org/r/20230609075528.9390-3-bhe@redhat.com
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon prepare
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306091859.NhlW2nny-lkp@intel.com/

Thanks for reporting. I reproduced them on my local machine. Below patch
can fix them. And by the way, I also saw the clone3 warning, and have to 
made change in scripts/checksyscalls.sh to mute it, wondering how you
handle it in your testing.

------
stdin>:1520:2: warning: syscall clone3 not implemented [-W#warnings]
 1520 | #warning syscall clone3 not implemented
      |  ^
1 warning generated.

------
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..3a369b78edb7 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -148,6 +148,7 @@ cat << EOF
 #define __IGNORE_nanosleep
 #define __IGNORE_io_getevents
 #define __IGNORE_recvmmsg
+#define __IGNORE_clone3
 #endif


From 6a86f4360a61a2b7b4d71172e5c03be554367553 Mon Sep 17 00:00:00 2001
From: root <root@dell-pem620-01.dell2.lab.eng.bos.redhat.com>
Date: Fri, 9 Jun 2023 21:21:36 -0400
Subject: [PATCH] hexagon: mm: fix warning in asm/io.h
Content-type: text/plain

Remove the old iounmap() declaration which is not consistent with the
standard one in asm-generic/io.h, let's use the standard one.

And also add macro definition of inb/w/l and outb/w/l to override
the definition of them in asm-generic/io.h.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/hexagon/include/asm/io.h | 8 ++++++--
 scripts/checksyscalls.sh      | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index dcd9cbbf5934..efe9cb00ebf8 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -27,8 +27,6 @@
 extern int remap_area_pages(unsigned long start, unsigned long phys_addr,
 				unsigned long end, unsigned long flags);
 
-extern void iounmap(const volatile void __iomem *addr);
-
 /* Defined in lib/io.c, needed for smc91x driver. */
 extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
 extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
@@ -207,16 +205,19 @@ static inline void memset_io(volatile void __iomem *addr, int value,
  *
  * Operates on "I/O bus I/O space"
  */
+#define inb inb
 static inline u8 inb(unsigned long port)
 {
 	return readb(_IO_BASE + (port & IO_SPACE_LIMIT));
 }
 
+#define inw inw
 static inline u16 inw(unsigned long port)
 {
 	return readw(_IO_BASE + (port & IO_SPACE_LIMIT));
 }
 
+#define inl inl
 static inline u32 inl(unsigned long port)
 {
 	return readl(_IO_BASE + (port & IO_SPACE_LIMIT));
@@ -227,16 +228,19 @@ static inline u32 inl(unsigned long port)
  * @data: data to write to
  * @addr:  address in I/O space
  */
+#define outb outb
 static inline void outb(u8 data, unsigned long port)
 {
 	writeb(data, _IO_BASE + (port & IO_SPACE_LIMIT));
 }
 
+#define outw outw
 static inline void outw(u16 data, unsigned long port)
 {
 	writew(data, _IO_BASE + (port & IO_SPACE_LIMIT));
 }
 
+#define outl outl
 static inline void outl(u32 data, unsigned long port)
 {
 	writel(data, _IO_BASE + (port & IO_SPACE_LIMIT));

