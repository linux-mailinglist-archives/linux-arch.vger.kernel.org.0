Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379483049A5
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbhAZFZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbhAZBbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 20:31:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDCAC061225;
        Mon, 25 Jan 2021 16:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzS+diy68QzL0F/aiNcG2SPrdE/+uRSNO9GA4W8sXDVYgHb78PEgvpmQ8ab6HxdnAjo9N9nTOQT/vvtnkob5peqrnv76h99KyJaWJavsOB+0dGEc9ovR6br/m7l1nU7tAyC8hnYWG9Q8/Qctat+AAmXhRjFAT76vyjIVyuSHcKl+2lLyft1up7M9tUxQgESCzfQBIyVQIZfQgkda66okm3FrRWEtQ0u9vcEElomD7AKz/XOIKGX9wD9GAf2hsXzCjYTbrWc+SAJUBEZurNM4uf6eR+iv5JAE9RQeR0kZVoBUGkgW0/uWqKLuKHQOei/zwi9m944iY2++g7i75Dai9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGyEhyhpg6Xu7fwYnqUNzwS4fJprTOzBU9CnQeIGrjk=;
 b=aGumx1SJbBwvpFPVX9N0KnmVHY+WqOt43VFnWWub6clO/pU5b9IoIiT7uKC895i4rH8wqCJhU71OsN0b6sTrfYvV5j1sq6MzkUooJxB/XP2NNTMQLIDrinq/yGTS326/DngJNQT+YTc0OCHnRCBv6oqvtZC6egSdobaMmHO2tEnFx7m0yn501AAaaibIZmy2oEHNiTWiD5nzu+pX8E7Lg6ZUU6iGQW+oI807fClOEdk3MmmWLkLpsdvCTwwdv0HnUVza4zbgE//uGjnlLGggE1qWCT8RePbN04cZKl2LB9bLuT514qxKTbG2Nt5rTm3714mIU1vYYHHzTiDJquyrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGyEhyhpg6Xu7fwYnqUNzwS4fJprTOzBU9CnQeIGrjk=;
 b=Oeu3eUF8qV0wWl27aPbiceRvsLauW0ZpfHXlhOKtXchPnBlIPDAbkmyutEY26emyBK9rQst2CB5taexrxOmow1/xeMdudhZQwY3N27V1m+vQjZmg8eNP5jy2wCiosQsJ2525GxCXbZfwYbzjBxATdFfvXT6vACfEUPyMvBur3YI=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Tue, 26 Jan 2021 00:25:27 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:25:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 01/16] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Thread-Topic: [PATCH v5 01/16] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Thread-Index: AQHW7yPwfLyUlDpBGUOgcxvPWRvy2qo5FQEg
Date:   Tue, 26 Jan 2021 00:25:27 +0000
Message-ID: <MWHPR21MB15939F8E462F6148F1882335D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-2-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-2-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:25:24Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=994d2267-3a17-40c7-b208-1675a73de679;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce052b7f-3d9b-427f-8b0d-08d8c190e186
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0862FAB0F54C4FE98B228768D7BC9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:261;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1zBOk5Cch2Q0fgZ88pzHfv8FPZ2tRZFBwxk6z6rnDgUitmEcOuWD/ADIdpbhpTKsGXmo9UOrfIBaxDZBxqVBwc4VH3mhkQrCKKHPiZnbwV6p7QMHHQAL67SfkpuzRGj89G0+dFlZPKVOfXX47aFsL3POO62lFORuLJJX62jgDZxjMBi1JtDDgZI/SxcMsrw8kSlqhaD3eX0QdNHYowVJSlxCYebSq1cUm9JzQkp62QBTqjJeZDTvG7G0uVsLLIeuAPrTYcXqeoYcY9tuupwTm13qF0eGRGNxyREnI/AB4VN2ktHmulfbzItMwadQeiiO2uYAIcWr6gAQn7hicBQ79SzyxatNMkRayAxArGG+67NKkRhQZQAhqIeywveGzB6GDIfZ3bUiDvnUUbw1e6q2aHn3DOsFkZjFbxpsm/JuiwdlQ5BeSIEiz1CEY3XEAlPIeDJQ8UBKZvtWZRCj50WuxLl7mUc/fxK/IFDRVR4gy2qluoGAQ4VDBgYVgJs71N55rtctXGsWrtJNwnrNAwxjiuvk5Hno3CapbwI6GpOBMiCxqzINbEwcNqR5KyhfHXj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(83380400001)(7696005)(66556008)(76116006)(8936002)(9686003)(8676002)(66946007)(86362001)(66446008)(64756008)(82960400001)(82950400001)(66476007)(55016002)(8990500004)(10290500003)(33656002)(4744005)(71200400001)(5660300002)(316002)(478600001)(4326008)(26005)(6506007)(52536014)(2906002)(186003)(54906003)(110136005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5f99lt+LuFS+Jkw0yPMMIszX6VjbJS0iQfPs0PYVT/WjYzua5ewWNd1pNJFe?=
 =?us-ascii?Q?ZVTxfQVwncQPRInu5aUF3EcYs3AllZl71TBPqHzCdc2O96Kj77AXOvvTN17r?=
 =?us-ascii?Q?5zxS+MpOVp2ee+5SiJaicsXUCscwcLT5iTycWqA+Jn3X3fzF/I3hBr7T7NOz?=
 =?us-ascii?Q?JL4p0EMgcSp4f/vwovJOAeY0EZlPrAuycHvODQRfEAyGf+GbuQ81WZdEn919?=
 =?us-ascii?Q?yRjrZ1VEzvlh3Pj1zZX97KrqyOPKClkpOD0EIlYGnCdzav7Qk4esDAWGG4+S?=
 =?us-ascii?Q?I1VCMsUEQD5XOU2ffbUzVbJ5kj9XWaN0GmzT9adqh+ZvS01oPdPXHfD91XEr?=
 =?us-ascii?Q?k9vrF6BRJbxEuLcGfSdIx/Vju+0+6MLcuVEz7hCAsvsFrukx01LK9jcp+23i?=
 =?us-ascii?Q?dIThhFmqBQoRyxVTeH+Qu9beU9QzG6TzKTOZ1BG2sTIobmZArTE+F8NR6Z2L?=
 =?us-ascii?Q?N3QsqVjXU3OZSGCDKf7SgJxFVePIITrDTFLgCsbw29tLmMt4lad81X8vDJYQ?=
 =?us-ascii?Q?J6yQp09TC+TX/4kwk6nHEkhOJyRBrIRN+/msoLo1HqVWe5DW7B7wTIwG11CL?=
 =?us-ascii?Q?xjKnqgvC7u/cOGO9RsCeSPEQ/xRx0Sf7jyHVCgy7FVaP3Pfz7kTo9X7Rclv+?=
 =?us-ascii?Q?EcLrRREOiYaQPkM0oyquVEsQFBNbwYBHjsP6gImF7Yly9c4M5yFzovgz+UUO?=
 =?us-ascii?Q?i5PRciy8/ZnLHyAL00S6dsJ4Z07ivXWGZeBirecc+aG3aWlZ8bUPRS6uOfWF?=
 =?us-ascii?Q?qcsdkn2nFNqLRU5QukuhBSThHXGr7Ox8f7zInxLul7xE3tbkhmH7rJ6zxO4h?=
 =?us-ascii?Q?2jdDrpAlbjGhdatTKM0xZs1vkR0e5dGqAXAv4zUituuhelqXU72SIqKflJze?=
 =?us-ascii?Q?HxY3Byo65I9BMnbHJ4P0m8uwCLBGT8fZ/48+871vFy7e7J/FiJx+68+OTDjL?=
 =?us-ascii?Q?RaccZxskuYK/AHNss0WxqUsL+Cpprkj8HamgN8ocJFSSiGvfnyyHaSIm1fMX?=
 =?us-ascii?Q?kikD3GplLCQV6y1ZXYY4AnJYNu2DjUXtKRTeQr6YWdZLojSttR6uNWCF6yP5?=
 =?us-ascii?Q?spcddz0O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce052b7f-3d9b-427f-8b0d-08d8c190e186
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:25:27.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSl2tSniivxX55E7qRdJLI3ZK/ZS81QkNkaIVS2fLVpUmPCBT0Bw/SpRsk+hC1ruyNF82Y4eKmwmQece30bscsX2KjQ1RNY/xOoaQ//9scU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> This makes the name match Hyper-V TLFS.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT				BIT(7)
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_CPU_MANAGEMENT			BIT(12)
>=20
>=20
>  /*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

