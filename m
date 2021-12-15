Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEB475BA1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhLOPOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 10:14:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52714 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243848AbhLOPOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 10:14:47 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFEKAso010344;
        Wed, 15 Dec 2021 15:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5/9fRCJVJdli2kfWBrjXstvYkMjKzl7NVNaNA5p8z4Y=;
 b=QOs/YOWl+5zmgmlGxtqj6Pt02m+CExnzw7XC17m3pbCrkSHTiO8k/WN+YFan7E8QzF21
 Jqynxz/82iiFxcBXpnHEYAmrctZl7yDtCUsEi4q2PWwW/DUrUSDWjZ/t2wPUHVgDPpg3
 JvD/21QWVXFvZhRs7bqsUs4ZIIeN9CrX5vRcg/3eMhrV6WjojWM+yHuNXftxz0O4a7lP
 GbCg8a+mrG4fcvrDEO7cvGmcvu4WRBJpSsEPFfSS6vSa6v88aIu5kWRFEDN8M+RawqQj
 Wveb9pe+ScJSgszwcF3TrM1tResqFIxsiPBrDDM34OUMmWa+KHOCsAq9xllG2UcKoV99 tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5akevja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 15:13:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFFAW2n009728;
        Wed, 15 Dec 2021 15:13:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3cxmrbytek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 15:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A29Nm8SuWPPRk5KMlm/PTmAoK0AtwMOOZbpvE9PbAeO+bCN+Osl2nyMq/7UEOPHinTEr7mipjBMG+qMW3cZCkOyhCQ7oel7Pi6+mdrBIBfa6SEfQ5K6UekB0ti4eXxkZKl96snHlcEuIrM3zyo1DIOY2AsiUttNJGmIzY3tXHDothmW3k4DEZwAmGDhyahbU1zYho7nLJZPhLQDYhTAnQ0MSuBHZtSBeYDlwY4Lv+zR0PyiYaww1mFpf/rc3UoikZTqZqRFzJXlov07n3tq6GGhe37NE9jIdCp1KvDr38REgTo2FU6Z+VAjDik5LraLqMOvq5muuOhYHuuiHBXpVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/9fRCJVJdli2kfWBrjXstvYkMjKzl7NVNaNA5p8z4Y=;
 b=jhF7Hh8WUsXU49AzlqymGDVw27U1485g/N2OamtmjCZPBq4pJaHRuNCXY5jnfW2gWnHkFRkagpvaEI7vV94KGPyKVtfDV5QZTEbwn3u9pOYeYH11t/u6pDd9k8Mx3wl2A6zQsvI7p0IuAnphc/I063dXUimmXvmKJTmvPCg1H3T/bwZLAWVOrOsxEVYjWidTBJUcTZUI4h5swJZ5cYKM0s6C679Sc/5hkBN3/foStF1UV7RzXWupUOmBk1VXX7NotXJbSOVfZeXhISeruY3xGmplA3eRxPQNNgkTyRguKl4d9snaKSD0sMM0/PViReFKfvpVnqUwfdCg6f8+I31uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/9fRCJVJdli2kfWBrjXstvYkMjKzl7NVNaNA5p8z4Y=;
 b=VEm/xc4QuS2iga0ecQ1NGGMuS+HMGhtR4Nv/AN/xzBIZ3AHiSvs0cpCo7Q4O9eJN4uCfXFQnnNXt/+78BCLVlDAgUSTSiVBCn25lX5Ax32n3zobpQHpw4ct37hjiZnr81S6w5h20Rlq/1fz/ySkbpdwH6zDHtdNaefqsHXFfjtU=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by BLAPR10MB5043.namprd10.prod.outlook.com (2603:10b6:208:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 15:13:28 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::39d3:107a:a22f:4c43]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::39d3:107a:a22f:4c43%6]) with mapi id 15.20.4778.017; Wed, 15 Dec 2021
 15:13:27 +0000
From:   Alex Kogan <alex.kogan@oracle.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Dice <dave.dice@oracle.com>,
        Antonio Paolillo <antonio.paolillo@huawei.com>,
        Rafael Chehab <rafael.chehab@huawei.com>,
        Diogo Behrens <diogo.behrens@huawei.com>,
        "Fuming (DRC OS Kernel Lab)" <ming.fu@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Thread-Topic: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Thread-Index: AQHX8GFPItDmpDT0R0WUWd+2hoaJ1Kwzq9yA
Date:   Wed, 15 Dec 2021 15:13:27 +0000
Message-ID: <49D5CB4C-F416-4BB4-8521-0E00B1D146C5@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <AF2D277A-5E20-4B47-98FE-70D217563CE6@oracle.com>
In-Reply-To: <AF2D277A-5E20-4B47-98FE-70D217563CE6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a578723-2047-4ab7-1690-08d9bfdd7287
x-ms-traffictypediagnostic: BLAPR10MB5043:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5043BC9C1CA6EFDDA7C95CDBF1769@BLAPR10MB5043.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywfjTcGtdIleRQko3OZVsOXQN74RShEhxlXoZNaZUGDS8w0C+n3IMGSHLL6UXVuX33dLAx3gEgm3EtiSh4ELqzGfbaCaCgTrSbXXsIbh2j5PGIAWwvWoWultr48opeXiavW2krY7LGbsfrBbulfN6P48z5pCexhzSLXyR1npJeEodUIYX6hUFRhJaZ1NFrNKxXniYBD3OXafK03fJ4iPVOkqnD7UT+Qt9HqJzU1jgbOOSPhlJdaUafH+zB8CuJW/KHCHmCIjw7XbLiS9oQqSld1UeULAbVX5/4zm3BwvbyrqIZfNzflWAWncT3G8+1AtvcwTccjUK3ML53z1wsSffXm5C6Py4s7a9ZVe57inSiZAtNnR48nsdg0PjP/Ej1do3QIrOkdc8e3fXbgdIb1qCBcVFMF0ijCFTLYAjBPX5YOAbolKZ1XrI6JHAxjzsv8RbNVFjD6vHjGt6Di1PX5QX2GaqaZlCqLGCmac0zGd6lrbOq0Tg5in6xY8wv2fm7gZsWUqAMeVMyhDnVxb/XmU5e4KpQIHi5P4t0J/6jghfw5444DRYUkVdCxLBheHxRgtyPo/QMMO4t9+mO8f2UAlTVOl9CDMDMnaGt+5Na6INYsYOStq4yiLNCx/C19CFewKTyBW1BUhsbiB7eFDoe+toL/KZX8CIOtoa9BeIkCdf4F7p6MWFfUVrWbToPdiIYArEM6BEClYF3vJhb/gFqpibWF/eLb80qDp3hvu+KxjtYRgBls5BAvpwDU8IBSWprXd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6506007)(2616005)(5660300002)(6512007)(66446008)(38070700005)(33656002)(36756003)(508600001)(54906003)(186003)(66556008)(66946007)(316002)(4326008)(76116006)(44832011)(91956017)(64756008)(71200400001)(2906002)(6916009)(8676002)(38100700002)(6486002)(86362001)(558084003)(122000001)(8936002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDlrOWFwUVc3cWpBRkVDOC80TmRoa0xJV05iRmsrTVM1Zkg5Rk9uU2wybE1Y?=
 =?utf-8?B?SlU1SFdyK1dTQWtocjFwSHMyYWlYeVd5ZlMxWncrWklrY09yaWZQNXo0dkVi?=
 =?utf-8?B?MzhSZzUvUkhueTdJeWkzRGs2eXRmQTIwZmZTVXhaZEN5SHJDQmZIc0t6M09m?=
 =?utf-8?B?UzZYT09XMzJDV1NaVm84Z3hmOUpDSGlWZGlvb2xFVndKYi9VQy9TTmlqeHp3?=
 =?utf-8?B?bG84Y3Z1ZjFDeEx4WkxlV0VXUXpjNEpTazhjTlg4akQrOVhtWm1KaXBQbDND?=
 =?utf-8?B?aDdQM2ZtRVFwUHowbEt6UHlnaVlGWnM5UGdvSXNOVmFlamdNdDdZb3U0SGUy?=
 =?utf-8?B?NG02Z3h1eHFielZ1bVhXZHhJaGdreWM1Um1rVHNNdHE5V1ZVM3Nza0RRak0z?=
 =?utf-8?B?eHh3WXJYWjNiT3ZxTGE3TDBtdVpEekhFTW9ZY3RzaEptVnp2UnlUTmh1cVBr?=
 =?utf-8?B?V3ZzUXh2NFJOZHo1QlhUQ3ZZdElxdVYxVGdFSVZjandtVHM5Nk81d25meWha?=
 =?utf-8?B?MlA5ZmwwdmxFNkNiMTg3T2oyVG5WWVIxSWJsOWNPaVMrT1lLSm1UdEhORk5F?=
 =?utf-8?B?akZCMHgvWGFLbktuK3FMcUlpYkpiUkhEYlBuRmFOK2pPNVlZMXM5dTFtSDk5?=
 =?utf-8?B?L2pNMlVnTGpCbjhGeWcralY4cTUrVWhnbHk0NGl6dVRMVkN2YjlSY3UvaXc5?=
 =?utf-8?B?ZW1ocjZpVE43dENTMzZTd3NEaGw0MjRhWm9FbnRyTXVtZmgxUUdVYnJnQjl3?=
 =?utf-8?B?cFFiK2RJaUlBMmhwdVFzMkY3NUNTQThJc3BwY3RYdEdLZm53M1B0QWUzSlVD?=
 =?utf-8?B?RGFlOFM2Skwwb0FWVitoL0RKYThCbUR0cGdYRGFTNWl1UHVMSjFDUVdpSzhr?=
 =?utf-8?B?a2hGNldWd1V4RmJPcUdscmxINlhNbFI3bGFFY3JSc09OUEtpaTh3eThOQUln?=
 =?utf-8?B?NGNoSXdCc2kwT083YVpCYnBwS2h4VGVZbnp6ZTV0TjBuT29rS0JPbzgvb2to?=
 =?utf-8?B?c0ZHTE5GV1J2cUk4NkVCcXlaNHRFamw3SEpxazdUZXlpMTU2TnhmR0plQ0hk?=
 =?utf-8?B?QlUyQzFhQ0R6TmQ5RWRZOEJTNDlCTk5idm14VEM1K1RqSlJtQW5ybFN1ZXlK?=
 =?utf-8?B?Y1dCcnJReDVUaExPeG8zVTN6eW80Qk1PTDkxakU4SDBabHVlVTY5OFRFM0Ux?=
 =?utf-8?B?OWxLYmFPb21oOFd3anJ6c3Y3YmpVekRrbTNoZ0YxVUpqbDFMUjlyNVpjZWF1?=
 =?utf-8?B?cUdqL1N2ZXdnNWxXWURkUEdpMlJSVDZWTU9QalYvZCtnVEZDd0laam0xNlVy?=
 =?utf-8?B?RGFFWk9ub2xSUzhkVkVrdGlGV3QvREg0ekI3L2NaR2JwZ205a0hCVkFwMGhM?=
 =?utf-8?B?czd1RHpJbzNIM0lXRk9FNEVKRDk3bk9RdXg5SGRzU2ZycEhTQmdGTFFuSGNs?=
 =?utf-8?B?cG9qVWZGaGNZN29hTzNmKzZsYWxFZldkb3VZTVJuUkxJS0xBcmcwOXBMVTBW?=
 =?utf-8?B?NFhpYWdhMjdFOWx2M2F5ZTAxOHM5L2oyOUVSajlHWlBmVDRWeUV0UXdvNjBi?=
 =?utf-8?B?aDAzQmRuZmhMcEFuUnYwYUREUDdpWGc4Z01zVjlEVGNQUFo4YXRVWUJaWW9r?=
 =?utf-8?B?aEU5SG9lZ2VFOFg3MVBweGtTRUk4RVlQQnJ2akNON3VxVFNDOWw5NlF0NkR6?=
 =?utf-8?B?dUNnSXA0OVJhTSsybmhyWjY1a1kwVFV1MzNJa3BmSncwVTAvTC81dlo2NER1?=
 =?utf-8?B?L2RtYzl4TDFlQ0Ryemg2Vnk1TVN5NHBuYkZSRmhYS1FKaHJJR0NHN2FKYkwv?=
 =?utf-8?B?WXlQcEhISWw3OUJiMkNFQVlrckpKd0JRMzJ1Rm80VjlhZFB2RU1zVFNaWUtC?=
 =?utf-8?B?d2JDR3pmMW9XZGt2enJwYkFYYzVXdEdIS2dBYmNnZk53ajB5STJuWVl6RHZr?=
 =?utf-8?B?RXpxZFRHSzYvSHg1VG1lVjJrZ0w0Sk5kZHJDSUwwVFNwVWd0MGp5L2hSRXZa?=
 =?utf-8?B?cURsYThhaThGNVBvV3k5RzdCTDdheVJGbjdXRitqeVVVUGRXQlFIOUdOMXVG?=
 =?utf-8?B?SUI3bFVEMk03RXVuQ3lIRUMyY1Jpbjd0WWpWOUp4bVhlaklHaWJFakFxZVA5?=
 =?utf-8?B?d0FhOGlMVk02MW45YnN1aEJkQkplTWVYNWRTOXBsVjdqWmptdTczVXJMSFMv?=
 =?utf-8?B?bHhmekJwSk1WQ2d0bjE3Z2dJVlI3d2ZldG9ITVJBd0Z1VFFBODNnZUpyQktC?=
 =?utf-8?B?U2x3UzlDRjBGeVlDOW90NDF0Ky9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19DE42D764C64F47A0C4C24BCC3137B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a578723-2047-4ab7-1690-08d9bfdd7287
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 15:13:27.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnB3qWTYLTLon0X/VuZBmRYG3K9vRExInr+28lPTXyAfMVJrjh2FiD+2VdF81CoqejpQZBCMTmUFC8d28ETYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150087
X-Proofpoint-GUID: 4dGRbcSpyDn8_wJOTiY900ucreS895kE
X-Proofpoint-ORIG-GUID: 4dGRbcSpyDn8_wJOTiY900ucreS895kE
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IFRoZSB0aHJvdWdocHV0IHJlc3VsdHMgKGV2ZW50cy9tcykgZm9yIHN5c2JlbmNoIOKAmXRo
cmVhZHPigJkgYmVuY2htYXJrOg0KVGhlIGNvcnJlY3QgdW5pdHMgYXJlIGV2ZW50cy9zIChha2Eg
ZXBzKSDigJQgc29ycnkgZm9yIHRoZSB0eXBvLg0KDQo+IFRoZSB0aHJvdWdocHV0IHJlc3VsdHMg
KGV2ZW50cy9tcykgZm9yIHN5c2JlbmNoIOKAmW11dGV44oCZIGJlbmNobWFyazoNClNhbWUgaGVy
ZS4NCg0K4oCUIEFsZXgNCg0K
