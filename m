Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC817117B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 08:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgB0Hby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 02:31:54 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:4011
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbgB0Hby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 02:31:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hej/yRbStgttwYJvp1RvbWsDPH5fqLlrbYEwIuePVGRlQmVs47L74rFlXkPxYgZJg2LynWukAoAg+ZCv840eHqSIYjeJXXsBjNlTTt6bjbg2OI2rDl6d+oCfFolsznm2cvZfCV0O3WY/IuvqYJsI0058//co1lB7MfRrQzkeZt+kQavdwfNCOPmnhFxeV+M6n3ImHP03UIDOB94vdbWkXWv76WR0VvGaMUNYzjjXF1WU0fy2EP7kH2x+Wlyu2SBb9vWFTt4vhgru35MVWJ6ZLMDfpBhDhg61ZiwS3xjEfb3idNawtO3dI73i7aUjigrQuQ9YXlMBmPLbuggkfa0HoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boyzg3ulGMaTj4eIyYG94pZEm4BUpZ2kxBq+r7J6Sjc=;
 b=kBWyk+8BIYKbljMyf+5pUYtw9+YCynofIhqextfriE6skENrPfjwtF0m27YpNLE53Hl5iecMJ0EtGXiER402x7XMC7X2BBZVePdp5uNJQNoo/Mn7Mwiiq2ZPQBIoE3ez399KzWhOYu4Nh7DSV7l31VletPQW+W59Zc+KDELRZl6DMsBLuNe70ge4mu8bb8kuZwbk3mmSJsNZbNA5Pmzh7GTKe/JB3qIdWuyDsqqfehvkN0aUQBJ+mN8Kv1G2tZ9XSDUOdVEDzajKwWUnckiTvfC49/8+WWUpK4ThH2tRcVQUjAiU8RZqQe/g0Yo/TAz51VgPkg28v2Lh9tXwfgedow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kvack.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boyzg3ulGMaTj4eIyYG94pZEm4BUpZ2kxBq+r7J6Sjc=;
 b=caFvwT5h929jRKj1cpw67RlEYeUXNi3REfP66YZiAB1um7LiOTq5RwHK4BRo4w5c/r7r1mG/BR1hV9jpcg5WDzguKCVktkHyQF+Fqp7wAFocQN5SDJgN7E2Q412JDMoTNlQd1GCwA8InTqjStlvvqwQotATODoHrCOLktyy2mNo=
Received: from BL0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:91::38)
 by CH2PR02MB6663.namprd02.prod.outlook.com (2603:10b6:610:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 07:31:52 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::6b) by BL0PR05CA0028.outlook.office365.com
 (2603:10b6:208:91::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Thu, 27 Feb 2020 07:31:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Thu, 27 Feb 2020 07:31:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j7DeA-0005FI-Qe; Wed, 26 Feb 2020 23:31:50 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j7De5-0000m0-NQ; Wed, 26 Feb 2020 23:31:45 -0800
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j7Ddx-0000kP-1c; Wed, 26 Feb 2020 23:31:37 -0800
Subject: Re: [PATCH 00/10] Hi,
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
 <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
 <0f8140c1-da6f-ef04-0809-252d6de6a5d7@xilinx.com>
 <CAL_JsqLf2e3z+m14264WFcsQgiwKR35Rs9Rw0c_MgoFvKwO2Xg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5dfa98df-8955-59fd-1d65-c0a988190acb@xilinx.com>
Date:   Thu, 27 Feb 2020 08:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLf2e3z+m14264WFcsQgiwKR35Rs9Rw0c_MgoFvKwO2Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(136003)(396003)(189003)(199004)(31696002)(26005)(186003)(2906002)(36756003)(356004)(54906003)(478600001)(31686004)(6666004)(53546011)(70586007)(70206006)(7416002)(8676002)(44832011)(336012)(81166006)(81156014)(9786002)(110136005)(107886003)(426003)(8936002)(4326008)(5660300002)(316002)(2616005)(106390200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6663;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d522991-1843-4460-55ba-08d7bb571cdb
X-MS-TrafficTypeDiagnostic: CH2PR02MB6663:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB66635A0EAE40D44ECFFF5444C6EB0@CH2PR02MB6663.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfFS4NOVHqoJB9QxLTXkbjeflvUdISgd7pir/gudeGpUA9ZEMdSpelZ61xRbu6CBiL1KZdHQCJKRVhlmnvwYRYEDQDAPK94bFVwrxDhOgnfUmsLxzkJwVFffiC3YoMtnfSM82OLLfonQSfgE5QOairDmXQLf498p91YokjwA0/zpWan0zill4Sv4j9H38BR5Yh+y19sFhJ8L9wFimos65k8y8Hig5uAJTS1F+cFRl0oX6LalKPggG1sfo9WPXDJ0WTX71kvFS8BpAWK1Kl84UAFpuf7+fkpjY0+IpZ918+QDqecoPOO1GBbdohX/axh7dQH4IzuTSRW2L+ZPwM1SeZ6JDw0ptn/6pTBwHi+4Imgq+eZNRcSYIn6KaJEeGDFaq0d8Y0hCxA9I2s54H86r2Qwmx5/wW9gwzkppXOO2MwfgK2AM5z5Qv1LQqBKh9acrbnYRy7cE3XiWl5koTCiQHE7Ibh10EyN+zHgcthDw+f10uvNYI7sekj/hRLkQn4Ei
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 07:31:51.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d522991-1843-4460-55ba-08d7bb571cdb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6663
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25. 02. 20 17:32, Rob Herring wrote:
> On Mon, Feb 17, 2020 at 8:28 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Hi Rob,
>>
>> On 14. 02. 20 0:47, Rob Herring wrote:
>>> On Wed, Feb 12, 2020 at 2:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>
>>>>
>>>> I am sending this series as before SMP support.
>>>> Most of these patches are clean ups and should be easy to review them. I
>>>> expect there will be more discussions about SMP support.
>>>
>>> While not really related to adding SMP, any chance you or someone
>>> could look at moving microblaze PCI support to drivers/pci/? I suspect
>>> much of the code should drop out as we have common helpers for much of
>>> it now. That would leave only powerpc and mips for DT+PCI platforms.
>>
>> can you please suggest changes which could be done?
>> I have CC Bharat and he could look at it.
> 
> Look at the host controller drivers in drivers/pci/controller/.
> pci-host-{generic,common}.c is a good template to start with as that's
> a controller with standard config space accesses and no h/w setup
> needed. Essentially you need to call devm_pci_alloc_host_bridge(),
> pci_parse_request_of_pci_ranges() and pci_host_probe() with whatever
> h/w setup you need in between those calls.
> 
> Looking at the microblaze PCI code, looks like you may need custom
> config space accessors which is quite common. Probably all the
> resource and device scanning can be removed. If you look at arm64, all
> the arch PCI code is just for ACPI.

Thanks Rob.

Bharat: Can you please take a look?

Thanks,
Michal

