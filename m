Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D74B9ABF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiBQIRi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 03:17:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiBQIRd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 03:17:33 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F941BAC70
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 00:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPJeavxnjytgeGuGvu8rj3WEI6aqFJr98u8loW+rzQM=;
 b=FYsip1VaKBEfSejx5OpXSebmZ6sIsY4/BBgyovlHNEp2xwgcEcP14XC0NCYK9JKWhkNVruvoRShNgRXDtCBJe+gPZL4xq2XV+1VdehvXS67MjXZlRTr0RtVtTBcVLleZdramSVCJZpwqeUYychPyMGBSd4bDhW4/Cqmy4ZrVSoY=
Received: from AM5PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:203:91::15) by DB7PR08MB3419.eurprd08.prod.outlook.com
 (2603:10a6:10:42::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 08:17:14 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::21) by AM5PR0502CA0005.outlook.office365.com
 (2603:10a6:203:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.20 via Frontend
 Transport; Thu, 17 Feb 2022 08:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 08:17:13 +0000
Received: ("Tessian outbound 18e50a6f0513:v113"); Thu, 17 Feb 2022 08:17:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ab5363d82ecee70
X-CR-MTA-TID: 64aa7808
Received: from 17901ca3ae3b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BFD48C18-54CC-478B-82C7-4C63F702B8F2.1;
        Thu, 17 Feb 2022 08:17:07 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 17901ca3ae3b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 17 Feb 2022 08:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgLX5hyxgCiANW0u83gnuPb+cLqsBN97OEdyz2cSf92sNOoujnOt57w4bKBx7Y7Oz4KQIvGINEr6U8h1xX5+cK+9RZ/PKHb3TXY2lTWSDWWQrvGC+U52Fi8Zh4xzxYl9hqX/PJ/BGfpkzr8Gi2PADvY2OSX+Esl1Dym+GC5RdTriWK4tYNWYIedpXUu+wPunfrxSC7qw8QoUA7DmBKRxqa2SMUn2X6ash36Fu/6sGZvjj6h/HKOWQmGYSMHjR5nvkHxHy9HaQTRYwvbNcvm6pt46e4qqW2PSLfr8cNQtGKP5zLeNARd0rrBheVI2llkaDwghXi+LBadjcHrAiV9Meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPJeavxnjytgeGuGvu8rj3WEI6aqFJr98u8loW+rzQM=;
 b=fb8O+8GgcKWY4Hgc3Mhz/u1+01dPWdYHnZrQ/bFJpizaFucODmfW/y8Rg7qiFNWiFt5u3dfVX4MnMTK/CMgKtKYsN8+VjzJxxGTHoYi5fTtxweksHC9Sl863IppE5WRRUcFKqXfizEWM67NVcwNRdtP0o9kL10gcHfLOPkBN8XQw70ktke8DyX8P1rzpBjQxwVfM0Cou/Fvoid2hrH6L+RPs2ydnXGz9vopmJDnTm0OXZz2ClI3KIQ3Oo6/yTISU0YKlcNBTEUrHR1VwPTPQCpnvUKOYTjMIRIowvYbh0ISBQu9Jqw8qq8QAD5vpUvDeDcZzTsrlcXaAiYfcqjax8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPJeavxnjytgeGuGvu8rj3WEI6aqFJr98u8loW+rzQM=;
 b=FYsip1VaKBEfSejx5OpXSebmZ6sIsY4/BBgyovlHNEp2xwgcEcP14XC0NCYK9JKWhkNVruvoRShNgRXDtCBJe+gPZL4xq2XV+1VdehvXS67MjXZlRTr0RtVtTBcVLleZdramSVCJZpwqeUYychPyMGBSd4bDhW4/Cqmy4ZrVSoY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB6PR0802MB2294.eurprd08.prod.outlook.com (2603:10a6:4:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 08:17:04 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63%7]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 08:17:04 +0000
Date:   Thu, 17 Feb 2022 08:17:02 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, libc-alpha@sourceware.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220217081702.GI2692478@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
 <20220216164954.GH2692478@arm.com>
 <Yg0t2srflG80zQKF@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg0t2srflG80zQKF@sirena.org.uk>
X-ClientProxiedBy: LO2P265CA0329.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::29) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c03007b8-a8cb-483d-d5c5-08d9f1ede714
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2294:EE_|VE1EUR03FT064:EE_|DB7PR08MB3419:EE_
X-Microsoft-Antispam-PRVS: <DB7PR08MB34192E722EE1E4D95F133544ED369@DB7PR08MB3419.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pe7JS3sNEIzP/e3i6Hr30pmTrwZfjM02yBNbOexpmb4UW0lZPxT2GKmzEP5qrPVa7ynUf/V/SwyJdXOuFmG4oCq2D6Xw1rRNnH9u6I4dN5rySi/2Kv5FU8go3SwR5KnWsrs3WvtmGzi2pOvLnWqWn07+VmwHWzhgUi2xfTKrQ8YF5WUlvy55C61EKr385MSYFQTH9LB9hd4ktWHi7Xb/4TVEjhgT28lnv1hJDk1BVEIZYMTjtbVi7a7rlR+Cf1jgeVBSmAZsbLHnilEWloMBCMAcanWt97WGKBKqQMAlWhiITwJuWCm0bKWVVhWlDyo+/JXjmJalsgIchT4meSPWunPA4EncImulcBRWHomkWf2cqlo/HzYQm0s5dDNETjjLXvxYZXI89p59JfV+2JAsyYjKIKBuC+HD1ogbH9GpnMD7a4ZJc+QvSCcxUm6cmP/BAyIO0jSDRMy/zrpOIC/+uBeEH4Zm95CeZsuFF1Unw0468KYiqd5CpOZiPCDiso81PKR5hkILBJZC1QNYG2l2KNsuC+6oKtoMtbpPyGbVKCU9sf7jEcV10NQ6rKZ89vnDwoP0A2swxMslA8WfiphIqaqJXBFwLjLFK997b2xGGhyms+Ad8R//M+0a9DcuVODm5xd8Ge7xvricrCV+U+LVKmYdjaD1+LmBcxH1Fu3X02p5C8BDygEia45NGHwGH1kzL7r3igDZ/rl9teStqZ853g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(54906003)(6916009)(44832011)(36756003)(6486002)(66476007)(8936002)(508600001)(33656002)(316002)(2906002)(66556008)(5660300002)(86362001)(66946007)(38100700002)(1076003)(4326008)(8676002)(4744005)(6506007)(2616005)(186003)(6512007)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2294
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cade716f-c1bc-494b-3f82-08d9f1ede13c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxZgxd3irbn+ZH3o32cCKJgHgCX/H7i9+ZMJbJD/0MPqVHkKnNpjfWAKg8Rq0HqFGe3TEtOCopuY+EDStsu3xGwndmow/pa6RlENADoZ7+9wPeMbFHqr0V5AU78M86o2N0uq6qG3aTF0v6OAE36Mcpqe+dQ4cANvWuI1hmWqFSm8oc1A1eiB2YlMdwJhUjSU70CMBq1Kx6r3mtInXHL+Q+dphlu+v0vV0Z6J69XHNrkWhCHFp/Z/ZPFOEil36GHShW4fjDjtCJlxucrLhTdvCQUbstfX7ZD7QwOPsLdcSfrLBZ2dtEskCFYVAaZPljFe8WV0Fr/x4IFCuKLZHPPX6LSMLLBjakDxI766S+1JxIcn4V+I/i8FI04Nh2LKsjwpWQmRXAHPkjmZmcv+vHqIk68MmUPMaPtcenOqPwUQLTuKUv0QgZgUPXvetMSvy82GGoMsvcdRK4toa5MWSwXjdp3wTmfeKMOS10o8hIX5Vw/vc31qoY5rGRd4os24hZOF+yRIH4y7n5eNkid3/yBtmnkzosmcw18KFlCEysCs1m/8EBQpZiyVclAgEUlqSPTaWsSrYfc0HoFGhz5qIFfDxIV/R683DpvtL+6EAWV1TiQklYDQi8POE55BvM7N5g4kNbbcBLTarnK73E2ACOVsMvPDsKlei5GsxIbl1cmAh8ZBpfrAb+cQnZxCqIpuARIA
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(8676002)(2906002)(44832011)(508600001)(6486002)(81166007)(356005)(316002)(4326008)(54906003)(5660300002)(6512007)(40460700003)(33656002)(6506007)(6862004)(86362001)(36860700001)(36756003)(4744005)(47076005)(8936002)(26005)(186003)(107886003)(336012)(1076003)(70206006)(70586007)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 08:17:13.4831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03007b8-a8cb-483d-d5c5-08d9f1ede714
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 02/16/2022 17:01, Mark Brown wrote:
> On Wed, Feb 16, 2022 at 04:49:54PM +0000, Szabolcs Nagy wrote:
> 
> > if we ever wanted to map bti marked binaries without PROT_BTI
> > and introduced a knob to do that in ld.so, then this change
> > would be problematic (we cannot easily remove PROT_BTI from
> > the exe), but we don't have such plans.
> 
> In general or only in the case where MWDE is enabled (in which case it's
> the same problem as exists today trying to enable BTI in the presence of
> MWDE)?

ah yes with mwde only.
