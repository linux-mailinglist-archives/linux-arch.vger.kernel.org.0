Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1F609E0D
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJXJbc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJXJba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 05:31:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041D543E7;
        Mon, 24 Oct 2022 02:31:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O93mmm000552;
        Mon, 24 Oct 2022 09:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RTUM7GyNHBkrWqQSWyP2/4hOOUzOHvE/t9aUWCGnarg=;
 b=3T6gUy4FOUs8bDpma3H9BjVwiMciOjQx6zux4CJ/QTMOZlnJR3SH185dBLPQ2aozpkBv
 HGmUmE9K130FPWcFayi6uccH7ox3L70AG8ExsA5J6sc5eCbysakbQxzwUJkROX9bhbPd
 BGGqMNhYTObfjieASJQ7ojJmKMNsviObznez3/XVLjpNtT2VxWx8y9rcisLeXeFEHc7V
 RQUe2pABccr4OUMQA2AP5isXFG+I1Is3VS3pbn3fa287b4BdJNSK8xwmiC5ik4JN91uq
 0SRU7bVltSyw3rmswGaGq28s6j0ZgmEqfNg5TUfPBON/0KSMIVQnlqk0wuYN2q8HNIAh kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdu62k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:30:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29O8bT9P032319;
        Mon, 24 Oct 2022 09:30:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3qstj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXoi6rNldoCeloW24ZFH6o6WRrDPb8IU04PEzjz+JmWbZH/xQVQIypweIVe9ami6qrBHuszBP/AtuJFQaeYPjxTudHTsyDbJpTQW8OjPxQMiccMVUQWpj7qzaHO0mYFR4Sw/1Ii1fQ0K35isOFZtzS6I8v+9caDSq97F3PzOWFvMmV2fX9Z1W378vzDPw3AZaeZOfXrqX4uJRKvwXYttc1BOkmvERLF8tSD0AvYY1WCJDjCoAJzw7JI2RbdDSZTaPqSzXMqHrAQ0m5H284RiHoHu8hMHzukiTiWy7lxL+GTa16z2B7/z/XwUhc0wiJqzpju/Ilj3wO5N6ZH500cRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTUM7GyNHBkrWqQSWyP2/4hOOUzOHvE/t9aUWCGnarg=;
 b=WS6P7f6Gw/BLL+UnznA1zYhF6qo6kzdzBCZbCUD7gSKeVn4D/gPb20zS2/PeHMgNhemXwFBiBFwcdw3fuSyyuk4PVKU1YE3tPoGZvgye9diigWXuiqv60OeFRnlk+5+6uj9d9DbhhmuJit7CBbIImTVBn9i3MSTjQ+FPUD+Rq6sFpLXp/3utAQTw0h/3DnnqbfHkQPMSEUEJzYNIM8LMO01+Vq/3LbPblbo6AaJSrmGmIIWtdeS9RqEz/etKEvxQ6n8JDx7eJcNWSDAByapGXEFcAX7kJZReinemvLrSVShd+6J6+MnrLn+9l4gMkIR1+PhvX/xADJbM11v5PQAbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTUM7GyNHBkrWqQSWyP2/4hOOUzOHvE/t9aUWCGnarg=;
 b=IoSS+tcLUSeqFRch8sfPQbYIutdSk9rL4sgBNKI5egqSitwbti5PSpZFfidNFifplsVrK8l0VrPLDxyOVWhq3Kd/BiRIKGF82oXQjcur72Cl9tR56U5v2lB9cgadw68bNwt7iWVEi1DcyJtixzEgp2WfdLKjN1i6AF5tmXE1q2s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4906.namprd10.prod.outlook.com
 (2603:10b6:610:c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 09:30:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 24 Oct 2022
 09:30:42 +0000
Date:   Mon, 24 Oct 2022 12:30:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <Y1ZbI4IzAOaNwhoD@kadam>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <Y1ZZyP4ZRBIbv+Kg@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZZyP4ZRBIbv+Kg@kili>
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e7d3fd-7b17-4177-a2b1-08dab5a26bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1GIo55OFcRSrsl7iS9N+WBMkQgJOuWswLCQUahxyfgMwvJ77kvmoKqF7nirrUk1e3IOCldqOFSAew2ViwINK0DQfB+QJ/iNDq7mVridxlxkvd8gywidsIrO7rVBNF1Sdu6a3ozoJ9Ca2oCw2jLAK7OpYe1+RMHZ20Bpvp9QiGYelqDBdmxzOYDhx+XAVds4/Xe+bfZBtV8xmjk/0eoCZ5lZ9vd1GOHPmtGptMCdP8Lhg83Wl39HQnyNRofZCpNHX0TjxkU121JPX9ejv3CE2qjgBjZaF+SUT68KtqGlTZUr8fY7WmUMuQdFnvmt6kZonh7n9l09StI0fHvBtEZtjMR+4MdaJ8x02JPJ6k77wSFYInq2/e2i0RwKtwkGmCnilTpQaJRZ5scZrAkdKqUnF0MNH67LxRSF+ZY7UXCgd6tG3CnqfexVK2UytQ15IuFyziQSvWG7nawsyL4eXfSIRFZYzS24NBnZSUa2hQiHzC7XyczFtLSPLs1EpGnNiTNyJLw0oZbku3rmvzPmLgp0oKOw+DVuqpUXCOPD+Dwo6ZuQ3ucy5w6/aotlZrmUX6CfButQvT63A0ueKIP5PqCcDUvuboLrS1dJwlA2cYQHtLtbVNPj3h2skMnqTeKYxiH6kwkT1faDopVpMwFjf/ZYxTtjJqThtjZ9hr5AzWKOfLREqD3865faCunQOPOBujARH+Jw3pXP9XbiyOrvUwKM8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(8676002)(6666004)(2906002)(83380400001)(33716001)(4326008)(478600001)(6486002)(44832011)(54906003)(9686003)(316002)(6512007)(26005)(6916009)(8936002)(41300700001)(86362001)(38100700002)(7416002)(5660300002)(6506007)(186003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jiaLKeu8+dR8t/gXnTdxtt2YQQcxdlKBZa4b0V8FBlreeqGDwTAgmeSmYRQT?=
 =?us-ascii?Q?KsGixzii4gzpmqodAjL6VaOYzcQRrbXmYunjj8jii1buDaVEttm/l6jsku/T?=
 =?us-ascii?Q?5Lw1qGhrV0K6GnO0IhyfdRfr0/rJdB+yGfKcC+UWkRCVy76hZ+rlFcKO6KoN?=
 =?us-ascii?Q?G9ebUxil8e5hW96Uftr67RdOVgzDCNxysD9YErQpkXhgJvOWMWihEk/nq805?=
 =?us-ascii?Q?Dn39cT+d0Lr//C5Sp3OXwWMazZcKmVXjAkx+1R39ZNfTnR1uL1BNYFJTyA8b?=
 =?us-ascii?Q?br9jUIYTQZO9DFa3pYMsPCsW63s9mjdI8LeDr6tKFKtNstNvknB4tIKpMPbA?=
 =?us-ascii?Q?B6Nm3JlCQ0wxvbEbC7aVZmomX7eC+g5J5ENHpAoNQyyuQOlhvM5vUBDDlijf?=
 =?us-ascii?Q?JrB+/cjrb/lVrTJ5jpP6degHKK9d+Ab3t+x1QnO11uTRWpUOto411px95NYL?=
 =?us-ascii?Q?F5jY2y7ucfp/ADyObd52eE2ZbdvBL8HW3CJrN3J2YrJVUIm2fYUtELPKgQZu?=
 =?us-ascii?Q?AJ/ZvtYXY63PsG8K5SlWQYcVAUfQQhhr0RNf0+z2iF4aLJ+MxkfXaV//FUNL?=
 =?us-ascii?Q?id6/X5y7Up4h6vmIcZYUYjQ8TaTji9Fe7yRkkBkc7sgoC5O2WhK0Yl473x2q?=
 =?us-ascii?Q?OHvS+e3nvgXtt2kKIKytHccTN98tk4pGZBpri6JYu5Nj427pYCbe9cZdlYmo?=
 =?us-ascii?Q?5jh+jsvVtYjydLOawrtGVpEaGUOObebwDMMFqExPAxt1J9U7F19nGkljBVs7?=
 =?us-ascii?Q?MXwZdI11X7WpegmLtyF1TvEa/iS5/UyH+bEQS41VzAcvjTQ51KqXqGDJAObO?=
 =?us-ascii?Q?LhZri1DZB3Bk1aas+QGkNiiLajxNFmY2AFheACHYHNyETnCLPLp5c3jdmj5Q?=
 =?us-ascii?Q?MHJ2QACwKWqgwtwGoiVEHxnASszamv0cozCM8DJm9M0ScwI4KCKamucYFYn6?=
 =?us-ascii?Q?a9HCUkbLMtTu9zGqj2FCY805hbcF4qnze7jlspjOWNX2Fxq3HbxMzXjDk2RZ?=
 =?us-ascii?Q?HQ1b2Y3TZz3Gfs3cfs2RtCtJV7vniw55AtBTiLwy2UX6qVQs57wKd4r0jRSD?=
 =?us-ascii?Q?GTcpe8oiK0UqgwoCeqb5jC+cFksIJh+PPlZeWRQqDuoYYZDYqbz1HiRNnuX4?=
 =?us-ascii?Q?LPqo1UUEu/50Hlq8JT0n//b+7vJ839mlD0C1cbxX7pwJAf4DKeMcgXRXT0Ti?=
 =?us-ascii?Q?kHEttSvjKDWSoP0K1T4/j3elXddT10C6dMIOYDxYZefBA/DH48GfR5/2C07X?=
 =?us-ascii?Q?73qd4UyCxRlJ/sHRkRiRenpEJ+P9JhhRRBRA/64Fu1nS6ZCx5ZyWkPwM320F?=
 =?us-ascii?Q?ddx0psj5dtaszf11LdhKvgQBsqqKXynZZGh+RVk4HBbDxTZ/nChLP+UUlD4+?=
 =?us-ascii?Q?ZZUCW+h5U8X8qdyPvF/3BCVisDPFjRRt4mLRSPmrGqqNjc0hbAJNRwuBO0Z2?=
 =?us-ascii?Q?GuZA0QM2ixHhqvidF/6TRoEUFu3U7voaifnxNhneYDZntO+KFiXElDJVmU9m?=
 =?us-ascii?Q?7WHJNA9R0J8Dmsl864mG8SxhenjsFSaEqQPoMlTEDth4O/M7657BkgpIAYNg?=
 =?us-ascii?Q?ysWvOPC/olXTiTkqW7mUgc+hAcSn3V46kHS1VMoZYUpPTm2307QOTioIVvtZ?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e7d3fd-7b17-4177-a2b1-08dab5a26bb1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:30:42.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Smr/m2vjLk1nE6jWzNGSKXR/g4s8PQRaMNr37Xa/0IJ2CTRkbdVJRmZnMGXsLUZIH59liAuKWTgLa1/dp2KUsntCHCdfq41RdX00zo/FoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210240059
X-Proofpoint-GUID: 91KPdYHu9i3tGZbEPczHf2BTBSbc51BV
X-Proofpoint-ORIG-GUID: 91KPdYHu9i3tGZbEPczHf2BTBSbc51BV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 12:24:24PM +0300, Dan Carpenter wrote:
> On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> > Recently, some compile-time checking I added to the clamp_t family of
> > functions triggered a build error when a poorly written driver was
> > compiled on ARM, because the driver assumed that the naked `char` type
> > is signed, but ARM treats it as unsigned, and the C standard says it's
> > architecture-dependent.
> > 
> > I doubt this particular driver is the only instance in which
> > unsuspecting authors make assumptions about `char` with no `signed` or
> > `unsigned` specifier. We were lucky enough this time that that driver
> > used `clamp_t(char, negative_value, positive_value)`, so the new
> > checking code found it, and I've sent a patch to fix it, but there are
> > likely other places lurking that won't be so easily unearthed.
> > 
> > So let's just eliminate this particular variety of heisensign bugs
> > entirely. Set `-funsigned-char` globally, so that gcc makes the type
> > unsigned on all architectures.
> > 
> > This will break things in some places and fix things in others, so this
> > will likely cause a bit of churn while reconciling the type misuse.
> > 
> 
> This is a very daring change and obviously is going to introduce bugs.
> It might be better to create a static checker rule that says "char"
> without explicit signedness can only be used for strings.
> 
> arch/parisc/kernel/drivers.c:337 print_hwpath() warn: impossible condition '(path->bc[i] == -1) => (0-255 == (-1))'
> arch/parisc/kernel/drivers.c:410 setup_bus_id() warn: impossible condition '(path.bc[i] == -1) => (0-255 == (-1))'
> arch/parisc/kernel/drivers.c:486 create_parisc_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
> arch/parisc/kernel/drivers.c:759 hwpath_to_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
> drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: assigning (-9) to unsigned variable 'tm'
> drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: we never enter this loop
> drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned
> drivers/net/wireless/cisco/airo.c:5316 proc_wepkey_on_close() warn: assigning (-16) to unsigned variable 'key[i / 3]'
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9415 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'idx0'
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9470 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'perr'
> drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
> sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout() warn: signedness bug returning '(-22)'
> sound/pci/au88x0/au88x0_core.c:2046 vortex_adb_checkinout() warn: signedness bug returning '(-12)'
> sound/pci/au88x0/au88x0_core.c:2125 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, (0), en, 0)' is unsigned
> sound/pci/au88x0/au88x0_core.c:2170 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, stream->resources, en, 4)' is unsigned
> sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
> sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned

Here are some more:

drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9472 rt2800_iq_search() warn: impossible condition '(gerr < -7) => (0-255 < (-7))'
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9476 rt2800_iq_search() warn: impossible condition '(perr < -31) => (0-255 < (-31))'
drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'

This might be interesting for backports if everyone starts to rely on
the fact that char is unsigned as the PPC people currently do.

regards,
dan carpenter

