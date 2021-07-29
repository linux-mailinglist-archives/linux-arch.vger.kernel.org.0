Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF043D9B8D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 04:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhG2CDc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 22:03:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7762 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CDb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 22:03:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZtvZ3zN8zYhCM;
        Thu, 29 Jul 2021 09:57:30 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:03:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:03:19 +0800
Subject: Re: [PATCH v2 2/7] kallsyms: Fix address-checks for kernel related
 range
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Petr Mladek" <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
 <20210728081320.20394-3-wangkefeng.wang@huawei.com>
 <20210728104642.7ae75442@oasis.local.home>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <637cd290-ecda-2727-519a-12147a92b01e@huawei.com>
Date:   Thu, 29 Jul 2021 10:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210728104642.7ae75442@oasis.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2021/7/28 22:46, Steven Rostedt wrote:
> On Wed, 28 Jul 2021 16:13:15 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> The is_kernel_inittext/is_kernel_text/is_kernel function should not
>> include the end address(the labels _einittext, _etext and _end) when
>> check the address range, the issue exists since Linux v2.6.12.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks.

>
> -- Steve
>
