Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBD15AA16
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBLNch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 08:32:37 -0500
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:39942
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbgBLNch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 08:32:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfDH+BWAnFblqrrRgffeKXbA2rKbU6x8ImGlnM7a4wAmPYjp87lz2kvD0PWDUmAAsCCCxMNAEL4mXtB4Ag4nMXym2Rg82iJ5pFGODtsNhvJWKHxBs0jW0GSdyvVTIwEdIjhq9f9Lv+tH0cn0ozf+/e6lbGPHYmYAQczqUwB2AQVeSYriG69MVLHTTaGnKvjvos32Fg23SPxp7qZVQjhNJWzLbLTjgNk5+sUwsHclryvI1+3RmY85xwBX6gz0NpZ/agcookK+RPaE58QCZU5JAEpXaiy86ysXWPFo9H5uv0cBiX1746mZsLN0BuFH5uM4AeomSnDKB0EAxtlE38WeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/+6aI4CSGjyta9xfoND7xrCTLCHsYapASMJV3XsmUw=;
 b=fkuBZVxC3zSVXM4JPHI3oMqseyh48wApZAsn7gU4qEUS+k7GcHO80Z+l5L6lNkTZOH/HFwiih18LNbGWWGk+dqleYJPJ1B7P9WP6RJ02oZTrSSxV8RLnRjycTL1dyVxquBeXphl9Q53I/3pl5kJBojaXXwPQ1sHyUTzSedFnwnWAKe1DRwVBWJp5UUAYoqvXaAg53HCYeZ5a9rk7MZRSsufFEiBPd/EOWWc6do88M3zD8ks7lcjUPxmkR6ntWxtdu5GAPj5g2KLc6TanfObPkpOEHzYy92hp5ERU2jLjgKjjs53WVgldezNhPf4PXreTpUIWUwDf+joYA/XbkD8aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/+6aI4CSGjyta9xfoND7xrCTLCHsYapASMJV3XsmUw=;
 b=rWP4QkxTiEQ50ACrWE312Q/LUTVtC6IovUUNEWq0LBS0gCYUmTTYsZu/Npu74Al5OU1ZufgiGehNB0aboSUjXz5kBAat1MyK10XfElQRHTA3YZvdSmF2lAcJY5ztCXkqkAoINYAeZ/k7wZ5RRhzEo6aMcFhpXXdu+zxuyXIszXU=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by BN7PR02MB3940.namprd02.prod.outlook.com (2603:10b6:406:f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Wed, 12 Feb
 2020 13:32:32 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend
 Transport; Wed, 12 Feb 2020 13:32:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 13:32:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1s7y-0000uX-O7; Wed, 12 Feb 2020 05:32:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1s7t-0005JW-Kc; Wed, 12 Feb 2020 05:32:25 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01CDWJ0Y031306;
        Wed, 12 Feb 2020 05:32:19 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1s7n-0005E5-Ec; Wed, 12 Feb 2020 05:32:19 -0800
Subject: Re: [PATCH 00/10] Hi,
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <cover.1581497860.git.michal.simek@xilinx.com>
 <CAK8P3a1NymovoUxYBF8Ok8Rfke7ECW49bmc+K-=vtH_Bz8_7jQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a05bbd70-9531-9445-c842-5bb8336d273a@xilinx.com>
Date:   Wed, 12 Feb 2020 14:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1NymovoUxYBF8Ok8Rfke7ECW49bmc+K-=vtH_Bz8_7jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(31686004)(4326008)(70586007)(110136005)(70206006)(54906003)(316002)(6666004)(81156014)(8676002)(8936002)(356004)(81166006)(336012)(2906002)(426003)(186003)(26005)(53546011)(31696002)(44832011)(478600001)(2616005)(4744005)(5660300002)(7416002)(36756003)(9786002)(106390200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB3940;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2267e22-056c-4375-2753-08d7afc002eb
X-MS-TrafficTypeDiagnostic: BN7PR02MB3940:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR02MB39401692B35BDC57D1321034C61B0@BN7PR02MB3940.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqFMQEA1TurfJe8amd2jHN9wmqVzlrNPYYQElrG1LD+ulI8Ap+ycwiwfJ7YISJSg8jouU/w/5lJkl4krmrYLCp01WxEoeLXN6kVXT9KcQ4gWiFDUKC+C2ygowCD1evJzdY/iEHl1HnsenmgvMRmSwK3NBPh2Ctku1QmTwCUXfJU3mJ7d8uJqUH0RJT4oJvH1fnQJo5YxrR/CgvkCBRgTTFVe5gulidq2/lHpG5scl1KJBGrRcqDXDEDcmV73pxhozo/IwyRuitnDapJaUcO2vNwJGBu7+GNaSYPR6DaFYKuAQtHkFMler3drBGkhr7r7nSHf3CNIqvGzLl7q8w1KxluuuI+8gzCC0j0SHZFfisFF3kTN5Umpdttkr4JxZM+Big+9KoD8+Df0Do/EPtWnzCz4cfneVz9ekZvIuRSXbTCgzJZwJ3n1tTi+3zZKwfM/XV3KyK+wFpgJzvmff6DQql6+xY2NPXydDcJaVOuSw5IIM/wA0ZKwQvbPea4UjOHi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 13:32:31.2470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2267e22-056c-4375-2753-08d7afc002eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3940
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12. 02. 20 14:02, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 9:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>
>> I am sending this series as before SMP support.
>> Most of these patches are clean ups and should be easy to review them. I
>> expect there will be more discussions about SMP support.
> 
> Agreed.
> 
> I had one question about a detail, other than that:
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks,
Michal

