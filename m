Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D69367C1E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhDVIQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 04:16:14 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:58368
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235353AbhDVIQN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 04:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo69zory96Utknbi2bpOzH+Wc5fqmiU8PCEgEGrxOw8PoDp5iLFqtRlIrWwYWhZckBM7Y77ieVrhQN8hhG5E3eXUZDc/lKsoLAMQpqXoLdw5QnXXjxjR3UQvDb8creUNW7qDiz5hAwqD0OC2Ao1bOAb8orzjK+kFxSDn3Z0gaKjQWWyIGYBsiHhdcD8s+TpM4v8XBOtJrH3GIEo6iE1tG3eu+Rs9ow47lxc0EE7L2kb+jF6tg5TQ7xaPS0TnPHw/MflOQVw8GRb6bw5J+iTqFr63a5voS12pWISq4MPtKfzp/BqmEDKCtzrY8XR8kY82i5+DfruewWsfcsP1mMxfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmrFbzLXqyCvnKwsPoePx5gw9HpN/jnKUZHcl7dka6g=;
 b=W7VAKswUNrC+1B3L5S62JFMycpMw3lfu+TbTg0r7M2k52BUolS5uvpMNbgwemVgmWoPN8Pau9O1EpDVhonIiRmYuBx34E00D6uqwH2HShjklkqZtiyc1YSyrYlUPBHpiN1bcUnE60M91BnRoCmxHs6Jg0dJ+yeAII3nxLnkoP1wynTlCpdVEW5JnUOzQwF2Z92/aeipkZfM2X5f5N0WhKr6DycEDNgngpVemytIDGSGLMyPjMscCpL0lA5uuga0H5/sOYYyTDCHliBM9uqsVoshC2tvfWfO9G0HzGri78Lbh0AQ9ny86WkVJzNcDWux3T4SV+rmEOjW3mQ0hHpPgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmrFbzLXqyCvnKwsPoePx5gw9HpN/jnKUZHcl7dka6g=;
 b=e87c/9FMYmP7YykZp6nmWAWdI9/TaSmsHYrn7ms8wMMqtTcQEpDkmwyYe2bWQQPLd3ri1PTsWziC7A+3PqdPEvz4Wxgbm5cVqnehhBb2MI6E1/t1OCjkQscG08pGtYS6gzZR/U3/AuFAS9uz5v8fdRd3mdHZpz5lcGVGCR85vKz8pfbLw88AUWqCxwrSCQ+Y+vSqYdqEczTKxij+/NJcSffscB97s+hX3QwejN8QafwvLMHUcNJpjfidL5kgep7hpV5JULGODNbyVvfmFz1xiqVvQO4Ur8K5ZkipWE5KOOQy6siaO7SgSPzGZhYbvFnffgKiyLvrnWL8LVw4h+01YA==
Received: from MW2PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:302:1::21)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 08:15:37 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b8) by MW2PR2101CA0008.outlook.office365.com
 (2603:10b6:302:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3 via Frontend
 Transport; Thu, 22 Apr 2021 08:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:15:37 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:15:33 +0000
Subject: Re: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
To:     Marco Elver <elver@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>
CC:     <m.szyprowski@samsung.com>, <dvyukov@google.com>,
        <glider@google.com>, <arnd@arndb.de>, <christian@brauner.io>,
        <axboe@kernel.dk>, <pcc@google.com>, <oleg@redhat.com>,
        <kasan-dev@googlegroups.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210422064437.3577327-1-elver@google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0734b0e8-b4c0-05bb-b90c-de89edb61b5d@nvidia.com>
Date:   Thu, 22 Apr 2021 09:15:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422064437.3577327-1-elver@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d710e30-c035-4cad-4b5a-08d90566cf64
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4548FCE178160AD74170443AD9469@DM6PR12MB4548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KTlrxID9+XCJ4fyydsUEi9epDHmEVgBvdgfqpG+VnfI+n+qHha2Wbp5v9G01L76nQL0fKDgZOOHKkQKM45PnBCKrDjH0kw7s/NSerUqB0XK9ItMKMLXTQFGBA6bH8AzOoQgw7rGB2UfIBZ37VEDnQhwpu0sIb65c9DSaCXTsDQew8oMI7ez1g0wWhMyV3M9Gk6aD3XJZnPth3egajqo8T/x+LLbQcJzbLvAwFOZBEOa5LSvBkGULXEBCYcoqXEG8WxhN9BfxFGBv+9NE34V0mPF0dvchXhaRnGIz6WXzniEQtsC7JytlMfwUOtU5LTs4KA4qWAv+zmlfu8zE7Ez/AfRcc3gV9P2urSS6RUt9spnmztu8mL3gzmrgDpljul6N8xPIThMyP8iVIdmg3isoS2IyvyFO1oKP0Zo+KY31m0WEmI86WFrN59ZVISDG8SNZTq3QJAtFabuBJZKB1jl2G86oFXJ2Sl6uLeVS2jnN78qnjDUJ7VvIE4AxqJU8Mkz/C7YHm+B0UwjLV9R8s+Rw5yj1HrFSN3VVUZOuC2U0mfJV154rCM38Q4wRyMP0KS5GmsjrpjqAAbw8tH3z3pWk6/Q2CyHOCy/QtPRyr7aJDSNJfUUwynLngqzTBV15px91hYZ1mp8sZTa7ar8JHVWIcXF2asraa+kEIIdlFiLeUvtaarsxY5fniWHPmO0vDqM
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(26005)(82310400003)(478600001)(31696002)(356005)(16526019)(53546011)(2616005)(7416002)(47076005)(2906002)(426003)(8676002)(36860700001)(4326008)(70586007)(316002)(8936002)(70206006)(336012)(86362001)(5660300002)(110136005)(36756003)(54906003)(31686004)(7636003)(82740400003)(16576012)(36906005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:15:37.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d710e30-c035-4cad-4b5a-08d90566cf64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 22/04/2021 07:44, Marco Elver wrote:
> On some architectures, like Arm, the alignment of a structure is that of
> its largest member.
> 
> This means that there is no portable way to add 64-bit integers to
> siginfo_t on 32-bit architectures, because siginfo_t does not contain
> any 64-bit integers on 32-bit architectures.
> 
> In the case of the si_perf field, word size is sufficient since there is
> no exact requirement on size, given the data it contains is user-defined
> via perf_event_attr::sig_data. On 32-bit architectures, any excess bits
> of perf_event_attr::sig_data will therefore be truncated when copying
> into si_perf.
> 
> Since this field is intended to disambiguate events (e.g. encoding
> relevant information if there are more events of the same type), 32 bits
> should provide enough entropy to do so on 32-bit architectures.
> 
> For 64-bit architectures, no change is intended.
> 
> Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Marco Elver <elver@google.com>


Thanks for fixing!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
