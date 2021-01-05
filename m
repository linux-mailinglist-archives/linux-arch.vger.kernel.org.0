Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E452EA992
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbhAELKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 06:10:43 -0500
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:59073
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729210AbhAELKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Jan 2021 06:10:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAeW8Qsnd1BFtMWkFATAY7ulqB2r6rjZdRuzzr7pvwwBHFkQWUIz3f1d9jKX0A1Fcu8dojesRijHuuXQIpNmrWXauW0k9ET/cOCiYJSxe2346BjiIsB09OzyfQYNpCh9amiGnRGWej0MZ5rr8IVdp9UQapcN5NCE5RzVMh1mSwwVRl++h76waIazv5itmZoHG5aWEPlvG1IupptFXMeiqeHtIhkXTVx94cgzlrxaFh6rQmIt///nO7FU8x/197tjQUQkJc5qQATkzOfigks7jwwTlVhki7Ao/If4iDw+28vXHYD5lGwrqyNozWJgXHIo68YKuScfl1pngdNKnRWX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8dDKZ7IfYQbYoFvm8NpM71p4M5fYj8aYrYg8XiXeJ0=;
 b=jakC7+58sg6rLwJcRKzSTS+yuwzT0SR1Sat2t8DpBE9Ddwo0iScnvcYjWlWbcqJEpDJ/rc0Sdr5vB6WwrZkpMie44Fjh74ezM/sZ3QN7aluecGG4padXeeGJKWU4RE0QqTW4IYxodPm8QMnLzwVqOB+0uT2JQoJBFLuL1DsFKba07C7ddrn99AJl0NYWXVaYIiepT05k4Nlf7RBwEZc3/rUkRCD2A6shiF4QmfXcqKusRr6xmU5E7+/oulrUlBUxRdcPzvotgyQH7ga3nCTSO5vXenOcBIGLEBkRAbW9ZIEicbgHzyWtmvkiRqwqRbROVopa4Va27Ki9RltDT/oF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8dDKZ7IfYQbYoFvm8NpM71p4M5fYj8aYrYg8XiXeJ0=;
 b=QT5owJuIWVO3mPycORw7t5tyK8f5Ypn0RcDHwFLj1WRxbZJIu+uIt4fop0sXX48Xb5sRfh5/cdWJQ1pToiFqlpeJx4kCGk0lsMRwIuBIzjOZO4elecpJm6lSul/Zo7VJuFtNogyLWWzojvoaBrr6INY6s1GDyMeJbVAZoQTSXD4=
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 SN6PR02MB4352.namprd02.prod.outlook.com (2603:10b6:805:a4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20; Tue, 5 Jan 2021 11:09:48 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::ff) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Tue, 5 Jan 2021 11:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.22 via Frontend Transport; Tue, 5 Jan 2021 11:09:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 5 Jan 2021 03:09:47 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 5 Jan 2021 03:09:47 -0800
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
Received: from [172.30.17.109] (port=46342)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kwkDi-0000GS-ME; Tue, 05 Jan 2021 03:09:47 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
Message-ID: <0ddb32ad-c330-b1d5-34e0-5b24611a4d1f@xilinx.com>
Date:   Tue, 5 Jan 2021 12:09:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3407ca10-4cc5-4257-4681-08d8b16a6a74
X-MS-TrafficTypeDiagnostic: SN6PR02MB4352:
X-Microsoft-Antispam-PRVS: <SN6PR02MB43528CE9AFCFA3046E414084C6D10@SN6PR02MB4352.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4FQW8+vWT3nrw+N22hJMANkdKalm+LEwsx8A7BQVP0kV4U2+LdKb5xtEL07UuVveP0pGUz3qzAzzwX5pUdlUsDxppnZnxsvkbl+WfQEvFF9V0I74lXE2FMLyyAWbi6OsQxCCKxJR04SUSdPv5hhTLlERUBke0swZ1KI/x3KD5zXuEN52+XSJpaLVVlxNzrJA0hPKDveuWSAFhC39Pqkdh2xVEpeCcE4qxxKjxq/PdAlfzKLVceoz+B0/LyKRle9+/VuD02x6H1hyX/dxm6WiTkHkYB3jK7HjgUXo75ywx1m0oVzlCGkP0fRoetgCTegRIdj/CfbifVq0JSIqbBM5/Y3sc5Eip4mlvORZc5f0XF2wg5wIakKLt6TPc6maAUgy3PHk96HOZlnzhtbHzZt8QXUVdhZzP0yT36WfT9XyfLMzL9YHJ7WNaQ+kmuqw92iotimTzCQd1dpzW/UNejiGwX+oFSUa3Ofc4FV6/hxtx2TNAuzVUHv/MjGGqVciyZtFtaBxFx5hr625f/ne4PYgg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(44832011)(8936002)(83380400001)(426003)(4744005)(7416002)(7636003)(6666004)(8676002)(356005)(82740400003)(54906003)(316002)(47076005)(110136005)(6636002)(2616005)(31686004)(36906005)(70586007)(36756003)(186003)(4326008)(70206006)(2906002)(5660300002)(9786002)(478600001)(82310400003)(26005)(336012)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 11:09:48.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3407ca10-4cc5-4257-4681-08d8b16a6a74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4352
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 26. 12. 20 7:41, Syed Nayyar Waris wrote:
> Hello Linus,
> 
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
> 
> (Note: Patchset resent with the new macro and relevant
> functions shifted to a new header clump_bits.h [Linus Torvalds])
> 
> Michal,
> What do you think of [PATCH 5/5]? Is the conditional check needed? And
> also does returning -EINVAL look good?

As was said would be better to handle it out of this series. And I
expect none is really describing fpga designs by hand and using DT
generator for it. But I can't see any issue with checking that we are
not exceeding certain limit.
Just keep in your mind that every bank has max 32 lines.
It means if you say bank0 40, bank1 10 which is in total 50 it will pass
your condition in 5/5.
It means maybe checking every bank separately is better approach.

Thanks,
Michal


