Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF927004EE
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjELKLf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbjELKLe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:11:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F356106D3;
        Fri, 12 May 2023 03:10:59 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QHktL6xytz18LRW;
        Fri, 12 May 2023 18:06:02 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 18:10:15 +0800
Message-ID: <f7a58629-05ae-18f4-d047-a2592f501b45@huawei.com>
Date:   Fri, 12 May 2023 18:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     <masahiroy@kernel.org>
CC:     <aou@eecs.berkeley.edu>, <ardb@kernel.org>, <arnd@arndb.de>,
        <catalin.marinas@arm.com>, <dennis@ausil.us>, <jszhang@kernel.org>,
        <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <nicolas@fjasle.eu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <regressions@leemhuis.info>, <will@kernel.org>
References: <20221226184537.744960-1-masahiroy@kernel.org>
Subject: Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
Content-Language: en-US
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20221226184537.744960-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

It seems this patch introduces a compile error on powerpc 85xx platform with
CONFIG_RELOCATABLE enabled.

To reproduce the problem, I compiled the mainline linux kernel with patch
99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv"), using 
configure
file:

arch/powerpc/configs/85xx-32bit.config

and enabled CONFIG_RELOCATABLE manually. Then the compile log with
Segmentation fault appeared as below:

   ...
   AR      fs/proc/built-in.a
   AR      fs/built-in.a
   AR      built-in.a
   AR      vmlinux.a
   LD      vmlinux.o
   OBJCOPY modules.builtin.modinfo
   GEN     modules.builtin
   MODPOST vmlinux.symvers
   UPD     include/generated/utsversion.h
   CC      init/version-timestamp.o
   LD      .tmp_vmlinux.kallsyms1
Segmentation fault (core dumped)
scripts/Makefile.vmlinux:34: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 139
Makefile:1252: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 2

Could anyone reproduce above error, or have I missed anything else?

Thanks,
Jiahao
