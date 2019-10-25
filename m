Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BDE435D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 08:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbfJYGMt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Oct 2019 02:12:49 -0400
Received: from mail-eopbgr730074.outbound.protection.outlook.com ([40.107.73.74]:64441
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404448AbfJYGMt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Oct 2019 02:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8XI5yhtglCYuIfY2ASMll/7LVU2DLqp2T6mm8/7xZzdTqwDW4ilapWVwMlguRQV548GBZhl0DNQJa2TWIe3+TOBXDtqk+pX7qbsQz4YZ3NYNLlsiTUgxaezJXdQrpW70BGUp46N0bIdmKUivtIbikVdpsuiP20JW2R261k9hNPOmlNgkq8MnYqTpwb6VUWZ989an0vsIPdMt/M66CJMzsj84Vrh1cu1bH0GLHIlB9ZhabQGaqG22cEuLuBjjM6ltxQbnr3lnzJN+ikPY2MJAU2KRqX01jghYL+l9NiXnKGydt0aypyvqsy1D8YltuZxv4XxWEl9x/hnjBjWSmsx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JHotugWXnKMqHBEUS9ou6QEtsSKsW6nGO9hidSCr3A=;
 b=SLxL0EMDXK7+NP63AM2fPMqdY7odQh1GwstSGAeQ4glmTfuWzdfA6296rIbtyy1U9qNEWqBTqV3gB/d7LW9ZuXskhcRkLNEZOtXGlbjZf7AoEj+Qzh88solWu3egBpCPIDcTazbG79PZxnBcEyRlshYNBe2dq1uDLGTxSvMSg7MpMlKjMbFvsyay8/KZlVADlHqN768nrtFhMKOiooWjL+aGdh2OLn3SgUBeP4xhQ33sqZpWKZd5FCQweVsg1m/3NWKY19mhVfKVfn3iiq6dbqT7kqytuUUA3b4lIresfEJThnPhkHIxALaFQMEKx6MDn0X3KZEGAQ5GWSpJRf61/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JHotugWXnKMqHBEUS9ou6QEtsSKsW6nGO9hidSCr3A=;
 b=Prd8BMMTPVwOefZJIdRXho1DaN2BLzJrAy+Ymlg0+1QYsKXhFCSB12C0OvVb8muM+k6W0KtHTZD0fAZkA3jPqLDKq3GytdAYDzF1cihagRgc0vZZVwvYrkj2DTkWtp5GuEB0pTmhtMUdUGFJooXss9lI2B7AZikV/aZNYTdcDkM=
Received: from MWHPR02CA0013.namprd02.prod.outlook.com (2603:10b6:300:4b::23)
 by BYAPR02MB5672.namprd02.prod.outlook.com (2603:10b6:a03:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 25 Oct
 2019 06:12:32 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR02CA0013.outlook.office365.com
 (2603:10b6:300:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Fri, 25 Oct 2019 06:12:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 25 Oct 2019 06:12:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iNspr-00005K-BR; Thu, 24 Oct 2019 23:12:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iNspm-0000Fy-7j; Thu, 24 Oct 2019 23:12:26 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iNspj-0000EL-58; Thu, 24 Oct 2019 23:12:24 -0700
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm
 header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com, Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, longman@redhat.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <cover.1571911976.git.michal.simek@xilinx.com>
 <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
 <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <33e46e4b-cfe4-db2f-02e1-0164327bcecc@xilinx.com>
Date:   Fri, 25 Oct 2019 08:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(4636009)(136003)(376002)(39860400002)(346002)(396003)(52314003)(199004)(189003)(6246003)(446003)(50466002)(356004)(6666004)(230700001)(58126008)(110136005)(54906003)(478600001)(486006)(5660300002)(44832011)(36386004)(4744005)(316002)(31696002)(31686004)(2906002)(476003)(2616005)(9786002)(106002)(36756003)(126002)(426003)(11346002)(81166006)(81156014)(186003)(4326008)(8936002)(8676002)(65956001)(76176011)(70206006)(229853002)(53546011)(65806001)(47776003)(2486003)(23676004)(26005)(305945005)(7406005)(7416002)(70586007)(336012)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5672;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00540cd9-42e1-4b1d-5a59-08d759125257
X-MS-TrafficTypeDiagnostic: BYAPR02MB5672:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5672716AD1E11AAE5793BB2AC6650@BYAPR02MB5672.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02015246A9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W26rSgbnBt0jt4ftISPhNMiWkJNEIONYyGVbrWw4DHjVZe34lWBYM61YskDjnoJ8FQ82uirPKA31RYp+qrem0BhZRvTqSC2N/XXkAxlVMgnDz3A1H0uHSLZA0pj0T/WMRv2go6zs/aw/hRYpu8Od49/wjrJnv9gmifPlWfHwpiE5DrQPQzY+04RZ9ouE2omxHPppajmsd2TUD//wa+eQFQrp97xh7gyFoLLRyLnMBzoQYZmIDxvZSXUAjBqcl8R+og4HbTMRqtx5xDjt2AEpRtdN5Llnrb7TM02sYErliJAWR+NhfVhGYCjTl5ZQ6aqOH0gMpZo8LrKl6EGMYkBRnugvRLalhpTl+H5Mojm9FwXc9AuJmFIDlMfi7WdzbyOc5x+nk5uI7oTxvZKKgUs+Pr1O4UpEmgCeqNt/tyh5WO+9/g4clhteNuIl3AUWtCFw
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 06:12:31.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00540cd9-42e1-4b1d-5a59-08d759125257
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5672
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24. 10. 19 16:44, Masahiro Yamada wrote:
> On Thu, Oct 24, 2019 at 7:13 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> msi.h is generic for all architectures expect of x86 which has own version.
> 
> Maybe a typo?  "except"

unfortunately yes.

> 
> 
> Anyway, the code looks good to me.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I have sent v2.
Who should be taking these patches?

Thanks,
Michal
