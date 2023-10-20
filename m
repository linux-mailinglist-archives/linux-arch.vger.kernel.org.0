Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0927D11E1
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbjJTOwv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjJTOwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 10:52:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691CCF;
        Fri, 20 Oct 2023 07:52:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KD8fF6026381;
        Fri, 20 Oct 2023 14:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=t0VhYViMcE4Ryk0628UFWCMHTXfLXcHwQMtyT+x6qQo=;
 b=gkVUkuVI8kcW8bemEuIUnFrwSCXL1uybuhmO0cLUsVhBoRtdjNSblopJC/gARjfaVCG+
 N/rAd4N5NWSTMKxo2h05no6MK00zhy8Yah94Vbwb818fyH45DTpftf28prAzPHN5lvJZ
 fewkIPbUzehT0YUlHkDmcJbWjFnRTFsw1BISxHQzB1ukNn94O4iCMO63v/T0tsjT8zPz
 ijYp6nlsOYrcHp+XDsVpOQTHHuUMAGIRvpmnLnad0EWBo1TYdSSPapTkcaphfuefgS4E
 m58ebEsO4Dvu9UdZurOmdDbObxkHfXXPKQgVxD15TlsrFpJoPoLwBv2ZFYYpc3/Oa+u6 qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwasyrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 14:52:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KD58Mx004928;
        Fri, 20 Oct 2023 14:52:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw3d9he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 14:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpNP1HO6de5chAVL47yF1Y9UP3y9W4fXDfLKkYa0sxoC3gDvX7IyUpwWZ3ATpi+YHir9k83z5yjvkMk2502dX/vWkW/hLDwTyPpiu5ZW4hkCS0vWOTNlJDJPMSDVGMVeWRE7coWtNpTtG6ounQfDEtocuQxQ/+z9diXoYVuox664UM1OmYsrWRGfsHNd7w+8vcwq2mBKQrqC0WR/MIBcovNU19VA64A5OMmDeA/+gIjMSaQ4tYXTHRSmqldiQi5L7PeMKzznAoZkcXkU/f22xIVsgAM2j7zifxmkgZUoR5vXtc/Eav4Ce50NQSFFib6FdPQsFooeVckO6C+i0SmyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0VhYViMcE4Ryk0628UFWCMHTXfLXcHwQMtyT+x6qQo=;
 b=isgYfmWSPgT5JBGFLnSzj5Vq5yK3AUIH/YWP3DnLJyt+H6287oiJ46zKe6awAqvpZvMrE5jRA2NE5idUv6pCnLrKKkWLZpRdu8p9rQiFnxiVB2oRx4cwKlszTZ5QMG7UwQ/PHZgONhWgn/bUWaCBbcYjdA4YOLiEeEJgsHoitBV4BRm35wz1cEb1yUWH/kgn3MOLyhoQnoDTIlFFLLujpEixCZPaAHjK+CcEBsjIJjMFQk9M0OHEPbxBIDHbbZIayeqzX5YAhP5oeJqScgY0Fi0MkDMt0biSCAdHJS0PuFlKfLIcbWRQ3QLm+JEc9Rpu8wmus/BqMzYqIh+HWaazPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0VhYViMcE4Ryk0628UFWCMHTXfLXcHwQMtyT+x6qQo=;
 b=w7H5FohCb7XX134Tgl+FRYmPukCGgduWZTPPOhJmtfbyC5GLbOdOJuD/CiakT4hQVZV9H8rMg3nuEd3yBraUkkDXeZ4ZNIsL0UJLFtOgRVj1kLKVO71O2bSwUkeFw0+GRt4oi2M6tJh1Ty+eul4CumJA8A+PLqBzi3ybc1PVkzY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Fri, 20 Oct
 2023 14:52:07 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 14:52:07 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Use the acpi_device_is_present() helper in more
 places
Thread-Topic: [PATCH] ACPI: Use the acpi_device_is_present() helper in more
 places
Thread-Index: AQHaA13K3k7G1GqTQ0aLYJjTYn36QrBSwzUA
Date:   Fri, 20 Oct 2023 14:52:07 +0000
Message-ID: <95A91316-0210-41D6-B8E2-4EE958066FFB@oracle.com>
References: <E1qtq2W-00AJ8T-Mm@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qtq2W-00AJ8T-Mm@rmk-PC.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA1PR10MB6832:EE_
x-ms-office365-filtering-correlation-id: ad922a27-49a3-4b01-33fa-08dbd17c21af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrmLfsVsTsEY2yHwvtoom/knmWtxONJT0uQUWqCdlsm2r0odJt9Zp5Vog1paCneebipM5e7gNDv6+5YYB8YC+4Karu2WPAWsWGY1kM+3E7SyYpSeVMNuK6n+vA2jXcIXFnERLIDknxNFRpT6lITt9RqmBpYFtxzSX9gg+EgDzeu9keAgvU9nfO+2sjqKWez6wpTtZEsrr7MepTgvCWpf1mfqMAsXRp0f6swOEhf35zazSc275xmAE7RnueFhOinUuNGplpk+rYfv3aQezRIVMUMgJLM8hgeHmkWuHTzGf5193f+mGqRh2CvpXBWASMa4xb9beAMe2PckIbcGVZXlNi+QJk7uQ/W5n6WQJu1qxA04BWAWKNsmkPgCvb8mYmphfDO61p0I52c53aPnByi/AaNnXzCLycPNBKAl8kSFF9gtr4kiaRUMcHd+TlKBvQigN2qYyx03pAHKlXaIeFL6OPjtZU+fDz9zaexK81ERTebzHt6kbUCOul2SBazXF9DzAKd/PueQxIJuGBDyEK/3T+TQ9o2C4XeqyXw6Nrx9HC3Lz4Ikle6U1onBHHmR4PW++14Zwxeclg03gB3v1LwcJCUWu8g+LRi6ak1TGyqJlSfb2/cNJ12zxROVDQXLh3pLgYgikgsU4jAWgdxFbNvgxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(33656002)(66946007)(316002)(54906003)(76116006)(91956017)(83380400001)(53546011)(6512007)(86362001)(66556008)(122000001)(2616005)(38100700002)(966005)(478600001)(6486002)(6506007)(66476007)(64756008)(66446008)(44832011)(41300700001)(5660300002)(38070700009)(2906002)(7416002)(71200400001)(26005)(8676002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+N/Jxbigrk9Gglx76wCRbMGXUfEtZjIHA/GOLISwsoIFrb+RYje8Z/5DkMWW?=
 =?us-ascii?Q?+BG9mYvYHgCENIf93fMFhsU8KsCLoIT0VjrnIRB6VNneSNlRsT36vsr3fBDi?=
 =?us-ascii?Q?pPUfOKW5rwdb3Vi3yx7WPK2l0su8CVmsSrwIVxqrGkid4qvg7AhbMDNirRM/?=
 =?us-ascii?Q?J7yKBHR9KOs7EGCu9MkpHAuT67+bx1BiHUbMw+baSqW+m8yK6wBfbUaAxZp9?=
 =?us-ascii?Q?srwR34zvRwYEZGKvWwA8RyEuFUkm1znpHMkS6QjtYaj/9f0F4qS4JtSjPR/M?=
 =?us-ascii?Q?jVujFi2suYyGenyjfMZfFn+cadFikv0AFBeqGJOchhSq2WBhHl6Rmg0Vi0Kd?=
 =?us-ascii?Q?Gr7AJ5RcWOCB0+hXhFzY1Q6hV+AzxqVN2BDa6WlOgbvVPYJr4Ol7mgkqg6JJ?=
 =?us-ascii?Q?TZuo8gH/vuNNDau52pFbMbao0K56v0FM+X2d6sm5Pb8bqps0z3hGLP3AE7gf?=
 =?us-ascii?Q?YhpxRfXRwoOv87Pfv2c9gAK4S0/gDkvnXR7iCmB4o6thxYxQKv9vb4f3RRX5?=
 =?us-ascii?Q?On0bvxguUrfDWY6etNaqvFiwW6QJEpo8cQziSfVnqZvCzGJiwJqRJRb5JYrv?=
 =?us-ascii?Q?F3TTZ5Hyr08gupD8qa2NbvReGzIAsVB9wYd9Kz3TR4fG8WgixDDtFxpjKaNM?=
 =?us-ascii?Q?yMfhXuTkNVOWOurdW49fbZo/d4hbSqkW+/AEJCLvZilDjTX+fCMHKJmph7sG?=
 =?us-ascii?Q?Bj4mKgwjervE+WOi1dLEYBJurNsnlebYPdUR0rIE5iPo0HlT0N1cYrnAyXtM?=
 =?us-ascii?Q?fpRMLk4kOMHbNrNPcVb02/l+9/XfBNQxfh6lXMuCGBzbU6+i8slrDpN18ESo?=
 =?us-ascii?Q?tILro9Vo+vf35vE7T5h1cmZn30F7o/SZke4PUHQ2ln5BZVx3OSgP5hQOWY7J?=
 =?us-ascii?Q?pq6e6IipPv97fP9h7TG9ZUBzdc8XRQ/sjBe9/upVKazX762m6TdqhXJSE6/F?=
 =?us-ascii?Q?ePOmkENx3LZc0m4GowdC4I2GdKxcUUOwq3M3WA3XJOTWoGGXENTATcULs7zu?=
 =?us-ascii?Q?Cq4LXYF5HDhOS8VoYuRuFKgP7AOR+BGG/vywdjO2p0JhzK+bnAg60z3hzFnw?=
 =?us-ascii?Q?krEResggDhxqeAsiwhVUnzLtNv2EZiOZUCsx9hYAxk2ExoFPPDwxt3/8lS7k?=
 =?us-ascii?Q?rRWV7Ogm4ExuxR42D14rCwNPahmlzd+pL9vt5azmQRvPx1PyHoHz021PavgB?=
 =?us-ascii?Q?iA7TjG+qTWGX3N2hkf4lHu8QBQ44xC93AifxBmk786dXBDgjRKHXKOqxw0mW?=
 =?us-ascii?Q?r4mqCeWEVWxGsxA9MiQiA/7E2eR/NtZjPUnSHklNkOo+IyjTYgkxbJKntAvE?=
 =?us-ascii?Q?xdrORjk//IuuxjYIRtJcYG/2Zs9/AkKlj+Iy/KP59yltGIcbA3/6gb0FIvnE?=
 =?us-ascii?Q?ARYjh+iXe+mteRd+0NDS6BQZZM6Ug7yMlBrUHt+4e98NffDI73KERZUYR98M?=
 =?us-ascii?Q?AQWOLKFrRPTl3B0cQ4bnO98v2KBGwZ4Rv1TwqGUra3FEdBEOw7x2NQQSmu7B?=
 =?us-ascii?Q?eDhva9hx5etpROpuUaPaZLDlxXIe956VbfoeWksfoKp59GbHBDuvvWdcT2+j?=
 =?us-ascii?Q?e/tloyzGSPZrgvscrG5WQ3zQ1sVjwlnnbj8eYqKK9SFQ4pmgi4QZjTz/C6Fa?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4A7BFDEC0CE0646AAE387D93A9DA6C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?J3I9PC87bK9ZtaMRsGF2rFPVdF7Ps1DSnNCSLSSqenMYapUwCta52ife7l9j?=
 =?us-ascii?Q?TtQoxRQP6Va6CDey2JnTwCyjyC1SUw9S4SKKKMFjnJI++kNhEseM+fAvE8Aw?=
 =?us-ascii?Q?yorV7iSRcH2//YmI3O7ezNfBfrxUSiCbwsGtvgi338c90BoIgmsx9uN/l+1e?=
 =?us-ascii?Q?egIxNJD2ePIvqp9mzh39cp1nC1U9cV05d8rSEFBbzWB15EgM4t0Zrz98+ZVz?=
 =?us-ascii?Q?zkp76upNP+XjRzMfR6lpOVKrTCbrooncRITW/gNt74J07vFERJgHERyhMT03?=
 =?us-ascii?Q?zori5x7k17hxEeiHPXqOUILJE29taLLQkm2ui68cncbSEBv9laSkORnrkKlZ?=
 =?us-ascii?Q?LDJwHn2tOTa6Mrh2AUKYKBCCYIdM8pAy9J0G18ftTrmv9f9v0NURoF7nZJKi?=
 =?us-ascii?Q?dRgmCmKsRe5XL8Sv9WxHWobvbUdWwrtFGsixRiiHtRwTzIBiSsSl6b2SJxdl?=
 =?us-ascii?Q?DsBEznk3cxYJFWz7XjLv+cdhLGWeZVsV6LFxhYoXmlp51TSVrp0W9g4Onzwm?=
 =?us-ascii?Q?MSuWwqUxtngx4CkHj4od1cdH9vX6hvxj4X9fZa4w7u32RKEvxcBQOVYAnP8x?=
 =?us-ascii?Q?tKfwrP5rPIIfNc/Uvb+xuqlVQIYLfcw+tsHoD59ULh6y769BAbKD/qbYExYV?=
 =?us-ascii?Q?3Uls3mmJngqpnLZO87k1Z0cQ5bj7mogDrV9yhbKztg6EuxqCxZd/wz+QM8dy?=
 =?us-ascii?Q?/QkEXtZYbXIivE11iw0+CBaCGotJkX3SiSigjpZbbq7pEDbVvPdFFULa1t73?=
 =?us-ascii?Q?ogvBUrnOOu9mRoWgtWbx107AW5eOQwn15lNCpa6HpI8XpyvMKevtaghUsuDU?=
 =?us-ascii?Q?ZsnCvzpO8R5SENlRXFLXphSZHBKNcVwhZDN2bStKP7HNL/wNv00bpT179idI?=
 =?us-ascii?Q?OOFvC50FEyUXR4Pw7RF22a/L5Nv/NESXCg/E5bgr3JNKF0e4XjcRKEmCN++q?=
 =?us-ascii?Q?uosQaGYbh57i69sw6WWE6uKG6zQLcw0Vd2OZL1/kP/MOzktq/kgvYhOT7pYP?=
 =?us-ascii?Q?2GEU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad922a27-49a3-4b01-33fa-08dbd17c21af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 14:52:07.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WjXGB0LtYniNizzfiOGQ3bhjQRqdFHD0jnxtr/L2sSrm+0C376EC3R3VCZuaPI4HgIt6Oy+HtLofuvLDD3EIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200122
X-Proofpoint-ORIG-GUID: EIWyHLGgmtDrak-aiuc2e57fswLXC6k9
X-Proofpoint-GUID: EIWyHLGgmtDrak-aiuc2e57fswLXC6k9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Russell,

> On 20 Oct 2023, at 13:59, Russell King <rmk+kernel@armlinux.org.uk> wrote=
:
>=20
> From: James Morse <james.morse@arm.com>
>=20
> acpi_device_is_present() checks the present or functional bits
> from the cached copy of _STA.
>=20
> A few places open-code this check. Use the helper instead to
> improve readability.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Jonathan Cameron suggests "Pull this one out and send it upstream in
> advance of the rest" so let's do that. See
> https://lore.kernel.org/r/20230914130455.00004434@Huawei.com/
>=20
> So, let's get this upstream to reduce the number of outstanding patches
> for aarch64 vcpu hotplug.
>=20
> drivers/acpi/scan.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee..ed01e19514ef 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device =
*adev)
> int error;
>=20
> acpi_bus_get_status(adev);
> - if (adev->status.present || adev->status.functional) {
> + if (acpi_device_is_present(adev)) {
> /*
> * This function is only called for device objects for which
> * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *ad=
ev, void *not_used)
> int error;
>=20
> acpi_bus_get_status(adev);
> - if (!(adev->status.present || adev->status.functional)) {
> + if (!acpi_device_is_present(adev)) {

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

Thank you

Miguel

> acpi_scan_device_not_present(adev);
> return 0;
> }
> --=20
> 2.30.2
>=20
>=20

