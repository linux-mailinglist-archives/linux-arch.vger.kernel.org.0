Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D53D9B66
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 04:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhG2CA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 22:00:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7888 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 22:00:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZtv72w4zz81YK;
        Thu, 29 Jul 2021 09:57:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:00:53 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:00:51 +0800
Subject: Re: [PATCH v2 5/7] kallsyms: Rename is_kernel() and is_kernel_text()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, <bpf@vger.kernel.org>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
 <20210728081320.20394-6-wangkefeng.wang@huawei.com>
 <20210728112836.289865f5@oasis.local.home>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <1551f9cc-eaf8-efef-0590-e2549eebe4ae@huawei.com>
Date:   Thu, 29 Jul 2021 10:00:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210728112836.289865f5@oasis.local.home>
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


On 2021/7/28 23:28, Steven Rostedt wrote:
> On Wed, 28 Jul 2021 16:13:18 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> The is_kernel[_text]() function check the address whether or not
>> in kernel[_text] ranges, also they will check the address whether
>> or not in gate area, so use better name.
> Do you know what a gate area is?
>
> Because I believe gate area is kernel text, so the rename just makes it
> redundant and more confusing.

Yes, the gate area(eg, vectors part on ARM32, similar on x86/ia64) is 
kernel text.

I want to keep the 'basic' section boundaries check, which only check 
the start/end

of sections, all in section.h,  could we use 'generic' or 'basic' or 
'core' in the naming?

  * is_kernel_generic_data()	--- come from core_kernel_data() in kernel.h
  * is_kernel_generic_text()

The old helper could remain unchanged, any suggestion, thanks.

>
> -- Steve
> .
>
