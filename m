Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC08737EBA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFUIv5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFUIvx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 04:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B51733
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2023 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687337468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwyBlKAjWWqC2ADnT8omvFeBUBts/JlKuShTUrNb9VA=;
        b=e6+0LnVAlwcO5XqxEys2fKA7OLiscrfN8nY2JlaKxXEIuCwMOSTtY6Qtv/nPMxzGaUAh6E
        HFRD5TdhGLpBKh+KhEMU4nDCr856uyAr5zEbl0Tibgyq9QOL3+g7Cc2Ok2Qgel7/lfGv2G
        mu9MjOFO2yY3KpvnHkeDR+qVESgQgf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-ZaFiW99aNIaeRMC_Bh02Dw-1; Wed, 21 Jun 2023 04:51:04 -0400
X-MC-Unique: ZaFiW99aNIaeRMC_Bh02Dw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AC25805C3F;
        Wed, 21 Jun 2023 08:50:59 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4175F492B02;
        Wed, 21 Jun 2023 08:50:57 +0000 (UTC)
Date:   Wed, 21 Jun 2023 16:50:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJK57Uw5ZYQZY3d+@MiWiFi-R3L-srv>
References: <20230620131356.25440-3-bhe@redhat.com>
 <202306211030.DioMEPhl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211030.DioMEPhl-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 06/21/23 at 10:15am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230620131356.25440-3-bhe%40redhat.com
> patch subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
> config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306211030.DioMEPhl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported

I followed steps in your reproduce link, didn't reproduce the error as
above line reported. I can still see those PCI_IOMAP warning, however
they will disappear when rebuilding. The clone3 warning can always ben
seen. I didn't see the symbol ioremap error. Could you double check if
anything missed in steps?

[root@dell-pem620-01 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
Compiler will be installed in /root/0day
make --keep-going LLVM=1 CROSS_COMPILE=hexagon-linux- LLVM_IAS=1 --jobs=48 W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
make[1]: Entering directory '/root/linux/build_dir'
  GEN     Makefile
ld.lld: /lib64/libtinfo.so.6: no version information available (required by ld.lld)
tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files
  CALL    ../scripts/checksyscalls.sh
clang: /lib64/libtinfo.so.6: no version information available (required by clang)
<stdin>:1519:2: warning: syscall clone3 not implemented [-W#warnings]
 1519 | #warning syscall clone3 not implemented
      |  ^
1 warning generated.
make[1]: Leaving directory '/root/linux/build_dir'
[root@dell-pem620-01 linux]# 


