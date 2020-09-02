Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77525A7D7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBIe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 04:34:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgIBIe0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 04:34:26 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DAF42C11693830390BC;
        Wed,  2 Sep 2020 16:34:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.211) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 16:34:18 +0800
Subject: Re: [PATCH v3] PCI: Add pci_iounmap
To:     George Cherian <gcherian@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "mst@redhat.com" <mst@redhat.com>
References: <BYAPR18MB2679AAA983C2AF3CD399ABD8C52E0@BYAPR18MB2679.namprd18.prod.outlook.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5aff44b1-a293-3ab1-a102-9e1ad8229431@huawei.com>
Date:   Wed, 2 Sep 2020 16:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR18MB2679AAA983C2AF3CD399ABD8C52E0@BYAPR18MB2679.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2020/9/2 2:05, George Cherian wrote:
> Hi Yang,
>
>> -----Original Message-----
>> From: Yang Yingliang <yangyingliang@huawei.com>
>> Sent: Tuesday, September 1, 2020 6:59 PM
>> To: George Cherian <gcherian@marvell.com>; linux-kernel@vger.kernel.org;
>> linux-arch@vger.kernel.org; linux-pci@vger.kernel.org
>> Cc: kbuild-all@lists.01.org; bhelgaas@google.com; arnd@arndb.de;
>> mst@redhat.com
>> Subject: Re: [PATCH v3] PCI: Add pci_iounmap
>>
>>
>>
>>
>> On 2020/8/25 9:25, kernel test robot wrote:
>>> Hi George,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on pci/next]
>>> [also build test ERROR on linux/master linus/master asm-generic/master
>>> v5.9-rc2 next-20200824] [If your patch is applied to the wrong git tree,
>> kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git-
>> 2Dscm.com_doc
>>> s_git-2Dformat-2Dpatch&d=DwIC-
>> g&c=nKjWec2b6R0mOyPaz7xtfQ&r=TjMsEFPc7di
>> rkF6u2D3eSIS0cA8FeYpzRkkMzr4aCbk&m=dvtRkwC273FmalEZE_KonLRWrIV
>> WLSWfG61
>>> NWTWG5LI&s=ycW6SZOVRuKAm3YwdhyAuSh22oPuengSMVuv-
>> EwaUew&e= ]
>>> url:    https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__github.com_0day-2Dci_linux_commits_George-2DCherian_PCI-2DAdd-
>> 2Dpci-5Fiounmap_20200824-2D212149&d=DwIC-
>> g&c=nKjWec2b6R0mOyPaz7xtfQ&r=TjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
>> Mzr4aCbk&m=dvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=6c
>> UOYHeDOBZ0HaFc2z-vaDgDmbIK4LCBRt9kNkn1sto&e=
>>> base:   https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__git.kernel.org_pub_scm_linux_kernel_git_helgaas_pci.git&d=DwIC-
>> g&c=nKjWec2b6R0mOyPaz7xtfQ&r=TjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
>> Mzr4aCbk&m=dvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=h-
>> TMyLlEdAwew-u52q4dgWBUMgm0ys-xKzvOO86e1Lw&e=  next
>>> config: powerpc-allyesconfig (attached as .config)
>>> compiler: powerpc64-linux-gcc (GCC) 9.3.0 reproduce (this is a W=1
>>> build):
>>>           wget https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__raw.githubusercontent.com_intel_lkp-
>> 2Dtests_master_sbin_make.cross&d=DwIC-
>> g&c=nKjWec2b6R0mOyPaz7xtfQ&r=TjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
>> Mzr4aCbk&m=dvtRkwC273FmalEZE_KonLRWrIVWLSWfG61NWTWG5LI&s=az
>> QcL0MQmPpr9UfvyBSSdQiu1UbjJgFrzNJOtcZ_--E&e=  -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # save the attached .config to linux build tree
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
>>> make.cross ARCH=powerpc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>      powerpc64-linux-ld: lib/pci_iomap.o: in function `__crc_pci_iounmap':
>>>>> (.rodata+0x10): multiple definition of `__crc_pci_iounmap';
>>>>> lib/iomap.o:(.rodata+0x68): first defined here
>> EXPORT_SYMBOL(pci_iounmap) in lib/iomap.c need be removed.
> I really don't think that is the way to fix this. I have also seen your other patch
> in which iomap being moved out of lib/iomap.c to header file.
>
> There was a reason for moving iomap and its variants to a lib since most of
> the arch's implementation of map was similar. Whereas the unmap had multiple
> implementation per arch's. So, the lib/iomap never implemented the generic unmap.
>
> I see either of the following solution.
> a. Have an arm64 specific implementation for the unmap function.
> Or
> b. something on the lines of v2[1], which accommodates all the arch's but has the #ifdef
> for which Bjorn raised his concerns.
I think 'a' may be better, and I have already make a patch, I can send 
it after testing.
>
> Bjorn, any comments?
>
> Regards
> -George
>
> [1] - https://lkml.org/lkml/2020/8/20/28

