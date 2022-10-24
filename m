Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F0609DEE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJXJZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJXJZE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 05:25:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE32B184;
        Mon, 24 Oct 2022 02:25:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O93hb8029591;
        Mon, 24 Oct 2022 09:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4q/8OpcF400E/BQB2g8dRklLLXVnXNYFun1psqkRsns=;
 b=v1ZD6XJMNOEXp97vDC3bw9Ei0aWfhnwRoWrQCLLmWd9m7ATGh35UrUBHZp0Y1HKz4p5I
 7FAuRMC1aG+iKrbdcQY5KZzS33FdvQsLspzVR8DqEPJAyppUkTDyGN4WLo8GCT3cIic5
 8ttuoxA/M6BZZl2WGp539uJobJwxVeGdz1VzcyIgzDBYkUe3fZuwysunoylkgQZcL+9h
 oAOYO3OiQFRAwk+IZLQgLExstUMCGJcKYsHoqABHTdgx2ov9ir6xglF8UJwVc3fmGv9i
 cqocn+AZWOPcbIteuZjzeYdfR5BSWqyeLVX6kPlGf0IXpujjq9DUbE16RhP2vpPmOgsE jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2u6wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:24:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29O8bT7f032319;
        Mon, 24 Oct 2022 09:24:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3qp37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 09:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSYPNU1PX9dvYDZlo4MPeiuJ33Wm2dk8LxpvGd5zkC0ik7KD5v8kaFdIXGhhH0nYkBZEtPG+FlAecIMKQD29totbYfoUBAqCvxYwnxJQ8lcNtuCpOdQz5lGeUyjI4cPzozH9xqVlQZ3WMc40WpI2LN0ueRfjBdMWvkV1JU1Hujv3d7yS1WBsFs+5JySW9ET5UdNGTOOuP6lWiTIBT8MkKCIeXDvq9WkMRT/cZ+gtAQgVI+jIaiB6HddRopD7z17i0xzm5vllE3IPAXkzfrEU0I1QWGccNNJMMbV/e0MRWPov8Jot8XOE91NIvv/VI4SObAMNJ2eHA6Iqor4rBwAfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q/8OpcF400E/BQB2g8dRklLLXVnXNYFun1psqkRsns=;
 b=FK8Q++XWq2NbMkngnyfWFqAZNeg54MzTbLVwtkl+iRzx3No2gyqGLMU//DxwFvtomu78fptNkTuj8XQ5/HTeuZY2E46YtBj0iWMjKVFcyScGOoW5nEjkDpui+EBTAZ0y4a5iibSkVHrWKA0Ub7yDPe9FEBbV8LE+EDV0+AI46kqIeLSZPKvtpDuWVCHGUn5G8wlDvoSVkGrm8adtDdBhauo+B2TnEiA3vKVYLrrp+JEpHz78qRcJCkjmTFYWZPNCUNT0dXfuSSmk2B98D1fHYlCSDk8VzFeQHZx569qlO3E8MHev/+4j41AmS41bWvP2Y9uXlqUeicHFHaELDD/jtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q/8OpcF400E/BQB2g8dRklLLXVnXNYFun1psqkRsns=;
 b=kgRO8gOUVKnp2M+liuQq4a/0zo9wYtCcQEQ+n4S/aJo/oAwzvbgcLO7SUSw1XMiCfMy0hCjtRDsEl1ad/KRWZ2WIbbB97YX/KmJWtNaq4F4SzPr4H+TjuksQLW2qzv00WlhqJhle0eOvvtfWd2eAp04/DALi2MxG7NVsFbQW5KA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6266.namprd10.prod.outlook.com
 (2603:10b6:208:3a2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 09:24:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 24 Oct 2022
 09:24:33 +0000
Date:   Mon, 24 Oct 2022 12:24:24 +0300
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
Message-ID: <Y1ZZyP4ZRBIbv+Kg@kili>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019203034.3795710-1-Jason@zx2c4.com>
X-ClientProxiedBy: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 8352fa7f-2b81-489a-0ed0-08dab5a18f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8po7M+h3WVn2KZND4TmqSwrhGmLiSKjzhz6hfDfMyiUuyNLsnl0Zsc1h3fpFeeUHFYowj9sBx6f7xlJMt7088HynZiwrS3JGOHmDq57ZkY+pJ/xnE8U8qC3gEY/yPDBzG5hLsmpQrXHmkM+zxotftXPXNVtSHrqJeWiXlr6Syd/ak7tbrgn6hvPzr8mGGDooYHZAwNZRjoUB86XYm9VCbxZ76YhXSh3r8xR37JiWE0VciNmepwtVzjmC85bTFdkAFIxP9e8TqMZsMKvIvETDuVGIrG4zx5vH+UQKo55lSyOsdLr5+yFnBYKxFTv6XlsyFWHhoCkuWztNTdqtO/bW/w2S2cP9CIERLtCgkA/mU108uP7Qz9AGn4lY/oAJpXA4Psh9b8PeBSxrJgJ/3jonV0QXKc0xtexXVgdxxMR6wq/avduE1OX2Putb0CrjljhdZlcheD1o1jXMknf3FYkOslBqBvEpsVsIgsPnKHnOmCKQF6VODc+PH9sOKxILlP7yOd9Gh7Tyy+cpiIDkPOz19CRY8ekGWdQtcrZOONXAqCL/PZCAXJif5rcdYQaWKthzBT00A04ll37sDdwc988pwh6hWRyKgzKFoxqFod90YUIi5sSO9rXE0mgxwu5mALFB21dcYP77F0epAujRzSWO7k40jYyYoQFfmx4LkKL3I+X139ejnQh8VHu6PvIiBpGdtcN2AZgPVXePQVR4mhamTIDJ+LmGn8No1LkjEodir8ftdYTPnZSsGa+HZR+tXmVz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(44832011)(6486002)(2906002)(33716001)(186003)(478600001)(6916009)(66476007)(66556008)(4326008)(8936002)(8676002)(54906003)(26005)(66946007)(6506007)(6666004)(316002)(41300700001)(6512007)(86362001)(38100700002)(83380400001)(5660300002)(9686003)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zYO3dFcgSd0C8/bCgjfAB/wExeha/8mvduSIGFTNdGaj3a8Yct3S0Q8zAbr?=
 =?us-ascii?Q?ouOiPTISIDLBS334XNjTMJfKg6Nvk7pOux1yOLwhNaHzIDQn8DdejgFiry00?=
 =?us-ascii?Q?tHp1Vn0KYIqXCAGOwjEI+vcqEK5/nAoxdC6MtfrCQ/i9zN8ByN3EAukjeqrf?=
 =?us-ascii?Q?bUUncQfSUCz4PMfMLrySbUOZ4M/O5FARtBX3LSWZG0x2t1kByC7v/NXHBaHE?=
 =?us-ascii?Q?w4DoHeS93aN75P9j8RRoU/HVQa2ZVYykKals9ep40FAzUNhT6wG/iqqJmS4B?=
 =?us-ascii?Q?VDnp/IwBnnjoUxTm6AlgpwgBgelUN5iGjI7j9T6138wC6kn/wIlfTrZ1InV7?=
 =?us-ascii?Q?3Ch50C2AqzY61GSJrlB0wrkGfKdXxMK+wPb/JHCV8UrGbcr0/TaIrG8uQ+pO?=
 =?us-ascii?Q?BK2CnebhrsU169wAMpwK7SpMWP2YU921m5LkGdnUOGS8O7is7sWg9jVRH3aT?=
 =?us-ascii?Q?CVqaR9+NQDrDENzonmFJhke/bxrkirljr/xtOxsr0SSFbcyU0u6Uihpuk/gW?=
 =?us-ascii?Q?qcRDGgOGAWF2+S/dyVCrP7CPWGNtQaM1USxqwZhJ+J8PRzHAKOD/ap3a+XwD?=
 =?us-ascii?Q?Qrp4MsDEc8ycHAT+niG7zdvOwv64aSSPaIzIUEcE0yiBoDtkL+Eu3f6/ojyV?=
 =?us-ascii?Q?eJ2SZ7jRIILqY4bHh0Ujava9Zwd8NJdUZgX5QiWA1FBhzyVBagQnHE3Z4/eP?=
 =?us-ascii?Q?3BTrJ0bVIEFNW9b6izdmEh35wX7v/k3KQFArDGtLWfOMSbwAYDnccW59lg4m?=
 =?us-ascii?Q?GMmDJdtbxY7t9Uk930x68GbqCwDF/NaiMgXEt1fKGSkF7jUL2Izeor0zRhPY?=
 =?us-ascii?Q?d3NllLGF5LOugJGVWqX+1Ihq1Br6nxtna8Mp67hUTM47d55EVl+fYxTw2tUH?=
 =?us-ascii?Q?28D+/jZqLbRCI3p8tjz9fGLGbuNHcsN1TINH4e3q571yLbndHaiph7cecrwv?=
 =?us-ascii?Q?E+p86EAADvqrss8kdBFFw/lI5XeG4KoXP5qjyvuVJ8rgCPrcuZgsk3rkAQvn?=
 =?us-ascii?Q?9nGX3zGx4zfF5rLvSSCYKbN8OOvSuaTiAKW1qfUawGzd3gfRx/MsbTxyH4vp?=
 =?us-ascii?Q?q9/MpZIK9lv65d6zcynzijatPMEGZ5cfTdYckiP/cDG+FllOUdH+NX9Cv28o?=
 =?us-ascii?Q?CFaTVqAFhDU/56zZYhEPAjppPJzL4VLuvM91XpPHxYfqBsfh0N8OKGVgeeum?=
 =?us-ascii?Q?WOzWCldc3zZIKBwfPS679Kyk/bnFu3LZkerAJ6Z9Yz2HohZ5e6iCgag8RvvT?=
 =?us-ascii?Q?4+9TQP+TbyQuGmoRkIC+Pcwk/cqRHv4cEFsZClygzBDXKYXzIoQUK7MiDioA?=
 =?us-ascii?Q?+2V0D5ExtjuSwLutWDhGOTKxRj6B0X2G6TnauliUx+E9CitslJed3slp/6g4?=
 =?us-ascii?Q?lqIJ5IZMSK4/B4gXVVCO0aO7fpDehBcP0AuVH+N9OvViYQh2Z3K6EJJcE1VB?=
 =?us-ascii?Q?DuaOHEsT8wUbiA7JiKPPPN3+cXzCNmr4sEvjrvMl9ZrLVrC2WcClf6EIkfsj?=
 =?us-ascii?Q?vvPWhkgOolvdzaBidXEM8ssdXkbGQXLRE+hQfQFR7N/6uvKfGrjkRzsieht+?=
 =?us-ascii?Q?ceaaQaTXFaDNRzJ3+TCpdoHD0J+sP6VSrub2h340aQBYxva+APKN/SyTRtgP?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352fa7f-2b81-489a-0ed0-08dab5a18f72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:24:32.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwoxkL8DqOo0EsBzbTgBcux53ghy1ko8zn9Y8K385VyTUq4JnqYKPiGVErLi9NmQ+ceWjdxEn0liHz3Vl/6jMnLZ4Hibe15uVCKqoTmwVkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210240059
X-Proofpoint-GUID: 8P6dNtA5XaMdeA9R50g2j2HiDElea7ga
X-Proofpoint-ORIG-GUID: 8P6dNtA5XaMdeA9R50g2j2HiDElea7ga
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> Recently, some compile-time checking I added to the clamp_t family of
> functions triggered a build error when a poorly written driver was
> compiled on ARM, because the driver assumed that the naked `char` type
> is signed, but ARM treats it as unsigned, and the C standard says it's
> architecture-dependent.
> 
> I doubt this particular driver is the only instance in which
> unsuspecting authors make assumptions about `char` with no `signed` or
> `unsigned` specifier. We were lucky enough this time that that driver
> used `clamp_t(char, negative_value, positive_value)`, so the new
> checking code found it, and I've sent a patch to fix it, but there are
> likely other places lurking that won't be so easily unearthed.
> 
> So let's just eliminate this particular variety of heisensign bugs
> entirely. Set `-funsigned-char` globally, so that gcc makes the type
> unsigned on all architectures.
> 
> This will break things in some places and fix things in others, so this
> will likely cause a bit of churn while reconciling the type misuse.
> 

This is a very daring change and obviously is going to introduce bugs.
It might be better to create a static checker rule that says "char"
without explicit signedness can only be used for strings.

arch/parisc/kernel/drivers.c:337 print_hwpath() warn: impossible condition '(path->bc[i] == -1) => (0-255 == (-1))'
arch/parisc/kernel/drivers.c:410 setup_bus_id() warn: impossible condition '(path.bc[i] == -1) => (0-255 == (-1))'
arch/parisc/kernel/drivers.c:486 create_parisc_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
arch/parisc/kernel/drivers.c:759 hwpath_to_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: assigning (-9) to unsigned variable 'tm'
drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: we never enter this loop
drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned
drivers/net/wireless/cisco/airo.c:5316 proc_wepkey_on_close() warn: assigning (-16) to unsigned variable 'key[i / 3]'
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9415 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'idx0'
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9470 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'perr'
drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout() warn: signedness bug returning '(-22)'
sound/pci/au88x0/au88x0_core.c:2046 vortex_adb_checkinout() warn: signedness bug returning '(-12)'
sound/pci/au88x0/au88x0_core.c:2125 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, (0), en, 0)' is unsigned
sound/pci/au88x0/au88x0_core.c:2170 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, stream->resources, en, 4)' is unsigned
sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned

I did not know that ARM had unsigned chars.  I only knew about PPC and
on that arch they use char aggressively so that no one forgets that char
is unsigned.  Changing char to signed would have made people very
annoyed.  :P

regards,
dan carpenter
