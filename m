Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827AE2EA96C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbhAELC6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 06:02:58 -0500
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:46342
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729005AbhAELCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Jan 2021 06:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJdCI//V6ur9j/9W185Va8MSGVr0MqSUuKEC2t6F9EtEbbTbHPy96kAE7ZRAUeGsJTaowD5kC1vgPv2qiLQpZyBil3Ko+BSXkgLAqf/fJzSXnYMXbqvoWAFKn1PJiS7lKSpKxolY2vzCqYJx2kf+GJBEaYuZZurnuv7NzOluvZF/5eg3sUw9WIhIoAaqHfkdK3rFBNL73wU2ucEk8kRMWXk+oHueXg6sa2jsGY4NQM5XoFUDeAwMYVWO3TU0kk7nOiZmb1FhqSXAaiEL33cy4q60KaGQVKGBBEKJ5ICVUhHiFc42dVHew0ezBxiPXHIgWHWaviFpnHUj3hXPxn/8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3fSo8nUZajjwQQxnocA/oB03d3bol8R7gYKToTeWU8=;
 b=dolYfeJk6Gymyq5fAeuo1+7crF641xzD6SIznN+erDuFGTQOJ13/yAi/ppf4BOo0IlRPPiIBRmZFN0gpo3veXoGfZZAVibZSxNHM41xJ2ywthap6sCiOE/4+oXDDXjeV+BDZ608JgGbQt/Vngdet8wtHmRVuDHfy1H6YfgNZyT5lfHuWaYL4HsgeP1pigwVl5Cs3YVLJyX0q2dXeZDct04wcZh1RlcbBSrQTQW9+kRNB3nS0crGMBzhenKWbT79I6PbN6HeuoOQ2y8L4H/cnj2/MQvBhtmBgGxkAPgeOf2PidnkrR5Tp91U3OwvsHoJmyu0DzJG3jE08EvS6xnoSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3fSo8nUZajjwQQxnocA/oB03d3bol8R7gYKToTeWU8=;
 b=ayCcjc3wdG4Ye0v8D+rNQRQbq2JIqofaBKL3f5KMMSKx49Wvq/CssL4Z8UEHGm9OznbuiC2z70rPAFfB/DFSZdjBeYpoyCx3wZj5OETVcyu+MWkAUtJMQ7t19hfm9wCcHGYK0NS86GirglWsmBcxZbOEuzm82AXSSVcdl1U3dd8=
Received: from BL1PR13CA0482.namprd13.prod.outlook.com (2603:10b6:208:2c7::7)
 by BL0PR02MB5539.namprd02.prod.outlook.com (2603:10b6:208:8b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 11:02:00 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2c7:cafe::c3) by BL1PR13CA0482.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4 via Frontend
 Transport; Tue, 5 Jan 2021 11:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.22 via Frontend Transport; Tue, 5 Jan 2021 11:02:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 5 Jan 2021 03:01:59 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 5 Jan 2021 03:01:59 -0800
Envelope-to: michal.simek@xilinx.com,
 srinivas.neeli@xilinx.com,
 linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-arch@vger.kernel.org,
 amit.kucheria@verdurent.com,
 daniel.lezcano@linaro.org,
 rui.zhang@intel.com,
 akpm@linux-foundation.org,
 yamada.masahiro@socionext.com,
 bgolaszewski@baylibre.com,
 rrichter@marvell.com,
 arnd@arndb.de,
 vilhelm.gray@gmail.com,
 andriy.shevchenko@linux.intel.com,
 linus.walleij@linaro.org,
 syednwaris@gmail.com
Received: from [172.30.17.109] (port=45660)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kwk6B-0007st-ID; Tue, 05 Jan 2021 03:01:59 -0800
Subject: Re: [PATCH 5/5] gpio: xilinx: Add extra check if sum of widths exceed
 64
To:     Syed Nayyar Waris <syednwaris@gmail.com>,
        <linus.walleij@linaro.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
CC:     <andriy.shevchenko@linux.intel.com>, <vilhelm.gray@gmail.com>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>, <rrichter@marvell.com>,
        <bgolaszewski@baylibre.com>, <yamada.masahiro@socionext.com>,
        <akpm@linux-foundation.org>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <linux-arch@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <fd642c0843d59a0091931fcf9baa19a9dbb6e2e7.1608963095.git.syednwaris@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <144a79b3-29e9-fa46-bbb3-378a41ac8eda@xilinx.com>
Date:   Tue, 5 Jan 2021 12:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <fd642c0843d59a0091931fcf9baa19a9dbb6e2e7.1608963095.git.syednwaris@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12dc7b30-2e2a-40f0-5527-08d8b1695387
X-MS-TrafficTypeDiagnostic: BL0PR02MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5539907AAE76BB0E1C1710C3C6D10@BL0PR02MB5539.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yY0+gNb36QEcJeDOseknoRT36nlGu5vNmO2yFvZAGzdi1EIW8aNUObF/wC9SgROgsxHapyz49JiH24Zky+lbSB88CF56/zwcTEjtyOVme+zv5GnknwyENqL+AQUHElifrk/v585Dc+5FcgiT3lucHijGbfVIHS1zzb/QUHInEd3/iNjHDRshc9DHPbnYxZv/oMw9erNyC0tNhkQ+lknHhzON2f23GqIKmt4F+mTFIvOxy0b9SjarlTtdmtlV1gotM98NyMgD1lcCXuLFgKXW15wov+qHbv+e2zjBjEVgS4SFYplBLvmSZrL8kT7Z3B2/TraiR+4kKoGJU/iJxyF22B+eqDWk55XHYiD/l8Nej/sbWVPBbEcYj5tGOyJxbwP50o8vkYlqAuC6AsPQ08R7O4oCt0KUfMxG5Kf9ajSJoDGb/rtjivY4UamK9GOB4Q5piMBJ8+dW64NTKZvRBhBECE8sItRbKUTlmLB6g1sFU0LqPRDFNeBRUihJF+q6eAvwiLd+s61OgQz01s7VzYAEog==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(31696002)(44832011)(5660300002)(6666004)(2616005)(2906002)(4326008)(9786002)(47076005)(426003)(8936002)(478600001)(356005)(26005)(31686004)(110136005)(336012)(70586007)(186003)(7416002)(54906003)(83380400001)(7636003)(36756003)(82740400003)(70206006)(6636002)(36906005)(316002)(82310400003)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 11:02:00.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dc7b30-2e2a-40f0-5527-08d8b1695387
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5539
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26. 12. 20 7:45, Syed Nayyar Waris wrote:
> Add extra check to see if sum of widths does not exceed 64. If it
> exceeds then return -EINVAL alongwith appropriate error message.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index d565fbf128b7..c9d740ac711b 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -319,6 +319,12 @@ static int xgpio_probe(struct platform_device *pdev)
>  
>  	chip->gc.base = -1;
>  	chip->gc.ngpio = chip->gpio_width[0] + chip->gpio_width[1];
> +
> +	if (chip->gc.ngpio > 64) {
> +		dev_err(&pdev->dev, "invalid configuration: number of GPIO is greater than 64");
> +			return -EINVAL;
> +	}
> +
>  	chip->gc.parent = &pdev->dev;
>  	chip->gc.direction_input = xgpio_dir_in;
>  	chip->gc.direction_output = xgpio_dir_out;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
