Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DD2EA97E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbhAELFD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 06:05:03 -0500
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:35054
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbhAELFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Jan 2021 06:05:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV0rTl5Q3Gn8iw6a5P7K3Q9EfmVQjLM9R/0H5wLU+4hici6ci+ERHqrB8ihxLBsvnkRBoPyzX0pYwyx08TEJRnK2CJtEXLVJ3jPET+2gk99dIEjEymfaDsJW1fDr6WH/Xj7ZLfQ3W9ByXvgmNkLnP1kgAThIOleVCw9kronkEBJPuA/X2mfPQSefJ5rQ4O/kJLjbatNrdz/eteDZAC4BI2UjPms3pJeP0c+j/U/3UUTfO1loWVAt2zHMX3yg1VxBJBXC4/YiGVdfoadwLZ7resUp2DrvsYRfAroGw0yCXH1aCTN2zj88NSMBL8XWXMSZfbd3WSkyfJbplSn18iNkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbypMEbc6OeY/hqya3aOrb5vwWWd4X1gj2QBx0ezLY4=;
 b=aXQ/nr/yuIAU1ndobmIgUoo4bgv7qseaW6X1g4FbZArP6nrRInu+QDAybuwp9U8zmGoAbIACEe6B0T4sSzRI2E0KtK+JVW9DPsKZ9nr3TwTMntIlFGpj9V8Fy5vE8IQAZD56Nfr2BQnR8YrCAjhdrBPFnbSaMmWrinBr5WVl0thk0g9rlr1yeD8zO/QgELWlbZJNAZW4zGMK9AYMNRpBzVN9NWDfqRJnH3TluQ1C1f2jgoO57h4RpeQckoQxli63u/q+YoCOsnmP6WjriGqezpkjs2vFwp6rRgR3lBuJvGJFWplxy05SH1QF7bA0v45R2i5riaUs5OoJavpqhq+mEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbypMEbc6OeY/hqya3aOrb5vwWWd4X1gj2QBx0ezLY4=;
 b=lmJNb9cu+WBZmfCfcoBAL2Rm66hLt8objIgshXdqqq/faeZyKfBRHVXaw7EjGgsy56A5uriBTZ8vrXir5LZktb8HiQzINA9S4OE+xJehpXE17FpLL+XUTdWH6d59VRlVL/n6TpC089wtFE/JeYmLyesWkefVcrLnN+Xa4HvTk9c=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by BL0PR02MB4788.namprd02.prod.outlook.com (2603:10b6:208:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 11:04:14 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32d:cafe::2f) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Tue, 5 Jan 2021 11:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.22 via Frontend Transport; Tue, 5 Jan 2021 11:04:13 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 5 Jan 2021 03:04:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 5 Jan 2021 03:04:09 -0800
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
 syednwaris@gmail.com,
 linus.walleij@linaro.org
Received: from [172.30.17.109] (port=45836)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kwk8G-000875-Rw; Tue, 05 Jan 2021 03:04:09 -0800
Subject: Re: [PATCH 4/5] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
To:     Linus Walleij <linus.walleij@linaro.org>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "William Breathitt Gray" <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <cover.1608963094.git.syednwaris@gmail.com>
 <5041c8cfc423f046ca9cf4f8f0a8bd03552ab6ea.1608963095.git.syednwaris@gmail.com>
 <CACRpkdYmoEjTzWv7wdrHhc8VFxFB+=QQwKA6YY+prydjgUB2aw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <361b118a-f425-2b79-4220-47e3f9c39306@xilinx.com>
Date:   Tue, 5 Jan 2021 12:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYmoEjTzWv7wdrHhc8VFxFB+=QQwKA6YY+prydjgUB2aw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2730510-ec10-46cb-c80f-08d8b169a336
X-MS-TrafficTypeDiagnostic: BL0PR02MB4788:
X-Microsoft-Antispam-PRVS: <BL0PR02MB47889C7D81B0408A0B1B4F89C6D10@BL0PR02MB4788.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiUqDoEiwgxBmdjDrwB+G/f/MNcWWFfFxgjS4KtLv3heoJoZNmVzr4iFBNXZ5FkpjxS7yoNBEjXHkvQhBS2Jy51azVFjSUnOKbme/uqCdJRlSP+PKYvrl21n77O3CYQIIESUiykPqixrlW5FTwFiayAh6R9/IZ9Xf8HY68UpovNEuCdDmevTuNxyODULwhLzMUF8QTmx8hP1sIC3ynlggq5WRAALHynczWPNOePmAen4rWUJeR3y+FZEodTckQJB41qo5KUh3VVEpp17fxqW6clJbIBoNbkTzrkv6BpHqKw4Dn3/gE5M2Nowa3knMoHdRQC/Mh83enAjz36uL4iYvcrHKoWR7QXK1V+8xynlPDUzCaFqdZGC2jSPGN+Y4Y1k9dvIDBa6qoyqsEqhKXb/2F2t9nd+3k6nQ0z89lJYNCbZbUvWzekjwGf/EoXx77qt661RZ3Sb9CQmZ2hiuUG5ecXGTvOjjg81RHiU/F8HIcV/2dw4NmTCCN1tSy7RhB1h/Racci6mDOjEtp6HzwwjsXqOR9MYwQH2P2nc9zCRl+M=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(426003)(44832011)(70206006)(7416002)(336012)(2616005)(6636002)(70586007)(47076005)(36756003)(9786002)(186003)(8936002)(31696002)(4326008)(31686004)(53546011)(82310400003)(5660300002)(36906005)(478600001)(316002)(7636003)(26005)(6666004)(82740400003)(54906003)(110136005)(2906002)(356005)(8676002)(41533002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 11:04:13.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2730510-ec10-46cb-c80f-08d8b169a336
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4788
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, +Srinivas,

On 27. 12. 20 22:29, Linus Walleij wrote:
> On Sat, Dec 26, 2020 at 7:44 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> 
>> This patch reimplements the xgpio_set_multiple() function in
>> drivers/gpio/gpio-xilinx.c to use the new generic functions:
>> bitmap_get_value() and bitmap_set_value(). The code is now simpler
>> to read and understand. Moreover, instead of looping for each bit
>> in xgpio_set_multiple() function, now we can check each channel at
>> a time and save cycles.
>>
>> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
>> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> 
> (...)
> 
>> +#include <../drivers/gpio/clump_bits.h>
> 
> What is this?
> 
> Isn't a simple
> 
> #include "clump_bits.h"
> 
> enough?
> 
> We need an ACK from the Xilinx people that they think this
> actually improves the readability and maintainability of their
> driver.

Srinivas is going to send some patches against this driver. That's why
please take a look if both of these changes are fitting together.

Thanks,
Michal
