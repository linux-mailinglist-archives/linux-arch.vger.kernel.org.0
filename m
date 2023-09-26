Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F87AEDD7
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjIZNQw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 26 Sep 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 09:16:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88044E4;
        Tue, 26 Sep 2023 06:16:44 -0700 (PDT)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rw0bh0SMmz6K7vG;
        Tue, 26 Sep 2023 21:15:28 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 14:16:41 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031;
 Tue, 26 Sep 2023 14:16:41 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: RE: [RFC PATCH v2 00/35] ACPI/arm64: add support for virtual
 cpuhotplug
Thread-Topic: [RFC PATCH v2 00/35] ACPI/arm64: add support for virtual
 cpuhotplug
Thread-Index: AQHZ5mDIR7JMF2KEeEGQTVeJuAX/8LAtKYMg
Date:   Tue, 26 Sep 2023 13:16:41 +0000
Message-ID: <622a39bda12a4b75a6da84f4566b4238@huawei.com>
References: <20230913163823.7880-1-james.morse@arm.com>
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: James Morse <james.morse@arm.com>
> Sent: Wednesday, September 13, 2023 5:38 PM

[...]

> 
> Hello!
> 
> Changes since RFC-v1:
>  * riscv is new, ia64 is gone
>  * The KVM support is different, and upstream - no need to patch the host.
> 
> ---
> 
> This series adds what looks like cpuhotplug support to arm64 for use in
> virtual machines. It does this by moving the cpu_register() calls for
> architectures that support ACPI out of the arch code by using
> GENERIC_CPU_DEVICES, then into the ACPI processor driver.
> 
> The kubernetes folk really want to be able to add CPUs to an existing VM,
> in exactly the same way they do on x86. The use-case is pre-booting guests
> with one CPU, then adding the number that were actually needed when the
> workload is provisioned.
> 

[...]

> 
> I had a go at switching the remaining architectures over to
> GENERIC_CPU_DEVICES,
> so that the Kconfig symbol can be removed, but I got stuck with powerpc
> and s390.
> 
> I've only build tested Loongarch and riscv. I've removed the ia64 specific
> patches, but left the changes in other patches to make git-grep review of
> renames easier.
> 
> If folk want to play along at home, you'll need a copy of Qemu that
> supports this.
> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v2-rc6


Please use the latest pushed RFC V2 instead:
https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/T/#m523b37819c4811c7827333982004e07a1ef03879

Repository:
https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v2


Thanks
Salil.


[...]

> Why is this still an RFC? I'm still looking for confirmation from the
> kubernetes/kata folk that this works for them. Because of this I've culled
> the CC list...
> 
> 
> This series is based on v6.6-rc1, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/virtual_cpu_hotplug/rfc/v2
