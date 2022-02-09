Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A64AF454
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 15:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiBIOof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 09:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiBIOof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 09:44:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C00C0612BE;
        Wed,  9 Feb 2022 06:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT/DGE+ty/5ONcS/+TBJuSX8582FddimUQBiigs4pRLqiZ+bXEmrKBbOML7yMxQruKbzT6fTeGfA6jmTaBohQJnhTE7bLwBbot7TFzlsSfKrU8Gy8QsOmB+gN4OxPzbLezEOclMXbv6YLUo4tFY3IWnY4uZWPZjtN5NRSM3ioEHEVT/HE8/2hmBF9BKfKW8wHp5+APqvL34ucS6kmzsA8nMo65L0+q4rDUUiH+8zs3wh6NK/TBPWIZD1WvNQmBTQj4zfAN5uyvh82FOAaj7FQDmaE8tqPpUkZSZfRi3uHtESNwLJBjHDPZNkprWcWhcITeIteZ7eNWBUC+gVkmTHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X7knvcogqbQc+4wEZXeNuYk3Cr3bQgj9szLXG7OTSU=;
 b=dfG6VzbyMPNcFCPJGlXDow2XEATS9drowuyXI/lwDt+PFd49PxByMGQwP9M6zuDXfjk2S9IGwE4KHwqEhOYEQf4mSrUpn5xvfj8Sd+PBybQCiM+XXKuGORgsRHaO5QL0Tz4iwKBL8cp+4YGV7tx1m3H2zdo8ZsJN18985rSo3r4PDKyDHBwmLRbXfg5QEHcb5IMFb4GRTiwm3OHXoJFbOCD9E7QTZa8rftlwmg0TnW+WF1wp/L5um5witoLFbmj0j2kMhwUUZtrZosugNWlhRUy7mtDdwznDoAoJ2ZwB3gJXGlJ53zcgQRp8ancYB3b5zVixuXTxj6w1J9vHUkimlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X7knvcogqbQc+4wEZXeNuYk3Cr3bQgj9szLXG7OTSU=;
 b=nkAe7n5y8/YwqeIKWQlvvyDAUfRKeRjwzUBGmO4Cg8bAeCGe3yt7HB3fS3fuoaMytCQnaD3jTvOKke/74h2dJmrrbJGm+ALbNUAT8mdH/Xct5R0b/B9gEjRHXG5jQUQDAYZW+GeIXAKxEO9Y8kzwD/n7D3B3IE6AR6TgxL37glM=
Received: from BN9PR03CA0606.namprd03.prod.outlook.com (2603:10b6:408:106::11)
 by SN6PR02MB4752.namprd02.prod.outlook.com (2603:10b6:805:8f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 14:44:34 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::86) by BN9PR03CA0606.outlook.office365.com
 (2603:10b6:408:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 14:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 14:44:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Feb 2022 06:44:33 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Feb 2022 06:44:33 -0800
Envelope-to: arnd@kernel.org,
 linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 hch@infradead.org,
 ebiederm@xmission.com,
 viro@zeniv.linux.org.uk,
 torvalds@linux-foundation.org,
 arnd@arndb.de,
 geert@linux-m68k.org,
 peterz@infradead.org,
 catalin.marinas@arm.com,
 mark.rutland@arm.com
Received: from [10.254.241.49] (port=40356)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nHoCv-000CdA-G4; Wed, 09 Feb 2022 06:44:33 -0800
Message-ID: <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
Date:   Wed, 9 Feb 2022 15:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abfe5172-e11d-46c5-adf8-08d9ebdab04d
X-MS-TrafficTypeDiagnostic: SN6PR02MB4752:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB475218FBA9BBF24E9D935D2CC62E9@SN6PR02MB4752.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xno8asaCI86cgIRxsFVvtU0guEhKo5/LZHwecQ6Xm00hP1X0QtMJ7GYlFn6NOJAsONTbPPgUP3x3A6Uw60RJ85fv+i/4H6kBco49H2jUHPcS/h5rn//8F7XenuEwY9yATgt5XnwZNFF5+21vL+mn5QZqYSFfgtWTpBRca9ItUhzJ9DkHBKq64lq308JOjRZdSTCohbnaxqtLPMZ19pqgde1HOvi0Gn9oVtZC2a1jelqxVeMj2MEHZnAIyceNfVHXiAtEPpecUlxg+IJ0GE27TOaTVEf2BotY1W4px2zURaOGv/7mpU6TRem9ETBOsvGWC4rkmUw5xe0B3ZlB5P2N2HqSaeXx+W1b6rrc87WBkF4W2vGsvqEHcUCN1xs3D4FgVQXW3lZJDcqmO8Lp+14nyKgaE2vRlVpC4mYDW6E9UxnEaZBpkVJv0FlIP9kEkINLB8lULm8xGkbRm0hneLhpN+0c4EM+nHZwLv5Vvk6bcll+DMAp1veGneS0Dfun3w/ym27oeFqbwOqsdeSYhXLwRatMqxrLn54765eINR2qRhFIDq+QDzpBxiD1yj3HwOKIhlUcJ2bt0b3JqI8BNMGyORrjK8kY1+xXovSt5YQ8FQk+ZIpwT89NlC9MmThZyfxDmeZBcgj2rk2bYvGL0leRk7P5vYDpL54RweSaK7Bne99jAv+sDDnX68YLt3g48wgwVF0ORJZciebVNENC8ShiuAROVDNPp2+ArTXADollyXiYyI1kuasTMxn01gW+elfcEooCWxPzLxCu9PCzU7WXJmx9QsxK8Kvu6fCIJqdIImaDOsdyv0QTpGp4hbmVZq/d
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(508600001)(31686004)(8676002)(8936002)(36756003)(82310400004)(316002)(40460700003)(53546011)(54906003)(4326008)(336012)(26005)(70206006)(70586007)(356005)(966005)(2906002)(83380400001)(66574015)(7636003)(47076005)(6916009)(36860700001)(426003)(2616005)(31696002)(9786002)(186003)(7416002)(44832011)(4744005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 14:44:34.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe5172-e11d-46c5-adf8-08d9ebdab04d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4752
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/9/22 15:40, Arnd Bergmann wrote:
> On Wed, Feb 9, 2022 at 2:50 PM Michal Simek <monstr@monstr.eu> wrote:
>>
>> Hi Arnd,
>>
>> po 17. 1. 2022 v 14:28 odesílatel Arnd Bergmann <arnd@kernel.org> napsal:
>>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> I picked microblaze as one of the architectures that still
>>> use set_fs() and converted it not to.
>>
>> Can you please update the commit message because what is above is not
>> the right one?
> 
> Ah, sorry about that. I think you can copy from the openrisc patch,
> see https://lore.kernel.org/lkml/20220208064905.199632-1-shorne@gmail.com/

Please do it. You are the author of this patch and we should follow the process.
Link to riscv commit would be also useful.
Definitely thanks for this work and getting this to my attention.

Thanks,
Michal
