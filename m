Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A27A0308
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbjINLse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINLsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 07:48:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14349B;
        Thu, 14 Sep 2023 04:48:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmbBn3SgHz67SFB;
        Thu, 14 Sep 2023 19:46:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 12:48:26 +0100
Date:   Thu, 14 Sep 2023 12:48:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     James Morse <james.morse@arm.com>, <linux-pm@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 10/35] riscv: Switch over to GENERIC_CPU_DEVICES
Message-ID: <20230914124825.0000209f@Huawei.com>
In-Reply-To: <ZQLaq0/qyXdJWbLq@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-11-james.morse@arm.com>
        <ZQLaq0/qyXdJWbLq@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Sep 2023 11:04:27 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Sep 13, 2023 at 04:37:58PM +0000, James Morse wrote:
> > Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> > overridden by the arch code, switch over to this to allow common code
> > to choose when the register_cpu() call is made.
> > 
> > This allows topology_init() to be removed.
> > 
> > This is an intermediate step to the logic being moved to drivers/acpi,
> > where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>  
> 
> ... and same concern as the previous patch.
> 

Agreed - with that note added, this one looks simple.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
