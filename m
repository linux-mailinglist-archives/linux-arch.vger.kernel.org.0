Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91F7A1A6E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjIOJWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 15 Sep 2023 05:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjIOJW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 05:22:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206730C3;
        Fri, 15 Sep 2023 02:21:45 -0700 (PDT)
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rn7wH5Jlrz6K6nl;
        Fri, 15 Sep 2023 17:21:03 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 10:21:42 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031;
 Fri, 15 Sep 2023 10:21:42 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: RE: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code
 first?]
Thread-Topic: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Thread-Index: AQHZ5mDqpYLh+nkhC0mj9mPBt3XEBLAZ5MMAgAB0lICAAAsFgIAAEfIQgADzSoCAAC7oAA==
Date:   Fri, 15 Sep 2023 09:21:42 +0000
Message-ID: <e91f1c42c6b643a4a8227d1bac895747@huawei.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-28-james.morse@arm.com>
        <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
        <20230914155459.00002dba@Huawei.com>
        <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
        <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
 <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
In-Reply-To: <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.239]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Russel,

> From: Russell King <linux@armlinux.org.uk>
> Sent: Friday, September 15, 2023 8:09 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; James Morse <james.morse@arm.com>; linux-
> pm@vger.kernel.org; loongarch@lists.linux.dev; linux-acpi@vger.kernel.org;
> linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-riscv@lists.infradead.org;
> kvmarm@lists.linux.dev; x86@kernel.org; Jean-Philippe Brucker <jean-
> philippe@linaro.org>; jianyong.wu@arm.com; justin.he@arm.com
> Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
> [code first?]
> 
> On Fri, Sep 15, 2023 at 02:29:13AM +0000, Salil Mehta wrote:
> > On x86, during init, if the MADT entry for LAPIC is found to be
> > online-capable and is enabled as well then possible and present
> 
> Note that the ACPI spec says enabled + online-capable isn't defined.
> 
> "The information conveyed by this bit depends on the value of the
> Enabled bit. If the Enabled bit is set, this bit is reserved and
> must be zero."
> 
> So, if x86 is doing something with the enabled && online-capable
> state (other than ignoring the online-capable) then technically it
> is doing something that the spec doesn't define - and it's
> completely fine if aarch64 does something else (maybe treating it
> strictly as per the spec and ignoring online-capable.)


I would suggest that we should concentrate on what is actually
required. The fact of the matter is there is no need to keep
ACPI MADT.GICC.Enabled and ACPI MADT.GICC.online-capable bits
mutually exclusive. (please correct my understanding here
if I am wrong here)

It is a different matter that x86 has implemented above
requirement first for their x2APIC and spec are still not
reflecting what has been implemented as part of the code.
(I would add, for whatever reasons)

On ARM we have copied something from x86 ACPI Specification
which has not been updated yet. (why it is not updated? Maybe
x86 folks can clarify more on this?). Even on ARM, mutual
exclusiveness of the bits is not required. But does it breaks
anything on ARM to *not* have mutual exclusiveness. 
AFAICS, no, but ARM Arch guys can confirm this?)

If bits are *not* required to be mutually exclusive on either
platforms x86/ARM then, I think, it makes sense to update
ACPI specification for both of the platforms.


Thanks
Salil.

