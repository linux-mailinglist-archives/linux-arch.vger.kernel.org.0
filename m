Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA95818C206
	for <lists+linux-arch@lfdr.de>; Thu, 19 Mar 2020 22:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCSVFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 17:05:02 -0400
Received: from mail-bn8nam11on2123.outbound.protection.outlook.com ([40.107.236.123]:34400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgCSVFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 17:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJCygmh8SKd+kOVYTbq6WlzOAyKb4lcESG09MW0xBtZmdsVAtgSDX9YfiNMgTzStvhZL9mEiyIWxpP6pfAESTeLw7uPFe3nOYrnBA1AkAUmVeuvjx1jrjXANUyaLJjsbOjAjPmlfyKvIPIUHhg/QKm1olFcZCthdOfd40l+klSJDcEbih8wjun9Omvbor7VRvdfDdXfYBz3QqBLSuYbQvODn4Nzr2FwooFAB3M3Mm3yfsBQ8ONfRN6cChosd5YlkHeKwbtSSl8DqaevSjId47YzFJDSlYjHOieho09dBtBfYPtguuaqdXpjWVfkcmwEHjQZwkUO/SHFIMuBSue255w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/GIME87zhTNBkq5xr0Zg4cSMjL5FvG8t6Q+M16wDpk=;
 b=W/estHAmt8b7wjeDVX2KlW26fKX+41u/Tpc16ktmQ0tyvbpnQbibSSIiPChGw47X6If5jSFChZdH14/uimixZav+KEN4xzfIOh8CpXArrFkKnSgohFJmeavY2ZQA2mUygfOOMOGGcWNFk4+smomdWU/Fcq8gOzuxNFCr5iQUT54GG8SkxG+rKIIl8Q0GcAwjW3KEf61vW4Nn8fLng6cx4o0MbITblKtdTC/2mParTg16GPb5IG/Eltms3fDs23nx2onbjB0sPsS0ATVpiDpI35PTIcPyd5qzmHVNJUOMzWvA3jkFNdxhVsB0et+rZEuW/O+8j28XRKxaD6C6Fgp1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/GIME87zhTNBkq5xr0Zg4cSMjL5FvG8t6Q+M16wDpk=;
 b=jTcKy87BdL6DYt3bEVt9sOp2hJblauAPGxPLm8YhSxQWOgzoe19pxC9c9GnSuNJ0ZdEI4lxi6GL24LIwuvBPOiS6IMEJBC9/v39QE8rOUaiT4W/v+2TsxUkrN8Hs6VWXtT9XLbqbuIfX4EgJm+bpmay74LSqCxgRN3AoMDZQDzI=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1066.namprd21.prod.outlook.com (2603:10b6:302:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.3; Thu, 19 Mar
 2020 21:04:58 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 21:04:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register access
 functions
Thread-Topic: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register
 access functions
Thread-Index: AQHV/NL4yYutMZ0IekGL9fCpeHI0z6hQZhXg
Date:   Thu, 19 Mar 2020 21:04:58 +0000
Message-ID: <MW2PR2101MB1052AAC1EE6AC082C9ED6779D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <20200318031130.5476-1-hdanton@sina.com>
In-Reply-To: <20200318031130.5476-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T21:04:56.0823555Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=db2ffac5-4430-4896-a2c6-07391297b4ed;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8743fdb-ee35-4ad8-b8d9-08d7cc492ebe
x-ms-traffictypediagnostic: MW2PR2101MB1066:|MW2PR2101MB1066:|MW2PR2101MB1066:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10665C8E7A53780EB01725D7D7F40@MW2PR2101MB1066.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(6916009)(76116006)(66446008)(64756008)(81156014)(81166006)(66946007)(33656002)(54906003)(8990500004)(4326008)(66476007)(66556008)(71200400001)(2906002)(6506007)(7696005)(8676002)(8936002)(26005)(186003)(478600001)(10290500003)(316002)(9686003)(52536014)(5660300002)(55016002)(86362001)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1066;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoQPUTzvJRwaWYB8+LV534XnuXD5TlyFkN8c4iO3Crqrze+DMuO8POwq6qK6U/BgWWP/RezDKdWIYF2/8XSvUZ+MkvNRNkRxsH29UlXf0HM0GkDv6SZe8tLvc2CO+HVuTn2O70HHBbmJeizjTSe7mpxgBZ68n7HJoa9NkhYaLhzfz4RwOSGE6vfjAwUo9rYqWA9zZB+yCsRIV29rgExdNCQz1ffGKsOi7lpSuyINJTEJ0OL4Hm8gx/AzT/DPSCr3O+h1ouZApkAGJL4dIk7eYFGZzF3rUbBmrqMP3jyuk3m/IEoAKHYJ7DYXbE9t+HhTZC/3Cjam2F4PejeXIl2wzFQD5wQdh9nFZ1QqLLAZEOBf4j+31HdMzkP7yyY4UnQvaJjE/YR2J7gpslUrKTaJtmeU09zVNhOe63KwkIBHW7fik2Mx74wmfK0ewa8w2Q43
x-ms-exchange-antispam-messagedata: Kte50PYEzGXWFonZr68EKIPyw0BTgPFSshERZoaBZKALIm3HgKA8PyVwPoHMSnbTy9N1laMSfEv00Ch0Sj+SRTh7Pk6N6opiJp3guL8Ci4+1e9ZN5aFa5U5KfjEo1R6RXBiJAhG70DZ3IND3Xh6L7A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8743fdb-ee35-4ad8-b8d9-08d7cc492ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:04:58.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqYPFKBM4ZAZm8uP5DazWcjERFur1UO8zkUO0Er6PTDTcgou8zOuYlhuvzMFne9vXlX2MBtARJvS4+J49dZ+I0QCj/OUEm0cf9ECrTPryaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1066
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Hillf Danton <hdanton@sina.com> Sent: Tuesday, March 17, 2020 8:12 PM
>=20
> On Sat, 14 Mar 2020 08:35:12 -0700 Michael Kelley wrote:
> > +/*
> > + * Get the value of a single VP register.  One version
> > + * returns just 64 bits and another returns the full 128 bits.
> > + * The two versions are separate to avoid complicating the
> > + * calling sequence for the more frequently used 64 bit version.
> > + */
> > +
> > +/*
> > + * Input and output memory allocation sizes are rounded up to a power
> > + * of 2 so kmalloc() will guarantee alignment. In turn, the alignment
> > + * ensures that the allocations don't cross a page boundary, which is
>=20
> Better to specify kmalloc's current alignment and why it fails to ensure
> (4 * sizeof(u64))-sized allocations wont cross page boundary.
>=20

Is your comment referring to ARCH_KMALLOC_MINALIGN?  If so, I see
how that makes sense.  BUILD_BUG_ON (sizeof (*input) >
ARCH_KMALLOC_MINALIGN) would be a cleaner solution.=20

Thanks,

Michael

> > + * required by the hypercall interface.
> > + */
> > +#define INPUTSIZE (4 * sizeof(u64))
> > +#define OUTPUTSIZE (2 * sizeof(u64))
> > +
> > +static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_outp=
ut *res)
> > +{
> > +	union hv_hypercall_status		status;
> > +	struct hv_get_vp_register_input		*input;
> > +
> > +	BUILD_BUG_ON(sizeof(*input) > INPUTSIZE);
> > +
> > +	input =3D kzalloc(INPUTSIZE, GFP_ATOMIC);
> > +
> > +	input->partitionid =3D HV_PARTITION_ID_SELF;
> > +	input->vpindex =3D HV_VP_INDEX_SELF;
> > +	input->inputvtl =3D 0;
> > +	input->name0 =3D msr;
> > +	input->name1 =3D 0;
> > +
> > +
> > +	status.as_uint64 =3D hv_do_hypercall(
> > +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COUNT_1,
> > +		input, res);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * getting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
> > +
> > +	kfree(input);
> > +}

