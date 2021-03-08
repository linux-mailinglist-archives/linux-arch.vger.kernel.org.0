Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71CA3308AC
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 08:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhCHHN5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 02:13:57 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:46273
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231805AbhCHHNa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 02:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq3xNrGemXwkaWnG+vSh4haCawCepLt2SvPgwy/YaeePSP3fUXtD1bjtLNeNsswXZz1OPtMztUb6GJIXfOqc/Qe3WhzrGkiSZ4Nn8MqSjDaSkfGCfiThAHJ4ZDlwRqeiN3Oes4yqLrOSq2FEsM4qU2guoBz2U/vi6BKm05jBsD20L8pqXu1XPeMtRxO7Mds21e/kgJLEbdHUE+XEApS0GzkUcDarZPp9U5V7etJwF9ZC90zlX7LksbTARFt1sWTEb+xA+1xp7u0zPGkxMZ77v70Kk06ICLbCMDRjiyNtrQYH+YdWBfrQFmD5QrlUzU/7zUJ3wjSnUY9RWb1xI+tAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyQoam767NkKeEqHK1mOh3IVmLsvXX0NixaSASlo72k=;
 b=ERa7l87UKn4qxhmO8njTEQL2lo2Ac61wEL9DqPgKkGlpinJcxiPxSyFF7KuaslMHDy9nnKnMQYwh2BA574DGmea785VHCh963XkmW6jt4FFbkKBKil3xd96AHrFd2yl5eVE8djxzJ36z3xKsoaQSUgpc/HoPA7ZXikWqZMV5ifIouoosp+Ai+5TD0eMvbB4BpUuZLk0xo3taOLwaIBjTG3rTWIpiuog4hAZfmriXXDqYMx1WcHeyDuGBaEtQtfgiab2zHykkbdzgHPAHtrFlQXJGgHW5KDXPzxm3kFKf3pmRaJnGR6ZS0MnLmx8eNsnK9zEuRGbhASO6i98YmIJA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyQoam767NkKeEqHK1mOh3IVmLsvXX0NixaSASlo72k=;
 b=dzDnALWMLbl5VtBA588m9Hi4tvVIA7Y2eVxxVueNPmGvIbJZrWBtrOPReZhGL5mz0Qcn08p8VEyOBMmZjugUvMdtBCn4ES/BR+d77RiMcn5FcVytvS15ETiSspwi29aVTJtuZQJ8iPhprzG0zoKMgiltVC/6WEaB0VZfnkqddL0=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by BYAPR02MB4311.namprd02.prod.outlook.com (2603:10b6:a03:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 8 Mar
 2021 07:13:26 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:329:cafe::61) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 07:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Mon, 8 Mar 2021 07:13:25 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 7 Mar 2021 23:13:25 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 7 Mar 2021 23:13:25 -0800
Envelope-to: srinivas.goud@xilinx.com,
 michal.simek@xilinx.com,
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
 linus.walleij@linaro.org,
 rrichter@marvell.com,
 arnd@arndb.de,
 vilhelm.gray@gmail.com,
 andriy.shevchenko@linux.intel.com,
 bgolaszewski@baylibre.com,
 syednwaris@gmail.com
Received: from [172.30.17.109] (port=43776)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lJA4y-0007ww-Fq; Sun, 07 Mar 2021 23:13:24 -0800
Subject: Re: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
To:     Syed Nayyar Waris <syednwaris@gmail.com>,
        <bgolaszewski@baylibre.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
CC:     <andriy.shevchenko@linux.intel.com>, <vilhelm.gray@gmail.com>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>, <rrichter@marvell.com>,
        <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <akpm@linux-foundation.org>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <linux-arch@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@xilinx.com>
References: <cover.1615038553.git.syednwaris@gmail.com>
 <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com>
Date:   Mon, 8 Mar 2021 08:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d1e5c9-aa2c-4fa3-208d-08d8e201aa8c
X-MS-TrafficTypeDiagnostic: BYAPR02MB4311:
X-Microsoft-Antispam-PRVS: <BYAPR02MB431111C14600E00495D7E2ABC6939@BYAPR02MB4311.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWPKdN9olhQANAEdWiq41rt2mq4QZ+vYH0yKqhZOrA0dBZuj9yfVfhPO+/j9EBpP7nw+BTJgJIiqyqW2ysZiXGx8LgVv8mBXa0idT3ojbjFjCFeT0fbXnIWNZUJ5xOTW3Mo/k6mgcN0elsy0cO5ahmAsJ4KEwTESZbd/qXcIxYRu/6My9s1GlmLrjo6i6S+C1Q9mMAz+Hs8rW0d5Bq2oqAXbG+6xFAs2RlcNGl6AMKHiC+2O+VeWnXtyyu0c9v+d3ek8oqhAxbnEafXL7yc6GcJX94xuJxLLdL9TwoEBFX3vnJsaKVZ5eacC32DnLRGLmK8QRiz4KG087s/aDdLqmdEkx0wR8vKIyg7xvxzXB/J3U70pPp1wOG7kkZLjATTxk8amvt05OF740vAR/d5XrpPzY+oQesfFfFdYBenw5I0JCCbPwQtj4xnBWldZoVkvBwvTJXz/82Z4X7ZdQc4BqbYNF+Ajv0tTrk7xCBdr6hv6Vozp4CyFjg6+bz6AeOHtbNaVX6i80XzO711VONyWYObVrPAe7uAoA2AiuaZ+kTRslff0ACtshcA1fd066XpjQQnlpLqpQmC7RYX/Mq4lyy+kMupbBsrdWJItMYzNmnUr9fn58S1kX3w/z7NO8aCmGS6mx225plpMO/8/m8tlOZqJPDWz0CB1Y9ea28874hFDbFEh/vXNWHpSoNctGUqQKTKryvGq8sI4FRLmuBCSdVp2mxCV6VnqkWjI3f8g72c=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(46966006)(36840700001)(316002)(36756003)(53546011)(47076005)(5660300002)(82310400003)(31696002)(2616005)(82740400003)(8676002)(36906005)(44832011)(26005)(356005)(4326008)(336012)(31686004)(83380400001)(107886003)(186003)(7416002)(6666004)(478600001)(6636002)(54906003)(2906002)(110136005)(36860700001)(9786002)(426003)(70206006)(70586007)(7636003)(8936002)(50156003)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 07:13:25.5360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d1e5c9-aa2c-4fa3-208d-08d8e201aa8c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4311
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/6/21 3:06 PM, Syed Nayyar Waris wrote:
> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.
> 
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 63 +++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index be539381fd82..8445e69cf37b 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
> +#include "gpiolib.h"
>  
>  /* Register Offset Definitions */
>  #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
> @@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  {
>  	unsigned long flags;
>  	struct xgpio_instance *chip = gpiochip_get_data(gc);
> -	int index = xgpio_index(chip, 0);
> -	int offset, i;
> -
> -	spin_lock_irqsave(&chip->gpio_lock[index], flags);
> -
> -	/* Write to GPIO signals */
> -	for (i = 0; i < gc->ngpio; i++) {
> -		if (*mask == 0)
> -			break;
> -		/* Once finished with an index write it out to the register */
> -		if (index !=  xgpio_index(chip, i)) {
> -			xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -				       index * XGPIO_CHANNEL_OFFSET,
> -				       chip->gpio_state[index]);
> -			spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> -			index =  xgpio_index(chip, i);
> -			spin_lock_irqsave(&chip->gpio_lock[index], flags);
> -		}
> -		if (__test_and_clear_bit(i, mask)) {
> -			offset =  xgpio_offset(chip, i);
> -			if (test_bit(i, bits))
> -				chip->gpio_state[index] |= BIT(offset);
> -			else
> -				chip->gpio_state[index] &= ~BIT(offset);
> -		}
> -	}
> -
> -	xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> -		       index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
> -
> -	spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
> +	u32 *const state = chip->gpio_state;
> +	unsigned int *const width = chip->gpio_width;
> +
> +	DECLARE_BITMAP(old, 64);
> +	DECLARE_BITMAP(new, 64);
> +	DECLARE_BITMAP(changed, 64);
> +
> +	spin_lock_irqsave(&chip->gpio_lock[0], flags);
> +	spin_lock(&chip->gpio_lock[1]);
> +
> +	bitmap_set_value(old, 64, state[0], width[0], 0);
> +	bitmap_set_value(old, 64, state[1], width[1], width[0]);
> +	bitmap_replace(new, old, bits, mask, gc->ngpio);
> +
> +	bitmap_set_value(old, 64, state[0], 32, 0);
> +	bitmap_set_value(old, 64, state[1], 32, 32);
> +	state[0] = bitmap_get_value(new, 0, width[0]);
> +	state[1] = bitmap_get_value(new, width[0], width[1]);
> +	bitmap_set_value(new, 64, state[0], 32, 0);
> +	bitmap_set_value(new, 64, state[1], 32, 32);
> +	bitmap_xor(changed, old, new, 64);
> +
> +	if (((u32 *)changed)[0])
> +		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
> +				state[0]);
> +	if (((u32 *)changed)[1])
> +		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
> +				XGPIO_CHANNEL_OFFSET, state[1]);
> +
> +	spin_unlock(&chip->gpio_lock[1]);
> +	spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
>  }
>  
>  /**
> 

Srinivas N: Can you please test this code?

Thanks,
Michal
