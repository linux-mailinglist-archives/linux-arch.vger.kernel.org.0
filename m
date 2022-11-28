Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1A63B35A
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 21:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiK1Ugo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 15:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiK1Ugn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 15:36:43 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021020.outbound.protection.outlook.com [52.101.47.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427E2AC61;
        Mon, 28 Nov 2022 12:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymq/YjlLhDmH3wn0M4i09bOUCeZAxT4MD4P6lxXFxcu6PRMphf+4Zh3n7+fjC5vVw0nTC9KaJAtRmWO1n/mjRRLiopP/a88M6mUNLRnn0iLdBzPzXvFwRbQhIeXJddzh4o+0+0A2l5yW7pKdyoP8lPE0GtCs0/WXXNF35vFCP/I2NsFeREtk0bqJqBwXtMq3vXDjEPo1EPp2yqhdBr+dCEwrz+n8gzV4LRrM1iSrgdunG07Wg6pVH9Wqc9fV0ZVNdL5Xv6xzwCItHdNDsmubHXZEGicihx1RYxifbuELZZBY5+7yTMVq5gM/AYsw3u4xwkGFgjv0mw7E01W7foSxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmIhozhAAWi1Z65Gsn9Z867CRvTftx0iAEivD60niPs=;
 b=WED0F7FSc0Bv8kYh3wGtPrYAIEBsJyJxTrk97HAg1QhOHbllHn0/uj7YCcPCVQdF1dcVvULoEL1FUsf/zC2UOFUEf9QfNP3mXCLREZx9l+g7qnEvRZsDjHbgaePHVr0r7UTEq7kDJ0k8yBkms4k4Ruvlo/MB0BM+ihwSFR8s3V1VdBY8Ty30cQp6ZiMIdNFwdniRjszJ4FHibre0DCdnk3WxazQLNTWVtYORx9dz9TDRol9Q4ilrXV7HRdH/ElaBdqqNFfL9k777yJc67vxon8T9V8Nlp7tgf+RqrTu+YjT46wZSAXyApWBI/4kIiIrtURzsazawY4PysmN8sjMFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmIhozhAAWi1Z65Gsn9Z867CRvTftx0iAEivD60niPs=;
 b=NWmPbVWyvVtVQJrm0xT0WUdTBgYF3oIUvvL7bgguomrT8HbwALkLA4GhewTi7oK5m7/X1Pi4qfDxyqKRsGIwWa9EIJwojfZoP2CO7URM4NdP7HxSEC67UILWEKWn3LQDMb+X9qd1/0uOFAyTlE9qAHYsjF7b7v+GEXOPfOkdH+Q=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BY5PR21MB1458.namprd21.prod.outlook.com (2603:10b6:a03:23f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Mon, 28 Nov
 2022 20:36:38 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 20:36:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgADyjYCAAC5pcIAAEXiAgAAD5oCAAAZzgIAABoTw
Date:   Mon, 28 Nov 2022 20:36:37 +0000
Message-ID: <SA1PR21MB1335BA75F51964636745E486BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
 <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
 <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <f6d27366-e083-b362-b44c-eaf4d3365b53@intel.com>
In-Reply-To: <f6d27366-e083-b362-b44c-eaf4d3365b53@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7c3eddb3-1b19-4bc3-9f28-639de49eb635;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T20:11:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BY5PR21MB1458:EE_
x-ms-office365-filtering-correlation-id: e848ce24-24e2-429f-5446-08dad1803f9f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qR9aq00w7rcEc6yof/SX0LRZ/kX90N603QxPAnP2506KR74CErXn06agGtB032qmd9i4sY6F/DADonc3zxZMwuiRoOty6aNmDH6kK6YyzLJi50+Z200YTBpBVnm20vil64yDZAFl9kj8ftmAMnrgNz4jbhgPpsmbVYYoOZrIyIClG13upwYW79W/yl6MQsk9mZA7ofergrkaDcu7RAsVAXgTD9Axd3MgZerE9m+UHaKS6eRaDC3YhsUovUrsNZyIqFXWpxPn3G+/ySbPwTrtEE6ajwW9xGH7f32H7J4VrN39VhCWdq2G98SyO6HxtnOgY7W+Qys2acKxZzl5qQywc44ZysfLdOAXZP1XnHGz8noHyKhauxW6cOspsLdFuxxLvm+0DiWHKyF1PL/iG3i/VCfszGiTDQzQXYHANyVgsU7YJ6G9eIPC45erjEA5IUdw5zyke0CABXE0LywpzfecxMkseXnl+xVKnWgXmS2YWr0tADZK1tZoKc7n3wN7ovmAF7BkpA6UiLWflOxJfknYO5Ji0Lmue6wkEoxW5l1BSdLs2JsGYk+VO/HIglSFimBWhf1IwCV+/DumDppu7G7BA77t+01t+aPTz/6dPhjfI03rT1Z3iRz5/by+pIg7k28H9TQdnGyK50pjG7927WBbzXPSmA50RQG0Ax8BKVqBoaOILmpMSnqZc4dEre+oDZzYA6/1edJWZgYICR0FETWCIOyRh9usEDCUxwTMnJD+TO6jvmPJW6SpARiTdMfOV3vheoTvH3axLcNy5QDXUX8q+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(53546011)(110136005)(7696005)(6506007)(10290500003)(26005)(9686003)(71200400001)(66946007)(76116006)(66446008)(66476007)(66556008)(8676002)(64756008)(4326008)(478600001)(316002)(5660300002)(8936002)(52536014)(7416002)(2906002)(186003)(41300700001)(8990500004)(122000001)(38100700002)(921005)(82960400001)(82950400001)(38070700005)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lal3PygNbmNnZhuMA5crK5JoMLtYUl3wyqfhA1DZlm7kKcCoSaYgHPg/FDiO?=
 =?us-ascii?Q?MecRuJMAXeumrW6zHY2UFfBUe/LU+tf+lUDZkA2IlJUyD3gOLi+vJnebxlIY?=
 =?us-ascii?Q?6eSisNVGCJb4BFxM1ccDsYvxYB86MV7xInMmpYd8LqPVq2SROZVrZsNyQFhe?=
 =?us-ascii?Q?sJd8luc3YVT9TpeVFRt+SlYZd4eZvlfXQ/DK1edpl9tb3zdui36/4jql567f?=
 =?us-ascii?Q?/823A5Blv7mzV33lru/jXkFGLvnbcpfkzpvm+bwfFOYBse1ypZIEmrgEKzN1?=
 =?us-ascii?Q?a0DI9ELokY2F0vbdlZPgNuBskmdmwDXl2lSM09/VA+RTATKnB+mMA7D0X4Ep?=
 =?us-ascii?Q?uOoXvX5bFqN981gFY9Tn2OChcPtxLFM/U19wwZFHMwBU4NA1rVNY943tQYB4?=
 =?us-ascii?Q?I/3B1FPu2n//NyqTkUAUOKSzQZVw0Pof4HFCOSEG13hEOLLwtKP3MpHGj5x5?=
 =?us-ascii?Q?CWWmFyBNVhbTlZVcF35HOi9EC53DgX1kZyGty9RRCQaLcWBoEc7zzLYPiFhk?=
 =?us-ascii?Q?ZUV32z5iveEVWWhohDy/BEvnMPB8Qj+y3fnlqaeH/e3wo2yZB/ncfAqdXe2U?=
 =?us-ascii?Q?ckzMDBdKNFHOpKsgKPaN3PUQTOADgA9KLWmxzKZ9ktTjLAYRsuDjkMtlC1B0?=
 =?us-ascii?Q?FTGQY+cVP4wwM4wCss2rDTxT20PQx6lxyqgLpw+iM9d9Cwe5ttxdTl2yS7Ie?=
 =?us-ascii?Q?CX4RdGLO41HoT4LAINI1FCk3m0clloIDn2a9RCqPwD+X3Ei1JJW1qQyPuOhh?=
 =?us-ascii?Q?3xW+LEKR3zExhnqILaGSimyHmg0weM/bpLLdNvTSwsQr6YfMF7BLdxL2K092?=
 =?us-ascii?Q?uBtliJ0niwxvLs75oPu64R6BYJBJozF7wzWbIrnvPWmefJCXmuSSMKJw+2v+?=
 =?us-ascii?Q?mdDp4MWvC/jxIFjJ1Lv02jRx+BBKoqex17LcB+0h8ONNvvMhvqkE1mPjuNF1?=
 =?us-ascii?Q?q4UYBp1wmpJOVjHTR+NKFsOcMTW+QPMx/5hFwqddXAtI0TzOKxJtsPLoMFmF?=
 =?us-ascii?Q?xpHQVWX1uKXHsp0BTdSUBAE+eS2Mh2FDQctX36pPiA0Ir/9XN2uG+FEaCO+D?=
 =?us-ascii?Q?o34gG6EoJlYk07A54obtPc1L7djSwbjpuXK1Zab/6Tcrh9c3WdhqBhko8EGy?=
 =?us-ascii?Q?nrNhc1YYTMdFO53xlORFDbOfyeTx6RPIqmINAlvXOnpvPui2dseWMvIhoOgr?=
 =?us-ascii?Q?+hwApWZC//zDenARSu8ray6iqAuw+cKcSL9WW5bJGwo3YIy+zzWAQ31gbBuX?=
 =?us-ascii?Q?H0T67LBwiZ/uTURbnzRmWi6QJYr6jBjdjvHmVMdlDsvwC9wiu/afTyFI7zbH?=
 =?us-ascii?Q?mOBlwFdZMO1EiM9TNwwx8LLiIkuW7TyyeLqb3be+T2hFDI7Y61xJ0VZ4FMUE?=
 =?us-ascii?Q?FscBWoB2wHzoVzm+MvFLUHl5mb5VFnAIgYeiRTAYkR4TAJ2HvIikQz7IOlfD?=
 =?us-ascii?Q?b03X8yQ06Vcg0XyPEcfRgdO4Rz//5i0dWJhCWMRjT7aOdnlEkB02+YauOQ0x?=
 =?us-ascii?Q?9hIgHzBr097tl1LBCUs6788l0vPIVvK+FdpzYCx2vQEr4i0LJO4NhPzm1bA/?=
 =?us-ascii?Q?OqGA1mrzStYuy07LWBFaG47WqqOHZ7m9z6Qn3QBd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e848ce24-24e2-429f-5446-08dad1803f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 20:36:37.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaZRQZGOCvSxWCfm1nztNHqt4Jhh3jABM9UINdl/dLbNvBg+OQ/bC/ISc9amrOs9EDoqmwJg+UiWS/w8s+ZuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dave Hansen <dave.hansen@intel.com>
> Sent: Monday, November 28, 2022 11:48 AM
>=20
> On 11/28/22 11:37, Dexuan Cui wrote:
> >> From: Dave Hansen <dave.hansen@intel.com>
> ...
> >> How do we know, for instance, that no hypercall using this interface
> >> will *ever* take the 0x0 physical address as an argument?
> >
> > A 0x0 physical address as an argument still works: the 0 is passed
> > to the hypervisor using GHCI. I believe Hyper-V interprets the 0 as
> > an error (if the param is needed), and returns an "invalid parameter"
> > error code to the guest.
>=20
> I don't see any data in the public documentation to support the claim
> that 0x0 is a special argument for either the input or output GPA
> parameters.

Sorry, I didn't make it clear. I meant: for some hypercalls, Hyper-V
doesn't really need an "input" param or an "output" param, so Linux
passes 0 for such a "not needed" param. Maybe Linux can pass any
value for such a "not needed" param, if Hyper-V just ignores the
"not needed" param. Some examples:

arch/x86/hyperv/hv_init.c: hv_get_partition_id():
    status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);

drivers/pci/controller/pci-hyperv.c:
    res =3D hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
                      params, NULL);


If a param is needed and is supposed to be a non-zero memory address,
Linux running as a TDX guest must pass "cc_mkdec(address)" rather than
"address", otherwise I suspect the result is undefined, e.g. Hyper-V might
return an error to the guest, or Hyper-V might just terminate the guest,
especially if Linux passes 0 or cc_mkdec(0).

Currently all the users of hv_do_hypercall() pass valid arguments.
=20
> This is despite some actual discussion on things like their alignment
> requirements[1] and interactions with overlay pages.
>=20
> So, either you are mistaken about that behavior, or it looks like the
> documentation needs updating.

The above is just my conjecture. I don't know how exactly Hyper-V works.
