Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4145E3B6E4E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 08:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhF2Gi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Jun 2021 02:38:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9316 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2Gi4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2021 02:38:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GDZQQ4BP5z70st;
        Tue, 29 Jun 2021 14:32:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 14:36:27 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 14:36:26 +0800
Subject: Re: [PATCH 3/9] sections: Move and rename core_kernel_data() to
 is_kernel_data()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-4-wangkefeng.wang@huawei.com>
 <20210628210538.0fdded1c@oasis.local.home>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <dc64df91-f89c-8e48-de9a-f5c864cdce12@huawei.com>
Date:   Tue, 29 Jun 2021 14:36:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210628210538.0fdded1c@oasis.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2021/6/29 9:05, Steven Rostedt wrote:
> On Sat, 26 Jun 2021 15:34:33 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Move core_kernel_data() into sections.h and rename it to
>> is_kernel_data(), also make it return bool value, then
>> update all the callers.
> Removing the "core" part of "core_kernel_data()" is misleading. As
> modules can have kernel data, but this will return false on module data
> (as it should). This is similar to core_kernel_text() which this series
> doesn't seem to touch.

Yes, The series only collect and move the basic part(aka, the 'core' 
part, which only

contains the start/end address check of sections) into 
include/asm-generic/sections.h,

the core_kernel_text() contains system_state validation, it's not 
inappropriate into sections.h,

so it won't be modified and moved.

>
> I'd like to keep the "core" in the name which makes it obvious this is
> not about module data, and if someone were to make it about module
> data, it will break ftrace synchronization.

After this series, we have 5 APIs, only use core_kernel_data() is a 
little strange,

  * is_kernel_data()       --- come from core_kernel_data() in kernel.h
  * is_kernel_rodata()    --- already in sections.h
  * is_kernel_text()        --- come from kallsyms.h
  * is_kernel_inittext()   --- come from kernel.h and kallsyms.h
  * is_kernel()                --- come from kallsyms.h

Could we rename is_kernel_data() to is_kernel_core_data(), and add some 
comment your mentioned,

or any better naming, thanks.

>
> -- Steve
> .
>
