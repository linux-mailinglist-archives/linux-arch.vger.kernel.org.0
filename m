Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63963E08B
	for <lists+linux-arch@lfdr.de>; Wed, 30 Nov 2022 20:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK3TO6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Nov 2022 14:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiK3TO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Nov 2022 14:14:57 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021014.outbound.protection.outlook.com [52.101.47.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1F63D51;
        Wed, 30 Nov 2022 11:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba0gyn6FK9m3Z9nqTwQlySe2GVD4rDTgQVpc1PlkVuzCEZZDwC/n3+u2/FamCMcMlPHMrb2BSIkDK7KzaugDxwoMhfg325e7YAVUu9s2v4jFmASm2Gxj4YD3TXyGKDgUsBnlwSdvM6fQDYvSO+kX2mzIDVG3MZ0wxYof6SQgPoLBVEhnm5ARfhstKk1oCY11uW11YoV1GPCGm1Qp6hrAE0odunYeK25vjQQoRA0g4YO3TfFZZEoO1elza/wNwE55mds2+TALgue3JOhUdGQjLLUm8Dq59exqbuaiL8PQPiHNQAHuzSpLSHgCSiGIn3wHL1j4m6VdwtB+o3s1PdRgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1saUKoLD+lkOeH6BblnTssOdomK+uPEMFgtoFpMt1s=;
 b=ZjW9MWMu+w/NlYqc2Qb1EXt/8i1OJDgbEYqumTzulKs9rIm3iZaGvPoUfp+63UVR8Y0vzYj/RlSGpCYT/PHEaxDzlrpvn7xj2GM8gXeAJffq8p9ga3iSnK+dw806FXvUgptENLH0V/SGmdMZNMItefgaeTXN5Ys90v0BOYUW6fiH5Lapf0V1OFqvopl93gRVrTv8HeXH8SAbd5xto7IezP8bAbwNThycrtyW/4AGMVLKv0BFt8jbfOdDN4eTZWRKUNEy2M1ErDZkrIvO2EoDbQgz/W3fJ+4sJ6wpVZVcX8Cch1szmlH71r+IOucGvQ44Ltnn8f13cYNQO7r3Ljk9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1saUKoLD+lkOeH6BblnTssOdomK+uPEMFgtoFpMt1s=;
 b=RDhcAYkPSBdhmediXHaWd1cp5N5rb88uG4/Isxcgu+nb8ZAf4KA/izP3vo/4iPOkuxQsdYu+N6bIjf2dFkkJbhSbZ5eyDlg77HUNwDW/064jBqK3rb2YkvFkKWyn1PqYLJVvTm7rUyj4enOWBFsipgspUboKQwEbqGtQ6GEwpv0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CO1PR21MB1282.namprd21.prod.outlook.com (2603:10b6:303:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Wed, 30 Nov
 2022 19:14:49 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5901.004; Wed, 30 Nov 2022
 19:14:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'Kirill A. Shutemov'" <kirill@shutemov.name>
CC:     'Dave Hansen' <dave.hansen@intel.com>,
        "'ak@linux.intel.com'" <ak@linux.intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>, "'bp@alien8.de'" <bp@alien8.de>,
        "'brijesh.singh@amd.com'" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'jane.chu@oracle.com'" <jane.chu@oracle.com>,
        "'kirill.shutemov@linux.intel.com'" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        "'luto@kernel.org'" <luto@kernel.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'sathyanarayanan.kuppuswamy@linux.intel.com'" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "'seanjc@google.com'" <seanjc@google.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'wei.liu@kernel.org'" <wei.liu@kernel.org>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Thread-Topic: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on
 Hyper-V
Thread-Index: AQHY/elAG0JYcbbfGkmNBxJJMMwuJ65LuIUwgADeyYCAAEbnMIALBXLA
Date:   Wed, 30 Nov 2022 19:14:49 +0000
Message-ID: <SA1PR21MB133594060B7EB17CF1FDBD95BF159@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144043.ne34k5xw7dahzscq@box.shutemov.name>
 <SA1PR21MB1335EEEC1DE4CB42F6477A5EBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335EEEC1DE4CB42F6477A5EBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9781b948-f20b-4377-b29d-f930da102b44;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T18:54:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CO1PR21MB1282:EE_
x-ms-office365-filtering-correlation-id: eaa26e5c-1796-470d-acc0-08dad30726a3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufNZyUHsrOm7HKWnbJRDiQ4WmierTqkAuyWK2xfMiqajipYnxshxiwz13yEMSyQfyG1HRPSbD+7oVmO+4UNLfwioLXAj31YX+HCXOVaI/gyJ8yLSvC8E9snC4JUMz32m/5+vrNNymNdYr/9sOVT60GljK/zwLvV5o5ge/M1Y44OctStjDRhwu501vf8Z8eyZtJfpHjCO0R0oaOP+CBjvKGmSShPEeW3Fka7qPlwBxK1H4ibb1wD8EQA3v2fjd68NT9eXJtG2KgrYY3fiDWyYlhBh5g1OPZf0XExqCFjHXLzFQxfa9B64REK5DO1BEHpP7g4M59TyAVS4qMtdepqwEm9USLMeBEvavMRWP2JvRhSyf0dK+Z9AD5J19dv7QdbQjX1DYJt+svJgPVV3dIDd72DYACnTVCxPXVEvyjADCGAfJSxSWfNSZYbMarRi1Whg3ljDhmdMNhD3wDYEXXk4LLiwYyBymyYr24R+FkeRW3jkQlLxzxTWH697SCOHkZjnlF9jj1RrOHppki1UyDJNygO9i7hJqWSxVX3WNzsjktpofx2yXIvYQRb6KSgGbXyqxtwjYI4x2PCggUaJhgtKosqLe8GtmH36bqrWj/LQDP1i2wXmetVroT836Vyt2jyHoP6gyPCVJKJE/x7EuJptF6YX+HJxZMKPCBhqjUcxq23wUSv5flXUwLfCKjpHIxayDDTS8qGT3paRKwmgPPImNvCd+O/qH6NRU+ByNUW4M9oHu51+GAG09O+HYN9D1eZk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(2906002)(8990500004)(82960400001)(82950400001)(4326008)(4744005)(86362001)(52536014)(66446008)(64756008)(66556008)(66946007)(66476007)(76116006)(33656002)(8936002)(53546011)(41300700001)(7416002)(5660300002)(8676002)(55016003)(38070700005)(316002)(6916009)(54906003)(478600001)(38100700002)(7696005)(26005)(71200400001)(10290500003)(122000001)(6506007)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0zOPQ2M/Hd96T9M5O+p2UlOOWaBrjVULgpb/DuuZtCHzE3xvtUkQxzQtNTqL?=
 =?us-ascii?Q?78r0bGgKaBfGxYjktOW+8kxZeU55t32VW5tbqhgsNZKqbxtqLYlUbzxPsQhc?=
 =?us-ascii?Q?edYDbbjy9Au/+TZCLwJtk8eS06dV/jK0QAC0F271BruER06+yyv8Pk7s+VOR?=
 =?us-ascii?Q?9fRPJpCy8VpkDLDTAE3hgxI2okhA1EP0v+NX+YlBZ0XAFLoyZRM/jCYBij1H?=
 =?us-ascii?Q?Rgw+ZCWebHeH4/mFvDQQILnr4m5KEzPlaqNX+vr9r69aVQiW5NgaXKDamLIC?=
 =?us-ascii?Q?ZuBS7O0u/W7sDqWKJe7BpP2SKw4mH+OUeprp79JQdymetE0eZP1MV+EqugRu?=
 =?us-ascii?Q?wh7pv+VBPlF0aCAJkKx/P6ukn4gp1fTpROusbNzUKJ34Ap/LtSIfzrELZ5Al?=
 =?us-ascii?Q?aLSadrY+Y0CW1YwFdkz+GiLCUfctZEd4Nz1bK6IOpDg1kgwa4YDHoLsAgT32?=
 =?us-ascii?Q?qQ/AQQEOUigbh19Ak+cH0OF6/o02z3VT9KySZxgmahJUyKWYDgutrJpwND+C?=
 =?us-ascii?Q?nEbGcIkdmB3Xbrt4i+D2QbIU46X+5c37rVvWC/HNCZcDBOffQJdg/wFdSHeP?=
 =?us-ascii?Q?Wlne2gPXxmDHv/B47OZToA8oITRg4udO/TLlfhkGyNokjHrMA6/aUJSq4cU5?=
 =?us-ascii?Q?ZogxHogz7cid9ZcUa3MjB6vjzS1/sWiCQRHtSwZHEjph84n9P2ybE4kN5IGX?=
 =?us-ascii?Q?uEHHm8VkbwYFbVr111hLw2R5uYbLsmzEC4jH15RvNumKMzAn5dABk723BNwS?=
 =?us-ascii?Q?UrvKw2AM2wohpGSF/RfLutKoC2AMemUZ00tXqVHsRcohUsrTGvki2Wo2zKom?=
 =?us-ascii?Q?lUTKiux/UFoBsaTk77GaiDKu51fTXfA/FVL4CoiywHhQLDvAoSIXqI51K59J?=
 =?us-ascii?Q?phEby6VM0j2i+4ioHlynw+K26+ghg2ekSFF1UHa4XfN1m2kj1zXg6m4HRXbw?=
 =?us-ascii?Q?uV+SoeG39c0UMmYnqU1d/YbacwFP1E7bgxRXD5vDCssNxCJY/9imiHCr630b?=
 =?us-ascii?Q?/VLiYagJd0LI10HMOiK+bDHOuJk+PRzHIagAeRRmyDvf27fOZVs0UmIFWT14?=
 =?us-ascii?Q?Efed6ZGPxf91QtpIAd6N0ynDCVdHJ5ZrkoEy2X4cnoVs5r+mbeMB9+G/mlFf?=
 =?us-ascii?Q?j+HLEpwTCsqcO4YSG41T6+vTmUw06w8NVz8XgsVRWiHvB+ffRKKvGK/r30oR?=
 =?us-ascii?Q?Xm5CMmEtDzoS5Hyd5G3MJKITG28VQcMe/nTv7mmOLSv5POpBjGsFu0CfufAg?=
 =?us-ascii?Q?rTJSUWY2b3GiRAjWJkcTCpCq/DvU6cRMs6lL/N45JDnBxFiO46rFcsadpGGv?=
 =?us-ascii?Q?JYyM+azUqLTgWS2OJqyRxwaIFS3EGsiX5TFVok2eD4WYPLVg/td+0MqCjlsc?=
 =?us-ascii?Q?Ljdurcw0/Owlga4E6fRpahjoDeAe1m5DIQ7y+mn6MC5lLT4/jCgYPAaPh4/Z?=
 =?us-ascii?Q?eGhXPKQKb4iw//JCxZj42tVRhogWjL7iS8zWaM/ubZoKN7rTHM8guHGwuWku?=
 =?us-ascii?Q?j1ZUW6P1PuTr5WBSCY6++Z5qTATalnZAa+QR+RMGyZwIIa1kviOXDGSZDKBA?=
 =?us-ascii?Q?fxez3y7t0F9XSyhrutLK/5le8Z2Q4h6yHKAxFhBq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa26e5c-1796-470d-acc0-08dad30726a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 19:14:49.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gt09ZewaU3tddH6AQImxlmbprx1NmTQvWHwx6mW3GgT1Bk91ltqVZt57HIENhQuwrGbb2IsenLOqt7hBWeWY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui
> Sent: Wednesday, November 23, 2022 10:55 AM
> To: Kirill A. Shutemov <kirill@shutemov.name>
>=20
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > Sent: Wednesday, November 23, 2022 6:41 AM
> > [...]
> > I have plan to expand __tdx_hypercall() to cover more registers.
> > See the patch below.
>=20
> Great! Thank you!
>=20
> > Is it enough for you?
> Yes.

Hi Kirill, it would be great if you could post a formal patch so that
I can rebase my patchset accordingly.
