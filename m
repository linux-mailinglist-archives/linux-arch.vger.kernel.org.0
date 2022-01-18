Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73914924AB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiARLWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 06:22:37 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:28905
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231157AbiARLWg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jan 2022 06:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsAFBbyBmHrA9wOmNH9ETk9jPTKgu3F0jZNjmvTyvY4=;
 b=O/AMKj8F9+Ws/ffwpCo9zCPpPUKJ1mAStou6GN9GGYEksNYHz18VCx4lR+Jn9ovPBGLx1yQgQnLvD9xp6gQ3Tw6qt3mxDRn7flLQtrIS34Ki1Pvzo6H1qHtSn8VEfKL0C7NKBnbIKO+X/6ZhOLIWQoalGzXVqoH3Mzi1cHI0fD8=
Received: from DB8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:10:110::36)
 by PA4PR08MB7483.eurprd08.prod.outlook.com (2603:10a6:102:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 11:22:33 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::4a) by DB8PR04CA0026.outlook.office365.com
 (2603:10a6:10:110::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Tue, 18 Jan 2022 11:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 11:22:33 +0000
Received: ("Tessian outbound 157533e214a9:v110"); Tue, 18 Jan 2022 11:22:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 116755341e9f4bf4
X-CR-MTA-TID: 64aa7808
Received: from 5ece61481cf6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6611B249-EB5A-4C55-81B0-706B08F66483.1;
        Tue, 18 Jan 2022 11:22:23 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5ece61481cf6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 18 Jan 2022 11:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utv0fzj47XccJISZNCjiVVoNEQe1Kg9CYZSxirtc7VmclCtEmjjfa7B7SDmRBZKNVr5gxIY180LqsRl0PtGmY9BbRHNwqzS5ml34iYgDxM1Ydv2UGaLqVQs7cwjdcWMGJajnk6pVbuDO20AOxCWYSqRcjplPmuoUfS1zONY4InbK45mx51Y2SBu19KXmq9TWpUkw/uSfFjq2ca1rpinT+8UsBUvda2eQIgt9c8XaN0OO1cIXsOQ8trfaIAcSqTj7MWw8eCrzarTrGeDEztQiV0XF4HI877W4r/l8lgitLrjCw1nBiv5DYeU6g+fxBJrRtJ+8M4tK1bq9sYBnvpFIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsAFBbyBmHrA9wOmNH9ETk9jPTKgu3F0jZNjmvTyvY4=;
 b=XrioNI/EP+yYM5UUxnMpJBrSR+ldgGJgYY+kaKGY1VbxT1Y3uzspqlA/KHthIBi9fLE4Rm91eXSguB++B7+KUPdPBT3O9kwECnkhumz6lrq9iL5h4WbsKH//eR8xMz42ZV7qpfnZdvYjKP3ntXA1aqRvsAoaXLMYg31gcCZJB2K83MsubRSMuMAxbBNIEqCAWZqysd1YV8GWPO8mxNkJvUFCmACwOb4BB3sVuTxnytTuVCGo11ijtofq53HAqKNa9J0NFVWXIONmKmGr3bpTwcNxOGRJpVAfBi1iOFXi0/14GY8rIALFrLX3ZRtNlrXuLSLYvclOX3W8LXpGa9mWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsAFBbyBmHrA9wOmNH9ETk9jPTKgu3F0jZNjmvTyvY4=;
 b=O/AMKj8F9+Ws/ffwpCo9zCPpPUKJ1mAStou6GN9GGYEksNYHz18VCx4lR+Jn9ovPBGLx1yQgQnLvD9xp6gQ3Tw6qt3mxDRn7flLQtrIS34Ki1Pvzo6H1qHtSn8VEfKL0C7NKBnbIKO+X/6ZhOLIWQoalGzXVqoH3Mzi1cHI0fD8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VI1PR08MB4527.eurprd08.prod.outlook.com (2603:10a6:803:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 11:22:21 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 11:22:21 +0000
Date:   Tue, 18 Jan 2022 11:22:11 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220118112211.GD3294453@arm.com>
References: <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com>
 <20ae043b-a013-068d-2d83-16e63f5b4989@linaro.org>
 <CAMe9rOo5zWO1BwZGhqGdWuCjsq86YUo4ptqXkFVNSwXbU+ZS-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOo5zWO1BwZGhqGdWuCjsq86YUo4ptqXkFVNSwXbU+ZS-Q@mail.gmail.com>
X-ClientProxiedBy: SN7P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::31) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d564eb4-630f-4bc3-20eb-08d9da74d2a6
X-MS-TrafficTypeDiagnostic: VI1PR08MB4527:EE_|DB5EUR03FT041:EE_|PA4PR08MB7483:EE_
X-Microsoft-Antispam-PRVS: <PA4PR08MB7483CA7CAC578F544782F412ED589@PA4PR08MB7483.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QEW/U1Wd0LSxnOY7YNp70uNuRCKVlNoBb/VT+ZklMKhAF/Uy/qf6hpqYBBGIHStAfW2O8/GQGHIxhKghGUeBmzgSUgTNA3RBJl3gmiE1By3qPQFBt7c542BXO5NzeKIdHo5ztNm8Zw6cQJus4MJSwj00tyB5yqxtr3SKSf870STIIsKOINgWZjxgfCg8KAVVPz9D/Khscyptj8/iPl48tWK445WSZ4sHdpNAapMwUbXr4yyqKbvtI2J1m8G5CUyD7inSShsI9JBefllgLVW4XGMQMog1UicT+x6VILDZT6F65X2nIFfbEZptQGY5klw3tbBdbo7FQNo+mmWvIgs1j4Cg06XMuWCNZF6/o0NcqqzytzIkoOoUDI6+l9nhPVLY4C9BiXp507yXGNdH19JBXLOfOltGirb33XtvYhMpYRR/hmE+2MKPGArFivUIY5zJJWZYG+PLUoYVMeMWZzOAi0JjSyIt+l8UMZG8xVWXP8CI9wu2hDRCs4IRVq8ovG3pdvKGsK8Fk7/NsGBomt8Pwku48bNjBrKd8FiVy7bB5+vJ0ZfqIccYcr+Bz/Q2tfuO9J5dy45pqm7xIeUXH7JR9P3+2aqt2F8nJSKF1NsPNwnr5HCl4mq0vOWxrqvIJcTwzr9MfwyQK7zGoqWYXVIOIRHdqc91B3bolwrGAtdUmTliyOh4BV8q/7l/DVc7Tqc/2/F87MAM4xJ5CnWc57gbACIOhD1ys0adtEpB+o0Lrn4qmo9sWR+qNCDFz1C0IKOzbzFZOeqiWfWkTDcskAGA6d37sFNk1WgQqOEKMNgeUPTW6Ce3v8nCgi77xMI1jiyKKdgaVwFzFznNLGCVYdH2rQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(36756003)(6506007)(6916009)(86362001)(966005)(52116002)(6666004)(2906002)(186003)(4326008)(508600001)(54906003)(33656002)(26005)(8676002)(38350700002)(1076003)(6486002)(5660300002)(66946007)(83380400001)(66556008)(44832011)(8936002)(66476007)(38100700002)(4744005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4527
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1d7dd4a0-ad9c-4a86-c284-08d9da74caf9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19Q7ONB/7DBqw2b1s/YN2XqOWykO5dOp4qkLwTZHPzxBn4YfWxJfC1HwMvR7v7wU+nYCfS17L7nFrrs3kC+Bi/FoAiUzjGJm99itIcPGWbEMd46H1R4X6iwb/7jheHs3gycF9GFV22czl6Lc76zIHWkUVWWE2Nqcr13ddsjgAL/7WiiK75LwTNBYt776zKdM62FLB4U5trEz92gCc70L1O26f71G/Sriem/dSMsaPCEiVwPT21DqCrJA9HIDMJ9pWrHNJ9YTUOETRGihQVHEsGzPAVohbtMnSmWVTLignCk2FE3zGnW2kfidUIlnYB6EgXwY0VFbGXbkQH42+1jeDiHm0DD4VicUIeffF0PDwkn9By3JHznb7ywU0vk6UT0TdqQeyoU5JsTqW6Q9r+b7owhdNs4z9WZYWBMdMAUVzTUyrJmp1Gw+70PZmxuXR5PlNPzHoOm+sIoRiXYceZLKS1Bh1dS9U/MmGPgg9cTT0wYeUDyTbvvlAs+OFACaS3NHUp22OxzPrAnMxgz4sttQO2Bs6H9snIF8/0hqd3cgSqt/0rZ4Yav9DJZMTg7xfVXKAop3ZDl3nk0a6H5yMgADV/5lY6kJSmeyc8idvpEGVhzVmtRerw0/EwMod6BO/nRlCX063quHU7eNxm+laEdOj1frZzoHZEDReuQ87joUM5vOVF03b86WAihMSA7/J/wEMd19ux5kv9f3hkW2quzj1WW1Au0JO7AxWEn8QHLbBzpacpnPgDQr3VHeMrUZwrqNNa7p9ggolpSQOMZiUmXYMw9+I3P3L9XqoUGVMTfxQwQOCKekjcRROijZQZjVEBf4h20pStncagEiZFnGhaeiOg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(2616005)(36756003)(316002)(6666004)(36860700001)(4326008)(966005)(336012)(82310400004)(356005)(81166007)(47076005)(44832011)(508600001)(6486002)(8936002)(33656002)(6862004)(83380400001)(2906002)(107886003)(86362001)(8676002)(6506007)(26005)(5660300002)(6512007)(186003)(70586007)(70206006)(4744005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 11:22:33.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d564eb4-630f-4bc3-20eb-08d9da74d2a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7483
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 01/17/2022 11:01, H.J. Lu via Libc-alpha wrote:
> We are taking a different approach for CET enabling.   CET will be
> changed to be enabled from user space:
> 
> https://gitlab.com/x86-glibc/glibc/-/tree/users/hjl/cet/enable
> 
> and the CET kernel no longer enables CET automatically:
> 
> https://github.com/hjl-tools/linux/tree/hjl/cet%2F5.16.0-v4

we considered userspace handling of BTI in static exe
and ld.so too. at the time we wanted the protection to
be on whenever BTI marked code is executed, so it has
to be enabled at program entry.

i no longer think that the entry code protection is very
important, but delaying mprotect for static exe does
not fix our mprotect(*|PROT_EXEC) problem with systemd.

i also don't immediately see where you deal with shadow
stack allocation for the main stack if it is userspace
enabled, i expected that to require kernel assistance
if you want the main stack protected all the way up.
