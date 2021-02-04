Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD5330F958
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 18:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbhBDRQf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 12:16:35 -0500
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com ([40.107.93.118]:59393
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238289AbhBDRQP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 12:16:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrm+CjAxjMu9fM/ix7cqFv7l7qtXyEb+6sHQ5lweaO6y4X+UIX1GfFn9GtG3JXKQj3njiTrteW494GDcPaSX5kZi0ltoSF27thEVpEytELIWanbi504N79tWh2T3COw7V8vgLLPwXZMDytF6iqfyEioh5Qn/VXCnBIR76A4kdIySsfnbfOj9P2/d6XBaEgkO8I0VUdaEHlm406C6x9PA+WQOfvVPf8EM6frTdxuPuuxaXWeiqTSzvZJ6kkMD9G/q78buGd7EpDaJ8xWA7fLGH7sC82eGkPdPEVR5eR+IELhxFswIpavcwWLtZ5DCUNz+irpFn2L7ua5PlsyeZ2h6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFuE4DnqHnSlW95d3e3g5OV8Xxd+GHNCLHOei9CQQM0=;
 b=XPMOJV01hZqVKQkOLNEr7fbPW2iNsbS3i9BDS+fQlhgvCae+JCTCuw/HTn+l8Vtd7zcURpJN3HOH3uBj2APW/9BEbzOJtkDQjxtnpD5fXU6gNYCG4uCMTwyiFKYORhVO/IrUaKlE6VV1fk+6xRS4YumAFqRMVm1VWfgODzym1HFDvbPJMm52LWqievkUvbUHhyh03DGo/E2B1gvbNY8J+fKHM8oSFtJt0Smgy/zkDvemOfRW+FRMYCLzQA53y4vUmXEVUA6Nq77PrtlSWh9cscqKI4nZ+69UP7uyU/293T9fZJ+xn0ejT/DMV1lnEK2YC1UKYbAKtoSUqUaVcKiheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFuE4DnqHnSlW95d3e3g5OV8Xxd+GHNCLHOei9CQQM0=;
 b=XbhV2qbWw3B4GTbw7USYLKV7MHhncKJrpEMLo4C6k5lB6fr1O8JZJNwpe2L6iz34nU8r7zj99J5/m3+cAWRzo2c7L/Cr1Evt+txvtkGaMLgbBYuIpmchh6YMgnBVD7QCDW/0EwDKvNGUaUw7oE13hNaNdFjbaEF/ComuCCXS/6Q=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 17:15:20 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:15:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Topic: [PATCH v6 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Index: AQHW+j3ufdlM/sDd1kSOsRZpmh1j2KpIPepw
Date:   Thu, 4 Feb 2021 17:15:19 +0000
Message-ID: <MWHPR21MB1593B07CBD21150942540CECD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-14-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-14-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:15:18Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bcb5e18-6688-48e2-859f-fdbf431bcf1b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33df266a-1019-4d29-4d32-08d8c930732c
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB187303C6E3038321387E1A2AD7B39@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pqqxFFQo7pIbxrp9aMKndnsd7SEFKk1BfizvtEjzS4NlaN5RJRZSnoYT+t0vugwvC7zV3YwdBof6SzmpxF4o4yNFaiysnIImnsnHD5y7EYaX5Ux4emjCFAPf1UrB2mzgEHK+tflZkmKTB6CMTd4VCg8SE4bHMDzq+S8uhxKDyTtMl02zpcfJK9C5q6BVEF+H7zFeE/bmX2GKNiTKVQfGvfJzhiwHArCUNVYBCSeTEU3c2wdm26wc6qneGXxJumk1Hhy2WWkdREzQp5kAH+9rTv4/ZjvNoQuevgAv8I6fEJ5oAxxHSXYiP5qMQ2sPNFdV+nDf8J8i+wUUQFAbEyVO64fzL/NCJzsuvyESKqr4LMN3hJNpTeotcqzKzWhWubgO2EH6hDSkYCVaUCJHk8Mhef5kvT5FUgnUF1rIxkG5Kjw6U4oP4hLety6Scln7c2NQ22tR85tznkS99YzByMXmNzTQORluwz/dBbsplzxMfMuR7MGgT/HMuZfUL8W0wLe4xrYeAm0dP0FAuaq5GpsqtIkUxPNfJXQNT2X/DCxX8nv6DM17PMbJRnoM+l6DbAl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8990500004)(7696005)(26005)(8936002)(8676002)(64756008)(66556008)(82960400001)(4326008)(54906003)(316002)(33656002)(110136005)(76116006)(66946007)(5660300002)(2906002)(55016002)(10290500003)(82950400001)(478600001)(186003)(52536014)(9686003)(6506007)(71200400001)(66476007)(86362001)(66446008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7l7f1hjY3ClJnViSDMeXAeFxOGMtwsnVyZkZ4Fdv9ftQ5s74bAZAd0TGalDchD/JYe3hP7CuWkLhPkqJPyryIrMadTXhFAu9wBPBGNGVM64ItCmY56B+Cn/0nc2Aw1+Hqe6gQRqt7DQu8YTGCelUHXIF1DzG8TTH4a0KwnRaMGKrX4fxZH8c1E4hzXSJP3fwX5iZ/D+4TNUr7QOzw+vwXCsTeWxDec4cmy3XcEBrJyOF6tEFNbTJ36EoIxnftgmze0INzAGqsDFPc47E9e6hlLbCrgd/4PMmZkYGj4nxk7x2swAcsHvvJwAPNFuedw4ZGFB3HyVIIHp8MHfOm4UeOZIuCJjz4vOu/T7N8hZ61irHMAbo3ALXrhXrHS6mys+LeyFCl1aBD+3YuFl7x3MT/NTItwDCgZEBMcGYzvbLwXbcTjMyjE/p8VHvKNI6nw+6C5UiCON0gMhu7komAdFHxg+WwiSaYMj6ONrhR0bmx0MRUz0HumOhwHBuD8wvYghaCNpa7m4YckfNTS2LzpJ+UzW8+Vdd909tRndf8IW/tc16SawUsFf3CgNC1Yd+3fYV/+lqCP9NFSnD9+HlW7OSjfpjan+hUcmRlvWfjFMN7zBOyDHZRyTqjMZTm20oVQwuyTj6mXcHZSY69uQd6X/115Skv5+zotW3ahpvXHW5bVuIY8jHyTADVHNAqioHAabQKHGv97S1alGRlYQpy3kfR4c8ji/3TzwSuv6dW78hRBQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33df266a-1019-4d29-4d32-08d8c930732c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:15:19.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrqmAmtKYVLqQX0xuSHgN8LAXei0LZrwwpoAi9xzgHqYSw87AuALWL4CTBLF+8K4oddkgys/OHZRocI+7bcLLkW+xdjlB84SLCuTLBAS+PU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:05 A=
M
>=20
> We will need to identify the device we want Microsoft Hypervisor to
> manipulate.  Introduce the data structures for that purpose.
>=20
> They will be used in a later patch.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Add reserved0 as field name.
> ---
>  include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 94c7d77bbf68..ce53c0db28ae 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -623,4 +623,83 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>=20
> +enum hv_device_type {
> +	HV_DEVICE_TYPE_LOGICAL =3D 0,
> +	HV_DEVICE_TYPE_PCI =3D 1,
> +	HV_DEVICE_TYPE_IOAPIC =3D 2,
> +	HV_DEVICE_TYPE_ACPI =3D 3,
> +};
> +
> +typedef u16 hv_pci_rid;
> +typedef u16 hv_pci_segment;
> +typedef u64 hv_logical_device_id;
> +union hv_pci_bdf {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 function:3;
> +		u8 device:5;
> +		u8 bus;
> +	};
> +} __packed;
> +
> +union hv_pci_bus_range {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 subordinate_bus;
> +		u8 secondary_bus;
> +	};
> +} __packed;
> +
> +union hv_device_id {
> +	u64 as_uint64;
> +
> +	struct {
> +		u64 reserved0:62;
> +		u64 device_type:2;
> +	};
> +
> +	/* HV_DEVICE_TYPE_LOGICAL */
> +	struct {
> +		u64 id:62;
> +		u64 device_type:2;
> +	} logical;
> +
> +	/* HV_DEVICE_TYPE_PCI */
> +	struct {
> +		union {
> +			hv_pci_rid rid;
> +			union hv_pci_bdf bdf;
> +		};
> +
> +		hv_pci_segment segment;
> +		union hv_pci_bus_range shadow_bus_range;
> +
> +		u16 phantom_function_bits:2;
> +		u16 source_shadow:1;
> +
> +		u16 rsvdz0:11;
> +		u16 device_type:2;
> +	} pci;
> +
> +	/* HV_DEVICE_TYPE_IOAPIC */
> +	struct {
> +		u8 ioapic_id;
> +		u8 rsvdz0;
> +		u16 rsvdz1;
> +		u16 rsvdz2;
> +
> +		u16 rsvdz3:14;
> +		u16 device_type:2;
> +	} ioapic;
> +
> +	/* HV_DEVICE_TYPE_ACPI */
> +	struct {
> +		u32 input_mapping_base;
> +		u32 input_mapping_count:30;
> +		u32 device_type:2;
> +	} acpi;
> +} __packed;
> +
>  #endif
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

