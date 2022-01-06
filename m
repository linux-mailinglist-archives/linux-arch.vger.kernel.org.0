Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53C7486904
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 18:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiAFRpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 12:45:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4361 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbiAFRpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 12:45:43 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVDFV64LGz67PH4;
        Fri,  7 Jan 2022 01:42:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 18:45:40 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 17:45:39 +0000
Subject: Re: [RFC 00/32] Kconfig: Introduce HAS_IOPORT and LEGACY_PCI options
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-csky@vger.kernel.org>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <00c5a9e2-1876-e8d1-68f3-2be6d3bd38cb@huawei.com>
Date:   Thu, 6 Jan 2022 17:45:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.56]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On 27/12/2021 16:42, Niklas Schnelle wrote:
> I performed the following testing:
> 
> - On s390 this series on top of v5.16-rc7 builds with allyesconfig i.e. the
>    HAS_IOPORT=n case.

Are you sure that allyesconfig gives HAS_IOPORT=n? Indeed I see no 
mechanism is always disallow HAS_IOPORT for s390 (which I think we would 
want).

> It also builds with defconfig and the resulting kernel
>    appears fully functional including tests with PCI devices.

Thanks,
Johnw


