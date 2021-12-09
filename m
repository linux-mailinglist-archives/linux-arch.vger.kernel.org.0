Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C948E46E750
	for <lists+linux-arch@lfdr.de>; Thu,  9 Dec 2021 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhLILOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Dec 2021 06:14:52 -0500
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:55790
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235323AbhLILOw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Dec 2021 06:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbqrvd3J42TVhk9cK9IeaJNcX9Lw486UhJgw6CxsNXQ=;
 b=KBiAWuLJ8wSiFLkYZ465RwzB7iNKM23c7K8N/SuDi5e40O1mtSZKKaUigl/3T0gHY5+eoZV9SA6Sgwa4YFNR8K9SZmarAQ211g8Iwczhd3y6p4OUKDytssvx80JZ5htUGprwZ4l5WFHE31zHEZ67CfWpkr5aOpGBD/Y1zfskkc8=
Received: from DB6PR07CA0101.eurprd07.prod.outlook.com (2603:10a6:6:2c::15) by
 DB9PR08MB7100.eurprd08.prod.outlook.com (2603:10a6:10:2c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 9 Dec 2021 11:11:16 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::37) by DB6PR07CA0101.outlook.office365.com
 (2603:10a6:6:2c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Thu, 9 Dec 2021 11:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 11:11:16 +0000
Received: ("Tessian outbound de6049708a0a:v110"); Thu, 09 Dec 2021 11:11:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8cd3fc06b39a2262
X-CR-MTA-TID: 64aa7808
Received: from 6e21fa10d25c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D23EE72F-75C1-42A6-826D-4ABEC510EB71.1;
        Thu, 09 Dec 2021 11:10:55 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6e21fa10d25c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Dec 2021 11:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuQvH6b1tv7ZnIa2eUbVgWd2BUzmP2wVitmOL56E2Ui1anKulHf9XX2reQiiKs6848TgoDE+993AGhHAWIz+jP9yqRwVj6farR9wHxr0WRSwF1Oza4R9wf+3WtD7EzH2orLiavlJkdXXqX3qryq4d4/IBDb/tA+I5GAeyASWm0YOTQoBXI7XSWAi1fniJGz0irhnAtACY5WzPkstBLBnojosPMPLxy6k97kLoavx1PgOQ/xXlrgmnLD6RKNwmDLdgK/wNN4pjKzDmzX9iasogzbIVSJ1yKeFY9KyC6goxwSIxUHC3ERFtgi3O4CIhVS2rIwdJhynF2knfrZguholSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbqrvd3J42TVhk9cK9IeaJNcX9Lw486UhJgw6CxsNXQ=;
 b=Y+HMEwlyxYeddcZYj4S2uBjJZwRgDMA1+EALe1Del4pSrhFP7ayPe+qfOfncU9q5l/c2gL0NAmAY7nZS2DkFnpvY74v5Jyjf/KePQ8Z2jDqnIvtkkNwpPe0cSglFkCBphZkvuy/4i5fu7n8f4C8ILG5N+F859r/44c749zrPfGtko6zRrwumKQmLjgSMMtaw2arXMkmzUgnFLSDWo4OSnaY/U3QlXzAL9PNfUS9fAgXA/jzpC8As4NSl2wfaHCT8DGFBWv9szswhnWYU2d+cwfvugwqsa47PvzAZWQbJWrHi53jRBP1W5Wc/YNZDRbV22Ri3g48HPXBOr6FcDdWosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbqrvd3J42TVhk9cK9IeaJNcX9Lw486UhJgw6CxsNXQ=;
 b=KBiAWuLJ8wSiFLkYZ465RwzB7iNKM23c7K8N/SuDi5e40O1mtSZKKaUigl/3T0gHY5+eoZV9SA6Sgwa4YFNR8K9SZmarAQ211g8Iwczhd3y6p4OUKDytssvx80JZ5htUGprwZ4l5WFHE31zHEZ67CfWpkr5aOpGBD/Y1zfskkc8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB7312.eurprd08.prod.outlook.com (2603:10a6:10:2e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 11:10:51 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::25f9:a7e6:422a:da43%6]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 11:10:51 +0000
Date:   Thu, 9 Dec 2021 11:10:48 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20211209111048.GM3294453@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbD4LKiaxG2R0XxN@arm.com>
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.49) by LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Thu, 9 Dec 2021 11:10:50 +0000
X-MS-Office365-Filtering-Correlation-Id: fce7256c-b16a-4071-4e76-08d9bb049e9a
X-MS-TrafficTypeDiagnostic: DU2PR08MB7312:EE_|DB5EUR03FT034:EE_|DB9PR08MB7100:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB71009B9178101E1E54421855ED709@DB9PR08MB7100.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZgaWEUeTbQkqLjH3mzSTr5iQP1OLGEaTHiXNQwRxLQx6fvCJqx81+iOUDqP8jWoEzjXT6j9b36RBGyfxp2f7bCWsYDyccINqEVhqkzUi6D1DdWQnIRiwaHj/KnNSWwmeZlsdIxTta+F8ME88syrpA2MXKnhPsWYLND/gI4/fg3EiEErdlw3MlgthaIApSL5YfB5i1Zxsx/W2JuGILrtiTUYgIKxaoqj5Sb8FzvT8/Y8514Hdvrf6zNL3KYpz9Wv4oYji9AHs2KHTC/FGaOcTccds02WhbFu1+moN663SEZalY8lp6azklYfMgBkKS7MK3oTDxISQmTx9uiOoiqpW4SWJuzZUxv8Lmej2lMGRAdkSaGyqnpMKvY5MLREotl2GnbjyyedojZL9V3Gs1gC8U9obMr4w3vp00M2acZdQXOJxNRpOTPFeXmzr0f++t8iSwVtCLc59p6uLc4ZV7ZomNIt2BNZSAA2sVHGfG7+WS+cHKPZxkp4HCaIgkVmGpGB239/Ny2cvkb1iq7WBd6nYrwOzYqfjhMm0OpgaWAPSn4vOnefGIbBAiDp0GL37VLclkWXk/XBNGl5Sr4KCYlbtmLHL4PWnz0iBZNfzU4FbcGvH8pNStKB7N49CkmGi1e7ItbR7YwkvEXTUcoptPmG/nGhUnmvrMwjn593FLGLaLLnYgeQQhZMEojdjCRKI2Odcy8wfokZvSEz+mw/+cQUXRg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(1076003)(66946007)(6862004)(4326008)(52116002)(7696005)(38100700002)(38350700002)(83380400001)(66476007)(66556008)(26005)(33656002)(8886007)(2906002)(508600001)(37006003)(44832011)(6636002)(55016003)(36756003)(316002)(86362001)(54906003)(8936002)(2616005)(956004)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7312
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e36cff7-1f05-4577-7116-08d9bb048f58
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYxjMSjPNomhV/5YCyKNPupeNBM1SWblASgM8j16fktSUKkZOLaWsD0wmZT55FLi1kka+Orv2eaHKdGNnRpP3yk8YH2+qVQ2Lv6pooE86gsUzakO9V1CK9vzUHEniXLapgxT+dDH6bgbhue+7ApC166kGTiNzBWB+5ErBMdwXpZzyyHNymETT9D2sQ4eVHqd9xJO2VPK7wVYZnwOpVAHwdV+EivZwx4vI1fYMiLlOeDBoFGG889rZCKyXt9cODP2+zFyXFOqhQTlW6LGgpx1aZsuC/84YlAys//ef50tHT3y7iu2QS93VQ/Av+Djbv4yp2cXHm+ZJ9FbE9IurxShiK3aSqPj9mlf+WT2UdiLupKfHYszYF1FQPy090sRkJs+uq0heF8TUCQLcEpiEHvCG69wKkjDMdOuGbeeaEZN7PSyLlH7KCKO5QXyE0azrVK0Ora4ceIQj1uWrDEkm4cBULvvPfediPqmSwr6To5WDOK4osIcsR02azg23Ew3qqpjWTgbh/ohuYAkIUDMkdfQEFtmg+L6UsiazVJpfR6n9wUh6LsTdbWSdOSQt/95fnuBZlL0V8vxjjeZQ9DO9sBCe/XYqZfL5V2yb4SeQr3KFF7MwLIsLgjT7+yvwSkeuZHCHglE9Jd4xHJhYCqf8PtorwkPxHgRYAJZwQdlbCE3VH+yYxX1miB6/UshEXFQzsZxmsj7/9weB7zQ5KvWxfeatfuHtwgJN5w1vsCglskfEM9qCkrDUfEY0l+uxY4UwTtMwAq1gPL9UrrOswHFyipPtQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(1076003)(36860700001)(81166007)(37006003)(316002)(6636002)(82310400004)(8886007)(47076005)(356005)(508600001)(336012)(54906003)(8936002)(33656002)(186003)(8676002)(956004)(6862004)(4326008)(7696005)(44832011)(55016003)(2906002)(36756003)(2616005)(86362001)(26005)(83380400001)(70586007)(5660300002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:11:16.4655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce7256c-b16a-4071-4e76-08d9bb049e9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7100
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 12/08/2021 18:23, Catalin Marinas wrote:
> On Mon, Nov 15, 2021 at 03:27:10PM +0000, Mark Brown wrote:
> > Deployments of BTI on arm64 have run into issues interacting with
> > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > linked executables the kernel will only handle architecture specific
> > properties like BTI for the interpreter, the expectation is that the
> > interpreter will then handle any properties on the main executable.
> > For BTI this means remapping the executable segments PROT_EXEC |
> > PROT_BTI.
> > 
> > This interacts poorly with MemoryDenyWriteExecute since that is
> > implemented using a seccomp filter which prevents setting PROT_EXEC on
> > already mapped memory and lacks the context to be able to detect that
> > memory is already mapped with PROT_EXEC.  This series resolves this by
> > handling the BTI property for both the interpreter and the main
> > executable.
> > 
> > This does mean that we may get more code with BTI enabled if running on
> > a system without BTI support in the dynamic linker, this is expected to
> > be a safe configuration and testing seems to confirm that. It also
> > reduces the flexibility userspace has to disable BTI but it is expected
> > that for cases where there are problems which require BTI to be disabled
> > it is more likely that it will need to be disabled on a system level.
> 
> Given the silence on this series over the past months, I propose we drop
> it. It's a bit unfortunate that systemd's MemoryDenyWriteExecute cannot
> work with BTI but I also think the former is a pretty blunt hardening
> mechanism (rejecting any mprotect(PROT_EXEC) regardless of the previous
> attributes).
> 
> I'm not a security expert to assess whether MDWX is more important than
> BTI (hardware availability also influences the distros decision). My
> suggestion would be to look at a better way to support the MDWX on the
> long run that does not interfere with BTI.

i still think it would be better if the kernel dealt with
PROT_BTI for the exe loaded by the kernel.

things work without this series as glibc will continue to
apply mprotect and ignore the failure, but with the series
security is tighter (neither mdwx nor bti are compromised).

for unrelated reasons bti is not widely deployed currently
so i guess there is no urgent interest in this.
