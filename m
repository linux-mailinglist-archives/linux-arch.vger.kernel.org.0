Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39C1219C5A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 11:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIJdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 05:33:08 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:35201
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgGIJdH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 05:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZuNEs4SR8BOF2AfQjTi7D5xe5vMmy1IOajKxj8UMf4=;
 b=B9O4mp8mZtLzJfBseLB9Gkai+jN5Ka8tRIWycxFkHCf6kpujftXzlXwXttBnSgMjlrglgNHoOaFRSMyKTFl4+wNbIiaYYGvWTkl4PkQSrrEeBQuxyhDL7lPKdoul3Pzshc6pb2rRhzqI4q/IrVxr4mbMaSEk2G7ZObqlSZj5jrI=
Received: from AM6P195CA0059.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::36)
 by DBBPR08MB4476.eurprd08.prod.outlook.com (2603:10a6:10:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 09:33:04 +0000
Received: from VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::2e) by AM6P195CA0059.outlook.office365.com
 (2603:10a6:209:87::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Thu, 9 Jul 2020 09:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT026.mail.protection.outlook.com (10.152.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 09:33:03 +0000
Received: ("Tessian outbound 73b502bf693a:v62"); Thu, 09 Jul 2020 09:33:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f3b141a47acc2efa
X-CR-MTA-TID: 64aa7808
Received: from fec839b157fd.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33022F70-DDF7-46F1-9348-B7221E1BF7AD.1;
        Thu, 09 Jul 2020 09:32:57 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fec839b157fd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Jul 2020 09:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBvIVGhcnO4u9z/FVjaPsQpwO+ASNlNoPRnQESQRipaEe7Hlkg7CXKFKSIuNkP5VQmP8wASTqaLT8AkThJPGbt2bKX3yqKLdyz80M0RH1R4rMTfIvphKfg3KdZZeV7tGUCPrPclskgpjwYMo09ZkjX/VGeto/d5NIt3xT+IWtK7EPwiH/0EQSYrI+poQOsckzJtPrnDpl74/KacNE3vXln/GaRiMwk3usyu+1tf6lRUs0ndVJMTtaOEUH86/RjnX+kRjc82eMVugQShpKGozxAyKj8x2dJDnFyjfOtLZO3VW985OfQXp458TCqq8cRjm6qZ1e9zJoGBVo7l+PaCJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZuNEs4SR8BOF2AfQjTi7D5xe5vMmy1IOajKxj8UMf4=;
 b=W2fEmuPE1oxcUldG39UiYtba4EMaM+xSWL1vDWmDBKg+H+Zg2KJkcKmbT74x815pL7x/Qly38YQ9eTE1IjboL3Uc/RyMxSlq3Efybco3TI4wvldVYFbJF+j2PO5qulNOrtPFqpir6M5wLZGE010WrQ0+u+IuhJ9IY9B4sF+FztE8z/AN1xcMeOS1oPIVVd3neLqrEGImCiTmgV6DI+kseYUOCdJBlAEcdbLk8BiErY2RQsAQC1vh3IWID7PuLSom4s3qSmw2n/qGOlvtpFxbOdtCJLDMrwhwGt/ShznICD4r5IgSkXnlfWXtoUmgJ/n/xyeW8O0h2BWJFWI1VDPHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZuNEs4SR8BOF2AfQjTi7D5xe5vMmy1IOajKxj8UMf4=;
 b=B9O4mp8mZtLzJfBseLB9Gkai+jN5Ka8tRIWycxFkHCf6kpujftXzlXwXttBnSgMjlrglgNHoOaFRSMyKTFl4+wNbIiaYYGvWTkl4PkQSrrEeBQuxyhDL7lPKdoul3Pzshc6pb2rRhzqI4q/IrVxr4mbMaSEk2G7ZObqlSZj5jrI=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB2999.eurprd08.prod.outlook.com (2603:10a6:209:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 09:32:56 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 09:32:56 +0000
Date:   Thu, 9 Jul 2020 10:32:54 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org, nd@arm.com
Subject: Re: [PATCH v6 26/26] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200709093253.GI32219@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-27-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703153718.16973-27-catalin.marinas@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::36) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.53) by LO2P265CA0144.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 9 Jul 2020 09:32:55 +0000
X-Originating-IP: [217.140.106.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fca2b74-0045-4f93-590b-08d823eb143c
X-MS-TrafficTypeDiagnostic: AM6PR08MB2999:|DBBPR08MB4476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB4476F527B28A8861597D8EB3ED640@DBBPR08MB4476.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OtDWGd3dgtUDpqg2CnbGXVaZZ7POO3g8NNpQ2ZMVg7Gj2DuGkuVA79nvCwXW8Vo8rMkZkI7Qnt/O18sMqfIUP1heD7Qm91jP/zE6/X8Kj31jLquDgUsG35j9rqCe3whA6oDdCBAyGpDG+2F9hNgHf+80C41zpab/BTGtdfzIjbhlO/ADpOYyFDhQHGhSzay47gD4CbPyf1MyZtIHP5VBWMqBAE50Ofpp66EyUMWgv0icJOyCrrVPKIJzjmrOLoEXmpGoUCYPmcIxc9eEVNwDZ/9ui7ZOB0ceEDTVtC/Tw+IGzXtHjQ+SIB34hxwKevZFgbe2osxGb3L2dNfjr4AuDw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(33656002)(478600001)(16526019)(1076003)(2616005)(956004)(86362001)(4326008)(8676002)(7696005)(52116002)(4744005)(6862004)(5660300002)(66556008)(66946007)(66476007)(186003)(2906002)(8936002)(55016002)(54906003)(26005)(6636002)(316002)(36756003)(37006003)(8886007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wVNPBINZ9h0UZ8mEOqE64l+dgfLswWjtzGCi32mkJRDHcRjsh+/qF9JwvQ+aj75JVcYjn5V4BDE94kY7eAceKxy3dbvosAC+W92uayanyM3B7DwykMTR6nWDmOw8S6cDkcZ0sF8gHkwMXLeZH8FD28eobHEC5DGA2dS0eFZyCML/1K1gRBYkBFV8r5EFzJTl5RN8FwUwTP6tLG0T1hRqguM55ghtPTFNByUbOGlcCpigSWAOP9raqmfYYcN7YawjHNg3Q63rzUuQkP03/+dbJh+2UdOINVX33OCiFj8FASbvMh0qooZNJBcCNaWiiazrFy7VLyBJluDzZ0SiJ4Tug/Vn943i721B5WYX7OCCKytaUW2kJ2r5csuui9CkcMsDgrKuMqE1hu4VjBSHvElYBBYWM+Tqb91aHR7KYa4MKoK9GlD0g0LoULOqWM5n1pK6jwPb0NbodQJMPP02sM3+fC8+v/IkMnNOPZjMaz5l/CyH7eyrhHvQe4TfiLUqyY6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2999
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(4326008)(26005)(54906003)(37006003)(186003)(6636002)(8936002)(2906002)(5660300002)(16526019)(2616005)(36756003)(70586007)(8676002)(7696005)(70206006)(44832011)(33656002)(316002)(956004)(8886007)(36906005)(47076004)(356005)(81166007)(55016002)(1076003)(6862004)(336012)(82310400002)(86362001)(4744005)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89b787a3-8633-453f-de90-08d823eb0fc0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ifi/hnjpe1MIS0BA0/cobpbpPkkXRI6+6neYLipDM8V1k5tNFupjzdZp9fb3ReFdOP+lPjeBphIPilMmoma8bYq7XCQ+MZd7ydcCiCp+h1DT4rvfK/fKaLeg+57I+LjadmSdJ4HEFUo6F0w4aVcbgbBpk4HzK+tyPJ8bEkUQk2oed4uuUfsMAtJjb+nLnfNa9dCHYlRZrjp827xF7nIlx2AmmHu/AspcycEppYrdTdYIHXuyMMavU0zfdHYVVw/CIFls7mAuBWJEkd0CiIhXd9NFd4+RlbtxBKgdfdcFkqlbmmafE5N1DnvlAGtXN/J6Nm+b1x3My1LplPoRPPAG5/p7mI/nJ5fM/+bYrh0GCXKamPZ93SfCN/aOC5BSAlqGtilpxS01dG4xaJrAaQpJbg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:33:03.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca2b74-0045-4f93-590b-08d823eb143c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4476
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/03/2020 16:37, Catalin Marinas wrote:
> +    /*
> +     * To be compiled with -march=armv8.5-a+memtag
> +     */
> +    #include <errno.h>
> +    #include <stdio.h>
> +    #include <stdlib.h>
> +    #include <unistd.h>
> +    #include <sys/auxv.h>
> +    #include <sys/mman.h>
> +    #include <sys/prctl.h>

the example should now include stdint.h

> +    #define insert_random_tag(ptr) ({                       \
> +            uint64_t __val;                                 \
> +            asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
> +            __val;                                          \
> +    })
