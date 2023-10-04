Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168487B870A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 19:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjJDR5S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjJDR5S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 13:57:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82CFA7;
        Wed,  4 Oct 2023 10:57:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FJ00p026776;
        Wed, 4 Oct 2023 17:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+Fi6dVKWp5ogqnRE4kjSyfPLcHlofmCzf1sAU+IxH3c=;
 b=4ACHlcIDSsWkB1tegbghA1O+0O87qnOqk2ABOX5cVTn0GBgOXdlZHvN2Q6F0SXZPJWZM
 87N0swV7MN//KONkAttyT0ihqR/f+vgxxwc1KNxoy+xMxLp5bf/Jr4XHmURgOc2x8fuS
 VxPDK7BgQ6yZvYwXqa+UT0rDzEv2lO0MzltPlUjkAS0FeNYsS/8YcB2jvXSMbQBsM2NH
 hX3f2kV+1Z4ODcRNntYp2UkDHC9ctkw2JTupEdHMcOJOXrGe1CzipeV/iu1b6Egkjg5q
 yBi9m0nqOuK1v76yPutYbvqJzqugClxkuzrIpt0UDKKEDUlPN4ByUPITwNiORkApNyqV QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3efqab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 17:56:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394GY2G4000364;
        Wed, 4 Oct 2023 17:56:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47v1x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 17:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGOXq1h5jyhmaca7G/ABTUG8IDTaJx5Mf91PEQX5NKl+i8OusecDO39jMAaZ4PWU9pmbZmpyEVI91WfRzq7ywEhGUX6jHBQbDKxnC9zdZFDsmDnBu+LEmUUJ5eTQBIFJ45G5A88who7J74QyN20WI7/wtv7gwX1poOdfpd9Vlrpj7pGqtBNbRNoNa/7HLFtA+qT6anpGIMSlGocOrCzrWIejLBxUccmuYXFtSAY2E1NvdDQIDiXo5q1yvPUIvZB/7yb20AgPktZFKF8F6n6hOBfMg7C0hlbpkLv/EoW0gxsFPtadlt5CXJc6yv4vmCTDOJGKPuvJZvDuoYOvnRtTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fi6dVKWp5ogqnRE4kjSyfPLcHlofmCzf1sAU+IxH3c=;
 b=GAdhv/0lwVM31OwrZFdsecsy2VGWBYxiIZ40ZHpA0IYkZgJ68tTXQlEIpbXr9Ddref+fH2p6cLiyCb/u3ziEUvdVAtNzpl42gFbqkqPBmKulrDhOnK9FTIZUYjNNDFxt67zy61/3LHse9/ml0oappsLYcXMSBggl6ysVgfXP4DDwc8L+BNyxozULBDg3Fq8uldLLtnCLs0E2F704YSZdlYf87UAbku0aHQTJ+cPSIMGtzqvJKtf2bauZw1DZjqJ+PtxVQ5ikRiezAnO8pMzL+jCm9DmEdss7MDcaTqtADBP86pZmOfa1UJem7hcnvWrMZgjDGMKL+nvrGoQ9n1FRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fi6dVKWp5ogqnRE4kjSyfPLcHlofmCzf1sAU+IxH3c=;
 b=eAcUAHh9mwwLaj6YwVuMyHJo35Bsl8eaimLAi7hIOX6fcQ9sBn0JzpfcUZU75zIfNffQcB8ClIeCxM4YUgVYWQR17kXn7ES18bvF+I9+luL30Rknmyu1yZbfpR6lPZRddROzbl4MRqBvhcHNlOvvdgpEL7y78GN71hiXI5IGojs=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 17:56:47 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 17:56:46 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
In-Reply-To: <2d690a95-67c6-45cb-91a1-4fbac09e1224@infradead.org>
References: <20231004165804.659482-1-stephen.s.brennan@oracle.com>
 <20231004165804.659482-2-stephen.s.brennan@oracle.com>
 <2d690a95-67c6-45cb-91a1-4fbac09e1224@infradead.org>
Date:   Wed, 04 Oct 2023 10:56:42 -0700
Message-ID: <87jzs26zl1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH0PR10MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eae3066-e874-4c92-9d12-08dbc50346e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW7HuzDEWjmepuAOk4dIIbmGayhQtlH90uSzdUVz6kn7awQbDICkIPR4opCfz/5kM8sFn6QUVZWitMG5TYGFap5xLcTK/tLsUqSl3au2JJ2FZ0MAKuWhKj8TuhM8ZZXlbjJzM/4tHEUAlLSsx1/iRyw7wvnIJHmgEtaBensQwWnSCs7LoqnxAiJko+Vw8Xy2W2ePkIFYeTKycLcRnqPqgAnWEiv2rar3ABobZ2NaNY2xJ9fqtcGJ70JTc//Eoc2+8MOZVEDDbBZ62vG/80+w2Fne3rfAVp5fJ2LLdxSAPIfGWrfKJ3bQnQ8icSX9NTGCmfitOMJ+5wukx5yyuQfzlfteUC5V0C0edpRWDTz5L1c7glHsdWNd3x90TBJ2v9GMJDTUiJu5CFUf9mRHOyh1Jbqqihw/gIZO9RPyX7hArkzbBF77q6x8onA1v3ZqHFhIFku7pcnHC6qIFa67aeewBSfqcAywPt910KyTzJfGkZvrElf4vvM7XMwMKQxjd/c5k4BUjN+U1MekiS/c/0lDq9Vqqw7hHL8AI+I2UMqPbp/ZoLDx5NUHUi8XwrWfJUor
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6512007)(316002)(2906002)(83380400001)(41300700001)(5660300002)(36756003)(4326008)(8676002)(8936002)(66556008)(6666004)(110136005)(66476007)(53546011)(6506007)(2616005)(6486002)(478600001)(38100700002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlDgRkWw+XIQFwjIc2j4MfUY62z3Epvsmx2UR0/SBlNPzJBNNKn6WEO7tJRi?=
 =?us-ascii?Q?XC7UAo8Z/R8nLyIOLXOSMNAZEbfPUWN5r+/TWFca0NIzGtnndDsOvdPlY6zO?=
 =?us-ascii?Q?hgpD5rTLJXheuQi1+BeTckDWuaNMW+PtEPkcytJ3EuAaOf8Ep/kTqJuUJ6Ln?=
 =?us-ascii?Q?rSKuvZBteNVNu+mjoJSy3Znm+AkHJsDn2a0G2DD5Fp1cPgMVVy7XXgVmfrkH?=
 =?us-ascii?Q?pAH7xgglGl4m3HcMMZNbMTZbYwSzhHHMvZzWLQ/c+gE/yowsUioTb5gf5gGf?=
 =?us-ascii?Q?ivnDQ9cAycwB2u90AWPoFQq3p3K0gPzGQHvUrJAQz2hV+Ib06bvp3/GGX5HB?=
 =?us-ascii?Q?Zi8ZvIgQ5GjKSntff2mvKiwA2DJffltCAqDHssNJmEFCBb6xdAsCV/wAgI0Y?=
 =?us-ascii?Q?OfKN8eSSxhPXXaGKser/SIn0VM4yXbUyq6o4uruC8lebvOqHKkap+YnYTbk9?=
 =?us-ascii?Q?HLPnzJ6Qb/g2pRXOgHfRhUxm27MYviYTshGwRfHZ9AIjZvJgKd2f6H/Iua9W?=
 =?us-ascii?Q?XN3RcQDcPHccFHp+fLXvZIJGJ2BmUEW5BCH7umx7FBLeeXRKnQRdmFW7Gy2t?=
 =?us-ascii?Q?DH9l4pGHD+bN5IzETrRIjq8OxyUA7AeXbZK1a0kmt4GNpUzl5mjo/sLhIuXm?=
 =?us-ascii?Q?+4lqfge/jHSL5sknV2LAlJWN4x/EYUkvjFrfvJISCLKF+7AQc3sqAyZUtEjA?=
 =?us-ascii?Q?cNSGUaeZKTI+7xqO4o9SfPpvi4XMZmB/LLLHoblCmSoa4lfw7PYGn3l6j2N6?=
 =?us-ascii?Q?FIyz16wuA00g9O5KzIVfGoD0aEJeOZRTnOy69abyunGOLiVDFDqoFl98Drf7?=
 =?us-ascii?Q?Jvu2TgOJo97ZiF5HAltfd+ACoYHnQ5Ci2szVBkQjsKbiuGzF2FK+pIge8Sub?=
 =?us-ascii?Q?2PnaAQBKiBpamPZPFuCoAAOZYHXv+ukqiz0sTTv2ogtx6XurQa6aAMRlHcvY?=
 =?us-ascii?Q?LL1Yn3Q70+VUlH7gID8pgPlL4REljh6Njd8gwHjprY+f9r78F2IYotSzzdUT?=
 =?us-ascii?Q?y/sDIGpXCvSOwP2rOFDi0tYiYt58Xa4CDsdUlAbYKEM8nyFdoc5M6Qz2ApNz?=
 =?us-ascii?Q?1IeNrnRsIFRRPS3jX3EvOVVORNNfWjm2Czt6RpEvxx5ccD6mUCBCoh8E0PxU?=
 =?us-ascii?Q?tQno06kODZyaJnb8VcPrSGfVr6OVf4Dd8fwysZI7Dk8n/ljUjjY8xEH5n2YW?=
 =?us-ascii?Q?R69C+O0IGrLCpkvygTUHKtYHM1ho2b6br73saqf+jcIycNWuifITLlYLrkU1?=
 =?us-ascii?Q?OV9zz2mgc6HE4S5GinE+Opejr6W+seDWzHfdewF/9fJSyxv+5uLUOm36Eyio?=
 =?us-ascii?Q?/9n3ewsFBQA1ihCunxpRAhjkyQ1w8ZMhfYcljwvz4Gx8q5nHzOsuQMeIQyC/?=
 =?us-ascii?Q?dis2dr/Rz0HzeVG7Xn4/O1bf2UnzeWN2QrZFe8T65dmfnC9p6s+DsoZLs31B?=
 =?us-ascii?Q?jFMzgaH2WEPGnJXXr/xXr0ORn0WmR3Jd5vPbxektrbRp46mMP+RII7tAq+oD?=
 =?us-ascii?Q?o2CgiU0Pxncvs5hW1G8XhtomFOjfaEdXUFy10dm1TvYPCW8LeeHBu37DE0Av?=
 =?us-ascii?Q?wVkRXIfnKh/Xrz+2CFxG/lWsb9h5b0qWkZS250MC3RuF2tMmKn2vW1nQnA2m?=
 =?us-ascii?Q?CmwuX8lK2NHbIRPinGY4ewuO1gHbvtK3au+OP5hFg5r2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +xxe2D2YpURhEVjfZP4szJGOdc8j6Sl3UB/cGnfwbJGrgYa4X4mu53y+Ni2wCNYUnpmJA5TwrmhoJxM8THGmy73/+eYbhyjzdVodiFClyUvfxU8awrovIPOmUGa1LuW5Rvz+xh1+wUlRest72FeClUNn4rIF3me5LofOES63jcRGFWIuCqRGv4jo0OaVpJwYKndQflmwxTdHE4LLU0GS8nusAlDX7SNL+8zxahFAf0tG5GilwoR/U8vTxoCPRPaAoSiTHZ5ddRxDBFZVnEIaIU53gwDJUGGsqBTEyBu3ofOFU4379FFpuOQg7j+30C8NhmI4S2vrm+hG326V70p588BTTsaG8b2nC1xCB8kcI8GrWisKcjyrQ9QbSoiTs5S9xW2QdKoy6vSxQTjClyjFJbMURuyVBMsMlerW56cPY/ctTWD7GrkGjC/rEgTkPe6diz1p9SOGUMYL/m5eBTkQGRPj8C1uLDzfpUd/sE1jY5BGNN40ubaTqpmjIwsHH7w7FHAepz1/+z/IA/rNtC4pAxfsJXYrJfqs0eX4S+qlguMOjrBGGnMjF2bVZ1nFOJXa+jIVuHxhTUPh7tbISzRST3VGll3BVMnpjFU/vSh2eECB8TuHFmJqwYX5yvtZ3Zune0yUg7F2w7c0MlITQEI9GRJUYn+ZoyiBAb+WOI89/8axlydNCmwFovdZNWZuECq74F1OMv9i29O8WGbz6iWbfifl3bNq0om0xWsVAyF1X10f3vU21NfhUPM9UV7h9xOxnMZGyj2TpXqBj6t2T4RcRaLaIbLV4dg74FeDP/RpPrHYTJitpl3LaOYtD7OOiJdv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eae3066-e874-4c92-9d12-08dbc50346e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:56:46.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BoUg4xNMWKOLnUcpGeM/T62HanBQzQvSDX9m+egmVhxEL09fl6pIVsCF2DjuvvivWE3fJZTAjGrf2dklbfMWUv4enQNoD00mSU4wdWZP+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040130
X-Proofpoint-ORIG-GUID: QcXSzGWyknPWztiLhTXgiboe_cUI-E4Z
X-Proofpoint-GUID: QcXSzGWyknPWztiLhTXgiboe_cUI-E4Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> Hi,
>
> On 10/4/23 09:58, Stephen Brennan wrote:
>> The option CONFIG_IKCONFIG allows the gzip compressed kernel
>> configuration to be included into vmlinux or a module. In these cases,
>> debuggers can access the config data and use it to adjust their behavior
>> according to the configuration. However, distributions rarely enable
>> this, likely because it uses a fair bit of kernel memory which cannot be
>> swapped out.
>
> x86_64 allmodconfig is 91 KB gzipped... oh well.

Yeah, and info like BTF is much larger, yet this is the config setting
that gets trimmed out by distros :(

(This is not a criticism of BTF, just an observation)

Unfortunately I don't control it and am just trying to work around it :)

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!
Stephen

>> This means that in practice, the kernel configuration is rarely
>> available to debuggers.
>> 
>> So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
>> which is only available if IKCONFIG is not already built-in, adds a
>> section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
>> out of the final images, but will remain in the debuginfo files. So
>> debuggers which rely on vmlinux debuginfo can have access to the kernel
>> configuration, without incurring a cost to the kernel at runtime.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  include/asm-generic/vmlinux.lds.h |  3 ++-
>>  kernel/Makefile                   |  1 +
>>  kernel/configs-debug.S            | 18 ++++++++++++++++++
>>  lib/Kconfig.debug                 | 14 ++++++++++++++
>>  4 files changed, 35 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/configs-debug.S
>
>
> -- 
> ~Randy
