Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89C399A61
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFCGCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 02:02:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23402 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCGCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 02:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622700059; x=1654236059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nHjTjzVXq8MEP8Z7IBya1nLUTCZi0IH1EbyIwdvq1yg=;
  b=RMnVBiQ+ocsmCJ7mchpf0clCvOl8txfqaUrhlb5BVVTo+KHMJ0qK560+
   ImRWaN4pJQjOTGHElSu/2EnGpmjaAGkAR7oqEpJJQlZ91fFRDklD8DkpR
   8LpIcAwKpsId3Pst9IjJHH5e4Vva8yfM8tzR5QakFoPs97HP2RWp07yci
   9cE6CPsTrDiQqgmTeRjVwiwxGW3HPbIyxVie7fjlO5BR4AzTjfMqL3Q4l
   jBZLWBxoexRqX8gIRMuVfcWPLqTSsd/29CJZO3zdJLRsubIuALbHqNwIB
   AwvZnPpNEDGP0cAW1bm/bsnSCIBZfN3ybFoVru/Y9mcsWcrqIPAWUFJSA
   g==;
IronPort-SDR: xmcAytCBif4PIl6Z4qdhuBZc3Pb3Ud6pIW+Vts/Cy/37GYrA+yBMyLsymkLLLjVUXM5nsmQuUu
 OCjlUG3cuGaIsNDW2vEuwsi1EZa7yaIKqU+lod7KKQMNrqgQkQBDnBc0PBE3JVBT7EiGPcz/T0
 E7sWEgPNOygx5+7TB3d+xIwI1HuBS3hWtvsc8vhqTP4G9PkS2eA1PtPffElBeubSTRfTSGJ543
 UEvLpODR4ZmT3AGPhXDmrBD5/z2oxlXChmiXeyU/7MWXJqBd8BAGoDYAmwReq3+RG+v7CbjBqI
 3FY=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="274406636"
Received: from mail-dm3nam07lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 14:00:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5H43Lfn1GwaPoLlo9BHt4x8Oc7RktRVK3x21GsCPD4JeiSnYbHAPQZzAXJfNOsLPXDly5y5CmabWPX5Z0ZDB3efca5MI60XA+nj/Rq8BFfNY/C58LepEDy8b33uWtoDPmn6ZpJkRpIk9OYjZvmhm8Er0mgip9QvFdz+md1x+zVysCYBCqUVCCMjWoZRH1HItYOqxK8OjSVAsqHPUlLdTlrSPiqelvfC57DGd9Z/5czVXe6mctyPCeBrpvipBCPo7qleCz2hkCHzhljbySUHJci0AZcB2tEgBMp3WkVFVfGMk3UVh8dsa7CTV0pfth1+wq1oruCFxndtodbMWVYfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8RGX5gkWMXQbeC2enI6ThBUqqVx9y6jD31AmI+/XdU=;
 b=YKwvLYUR/oFuW8+DAr1NmE9nNU/VtWg/n1vk9p3WwHqCZxjtrKbl1S3YwcZBG7iO9TChQil5mhuCfpVYMDw5BpbGTAkDmHKG1YNy1zvcFrtxox+mD96SdU2hc9k3M188G+bEONUR6iitvOya5FP1lwjBlr+zkeoCARAmO6oh8UZNmE1IAhufPyAK4PGIBDeQmsLW76d7PApyw0H6mwngMI5jqWZ3qbBX8YmBiGqCKw3hBF6PJHZhcnkRTkPt/ebEAT1vBm7moiBBVTyOllKh6H87z9qkSQLPCsrjTl7AuKvKONbAh8OLdC1PR7zYZJwBAYgVqrUCGTEdzQXfGWOcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8RGX5gkWMXQbeC2enI6ThBUqqVx9y6jD31AmI+/XdU=;
 b=FAma9HAJ0ViPDicLMZ2S5F5ropiNkkeFYQBJssHcMySbaOQgAY4MaSyzC+4Nrtp+yXVAYrNHp+Y6psu026H/wfWexG+e51euWQqD4yT9Pzr3qtySBmzkLN/dxeSnNeGQk0Wwe/mV3bhydcMhmgY0XOpoPq6o8PKLtHwP/0Rj/x8=
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7793.namprd04.prod.outlook.com (2603:10b6:303:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 06:00:29 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.021; Thu, 3 Jun 2021
 06:00:29 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        "guoren@kernel.org" <guoren@kernel.org>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: RE: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Topic: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Thread-Index: AQHXTGyTk+HLcFgtPEChsdrUswIwKarqRJuAgAAMWQCAAABbgIAADXqAgAAFs4CABEeUAIAMkQUAgAaHrgCAABm6QA==
Date:   Thu, 3 Jun 2021 06:00:29 +0000
Message-ID: <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
References: <mhng-a5f8374f-350b-4c13-86e8-c6aa5e697454@palmerdabbelt-glaptop>
 <mhng-c0406cea-776b-49d2-a223-13a83d3a7433@palmerdabbelt-glaptop>
In-Reply-To: <mhng-c0406cea-776b-49d2-a223-13a83d3a7433@palmerdabbelt-glaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.171.195.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f972a6-8eac-4dd0-5498-08d92654e42c
x-ms-traffictypediagnostic: CO6PR04MB7793:
x-microsoft-antispam-prvs: <CO6PR04MB7793DC9B5FA4A33C8AF092818D3C9@CO6PR04MB7793.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Zy0RoJYNuXHk2gz8axl3/sL87NypaJWZaLLJ8Toh3BJEE2mbUHfqJVPCvb9j8MtQFS76Y1Vz/FBjMyVW45Axy03xIYJ7PM05HcASUq1lhHnfRG61XdOGAdaF9yUDi/KHnabKNOaScQUfmB5gOJXBLSib5oXVLzp/LCIVei//sdpPkEYsRkrVkdX+e1SYKUBxZzJ2zyBT/Dpyp1LGtwFv9hZu9AikFJRAozwiGbm49gd4mlAkinOOgvs5TIBIewCSIh6BCKv2ZAoQulGFJxrBVYgMNvmn+Lntz1iIMaqBj2GbQ+APB+h6QcGPYwEUWnAyFcIoaAmayyZnTEnSRNIHA3sNBvVwfC3rqENEm/bYPG3r8MxaWlvgH8eCZZMX2C4hW8EMsK9JMfSpTyaN0rLw8T2JpEPwWqfIPh/Z1uRdpnAdg6582aaZoxc9i18tv2e+UqAYWePKnRa4M1dQmiIYioGfZTF08SB2R88TXIw9wIOYIgzUdlqRL6SibQtghbFTOmDwW4u45xVgBuADg9mPqsRpbNy0A4bqtLgcDS3su6NPM2gnIZOVozROAzJ7QPt5OdhQcN29Z5fW8uJqg9RprZY06ACBcb23W4WlPnTyTQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(186003)(4326008)(7696005)(316002)(6506007)(86362001)(7416002)(26005)(53546011)(33656002)(8936002)(110136005)(54906003)(83380400001)(478600001)(52536014)(55016002)(8676002)(9686003)(5660300002)(38100700002)(122000001)(71200400001)(66556008)(66446008)(76116006)(2906002)(66946007)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?srd77p2U8Ql4rYd8OVR2FzxcJzMtLOCn5JJuU4unNJQvSpvHfdRPv4wzQBDG?=
 =?us-ascii?Q?nAm2k+pu0IO29OPO5Z8ysXGvD5pzVn0FOGRqk7lbe/OUrtKsdTVQhtxU5NzA?=
 =?us-ascii?Q?VNPPoazF1gsSvVapd0/DuqSC60H0dSo5At0JU8maEpsGlHnsfmgOIjcmcCO6?=
 =?us-ascii?Q?8/1E40Jd6+sMvMrEnaMrFP+zFm8HRrCSp8t9ziqxECzPTA+2hSWc+Vh5XyHE?=
 =?us-ascii?Q?jXZT8fF34H114+CyFWJVDIUxMG3Y4t9Lux9Zgjq7fmbHi+nVj4ncRc6RI25A?=
 =?us-ascii?Q?dlrjO/YIZvjpjkqG8TJnjDF2pmOPT7M+lMCmptaVvo2Jj11AZXo5/Alrr/XE?=
 =?us-ascii?Q?fh2U33tCybtJJ9Kt7hdoJIP0GCjsgxZuvryAQYSSaq03HF+Mfusc78RrQH8b?=
 =?us-ascii?Q?qe2Aj2kbzjLAzgj/ZTv0ijuuo+QlwanoWw0HGTQ+brdIWaN2/eZmSvEP0BKb?=
 =?us-ascii?Q?ovsyu/f0EJ/IjvKbicx8sD7KoSbdST8yYQyK2V/ZsjbdLq67AEs1OXRUt77B?=
 =?us-ascii?Q?AiZo3FCzFhnRtGeXWcs7HqiKp5GXhc6uPHJ4+cB9ma2MeHNmqv2gwPJzVzPj?=
 =?us-ascii?Q?CMBx+8rEC4ODuuj8vj5yJC1Vhqg9MIlEA9BB2JdJnQWjOJTP0iPRuyECLmEs?=
 =?us-ascii?Q?Tx93O5xiqbBq4vWhDsvwwbWq42gMkImp/bCqcxz5ayyEwBkTNiW4WyTaFdZ9?=
 =?us-ascii?Q?yHqFoN0RtaA2TcH/M8nCnNaa702eW5apFxn8HQ/bBmvoxf8Qv3SPO17r5zXx?=
 =?us-ascii?Q?qYfPzGXAuINjTH9yBTl+bRAyZchhIOAMQCHOveFJ7coUvioF6Cdw9jWTyB+f?=
 =?us-ascii?Q?HFQOkJMYHdGgNZzyp4J5flIlXPsSrneX1McyfhXb38otkh4Gclq1wOvB85O5?=
 =?us-ascii?Q?xivBXZLhANf7USL4aHKPaoBdK+gZu1Z6em/JQ/9w2lDFvrV2mZ7wDQF0VMta?=
 =?us-ascii?Q?f9xdC+MjKisCJeNumjARsW28n/i92f9+MMLIINimeAOtE/QG6a8PbKevselr?=
 =?us-ascii?Q?9WiX4AurQI8twmMEh867mWMV4qnBH19vE5VPX69f0VOd78QJGpK7q66iU2/t?=
 =?us-ascii?Q?sbfZMzVMVrh6/AUv/TWrMtxRi5xoRn5HeeEs+2SvYOs2SKKXwzdg9Fj/F69A?=
 =?us-ascii?Q?o1EfbJqOxkhnoAbwN3WKnKwXrClwWyyKhBMNiTsxR3MfEDcPrn6kQlMug5QZ?=
 =?us-ascii?Q?1V4XeQiLiTJKn9DR6wIjBdX+Encz0Ok7PvkznH4tSF/sAEhK4Lvpr9CTz/MG?=
 =?us-ascii?Q?F33cxtDVgOFaQ4+gXyO+f8NPpyzVjXVAx8KMv9uHkSEs/6ofxR+EQpNHKedY?=
 =?us-ascii?Q?vsc8w17xg2P0+RJskdNmw+uR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f972a6-8eac-4dd0-5498-08d92654e42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 06:00:29.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkETVx44qjbdwe1iPlV3pqeq2/gu5CL+BxIIBVmJ8NMf41jf7x9S3xyKedTtPXql+TW45YmMQVssi3yF8AepSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7793
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Palmer Dabbelt <palmer@dabbelt.com>
> Sent: 03 June 2021 09:43
> To: guoren@kernel.org
> Cc: anup@brainfault.org; drew@beagleboard.org; Christoph Hellwig
> <hch@lst.de>; Anup Patel <Anup.Patel@wdc.com>; wefu@redhat.com;
> lazyparser@gmail.com; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> sunxi@lists.linux.dev; guoren@linux.alibaba.com; Paul Walmsley
> <paul.walmsley@sifive.com>
> Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
>=20
> On Sat, 29 May 2021 17:30:18 PDT (-0700), Palmer Dabbelt wrote:
> > On Fri, 21 May 2021 17:36:08 PDT (-0700), guoren@kernel.org wrote:
> >> On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org>
> wrote:
> >>>
> >>> On Wed, May 19, 2021 at 12:24 PM Drew Fustini
> <drew@beagleboard.org> wrote:
> >>> >
> >>> > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig
> wrote:
> >>> > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> >>> > > > Since the existing RISC-V ISA cannot solve this problem, it is
> >>> > > > better to provide some configuration for the SOC vendor to
> customize.
> >>> > >
> >>> > > We've been talking about this problem for close to five years.
> >>> > > So no, if you don't manage to get the feature into the ISA it
> >>> > > can't be supported.
> >>> >
> >>> > Isn't it a good goal for Linux to support the capabilities present
> >>> > in the SoC that a currently being fab'd?
> >>> >
> >>> > I believe the CMO group only started last year [1] so the RV64GC
> >>> > SoCs that are going into mass production this year would not have
> >>> > had the opporuntiy of utilizing any RISC-V ISA extension for
> >>> > handling cache management.
> >>>
> >>> The current Linux RISC-V policy is to only accept patches for frozen
> >>> or ratified ISA specs.
> >>> (Refer, Documentation/riscv/patch-acceptance.rst)
> >>>
> >>> This means even if emulate CMO instructions in OpenSBI, the Linux
> >>> patches won't be taken by Palmer because CMO specification is still
> >>> in draft stage.
> >> Before CMO specification release, could we use a sbi_ecall to solve
> >> the current problem? This is not against the specification, when CMO
> >> is ready we could let users choose to use the new CMO in Linux.
> >>
> >> From a tech view, CMO trap emulation is the same as sbi_ecall.
> >>
> >>>
> >>> Also, we all know how much time it takes for RISCV international to
> >>> freeze some spec. Judging by that we are looking at another
> >>> 3-4 years at minimum.
> >
> > Sorry for being slow here, this thread got buried.
> >
> > I've been trying to work with a handful of folks at the RISC-V
> > foundation to try and get a subset of the various in-development
> > specifications (some simple CMOs, something about non-caching in the
> > page tables, and some way to prevent speculative accesse from
> > generating coherence traffic that will break non-coherent systems).
> > I'm not sure we can get this together quickly, but I'd prefer to at
> > least try before we jump to taking vendor-specificed behavior here.
> > It's obviously an up-hill battle to try and get specifications through
> > the process and I'm certainly not going to promise it will work, but
> > I'm hoping that the impending need to avoid forking the ISA will be
> > sufficient to get people behind producing some specifications in a time=
ly
> fashion.
> >
> > I wasn't aware than this chip had non-coherent devices until I saw
> > this thread, so we'd been mostly focused on the Beagle V chip.  That
> > was in a sense an easier problem because the SiFive IP in it was never
> > designed to have non-coherent devices so we'd have to make anything
> > work via a series of slow workarounds, which would make emulating the
> > eventually standardized behavior reasonable in terms of performance
> > (ie, everything would be super slow so who really cares).
> >
> > I don't think relying on some sort of SBI call for the CMOs whould be
> > such a performance hit that it would prevent these systems from being
> > viable, but assuming you have reasonable performance on your
> > non-cached accesses then that's probably not going to be viable to
> > trap and emulate.  At that point it really just becomes silly to
> > pretend that we're still making things work by emulating the
> > eventually ratified behavior, as anyone who actually tries to use this
> > thing to do IO would need out of tree patches.  I'm not sure exactly
> > what the plan is for the page table bits in the specification right
> > now, but if you can give me a pointer to some documentation then I'm
> > happy to try and push for something compatible.
> >
> > If we can't make the process work at the foundation then I'd be
> > strongly in favor of just biting the bullet and starting to take
> > vendor-specific code that's been implemented in hardware and is
> > necessarry to make things work acceptably.  That's obviously a
> > sub-optimal solution as it'll lead to a bunch of ISA fragmentation,
> > but at least we'll be able to keep the software stack together.
> >
> > Can you tell us when these will be in the hands of users?  That's
> > pretty important here, as I don't want to be blocking real users from
> > having their hardware work.  IIRC there were some plans to distribute
> > early boards, but it looks like the foundation got involved and I
> > guess I lost the thread at that point.
> >
> > Sorry this is all such a headache, but hopefully we can get things
> > sorted out.
>=20
> I talked with some of the RISC-V foundation folks, we're not going to hav=
e an
> ISA specification for the non-coherent stuff any time soon.  I took a loo=
k at
> this code and I definately don't want to take it as is, but I'm not oppos=
ed to
> taking something that makes the hardware work as long as it's a lot clean=
er.
> We've already got two of these non-coherent chips, I'm sure more will com=
e,
> and I'd rather have the extra headaches than make everyone fork the softw=
are
> stack.

Thanks for confirming. The CMO extension is still in early stages so it wil=
l
certainly take more time for them. After CMO extension is finalized, it wil=
l
take some more time to have actual RISC-V platforms with CMO implemented.

>=20
> After talking to Atish it looks like there's likely to be an SBI extensio=
n to
> handle the CMOs, which should let us avoid the bulk of the vendor-specifi=
c
> behavior in the kernel.  I know some people are worried about adding to t=
he
> SBI surface.  I'm worried about that too, but that's way better than stic=
king a
> bunch of vendor-specific instructions into the kernel.  The SBI extension
> should make for a straight-forward cache flush implementation in Linux, s=
o
> let's just plan on that getting through quickly (as has been done before)=
.

Yes, I agree. We can have just a single SBI call which is meant for DMA syn=
c
purpose only which means it will flush/invalidate pages from all cache
levels irrespective of the cache hierarchy (i.e. flush/invalidate to RAM). =
The
CMO extension might more generic cache operations which can target
any cache level.

I am already preparing a write-up for SBI DMA sync call in SBI spec. I will
share it with you separately as well.

>=20
> Unfortunately we've yet to come up with a way to handle the non-cacheable
> mappings without introducing a degree of vendor-specific behavior or
> seriously impacting performance (mark them as not valid and deal with the=
m
> in the trap handler).  I'm not really sure it counts as supporting the ha=
rdware
> if it's massively slow, so that really leaves us with vendor-specific map=
pings as
> the only option to make these chips work.

A RISC-V platform can have non-cacheable mappings is following possible
ways:
1) Fixed physical address range as non-cacheable using PMAs
2) Custom page table attributes
3) Svpmbt extension being defined by RVI

Atish and me both think it is possible to have RISC-V specific DMA ops
implementation which can handle all above case. Atish is already working
on DMA ops implementation for RISC-V.

>=20
> This implementation, which adds some Kconfig entries that control page ta=
ble
> bits, definately isn't suitable for upstream.  Allowing users to set arbi=
trary
> page table bits will eventually conflict with the standard, and is just g=
oing to
> be a mess.  It'll also lead to kernels that are only compatible with spec=
ific
> designs, which we're trying very hard to avoid.  At a bare minimum we'll =
need
> some way to detect systems with these page table bits before setting them=
,
> and some description of what the bits actually do so we can reason about
> them.

Yes, vendor specific Kconfig options are strict NO NO. We can't give-up the
goal of unified kernel image for all platforms.

Regards,
Anup
