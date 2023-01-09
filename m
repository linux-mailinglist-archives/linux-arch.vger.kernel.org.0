Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB20661EE5
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjAIG7b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 01:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjAIG7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 01:59:30 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444062FA;
        Sun,  8 Jan 2023 22:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRVONq3Zbs270oGm2hUXy6kBjETW5G6MnaYA1cSDB5XqsPMQDlWnmSBVgqeEwb/yQ0+YL90Ii4WQAIMagY2e6Qn3dBHtfMLpyCo/Wo0CUduhDSdOG/QLrXlGqYymgKwNoFdVxM43wkdQ+nCdIlhVlEOERs+SYFjwMUPgV7NmOml5Mxm+G3iWg5c7EQ7EgSAbxZvmSf6QLgRwkBbXmXrUbdThnMGGtdjUM9upccbe/LAhy2eY7sARsg0nxsz2qXpht95nrtYNqh3DHU/hEccNg5oi5HVw4B3e3mVFBygbbmjk28RaUwH330VcLgzFDBzElI1w7XkGyavV3kzjANk8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x22FX49DSef7J7E75ktTU4AQfgDNp8llAaJ3Gjj8TdU=;
 b=iTOqpQHxI2DdW33ciiKEBy8acG7B7nXnj+k/v3hlKytp3i+OMuStM8mFsjCIiqcM6Zzgor0mfJAEHaDMVV7zANz0VbelxakyVIAEfsskiqNU9Rf65peBa9aZkaDhISQrx/gEGx7tQwDWJWVDo5CQyxNmGY1uSs9lpKjwTWGRNmaHZU+/BjJzUcq4CB/W+Q43jVuaTxKiM39xNQTlcV4FfJosWWNX1y3We41rhOQTNlEYVeHuxFLGDj0+5PGmm0SRZo9yxlbfn1hrMyTIHeyCeay/Mxaxc3hN5R4gd38h5G6mzGIGv/ycHglKW/sc90vYpyZXOXzvj7390r+uWK4wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x22FX49DSef7J7E75ktTU4AQfgDNp8llAaJ3Gjj8TdU=;
 b=AeNQ4xhIBRwjdtcQTQHBss42pVsH3CIB9aMpTQWSK3lJ8S9hKv85PH+larQ5r7cZoyeQPDgko44B/pFXXzo4mkhSScM3g3r9NRftOcQa3zv9uO77XfJTEUvE3lJMZckBtsi7zPjQY8OvrZW2UMU+u6osHkXKRxBARmiUXFg4z3o=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CH2PR21MB1511.namprd21.prod.outlook.com (2603:10b6:610:88::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 9 Jan
 2023 06:59:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d%5]) with mapi id 15.20.6023.003; Mon, 9 Jan 2023
 06:59:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZIb4ZJUu8X0EPMEOTB/ACgw8Gm66RjT6Q
Date:   Mon, 9 Jan 2023 06:59:24 +0000
Message-ID: <SA1PR21MB1335A94FB6D78824104FCE5CBFFE9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
        <20221121195151.21812-7-decui@microsoft.com>
 <20230106130021.00006c94@gmail.com>
In-Reply-To: <20230106130021.00006c94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56ae4b86-2941-46d8-bc56-40f7b5d956fc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-06T16:03:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CH2PR21MB1511:EE_
x-ms-office365-filtering-correlation-id: 29103035-34be-470a-ea20-08daf20f0b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ii77cZtFZy2wyGObAoDtJdkwM/2uJg9N8l0mi8dn+V8mn+nXYIFwGDceOPEUDCI2l1PLTh+Ns9+Ngz5c3yakcEnTXhrZmvqC+jBVge/LIH/p+8XNKeo36eKS31bHYtuRtgs1dXQC+Gw8P3Qhzx/u6l62Piyg3oNt5MjY4DCyM2EUl4ZSYqU+N78RPZLUrLQGYG/im0BD/Ypf5yfdd6hWFuxHXHvI5H7u/+M/vR/OdyCDWgLI4J/u2zj6OWdESeVQ69LoF4Zp5+qfoX/a2x2Xw8cl5Q/61qrDzlNvjQoUnrGEAaigpq0RrV0kGjyh7BuVqTqrgal0cu24gbVhiCcTmgyBVl7bydHLPBKhrwcBhkfXcfC1jP7/HYLLt/19WbE3Ba8BSx+8o95NueBsmEDfms7v9T4Bo/C1AuqpFwldf2H1JbR4rx78PTQyh7DvCQxzKNSxrTR7jn7aNcZsg0D+UMP7Fsob3QtZtSowPVxboJJiPfO+a2GZcm1MYN5PqbWhA3hLmDubndSLbil/u3T+t4EQt/Sgl6xUFugVvycPGawtlnsxo5mBEVjL4pV3uj4/S9DOgN05sucJfK1Ev2q1R8D1iQpakPuSz1cNnT7wB0AGg6kawWZ6kueYPVQ/RP/C8CjsXGR+uFWz9VlNdB0yTUm+k2TZEU3xlm2HScdJUGp26YCN678a7A+7nOJB7JEZDsHMDDrmuRskZogjCvIdWkrhSkTby3/nHSoWbVEY2HFadzTN4y90PFVwXusfMbpkrt0zQp9H2v4yx5w7Hx6QU5D+Zp7rPaJIefNaNOa2yREDjGCSHUXqeyVBe5podjQx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(122000001)(6506007)(33656002)(8990500004)(5660300002)(7416002)(8936002)(52536014)(82950400001)(82960400001)(86362001)(55016003)(10290500003)(478600001)(38070700005)(316002)(54906003)(966005)(41300700001)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(6916009)(76116006)(38100700002)(66946007)(2906002)(26005)(9686003)(71200400001)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+LIk7uCA1Xl1EqkuIK9MPOC/WsEiUQ6RuS8MhKLiF22nqkQfupVKMd4U9NnK?=
 =?us-ascii?Q?murFpGreitHJ4OtDwNvdLTAFggUszK3cNIphTX+7aachErRI2irTBoOZE1i5?=
 =?us-ascii?Q?YlzNn6Bzc/b/4ZORweZyYbLklNfrMYix8aJL9Y3zbHj/QnpPuUPRz4CEEVGR?=
 =?us-ascii?Q?W4wSDaSSDzzXm01vRu9bIcyP8hV2Hc8NjjJw7xiYc2YGSXRjS3xnvJUWc5CR?=
 =?us-ascii?Q?U/cWr6OVpMlUQL+zfhsfgK7+351LetEkMHwTHF26FqfaJtv+jq9xThU7TfuD?=
 =?us-ascii?Q?nmqiJdfbiqMNJcOL1VewsJTHMX8zHBU3ZBfzgbcrRrYlsrISaFjzbq4DPhBQ?=
 =?us-ascii?Q?0uqqea92g3JZJ2CAj4zdFs0Zc9rUYg++BuLGEx8hjZ5/HLh/IGPjS3Mra0jt?=
 =?us-ascii?Q?hsrXmzucu6ENCuczhcUMz6Ll6Go5RMqAK/LKbfeczgbuo8r7EXxi11fcjiom?=
 =?us-ascii?Q?deDjCZI90IK/WNd/ab2lpQd6m6gpbxZ/QdNdR0aSZiw+yEk3KDPxENk46blv?=
 =?us-ascii?Q?ybAQit9YLOO7ueM7o1neqIvqnOLEtrfFAtyXQ47J81uiLW+XgwZ9JHWtqgvY?=
 =?us-ascii?Q?L38rNsg6ht7tW3iwx/LdOaYSihRuTxIN/+SonlUWj28Hdfcrda1I6BMqil1u?=
 =?us-ascii?Q?mtxJn6W34Bz1A+OZasLAAEe2TM1gGiMHaqsnQK+WjdOHZx7EnYUA1++7NZsu?=
 =?us-ascii?Q?e8ndnezwvHlrNFbtaar0QY9wQqGoeZBApGB3H9BTg5QI969SU50XPRjP/lpg?=
 =?us-ascii?Q?lQ4ngdSjCi4Lgq4qgOBllK8lqfz8BesJbeEefdWBtME8yHbL2+mQNA1CgoXK?=
 =?us-ascii?Q?txK4wF9KhTGZy3kwNHHC22N//YxIjtp6gEe8o95xM67nmM1BtqOG5rHBQUpe?=
 =?us-ascii?Q?PfgjI9z7xJKYhZMm6zTrvCe1mrtqwAxrazx24GkLbVoDrSMJkKzF+XofKQ6H?=
 =?us-ascii?Q?qSvCD2r8cJzcoIEvO/vTuq+CVp9B414vtPF7bAATu9LJB6I9YdYQbn8hBNun?=
 =?us-ascii?Q?qo/1KRSs3P3l6XUqTX5saTq11c1zFqKU/MQeVBdeQXEACA1qNDRgcfExleyE?=
 =?us-ascii?Q?5qpkbSuMIhDeTHGBrxuCufSBM4FYYwuzjS170YzcKhvTY0pT0ojbyZwrBdWE?=
 =?us-ascii?Q?ppjyZoNueEOvaIkLgtG26Y4MiOAizjzZvisNqzgrsrDUabKdwdgVrROutTya?=
 =?us-ascii?Q?rd2EoSS2SCdGlCzCrYu/MjcWRtZdaO4HLnu864ZBz7oxA/2Q1AGmpntPfZ4p?=
 =?us-ascii?Q?Kdu7Q3uhFJPWiPg62U1IhEjZWyGd41WJH37KU5YdY3I5mPAge05tolvPBVxm?=
 =?us-ascii?Q?ZtwyweRXeny2khNmgUi6wuOwVZjRUpVkaaC3yU/wXF+rIuYZyFBvgGb5D1Xs?=
 =?us-ascii?Q?MAZMavG72EYsXTsFH2AyOLKaDufEHSAXK1XahiPmEpaFtyWbG45yflrbe+MM?=
 =?us-ascii?Q?bPZ0c2WX4d62R7sFRY+mEUMOwJzwC8O9uAkkO9v7uPrUIMBG4MnrT+NEVGbc?=
 =?us-ascii?Q?u4YZuIKoJaxgy9RcGUhpFAGe/j2wzD5DaxAQ8KusQqPXNJWr4MV7NgzJPevG?=
 =?us-ascii?Q?YvvjCNqBm+QSlQ6spKdZgySGIVlDoM14DkMrF0OK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29103035-34be-470a-ea20-08daf20f0b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 06:59:24.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vx5gpmkJBJuVL55FTJvYTRj45l17PgjWBSt6IB7RqEY+yEozYvtRRT994YwR7g8D/b/+QElyw4Q7ac2HNr+fsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1511
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Zhi Wang <zhi.wang.linux@gmail.com>
> Sent: Friday, January 6, 2023 3:00 AM
> > diff --git a/arch/x86/mm/pat/set_memory.c
> > @@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned
> long
> > addr, int numpages, bool enc)
> >  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool
> > enc) {
> > -	if (hv_is_isolation_supported())
> > +	if (hv_is_isolation_supported() && !hv_isolation_type_tdx())
> >  		return hv_set_mem_host_visibility(addr, numpages, !enc);
> >
> >  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))

The change here is kind of a hack to not call hv_set_mem_host_visibility()
for TDX guests on Hyper-V. The original change was also a hack to me to
call hv_set_mem_host_visibility() for SNP guests with pavavisor on Hyper-V.

> Let's say there will be four cases:
> ----
> case a. SEV-SNP guest with paravisor
>=20
> In the code, this case is represented by:
>=20
> hv_is_isolation_supported() && hv_isolation_type_snp()
> hv_is_isolation_supported() && !hv_isolation_type_tdx()
These look bad to me...
=20
> case b. TDX guest with paravisor
> ?
As of now, this is not supported yet. I'll need to figure out how exactly
this scenario will look like.

> case c. SEV-SNP guest *without* paravisor
> ?
Tianyu Lan is working on this:
https://lwn.net/ml/linux-kernel/20221119034633.1728632-1-ltykernel@gmail.co=
m/
set_memory_decrypted() calls __set_memory_enc_dec() directly. This
is the same as a SNP guest running on KVM.
=20
> case d. TDX guest *without* paravisor
>=20
> In the code, this case is represented by:
>=20
> hv_is_isolation_supported() && hv_isolation_type_tdx()
This looks bad to me...

> ----
>=20
> 1. It would be better to use "hv_is_isolation_supported() &&
> hv_isolation_type_snp()" to represent case a to avoid confusion in the
> above patch.
>=20
> 2. For now, hv_is_isolation_supported() only shows if the guest is a CC
> guest or not. hv_isolation_type_*() only represent SNP or TDX but
> not "w/ or w/o paravisor".
>=20
> How are you going to represent case b and c in __set_memory_enc_dec()?
>=20
> I think you are looking for something to show if the guest is running
> with a paravisor or not here:
>=20
> if (hv_is_isolation_supported() && hv_is_isolation_with_paravisor())
> ...
>=20
> Thanks,
> Zhi.

Michael's patchset removes the special path for SNP with pavavisor on Hyper=
-V:
https://lwn.net/ml/linux-kernel/1669951831-4180-7-git-send-email-mikelley%4=
0microsoft.com/

With Michael's patchset, I don't need the change to __set_memory_enc_dec()
at all. The plan was that Michael's patchset would be merged into the upstr=
eam
first and I would rebase my TDX patchset accordingly, but Michael's patchse=
t
has been pending for almost 2 months...=20

so I probably need to post v3 with the below version, which looks a little
better to me because it hides the Hyper-V specific logic in a Hyper-V speci=
fic
file arch/x86/hyperv/ivm.c, and if necessary we can change the implementati=
on
of hv_set_memory_enc_dec_needed() in future, e.g. Tianyu can change
hv_set_memory_enc_dec_needed() to distinguish between SNP with pavavisor
and SNP without pavavisor. Of course, I still hope Michael's patchset would
be merged soon so I can avoid this kind of mess...

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 07e4253b5809..4398042f10d5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -258,6 +258,11 @@ bool hv_is_isolation_supported(void)
        return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
 }

+bool hv_set_memory_enc_dec_needed(void)
+{
+       return hv_is_isolation_supported() && !hv_isolation_type_tdx();
+}
+
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);

 /*

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2e5a045731de..5892196f8ade 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned long add=
r, int numpages, bool enc)

 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc=
)
 {
-       if (hv_is_isolation_supported())
+       if (hv_set_memory_enc_dec_needed())
                return hv_set_mem_host_visibility(addr, numpages, !enc);

        if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a9a03ab04b97..192dcf295dfc 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -262,6 +262,12 @@ bool __weak hv_is_isolation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);

+bool __weak hv_set_memory_enc_dec_needed(void)
+{
+       return false;
+}
+EXPORT_SYMBOL_GPL(hv_set_memory_enc_dec_needed);
+
 bool __weak hv_isolation_type_snp(void)
 {
        return false;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index bfb9eb9d7215..b7b1b18c9854 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -262,6 +262,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
+bool hv_set_memory_enc_dec_needed(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_si=
ze);
 void hyperv_cleanup(void);
@@ -274,6 +275,7 @@ static inline bool hv_is_hyperv_initialized(void) { ret=
urn false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 static inline bool hv_is_isolation_supported(void) { return false; }
+static inline bool hv_set_memory_enc_dec_needed(void) { return false; }
 static inline enum hv_isolation_type hv_get_isolation_type(void)
 {
        return HV_ISOLATION_TYPE_NONE;

