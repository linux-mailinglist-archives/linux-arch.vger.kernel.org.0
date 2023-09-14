Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621C77A0207
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjINK4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINK4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 06:56:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071D1BFE;
        Thu, 14 Sep 2023 03:56:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmYzn43fRz6J6LX;
        Thu, 14 Sep 2023 18:52:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 11:56:45 +0100
Date:   Thu, 14 Sep 2023 11:56:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 02/35] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Message-ID: <20230914115644.00005182@Huawei.com>
In-Reply-To: <20230913163823.7880-3-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-3-james.morse@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Signed-off-by: James Morse <james.morse@arm.com>
Seems sensible and well reasoned cleanup to me.
Technically an ABI change, but would be seriously odd if any real code
relied on the current pointless behavior on the few architectures where
is changing.

FWIW review is really of your analysis rather than the change :)

Seems like there may be some additional cleanup that makes sense from
Russell's analysis, but that's perhaps a parallel job.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 9ea22e165acd..34b48f660b6b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -533,7 +533,7 @@ static void __init cpu_dev_register_generic(void)
>  #ifdef CONFIG_GENERIC_CPU_DEVICES
>  	int i;
>  
> -	for_each_possible_cpu(i) {
> +	for_each_present_cpu(i) {
>  		if (register_cpu(&per_cpu(cpu_devices, i), i))
>  			panic("Failed to register CPU device");
>  	}

