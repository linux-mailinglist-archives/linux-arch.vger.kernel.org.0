Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9D6F4713
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjEBP0L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEBP0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 11:26:09 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A50D7;
        Tue,  2 May 2023 08:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTjnfnFpQhop0avkPwnaq2xEleZcgUjBT+IkvMON5mwhmI5gnHfhG9C75UfN71jT9fy+Ie3RnNHZvmuSp4z4TVfEhKrLXjmXXS0XFxFqSnQGCBrt2vK0vjvMtiTbC73UWl8yWPauM1Xmp5d4JRsVOImmEuAbRNm+oo34Z68foJGIU4aq/R8dPSyyjLiAEC38FppMyGPxP6Xhbh7yRsSMwsWl7KuQ71S9zc4kkGFNQTcm3ZMt+c/b94yk3Y1mZ3Rrat5XxVJtbx6GML3qsGmLADmseydwACgERzb8YZ3w1XYLui/t39/qy/f16z1ZhimZBnsFCWrivGLTfTghn/LBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmgaqFvzJAhrKvYUMSzqpPvX4wKHCqptF/QYTX1uxWM=;
 b=BMYygr7K44HeKeRwnrfFKBmp3TFvMHQ8Ha7506o5KNUimk/JtEG108HCAAduVd/G6pHYbbKLlxhcElj+ZVsW8B63z/yHPNV6QoCWAQSiMWPaUBXArIn5Dl5KfjRCa27FvCO4grXcBCkIuyNd0/06w7wT2CgYYSOvzEY8C89qnwAUgnRAlPiV9yJK6A0rIbrZ2u5Cny7QQY9mm5JzcCPVepw0okiRlopfJIbqee6Cn2Vc3EU45ChPuVlzzyFbnMfEIVQGKPkhMYduuxTmZ2hyP1i0HgT2qVOFFAj6MCytp73MnACfTbgzxDYl9K+f9XwzpA6WBGGx/GhjdtdQiUlQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmgaqFvzJAhrKvYUMSzqpPvX4wKHCqptF/QYTX1uxWM=;
 b=KTBmcDjwg5Kj+ZcWYFhIOORSMP3Dn5btIoOyk1hNCaMipZHfQghbCKPux8oNYM3M5SsdB0jCgb6ofozD1ah5d11BU4bNmlMX9wrjhhVINYTk/5i9lPD7mfrJjlXec5NQ3ebrblV+8hcweBQkGmVS2BnopPu5Ez4GqXAkUDl2l7w=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3654.namprd21.prod.outlook.com (2603:10b6:208:3d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.6; Tue, 2 May
 2023 15:26:02 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7%6]) with mapi id 15.20.6363.018; Tue, 2 May 2023
 15:26:02 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AQHZdMDlgRiCry573UqDSIN3qcYRLa9FtKkggAB7cdCAAPlpEA==
Date:   Tue, 2 May 2023 15:26:02 +0000
Message-ID: <BYAPR21MB1688F458EE551BA19D80B65DD76F9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230422021735.27698-1-decui@microsoft.com>
 <20230422021735.27698-6-decui@microsoft.com>
 <BYAPR21MB16888DA20245DDBC572A2240D76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB1335046F4BA2B407C9026130BF6F9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335046F4BA2B407C9026130BF6F9@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe447994-baa8-4b2f-a2ae-c9a8aadd7e33;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T17:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3654:EE_
x-ms-office365-filtering-correlation-id: c1d07026-c73c-4057-74ef-08db4b218a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kass5DpYQKjXvUkK7UEjDWmU3RUldFZSVF4IpP/94/JJ8tkwVT3/VlUr+/OlaglfqiXjrFc5+uyVhE+wKzAi5+py6xG7zfLXXbb68HPHBfqGlYHqJlZIKTj1Z+tXwe0Yd7yz+DpDuHo35LfLIWyo9uT2PiB1dedwcnYJ3ZLO3eLYdEdge2D2gZvl2Qp6m0rTbIJg70dyJCvgRg0E/NzRaW7ZJhVawFu2iF3cNV9et7spH3E17ELSpYdGF1ULbSq9ASp3oZ1l+9iZr87t3NUkNuH+6XPJ+sSW52lSvmgIzZyWaZ+g7Qtysw9fvINfSNHERh2xJVm7STSXaYOUduMxbuCl1lHF6fCgi1M5MRjn6HuXEfv+SIi2K6f+6MFxvD5ZGDUtX8tiZBOfgb9/vvh5uc1aHv8zT/ZlPectoLFfatuxZHaY1foMR9DgFSmVIkjw1YWyuR7hcQgQg2r1rmbbNKG534/AkyRxPqH9h8B+pGwmjTL05juzUGRzoTH324Bgk8jRKEbKwldYj0LR6Rmrq4OeDUsKkPtxWxggWz++QwGdJv0j1+8aiDbevn+YZYnFiK22v+vliJ6YRPmV+D52vbiqC7TdHYZcVVRejp4Z6gLgrHLTWUh11j36JkG9i1D02gS42+4QYpJ/D2nMrGi0qJLNZ8/GNCJonxRVcKUfoOG7rgBajx8MwKFq4V33JSHg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(86362001)(33656002)(478600001)(110136005)(54906003)(786003)(316002)(66556008)(66476007)(64756008)(4326008)(66446008)(76116006)(66946007)(7696005)(10290500003)(71200400001)(41300700001)(8990500004)(55016003)(5660300002)(52536014)(8936002)(2906002)(8676002)(38100700002)(82950400001)(7416002)(38070700005)(122000001)(921005)(82960400001)(186003)(107886003)(26005)(6506007)(9686003)(83380400001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FE9/OG+mj2HLJHnUmeLWWpaZLgBwu8j352f+AZRA4C7qDmGv7kRjjKEcDZt/?=
 =?us-ascii?Q?DYEXiBq07oOb9rtyW8d5SBled5pm9GkS1+vE5/DuJ2q5MG6XRsH8Ld1cQ5SB?=
 =?us-ascii?Q?d1eoKahN61quEwVlBqiKkikvxQ9H4lZjCPdIao6uoNya1ZMSx4T7RKArnUaG?=
 =?us-ascii?Q?t7LmdUfMU7yJUfGZrnzFccBedsPzRZs6or8Odkn4NB1p4VMQLmU2GHlv6qgS?=
 =?us-ascii?Q?d2lQPbLo4SWVTyMeKX+kLDDtnl46yo3WUStSLXSOGEPjTi/ErtIy2bVl7CCo?=
 =?us-ascii?Q?CVVomVMf2ovh4/imwu0l69I83w2FiQOEqH8Q1p7ITyqFjP3zQu+z1qUgKLdI?=
 =?us-ascii?Q?z9oGSpgM8FAYD5tt5I8p9s+4Unmvvgcwj+QWcEEBEaKOHtlmqo95qASyY9y7?=
 =?us-ascii?Q?q4Xrt/d2YXkPvpU0RAndtXRIHAHWT700c31Wchgo29zZpiFDq1pnilbyxick?=
 =?us-ascii?Q?3zI6VAuQeDHF0gVgKVA9y81G9gfGnmueCXF4jQjrDqEAeCF4limcC4h8yklv?=
 =?us-ascii?Q?qDuEyG2l0lu6VK9XLPnvJJBtTkuMATdEL8l/ys/Srhsh0+KUyFURX8fUrjJD?=
 =?us-ascii?Q?4fm+piUUWPyhicpCzm32StRy4veeJYWYPNLrg3v5detuA5YvmpOJlusTodj8?=
 =?us-ascii?Q?zPwRobaDgJd86cMAg2j/Ty7VNQl5J961cnledavCMKKdycl74XUyjFWJBJFB?=
 =?us-ascii?Q?u0Ef1n3llQOv9l2BNyhLaLzMwzdmertQkhXyIfw3p06rcHHeKq35JwtEROmc?=
 =?us-ascii?Q?eIlbGUrLi8+tDWjFrf2FGprrKAsrJfH8e+SNXuofrUZUO0IbcfMhka35E5ih?=
 =?us-ascii?Q?pU3ZYKyvk5fbB2Ag6O7Bc0zc467tRk0l62b3+JSL+bkKxrStw9852tfqDorR?=
 =?us-ascii?Q?FVLGM2g/Sd6KEC9V3/SiOGSFz11lGtcwvDE3sYnS8R58rCy+0tt8Ha8xN53a?=
 =?us-ascii?Q?Dr+c/3bcyjAznzZFFX/VDGIJzaUvAIULo1B9A6XkbcrxK1YaU8DslpmGDL4p?=
 =?us-ascii?Q?zgDq/0rg+gtPoLyn+4W9r7JGkzHvncQ41GOwZ9n7YKXK1TaYNmFsxc90KMna?=
 =?us-ascii?Q?dQXJK1qjIJqVarx/e4vw48bIxqAOSvQ52DYTuhhTk3gM2YVGoywz0dcFY4kK?=
 =?us-ascii?Q?NhmprbnSSL1K/bctwiK2XdT43dKmvBUT1/qivLEkkEG85Vda6KMWiSP4ciS5?=
 =?us-ascii?Q?/zqI81PstXeUOQS9BgONux7MQHx1cqy3J4mP7BAnkzb2IUNMMy8yCwY34fxG?=
 =?us-ascii?Q?WvGJw4pyw/CanDUE9RzvSOXJgCaOya/2LqJGCwAoxy7OY1ApiQ4T6ztfehPz?=
 =?us-ascii?Q?VhoSG+SXnJbTEkNl9rKMe5yqHVuA8o3pPJpNmSnaLgbJrlMBHGQhPb6azft2?=
 =?us-ascii?Q?EmQkS1gXRROEE/6WD1oYu7rAGv72SMQYdO2fGPLfQdbNUnGvf5ur6Jk3bLO5?=
 =?us-ascii?Q?jkcFPDE+XJrPIUM6na8jC+MhJEI6WrKAwbzSeDxg1MkzOop/8AaJAU49crrn?=
 =?us-ascii?Q?DX6PKVTHe4Zch39GrYdmiPgywEY7PEMjjaWU2cBDt1i71h3fYd7zeSIV3UrW?=
 =?us-ascii?Q?1lHNBhzEelArFezx5kGw1aFRSs1Z2KjJjC25oOHtVWpLklnwXgcNPLjxCYFA?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d07026-c73c-4057-74ef-08db4b218a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 15:26:02.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udq251sSY2ESOJWUX84RvXSnFZYhMETzoWh/nne+dXmQ2xDb7cAq49x6oahn1H2rMjlA1u9DZXW+7dhE/8/nwrOOcCAt80OFIO/IeYl7zJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3654
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, May 1, 2023 6:34 PM
>=20
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Monday, May 1, 2023 10:33 AM
> > ...
> > From: Dexuan Cui
> > >
> > > Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
> > >   No need to use hv_vp_assist_page.
> > >   Don't use the unsafe Hyper-V TSC page.
> > >   Don't try to use HV_REGISTER_CRASH_CTL.
> > >   Don't trust Hyper-V's TLB-flushing hypercalls.
> > >   Don't use lazy EOI.
> > >   Share SynIC Event/Message pages and VMBus Monitor pages with the
> > >  host.
> >
> > This patch no longer does anything with the VMBus monitor pages.
> Sorry, I forgot to update the commit log. Will drop this from the log.
>=20
> > >   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
> >
> > The above line in the commit message is stale and can be dropped.
> Will drop this from the commit log.
>=20
> > > @@ -116,6 +117,7 @@ int hv_synic_alloc(void)
> > >  {
> > >  	int cpu;
> > >  	struct hv_per_cpu_context *hv_cpu;
> > > +	int ret =3D -ENOMEM;
> > >
> > >  	/*
> > >  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> > > @@ -159,6 +161,28 @@ int hv_synic_alloc(void)
> > >  				goto err;
> > >  			}
> > >  		}
> > > +
> > > +		/* It's better to leak the page if the decryption fails. */
> > > +		if (hv_isolation_type_tdx()) {
> > > +			ret =3D set_memory_decrypted(
> > > +				(unsigned long)hv_cpu->synic_message_page, 1);
> > > +			if (ret) {
> > > +				pr_err("Failed to decrypt SYNIC msg page\n");
> > > +				hv_cpu->synic_message_page =3D NULL;
> > > +				goto err;
> > > +			}
> > > +
> > > +			ret =3D set_memory_decrypted(
> > > +				(unsigned long)hv_cpu->synic_event_page, 1);
> > > +			if (ret) {
> > > +				pr_err("Failed to decrypt SYNIC event page\n");
> > > +				hv_cpu->synic_event_page =3D NULL;
> > > +				goto err;
> > > +			}
> >
> > The error handling still doesn't work quite correctly.   In the TDX cas=
e, upon
> > exiting this function, the synic_message_page and the synic_event_page
> > must
> > each either be mapped decrypted or be NULL.  This requirement is so
> > that hv_synic_free() will do the right thing in changing the mapping ba=
ck to
> > encrypted.  hv_synic_free() can't handle a non-NULL page being encrypte=
d.
> >
> > In the above code, if we fail to decrypt the synic_message_page, then s=
etting
> > it to NULL will leak the page (which we'll live with) and ensures that
> > hv_synic_free()
> > will handle it correctly.  But at that point we'll exit with synic_even=
t_page
> > non-NULL and in the encrypted state, which hv_synic_free() can't handle=
.
> >
> > Michael
>=20
> Thanks for spotting the issue!
> I think the below extra changes should do the job:
>=20
> @@ -121,91 +121,102 @@ int hv_synic_alloc(void)
>=20
>         /*
>          * First, zero all per-cpu memory areas so hv_synic_free() can
>          * detect what memory has been allocated and cleanup properly
>          * after any failures.
>          */
>         for_each_present_cpu(cpu) {
>                 hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);
>                 memset(hv_cpu, 0, sizeof(*hv_cpu));
>         }
>=20
>         hv_context.hv_numa_map =3D kcalloc(nr_node_ids, sizeof(struct cpu=
mask),
>                                          GFP_KERNEL);
>         if (hv_context.hv_numa_map =3D=3D NULL) {
>                 pr_err("Unable to allocate NUMA map\n");
>                 goto err;
>         }
>=20
>         for_each_present_cpu(cpu) {
>                 hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
>                 tasklet_init(&hv_cpu->msg_dpc,
>                              vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>=20
>                 /*
>                  * Synic message and event pages are allocated by paravis=
or.
>                  * Skip these pages allocation here.
>                  */
>                 if (!hv_isolation_type_snp() && !hv_root_partition) {
>                         hv_cpu->synic_message_page =3D
>                                 (void *)get_zeroed_page(GFP_ATOMIC);
>                         if (hv_cpu->synic_message_page =3D=3D NULL) {
>                                 pr_err("Unable to allocate SYNIC message =
page\n");
>                                 goto err;
>                         }
>=20
>                         hv_cpu->synic_event_page =3D
>                                 (void *)get_zeroed_page(GFP_ATOMIC);
>                         if (hv_cpu->synic_event_page =3D=3D NULL) {
>                                 pr_err("Unable to allocate SYNIC event pa=
ge\n");
> +
> +                               free_page((unsigned long)hv_cpu->synic_me=
ssage_page);
> +                               hv_cpu->synic_message_page =3D NULL;
> +
>                                 goto err;
>                         }
>                 }
>=20
>                 /* It's better to leak the page if the decryption fails. =
*/
>                 if (hv_isolation_type_tdx()) {
>                         ret =3D set_memory_decrypted(
>                                 (unsigned long)hv_cpu->synic_message_page=
, 1);
>                         if (ret) {
>                                 pr_err("Failed to decrypt SYNIC msg page\=
n");
>                                 hv_cpu->synic_message_page =3D NULL;
> +
> +                               /*
> +                                * Free the event page so that a TDX VM w=
on't
> +                                * try to encrypt the page in hv_synic_fr=
ee().
> +                                */
> +                               free_page((unsigned long)hv_cpu->synic_ev=
ent_page);
> +                               hv_cpu->synic_event_page =3D NULL;
>                                 goto err;
>                         }
>=20
>                         ret =3D set_memory_decrypted(
>                                 (unsigned long)hv_cpu->synic_event_page, =
1);
>                         if (ret) {
>                                 pr_err("Failed to decrypt SYNIC event pag=
e\n");
>                                 hv_cpu->synic_event_page =3D NULL;
>                                 goto err;
>                         }
>=20
>                         memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
>                         memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
>                 }
>         }
>=20
>         return 0;
>  err:
>         /*
>          * Any memory allocations that succeeded will be freed when
>          * the caller cleans up by calling hv_synic_free()
>          */
>         return ret;
>  }
>=20
> I'm going to use the below (i.e. v5 + the above extra changes) in v6.
> Please let me know if there is still any bug.
>=20
> @@ -116,6 +117,7 @@ int hv_synic_alloc(void)
>  {
>         int cpu;
>         struct hv_per_cpu_context *hv_cpu;
> +       int ret =3D -ENOMEM;
>=20
>         /*
>          * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -156,9 +158,42 @@ int hv_synic_alloc(void)
>                                 (void *)get_zeroed_page(GFP_ATOMIC);
>                         if (hv_cpu->synic_event_page =3D=3D NULL) {
>                                 pr_err("Unable to allocate SYNIC event pa=
ge\n");
> +
> +                               free_page((unsigned long)hv_cpu->synic_me=
ssage_page);
> +                               hv_cpu->synic_message_page =3D NULL;
> +
>                                 goto err;
>                         }
>                 }
> +
> +               /* It's better to leak the page if the decryption fails. =
*/
> +               if (hv_isolation_type_tdx()) {
> +                       ret =3D set_memory_decrypted(
> +                               (unsigned long)hv_cpu->synic_message_page=
, 1);
> +                       if (ret) {
> +                               pr_err("Failed to decrypt SYNIC msg page\=
n");
> +                               hv_cpu->synic_message_page =3D NULL;
> +
> +                               /*
> +                                * Free the event page so that a TDX VM w=
on't
> +                                * try to encrypt the page in hv_synic_fr=
ee().
> +                                */
> +                               free_page((unsigned long)hv_cpu->synic_ev=
ent_page);
> +                               hv_cpu->synic_event_page =3D NULL;
> +                               goto err;
> +                       }
> +
> +                       ret =3D set_memory_decrypted(
> +                               (unsigned long)hv_cpu->synic_event_page, =
1);
> +                       if (ret) {
> +                               pr_err("Failed to decrypt SYNIC event pag=
e\n");
> +                               hv_cpu->synic_event_page =3D NULL;
> +                               goto err;
> +                       }
> +
> +                       memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +                       memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +               }

Yes, this looks good to me.  A minor point:  In the two calls to set decryp=
ted,
if there is a failure, output the value of "ret" in the error message.  It =
should
never happen, but if it did, it could be hard to diagnose, and we'll want a=
ll
the info we can get about the failure.  And do the same in hv_synic_free()
if setting back to encrypted should fail.

Michael

>         }
>=20
>         return 0;
> @@ -167,18 +202,40 @@ int hv_synic_alloc(void)
>          * Any memory allocations that succeeded will be freed when
>          * the caller cleans up by calling hv_synic_free()
>          */
> -       return -ENOMEM;
> +       return ret;
>  }
>=20
>=20
>  void hv_synic_free(void)
>  {
>         int cpu;
> +       int ret;
>=20
>         for_each_present_cpu(cpu) {
>                 struct hv_per_cpu_context *hv_cpu
>                         =3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> +               /* It's better to leak the page if the encryption fails. =
*/
> +               if (hv_isolation_type_tdx()) {
> +                       if (hv_cpu->synic_message_page) {
> +                               ret =3D set_memory_encrypted((unsigned lo=
ng)
> +                                       hv_cpu->synic_message_page, 1);
> +                               if (ret) {
> +                                       pr_err("Failed to encrypt SYNIC m=
sg page\n");
> +                                       hv_cpu->synic_message_page =3D NU=
LL;
> +                               }
> +                       }
> +
> +                       if (hv_cpu->synic_event_page) {
> +                               ret =3D set_memory_encrypted((unsigned lo=
ng)
> +                                       hv_cpu->synic_event_page, 1);
> +                               if (ret) {
> +                                       pr_err("Failed to encrypt SYNIC e=
vent page\n");
> +                                       hv_cpu->synic_event_page =3D NULL=
;
> +                               }
> +                       }
> +               }
> +
>                 free_page((unsigned long)hv_cpu->synic_event_page);
>                 free_page((unsigned long)hv_cpu->synic_message_page);
>         }
>=20
>=20
> I'll post a separate patch (currently if hv_synic_alloc() --> get_zeroed_=
page() fails,
> hv_context.hv_numa_map is leaked):
>=20
>=20
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1515,27 +1515,27 @@ static int vmbus_bus_init(void)
>         }
>=20
>         ret =3D hv_synic_alloc();
>         if (ret)
>                 goto err_alloc;
>=20
>         /*
>          * Initialize the per-cpu interrupt state and stimer state.
>          * Then connect to the host.
>          */
>         ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:onli=
ne",
>                                 hv_synic_init, hv_synic_cleanup);
>         if (ret < 0)
> -               goto err_cpuhp;
> +               goto err_alloc;
>         hyperv_cpuhp_online =3D ret;
>=20
>         ret =3D vmbus_connect();
>         if (ret)
>                 goto err_connect;
>=20
>         if (hv_is_isolation_supported())
>                 sysctl_record_panic_msg =3D 0;
>=20
>         /*
>          * Only register if the crash MSRs are available
>          */
>         if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABL=
E) {
> @@ -1567,29 +1567,28 @@ static int vmbus_bus_init(void)
>         /*
>          * Always register the vmbus unload panic notifier because we
>          * need to shut the VMbus channel connection on panic.
>          */
>         atomic_notifier_chain_register(&panic_notifier_list,
>                                &hyperv_panic_vmbus_unload_block);
>=20
>         vmbus_request_offers();
>=20
>         return 0;
>=20
>  err_connect:
>         cpuhp_remove_state(hyperv_cpuhp_online);
> -err_cpuhp:
> -       hv_synic_free();
>  err_alloc:
> +       hv_synic_free();
>         if (vmbus_irq =3D=3D -1) {
>                 hv_remove_vmbus_handler();
>         } else {
>                 free_percpu_irq(vmbus_irq, vmbus_evt);
>                 free_percpu(vmbus_evt);
>         }
>  err_setup:
>         bus_unregister(&hv_bus);
>         unregister_sysctl_table(hv_ctl_table_hdr);
>         hv_ctl_table_hdr =3D NULL;
>         return ret;
>  }

