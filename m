Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90BA57D216
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGUQ5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiGUQ5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 12:57:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-cy1gcc01bn2085.outbound.protection.outlook.com [52.100.19.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011189A70;
        Thu, 21 Jul 2022 09:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrygHs4IoOeJSblnsQwLTEKkn4qajEdHjhsdC9XV+tw61Q9Wjs/VjZh58S4wSjxXBQ0znZkbjbbKEdOeMlLksKYL172EaLhoFXUnqKbOpJdSP2w1iF1Nye5LkRfxotdOzWww8hfasP5ucMkkRhNSdZD49LXN+KaFuEAfFsHualu5Ja4EtlsjJXdOQ/nqL16garE1n+E0O/4RpyC/O5RU4DVWrSKpH47wxf69R/Vqk40311ZSVoM9t8S76VjgkfpMlZM/m0ISuMllIqDBK8zHr01GzUg3yjSq2Outd6C4D9y6jFAqXL0dKQfcOUIHlT5hii3zvVCiTMkZVOO4532eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufCI9C68Qdi+z4RWjQt7uDSk6RdinBXtQyNv5C8HqjI=;
 b=gdq3fSHw07J//1igCSQnsPN2m++956ixKS66jxGv6fsTlEoQVZax/ewulUP1y3gQkCF5ZmnGWsFbD/3saxzkppFZGz+Z6FV7MLj+OViZuyzE6v90m+HFlbZL8KhUTQkcroUJiRJgos/nm0HrOljw1DJvwz11FdRe8QBlDCOYGRlSgcoV7aqKNMh7B7Fwr7p8AxLJ/ieLR0UtTvRmufNl0ir8GoqlF49YDOTvkT4PUiarZylfTSshPbJqDfMQPLckNtPQaZx9a7Ctiuf8dMykKG9BruT4LejDcOuQk5gksTOVfCeCcw9+OGqkbXejbx1Yk+eaTTz7OVb1vg/6TKuaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 193.183.126.23) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=redington.com; dmarc=none action=none
 header.from=redington.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Husqvarnagroup.onmicrosoft.com; s=selector1-Husqvarnagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufCI9C68Qdi+z4RWjQt7uDSk6RdinBXtQyNv5C8HqjI=;
 b=B1eRPNeqaKLy4YZSWMKuAn53Un93o2NwFvJ8jp1jfofXYhOD4WqI3rc/uTbcdhcSKYGstCYJGMEieph6x1gVpJPXg636Ub1rN3FT2Aj8g+0FZcmkv8wl862NlSzSD5ZLCEC7lmWmly+393KbMGh+dUD35qRUQ3IBLNbbndJD9IE=
Received: from OL1P279CA0030.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::17)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 16:57:17 +0000
Received: from HE1EUR02FT073.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::a6) by OL1P279CA0030.outlook.office365.com
 (2603:10a6:e10:13::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 16:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 193.183.126.23) smtp.mailfrom=redington.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=redington.com;
Received-SPF: PermError (protection.outlook.com: domain of redington.com used
 an invalid SPF mechanism)
Received: from smtp.husqvarnagroup.com (193.183.126.23) by
 HE1EUR02FT073.mail.protection.outlook.com (10.152.10.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 16:57:17 +0000
Received: from AS400TGT.CP.ELECTROLUX-NA.COM ([10.80.249.221]) by smtp.husqvarnagroup.com with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 21 Jul 2022 18:57:08 +0200
Received: from [107.161.81.132](107.161.81.132.static.quadranet.com[107.161.81.132])
        by AS400TGT.CP.ELECTROLUX-NA.COM (IBM i SMTP 7.3.0) with TCP;
        Thu, 21 Jul 2022 11:57:08 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Please Read ....
To:     Recipients <gukailai@redington.com>
From:   "Ms. Gu Kailai" <gukailai@redington.com>
Date:   Fri, 22 Jul 2022 00:56:43 +0800
Reply-To: mail@gukaimail.com
Message-ID: <SW02202YFSrAuWiqJmd0002e268@smtp.husqvarnagroup.com>
X-OriginalArrivalTime: 21 Jul 2022 16:57:09.0020 (UTC) FILETIME=[EA256DC0:01D89D22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11643831-cf35-42f9-ade9-08da6b3a1196
X-MS-TrafficTypeDiagnostic: DBBPR04MB7772:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kCUSmUHwFKYe+uC026CDTVGRvOjgDQSsICkC5ntNLzg5hjzk7UkHnn33Vt?=
 =?iso-8859-1?Q?zKi9Wqkil74cgr58rWFYTyrtqgcBM2Zwy8aFVqr5O47bg8hyiff65oTT7f?=
 =?iso-8859-1?Q?hFdCzDVjNGyE8qmt6OHmIx/u52Qh3GpDNR/z5nYFFi+eM9SdvvEcRQjLQA?=
 =?iso-8859-1?Q?MWMzZGdfPqrbRxZY8/DLEcnvcudBseb7L0Q5V5WixoyUAAxZNCkGJpWP2Y?=
 =?iso-8859-1?Q?wap6VFbW4w10lsyRldKaBbHQ90H3K/TZC2S4RjQXVLpKPoZ1iYulsWR0bI?=
 =?iso-8859-1?Q?T3ZHXBaxQuDJiytIza3xD4Xzk7nbIz1yS40J0Fl/joI/KZdfybnpwtNKst?=
 =?iso-8859-1?Q?BrJRbHBIFfkXIowTICZkZOA67WrJdlyeLlzecn1aOTpMHzXP1qMiVJKuHZ?=
 =?iso-8859-1?Q?5G09vZlY4YnxiPt45hguqFwZq15XzZUFbKYQQLkwUNVRbn3nmekASw5Q9t?=
 =?iso-8859-1?Q?iy+UtrRcG1NpIMhA1NiNahaMElIpojb+oePe3kSt4RD+9qF+GJ4h7bPcj/?=
 =?iso-8859-1?Q?jZ6w3qhi6nSCOUu5f2frJzjr2sK2bNv0yI8pSO6KnLdmxDiUb6RZFQvqGK?=
 =?iso-8859-1?Q?bNMXnGsTekVAJr61fw1IelFkmfqwQhq/El9GEE8x/XVgRYUu8j+CWwQLPb?=
 =?iso-8859-1?Q?p9VKiB2v5S9BMJqmVlyysJEtCClVahzk+xU7XGKYBfeWg0eIQ5Mu7qYkqZ?=
 =?iso-8859-1?Q?03XpZ+tWymlDeTuAF5uMcnlr5uqjG2vwR+Bt6oqgLNhmhYF6HeIGC3gVK8?=
 =?iso-8859-1?Q?D0vFHZx5qnzbIVbq3uoJoHL2uGlkIR+Lb4D2GQb840HLyj2z+4MdTCjumm?=
 =?iso-8859-1?Q?k+E5XBaQdQihC3ssRpS4kNbFj8GxpmsOKUHluGFynFCq7Pah6KABBvgl08?=
 =?iso-8859-1?Q?XtgD1mT23NgMZd5jMOctiEOCSbbUCSNIE8H8OBJHcjuzV4g1qHq9ABBqG2?=
 =?iso-8859-1?Q?gRsYZSmA80KGiMsASHMMMgy6Qdk/k0ac94lL8VOLasWt7Bg8aJJ5p+1III?=
 =?iso-8859-1?Q?+L9t9+39aS9zZQbmQDQ//bX47QdwYyVRmFGCosmkI5KkzXqndp9sQwWgsN?=
 =?iso-8859-1?Q?qAuPV0C0WPgDL7R79Qm7Ws/R37agIHIVviunCSovADAdSGsnia6E/TwGJa?=
 =?iso-8859-1?Q?JIK0RwYWUMnICeeRpluajO2ftmjCjfrrNnzcofrIxfiEiCek8EcV3xySrO?=
 =?iso-8859-1?Q?HYmjq1Vo8JxwtA=3D=3D?=
X-Forefront-Antispam-Report: CIP:193.183.126.23;CTRY:SE;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:smtp.husqvarnagroup.com;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(84040400005)(46966006)(40470700004)(6200100001)(41300700001)(498600001)(82310400005)(2906002)(26005)(6666004)(47076005)(35950700001)(3480700007)(40480700001)(956004)(6862004)(9686003)(336012)(81166007)(356005)(70586007)(8676002)(70206006)(316002)(82740400003)(8936002)(86362001)(83380400001)(40460700003)(4744005)(7116003)(5660300002)(450100002)(62346012);DIR:OUT;SFP:1501;
X-OriginatorOrg: Husqvarnagroup.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 16:57:17.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11643831-cf35-42f9-ade9-08da6b3a1196
X-MS-Exchange-CrossTenant-Id: 2a1c169e-715a-412b-b526-05da3f8412fa
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2a1c169e-715a-412b-b526-05da3f8412fa;Ip=[193.183.126.23];Helo=[smtp.husqvarnagroup.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT073.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,



I want to make a Donation to support Charities in your City, I will need yo=
ur help to achieve it. Reply to this message so I can explain further.


Ms. Gu Kailai


The information in this email may be confidential and/or legally privileged=
. It has been sent for the sole use of the intended recipient(s). If you ar=
e not an intended recipient, you are strictly prohibited from reading, disc=
losing, distributing, copying or using this email or any of its contents, i=
n any way whatsoever. If you have received this email in error, please cont=
act the sender by reply email and destroy all copies of the original messag=
e. Please also be advised that emails are not a secure form for communicati=
on, and may contain errors.
