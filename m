Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7264A806
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 20:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiLLTS5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLTS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 14:18:56 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022017.outbound.protection.outlook.com [52.101.63.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21579B92;
        Mon, 12 Dec 2022 11:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS5ePqhqO7+QrfqWxYAby5f+lSpuZpJsKbXC4TYiiuLFvYRyzKdFiIxcfy1Z6iSjnEZA6rm6q5rCL75VzKD7nmc2pdII8+0BzR26WusyG+yTQlggx0B+PJKekFgN23iBJnSB2cSa6T2GmoPgoMLkdRHPgOTo99XGw9PJb4owsA0u7zJptpBnglnPb0vyrDx4AdZoEk7qTqLEcdOqIKngJ8GojyYKj+0v+i8ocj/1UyV+O3+9o2Kk0lmLBkf7B+h64kKIoQowq5To1LH9r4XRdW1Ybr+FsBG2l78kF5OTvAxYFGafOVxiVFrJgDVt8nL32IKPQr/ofQ1f3mFPk5y0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MewV258lrFUPKg46EtBuESZ/OSjdQU/kzT55lQfNeTw=;
 b=UHcsteWRz2OlKE998+Zjrr9rzgXQmRVy7GiP6xlUC+GHqqnzg3TuucZaQl2i4L8Vg6fkLxZm5USfio3C1UW5fUJJNtNs+d3pZunvj3pb45mgm4Fs3owTmDgqpyUbUuszBVp8k3WVpUJjbSofhgN1jlN5QVIYNne3WBL14ycQHIncYy7PYBj/ZzGETImy1tidQIcopGPPpofJwaw9A1tNqPM2F0LqDPZz4tSRtt9hNufBl130y31ygYeZwUVwvwVrOYnhsypwKPb+Ap/Od+vtqcPQshNsNfphitQ+ohTayLe44MeAvF35nOqGoVPpheiWcamVQ1pjGJbnXJ2P+hmcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MewV258lrFUPKg46EtBuESZ/OSjdQU/kzT55lQfNeTw=;
 b=IsZV/Zjp6ePHOcS7PlEfMauSWPiIPdSQdQJ0sZALWTz5oxw2DJuiWXERbNXg9UOtSkzltuf3upcbrWcOsRmdJoIg28gVAlNN2h0jlcAOuDuI+Gh9+keIbI+0zznOlydpsMaFVi90F0Ceml92sKd3dc2Gjdr7YitrR1s9ZPdUheY=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1293.namprd21.prod.outlook.com (2603:10b6:a03:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.1; Mon, 12 Dec
 2022 19:18:52 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%7]) with mapi id 15.20.5944.001; Mon, 12 Dec 2022
 19:18:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v2 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZCdO7v/iQZOay70+ESepxHwMb165qgFMQgAAkIJA=
Date:   Mon, 12 Dec 2022 19:18:52 +0000
Message-ID: <SA1PR21MB1335D873764C7440AE68E460BFE29@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-7-decui@microsoft.com>
 <BYAPR21MB168823D0A03CC3DC3E2365A5D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168823D0A03CC3DC3E2365A5D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=040aec30-5c5e-4632-b625-7fe1c0d87b7d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T16:51:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1293:EE_
x-ms-office365-filtering-correlation-id: e9f7afb8-ebb5-4e1d-ad9e-08dadc75b462
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQkVhhrq6VkGGeQER9qd5G9gqdq9foBuvViV7UnKlNL3OXL2dxzpdc9CeNNVZyd23Uzo1rMvClML17ibyWk4RNCRdpVuwCYy9/BKM9FOw2NH628cG2CB7Zt2RTFckCVcTMNGeCIEfM3GDEG2noRj5NDAzzealnhhTerdaBAHb8cCq5NtZjsf2qlDOnA3lgNv32Mx0gMfx3YtPNsVEGcA6ZFaIpiOpIZV2RQl1S4chAjoDW8gXlCtZLUfQsyOz8WvzvfOU+kH99R7uzAOZT71Q7lmgJ/FXnyQr3CT2JQ7wErVbV3tl8T+wCOVeUb0eiei34byoeLc+1OCSLLMu+r4dnmBU2f6sL5lYmlsB4ihyCGXY2yUJY/yFhnlt+bHk9HhhBK9diONWyKdqYqUWL6kGOOa2mYq4OYMjwsn2grVH88Hh41XZc9/ppIijoxOrgjYC7BFoQ6HZmLZRjRPMWKSoEgAKZsoYVUFIcgCoFCbfmFLEyvXRZryrXogE/MIgIch2lDcYqUsu+4VTVQ5+8d0kjNgdaVhcACsAmR8WBF/jSB092eUFEvsBFEKWTrt87LKhKiQMhqjrB6ELAn2WUnp37eTtoM9xUbuTEj0V6QxsY707LMoXpxyKsbf/8Zz05njl+yb2kPV3E6U9d4JWCFxM7sSz+HbUklhnDygjOxslDJy1stid7i6xRQZuDYWM/VRCuMRXwIHyTuL3IcOxawiq8xoqDRbm0z+AibhYPEMXkEVszTuJEeLMNNbxCkCkcMzVjXH1nuEDUW5oH0b+n8e7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(7416002)(2906002)(8990500004)(66476007)(4326008)(66556008)(64756008)(66446008)(8676002)(41300700001)(316002)(71200400001)(66946007)(8936002)(76116006)(10290500003)(110136005)(6506007)(7696005)(186003)(33656002)(55016003)(38100700002)(83380400001)(478600001)(9686003)(26005)(82950400001)(82960400001)(122000001)(38070700005)(921005)(52536014)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5W0hbJctrsJgeIsaZOLE1AW8K9BnPo5ylO9CGzOAjVqpZdUmlPag5JWa7XAt?=
 =?us-ascii?Q?GEtOot1rqCwLo/CGOai3WGWwWEyUZ2x67Qa7ETKUh5UO8PUd+nibIuRFj3QZ?=
 =?us-ascii?Q?rgSWbZ1siWQB/Sjob6/d6Shf+Qd4JgkJ86a/oL1sPOPyfDxeR7/eVFKHO9Xh?=
 =?us-ascii?Q?5nlU/e8U4M1P1SW9p6rMV3AE10rCKFItQM7Sx0c2AEiprjzgAENN37a2f9ux?=
 =?us-ascii?Q?SfSz92oCn6hZc5PgH/V+wm8+x4W7S6tv8HVrV2zFqoZBDKZ784VpURkvVY/m?=
 =?us-ascii?Q?FdzfNqnfIAs8Zipc5wKU3ywvha3/WwgAfe4Is9fnQ0dQSppxW6sxYg7r3l/o?=
 =?us-ascii?Q?5Mh43BPlWZCLCSyxUMb5gOE9vDbY4bAHDtnAX6RWzEy6aSjKY6PAYSHeXPIE?=
 =?us-ascii?Q?+BF5915UaSbaJkATYCjIDstvkSy8gbT+KIS2+zi1iz8TFc4i/c5GAMsgvwdB?=
 =?us-ascii?Q?UBbuZBCeq1O8kY5C24xNi/RwBX4PUFIiJxLamLDWv/87tQ/mVmhjqO6wKToo?=
 =?us-ascii?Q?WGRqIGuzNAa7hyEENqIG9Tb/GvxjoxTZnGQie65XTfnYIAExe+atvFoB1eER?=
 =?us-ascii?Q?G96M2moFHahQu47GnoIVjbbQe6SDdNEQ0nxsbBXR01eXVwbTl5dHpDPWcbh1?=
 =?us-ascii?Q?Zr26a5sEbNIxJ5V8lKOJuBFlGY4lXYx+tm21qMtsbo0d0QmLw7WJAsguweNd?=
 =?us-ascii?Q?e4B3LquLjC+FQx9CXGIqe6x8CYoK0uTAIimv2jU1KU7Z1XuLYZjOZaXRnQlg?=
 =?us-ascii?Q?xq/mrUK8gkfqTMAw4xXY5dE36d47F/tP/aZx3nlfN0OsppRQ5l7FeVEoyTEU?=
 =?us-ascii?Q?z1rPTHlc0fvJj6HitCt+kqWePP1VppKYSz0G97wWljIEdCZdXGdTcUMdrrix?=
 =?us-ascii?Q?qCrp4X6iTKI/BKFTuDdrhNkJOPldQ0uwZfrbzZVk1l8b4LySSxRNAQRctVV8?=
 =?us-ascii?Q?ZCx5nYBiCfMCUeW0/IgNUyXvsa9/uujsZ1HoFPq78+AkEC8QGX3n23ozy6vd?=
 =?us-ascii?Q?Z/LYXgQYng3bhcvdTVzupfzHM7p97MdbdcjS99K+ng7GA59VjUfNghybW9Ch?=
 =?us-ascii?Q?nXB2IZBWaG4f7CLNc2OqGCyGro/QpVyNRXL9h+OmdyVCUxTGzbJQzcO4hoKA?=
 =?us-ascii?Q?taeWSjSyYPsJ1KoUlPpBB48DoSXBlFzNIajJWMZMfXCgJi6bNAeSATJUCD7b?=
 =?us-ascii?Q?ELOtYZET7BcLkEPjNPx8BGsR8Mw7VkXrngzgzSRpP+S9aCkuslJAKYcMGVlI?=
 =?us-ascii?Q?I80CD7nbOEMhSjhyhaegyW2+V98SgRuIzbFVEYaRGTg1z41jQK4sZC87hZ1L?=
 =?us-ascii?Q?GKmsjs38SKIfJnt4OkMxUaw+4MTRbXii28K03KP8iTzq1Essa/f9IjuT12fB?=
 =?us-ascii?Q?0qzqSXnj7DhMcFPNtk+jgVz9l/Y6IwSqwHGOd0KtnK1G2eQ5oRWlX8tY74aD?=
 =?us-ascii?Q?c0/Rqrw6aWwh+tQiK1yMjt3M/a4P+CffNJRiYD2GkumE9h6E2OmoSFTvEXKE?=
 =?us-ascii?Q?UA7ATfEi/Wg2xAP4zjmRUPUQaRH81YuOrUnRwy2y6lOR4N/4S02B9CDraqnB?=
 =?us-ascii?Q?L4bRxyxYKDwLcMYxPkgMNW06EWosqpQvL6JbQg8i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7afb8-ebb5-4e1d-ad9e-08dadc75b462
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:18:52.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRgMLiDA6bEt/Lbi8SqF007z+ciisA6m2plciRmbZoRz1gYzd1RfRCsQm2QtTRT/ZqPloARnmKqs6FNV41xwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, December 12, 2022 9:02 AM
> > [...]
> > @@ -225,6 +275,10 @@ void hv_synic_enable_regs(unsigned int cpu)
> >  	} else {
> >  		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> >  			>> HV_HYP_PAGE_SHIFT;
> > +
> > +		if (hv_isolation_type_tdx())
> > +			simp.base_simp_gpa |=3D ms_hyperv.shared_gpa_boundary
> > +				>> HV_HYP_PAGE_SHIFT;
>=20
> Since we're using cc_mkdec() in hv_do_hypercall() to set the SHARED bit,
> perhaps the same could be done here to simplify the code and avoid the
> explicit call to hv_isolation_type_tdx():

Good idea! Will do.

> 		simp.base_simp_gpa =3D
> cc_mkdec(virt_to_phys(hv_cpu->synic_message))
> 			>> HV_HYP_PAGE_SHIFT;
>=20
> cc_mkdec() does nothing in a normal VM, and vTOM VMs are already
> special-cased.

This should work for C-bit SNP as well (clearing cc_mask from the GPA
doesn't really change the GPA since the GPA doesn't have the bit in the
first place).

> >  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> > @@ -243,6 +297,10 @@ void hv_synic_enable_regs(unsigned int cpu)
> >  	} else {
> >  		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
> >  			>> HV_HYP_PAGE_SHIFT;
> > +
> > +		if (hv_isolation_type_tdx())
> > +			siefp.base_siefp_gpa |=3D ms_hyperv.shared_gpa_boundary
> > +				>> HV_HYP_PAGE_SHIFT;
>=20
> Same here.

Will do.
