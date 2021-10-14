Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E6842DF00
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhJNQSe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 12:18:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhJNQSe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 12:18:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EFa2Um029664;
        Thu, 14 Oct 2021 16:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZMDPvgZCnwoVrQFn+QcO7FFTH7Rn51F0sFhzQc/f8A8=;
 b=qFHREW/9Z+AheZ0xIt4NKE1fx20fSYCDFVU/s2ayBpUEy73/qwRbzwslE0pHwVeNOpti
 WIPNiuTo+dcx65Yn+EmM6xhOw1Sy2dNY+FJFEMzV5V00ngXv2bSFUkq5e2EKRODnPMwW
 6NEQsp5eUABMScYAF8N/oTHbYgd4Lyh9b5epbockttbzd2wLb9qd0EMutrlkhewZvIQX
 9SJ4901Xs1R/sbRv0yLWjsR590pvdZm9ULNm9UoWuwOgheAn8nkSusMmI4xN22wEIWh9
 /5vT9RJizSSO/5lDD/6oAZQ8rwMOpPLXrvGwAn6otU6rcGsy2qXIp5wLjY/0e5IlZZNl fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bphhuakgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 16:15:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19EGEdD4166843;
        Thu, 14 Oct 2021 16:15:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 3bkyxvh2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 16:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPi03+BEi+czZMpcqAkePu6ycvoc79lp7n0bPzczzdUdtMlPFFwoQYOVOMfcfAzweCWku1NrDF6CJN5pIvGGH2J1uIby1KMKMnefhPXcIgjO7k5QmuUvawIQKTJ1eSO7P9bgYqcgL1Z7683B6GCifPE7td0or+aBiUqTzmysjoQiXU32iWWP0KRVExgoUu/VAmb4wV9D5fjs10gDjYZMHbFuKFbqPK/VSTmSaQl4QEQgdA0R0AKeKKgeNqqYdcG0QQ9zThzQv2d1RrLxYbj/3ZHDLbxMXvBWpvGe9r2buWV8DbgA0ThyOq8JVLSd7KO3p5JsQs2HaJgE/umSf0CHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMDPvgZCnwoVrQFn+QcO7FFTH7Rn51F0sFhzQc/f8A8=;
 b=MAKgS1aWKRuclZYe0EG7ULUnbT+OJ3jlr2YKGDlkaJ3Taac5oRURrI5lRB4lwgzfkZE1pMteweXMDy9pdqs8+srHOP7qX1CTjLIWqUulgRmvpwtSbDUdN7AnYrk67AoO0O3d+tLzK1rytlHr4y21JGGfs873pWURaDcllge3mtr64uQb63+UAmmFvNLJJWYwn5nry/Pu3sfosU0NC5zLbuMXtXqWf5Oxw7MSoXDeJyzXhFgpWnUdAzBy7BwHnbYca9tBMbr5sptopWBNzBt1voWTCJHSZ+mEkaTco4ko8tuYMbVvy6QTocO1tflRURPhAb07lk833/HhQLoRbApnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMDPvgZCnwoVrQFn+QcO7FFTH7Rn51F0sFhzQc/f8A8=;
 b=QVyzmnnthddlhAwXMtztwbnfE1hbAiRBM/gSWRfmxI8RQOyQR9Lp7Vctc5B9blBFPrpMWOJR0LsNK2p6wkuMWiLnLljY3DduQUER23CDULwV/76lFgdNmDXJkj6EclKkUfvJmBrijdClFdV1wyF+XMS9fp1Aoj1UTGRqnUDK+Kw=
Received: from DM6PR10MB3018.namprd10.prod.outlook.com (2603:10b6:5:6d::27) by
 DM6PR10MB2810.namprd10.prod.outlook.com (2603:10b6:5:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Thu, 14 Oct 2021 16:15:20 +0000
Received: from DM6PR10MB3018.namprd10.prod.outlook.com
 ([fe80::8d95:1612:fb86:6c68]) by DM6PR10MB3018.namprd10.prod.outlook.com
 ([fe80::8d95:1612:fb86:6c68%7]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 16:15:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v22 21/28] mm: Re-introduce vm_flags to do_mmap()
Thread-Topic: [PATCH v22 21/28] mm: Re-introduce vm_flags to do_mmap()
Thread-Index: AQHXFfkGAPz+JV8zwUWN0ORL7/sgQavUAWIA
Date:   Thu, 14 Oct 2021 16:15:20 +0000
Message-ID: <20211014161512.nhpxd6lyjx3c5jjr@revolver>
References: <20210310220046.15866-1-yu-cheng.yu@intel.com>
 <20210310220046.15866-22-yu-cheng.yu@intel.com>
In-Reply-To: <20210310220046.15866-22-yu-cheng.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b59ee20-fd0d-442b-aa14-08d98f2dd1d2
x-ms-traffictypediagnostic: DM6PR10MB2810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB28109F524F680A1564FAC706FDB89@DM6PR10MB2810.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uoomk0/M4gG1zFHsShShuEE6XX7nF9xSQQKGp0XCwzipps+x52YGaaskdMfo2FMjAx2AGpYATnxjX9fcdlHlJvnF8ghYd20zQLwmmINpBO5bvhPADaEzeK2t126nWGA/oGFJCQ+JIqhGg+8NfWP9Reml9HbeZ9xjQ8uW//7CoRGxoV7dKnaiVUcc5NRIVrYZEYzd8eDpcqBnq4e589OLwRYWA3U3KWh83/JKuxxzr7HGnqjTPhaJxZ6DOYjEThH4wTEZSXECzdkMlYVu3QYAHWdIsgGfdscbe2kc9UbdQgchVKaleyRQdjxJrztD4QSrOYdlrAwvpeQZDcOBzcXQSnAmEXqS+TIZl8FPD99YF+echaOfro5WXM7LJCUDatp3XURDncK1wUvvIuZa3PkD9XRMazQ1zj9AEAThws8BUAPgs3td4BrlWpdaz2UNrN8NlIww8CBWh4Ex2/97S1suBS+tklMkdadR+A3jyIBreozGhisH80Yq3w0GVh54nzntJBdsVypCl4la2fdbc3N52ZyL45xcaT5+OW9frGyo+ycEb+iMjKxXpVSjjb35utuOMN+n8JXNHoate6IIE8Io/ggmodi11KDBqOPvoGPa+zTwIRFfSQdhgdgUI+ynvWpnEELfXV8cYMdzgPJu9A/1F5EoR/bki7YuqaY1zR2Mrzhg8B0ZBJE7JZ1U2Ee8Rzbt9TI7QuHIBw7D+kDOpWbHgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3018.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38070700005)(44832011)(66946007)(66556008)(66446008)(6512007)(9686003)(54906003)(66476007)(64756008)(86362001)(91956017)(76116006)(186003)(2906002)(6506007)(26005)(508600001)(83380400001)(6916009)(71200400001)(8936002)(4326008)(122000001)(316002)(38100700002)(1076003)(33716001)(6486002)(8676002)(5660300002)(7416002)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kEBAk3UH6yNL9k3iy3K87g3T2e/7QRKNrg0btlNZ3eaym0XOiO8XI10hAjvc?=
 =?us-ascii?Q?1oNDVaytOvx+bQjaQdWMfb4x9aBMPemSd10TvZgNti5LZPp1kZTUL6yQDeMk?=
 =?us-ascii?Q?e/Ud+JO2WEGpZmvnEbUH+XIEbVKPgzFewZKe5DvAzks7IGVBOYXstNxfP/WG?=
 =?us-ascii?Q?Gj23lHQ9rvKW9hF0tQuy2OB2EvfvAmGhAkYpUuj3Ea8YMn7rUXWuFnaBshS6?=
 =?us-ascii?Q?ZZ8Rx/4f1U/ToIVoqU7vWluOpprjB6a1Fag5H+IwMC0EGNFzN0e8Xmakv3NL?=
 =?us-ascii?Q?fU537xGqGkF4oQPnYy8qel8y4h8iZBOUUYWk3wrVfTaEn17CRnXwiLBiDdpq?=
 =?us-ascii?Q?qFJLV/qF+PtuhbMOkpaI131GG3KwGrhyT2sWZ4jd6X3Ehfag5IPIyHaPxOFQ?=
 =?us-ascii?Q?y15Y4FPIr7GAkVVpNX+iZYF3kAiEnOJqrRjgouZTtdD8/4eBe1Rw9Z7v8deB?=
 =?us-ascii?Q?W+1tFj3tSr0myyNFtVh1C6i9l1OyGOYPP0wYJ78MHBb2tAXbMkEfkaPXnD1S?=
 =?us-ascii?Q?IwBbM0vGmnmSG/R936eFcGv1R3crUu4H+nc99Gk1giuSZvF5+BZAy7MTRdNi?=
 =?us-ascii?Q?G24W4uMwekIH6f2exe5Oad8KuoUD8xNTMqeUu6/W1y6edSb+UzPVsA6KsXW9?=
 =?us-ascii?Q?lHnNVEg8PRs9h2hWtjxCRQsUGFNDVRPFqnm1UtI92y4DrF9gdq+K/+Em/7dG?=
 =?us-ascii?Q?u4Y4h0rokCaewkGc+j8M+zfRS2sXjQqqeNOSKxboS91NJPC6Phg6LN35EKC9?=
 =?us-ascii?Q?hJHnYnfK/KdFMEUKSyQCcuKSOCCnWCc4vb4R2ukNbbZTP6sGcWCLBf5vUkai?=
 =?us-ascii?Q?OXrKl5R/kPvocLpbuyeE4Add53bqdD6uSiu/QMhj2ohGYTTy4sdumLE/FdDw?=
 =?us-ascii?Q?dWMAAkGY/M6zx7XDu0MVR+SIa0BaD+/yzn8s9sJTv1vkxiog/wv3rACBpBcp?=
 =?us-ascii?Q?4DS+YrS/nm+eSUbh8VpDfK/kBjm/RpW/0RS2CqiMC8f2IQcqHkou9bubap9n?=
 =?us-ascii?Q?z5MhDlNazA0RnRpaL90DRY3f4SBtZkQtHeCsnHW1VSnedlEd0RbWoPAgpMIm?=
 =?us-ascii?Q?VT0rW0cS5Yj1LXLwKgNr5vunhIhOIjehDml5WjyDKuYeuwKw9ZyyAdHRw1k/?=
 =?us-ascii?Q?oMySSaSc+E6i99H1R5G1f+Dd2XeMJbEqwgR3QN3TmkgnoPdawjn6rntosibF?=
 =?us-ascii?Q?y4ABsrUMSIJa59leWOfrdib7RtJdqsvuSH7HukHPoUltJejUQVWXT9N6J40e?=
 =?us-ascii?Q?XsAnmw+hvT835LL2712z7LbxJ02AzP8K11RIaMtWE70JCQ6B9U0n+oTr8s2M?=
 =?us-ascii?Q?++DzPqyQHRxQruFMnQPd/oiH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74AEF4C5A5934E4DB2A838D971BDABAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3018.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59ee20-fd0d-442b-aa14-08d98f2dd1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 16:15:20.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fglRD360+l0ZHVXlLy+NFglsXI16Eqda8QWSiw2tpEONyMMPznHDsTzHfoS4Fl28+j05IoiJ/cHRA6Q2TcoqRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2810
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110140095
X-Proofpoint-ORIG-GUID: qzZ4k7zHakj-Zx1kFftlMva9NEtQ5Q6t
X-Proofpoint-GUID: qzZ4k7zHakj-Zx1kFftlMva9NEtQ5Q6t
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu <yu-cheng.yu@intel.com> [210310 17:02]:
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
>=20
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap=
_pgoff()").
>=20
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapp=
er
> do_mmap_pgoff().  Instead, make all callers of the wrapper pass a zero
> vm_flags to do_mmap().

In a later patch, PROT_SHSTK is introduced.  do_mmap() already takes the
PROT flags.  Could PROT_SHSTK be used to indicate VM_SHSTK instead of
expanding the arguments passed to do_mmap()?

>=20
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: linux-mm@kvack.org
> ---
>  fs/aio.c           |  2 +-
>  include/linux/mm.h |  3 ++-
>  ipc/shm.c          |  2 +-
>  mm/mmap.c          | 10 +++++-----
>  mm/nommu.c         |  4 ++--
>  mm/util.c          |  2 +-
>  6 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/aio.c b/fs/aio.c
> index 1f32da13d39e..b5d0586209a7 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -529,7 +529,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigne=
d int nr_events)
> =20
>  	ctx->mmap_base =3D do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
>  				 PROT_READ | PROT_WRITE,
> -				 MAP_SHARED, 0, &unused, NULL);
> +				 MAP_SHARED, 0, 0, &unused, NULL);
>  	mmap_write_unlock(mm);
>  	if (IS_ERR((void *)ctx->mmap_base)) {
>  		ctx->mmap_size =3D 0;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e363173f7634..2731889f49c1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2543,7 +2543,8 @@ extern unsigned long mmap_region(struct file *file,=
 unsigned long addr,
>  	struct list_head *uf);
>  extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot, unsigned long flags,
> -	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
> +	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
> +	struct list_head *uf);
>  extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
>  		       struct list_head *uf, bool downgrade);
>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
> diff --git a/ipc/shm.c b/ipc/shm.c
> index febd88daba8c..b6370eb1eaab 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1556,7 +1556,7 @@ long do_shmat(int shmid, char __user *shmaddr, int =
shmflg,
>  			goto invalid;
>  	}
> =20
> -	addr =3D do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
> +	addr =3D do_mmap(file, addr, size, prot, flags, 0, 0, &populate, NULL);
>  	*raddr =3D addr;
>  	err =3D 0;
>  	if (IS_ERR_VALUE(addr))
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ac67882ace2..99077171010b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1401,11 +1401,11 @@ static inline bool file_mmap_ok(struct file *file=
, struct inode *inode,
>   */
>  unsigned long do_mmap(struct file *file, unsigned long addr,
>  			unsigned long len, unsigned long prot,
> -			unsigned long flags, unsigned long pgoff,
> -			unsigned long *populate, struct list_head *uf)
> +			unsigned long flags, vm_flags_t vm_flags,
> +			unsigned long pgoff, unsigned long *populate,
> +			struct list_head *uf)
>  {
>  	struct mm_struct *mm =3D current->mm;
> -	vm_flags_t vm_flags;
>  	int pkey =3D 0;
> =20
>  	*populate =3D 0;
> @@ -1467,7 +1467,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
>  	 * to. we assume access permissions have been handled by the open
>  	 * of the memory object, so we don't do any here.
>  	 */
> -	vm_flags =3D calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> +	vm_flags |=3D calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) =
|
>  			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> =20
>  	if (flags & MAP_LOCKED)
> @@ -3047,7 +3047,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
> =20
>  	file =3D get_file(vma->vm_file);
>  	ret =3D do_mmap(vma->vm_file, start, size,
> -			prot, flags, pgoff, &populate, NULL);
> +			prot, flags, 0, pgoff, &populate, NULL);
>  	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5c9ab799c0e6..9b6f7a1895c2 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1071,6 +1071,7 @@ unsigned long do_mmap(struct file *file,
>  			unsigned long len,
>  			unsigned long prot,
>  			unsigned long flags,
> +			vm_flags_t vm_flags,
>  			unsigned long pgoff,
>  			unsigned long *populate,
>  			struct list_head *uf)
> @@ -1078,7 +1079,6 @@ unsigned long do_mmap(struct file *file,
>  	struct vm_area_struct *vma;
>  	struct vm_region *region;
>  	struct rb_node *rb;
> -	vm_flags_t vm_flags;
>  	unsigned long capabilities, result;
>  	int ret;
> =20
> @@ -1097,7 +1097,7 @@ unsigned long do_mmap(struct file *file,
> =20
>  	/* we've determined that we can make the mapping, now translate what we
>  	 * now know into VMA flags */
> -	vm_flags =3D determine_vm_flags(file, prot, flags, capabilities);
> +	vm_flags |=3D determine_vm_flags(file, prot, flags, capabilities);
> =20
>  	/* we're going to need to record the mapping */
>  	region =3D kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
> diff --git a/mm/util.c b/mm/util.c
> index 54870226cea6..49cbd4400d13 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -516,7 +516,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsign=
ed long addr,
>  	if (!ret) {
>  		if (mmap_write_lock_killable(mm))
>  			return -EINTR;
> -		ret =3D do_mmap(file, addr, len, prot, flag, pgoff, &populate,
> +		ret =3D do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
>  			      &uf);
>  		mmap_write_unlock(mm);
>  		userfaultfd_unmap_complete(mm, &uf);
> --=20
> 2.21.0
>=20
> =
