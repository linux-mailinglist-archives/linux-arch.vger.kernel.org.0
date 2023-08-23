Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B787851CE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjHWHkj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjHWHki (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 03:40:38 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020016.outbound.protection.outlook.com [52.101.128.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F9FB;
        Wed, 23 Aug 2023 00:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdrOWUKCY+tZ6Tj9LLaVETI2iypnkUKDy2a6/FL0yYHfJqv3+ZnJxZpOgQ6IviGSVGMYzSiFIciEYdzl3Y1AWcXnV3DAj+jRSrpURcgHBgeyNNy/Yl+5BvKiddGzjootsBHW1rGWeuQYCAyOb+FLRCgd1cRqn5Jv//ANZV0C06D9nndfqN3i0C4hno658Qf/98TO6VffzQJUJXHO3gps5KEq70zRemg6MEWm0tZiPCavp9xda9+f6PvjbRr7w5bRAOfuizDU2XLJqaWDYLm7KS6WxCLCIRMutvZKfwr2FeriyhY4UBVlU/m+NqEM/UcXrv5fKqwSVFBvNN9Og/BGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku/BsbCksZ4ZeS7Wn5A8BMT4Hh17yQu5w7cY3hWADIc=;
 b=USf8BmBKqdMf99HLZ1KP7UxEaza4ZduSt5n/1/6+comkXeqh7e0RLSv9AA0bm9rP4I7qp9XO4owTUqT7MbIWLhHtigUk6vaPJOywvD6/EUrXr/d8GSrREU+KcbJw/ei7wGAjdCU9H2q06Y/VFDeii33L14u0XkC618RgvWK4PoYET63hLgtyCECvCSW7e5t8bVUK5AvkrLb1t4HN+RcTVGN7UW3+qqj7frnv4WeYYYsb7R1SETteSkRuEdEC0Hx5BB1iWVWjCYdtX6USPQenc8RgqnXrQhj9brJgMbT4k+veSFoIY+wrln1tfvBffpX64PNRYAYazHPjFWRNVITDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku/BsbCksZ4ZeS7Wn5A8BMT4Hh17yQu5w7cY3hWADIc=;
 b=XDaGf3ygfdNLpk+oJjR+lYxlNDK0lxkbZDll/F+LtoK8lMKWIErgAaY3PrIL85i65qEBDl7pU0ESzoZWNWhkzSgVEmqRXLZ4zc5ZsCRzfG6i7N9eRCuU85gvNEOtp0NiMYdD9vyi2+IPGPoUMvlP7DcDa+u9lTK+q74COKwzXLg=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0458.APCP153.PROD.OUTLOOK.COM (2603:1096:4:130::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.5; Wed, 23 Aug 2023 07:40:31 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.005; Wed, 23 Aug 2023
 07:40:31 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Topic: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Index: AQHZ0VZ96EEPB9Xi80mUoj983vpcr6/v7KBwgAB88wCAAjguIIAEJ0yAgACyiqA=
Date:   Wed, 23 Aug 2023 07:40:30 +0000
Message-ID: <PUZP153MB06355D695AC8AAFD2624ED2BBE1CA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
 <PUZP153MB063545036E6B547C009F6AECBE1BA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <664aec4c-7ea9-447f-afab-9e31e9e106c1@linux.microsoft.com>
 <PUZP153MB0635A9EBE87C3589612B628CBE19A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <8978223c-c5e8-4235-a0ed-2031583c2751@linux.microsoft.com>
In-Reply-To: <8978223c-c5e8-4235-a0ed-2031583c2751@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75ae88da-eda1-415c-97f3-a1cc5fa28960;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-23T06:57:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0458:EE_
x-ms-office365-filtering-correlation-id: cec627cb-beae-4e8f-2f4d-08dba3ac3a37
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cL83czVKM3J7hsoIFKyLjsvD+2wM61j5t/ULh/SSt+I9t6+g4XJEHWod1I3T83UaKOfIwG9DrgU1NwntTiMBhh35qZcHCGBLufAnxWcwsxLYI+MQWa4c9n9bAcMYtn5CJffVo/nAljA174a2tIWglkTHtsjpI8gmf2icvS03sZGeD1tDPC2LWd/xRfWiM7FdWQ1ja4Jp1/wURR3qqWQfeoiy6b71lfzXbhbx6A94P6bb60d1svxcFpMkbGwJWQqFuN8jC2LPdjxELMHe5CBccFB082kC+ULvemogn8actirtvZwK5H+0zPBh9MyhaLWP5+FHXBkbsf0RTDdTCNgGYgFXRSaVVVHiZrW/74gAUs8JlEVzBxj7+bnppimiZ+ZhzztfJ2I+U7J9KWFi3Chr+e1E7Fjo3NdMpoDm2akbXovVsa1i2qy7mKEdsB4CCeMzls9i5vdCxe+0IqCymMFUJFNIN6kdT9Byrv9KTdg73Q0XwFvXJG/8o+t6T8mK//K6GzrQ5q/kibB8RUocd8GwBN1kvkVP3lVOOyR7cYCOKTF4Zd039tGJZtggauuBChW7v9ErBbv9+x8wcJUnP2iA6xtQRMzdMOJ/bOXJ1Ivl+yBPXNyXUyQOyJvLfoI7AKPK9ZEACFH3bYOyS9xfttQhjxcRDJoA0u0nmUdPbWmbkbyUtYAAMDdOGtkwlb7gI6H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199024)(1800799009)(186009)(83380400001)(7416002)(2906002)(10290500003)(478600001)(41300700001)(66556008)(7696005)(66476007)(66446008)(64756008)(53546011)(71200400001)(12101799020)(52536014)(5660300002)(4326008)(8676002)(54906003)(8936002)(66946007)(122000001)(82950400001)(38070700005)(38100700002)(110136005)(76116006)(6506007)(316002)(9686003)(8990500004)(82960400001)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1B3bYq1RQSwxx0BG8z3FkmeYqiaCOtKvweLq9FrsCArvghs3HnROnizOlNM?=
 =?us-ascii?Q?Cyn92LDMzOF33gSmA+eLObjKosWHqdJqCiPzcCoVgBKD8CCgCXeX9wBQcmw4?=
 =?us-ascii?Q?SpOoDVacgZij86wefrrl327HyBguais8EKENwGugBJ7rmf2qiMx6Bs8QvJSR?=
 =?us-ascii?Q?9bx2yvBns6BvXEPE4gmOfacPvjJ2fThYMOQSQWZQi5+4zIs9h+HsX3c/hL4S?=
 =?us-ascii?Q?YFVdLhgbe82kmUpq60cxCelUmFpYLJDchCX2WxLsRXwPt2boAfmsNVMGdzmO?=
 =?us-ascii?Q?LDr6pmX+70BI31UXx4iM9tueq6v6T1ub/sGhbftVC5ckKhHh1xkx+rpjVsUb?=
 =?us-ascii?Q?OX6mFV53hxjCf0acPXrrmobVS1XZ6Rv2kCUvWflodRqOeRH+Dodso7V/Yxrx?=
 =?us-ascii?Q?ZO2u0v4Yxfg5QngySrGuG4D/Qrwl3WWJ65wlKz5Qef83tBdOAbvIo9c1gE7S?=
 =?us-ascii?Q?fGDDB8OQnDu2JreItL8kRPzt3rNDzSZQvovk9zwFVRCv1py0Wi4r7Rn6D9JO?=
 =?us-ascii?Q?SlV9PWQX8SaZF6KLVMlOIqwk8uTO8UBpVB8U/KPCSrGX3GPQOv+psxq3oVvu?=
 =?us-ascii?Q?fTs2u0BWsW9CvQh/AXgrSibnMmDcakj5/1tipQPaDWZiF2syZ91urRsrybhM?=
 =?us-ascii?Q?wf/RlXZMdGCL0+1tFEMpy7FK3r12EVT45iZYrjfWei28PJdh+yDYEADzGfDk?=
 =?us-ascii?Q?xL9DewhD8ibkUNebW5ADtiQZbWlq14QQ/pdhi0OPeo0IKH8dEn5NGcJKXRDU?=
 =?us-ascii?Q?MCtsX0XVRavRNxVQUajOe5zPTkC1p0OXCnrRyVR+ej9jVQEc8a58O7xL0r/H?=
 =?us-ascii?Q?+M9dGG8Z3pzG3cLSyW/x2D2WdIHk6upJwcWUBh5B0Y5ZSzYJ16MmdhDpmBOw?=
 =?us-ascii?Q?w3XESi8m2BN51G3vylU/JyVjs/Sd5ZESz85oLFgNj5MH8vm/8Qj9xozk2Xei?=
 =?us-ascii?Q?g2O90/qk55lNThdmCqJ+VjIJeeHS2k68Zf9z6RliEfDdSzUckqUghtLxCaJx?=
 =?us-ascii?Q?F1wTEJfBlKwRn/15l/jp28Ptw9gyVA03BDJ23b/0ro1EzEcs21CxSHr+Ai6Z?=
 =?us-ascii?Q?AuD7KnpyPFzvos8IfOzYCLI9KMrh5aImILHVJNcpjZBRM8Py96wzIbGnf/Y3?=
 =?us-ascii?Q?+C0MIfNfKqdTcpAANEwTsh3GVQvwhP2tEt3XOcWWQsYUgn7rL+jCGEfyikxI?=
 =?us-ascii?Q?gnC1N38N0e1ERVvStVzf88MTfdFWoDAtvX4DIHMqF+MznfNB+dB1sfpKDL/q?=
 =?us-ascii?Q?+KXryDxOe5Y1615shWuy5kA/nYZTky+jqXFxszM4Zwwb8DdprW2r2G8/MKap?=
 =?us-ascii?Q?4bRQ0h7X0mQnTqZFosNIPhjIBw3Egeq1IL5zcAgeb1VMUYrFpWtSQxFTYVDv?=
 =?us-ascii?Q?Mh4rdzElXo01Y8fw+lbtNrXYhr/oTWhZkBS3hbJK1P9K93cvxJf2H7O2tB5G?=
 =?us-ascii?Q?w88wXaL6/RWD8I9aPozNQyuQz9fEqrHsoUMBK/x0W1fn5oPYmn5UpPVx0Ktq?=
 =?us-ascii?Q?xjNkgc7LsqQZDFMXSAmqDEq6HEEqBu75NJz4xQ3IIJMLZr8ziO2bUmtEID5Z?=
 =?us-ascii?Q?DS7GSlFju7kCRAoxOQm++763pIr0sT05+74yXI3e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cec627cb-beae-4e8f-2f4d-08dba3ac3a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:40:30.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTEVaPDj/bQaEx9LtYCIUdT5ynGEMk7BMqPYbBzUDcDYQtsfQQMybWKjWVgi9thJ6jWlHfk9fjK8xnHoj2xD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Sent: Wednesday, August 23, 2023 1:49 AM
> To: Saurabh Singh Sengar <ssengar@microsoft.com>; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org; lin=
ux-
> arm-kernel@lists.infradead.org; linux-arch@vger.kernel.org
> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
> RATHOR <mukeshrathor@microsoft.com>; stanislav.kinsburskiy@gmail.com;
> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
> catalin.marinas@arm.com
> Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/msh=
v
> to VMMs running on Hyper-V
>=20
> On 8/19/2023 10:19 PM, Saurabh Singh Sengar wrote:
> >
> >
> >> -----Original Message-----
> >> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Sent: Saturday, August 19, 2023 12:30 AM
> >> To: Saurabh Singh Sengar <ssengar@microsoft.com>; linux-
> >> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org;
> >> linux- arm-kernel@lists.infradead.org; linux-arch@vger.kernel.org
> >> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
> >> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> >> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan
> >> Cui <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
> >> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
> >> RATHOR <mukeshrathor@microsoft.com>;
> stanislav.kinsburskiy@gmail.com;
> >> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
> >> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> >> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
> >> catalin.marinas@arm.com
> >> Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose
> >> /dev/mshv to VMMs running on Hyper-V
> >>
> >> On 8/18/2023 6:08 AM, Saurabh Singh Sengar wrote:
> >>>> +
> >>>> +config MSHV_VTL
> >>>> +	tristate "Microsoft Hyper-V VTL driver"
> >>>> +	depends on MSHV
> >>>> +	select HYPERV_VTL_MODE
> >>>> +	select TRANSPARENT_HUGEPAGE
> >>>
> >>> TRANSPARENT_HUGEPAGE can be avoided for now.
> >>>
> >>
> >> I will remove it in the next version. Thanks.
> >>>> +
> >>>> +#define HV_GET_REGISTER_BATCH_SIZE	\
> >>>> +	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
> >>>> +#define HV_SET_REGISTER_BATCH_SIZE	\
> >>>> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
> >>>> +		/ sizeof(struct hv_register_assoc))
> >>>> +
> >>>> +int hv_call_get_vp_registers(
> >>>> +		u32 vp_index,
> >>>> +		u64 partition_id,
> >>>> +		u16 count,
> >>>> +		union hv_input_vtl input_vtl,
> >>>> +		struct hv_register_assoc *registers) {
> >>>> +	struct hv_input_get_vp_registers *input_page;
> >>>> +	union hv_register_value *output_page;
> >>>> +	u16 completed =3D 0;
> >>>> +	unsigned long remaining =3D count;
> >>>> +	int rep_count, i;
> >>>> +	u64 status;
> >>>> +	unsigned long flags;
> >>>> +
> >>>> +	local_irq_save(flags);
> >>>> +
> >>>> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >>>> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >>>> +
> >>>> +	input_page->partition_id =3D partition_id;
> >>>> +	input_page->vp_index =3D vp_index;
> >>>> +	input_page->input_vtl.as_uint8 =3D input_vtl.as_uint8;
> >>>> +	input_page->rsvd_z8 =3D 0;
> >>>> +	input_page->rsvd_z16 =3D 0;
> >>>> +
> >>>> +	while (remaining) {
> >>>> +		rep_count =3D min(remaining, HV_GET_REGISTER_BATCH_SIZE);
> >>>> +		for (i =3D 0; i < rep_count; ++i)
> >>>> +			input_page->names[i] =3D registers[i].name;
> >>>> +
> >>>> +		status =3D hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS,
> >>>> rep_count,
> >>>> +					     0, input_page, output_page);
> >>>
> >>> Is there any possibility that count value is passed 0 by mistake ?
> >>> In that case status will remain uninitialized.
> >>>
> >>
> >> These lines ensure rep_count is never 0 here:
> >>
> >> 	while (remaining) {
> >> 		rep_count =3D min(remaining, HV_GET_REGISTER_BATCH_SIZE);
> >>
> >> Remaining can't be 0 or the loop would exit, and
> >> HV_GET_REGISTER_BATCH_SIZE is not 0, or we would never get any
> registers.
> >
> > There is a parameter in this function "count". I was checking if there
> > is any possibility that is passed as 0 by mistake ? this will lead to
> > "remaining" value as 0 and loop will never execute. Which results using
> "status" uninitialized later in the function.
> >
> >
>=20
> Ah ok, thanks! I will change it to return immediately in case count is 0.

Or you can initialize status with appropriate error value, either way is fi=
ne.
Please consider fixing the same issue in hv_call_set_vp_registers as well.

- Saurabh
