Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3806F4A40
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjEBTVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBTVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 15:21:18 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85607198D;
        Tue,  2 May 2023 12:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy105V4Cno46171h8GwTJiehv+WAgaC3JnVd165PVcYp5ncG+KvK3ZqU6Mbtgc/xPTytycyzwvjcDAd0RbnHxCad0rWoriGsfzAFPj5enm3jnoJc032VrGBLEDgTlP1HoShnpDtJVG4dT2r8uydqdpkugeUw+Cu/zsVzCs2i9zW5CFYxAgsrQxods2OK6imaf3jLeepgG3zktyxvwvMCfNYaQWkTOxpN+ZoHaTOpFJtqb/6zAcBmBLBgY4C3r0qBQLP/Kbb9kD8kejLfidwZfkqtcRzw4dlCbpBtf39xrJkL3L+vBhkw5jDsUIU3vUs7ZmwS2QzCj8SKkKTn+P2bRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02k2hTv7F31oB3w0iOkvTIdZkJ3lwpN4f4WsZW9xSZI=;
 b=OHEzsIdOOTBPOCDPMrxfiMYXskDP/XW98h0aO9h6skDHbZAjl74MrF/0vohXO6k97fw4U3FtDIksgKwfCywcTVWwqLcOsGQncNJJ5XNp0gjLi2++CvEI9MBghc+5Zc2DMIHhupHPc1xmFnGYdTbhl9bwyNORxw9lI4A6aKQ6DwuXqCADuI6gBgb/elWD1lIhjMQ/p8+qcjNPzHtarVrYcIccfmjIkJmf+qTMwreyE4MiwQfgQgF3QxMF1jJQo/cpNX1ZRYfcGs/0bH01/Tkh5GUjfcP+DF/S7CF/LTMSrVzZy6XObZhVr4qHaB1iplTlH7q4W2InuySnLaJZ0aUAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02k2hTv7F31oB3w0iOkvTIdZkJ3lwpN4f4WsZW9xSZI=;
 b=GAeontrfXSqhOsSk+v1cEDWk1JKuLWupGtCb6ss32Yviq2fZSMsgMDUka9LA6INOdT6EzwgHZd3zfT8lhrxQlPr/CVg1jIJCZ0FiHaiZQ9VZDyTuJBMdkBovCqMmtiRGcb/Yrvvso71JsLp3HxFIPu7T1WO0vjvUkqk+hlp+oMo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3582.namprd21.prod.outlook.com (2603:10b6:208:3d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.6; Tue, 2 May
 2023 19:21:06 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6387.007; Tue, 2 May 2023
 19:21:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZdMDlgRiCry573UqDSIN3qcYRLa9FtKkggAB7cdCAAPlpEIAAQwOw
Date:   Tue, 2 May 2023 19:21:06 +0000
Message-ID: <SA1PR21MB1335446CD89B9360CC70E7C2BF6F9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230422021735.27698-1-decui@microsoft.com>
 <20230422021735.27698-6-decui@microsoft.com>
 <BYAPR21MB16888DA20245DDBC572A2240D76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB1335046F4BA2B407C9026130BF6F9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <BYAPR21MB1688F458EE551BA19D80B65DD76F9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688F458EE551BA19D80B65DD76F9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe447994-baa8-4b2f-a2ae-c9a8aadd7e33;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T17:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3582:EE_
x-ms-office365-filtering-correlation-id: c79e5e9b-dc00-4b46-971a-08db4b426073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YA1YRb9qMsd8JQRuUlzg5q9TByfF4Q5uALvJJSY0vaQtDRxsaENPxwolRzMK6HMivNUeIB0wloiW1Do8BKlDq1OkHvOEAfnknFs4sszHOlHKlIHK2BYXLsnh0kV+itDsT9CFiw9BZNOZa5GukIGZTDc2KFd4Nez1g36oc/L/QRH35bv6nUw8YwRLdw2Zxxoiveb4uk5SF9eTDwmoYGDR0CUtrLG+QO2V+ap8IVh+ZYp1EuWLEIfnCiBTN4BBwjk3w5wUu8gpFuDYn3FmWJ60ezT8BJyWDGCfcEn376cnvOa9RPKUvNX+WqDK3zoZmWengnpoAmyiN84BnQIeqNkZwDVOW+2acWvjuEaq4uL8cUnJPAJW+LVU/weBedarobCUxXKd/nOq9RvUPfh+EYpfNOPmHzltUHLn7yhr7MNPLOCqsGh80TLYeEAr1BsS76ybQm29MMxCHGQT6TWayoHcAJMJObDksUnSItemQJFPuAVovWyLInOBr0yXCnAYqtHCqHhrreIk2MUyoqwPagVbJbP1e4yF4cfe2O9mIwAZH3D5TmbFzTpPBnAdvypUPdrbt0G1VABQUx0ImXj775/WYs50RJ2ijMSN2vCcQ6PKU1quAC9C15u0Prb8LmYxB73JKidGD9NPxVei+vDTe71CqOoa/PdRqYyf/1MTIUEuJmuNAqS8Eu05u2SjHvVKnnln
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(82960400001)(4744005)(82950400001)(7416002)(921005)(122000001)(41300700001)(8936002)(8676002)(5660300002)(52536014)(2906002)(86362001)(55016003)(38070700005)(38100700002)(8990500004)(33656002)(71200400001)(7696005)(54906003)(186003)(478600001)(10290500003)(9686003)(83380400001)(6506007)(107886003)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(76116006)(786003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JU9nm0TDquX3X1zxc7zhOgUD9xo7dy5sYVC+JZyVzFliex2VMIT+rHHQbhJL?=
 =?us-ascii?Q?3PBdC2l5rlFTjhVKS2dgl/0up/4g61HDiErnKMsT92J8mE1LKELeoFXtJAZW?=
 =?us-ascii?Q?qWCBB398NYuKFBMqqU8RYpIfOimsiGS5Llexmx26Lv+tPPp02yYyj+yZmYmD?=
 =?us-ascii?Q?RvXIvDpycnoYefrebOf55V/pTneigtp/lDor4ue0pHZtbzLdvOR8A6zUd5Ef?=
 =?us-ascii?Q?tCsW1R6pWj8LuOx0KpUCNBvaKoPN+Uh9XaayXkn12cHMWl7ViasiucKMtd36?=
 =?us-ascii?Q?A0Tidg6HfLmBPjKUWJRuN5wkG4zbeTej3y+XxEJz8LrkxYH7LBn8YHqfbyKy?=
 =?us-ascii?Q?WqIcxtjJLjREEfQyVq6F7XoKZCm7ZLVmpYexC1ZlPKmz02jZ7KRHfpwBeVex?=
 =?us-ascii?Q?fEXR+kQKx5GBqSN+gOmw6KrqbHpzifjHFpqf5l3TMZxL5LXubJRs0l6QDo1w?=
 =?us-ascii?Q?pIUHYQLM2CQvULjL+jeXDDwiu5kBEZYN6X5JimWOCNQ1GRrCi3XV56Ahafyh?=
 =?us-ascii?Q?Xs4IQn09z47vrG8gQY5Pobl6GXkPIB9QsXiFXA9Hb04yhj42L+H59FVsgHgP?=
 =?us-ascii?Q?m/3ARFHUEQ6rqj1o45L7w+GHQtMJuuNGTgFPl2vB9LzdlIWVRnTrSfg1G6O1?=
 =?us-ascii?Q?QKo3DFQBZMjII4Qc/aZaJuFPiZDglu8RMSIm8ARSz2MYP5q+Oo6K/QJzB00k?=
 =?us-ascii?Q?mv8S0dxoVGURkF7Szhp8DqFvrtz3J7waIgHYR8CWHUzxNzkl49n+eV4hyZt8?=
 =?us-ascii?Q?sIkmSqtbSASTHozLN0ZhrRkaVm+88dq/09cXeWeUnkWnWlRlOUUEViTTzmyT?=
 =?us-ascii?Q?Sr4oyicPg2nT5vQZY79Cerm3447ozehkSVxzDkFx1qfNhnBt31LaP1gVM5NG?=
 =?us-ascii?Q?9yR5zUVtoijCqSQurLD/Q5KyYWDh0o9uGCvIoRe8yBSKfWij7Ck5o7+70EAj?=
 =?us-ascii?Q?r3D34uqo2x2fdvOHrE9EM3p8bTkGJ3MEecdUKJPnBdNHhRIKuwhZUAdNLbav?=
 =?us-ascii?Q?y4ZRV2wq0CAXrBe+gkTLEEU8CZOFvSz71Amq0Omj1BUGIaHtFVDI6N2AdFo2?=
 =?us-ascii?Q?I0ikUEo9eeXSXGFwXq2K6uDRFRPDF8Ar/D8Xo71NEu8bK0io5upBrfvMYQ+x?=
 =?us-ascii?Q?7cG092b3r9WlQX8gKknxDAPRPr6Cky0WhxzDRUe6jkWlTXA5X8RoENwnhNtq?=
 =?us-ascii?Q?IcjEk0FfAuN22hrIl8sZTy6caAecU/kXS1mJQ5kn11/4dFMrsqRx64Sux1x5?=
 =?us-ascii?Q?Z4kAkWWO2UaS3is3WnwjwkyuxZpNRIiJpZaBhpKefbCpvFILQnS5Jvvp4fAB?=
 =?us-ascii?Q?4YzvQ6ir2MP2u2wmTLLydJWqHJ5K/88RYY+cqXN2UbvB9l3Cyrj6jUqlhHl0?=
 =?us-ascii?Q?ckEUoLnMxkSmIfZxNl5ansdYKsSxRVYPCyBIqqCFFYQth13hpOJ+hZmUIYHH?=
 =?us-ascii?Q?4Cd1Ql6jH/LOoznWm1HQwaoj/lX/P3VsM11s27o75HEmN+/B5pEfPfHiflcj?=
 =?us-ascii?Q?FVEQkvCxoHtlWtKZcnTjNacUUfHGsuYK3TYLU+zeAFG3wyJUpP+FHT2YnxfM?=
 =?us-ascii?Q?yAiAbBq4KnNLtlG0pvjkYIvrZrLbiCReLK3dqkFeuhKSoTEVAiwmcg3sE1wK?=
 =?us-ascii?Q?ppK2tCadQYAVzszJWuJ1nIROF0KzpP7QzC+J5MoQvxSK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79e5e9b-dc00-4b46-971a-08db4b426073
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 19:21:06.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6UN7iYTUXy12fR4DgM0MWwE0otBV66XsbAjMPuFqmoae4Tcv2Qj0FzjIRaNtympoEUE38qK5iE5WSWvkSx/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3582
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, May 2, 2023 8:26 AM
> ...
> Yes, this looks good to me.  A minor point:  In the two calls to set
Thanks for the confirmation!

> decrypted,
> if there is a failure, output the value of "ret" in the error message.  I=
t should
> never happen, but if it did, it could be hard to diagnose, and we'll want=
 all
> the info we can get about the failure.  And do the same in hv_synic_free(=
)
> if setting back to encrypted should fail.
>=20
> Michael

Will do in v6.

