Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245DB60E3E1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiJZO6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiJZO6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 10:58:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021018.outbound.protection.outlook.com [52.101.52.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A81213D8;
        Wed, 26 Oct 2022 07:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO0rMXzqth99pdO+CNcGAPxixjQZs/0Yt7jDXx835Sh7ReWxpS/EfKkDBA1Ln25HKMIdoZchfZDQcds7NKwI9WDZw3abulGID8mzqVea5stdPGXVjTeEhn6jmR6xFtobpjaOAl1Oc3jJRKyzP8JyLYxJFxICjtghpyj9yet9pw0qs4IuGOBA8zIBoT40fDCCw+5SZHweWnZmyPJrGXHjXEiW21j1sgsIRoUFnNLfH7yxXRqFGyrxl8iBaeMOtjwlF5BN3+IXlaClr/+EuDrzhx/CHV2+j7aQDIXihA4wbZ+bDDOxZjdNRvFB3oU2nCI+NnzsheeRFZ2Hc1Pk1mAnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SAxyFnDrMP9zDR++7dI2iZ3B6ZWI/+AlEdRfa9sktY=;
 b=WUnXE75pHqUDk2kciF2k8jQM2pELEV3zcxTUTTrnlBYXKt+TUTeVoq+z2j514sEn3RFz++aPlundx9Hgb+6W4aOul9toV0nbfmOfXY3AnKntFh+mhqJ/92SRrvSQuBJanDnZ/yc+u3QuhYXrSnih555OQNlE/AE/Skaw4LY0RZOw+Sb9u3fb/b5HFgoTs89Y3PVT1WA9W5WuApEygUoAjk1x7mC6F6H3Oui9haHIa0PU1VDPVAaFpbC/m5BwZJxD0HUrIb8JojidtKlBsqazJjWn+5ABPqR1U7HazUiZyyhG8sCJQpVfFRlF2gIMjtKcTBl+rz4vnrY/SRKFtuXyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SAxyFnDrMP9zDR++7dI2iZ3B6ZWI/+AlEdRfa9sktY=;
 b=aLWXY7Tjv1Mg4kxaNUL648eRmfZSmG+dLZ/37O8ZosgmRK0qqJIoAPV+tLKxUvS2GhNNYtB3/lVVUqG8UUc8GPC9xkgRcP+TY2lQO/7a5OYeqfICdzSukYOfMQlEn8+T09YoTnb0LnThy+sEFdOThsuJdWtytp7nOy1kx+2UnZs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1870.namprd21.prod.outlook.com (2603:10b6:a03:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17; Wed, 26 Oct
 2022 14:57:58 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5791.008; Wed, 26 Oct 2022
 14:57:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: RE: [PATCH 0/2] Fix MSR access errors during kexec in root partition
Thread-Topic: [PATCH 0/2] Fix MSR access errors during kexec in root partition
Thread-Index: AQHY6UGlSxecIa3tCUqtnwUn6w6xFa4gwWeA
Date:   Wed, 26 Oct 2022 14:57:58 +0000
Message-ID: <BYAPR21MB1688DBC9CA80E03BDC7643E2D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
In-Reply-To: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=edc789b0-4bdb-4268-bcf6-837b60eb2193;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-26T14:48:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1870:EE_
x-ms-office365-filtering-correlation-id: c2b7b51c-f28a-44cb-6ee3-08dab762789f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LiO+8KgY8kA9gmq+5QlVsEieRGvsAZRvtGlQMEFE65djiPrp+ZT/kCz8BwUIkFmRUWc2Svs7tbjxg1zJE2zleuY1OVt99Z0Y+kqYVkr7s6MFK4eYRJEqRI7KupEyTsdb51DaYqJfGtPwXsJTwawDclQdAIPGw0iOjuXCcXz2a/vnwqwgfBe33AvwlhkGn7vReHrOYmkqFsSC7ZEFUvdPY9O+QVLmm5z5dVuQxeeFYumhMUna4BTj6QYE5Q53TW3iVG7TELLmxlQCkZRTFEYHV+5EpACbYGslnrZ9Yg1RAKAvHWG0/8+/BlcRUa/t5/YZF1GKyT38oKq0ZsWhWQw3X4yYQ/Wa345hFD6/xAphj4a9H3ufhrMiMBtHmy3kPsa9uX/mOwyubm8aPgaXYV56B3E1kJ04oFxBOWD/q7/A5UTQ5+HTO05jHsdw6WPLSOwNZfOB8uGt0JPMXsDRfqPeEuktNFPyM/sGyy6dIttV0vTQE6/gu2aTlmHi60gUS8MCCpI7xyaH2HgD9y9s2+0eLEl8dX8tolXi4JiZNdTz94+k2RMZuM+AqhFJedPybSTYbDO6Pr8SfmRhUvHWhp2YbAk99Zm2isPkS+sQTjAy0oCIFG2+mdf7f84P3K0uG9LtTwInhLOsUa3pmAFmkETh7KNPAODUlIxWURZa9cg40/6+FKFCi3rOD97qduBJvR9EqaWHjssCJUMhL6INU4Jhi/x2zZLsD9IM+AXZiZEwIbzjgIKyTT0f0eLqRp0X4A5Q9FUFzLb9HM2HcmOL+4JmSKfwmxoVnw0a+SYWJzDxGv1UpxHaHubbyTw56grOYppdQWbuLw1ewAHIFbBndF5IvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(2906002)(6506007)(38070700005)(186003)(66476007)(66446008)(5660300002)(38100700002)(41300700001)(52536014)(66556008)(921005)(7416002)(122000001)(4326008)(33656002)(86362001)(8676002)(26005)(7696005)(110136005)(8936002)(64756008)(66946007)(8990500004)(82950400001)(82960400001)(55016003)(54906003)(478600001)(71200400001)(76116006)(10290500003)(316002)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hcDXCjmxA8NSnyf1af2LW2gORTq6g30BiEia6VVwhzzDG+YUqgAFH3y8rq32?=
 =?us-ascii?Q?FT/kuKbzL3UUrG+ko7z0hpvHKYz9ZvkOQcNG4IAKyUdxqdREsXTOmoY24R8V?=
 =?us-ascii?Q?HZSLD30HvB1+67UuLm/dOy4dG6nKW+p6YCQu1S9S0CPvTfqWNCzG6jlEENJB?=
 =?us-ascii?Q?mlwKxQ5FqaEtYHY+Rf5Lzvoh6MjjocFAF+h/d8uAwe4TUQ2V3n+ou+7959tJ?=
 =?us-ascii?Q?4d/FG7RzRw8oaW68nsfTeNm5hVNiH9od1E476E6MiRzaShROmRWIXSAOE8tJ?=
 =?us-ascii?Q?CDdvMX7czEB8ss5I0Fv3SdKbKAJ6+fBrzUlAqiuYP4bvB8KEEVlVLkVQkGuI?=
 =?us-ascii?Q?9NubeQkPauS2T6RG9ccJunXXk80/HWb30+5uHfnP/9L4Kmi/OR8/H3J3ICPb?=
 =?us-ascii?Q?jfAbhYaqWlLLPQby9VLRyn6O8fPZnrj3w5kPnE/4Fbg4OpZdrTyGV3JJBQhu?=
 =?us-ascii?Q?UhQnvvE5s6xX/AbXbb+xk4IAx7+3UkZjh6ng64darMvOnrzqDlUsubPiAOuw?=
 =?us-ascii?Q?ZKkO2y8kWe3n9T+l1bvrraloTR8fCICgKTfmGmNVw8AWC484651Phpoo7LJ5?=
 =?us-ascii?Q?kEly8eyVmnYu2XG30tPawAHfdu29KoIhElGehdyYc5AVQT+bfMyj4JlIDFg9?=
 =?us-ascii?Q?h+AIfvGf03ZOUe/TeH7yCrlUuyci9Qw99q4Ohwy+7WrpYlYvl7lw8vxUqmgd?=
 =?us-ascii?Q?yS8eFx78WU2NkC3ZzNdTsdJHmXm0NY5mnDDUGB0Zu6X79cA/xHK50w4/B139?=
 =?us-ascii?Q?QYy8AdR9ntR59arc6bH6J1jdh0cCFqwbOUoXQQ939y4UZ7OIwT1mc5bMKT0X?=
 =?us-ascii?Q?fvluIVgrQCPpbJhTz0SbZfMr6l6jHjsCe4ttauI0+8CP6pN8SVNHS4MJ7cna?=
 =?us-ascii?Q?0g/t+dURVK0hf2boMvwdyiSISdewpH0oxnO20lfWTPr5cGf1rCJDt2ivpz+V?=
 =?us-ascii?Q?jfEZGcmPvxdsz0g4K0Q5rbrJaxKjao+LyqO3WFoiZowRXdLJaBpBBfCVij+c?=
 =?us-ascii?Q?gkdRBIHEiL5HPa5nmxY0VzA8fmHnGWfsI3LGp8pcmQYOTgGhYYSvDtUfSH38?=
 =?us-ascii?Q?tIPo59OPfePjLkTR5TZ0i8HUYzOzVA6Q3e/Lfg3wrM3p1TanF+GtRWzQjGp8?=
 =?us-ascii?Q?gAafcGQT0v5W3fWc7Y8W2am/MwDqf2m7QpB0FdhSqh5MKtc7E4SjvkSwtIgy?=
 =?us-ascii?Q?aWqA4Ljv/JB8vgarIdnVnRRVpw1tsz0gfAMZqNtkj5PQIH9SzcqiRcb85Sir?=
 =?us-ascii?Q?tyo7wfa3/BqRIIkCRz1+y2yUa7AEWKIM3Nfh+cIbGizmDmmDNKDugiYwZJns?=
 =?us-ascii?Q?pBWuYQydZtiADO/YqZyoVxEzPa4RW5aaOuonoURCg7MSRgsjQMmWCPxKyTii?=
 =?us-ascii?Q?YJMQXIUDQHEcUAn6V6lksRc4dFbc3WrLmM7kEUvl0qbR9Tupj5PA+N25OAOH?=
 =?us-ascii?Q?dNg/cWl2I40W4dQmo1m4aDOo5jTX32rNDrQfHZKG3x2suQKb4I/3ShPo5nf0?=
 =?us-ascii?Q?WaWm/LW7ZUzg8d08OmUuk50RoXRawmBRkFcnu6Q7Mn6Yj+KrWhwN9hoUpU5o?=
 =?us-ascii?Q?2RV+REs6OFeMtEHLDwV1mONo4qlBFESVRFs8RiJTLO8dz12zAMoUtW9/7suF?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b7b51c-f28a-44cb-6ee3-08dab762789f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 14:57:58.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmAGfCHSUU/L4lx1QhMr8euiQI6Gbt7NQehrokIkTrE8UpQzqNhcREM5MCcU329XARGqypxxjoMYo9RvPmsjK5jd8d8psgk6fMiTgFlovV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1870
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Wednesday, Oc=
tober 26, 2022 6:47 AM
>=20
> Fixes a couple of MSR access errors seen during kexec in root partition
> and opportunistically introduces a data structure for the reference TSC
> MSR in order to simplify the code that updates that MSR.
>=20
> Anirudh Rayabharam (2):
>   x86/hyperv: fix invalid writes to MSRs during root partition kexec
>   clocksource/drivers/hyperv: add data structure for reference TSC MSR

Could these two patches be sequenced in the opposite order, to avoid the
need to change the TSC code in hyperv_cleanup() twice?  The new
data structure for the Reference TSC MSR and clocksource driver changes
would be in the first patch.  Then the second patch would update
hyperv_cleanup() and could use the new data structure.

Michael

>=20
>  arch/x86/hyperv/hv_init.c          | 11 +++++++----
>  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
>  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
>  3 files changed, 30 insertions(+), 18 deletions(-)
>=20
> --
> 2.34.1

