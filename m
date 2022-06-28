Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B346155DF56
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244001AbiF1C74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 22:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiF1C7y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 22:59:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44310E7;
        Mon, 27 Jun 2022 19:59:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S1p8pw020672;
        Tue, 28 Jun 2022 02:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wMamLpDb+BRSMzdaF++yecs649QCHZ3DOgROwQe3Bpc=;
 b=jYq/aY1sqUjt53/It8QrvnGHbksfYg0vkY27bXmC2aouAPvdZPMFYotmYsvQA3HwaTM0
 nOGwnY6e2YmQLwwm1Os56Fyt9OiMzDhqgMyd5CP1TttXBjSva1+SudstztZvZpiRiiWf
 NQeYDvz35LLmRqkpxCvys4KaOBPqMs7CK0UZhD1NUcc4d86VeCxxetSzimF9by7EsK9D
 c4Dmb5bv+xU37YZ700HFacoQ3QKnAgu1EOLTrfsdG7NM8p4nIR/oWAVhf+KuMtQe3nNX
 1RtmiR8urxRP7d74RwhP1KlFeHgS8vpjuyEQ+97mZf4ZGad6T50Nict57F8nqlAG+HIR pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt89vrbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:59:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S2t1HG032517;
        Tue, 28 Jun 2022 02:59:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7j601-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvtE1IluxXRxNRAdXj+qFrHZoAM3IRtNbDnRYlNUxSSv1k4ltXnN24SJG+3iKrA2WdUu8YSn5nPUzubHkcf29mgsNiIbjnx0QSUdqcOB0ZDvgeSN4s5HIPxtb3CjF7D4dceObk+Xi2o6L//+aA6fjYaalrcg7QVI9/zavvbi/K7ygetsmUigDJo18ztgBb91OcqrRgHXKbzgb8x2gVEg6CX2nxoxBc3RCMNYcyfnM1N6YMnzjS8sXmghZnc5Vv3fVbMWyr2dei1vQm6XkwF+tr9f6Xzl3Wj1oSEjQEjn2sGvaj7p9ipueXDhSILYmccHRGBhCKVfOZWPH/wcGJ3NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMamLpDb+BRSMzdaF++yecs649QCHZ3DOgROwQe3Bpc=;
 b=InUGp7rGX1unmBFP0RxlfGt5G8DzuZTxAOjDKSztS0X3yu1sEQXRuks4vys4S6ywdQxOZMIlzQDcVusM3XCeN77/pnNOipp9wPDWPtMRnlxnf20vanF1BBn5xPfrQE4cX1YU3N9kTspFTMhdy4NentGl4ag0eN9Oa7RH82ApocKautzIEBL3XbaiTB+lnryjW6DleJk3rWol2GnMZEMvlv5H/PwvacVnhj9wzx5st2Vuh8OoMXmWLb2Ah38X6m6EsCogQCts29qeoPw2aPRE6iPxGUCXWk5tdVQwkO9AskoM7zM9UjLGw9oZW6DEt2KLLSZSM2tuf+T7FVvKRBSI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMamLpDb+BRSMzdaF++yecs649QCHZ3DOgROwQe3Bpc=;
 b=I9XQ0jhF1X4CeHVVFET+PdKQLm9Namx8Svditd958QPAlpc3pKSMK6eaFJqbv2Rfa0xi09qDZRc5v3LPKhphrZdC9/0gqWQ95AaolsH8WHCHU+E8qwEuJ1QHRHh6+2QG2uijrpfgqAnm+zOWuqHIZiEF1GweR0OtnGZVXv1WSlQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 02:59:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:59:13 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkudh4va.fsf@ca-mkp.ca.oracle.com>
References: <20220624155226.2889613-1-arnd@kernel.org>
Date:   Mon, 27 Jun 2022 22:59:08 -0400
In-Reply-To: <20220624155226.2889613-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Fri, 24 Jun 2022 17:52:23 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:5:190::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0eddaa0-0a3c-49d6-e44b-08da58b22e24
X-MS-TrafficTypeDiagnostic: PH0PR10MB4790:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4KHyljA+8Z4xiHfUb5lVwRtPt8Osb39c4XVCLviyhjlN0h7hl0nYUd4peL01XITkHdahCs0KSLb9nJEYrMlh14sVy5eGncN2fe6iPcfZ2yreMrp2E/uMdW+d+Pah2QvgDcujX2XZkXzSZZvsWHBjHX5/US4IZstRVFWXaFJ37zIvWwoiTLWRvO5yloORDND/DAISk7xk1E4bPdrzYf7FB8IeGHww8bzCSwiJkh8O2Jh3CIuRKbVMDxkCzwsIywhYtcssT82I3vuaHbK6QfSdzqVqjE1wTJ2rVvEiX60SZ7uxtEzfGj9gcKBvf1rH0enF/Kz0ebXmaOVZRIU593AiFatCQbcDDGm6wiMBAfjDq6bfLY0WRogDUSFXbcqtLBeP3tl7wTRgb2N0Q4BFjYJdIffHfcMsDJlWylfJYmjJ8EZEvlet+Byrh6Uh9D+YmLD0L4fwXjM604RA8lfJLi0ubjccNt+cF0HqLIHimsq9MfCuuXPUZdDJSPDrv04/vU6veJt5MKe9m7SFdxSQx1M7rB3bxkRSJ8sj2mJ3Ps8Bn0p5OVzrg2qxdAQrJn2Zy4iUEQt8BUPJoIE33CrwfEVWie+MLZEqGL8x4AhqhiCzKPWxoLLzcvK0L6csvKumdj4iE1nYqds1creOSKYOVHUcW01NvwwLFiFgzl5IHQPBSDoauIDJ3lvhd1Ud01cIsXiwAToaOehlPeZGiLmXHR/GCqWyus3ZrG/x+TLrmqiV0b03qTg7r0MZrraK12hbh4criYxXRcO8iF8QUdYH4YpnjgsxyShBXeu6bRMpmQDz48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(366004)(376002)(6512007)(38100700002)(41300700001)(8936002)(86362001)(2906002)(26005)(7416002)(38350700002)(4744005)(316002)(6506007)(6486002)(66946007)(8676002)(478600001)(66476007)(52116002)(5660300002)(4326008)(54906003)(66556008)(6916009)(186003)(36916002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ogi8FfaCr20aXP5D0AeBliPkBoOfl3e5M2wOGI0c4ztz/AvyEfzVnHcH5rRp?=
 =?us-ascii?Q?dyXRZiG2D0FOwmCCh4q5a2/xl4GYGtTvv12cw5s02p/6tgGOkNNgBkvSt1c0?=
 =?us-ascii?Q?5wB1v7fdkezPG9iElRMEIJdjUwksmLFLX1r4slXo28/SSlJPpD9j5IpZ+jXH?=
 =?us-ascii?Q?vvx/OUcnmQEhXxDOtC/3pXzbQEG57qj9z9MRZ+PjTGShfCmdF12KAHweMM6K?=
 =?us-ascii?Q?ZRGkLhkDu4T6PrWSEdgmoj6UUTsEYdNzF61Ifi7pcJtD02G2eibMy5lbcJo3?=
 =?us-ascii?Q?ya5EY9GRclL1w5opXZVDzL2h69sUvCaLieYk91yQuv47Yy4lWDUOr60oZfsI?=
 =?us-ascii?Q?u6w6vmnmiXv3MPwOjMCJ5/d5iaShV0a94hpDESFENw+hAMkJelrNm+B3x62p?=
 =?us-ascii?Q?X9p/HwV/HgX9V13dpmmxcypOTZTDXlof93BC2BBKS83A+QTly6pAfA9G5dAZ?=
 =?us-ascii?Q?jNiK0alRsCN2Zxwa3+2BRYq6YDAUKkOvq8pntEpb5fQYN07fTyPz79yFVcgx?=
 =?us-ascii?Q?oA24FSRpqK/45LrrEyDS0oUeMqqeKsOQU/NZWRFRBVAHN/ZvlRZsE3d1xBVG?=
 =?us-ascii?Q?80Qc5CZ9gVol1VRtqI3262yS2HLYfhdMoqyIi2UH6RsGZlFrztqernXnhSBZ?=
 =?us-ascii?Q?xT7yMVK4XSiLqDa0VHa/d6Ps7ogo1gPJb9SH5VrTqRndeXZ8phk1pkHHrizR?=
 =?us-ascii?Q?1lj2Ozw+SRPpbKg87+EZX3A0kTl4bJXiw9MGPrrlWMJt413eSC3b63CZMVa2?=
 =?us-ascii?Q?lO4tCKmszDzNVT3UoRfZD5qZMYy5T/9JwgEG8Tf73ikG7rd+7Ic2fquhU2xA?=
 =?us-ascii?Q?WGmyHpVKUZqEbhrFt29cMFkQpnQn/2eW0QMbGCcVE7a0NyDrvaNSkANZ4lB4?=
 =?us-ascii?Q?xb2Fi+ElxAEKxf8Yc/TmuqlRSibCXDHas83O4OCNL9BreDeMxkPPo8CvbPyd?=
 =?us-ascii?Q?0ww3ZKpWJndL03XBIRr2deB3XpuPVzqoZ0kYwuWfwnc84HQKFQunoNDb7jEQ?=
 =?us-ascii?Q?nL7/LFrlA0AvDWgTj4UQUI1yVIIGDgF8Eq8okPHHVEusY6ksl1IU8ZZWyXND?=
 =?us-ascii?Q?ZqjfGsMWcv1wBSh3i3YEPTFjvDziQIr/AcXPBrMKW+jGWPfmCrWMip1v0E21?=
 =?us-ascii?Q?FG4H90dS1paXvHufqLxPsmFhCrj0smTDTqZHA+ApCTDTF+zL7GMh80pBv4Rk?=
 =?us-ascii?Q?8/Pp1FYI7kLdizN5t6WQddApPMKBwDWb/3fhhsLNY14nWN2spBn4zCwfNxU0?=
 =?us-ascii?Q?HRqzWrFAk0gu0ra8taFagqJoJm+GbmXe4qPET9hT6jqHNCpVJayg4N/dAOxg?=
 =?us-ascii?Q?QeuE6LB6B2ed37RkPzs4OoKjJQtBl07Q/qBK14FlhlTcZ9rjKNGnfvqoXzpC?=
 =?us-ascii?Q?Tl3Ckr2/mBUe3O7mcvrmEZdeCyc2/K66s7Jc2Rp8QvHEEfX/0vgO61HeWKSU?=
 =?us-ascii?Q?QbDkr7WnovC/Vo/daWD64mYv7brLLZVfcUfPEgd3uaXzVZRDN6HlFQLMrXxW?=
 =?us-ascii?Q?dj0YEqzB3WHLg3hrhTzOUDlUz/FIwvkW6PGgVhv7sIhVCxgz4ghOC55nnXeB?=
 =?us-ascii?Q?JyQ9PLyP0yEgU4QfMBiNzKhi7YZCWlcrZDvd0EidUVbmpkxBHKe55GwEW65Y?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eddaa0-0a3c-49d6-e44b-08da58b22e24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 02:59:13.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrNNVYlCJEUe2GlQS/SUgboR0K7cd1A8xqCcC9y4F5e/LCSlzQFxkr5DuOQ0MkXbxw4vCXPVIyE+apv27xcBVKtOOhhIFzXrpckfB0DR/ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=879 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280011
X-Proofpoint-ORIG-GUID: 1dFk_RKS9mTueJWMTx8745vB7FgPTCzA
X-Proofpoint-GUID: 1dFk_RKS9mTueJWMTx8745vB7FgPTCzA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Arnd!

> If there are no more issues identified with this series, I'll merge it
> through the asm-generic tree. The SCSI patches can also get merged
> separately through the SCSI maintainers' tree if they prefer.

I put patches 1 and 2 in scsi-staging to see if anything breaks...

-- 
Martin K. Petersen	Oracle Linux Engineering
