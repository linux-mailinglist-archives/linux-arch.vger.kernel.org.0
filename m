Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95907642F3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 02:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjG0A3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 20:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG0A3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 20:29:31 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1642135;
        Wed, 26 Jul 2023 17:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8raw8XDZ6WuYFBrS+M3x62VH8Va1G2oexKi/AAhp0MQ3e4A1c8j0ox7HnB6aVO4fDJtacUdEtuOI/wH/BzKf2vZ1rFDQz/SYtrGZS89bM2XOxxxutGmWGX6UqR4syIonN8Bdyil2iDKpWk7HtRqjKnqtN2EtE6LKhL6IuHpAkXiRlMyLMmAbpKu+UR//ZjT3L+FOsvkWL5lr2uQh5btM4kwDkH9xlg2SyKigxQwt+Mul7cNTIRgZqp6cy0KW5GajLdjO9FN+YFqk1HFJ5Kiom/un9ZRm6o+8uo3OacxkkBMh5UIhSL8rQIFY24ZkZ/PRT1k8dXadz4dyYmXGOkdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVyEjFi0CzrCbCunWuCh/ZQY/ZIA60XEkXKaSPfQmc4=;
 b=Au506n3DGgEGSNHmWiE7PakXJSmG5FkFRWnW0u9khp2HbUszhpRxtaewlIzDgBDHFxNfvEPsWHRZzzAN0/SFt6mbCdeshDPfq1jNsVq6cJtjM0k6gOrfAk578K8FJT2/NVD/7EdGtSkl9UTzGMQ2kZ3DjBNDBJnDqKFY01oPY4QA/BVo/hoeyHkyNIffRkpSCroULqlmQozcycdTY3Y8hEu1WGJ6Rv0kFLnIQupDnzYud4pwcemvJBjDyYQCCjJPtiYMJawafzyuwemt21nEgCyb25F074ud6tWNKQIBwRfXHYAVbfElGn97oC0gaH5p0fE3Rxr+o5yN5s46rS4OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVyEjFi0CzrCbCunWuCh/ZQY/ZIA60XEkXKaSPfQmc4=;
 b=d9VOhswWQP5/56pRsNfcpHQIM/5ie4Sa75VW5hqYo+RnxEoDQQnECCcQhoL1ki8vjRk76B9OPw7Q29lWo5Re9WL2tx0r4xhecu3SrHWmMdwCgW4KpQPNeAZQ3Mg2iyjJkPXndu/WZvzMKewbRPOZP4ncxkmOzTikAS+e1KWPVS8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3244.namprd21.prod.outlook.com (2603:10b6:8:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Thu, 27 Jul
 2023 00:29:27 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a%6]) with mapi id 15.20.6652.002; Thu, 27 Jul 2023
 00:29:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "Sebastian, Shiny" <shiny.sebastian@intel.com>
Subject: RE: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Topic: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Index: AQHZqesomMpIPtubN0K/S6c9+nGnj6+gi4RwgBLE6uCAGZ0BIA==
Date:   Thu, 27 Jul 2023 00:29:26 +0000
Message-ID: <SA1PR21MB133587976F510C3E816E6583BF01A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230621191317.4129-1-decui@microsoft.com>
 <ZJx2cm1HaMEcNIYy@liuwe-devbox-debian-v2>
 <SA1PR21MB133517262C2D1DFB881BE8B2BF24A@SA1PR21MB1335.namprd21.prod.outlook.com>
 <SA1PR21MB133517719A03FCE05A9251C0BF30A@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB133517719A03FCE05A9251C0BF30A@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b79af80-4a3e-40cf-8e4e-0deac849eee3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-28T18:38:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3244:EE_
x-ms-office365-filtering-correlation-id: cfe174ae-731e-4e1c-0a25-08db8e3888d0
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vgl0L5ia7DQGBTCEhdlAK7x55yJKieCY/7A6YtrMt+sFwST0k5vaen1b21pODDjffJ35OLXVvpyWFHKDxQxAfdkmmZHSFqZ2fnaJWYqpOl7U9omm7+Uzy9AA/r2kAL8VmJatEYOLX3tzANAUH5++CHJwYhcMFkiYVRSA5bA2COCzcqEjZ4pB3fjnuMA/6RX5Rrh/9SniqmmFIL4VDp2lb20DlVFlX9VjVinGzR42QF4FWxqYYAGrjjHgoS3ZLBDgXmyL+ScPIUOOaYqqgsJsaHoqurpgyPEQAzugtRYZ8SqrYffcq198v1R6DrN6scxTRNIGBMgaAr+QGbSy2dBsEpHC2ob86qU3qdizHZk4fcofsBc4WgTFotDOAOdwrQXx/86oQj6uJqbU2fsTPPs0Fja5QT25DAkNw7Y9hyZxh5B8QB/SXwlTReQtJ+NH41cimv3zdRnCUIrKenYYvG5JGH95HUgkOXtPDd5rw++EJe0lBNNqMuxv4cTlZxj/E1ecJn810OIe3HGqYet6WfMZNGZN8ADzwr8Czs2XB1jEBOJ0uPaBb1jGlkpwQ8K6z8RwjR3voruT55X6Ugj7ZdHIEa/kbPtmxTZBhs2z9eNKfGC1LyeNg/2770KjhKf5dceX/YMLXOU/wDE6j8odGd+1ZjDRqkKE7uPjsEQ78DE1QXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66556008)(6506007)(64756008)(26005)(122000001)(38100700002)(186003)(66946007)(9686003)(8676002)(8936002)(41300700001)(38070700005)(7416002)(4326008)(5660300002)(76116006)(53546011)(52536014)(66476007)(71200400001)(86362001)(66446008)(55016003)(82950400001)(82960400001)(2906002)(110136005)(7696005)(10290500003)(8990500004)(478600001)(33656002)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ah3koPN2NfJDlkmyEn2Ncm1GagaIxrgbmH/Qk7MLBFi0aDuwuCR8WEf/BDQD?=
 =?us-ascii?Q?PHMoOh2s/3b+A1M+1MjjfgB8B3gar/xb0KXbUUmzthPMVvVCIwYawhLORziF?=
 =?us-ascii?Q?l/lf3FB7ZpzMQmNAg98Hu2KIaeMyR4gzUMZ4cSE4GFPmyXfFiujILd2Gpupb?=
 =?us-ascii?Q?8xz1rDAmLFgIgk9J7Vdf1XMK6oVOCAwZ6EoVKM44LEBpXFtS7TTAdaEWlO9Q?=
 =?us-ascii?Q?sGC082/RqBJi+svuFIuGnwYxQzgc10wS7jXLMKYCS0ccCu0LmW3H4VjXgNWW?=
 =?us-ascii?Q?nXXHDR/r15Fg084gA6dm48UzWXs+cEG3q5Q4lVhWk9JxU1BY7N7zXN5NkFNW?=
 =?us-ascii?Q?VsquSq6WC2ewGtbgp3ceg732bXU5eEY2f1cVThnFB+S5tFDVTkzH/c8/rL49?=
 =?us-ascii?Q?1Mkas2cqkV7kdHc6/Al0t6N9t+lNO+7ztwm2Qx1JpZpfkI4NAqqAXsz6vHaw?=
 =?us-ascii?Q?fFyL8nq5+RT2ocqtanQPktlJiq2P2JYhajR4zZWkNnZ3LK6giHhoCYe10cfA?=
 =?us-ascii?Q?siM6DGNg0AsJdmAemWDrMSMjxZpVjcEB3SyIxtO3OhgLS+3myxxUDHxA/Jg8?=
 =?us-ascii?Q?w0ynvIXQMFzAH3r/Fik+ov+TqV+SBqleQ2oI8PPn6v4+dsKBHlClp/YdDvWV?=
 =?us-ascii?Q?RWX8cu8W5YsV1F+x6KKZ7R9cISitUtuy6v/Ewm+bLT6TQRKKjxrXPqobI6L2?=
 =?us-ascii?Q?7s+9oi5bSRjEtfdIqCMkdlaykL4Gs49MxX87djONVUCohuQUX4U1Ald4cpCQ?=
 =?us-ascii?Q?0AT01e+ERlYzFyGeH/TxjyN18o8wjvIplG+G7mEnQ9YfwTOUQh7SvEv8N/a2?=
 =?us-ascii?Q?L/cYcRa4897ln8da22Q2iGBFDZk2nyidZmv4jS8JC+nO6N4HrAuo+LtPVm33?=
 =?us-ascii?Q?+YXTjdAsWKbQgqryIjSk5INRkHHtKD2WYVCH0qeAJOUGZT7o6H42FpQOcw9J?=
 =?us-ascii?Q?tsqN/lilJY7XDxHtXYU2OAfBLpL6uwLQpzY/Zql0bLIItqe3DEwzQYzT8yuF?=
 =?us-ascii?Q?bduxBKDFYLWtCi6qNxPxKnkfSEIAJ4b4BqG9pbz3GOg77UNVcvePdjrSk8wq?=
 =?us-ascii?Q?Gs+Pvw41Yd3dhQkM93uJgCSZmHx0/r+K+V7Kf8LOO1YeSQMkpDG5pSMgDyo1?=
 =?us-ascii?Q?HZK/4YsxZ5H6pknIprwTBA1rUjBHdfqDiSmnl9+Yh4N62YLy18wzpUZIB9uJ?=
 =?us-ascii?Q?Dqr3r3LqTPUHLHBCdqQUe1cwYTpLC13J7yOSNjAcOo5YHhbunnXIlGplp7mG?=
 =?us-ascii?Q?VYNHxYBU81tJtAlrliEColUuxjmymHlhqaUniRIQMUY1+32+/0CrrxdGwQSF?=
 =?us-ascii?Q?ILL5lXW/QKupkgK4T5K5BODMCPJQbN3RHEyY68pJhbZKoaB5XL6vFocUYFB7?=
 =?us-ascii?Q?GsiebE9hS6PpGbCXKV0qEjaNhBS8FLmH/b7tzkUBc+UgvNyb7rOv7tuol1tZ?=
 =?us-ascii?Q?B3ZyG1dWT4kEw6bolONv3ui0q2At+BO/v+0rK4pZB6QGhOtVwsC9zl87PTxk?=
 =?us-ascii?Q?DFuH/GAx/U14ofJf7f7mNerjHwPZsFtPRTDdolat69OiEuN2iyxpTYWqxsJn?=
 =?us-ascii?Q?HAmnrrtvTwPAEtKILS4FHd0HbfKbmCrpcnJ8zzih?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe174ae-731e-4e1c-0a25-08db8e3888d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 00:29:26.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILTZhESEzo2tCTLwRdsKqcMnaUVnslXdaf73YmadDu08E0XYKUsv6TmxEAPurtPXYT5QbD7U01BcSRqC4/zpiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui
> Sent: Monday, July 10, 2023 10:21 AM
> To: Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> dave.hansen@intel.com; dave.hansen@linux.intel.com; bp@alien8.de;
> kirill.shutemov@linux.intel.com
> Cc: ak@linux.intel.com; arnd@arndb.de; brijesh.singh@amd.com;
> dan.j.williams@intel.com; Haiyang Zhang <haiyangz@microsoft.com>;
> hpa@zytor.com; jane.chu@oracle.com; KY Srinivasan <kys@microsoft.com>;
> linux-arch@vger.kernel.org; linux-hyperv@vger.kernel.org; luto@kernel.org=
;
> mingo@redhat.com; peterz@infradead.org; rostedt@goodmis.org;
> sathyanarayanan.kuppuswamy@linux.intel.com; seanjc@google.com;
> tglx@linutronix.de; tony.luck@intel.com; x86@kernel.org; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; Tianyu La=
n
> <Tianyu.Lan@microsoft.com>; rick.p.edgecombe@intel.com
> Subject: RE: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx pa=
rt)
>=20
> > From: Dexuan Cui <decui@microsoft.com>
> > Sent: Wednesday, June 28, 2023 11:45 AM
> > To: Wei Liu <wei.liu@kernel.org>
> > ...
> > > From: Wei Liu <wei.liu@kernel.org>
> > > Sent: Wednesday, June 28, 2023 11:06 AM
> > > To: Dexuan Cui <decui@microsoft.com>
> > > Subject: Re: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/td=
x
> > > part)
> > >
> > > On Wed, Jun 21, 2023 at 12:13:15PM -0700, Dexuan Cui wrote:
> > > > The two patches are based on today's tip.git's master branch.
> > > >
> > > > Note: the two patches don't apply to the current x86/tdx branch, wh=
ich
> > > > doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted
> memory
> > > support").
> > > >
> > > > As Dave suggested, I moved some local variables of tdx_map_gpa() to
> > > > inside the loop. I added Sathyanarayanan's Reviewed-by.
> > > >
> > > > Please review.
> > > > ...
> > > > Dexuan Cui (2):
> > > >   x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
> > > >   x86/tdx: Support vmalloc() for tdx_enc_status_changed()
> > > ...
> > > Dexuan, do you expect these to go through the Hyper-V tree?
> > >
> > > Thanks,
> > > Wei.
> >
> > I suppose Dave and/or other x86 folks would like the 2 patches to go
> > through the tip tree if the patches look good.
> >
> > Hi Dave, any comments on the patches?
>=20
> Hi Dave, would you please take a look at the 2 patches?
>=20
> The patches have got Reviewed-by/Acked-by from Kirill, Sathyanarayanan
> and Michael.
> The patches can still apply cleanly on today's tip tree's master branch.
>=20
> Thanks,
> Dexuan

Hi Dave, kindly ping.
