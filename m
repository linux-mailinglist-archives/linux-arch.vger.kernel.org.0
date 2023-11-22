Return-Path: <linux-arch+bounces-381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C07F4D91
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854CE1C20A0E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166B4F213;
	Wed, 22 Nov 2023 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hzi4PWJz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286161B8;
	Wed, 22 Nov 2023 08:57:06 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM9iblq001221;
	Wed, 22 Nov 2023 16:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=WxBhgQsTvR/j4TQDt79mI7mu7eHrl3lIDmOfTikpM9E=;
 b=Hzi4PWJzP5Ocmo5Z8USLnY59vOTSNeod/oayOvwkxBUlR5MaL9SDxtXJqqhrQaOMfYQ0
 xzsk6eOpmLbTgcA1cZ8tmpzY/0KMjIbrM/mcXur/fiqpsdR+2zhRCO5vcm4oX9K4AiDh
 P7griAGwh0/O5f7c4c20TkDQBDVf/1Y1K6jg0LpUh2XrN0n22Bnb4iG2UYbKhGT8Olvc
 32WJsJbnWmqaXI3SrkFeNJYInCk0Rl87T5riHWZ5pNYlCI9vhhMVUHMEIgktxhGP19cl
 wSI5t0QuCyhbsBxUgvsfUE2C+Yt4MmgaBAt1rRq9G2tWWB+hP5os+JCx+BEEySCmnbqJ 3A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhf6692v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 16:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzJxrb8d0lXYZbkEzUuP3qI42MFgNsfSBxpGHoKa7Qujpb4SvMX38G/XQg3nKbfncA3w80SfTM9IJ7W90QvVAo/UCk6BKkjE3GGKBncPKXVPZ1j8XEsTkDU+M6ROTcr4NxwlU6XX2vR6KcaPn/STi8i3rzWW5YSZg7oXSocOTQLnaVBuLu9pA2jus+U2YnCV1dEh6SWDA7qB9wz6NlTogUSAPB8hMiMCINVPhUz3hHzU+CGlR997EeTWMuUAWNDmAFhGzKv8sgvUl4ZW4f7AwdWAIhdygxn4S6EYD/pXLWfcs2//DhcFGljka7ZeKG/5rclODqHO/cs/dX+u7HaWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxBhgQsTvR/j4TQDt79mI7mu7eHrl3lIDmOfTikpM9E=;
 b=R6+BWIbdVEWXBJ8dlGX+IJJSZDIakIAcDzj3llLRLch3yGq2mUBY+SYwA959OD6GyAVxeJ0qR6CXoMsCajkiuyTnPpLZsbH8Gg358NsecwnuQnrP2G6eREi7r+sZy5vxUJ0a/nq7Df3hPCjfDgG6bI2KQD58rgc1BsKOwqiV06o09aVwRWe9VGhbFa4Ppb0/hhTSNO0FmdiVfutknOhXjovm2yGgXO1ofGT2Zg4Ifl8gkF0VfoPlmlJs+J3cT2PzIMPH+FAWIyJjpL9so0JIJNRYhDVnEKGa+1je1uJPZvWh4mmU6cIEs+cebLaXZ5U1mSNK1I01UYNqGXAhWXXnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by MW4PR02MB7105.namprd02.prod.outlook.com (2603:10b6:303:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 16:55:35 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 16:55:35 +0000
From: Brian Cain <bcain@quicinc.com>
To: wuqiang.matt <wuqiang.matt@bytedance.com>,
        "ubizjak@gmail.com"
	<ubizjak@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "jonas@southpole.se"
	<jonas@southpole.se>,
        "stefan.kristiansson@saunalahti.fi"
	<stefan.kristiansson@saunalahti.fi>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com"
	<jcmvbkbc@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "mingo@kernel.org"
	<mingo@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "arnd@arndb.de"
	<arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "mattwu@163.com" <mattwu@163.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 4/5] arch,locking/atomic: hexagon: add
 arch_cmpxchg[64]_local
Thread-Topic: [PATCH v3 4/5] arch,locking/atomic: hexagon: add
 arch_cmpxchg[64]_local
Thread-Index: AQHaHIaMNzVqVpV+0kaskN0D0LfaoLCGkEew
Date: Wed, 22 Nov 2023 16:55:35 +0000
Message-ID: 
 <SN6PR02MB42055F99C792153754435AFEB8BAA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
 <20231121142347.241356-5-wuqiang.matt@bytedance.com>
In-Reply-To: <20231121142347.241356-5-wuqiang.matt@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|MW4PR02MB7105:EE_
x-ms-office365-filtering-correlation-id: 95a05139-15c7-4c58-e994-08dbeb7bd8f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lq9Fe9m4KnVrgYh7d8UYcrPUEc7OdixOvn9rRyFq2j7e8Pv0tsGs95AdOR5oHcNEhAmLIbIrPVn9KkXnGIK5EKfDFHvzem3Pec4FZSn/Dtpp7Prlg++0Cc44owWCZhKIfuhiGC5aN+3YkFlDNd3TTEL2PI0flQXZ5CZD6Nm830TOZjKfpCfgcZxilACUIqltWxNW80AEY0Stkkl0KGT/E5/45w3siBQF4IDNDVN++eNYDW9LHSH8Xnz5zwIJDXvXykBLk4ZnmbB9tgUI2QCwQRFXckhUjAJhRJj/N2m5KGh9+XoZbV7mccVmgXeKmCmU0iMZJe71uhSlHbYmlYSsX4rlRSBRX/Gw8OjhS2LTJkrA+zhfK3oymD/CQyXZbOkhRx6Fbu8ZeVtK6lgZehkZfc1v2jMVg++2gFEpxT6GQPNf48EUYyxb6tAFUO0UkZsloiGXjwHL5+o5eCUIKGJypAiHe3sK8xm8z+8aWgzT5th7FSpREnMGh3/CMaSIc2AeznCT/dNF141fL4C1BM22/PdE40df5polvqSQMCVTYKCZ/EwTJTJF/mJRGM86Rqne6HPpLs9Xo0SSRWfYO3O0CGhtME0ewIcI2cBNQVRBjzLtKfAShnoKHJP3Si5+nul20IKaWCl8JQdrWPbKhql7QaMZa83Qho9GRpoWiMeon8c=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(2906002)(5660300002)(7416002)(33656002)(86362001)(38070700009)(921008)(38100700002)(41300700001)(122000001)(76116006)(110136005)(26005)(66946007)(55016003)(66476007)(66556008)(66446008)(316002)(54906003)(64756008)(53546011)(71200400001)(7696005)(6506007)(478600001)(9686003)(966005)(52536014)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dzwRCo39FexMjc/QqZ0SPxJyAnDgCdZ3K6td/gJe5N2ZJaRNxbg9bjB8QZ5k?=
 =?us-ascii?Q?bZGt6660/NHTTzaP3CY0RKn+NAdqeaUdvfvKTuKA1Yz/UVvc0AjdRdnmI5x/?=
 =?us-ascii?Q?LwSNEWiXjx9c70TCr5mI0I52+3kGFtDh+WX3d+EbLXm+dud0/hGUSjYMmSi1?=
 =?us-ascii?Q?89Ihsr/FhaxPCGh7UeVIPIDeDZI2u59aw7qvpqBYbl4GP2XvOsV8+hh16ZMD?=
 =?us-ascii?Q?K2Ip0i1RyjIKaCSKFcFsC/qjkpJHsZdXgki0iEYvyLVjZvl/92t8yLHe4YQv?=
 =?us-ascii?Q?LVquIgbD+pJgg6GKnX16p6EUswuHaHK1KGZVf7BXp1HSOezA8J+lL/1ZUJD5?=
 =?us-ascii?Q?NFaIDN/WIUQzYZiNnBOFOiIE1UP0QbvFz1jwHfjDwFxB8GZtktr8iH9MVtrF?=
 =?us-ascii?Q?XxKtzJjB+wvnSrTIJju8USzK1eiinsS9c7AyrLNQlpZN2gFvqXJpehZM2PXn?=
 =?us-ascii?Q?q7fc2DUsS7CYmuxAuatug3smngq/aRibAgJAWXW6cU2DWUqFLXj6qTO2O1rC?=
 =?us-ascii?Q?8q8OvhC5IAncwPV4o5cnYC3+qZXjwsTkccrAcJ+NRRnpiK71VUG7bmVHgeAW?=
 =?us-ascii?Q?y46iu0uzg75poocABh7uVwSo/6FzjRx7vXNdmumBjkCqNqNXw0OpKf+byAYa?=
 =?us-ascii?Q?3/ez7vbJwwiyL5KO05vkC3NNDGa8vFopACpBNLK3gQM2i0MhdVFbPZkRnrD8?=
 =?us-ascii?Q?tOjxvDrS7zxgqgqP5ZplcG8L2ViFEmD9DO8JGH1sZqiPHKLC90QkWLCFCALG?=
 =?us-ascii?Q?6DmiWaCaTWB4BHVNa8Knu2GvaSlr+UfvgA14LWD3ItmSHAxzkZLGwgPqp7TS?=
 =?us-ascii?Q?1T3tHpPhmj8XZVDwsPTVdgrPZQFWuK7bEpw9TIvdzqDipiXhtFXuQ43z0X4w?=
 =?us-ascii?Q?mtM3izd0CM5LDOL/5//mG8sRyUR3DeNYPZ8XBzC9kWT0awLbAuJ7RWyKI9zz?=
 =?us-ascii?Q?3iAFKxKeEZkC7YQ499GhsP3hzdWX8+RtWzlMQpVR0I35WBe1roSTD2O61S6d?=
 =?us-ascii?Q?+Xv9wtTtKpn9LRIu9+nOf5Pom+9XkPPPgy2/CPICnuGOh0Zpp65zsduscQ39?=
 =?us-ascii?Q?WaPWpMtixh7WwPJfYIGlL9AY+WqfLXGkygYzaOsUoTpR2Up005+3DUucYPnc?=
 =?us-ascii?Q?A30EDn8cDgIIdY+v26PMrDHhcVcxQenvoHXC+mlx69WWnrrmhl/RuKGVmx3/?=
 =?us-ascii?Q?yXu09vHPggQ5FkFWCW+iVR0EP9lvntpP1+t84GJdOzBOw5vyYJx0mSjKxM+K?=
 =?us-ascii?Q?TjlS+/DpHzD7pF1kXNr4ErlOmlYuMyRBKioy/ebuhF9DYoKCabIvHRYh0ijj?=
 =?us-ascii?Q?CI16gyJzr0FDx3l3xPI4wuUmZPzl9piP/icm6i7U6be4ZqEDcbu0jFy6s8Ex?=
 =?us-ascii?Q?g/+tcHQ2foZDPviZhBKeZ0wIfsmyhC7OBDifrQT0A9k/0tIALP46Gn7IMIis?=
 =?us-ascii?Q?XhBtonB6Yx12bNtsPW8Fyjv2ljFOAGmh4WFvY7a3jtFtkpgZDGMXOceaGGve?=
 =?us-ascii?Q?McInThqWVUwdUF/g04h7RXiePxthzJ/JI3Y+h1lx30z6Til6xS5lcZD2aOH3?=
 =?us-ascii?Q?DgUhuOjb8ofdNCvA02o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?LBCT7fXGOsg4KPflT1IANScteYGOxcI257j3KOG6i3/YoWce+uMnTkvoznO8?=
 =?us-ascii?Q?6QHmREqOZigPBAz9obJhY6i+l2bYjioySiLfjvuJPAolCWiOpecGrFQUHzRr?=
 =?us-ascii?Q?BgdjuFTuRYm+SbNjWrFBKmpuPYZNzI5Pv97NfWrTP/Vagu19uZQpUbKMPZOK?=
 =?us-ascii?Q?kSqzLrT0A5Kj4zhyYRnVwk2zutULCzkqg9zZzgnpDa0uxD1VrJ+29knNQ5NH?=
 =?us-ascii?Q?1qpp6WPRD9QJ2PqBsv0Ya7wbnk8O7tLQ22hPH1zNGd6IN+GixieMNbU7Y4D9?=
 =?us-ascii?Q?v491auh9v8MeIFMN+29USVCsk4VNk72rIBisVYWxMiBE/YYkksN7p5lRTyig?=
 =?us-ascii?Q?M7e+IKeq+vn1Xtv7DOiTja3r5BH83XGHTMa7vgV5H3esBzNlmbdQqNvF488H?=
 =?us-ascii?Q?94XauIcCCJLGPM3e/3kFQq3ySMskbsLJBGW1a6UQxdyzqcUAgzpZTmYENDbO?=
 =?us-ascii?Q?gjfny18DfSNu+n7jc9S6b8lhcY1Ke26TvQCcQaqLZkDqhKLaMPSrpXYlKlG5?=
 =?us-ascii?Q?qLlUA3kQk5RGfQGmCNOgYb8FwcCT9KkYvI5VWxJlV2LL8WqKUZgYbjoLCaw8?=
 =?us-ascii?Q?8u7+/qDnSWkDSjYxQEhIX4thGoSAmJPnh7an0sVyJzP1w0ka/hWD4hvAXHpq?=
 =?us-ascii?Q?fv/ARma8rOOgAZqcvgtPnD1PIpFvK3eyFzRXK1dr8BvihVvJzvbIF/E1/CvN?=
 =?us-ascii?Q?KYEGY9VW7T/xlGrzB1VXisFOzSjDzeF16ultRxtFlLfduTF0wzy9WohlqLoj?=
 =?us-ascii?Q?7mcEF0KNhLn1N2Sr8gct372biGSpPvHRbiWx67UGo0KKUzU7sw3BO9pgX9zt?=
 =?us-ascii?Q?A+nujtPTEYTMnNYTyhTC+tAR1aK2KOqjQQqjzAs7IepiwlsYpPK9xwKg11IW?=
 =?us-ascii?Q?aFqKONfeUgjO5ydtitzpZwjNizuAz/lWWhkGyN17y/57ustzC204yechAzod?=
 =?us-ascii?Q?N9rB8Vq08I1C2nwrNT9sMhU5bQC/IzHf/pRzyYkXUPQGWrZwj6L1rbkNP+aG?=
 =?us-ascii?Q?kz+YSfoY40SZ/jz3Jt6K3Qmu6M52MRGOvWxVaJQUU8rInInY6qn+3MlGdvhS?=
 =?us-ascii?Q?XGBVe9htujrzqEIIrkKoHsgQhOgHy08+5XQIycGPSx1GsnRjgmZzlX9vIwXH?=
 =?us-ascii?Q?Xtn772TNTiWP7fDG/2v/YPDyqLtF8036275LuXMm2a6h+Scho3dXaV/9vP03?=
 =?us-ascii?Q?kQkCuEwLZp0pRZW8kNdi8fWoXOLpd6Hbq819G5UipPEEVMRynk3DkWQGIEer?=
 =?us-ascii?Q?iW8fszhOzZfwBM7A0wRrvRd/0c5XRjRB8/Z8eI4HeIleTv/iDBAYO+O3Q6dD?=
 =?us-ascii?Q?DuPdJPqlvckx0EEeff3UEbBy?=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a05139-15c7-4c58-e994-08dbeb7bd8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 16:55:35.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kr1dt8M2i/EFEt3xq+UBssoaQb5ZxOCTLG6UXcugLsRyhXzZ1Fjx5mhFNB0PT5KrdCVD+srWg04JklUSZgCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7105
X-Proofpoint-ORIG-GUID: 5XRJlYPoBDKqHcvHiTAoNWB8XVjE2gjB
X-Proofpoint-GUID: 5XRJlYPoBDKqHcvHiTAoNWB8XVjE2gjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=459 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311220122



> -----Original Message-----
> From: wuqiang.matt <wuqiang.matt@bytedance.com>
> Sent: Tuesday, November 21, 2023 8:24 AM
> To: ubizjak@gmail.com; mark.rutland@arm.com; vgupta@kernel.org; Brian
> Cain <bcain@quicinc.com>; jonas@southpole.se;
> stefan.kristiansson@saunalahti.fi; shorne@gmail.com; chris@zankel.net;
> jcmvbkbc@gmail.com; geert@linux-m68k.org; andi.shyti@linux.intel.com;
> mingo@kernel.org; palmer@rivosinc.com; andrzej.hajda@intel.com;
> arnd@arndb.de; peterz@infradead.org; mhiramat@kernel.org
> Cc: linux-arch@vger.kernel.org; linux-snps-arc@lists.infradead.org; linux=
-
> kernel@vger.kernel.org; linux-hexagon@vger.kernel.org; linux-
> openrisc@vger.kernel.org; linux-trace-kernel@vger.kernel.org;
> mattwu@163.com; linux@roeck-us.net; wuqiang.matt
> <wuqiang.matt@bytedance.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH v3 4/5] arch,locking/atomic: hexagon: add
> arch_cmpxchg[64]_local
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> hexagonc hasn't arch_cmpxhg_local implemented, which causes
> building failures for any references of try_cmpxchg_local,
> reported by the kernel test robot.
>=20
> This patch implements arch_cmpxchg[64]_local with the native
> cmpxchg variant if the corresponding data size is supported,
> otherwise generci_cmpxchg[64]_local is to be used.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310272207.tLPflya4-
> lkp@intel.com/
>=20
> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/hexagon/include/asm/cmpxchg.h | 51 +++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/include/asm/cmpxchg.h
> b/arch/hexagon/include/asm/cmpxchg.h
> index bf6cf5579cf4..302fa30f25aa 100644
> --- a/arch/hexagon/include/asm/cmpxchg.h
> +++ b/arch/hexagon/include/asm/cmpxchg.h
> @@ -8,6 +8,8 @@
>  #ifndef _ASM_CMPXCHG_H
>  #define _ASM_CMPXCHG_H
>=20
> +#include <linux/build_bug.h>
> +
>  /*
>   * __arch_xchg - atomically exchange a register and a memory location
>   * @x: value to swap
> @@ -51,13 +53,15 @@ __arch_xchg(unsigned long x, volatile void *ptr, int
> size)
>   *  variable casting.
>   */
>=20
> -#define arch_cmpxchg(ptr, old, new)                            \
> +#define __cmpxchg_32(ptr, old, new)                            \
>  ({                                                             \
>         __typeof__(ptr) __ptr =3D (ptr);                          \
>         __typeof__(*(ptr)) __old =3D (old);                       \
>         __typeof__(*(ptr)) __new =3D (new);                       \
>         __typeof__(*(ptr)) __oldval =3D 0;                        \
>                                                                 \
> +       BUILD_BUG_ON(sizeof(*(ptr)) !=3D 4);                      \
> +                                                               \
>         asm volatile(                                           \
>                 "1:     %0 =3D memw_locked(%1);\n"                \
>                 "       { P0 =3D cmp.eq(%0,%2);\n"                \
> @@ -72,4 +76,49 @@ __arch_xchg(unsigned long x, volatile void *ptr, int s=
ize)
>         __oldval;                                               \
>  })
>=20
> +#define __cmpxchg(ptr, old, val, size)                         \
> +({                                                             \
> +       __typeof__(*(ptr)) oldval;                              \
> +                                                               \
> +       switch (size) {                                         \
> +       case 4:                                                 \
> +               oldval =3D __cmpxchg_32(ptr, old, val);           \
> +               break;                                          \
> +       default:                                                \
> +               BUILD_BUG();                                    \
> +               oldval =3D val;                                   \
> +               break;                                          \
> +       }                                                       \
> +                                                               \
> +       oldval;                                                 \
> +})
> +
> +#define arch_cmpxchg(ptr, o, n)        __cmpxchg((ptr), (o), (n), sizeof=
(*(ptr)))
> +
> +/*
> + * always make arch_cmpxchg[64]_local available, native cmpxchg
> + * will be used if available, then generic_cmpxchg[64]_local
> + */
> +#include <asm-generic/cmpxchg-local.h>
> +
> +#define arch_cmpxchg_local(ptr, old, val)                      \
> +({                                                             \
> +       __typeof__(*(ptr)) __retval;                            \
> +       int __size =3D sizeof(*(ptr));                            \
> +                                                               \
> +       switch (__size) {                                       \
> +       case 4:                                                 \
> +               __retval =3D __cmpxchg_32(ptr, old, val);         \
> +               break;                                          \
> +       default:                                                \
> +               __retval =3D __generic_cmpxchg_local(ptr, old,    \
> +                                               val, __size);   \
> +               break;                                          \
> +       }                                                       \
> +                                                               \
> +       __retval;                                               \
> +})
> +
> +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr),
> (o), (n))
> +
>  #endif /* _ASM_CMPXCHG_H */
> --
> 2.40.1

Acked-by: Brian Cain <bcain@quicinc.com>

