Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC957CE2A1
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRQW5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRQWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 12:22:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3C98;
        Wed, 18 Oct 2023 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgj16zS6PgE0Gfzy2ZVYrIaDELe67037s2rq4tznm7Y=;
 b=jVWTV1dgPmW8ShIlQsW1ISqg71I2IaJt0CZwji5LJhkxIcv1j5RSdghYwJUuxa7eQ6pzZZO4nNeXqh8cdX+8T60G2DRFhPZ5ypFHlW+uchRZjCcgLhJq4Use8c2sJLTNpShv4tUcw7ZX/9yCFX4FSM6S/yFi9jg83n25EHxXo5k=
Received: from DB7PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:10:36::35)
 by AS8PR08MB6392.eurprd08.prod.outlook.com (2603:10a6:20b:31a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 16:22:51 +0000
Received: from DBAEUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::86) by DB7PR05CA0022.outlook.office365.com
 (2603:10a6:10:36::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 16:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT061.mail.protection.outlook.com (100.127.143.28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 16:22:51 +0000
Received: ("Tessian outbound 9e011a9ddd13:v215"); Wed, 18 Oct 2023 16:22:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9bc9be87f8aee56f
X-CR-MTA-TID: 64aa7808
Received: from 6319eec14f4b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 16CA8F59-A1A4-4788-BB6B-1934F2EF7CD7.1;
        Wed, 18 Oct 2023 16:22:44 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6319eec14f4b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 18 Oct 2023 16:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/bumfYspw4GSjf+TokeekzRTgXTX0pJs8w4FkTa7TzYMA3azxTez5ci6MdLvIJW/5DniiGgWp+Quk3MdF5+jvlRzCy+9TORzPgybv+NR36If+GKHHRdyA38HoB26AHsK8oEiXNNqeYfU0gVpBotxUZKZen1/LF7kFQSHgk0P7yluU4SmxgO9jFHra0sf7Bw9Ik4Rmy3Md521GIdzPZwl6SDtOWpx+JD9XW7zevLis2mDcTGa1vVDKjRjVycIzmeLFAFKE6GgHBTIs1kirAGV+du91tK0icJEARDmyELHR1kQ7zIxKLRZcvmv4rlzyGCF0b6gki75Ma9nH/clC74ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgj16zS6PgE0Gfzy2ZVYrIaDELe67037s2rq4tznm7Y=;
 b=kiKuFCr+9docbTvI4txUNY6Q877bwEiXyOqiUpYn4MHUCvn1DJ7KvY8AYDj1kBanazp1qivrftom3nQXc9nUYmMxVzVWXVmbwN+M/QTRaO7uUW7R8iii2yO1mpqrnCim1WXndftIVSqjqZJDzmFcLasPvWddkJMx/90qSXQxUH3Sn/FctfgEeX/qEnt2ZaPnKpKAGEHMpba+rFXohvbRaFM3RUQdV1q8V7hFuX3DlK+VJIvHLqzsSdqxCNuhjjN50qo4uiXQMtZX6K04NTP2qbilHDU98MILcPGwGEzmYQGy13mmZknuklkUaFiE7eVMcWtrIY1+1a1JkfKovRpvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgj16zS6PgE0Gfzy2ZVYrIaDELe67037s2rq4tznm7Y=;
 b=jVWTV1dgPmW8ShIlQsW1ISqg71I2IaJt0CZwji5LJhkxIcv1j5RSdghYwJUuxa7eQ6pzZZO4nNeXqh8cdX+8T60G2DRFhPZ5ypFHlW+uchRZjCcgLhJq4Use8c2sJLTNpShv4tUcw7ZX/9yCFX4FSM6S/yFi9jg83n25EHxXo5k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PA6PR08MB10829.eurprd08.prod.outlook.com (2603:10a6:102:3d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Wed, 18 Oct
 2023 16:22:43 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 16:22:42 +0000
Date:   Wed, 18 Oct 2023 17:22:29 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Bergner <bergner@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [PING][PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux
 vector, entries
Message-ID: <ZTAGRY0Zn0KV/biE@arm.com>
References: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
 <4294d9ae-3f5e-4f81-b586-2c134d21896a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4294d9ae-3f5e-4f81-b586-2c134d21896a@linux.ibm.com>
X-ClientProxiedBy: LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::28) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|PA6PR08MB10829:EE_|DBAEUR03FT061:EE_|AS8PR08MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 81352d72-dec6-404a-c268-08dbcff679d5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1wG3soMbwbiPjvoXL19E8lJ+DuH7PSpk/5qhpukbI+bBLeHFPrtl072sjH9FZe3z1B03vf9zi+S6RJyWdk810MI7KXszzeqx3O5kElJYvb4JnaprgE3zd03eW3DEnHrkhOpg7vqOvDkVKb0shiw9yTcmI/nG1CszATch8TeTq4ZkqzYA7Dzn3Jr/0CNRWYRcXKSl1hcA2LAgl2LaaidZNUojK2hTUEH/CvuvDSRRLagDLgccCcE0iw1BatvN87ntIrNcHz0zLlK/kiYXSt3INTh7azjHeaqopKiyL6iqzWKf55xAc6U4eKEhmNkgVvza6Yp7JGU2Dn8X/iqIxPW0mnM0oMUOCxKcW/QBEJQXRyAJjD+FCkhS1+m3Td4vUHYB9xmO2MvMzKXDiA6No6stIK582/75zWHYbl9rGonxLMC8lklifowIlyC7MokJzsrdvy6lnlGomXNVZxp9y66cYEz9Q2LwNPBFCpm0V7xjo7ooYC79SZwoEqNKK30n7k8D1kAoK/QXGw7ma+VnxZPfTxEXz9gUYAsk7T7QNZHRSiiwXvh+xK/WaG0iyHn6gDRD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(6506007)(2616005)(26005)(6666004)(6486002)(478600001)(44832011)(38100700002)(8676002)(36756003)(5660300002)(316002)(41300700001)(86362001)(2906002)(8936002)(4326008)(110136005)(4744005)(66476007)(66946007)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10829
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9179579b-26c2-4ba1-771c-08dbcff67472
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh1dzEQkYmsYJuEDOPPI94cW96nYGHKFBJgrIGfdbfnSaMcyYu76QNs+uzeW6la0c3B7wae/+NcqdawcFMfn8IWg59D0bzDdO3L2jGN51aX2MHSZs2J1C7laGXHKCvLIJTf7lc/qRcGNbMqNZ6FXSEGa4lSX2x/EQrLE05+HyuEQP53rNSL83XhEEoI2ndCpgpPCocdyNiLkULlJvlfAh0AFlyAlfiSzkt3c6pozk/4pC8/ypXJHXinorxoPMYfjVPL6NxuTqWmTCgkW7dtyOB885GDLZT648vanp0scl9L7+R6nZync2mjpcQqGKa5LvjLoi5s2rDi6fSoUl0G4V1q5wRKzsC3CYA8Z7cKOU9vSO7xPbOPumLgCPuVYUFj0wO68A8RD8HbNkQFN/2o0KZGIsqvet6gyR2p/iqFvXWQcj4DV3NiC0z9xCHe93xAyr+370h5oYD8ZhW1PgX+sl/Lq+nen6WQiqj+npnMt5r1sfZWmLI+aPgOPCDiU/gGz/2dGPLSjPMm5lU6MCURtid7J45N0ps7qfmHzyWlKCNPj3UYhDGgauyKfRaFP8lqmHENSfo1KAFTceBR676yJoxR6S/AV/OVWv4JGHUPitISY6RhqV2T5+0re4HIh/gYL0HV0AS0bFKlGbCftD1hbCpkBhhKH+XmPbPkFf7v2OTyQQ3sWhQ6TeFl6+FDbeZt9G+A63lDk6hw4oNL9SvxxlkVnofCyXA8BScRGR2COSxoNchTNOyzv/4xn2ZH2ZOPv
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(8676002)(450100002)(4326008)(8936002)(36860700001)(336012)(6512007)(47076005)(110136005)(44832011)(5660300002)(41300700001)(36756003)(6486002)(478600001)(54906003)(6506007)(4744005)(86362001)(6666004)(316002)(40480700001)(70206006)(2906002)(107886003)(2616005)(81166007)(70586007)(40460700003)(356005)(26005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:22:51.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81352d72-dec6-404a-c268-08dbcff679d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6392
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 10/17/2023 18:14, Peter Bergner wrote:
> CCing linux-kernel for more exposure.
> 
> PING.  I'm waiting on a reply from anyone on the kernel side of things
> to see whether they have an issue with reserving values for AT_HWCAP3
> and AT_HWCAP4.  
> 
> I'll note reviews from the GLIBC camp did not have an issue with the below patch.

fwiw, aarch64 is quickly filling up AT_HWCAP2 so this will be
useful for arm64 too eventually, but we are not in a hurry.

> > +#define AT_HWCAP3 29	/* extension of AT_HWCAP */
> > +#define AT_HWCAP4 30	/* extension of AT_HWCAP */
