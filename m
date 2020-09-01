Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B6F258F75
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIANu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 09:50:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbgIANav (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 09:30:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C02F361D37743339AAB;
        Tue,  1 Sep 2020 21:28:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.211) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 21:28:48 +0800
Subject: Re: [PATCH v3] PCI: Add pci_iounmap
To:     George Cherian <george.cherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
        <mst@redhat.com>
References: <20200824132046.3114383-1-george.cherian@marvell.com>
 <202008250903.G0uQ5UZk%lkp@intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <13af6d70-7de4-e86f-5db0-f42159c5b4a5@huawei.com>
Date:   Tue, 1 Sep 2020 21:28:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202008250903.G0uQ5UZk%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2020/8/25 9:25, kernel test robot wrote:
> Hi George,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on linux/master linus/master asm-generic/master v5.9-rc2 next-20200824]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/George-Cherian/PCI-Add-pci_iounmap/20200824-212149
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     powerpc64-linux-ld: lib/pci_iomap.o: in function `__crc_pci_iounmap':
>>> (.rodata+0x10): multiple definition of `__crc_pci_iounmap'; lib/iomap.o:(.rodata+0x68): first defined here
EXPORT_SYMBOL(pci_iounmap) in lib/iomap.c need be removed.
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

