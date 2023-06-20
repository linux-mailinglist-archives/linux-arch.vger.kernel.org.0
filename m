Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B2737504
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFTTXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTTXv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 15:23:51 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE31B6;
        Tue, 20 Jun 2023 12:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsGGS4IbHOl6t13/pkdbEJeuIDGj5m02VQnG/ALKRlrQhGlHuDho3t6UotTFpYPNFrNB5fQQVS4MNylwwLS8wV5CUUk1dIxQ+RtjQC3CfkWUnw9PKG5c8mShs/2uilLpBtYHDsYCFDmfF6Wkc8+h4Lq9hmyZsh0rPU9HpmT0Wm8S/Cj1rG23TnvcrTK9FxotKCcsKRYGuyv7ph3R1342zYw88WGUek6x6girRNIdrDCH4PRZQj1GhYp7egKcnNTCOIjvsk6tMVpFQuyUnWTNgjn28HpQUhFA4QKZcF08CUWvTbBWyJyY4mUQVixEVZHhnPQ028dFDXwOYHr5r0Hekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQD0aGrgb5GuJaQCglfyUM68QDWyYgJ2avzA2jlUJ7A=;
 b=LqdUtYQ0/8N2jWHPEkJKZunR7WZ2jEoEZFR7MGz7JxeChyyYMu+rgdQHat/PmkR+5PA+mPO3gvbiSFgISCKxM7BjTDb6V3toVwpu6xshoWWykIW+wrwVzAerbFB1ICyOTVVwjg07KTg0XwfTaT67NwguObJYJ5w1kmPfMhCd+ejIxt3FysLbXTYmjrkTq3XabsKYx+UtXKxw6DrktPoZKJ+lhckIyyUtkXrXuDWJi92wsO4by3HCT0b2sxluYCQK9aEvTVnuM1y7ntK0Lh6l7bBoSodG7n6pn0TR4TxSxSlhywgfxzMSG6ZGAkfRhLzQfEB981/XnzfHlK+i1USIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQD0aGrgb5GuJaQCglfyUM68QDWyYgJ2avzA2jlUJ7A=;
 b=UyIE9uc4x51Kh63uhrx/O/3utKI7HxgMQVXJNNezr6B176rur/nIsZt0r3+CGVpKEYn6ZOvKyJTICLJZyEtyIW3HN4R+u6Hi9n8MxtIsM1qg5qhPWcuN5DWYy+gM3AnXre0LooYa5fBzBL7vR7oyntHeaC53EiObZo7/FXfp7iM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BYAPR21MB1319.namprd21.prod.outlook.com (2603:10b6:a03:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.6; Tue, 20 Jun
 2023 19:23:42 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.002; Tue, 20 Jun 2023
 19:23:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZo6VdzbqfjiZtTU+wNQsPRxDHk6+UDR5g
Date:   Tue, 20 Jun 2023 19:23:42 +0000
Message-ID: <SA1PR21MB13359EB1A88FC676C2269318BF5CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230620154830.25442-1-decui@microsoft.com>
 <20230620154830.25442-2-decui@microsoft.com>
 <49cb0f01-f1c2-8812-7f2f-9a70ff576085@linux.intel.com>
In-Reply-To: <49cb0f01-f1c2-8812-7f2f-9a70ff576085@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86316d96-cae1-4555-ba7a-351179ee73ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-20T19:05:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BYAPR21MB1319:EE_
x-ms-office365-filtering-correlation-id: 22225de9-d4b0-4951-b523-08db71c3dc07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjYCGFz38A79T/WNaNsnJQA7C+CKkWvpcEfmU+enORRVYXvkVGOyoB6BD+iwXQVtXzVG0YyUJcqpUmDJblwNo+6LaipbxfQ+PpI0RsvKUhSwHi72qcimiSZOjoNBCiRESXpobWQwq42YQxMs3d7tm6tFWHItJI/70gMw/WuiCM7Sqr1+I3Gj9gBrVIjB3EPPXndbRyTYYzHKbiFMC1RlGGpJRfFEM6avOnz2Ft99z2/SoNM+f2e/aK0PuPm3uQxYIub8gBEvWSDUlWbroCRhSXVIRKogbiGAOszKpRBqMssK4P+5p66KVQD+JpGMr++2eAoaXL4u3TGu22YG2OjhvywBRIYRd/Jw1fdaG0DZWNNZzkTj6UWN5IQTOw46UGhw+NHdhMUo6fWnOLgvJE9lsoYIFmNqAWzAPfdxomHX2RpxktyGdyu34u6jwKImb97/9D64/FjB8nA83+IcF65N14WvLcSg9AksLUM1p84RCK+aUY4BZbEOsH+KWAFJW6aX7maL9S+Jkgjqw8tJitblwVlE4Hy+F9Qb17w/okVb+lsdvylhhVkuMrQDWysiWkhjkgoYs2l2fK1jA/zk3W1a/FF/rGCsIoDBPkHaWU8yQNBSfXL1EOa4jutQ5Q/4sGUZCg75PgPeXEl9W4bJ4gXBi6Ysprp1fcK54hm5d/dqT/drdQ3GHxm2pGRaBiyqO6Z/4P9BQh0qodPvXmTpiv7obA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(71200400001)(966005)(7696005)(10290500003)(478600001)(122000001)(33656002)(186003)(9686003)(6506007)(26005)(86362001)(38100700002)(38070700005)(82950400001)(921005)(82960400001)(55016003)(66556008)(66446008)(66946007)(76116006)(4326008)(6636002)(64756008)(41300700001)(8990500004)(316002)(7416002)(66476007)(2906002)(5660300002)(52536014)(8936002)(8676002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSSmEIOoWMZEtHyZlivL7H39XphwLZRhugOWsFDZqKW7Oq46BF+/wbV0jrzS?=
 =?us-ascii?Q?eyfDTVsmNEjU6Pg5smMYvT5jtkns8irJc1Jv+MyzlJj9WMnoHHYNDHDtGd04?=
 =?us-ascii?Q?g2zN5nwWJu9bA7eM7GSKHFa5g8P/gBbuhjamEEmYzxMF0//fNz2B1PEDHh2i?=
 =?us-ascii?Q?7qntZv2kRKABLlqbHATURVIyflmy76/FlxUWmFYJHrQYHO0IK6xDlylSLtvf?=
 =?us-ascii?Q?DMCPT6EfnzXu01EPON/c2HvZErlqM8SaI5WSGeDe8+XPqug0Gx4RipKIYwgW?=
 =?us-ascii?Q?ra07qHFlhhZIS+CSuUe77amo3TbJIjxxy5RL9V8/km5fNo0GItSyzRoIeql4?=
 =?us-ascii?Q?QIwzICZQsR86Qn/ENIYgUse/vdaVobEEPufb3GChm4RtSUW96X6GPXbMxuqs?=
 =?us-ascii?Q?ET1MbV5KHPpFKzmVfmPMsCWD1EQ3jRXYUm3xgPSu5OU2tMhb7JBRDx+tCbWk?=
 =?us-ascii?Q?7Jb4/HBjKivnxtZQY6vWSMIu0N2WJpC5CsXqIX3GPe4nH02eNnkglz5TTRG+?=
 =?us-ascii?Q?xfiDV8jcRADTiKvfNPPEL8G0XUDEJhIcnMU4yRQu7aUEunmgHgpk1tnAbWzj?=
 =?us-ascii?Q?qunH9cCWpldp0jM7KhlszFT1tnUE9sk9LZ3K5/6UQIWXdkuvgos+863bJyCF?=
 =?us-ascii?Q?sbjEJsN226MchBFSdl3r3EhIU3VRVsddNpa/FjkYIbQOrNbIuf5/Fe7rvS1r?=
 =?us-ascii?Q?VoYdVlfaudY8LoYjlm1Kaa0zb5Dh4ie9u+z9PCJiLNm3veJsGhErKkapzjnh?=
 =?us-ascii?Q?SQWCH4LvbjeyorwUuYXav+0xbVe9VYAriLVdwtsN6NQwang6jGYiRp+YRUbV?=
 =?us-ascii?Q?gJIYAX0Q9GIdkR9ZARnGDaas4j2+kK0TZqOJxo9RGRI+pYttJOjfMY11w4ns?=
 =?us-ascii?Q?gO6clPr81MO5EL8QWkyW/JkpIJwJxTP4UAFVDxh4WoaOOJhTA0MAveHaWo3v?=
 =?us-ascii?Q?MkW39+/mfQBBbM2U3flBUfghgsaHp+uke6n6VP8FMfM8F6AZvt5J2XcN0Gaz?=
 =?us-ascii?Q?Q8hLHsNYJ0886pw4R4tMkaLX44Z2E4qFM0qm5YV9qNKacCty9mj5l9lM8Zdw?=
 =?us-ascii?Q?agiXbGbcLzPcyOYsXRKQrh68orxUriEPtJvXSRyCYgOjMQw1KqED0EeIUqNF?=
 =?us-ascii?Q?iKd7PZFgofRTQI6m9zvrBbm0K6kNLB9rkaKR5Br5Uk3IVuxzk2GP3fYZpqj8?=
 =?us-ascii?Q?K4Pdwmuo7nzGZ4huh8v4vgl7h8uVKba4LEI2WNfbRDuPO6WbMxRLZQV6OdZf?=
 =?us-ascii?Q?cv1iBugQyvfPRHDA15SOQqgP//GiEqgFOuMkHgX8BwtLSbzS/S4vZiKPaTO+?=
 =?us-ascii?Q?7LiVenDof8mr5k5kr3Nx8XtPyXGX1rMRX8TUGTKRPNfhqo/GQcfvSdwVdHHA?=
 =?us-ascii?Q?EKFE7ruYS3texGTtH4upqAiiA3Zb6OSr+H5hprney37IgE75YCfBozbQgRcS?=
 =?us-ascii?Q?HFDBeejlEke1DzrTWUfyvAxI/g6ub6y7iqwp9VaMs0gSzLbWlKrMmOgMFzbm?=
 =?us-ascii?Q?6ylmUnLk/ER3/4Y0chYVwXI/vVEjetu+uWCN9vN9naDvo5jg/gCqVBfx0m/b?=
 =?us-ascii?Q?awFpvr93f/u1TRdldy0trRmKUmITx+xO7CCVL56l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22225de9-d4b0-4951-b523-08db71c3dc07
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 19:23:42.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozvovL2LMkbDd90mG38QuZBB8j6CwoArSiUHIVdwEp4nA9vaA+wQ7HQcfFLv5DcXBKQkCyL1ErbsWSv7oWkZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Sathyanarayanan Kuppuswamy
> Sent: Tuesday, June 20, 2023 11:31 AM
> > ...
> > -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
> bool enc)
> > +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> >  {
> > -	phys_addr_t start =3D __pa(vaddr);
> > -	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> > +	const int max_retries_per_page =3D 3;
>=20
> Add some details about why you chose 3? Maybe you can also use macro for =
it.

It's a small number recommended by Kirill:
https://lwn.net/ml/linux-kernel/20221208194800.n27ak4xj6pmyny46@box.shutemo=
v.name/

The spec doesn't define a max retry count. Normally I guess a max retry cou=
nt
of 2 should be enough, at least for Hyper-V according to my testing.

Maybe we can add a comment like this:

/* Retrying the hypercall a second time should succeed; use 3 just in case.=
 */

Does this look good to all?

> > +	struct tdx_hypercall_args args;
> > +	u64 map_fail_paddr, ret;
> > +	int retry_count =3D 0;
> >
> >  	if (!enc) {
> >  		/* Set the shared (decrypted) bits: */
> > @@ -718,12 +720,49 @@ static bool tdx_enc_status_changed(unsigned long
> vaddr, int numpages, bool enc)
> >  		end   |=3D cc_mkdec(0);
> >  	}
> >
> > -	/*
> > -	 * Notify the VMM about page mapping conversion. More info about ABI
> > -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> > -	 * section "TDG.VP.VMCALL<MapGPA>"
> > -	 */
> > -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> > +	while (retry_count < max_retries_per_page) {
> > +		memset(&args, 0, sizeof(args));
> > +		args.r10 =3D TDX_HYPERCALL_STANDARD;
> > +		args.r11 =3D TDVMCALL_MAP_GPA;
> > +		args.r12 =3D start;
> > +		args.r13 =3D end - start;
> > +
> > +		ret =3D __tdx_hypercall_ret(&args);
> > +		if (ret !=3D TDVMCALL_STATUS_RETRY)
> > +			return !ret;
> > +		/*
> > +		 * The guest must retry the operation for the pages in the
> > +		 * region starting at the GPA specified in R11. R11 comes
> > +		 * from the untrusted VMM. Sanity check it.
> > +		 */
> > +		map_fail_paddr =3D args.r11;
>=20
> Do you really need map_fail_paddr? Why not directly use args.r11?
>=20
> > +		if (map_fail_paddr < start || map_fail_paddr >=3D end)
> > +			return false;

Originally, I used r11.=20

Dave says " 'r11' needs a real, logical name":
https://lwn.net/ml/linux-kernel/6bb65614-d420-49d3-312f-316dc8ca4cc4@intel.=
com/
