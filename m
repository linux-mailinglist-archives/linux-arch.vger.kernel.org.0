Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1617B85F7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbjJDQ7B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDQ66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 12:58:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40577A7;
        Wed,  4 Oct 2023 09:58:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIiPr024127;
        Wed, 4 Oct 2023 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=IHvcv+VQ2NsB5bPkAeoNVVTUQHfytK3nzrrqZ5Heqkg=;
 b=SIrn5EQN544lI2YWrKpq2gdL+nq+BOZXuOQfxNM7/AuN7mhHVLGxBef1ZuS8/0INDwhU
 T4/bogpDc9ps9vISpDx0ngch0Agf0hMQo0d+L0nw4kboYzGtuX3TVH7pFbU6P64Fr7eP
 tfzSNCM8mwQIF0o/JhxeFaR7TcaIH9HgbkWouDEl1thGPeSxHdWmBBqfB4fWNCksuScG
 It428sVOCNtXkR0ICkJIWJrlylCQYxBQGKT67mRIAuLN3p9BW6Gvytfya+LviGr//8VY
 17kU0wmfY/oauoBfQvBZfyDXUxAbGir3gwBxAfch+mTUWSL3F6ig73Dp5gQqDs34UVoj fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf47mmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:58:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394GcYp4002843;
        Wed, 4 Oct 2023 16:58:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47u2h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th4Wo4gqpeVpTz5ROTVsSuNGPaStBKEBWCVU1WJFRnHJUEiWJ3TyNS3Jl28LILo9CEdAkTQy5EWgdIvwmyXXL9DhJGOo697/5BGEQf51gAGk/p7NNJSzi0332ZrWHof1WNjakRAURUs4b4ryyDKKxcUDEN8ae4aXxEvF0IPl5987ZMOQjIGJgWYxSMv8V593LPfbpvR9E4QdiNg67lhoXHaHi+5mWzxzOWSksn2kczgpbeld7SfwPN4NcXSpuwqjXhdn9uPXwDo7PxJjgNjpwy0c2fmTtvZDV1wChWQ/WDwUfKZ9dp6ivNcBatH0t9SUijbgkx46hW1jDP7Hm1ZUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHvcv+VQ2NsB5bPkAeoNVVTUQHfytK3nzrrqZ5Heqkg=;
 b=BXbym1sPneqA92kJzO3qagdt1uDDQRTO8PBf8TwYycWJYargdtw+JT4Iwjgs6M9xIPZwPs9fri5pDOKA7pCxDOqm+AGXY/2wLnIbGVeg8qRvZcjk/HyXzDDa+dTK2ttNMLIFU6OFxEHB6OQLt1CiKyt9R1Jylpgnuhv2AFkHZ7NLXCH7EJWs9rjA/ZkseNggRHmNV6JP+9bCjbStOgMv2DU3NIVPu75zUfNEXKYnYIlcHZmvpnNktCiVQQkd+/BJUIXLhKsghvg0D89Ja7Y4xBOTX7Z0A88/sdm+//4sbCs15Z3+EP98vnLdGIPh69JpsGfnkRvfMt/mPZIWuXfA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHvcv+VQ2NsB5bPkAeoNVVTUQHfytK3nzrrqZ5Heqkg=;
 b=GePfkDxEFV+wEY6/WrLddYElREwcEQPDe+Q0yPBHiAkGsEkr3bdpgoXVb5zBTNgTn/fpBm+7+Fkj1vFRC0fquQRp/TIZ0Gv23goQAkeWMEJvMYUhssvd2qocJUXShByGU0cf1t7ahOlY4i7IBj3pvzGi0bdKQMBTtUkf6EXlUb4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 16:58:06 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 16:58:06 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: [PATCH 0/1] Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Wed,  4 Oct 2023 09:58:03 -0700
Message-Id: <20231004165804.659482-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::17) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 009b35dd-2667-4fac-04ba-08dbc4fb14ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQ9AwUCGF/g8p9ojsEKJ95a0e85bR29fQUVq1bhYLRJmoqiMxw5QIyDsNF2AI2C6NPMLBPTtlZOat5mdLESZmcnEhxSurKkxoUdJLRR+TPE14y7gOE+T5cRNWIt9TTvgc0Mo50S8ynxf3My6cp4A0SLhJ8bFHpfDlYKvzmsJiKQWmVBJMQYTRnN6Di/3++hCZGTDMXzRiGxDNrEGf1xYSOXb0c6wYoz6ScvgEKoZHJk3VTuLOe51QpvnuCnVAbkK6+FHM70unJ5PkbvNQGa4eMR97AAdCwhw+wUFSR3dgUdHNwVvKrq0N26vlPP6KglRbW1gbF1rjsZmQoLZ+7qdcvfGpeSBTTxZm/0qufhskzGwrDEI7klEKxQrDkeUOSIxVN8WnPmjsDERCLrAWmtUNDEo9oS7RE8GBxvdZmqyHJMhKU9+zP+WjGAS0cX3c9twrR5DPRn3B6OAVqDbGh7OFRSFqrANZtBfK8rj2taxFCRWj8pfiJmLDRtHU3/cdET9SIRGlo4VFGD2Q8IL9LxU9vnBxV46wpTpUGEEyzhf7ms5Ni+m0CtF7fIl6v0mQ5EG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(8676002)(41300700001)(4326008)(8936002)(36756003)(5660300002)(66476007)(316002)(2616005)(86362001)(478600001)(6506007)(6512007)(38100700002)(6666004)(1076003)(6486002)(66946007)(66556008)(83380400001)(6916009)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?exeXP+f5O+2dYTvbzTYCin7uYIHJAgpQ9mcdHezm5SimVhyvd8Njlp6CAJPq?=
 =?us-ascii?Q?Y7HAcOBqhOQZnRJwHy5UDKa1mT8McFpfHct8Hv6EgYgf/XlbwMeyqVk344gY?=
 =?us-ascii?Q?Yy7NspCIaK2HuGTZmUzeA+KcDUabHbU3gWfb1db/pYc+yvc3g31YDRcyrs0R?=
 =?us-ascii?Q?83ML9ePWSKHrqzh0HWYpAqRiUszFNB8Dxw+rfAlikLZinhnyYrjlaw90CAon?=
 =?us-ascii?Q?8tUlH3PfKJhtsceAyvSIb2tJ8DFdY0NqfMII99YNhtDWJH3VkaMygwdp7nRZ?=
 =?us-ascii?Q?KEyJVAqnpz/k5ozpde9SzLQ3wpukmss/UPTeGTe1rhwVSxRbvKMg70Yz2RDD?=
 =?us-ascii?Q?s/1PenVNKlhgaZSStIuxWEZrGXhAvciOqMDkRIozjP8z9ffM0NgN8h1b4q5t?=
 =?us-ascii?Q?NPMr3wKcteR/plEKa53dpZjvujvOR99ZDscELY1CecACYHRpd/yfISkJVJJw?=
 =?us-ascii?Q?h2+E7UGQr1mZUwRGTXiC0ZnPVnh2/HGbpoBYEgcKVVXySQr8wBzxUPkrQuR+?=
 =?us-ascii?Q?xBwNO9sXeyOfqa1RNrtvbegZ163dDNmFUU8Ewbu7esMXWJnk5qmKQ4p1ros7?=
 =?us-ascii?Q?QiJV4vErEUfYYZHtYYVB/eHiFRA7otiQeSwC5I1kL6KfGKf1i6qhMI+e7pbb?=
 =?us-ascii?Q?UsCK25CCRoiabigB+pUX0Y34hCH/Ov+93bL9lVtJEAzTcqkJimtg6XVh/XEJ?=
 =?us-ascii?Q?ejGdMH5Rkhf0yeTYam0c90NlQXIJItuc3PXN0kdkBCy19GICQcg6jiON/gdc?=
 =?us-ascii?Q?3+xmIe2Kb9L3P82GB45/YD9nOViCYXCzuPRv0D8h32KzlwrCpyIygoYyzH8K?=
 =?us-ascii?Q?iFG+qt1sdM+vFwHQMcy7A4EHQH7u6GWKgB7AX7SxkQetValBZb8FvwbQMvMk?=
 =?us-ascii?Q?qR7I1fkImGGLkhjrew2gx0wRN+NACHCAnQ9pxocQhFwkneL0TE3EqAdbsNGU?=
 =?us-ascii?Q?61l36xVtsiekE7ZJa9J4AZ6pqZUcSuCieyRfBb0qL0uuw01d5du0ncCH5AN9?=
 =?us-ascii?Q?Nym1Aur0Z2RU8hUpS1MnWOYnhO6ljje9hO6I7YZ2DzFFr6vIwrnKb4akPKgA?=
 =?us-ascii?Q?NWgkjAezbmjjb79EhCc2504DvolaYACMHuMQkKX5NjxoViCE0dLfTAEsRCPs?=
 =?us-ascii?Q?fqIogXUYQ2zTdB1lSB0HCBbBWEBgEwDNnB2gT7lgmEPN1CjcaXnra8H/H9Cr?=
 =?us-ascii?Q?u+9qHr25N9KxUzQy587iPKvUT8hToZpo4br15D55WvpvFWkQXmYLxFxwZg+D?=
 =?us-ascii?Q?hvqnzdAOyTtm3/Fjl52az2dDrX3mNegGL5QupwYAQgSBXaajAYFcgW4mYp0A?=
 =?us-ascii?Q?D2EvYYrXi/7Lm5sRc4pF9LrTjJaX70fqy2KeceSqmPrkft2Hb8re9R/DJ6l/?=
 =?us-ascii?Q?pspF5sfxJQ9rmU/fPmDeRBsgQ87fYUJqZoww7aWibz7D/C1wZBNOHydgHl9O?=
 =?us-ascii?Q?FmjsvCJakZ6w0qoFRI6ldN23RgWJiHNa/hR4KzGN/zqFZYypKPciOGJzHHrP?=
 =?us-ascii?Q?/TB/O8988qev5GsmwOvyt1TAuR9Y0qGkQlYPKeec0gbjR6PCDmzR6NdpXkAx?=
 =?us-ascii?Q?PRySK2X+Whm+aRQp1DBBAYSODt38qt2Ww+uwcuuBIVrzry+YWp0wgJ/NE7ko?=
 =?us-ascii?Q?g7ZNNVzqXMZY6Z/y40uIjbLVJLrJSJN5bW948Zl7iJamac7cVA4qL4T6zhl5?=
 =?us-ascii?Q?pxVSOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tEt3EXz6BHAM0r9QPCfPuFtCWFXcEJ/XfMW/+saOC9o9eeAu/hoBsoMZwc0OCHCj7twS7f+yKVVBJoZg0KZA3Hq0ovsLPUmA/lJ8+PvzBjGLukvTHxbRKrJEqThIJjeoEQYgg9H8RhsA3oajfpqJALRgD4OCJKDhMeILYnryEXSP4yUhH+toA9jiHt2vvT8uI3QHNjWcjDWqXMkjWUkpB/Y34N2/Vu8VM3Rl0hKmyh4bqEAdt8uEbgr26qnQOSEt2AfTGDxhW0R9i/vmlsHzosVB1UUjp0rp042cZNmMz77ATiYDnjzIE8evLXM53yIvc+5fVEdn7q6OSHyG2RmEwehAytcm0v/8mlj5TpnSb3umG/ARf4/FHrkK93fTg8gcFp/Mb3G0J7TCSBoPuFYmEqcf5hlUjl8XxI+MhjV7jqIoJUUmJ6KAeeiPazaw6h25Qml8CAP3sWcnJ7QQdp5kHedL33c/u1lbIvGp+66YPWK9Uz2ICYLaP7m8leprEpRy6rtyPOYSitD30sVKTH29XFmKvtp3j74Lr7Y+MX/3IqczxOKkkI3jxL9uoUtgMFhKqPUG8yQns9kHlFELK35CSB07mYtMP0gFloB3Vm8UTEUbWWTINmEhhd5mPMkiL+yZvm+6CDCqITcXbnzYKyqQBGT7rBkC0SOx+3urbCfJYYCIno8+meF5tLoPKTSZKbhFf+LfB4SWy0psu0c8zlCEh4D2hGZPPy0HQBwHX5qalchMJ3ofTGFo/FAgDKCl/keRrzfmCUEmqrL8PvtmOM6OD3EC7jBAuZbTbG0gfwuTxz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009b35dd-2667-4fac-04ba-08dbc4fb14ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:58:06.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQh1ZHWWc3ioGOrJUx/WkCbaYyHfLKNJO4MIU9MGY1VJRgd65VnEzInTbNqYsTrRp7HryMlwkIwr1v+5Gjk1Tq6ORl30hJI/YRvlqkYEsMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040123
X-Proofpoint-GUID: 2aHLeEOU8bvx9rsgy-5wHKvsELahJdiK
X-Proofpoint-ORIG-GUID: 2aHLeEOU8bvx9rsgy-5wHKvsELahJdiK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

CONFIG_IKCONFIG is really nice, in particular, for debuggers. Interpreting data
structures becomes much easier if you know how the kernel was configured.
However, most distributions end up disabling it because it consumes quite a bit
of kernel memory at runtime when built-in. The result is that debuggers have to
find workarounds, like checking for the existence of symbols which would only be
present on certain configurations. However, this isn't always possible.

Building CONFIG_IKCONFIG=m is supposed to address this: users get the choice to
load the module if they want it, and if not, the .ko is there so that a tool
could read it with logic like "scripts/extract-ikconfig". In practice, this
leads to a few issues. First, many distributions still end up disabling this
option, and second, debuggers are more and more frequently relying on "build ID"
to fetch the corresponding debug information. This means that they may not have
the entire debuginfo package containing configs.ko - they only have the vmlinux
and modules corresponding to what was actually loaded in the kernel. So we are
once again stuck with expecting users to load a module containing a blob of data
that can't be paged out.

I'd like to propose an alternative, which I named CONFIG_DEBUG_INFO_IKCONFIG.
When IKCONFIG is not built-in, this adds the gzipped kernel configuration to a
new section on the vmlinux file: .debug_linux_ikconfig. Since it is named with
the ".debug" prefix, it is stripped out of any bootable images, but remains in
the debug info vmlinux file. It can still be used with scripts/extract-ikconfig.
But now, debuggers can hope to find configuration information automatically,
without asking users to dedicate runtime memory to holding this information.

The hope is that this will be enabled by most distributions since it has no
runtime cost and a very minimal cost for debuginfo (which is usually on the
order of hundreds of megabytes, not a few tens of kilobytes).

Thanks,
Stephen

Stephen Brennan (1):
  kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG

 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  1 +
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 14 ++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 kernel/configs-debug.S

-- 
2.39.3

