Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07902639EFD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 02:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiK1Bga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 20:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK1Bg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 20:36:28 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020022.outbound.protection.outlook.com [52.101.46.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C36B7F8;
        Sun, 27 Nov 2022 17:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY+WaY8L7pITi5nxst6ztcRpbWUm5RfXRVFDUSYT0iIYauvYbzYAZupMCseSkk6RVg0oANUrxmYWNfFvXPoYU9dDvIKReNSFChBL3jZK1z1v7llzkJxBO7sZUEGiR96x1rfSmoVUsxDi/s6e5Ooglobp4gzrUju0MuvrGlgKLuJK058qwGx3bDqmQOFYDJ67ygpmq2Lob1rO+L+q7bNrOmPzySBMt2oK0QfH/BGmbYJBU0XIQweSqJE7wfQ6fKpEXCsJLvqSs1pjbPPOiMU4aC2M3EroOgDoyeEIPNdJAfbFrEZyVeK0H69LM6MmR+WKBRDATFJDOrUsCLHdTo/1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw03eYe2731sjitWsiw5XGojrKxZY2tKDhhtO67I9iY=;
 b=lbeJ0R4VTNWgQiKEBQGwU2H7iP2VRvjJWliRckqDBOqJJEFzwd04DRL/0ETf3Ifhh5lzDae4oPZ8Bu5QF32yJtDvfDQL88XJyNS+Apm6a/c2cCwtDzFHXk4cogX/Z2muXIptK5y1C7z/KEq1L/23rxdKNdoGdhU4lmLrXanJtnUu2j9ZihFdu5ENfe+wzbflirJdJ7ZtZSKLScSoEpb/4qO5hvyaVkLUL78frsfOTtVWKr/pTjiL39hENhWW06XF6pUrxDzhUFzqDcpC0GLkot3XXIj8xcptAdeJllSDv9mMt3TwhZ1bO+sUTmD6TZkONM7NPw3o76wYU896tcSJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw03eYe2731sjitWsiw5XGojrKxZY2tKDhhtO67I9iY=;
 b=dLfhgEIcWE9dMU1lRHDw1GQt0N6lxS13w70dLebnEjDWd7Wnx1U2FpouaV+orITzp9jDJa8lE13etAL9EN4xoIEYnWZWi67cK53DL1q4f3QF06CVICaKnDp8kb4RuhmRt5Bnr2cOSH+gcAsf/KVnMEDhiGg1yFo7E5+oVpMAMi4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB1938.namprd21.prod.outlook.com (2603:10b6:303:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 01:36:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 01:36:24 +0000
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
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgAAHXwCAAAQAEA==
Date:   Mon, 28 Nov 2022 01:36:24 +0000
Message-ID: <SA1PR21MB1335BAE56BCE81538E220B47BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <BYAPR21MB1688A412FCBEBB3189107102D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688A412FCBEBB3189107102D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a799fdd5-3e93-46b4-b0f9-8dd673651b98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T14:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB1938:EE_
x-ms-office365-filtering-correlation-id: f844918e-7a1a-4f37-64f3-08dad0e0f5da
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66lRQh+ngp22BfurxNHgYi49+Kjz7Gyrogvge0zpXiXtnUCUMvRkUtDH/X/zEm+9G+FtsuZowaQFlcGqNwidVq1e1l5gNZenTB24mSWNfmZl+Z9GHmOgzEJRS096yUqTmu/mYq7g0iX4riuA+WvsUUNLVIbkayVxMbmo1ghxWOlN9eRwoj89j3KlJWBhlA4oEokmV+t+zp5QACOpQSwWU4zabJoEQbP+pWWp40wnKmmU1sVFqT00nWSMMpU3UvBrQUVzYna5zXg/L4+TlVUmTaFVC0TvwZTM49/aq/eIWfdcG+BKcxo6RDdeABNfVNJq8Sg4921pBBXXFO6xs+evKtCqrsPgE6BpkZ9N6J/1/mUEC78Z9Hnw26WH9AmNF4hR2AJsZ+bTbj59vBhYZaHQwK8ActTW5bV6Zf31Q1tsk0zmW2Kma6X8m0yyqSywUBWXn5h5zqFFh9jd9ufNDWT46fsIgmnwU2YsUc/6QG4+T+/W2z1SFRFyvdbz0PorKE8gOnl5pNyrUnwchPCQJLSvbdPJteJZ246YEOmdF6je82y23jipzWLsYLSnQbSNigS61LPdgOaaTHq+soSJd9RusdRm6Pc65iUdKHanWijldrqDdefkgdNByJ8XlkDM4Di3Og09uchZQh3FT+kjhqWy8XWRd7Dzx6vTyB634d2ytVEh64qOCEzH+06ramdkWGAtkZEai3HZeuDlr03C6fS04pEIXD8HG1H+2GQwgIsO3kYvSiNYp6ZBANMWaVnC0c2IFNFyrBfVY59LWT8H9bgjhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(5660300002)(26005)(4744005)(7416002)(33656002)(55016003)(316002)(9686003)(66946007)(76116006)(66446008)(66556008)(8936002)(41300700001)(110136005)(66476007)(186003)(8676002)(64756008)(4326008)(52536014)(122000001)(38070700005)(38100700002)(82950400001)(82960400001)(921005)(2906002)(8990500004)(86362001)(7696005)(6506007)(71200400001)(10290500003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OKkaXgflg0H2WAtJee/M0A0dc/9+XJ01Gm33ZOMNqO0OXA6GivMmSt8JpLHE?=
 =?us-ascii?Q?168dbzIyG3FHYWCUofCgBjBdPexkqgDIGmNkFgDLszoQfgCiHzU9QeSrCP4a?=
 =?us-ascii?Q?CEwb5k2QMa4oU/+F4vE+34o5fpi/UXzOIjRB2+bochDmfC8DfNtrdK/XNywq?=
 =?us-ascii?Q?6LcJ5RRtkjG//PkZHNNmvlunldwwzk8txfkG/O7muQWqQpVPrbDpQRlPcAx6?=
 =?us-ascii?Q?rd0B/mPiyM0UhvIraGLmCZa9TXZjNODZGsW+IP/heJV16jdroIg2NN/8BzhX?=
 =?us-ascii?Q?8ay1QMx2yICpcvsHGbZtW5KLtgkep06Q+FR0TJJSf3B6pBbJfBx1qK4+BJW0?=
 =?us-ascii?Q?xTwRaJQF/y9uVCFuTT7JbY89negUqwxmWRbvDXC4rA0C2LDfxPsDurBMMN3y?=
 =?us-ascii?Q?kKFD9gcIxB/OnO5BD2NTWKe/9CGE/ugWzlMdVLHFykPwd4wmlyTc9GDBrCxt?=
 =?us-ascii?Q?4iCoHE3T7nWO2qJeVW+6eCb3EnMlCew3R+/jLBi6WWpgG9H6tLUAi3bMu4qa?=
 =?us-ascii?Q?41pOjsPBWao+fEujlBTacy6mY18UtRhZcndqLQo3kIEhm7HLK4Xho4A+ZtmM?=
 =?us-ascii?Q?GbPbb8o8WqHmxURlod5zW1ZFE8eBPiobts/MXAB3NmKKGv6STp7nhuizCe/y?=
 =?us-ascii?Q?nRiW1oQh+z7q9lnhcEUmUThlxRN5tBiAn8vyHMIP7td9PGpL1CWQUnLnqRDG?=
 =?us-ascii?Q?ZtvLBHwjnns3OieY2cFY5n8NwvR4t1Z5aqJwswrbuOLnACMwl1xyKinbtKec?=
 =?us-ascii?Q?mlKrURQhELqJ7MTNJB4fJQwMANcK7XwdqjKQ8TRWdaaqTuLoZChscqwozLmK?=
 =?us-ascii?Q?6QjirHdzpRNfyPBnxG+vBh1Lhpc01hDV0mi3xRJJjoSjOjYujWO72s70FW+H?=
 =?us-ascii?Q?LAHt8TbP4NGaYS4aLar7pT1h28Jj+NKW531rTXvxldym81TyLzk4s/xmpDpt?=
 =?us-ascii?Q?85uuydMgbnqWHi2xsOfT0jIU0GWXOhnx6XafoyclyiYVzVpkNh9TrKkid3oW?=
 =?us-ascii?Q?Rvg1QADasDvy1n+0NTxsM4lbBjZw3Q+lzxk4j0TTyAUQzD4wrcjKcWT5XJiI?=
 =?us-ascii?Q?V9UjMcYdHj7fV1XqpaNM6Eh0LASLgmyrzlEfyErEQM5td4bgiTBstPcaW5sV?=
 =?us-ascii?Q?fQMabiYazrd7DvLhx+5sL3BQg0juTgN+lBuR2XM4ED7xZp+056bcLjIsKpFW?=
 =?us-ascii?Q?YYcpZXZcmouzyvMjFwwB4/KTWbFYI8NpBEf5RV6SoPCHmb4PbmGIxVrIw5r4?=
 =?us-ascii?Q?T7pBOy+c/LckBUTUhfSNbtJa59L7Td/SFP5SyS3V5g11xoCOt6DCEhRcQm1t?=
 =?us-ascii?Q?XO4r+lGRJOFwl4VVLrrnzHdlSg6uz6V3dN3Qu0jv9UlV5hwM431UByv1zO4o?=
 =?us-ascii?Q?hsH/x9N1N546owXvEgAFkr/JVOJFwyP1L+WpBBrtYGZ+UAJqYYvegmBaMk4s?=
 =?us-ascii?Q?8E1cDkCRqSUDIdwY2sBgI4x9JJXevfw3CGkqrsVGM7vS661wnO1uJppiT3A+?=
 =?us-ascii?Q?w4C1/80TQ7YOwr//wxFydTTKB8XFUrSHun8v/Zd7wYyGZ7YrZyHncQORVbX5?=
 =?us-ascii?Q?oj12GdkZf+FA+llq055jtnmOZBYa3Jb7O02Ly+dW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f844918e-7a1a-4f37-64f3-08dad0e0f5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:36:24.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCt/okKscONpa89zolhygplPQZtlDpM8sF6dhPOuAiNmdnAkiwZB/qfLLhsGwJJ4z8iuoW+xxF7HTjIGNlpneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1938
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Sunday, November 27, 2022 5:21 PM
> > [...]
> > +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> > +{
> > +	struct tdx_hypercall_args args =3D { };
> > +
> > +	if (!(control & HV_HYPERCALL_FAST_BIT)) {
> > +		if (input_addr)
> > +			input_addr +=3D ms_hyperv.shared_gpa_boundary;
>=20
> At one point when working with the vTOM code, I realized that or'ing in
> the shared_gpa_boundary is probably safer than add'ing it, just in case
> the physical address already has vTOM set.  I don't know if that possibil=
ity
> exists here, but it's something to consider as being slightly more robust=
.
>=20
> > +
> > +		if (output_addr)
> > +			output_addr +=3D ms_hyperv.shared_gpa_boundary;
>=20
> Same here.

Ok, will use |=3D in all the reference.
