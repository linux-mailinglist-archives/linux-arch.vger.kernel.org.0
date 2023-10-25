Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C765B7D780F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYWg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYWg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 18:36:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2419AA1;
        Wed, 25 Oct 2023 15:36:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLGJCN006386;
        Wed, 25 Oct 2023 22:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=eQss15UvPBo3BbJhLU4iex6NASr6xXqmpSfHJOhlbz4=;
 b=D8PcQ2iutEE0smcMfgzisVA8bxPaKngfzzc6htEAPr7SUrjhAnBFs17OMu7d51mBEVXL
 aC0ixgZupKnMXSEDb3DcKKBJ8zgJC4SkGetcWfwR9723vOz2OZ/Hq2nhSMf+mH+ZKH9N
 2avE2wNcDITfnRDK8/InR05IM7cGg/dTG1rc41OnGKUlShpyV+1YLMK2r929sFYNCudC
 j/WzB/U2/WvtQRnBZvvJZjGaDyGPHguVVhI4zmviXO1NLFDaiUSo5IrxJGYT3AFuhWZg
 SUWznQT32VOSIGoUnRp2KYfOvOajiXVV0ApxGqJhGp7e+9uQJXTEeIlqf40krXjJYG9B aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581sheq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 22:36:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PL0RmX014244;
        Wed, 25 Oct 2023 22:36:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfmkrr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 22:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU0+MeWOFXNn+tRWgsw16S6sL7AuE+E1/6gSEGYLBsRr4CgDM+9sQHTGGgvp5WitK8tRczQRuFa/XAmeU1+NZ7igK8Y4KXazA004klu56sBN31QOET/LWFuslIgrCr5cCrgfuufp2sH0CSCBSDJWczxqINBrYoC5c+ggxKIiEwT1GLGXEsa1Aje8LT63QDgTpHTeT3yjhuZSqRg/LaX8ZSB10yhqT84NVkw8heTbHuUBxeySNIz+1te0bp11dks2EaVnt6HL8q5jl9Gn3dWfxhuWrkqFXGcwN9guCK7B5MDYUtDPOO27WgxGWnJZQ//Wpl+qm912+h95ORPHKHC1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQss15UvPBo3BbJhLU4iex6NASr6xXqmpSfHJOhlbz4=;
 b=FfCAaBnErvto5SQoArRx447P351uYiwqletY6udv6WWX1IinU3XUePKVTpRqdu5r/hsjSVAW48rRAMfYClQCKL/dHicJHPilb9x5Tq0/SeDZxsiCDzRnAte5ahnQHmeWFJtjfe1veQ889PpanoynZexNRRZLVKZBzxzePhjV5DJaPeULajUkp8k88wbXKqnGVCLa3cH9GjKuzYrTs3OD7JNB/Rr6NvUFdvO+V7cwXL+sbVkTPBcTqw1GiICu3Wcb5ckEAEl4JX0IUNF1viBvvPnCU6X1PQOOlxvIdZu6cOf5ddn+cO6t8C9qhkDjd0nEQDsNHxNCdg4AGKQeskSw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQss15UvPBo3BbJhLU4iex6NASr6xXqmpSfHJOhlbz4=;
 b=wtx+lD/hfDB/PhuhYzwO4lTSKEI4CHJE8eyoIvEGwSG6fQ3cthmrHVC3Rp4AEK9wi7nEyRbARcrBTNVetk8jEGRG+uE59lCmnLrOSloj3eneuaczgWtTn+QNMWoF8asRtQ8wO+njySwbOMJaOiqLpPWmEWkrqjFyTy68m/KOYX4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 22:36:43 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 22:36:42 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: [PATCH v2 0/1] Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Wed, 25 Oct 2023 15:36:39 -0700
Message-Id: <20231025223640.1132047-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebd5ef9-9356-4f94-9474-08dbd5aadcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cdeb5EfhaXA7ixjceM3gNHyqKAN3h3GnNHlPAcLfBg6tjOE8p3t72lU82+qzeU2Dcj0iMkKvz4ocPNer6ma+FBeIkehVMCcD80dgFvSedEF4XP5/h25DKh+G44E1TWR6iWksCtoQTwG/spplqdVZPkBqVdyCnCjUMtqdAGUluU6fighQoOM1AdvDzKZDp4S2PlMz5ehta2GibDrOzmb7S9dWhi8mXNsUt+m0sFRZJiovUIz3vVgNG9eKJnE7Mei7H83u/v8BOdgYnBIQb9P/yybr3dkXgJyNvndLFOyOrS2NuJPenBQ8MD3/l36WByWvUG+3kbyryyUVwnZ1c8eFsOJ3YTu32w+KqbHrGoZ7J4ZVD4T6DlFUnnEbwHlHLGNuoZ2KPm1V6zA8aGe4VGvl9pHw9S45OAlgQq7a5XynDys8aJUyAjnyU5h4Nz3Bgu313eZJo8S5gdhiL2vP7JhMcEQ8ZwsAlSzzaOMqnSxXdx3DSM2GntZ0JptYcW3FOCL2T2hXKrr0rOzDi9vq2E9VZFneIbllusL/7Eo8pDt63mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(1076003)(6512007)(6506007)(6666004)(83380400001)(103116003)(86362001)(36756003)(38100700002)(478600001)(966005)(6486002)(2906002)(66556008)(66476007)(66946007)(54906003)(5660300002)(41300700001)(8676002)(4326008)(8936002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/kkn8V5ohMKLjz+m87oz8VAMiWOa/oUeK1sSSMGE9Wfb+eNoScu5BBrAGFE?=
 =?us-ascii?Q?FopuKE7nQo0+aMf+LJioapzZDmrw1v+iwXHVhOuqcmgkuxXYipGTqQ3m8vi3?=
 =?us-ascii?Q?K/cbWD/Py7h+4YY1vTyIquN51w/VUaf5vQFZKCGJ35xqrieB1m3l0+v1c158?=
 =?us-ascii?Q?1zBlc/Inyrn92mF+zN1ON6Of6xkOGhky1KGZlOeFQdY9iNPhxrszH1mvZqUy?=
 =?us-ascii?Q?H6Howui3rWSR+5SsEqJCQEWkpxC6wpn8dU/DS9dFqo64LHY36Dmn+/byviub?=
 =?us-ascii?Q?Sstb37KteSHqzhlNLyd2AtD38k2jjA6YPqfnYePpbGVoGLuJjtCwLUizhTM3?=
 =?us-ascii?Q?bFMd3WooG9m5ndUcIrLavZpYC658B5Hb53RXQL8wJ+hSsJcdFO6ju8bs7ERX?=
 =?us-ascii?Q?duNLJLiKttAluhw25hgRPkgwETFgtVDH1Mq9xKGzObxaCPlKf0TmxBAGBhpi?=
 =?us-ascii?Q?c4nR4n1i6rmw6BaUObCGkgg3ERZx8uJKacFjEPpmjdy/bItPCh7U6ZvBgIzK?=
 =?us-ascii?Q?oaP6E/4xKIVsk1u6ZeuAyz2dfCEh8OipqVfwSdgr+vmI00MWnf691lHAq29O?=
 =?us-ascii?Q?SSHq6FaGDioc4liBipjQzXxJn2tDaC69TJFCKqj1aPXV8Fg2d8AppWoWjkdu?=
 =?us-ascii?Q?MWoVQvQT8hoD7l2pBdyYuF/SyPXoT8i+OnnH8u6MvxvHzqmgKZqwnMX0g4ig?=
 =?us-ascii?Q?OvrJ65uDIbOsxjknX4eAxnqpT/gXOHQ2QZkWirETAdC/Zk73rfnQ3dAorKlZ?=
 =?us-ascii?Q?IOca012U5ASVfh+ESR/en09cteL3Wp58jdn4SVqV/lm70LD3BjKHU7M0lzky?=
 =?us-ascii?Q?vFEQcmoQLbmsSwsS533MXZuj6fIB9wggm94DAEsbAedv9swEU2nHJM2nLkTM?=
 =?us-ascii?Q?K1KxbU5fmuGBHtSVtRP7TSnEiYVZIbsQjCBQ+bqEhEy4XWACEpBq/lkXa56N?=
 =?us-ascii?Q?4aUOZ+0lv0O3ovK65cNjUn379ohgIOm4BpbJ0mTqEPkWeOnoNRiKbegfcx/g?=
 =?us-ascii?Q?Xq7MEzbfmVn5FNqz2s5BdwPOzzcv1IRDXsmkrZesYH02Y98l9udpC+GpEZWk?=
 =?us-ascii?Q?6iVvSzNWcfjyLQBC9aCNLLsEoGGKGZNE93b10RbgMUQ3v4leaS28R9r9fk9a?=
 =?us-ascii?Q?fGMHG5/sI3n89djfm/tfmoP3aOqatzHvpZu+QU0cM8tgsDlnICw1cYH0Wtc7?=
 =?us-ascii?Q?oW2X+G9wme1MDhm2Q+wko4OWAtL3kG7r58s7YOFPnd5gNEgxnI7usP95fzkE?=
 =?us-ascii?Q?Exb+n3UVbg280vUGTWGsgyvrK1iJaqu/oKCmi4pK51747SUbMJVH3UhLIONM?=
 =?us-ascii?Q?Hx4pF4LuDe0Eg4bpeFYuuHYhkEbTricTygzlhTZTO8AGPF0r3SHizvkoWA7I?=
 =?us-ascii?Q?rfDvhelBPFNPs6LHCSDIlg6Lyc/0SB049s4K2iEshJ7Fsy8pJMCFPgOYc5JH?=
 =?us-ascii?Q?AgsMyHZd2/vcyHVrt4nwU+7B9qUB0R7IFPC/Axbqdgghmgw382WGEYANm/Pi?=
 =?us-ascii?Q?Saglxn6LAU4iOrkXpN6ANqjWZr9ARJcOA6cf42RQ+blKGkc7zkpmLOs01ws4?=
 =?us-ascii?Q?Yo+RYtczUAvJxUB5wOmcbPjQ5wDl0qDq8np3YrPgV4+dMKLB+sG5p6SMmREe?=
 =?us-ascii?Q?Kfw193k6wbPRdf5Wqi1J3E4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UsVmLjTpDSQp5fpB4ENoyZosijygysrObr/wsLqEQvYghM8LNRslosPDbuknjzDF/88537X8iHS4bwx7vod2/rET7DP+8BWoZSIHZo0zuLg8xec1Yxpm60lkzEIOF0T/qGErKdK7qJ+2sVnc0kA1LrnfPAZntAV7pTp/n6HkTP5CX1zS/OFe7C1AoHCA2PAZfxqeGECB1ImRYq+2DMDEEi+mZ8LIxp02tg+kUjoPlOnreDRinSk1qBzHvmXbdVe32f6726TcNnC+dJhtYZ57RLTjn8Dn6yO06KIUJXhNUw6fT1qfr18X0V5plvmklEq5nVjSUyzSRTzu4UhrUZwE24vH3GuzsBm4Gz/EbNmxA5Buq/eEenDq3ugirLqb8Kz+B9llf7olX8tRI+PdnpZXxBOBMDdoBNNXoIadCeephtF1HUu5QL9Oi63fRpyDN8Z54iY829r8ezH/PL5Mpy5ViCX7JYkq/EIpzwLjizD4sP2mtROb8zzojeBVf8PlWyU/omd/ahmMchxgEqODclNpi3NWn2Cc7bFCr9m24z5Bni1tfMbHROWF/8AhnZqL5vS5rmOepPNVOi8rdT7D2tLUTwjA8Xj4VB4rzBsuWaTxJwceoEIBDvwdQiZd7vfK3DrcXcXC1ynktFzxzXd9v7Srjq1inG9n/EiiDJ8m0Vp5o3hIkeOkohFSlU2ANwHm1cAveLwzKxdT8soyU8hxNZG84ubV4qoskGpri5Rs9MfodiDXr2en2fJvvaDvioEURiUV9eDHmupiDTotjxmPs6DwjJoEvttqmQaJBOofvZ4wB6g6hqaALUgNX8WPv16BpcC2G639tpZlFG3s+ai58oX4Cg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebd5ef9-9356-4f94-9474-08dbd5aadcbe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:36:42.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Piy2+cKQq6eOBBKwKfdM20PfeyESDnptAJg7yRg2Zomwl6ShxsBWy7xT/mtf3g0+Mje8CIqJouRhKMVWEVLRkhnfpbPsLqT9L04sx1x4UJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250194
X-Proofpoint-GUID: dByHomgd6g2YtCLkxVZN2rCwUMN8U2mB
X-Proofpoint-ORIG-GUID: dByHomgd6g2YtCLkxVZN2rCwUMN8U2mB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello All,

This is an updated submission of the patch to add an alternative for
CONFIG_IKCONFIG. I wanted to bring it up again for consideration, and I also
made one small but important update.

v1: https://lore.kernel.org/linux-debuggers/20231004165804.659482-1-stephen.s.brennan@oracle.com/T/#t

Changes since v1:

* I added "default y if IKCONFIG!=y". The result is that whenever DEBUG_INFO=y
  is enabled, and IKCONFIG is not built-in, then DEBUG_INFO_IKCONFIG will get
  enabled automatically. The whole point of this patch is for kernel debuggers
  to be able to rely on having kernel configuration information. The IKCONFIG
  data is quite small compared to kernel debuginfo, and it doesn't change
  anything at runtime. It's safe to enable this automatically, and it's
  important so that distributions (who create debuginfo explicitly to allow
  kernel debugging) will automatically begin creating this info for debuggers.

* Randy Dunlap did review this, but I didn't apply that tag with the update,
  since I understand changing defaults is a major update, and it's a small patch
  to begin with, so I didn't want to misrepresent the review.

Stephen Brennan (1):
  kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG

 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  1 +
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 15 +++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 kernel/configs-debug.S

-- 
2.39.3

