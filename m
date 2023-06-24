Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F0773CAEF
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jun 2023 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFXMqo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jun 2023 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXMqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2023 08:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57041739
        for <linux-arch@vger.kernel.org>; Sat, 24 Jun 2023 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687610746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2CS/MHrcK2qAcbibQs0p6Mzwq91ZIK5MauV6h2MC84=;
        b=PF/LWt/Q/gu6UJNVZxgoEz5ew0PoRpBb55iwMCgKpj/sjbOZUT7lsM7Emolc54Q0limWSk
        D6Lx8SjboIlInhWPG4MuWUGha8zS2goC4p5xZhSysmrkOrwTGwH6xhkFDIUTdpIBQeV29Z
        2nZwn/5Z7rQb294mxmLM9/Ka8GgTRYU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-SmHjZj3eMLi0FocPi9i6Ag-1; Sat, 24 Jun 2023 08:45:43 -0400
X-MC-Unique: SmHjZj3eMLi0FocPi9i6Ag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABB1F1C05AD4;
        Sat, 24 Jun 2023 12:45:41 +0000 (UTC)
Received: from localhost (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A54240D1A4;
        Sat, 24 Jun 2023 12:45:39 +0000 (UTC)
Date:   Sat, 24 Jun 2023 20:45:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>, schnelle@linux.ibm.com
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        glaubitz@physik.fu-berlin.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJblb6NeS9GZaHuI@MiWiFi-R3L-srv>
References: <20230620131356.25440-11-bhe@redhat.com>
 <202306211329.ticOJCSv-lkp@intel.com>
 <ZJLTxUOCEMh6l/El@MiWiFi-R3L-srv>
 <20230621192133.GB842758@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621192133.GB842758@dev-arch.thelio-3990X>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/21/23 at 07:21pm, Nathan Chancellor wrote:
> On Wed, Jun 21, 2023 at 06:41:09PM +0800, Baoquan He wrote:
> > Hi,
> > 
> > On 06/21/23 at 01:43pm, kernel test robot wrote:
> > > Hi Baoquan,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on akpm-mm/mm-everything]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > > patch link:    https://lore.kernel.org/r/20230620131356.25440-11-bhe%40redhat.com
> > > patch subject: [PATCH v7 10/19] s390: mm: Convert to GENERIC_IOREMAP
> > > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/config)
> > > compiler: s390-linux-gcc (GCC) 12.3.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211329.ticOJCSv-lkp@intel.com/reproduce)
> > 
> > Thanks for reporting this.
> > 
> > I followed steps in above reproduce link, it failed as below. Please
> > help check if anything is missing.
> > 
> > [root@intel-knightslanding-lb-02 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
> > Compiler will be installed in /root/0day
> > lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz
> > /root/linux                                                                                          
> > tar Jxf /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz -C /root/0day
> > Please update: libc6 or glibc
> > ldd /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc
> > /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.36' not found (required by /root/0day/gcc-12.3.0-nolibc/s390-linux/bin/s390-linux-gcc)
> > setup_crosstool failed
> 
> Certain recent versions of the kernel.org crosstool toolchains were
> built against a pretty recent glibc so attempting to run it on a system
> with an older glibc will result in the error above:
> 
> https://lore.kernel.org/87mt2eoopo.fsf@kernel.org/
> 
> Arnd resolved this and reuploaded the binaries, I suspect the Intel
> folks need to mirror the updated tarballs to 01.org:
> 
> https://lore.kernel.org/e9601db2-ff7d-4490-abd5-8d3c5946e108@app.fastmail.com/
> 
> According to make.cross, you can override the URL it uses with a
> variable, you could try removing these files
> 
>   /root/0day/gcc-12.3.0-nolibc/s390-linux
>   /root/0day/gcc-12.3.0-nolibc/x86_64-gcc-12.3.0-nolibc_s390-linux.tar.xz
> 
> and running
> 
>   $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 URL=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
> 
> to see if that works now.

Thanks a lot for your help, Nathan. Really appreciated.

Above make olddefconfig command works well, however the building failed
either becuase of lack of gmp.h. I am not familiar with the manipulation
of lkp building, so I gave up after attempt.

======
I finally got a s390x kvm guest from redhat lab, fetched the config file
lkp provided and build, I can reproduce those errors and more similar
errors are catched.

CONFIG_MMU=y
# CONFIG_PCI is not set

From investigation, I see the lkp config enabled MMU, but disabled PCI.
So those drivers which call ioremap()/iounmap() or their devm_xxxx
wrappers will fail building because s390's iomem operations rely on
pci support enabling. So I just change to make these drivers depend on
HAS_IOMEM so that it won't be built. The draft change is pasted at
below.

Hi Niklas,

I remember you ever entioned you would work out patches to solve those
those drivers relying on devm_xxx(), not sure if they are related to the
compiling error I met here. If I said the right thing, do you have plan
to post them? If what you ever said is different thing, or do you have
suggestion for below change, should I post them like this or need some
adjustment? Look forward to your comments, thanks in advance.

diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
index a8036dad437e..f51d533390a9 100644
--- a/drivers/char/xillybus/Kconfig
+++ b/drivers/char/xillybus/Kconfig
@@ -29,7 +29,7 @@ config XILLYBUS_PCIE
 
 config XILLYBUS_OF
 	tristate "Xillybus over Device Tree"
-	depends on OF && HAS_DMA
+	depends on OF && HAS_DMA && HAS_IOMEM
 	help
 	  Set to M if you want Xillybus to find its resources from the
 	  Open Firmware Flattened Device Tree. If the target is an embedded
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..52dfbae4f361 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -444,6 +444,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..b6221b4432fd 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -211,6 +211,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -280,6 +281,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index 3f926a653bd8..ace75d7b835a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
 
 config QCOM_HIDMA
 	tristate "Qualcomm Technologies HIDMA Channel support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for the Qualcomm Technologies HIDMA controller.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 09e422da482f..4b9036c6d45b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -89,6 +89,7 @@ config ALPINE_MSI
 config AL_FIC
 	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
 	depends on OF
+	depends on HAS_IOMEM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 433aa4197785..1d2b176a0594 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,6 +496,7 @@ config HISI_HIKEY_USB
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
+	depends on HAS_IOMEM
 	help
 	  This driver exposes a DICE reserved memory region to userspace via
 	  a character device. The memory region contains Compound Device
diff --git a/drivers/net/ethernet/altera/Kconfig b/drivers/net/ethernet/altera/Kconfig
index dd7fd41ccde5..33927fdfff28 100644
--- a/drivers/net/ethernet/altera/Kconfig
+++ b/drivers/net/ethernet/altera/Kconfig
@@ -2,6 +2,7 @@
 config ALTERA_TSE
 	tristate "Altera Triple-Speed Ethernet MAC support"
 	depends on HAS_DMA
+	depends on HAS_IOMEM
 	select PHYLIB
 	select PHYLINK
 	select PCS_ALTERA_TSE
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index e40f10bf2ba4..da9826accb1b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -55,7 +55,7 @@ config OF_FLATTREE
 
 config OF_EARLY_FLATTREE
 	bool
-	select DMA_DECLARE_COHERENT if HAS_DMA
+	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
 	select OF_FLATTREE
 
 config OF_PROMTREE

