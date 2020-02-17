Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2A1614A4
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 15:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBQO2L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 09:28:11 -0500
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:56010
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbgBQO2K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 09:28:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0dv5FZw/NPWnB79ygxlzNr71zWsOmt+3FkrpwPhPFCFfuXpD4qnWhKtSsZ/s0iJp/b6OxOgIjzILYT1VqrSw6gVH8BOUt4KBtVtKSqLfMSo0sJMLkwoScIxYYOjxY5omdknN+kB4Pj2oGycYjHKeYJEGP6vFQnzxilcf7ssMoej6hUn4EThU/VW19rwrK/PCJNgMJfv46teGoQHOjXPpfsm2Fs1dbZGF3RVTaldi5RH62+xtJjUNuDkCvIy//B0Z9gX6bQTg7ND3g8C/lruWMvCmmcqLE7SH0TotT+w/XaFgkg5M0uE+G5lgNmgEKI7JfnVOTgrfz9ClH8R++x1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hew4OW53CmcLQprG2bW9SimYvauhC8sgz4XUBqusP34=;
 b=bs8INouAIeYJZqJtHWhN8d+NW8rv4bX5lz4widHJCHdWfIcFvXlEI5nPlLkGK+EW0fX6Ko0lueWorfpkj34BpeVWNXriiJDlzIVXm3mJU53ypElOEnKjSnJIdGRRKQFGsKwOfyj2MskKVl47iaIGkABtmzug/Y8if64QEHiTC5BiFXSXVF4mrhP9nLLnWBM0CIGSCIQGgRU/wvmkp25n56dKPClb/Vhd4ev/dd0m/H5HDwA4cKvucpTVnaFtI4gwhyfH+ik6INZo1uuFLZW9Mz0zC3gW4xBsVaf3IQyIvxKY9h43fx9vlhQp7mU9yyzf1gBwp/+hRsKaloF6U88ysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hew4OW53CmcLQprG2bW9SimYvauhC8sgz4XUBqusP34=;
 b=DwpIr0otddNydFxB88p9vKM7cQTEgSHpIbUBXOdeYmn7woKqU1qZyvvpodtpPTOcjuI/H6HVc7pBl7UrRjKQnxDY620eEN+OvMVs7Amamvw+NsW5ZSDhgfgGS6kIhHyPkOhtmOYnun8eC7M5ToFr1IIDKEeQOwV7xuUwePNjSHE=
Received: from BL0PR02CA0067.namprd02.prod.outlook.com (2603:10b6:207:3d::44)
 by CH2PR02MB6086.namprd02.prod.outlook.com (2603:10b6:610:a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Mon, 17 Feb
 2020 14:28:02 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0067.outlook.office365.com
 (2603:10b6:207:3d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend
 Transport; Mon, 17 Feb 2020 14:28:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Mon, 17 Feb 2020 14:28:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j3hNR-0000su-2u; Mon, 17 Feb 2020 06:28:01 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j3hNL-0001fJ-Vo; Mon, 17 Feb 2020 06:27:56 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01HERn1A030667;
        Mon, 17 Feb 2020 06:27:49 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j3hNF-0001ei-Eu; Mon, 17 Feb 2020 06:27:49 -0800
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
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0f8140c1-da6f-ef04-0809-252d6de6a5d7@xilinx.com>
Date:   Mon, 17 Feb 2020 15:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(316002)(336012)(6666004)(478600001)(70586007)(356004)(70206006)(4744005)(4326008)(5660300002)(9786002)(36756003)(7416002)(31696002)(26005)(2616005)(53546011)(81166006)(426003)(44832011)(8676002)(81156014)(54906003)(107886003)(186003)(2906002)(110136005)(8936002)(31686004)(106390200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6086;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf1217e-51ec-405d-a07d-08d7b3b597ff
X-MS-TrafficTypeDiagnostic: CH2PR02MB6086:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB60862E5DFD39EC617DE52CB3C6160@CH2PR02MB6086.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0316567485
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bTBQeOlAmvIWhnPS8PgAYmxoWutGAb+5B1dAH71ubHdhbADwWwlSKLJAKUzwn+w+s8yQL/Mg9u2CBBgi0O/TOp97hfHu7RhYsSo6u1OKv59vn3sAvD+2PN64gdb7dwnyUqaX3pCPfgRO8xicHdXLiKRfTIVjDwcQSnoIdJB2v1xmGqCf5V0WUaPbbpyMk8YOdobJfT+VDLeSLItyunzkc2tx8agHYn3JuVau+Sp3Y69mK4aMcCytCd9GdzE7XcrujiEu8beY0MAg9RsFx+fkGo/jC0Q0aS6RreqRWlWdXuKoTJNd0ANZ4/wutdL7smadgKZdzvzRy9X2hvcLG9OdWgyK9Alg22aFUop7uDsN88S7rX7uUPL7llFWytI8l8JwSVf9EVtcPmD7l73wmlJaeC8idUFT4BH9/vcRW8kwPMpnnWGvGhP+EKWb1DC7n0d3bmWmKGfv5iUpafgISVsD3MlbPdKPPZ5WzNpe3QJS3qhy+d4ts8guZ1dgJT4Js/B
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 14:28:01.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf1217e-51ec-405d-a07d-08d7b3b597ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6086
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rob,

On 14. 02. 20 0:47, Rob Herring wrote:
> On Wed, Feb 12, 2020 at 2:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>
>> I am sending this series as before SMP support.
>> Most of these patches are clean ups and should be easy to review them. I
>> expect there will be more discussions about SMP support.
> 
> While not really related to adding SMP, any chance you or someone
> could look at moving microblaze PCI support to drivers/pci/? I suspect
> much of the code should drop out as we have common helpers for much of
> it now. That would leave only powerpc and mips for DT+PCI platforms.

can you please suggest changes which could be done?
I have CC Bharat and he could look at it.

Thanks,
Michal


