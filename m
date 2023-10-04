Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC97B86B2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjJDRgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjJDRgl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 13:36:41 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE3A9;
        Wed,  4 Oct 2023 10:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtvUh03AoemAkFbRhPhsVhnktqB1FL7ocbCwU6RlwFtDc7xJljPxf2a1UpK+aNo75jru/x+uSkEfk6zm+HOqW3DLX4Mr9NqkDFCPNgsE329vh7BhEyKp+0PcUHRbt5L3s6VOhHEEsAODOtXwTrWKizuyyTnhVE4uJc2Wcp7iXpABhBY8UJggbYhRkvlC+ePopNI/2/rrooUQX9R7FNcGu3Tch4Gpf/2DgecM6ICMMh70PLhZSipzd0/vDddt+j2XEcapU1lQ9YWahjDtqo7GP8sotSbYKithSwOg+XeBG/W+bDdukHRiw/VrbNKtAtDWI0Yb+CMn+DVkOofuIczGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkkEpZ4+Kc3iOtxkjaUM0Dq3gOgJh081dNnPFqjujDY=;
 b=BpZa+S2uriFsVLYehKZImKGbKs9qk2VkYCm3zyjFN8sBZzDlXnjZ8W7QV89q2z+HSnYo0WxEx0frH3axhQxqpZvA+b/PvZ28Ccn2Hzr/ilfe3gx6LE/ibiafJqLwJQhVK9xgC6VbkB2TGLbpLL0KD4yZQDioXxzDS/tACCrSkPhI0LArV62CuZb/D+Z/KvejzYrDTwofR+OxgS76f6LXTLNtw0CurL2C6MmgSxj4k1Xgb6Uq9pdXf5wRHILsiGE1znRvautvu4WND0qMKpxhw6oDY4kDDKBuHmo2/MJIcAxSskKTsbxlkI4L6IYkRKYCUfaaJhEDkFGrvLJ+E9Jaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkkEpZ4+Kc3iOtxkjaUM0Dq3gOgJh081dNnPFqjujDY=;
 b=KrzcNqRf1+qr8jAjlcTsnaUxG0a66GerG8fw1JGFhdV+zSBdGOEGCBj4xRUPoRsUDcHjscCTrcPtfa2wG0LLUWDB+Ca5Cn3EjZLXjUfNtXDCGcCXcoCwq6S+7/6/tu/MVTMYv34QZlx4oHrPAqpo0qk2BbYQADHv9w7KABYFakA=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB4043.namprd21.prod.outlook.com (2603:10b6:510:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.3; Wed, 4 Oct
 2023 17:36:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::fb77:c270:55e6:370d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::fb77:c270:55e6:370d%4]) with mapi id 15.20.6886.001; Wed, 4 Oct 2023
 17:36:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>
CC:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
Subject: RE: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Thread-Topic: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Thread-Index: AQHZ9olsSlNFxyIgkE+OuXJhoX5gRLA55Dmw
Date:   Wed, 4 Oct 2023 17:36:32 +0000
Message-ID: <SA1PR21MB1335F5145ACB0ED4F378105ABFCBA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
 <2023100443-wrinkly-romp-79d9@gregkh>
In-Reply-To: <2023100443-wrinkly-romp-79d9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff29f0ac-1e5f-4f83-a79b-6e899e5dc689;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-04T17:31:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB4043:EE_
x-ms-office365-filtering-correlation-id: 03e3b665-37fa-455e-f35e-08dbc5007312
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFEws6rnwUa+iN0THzAk79h177UqQsns/cgox0CL2UhMepN9wmSjvSDA/P53pFajKAkRY9pTfCA+ZGBxuQqdNfcYskKOADTXnhzT3sNfw0V/3hwT1yIvMVoWlao2l8lmN/zCvG2AXdtUp7lIpGE1QNsvkw4n6YIALqKFFnQ49806XMNKd7BpiNcyFtukyTrYf26mCp2O+A8If25cz1BBy8mZ41GrQ+wSOWqm02FYafa2Q3WZeYvC9HdEjLmajrgFTUfmp597u59JNvXrSiH/PL3YJ3uofiVbYGUKnMTyCWXRXRloHBPOQDIIy+sxh/i1YBlovxpJgoZw2Q84zIvaNgBtd/dRr4GIadUUuIrEcksFF31SDx3NcRsz3Bz7gasyqRt3yDXDV9rRdXhk83ZP186k21rsC5twz69/y9/W3TtdzTHqYcOikrJwhzOmkEjCLM8ImPF2NCxsTWBhjiHwxhccVEwnk9RlDqbTd7hAaKm8WoPXIfbyOaSXogFWB0/nlsh0j9GwMiy4QPtgoNP/F7N6nYmJL45qpTfWVHpvfO2XGfrLhMuvR0i5+X2KVU8Qa3glfYoMpXs3d+EgOQSeqfFKoIYOccmhal57No0jdGwvHnkg1nM+fjjWDzye1adMiGb2sEAlZAUqmupRSQNfuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(71200400001)(6506007)(10290500003)(7696005)(53546011)(966005)(26005)(2906002)(83380400001)(66946007)(110136005)(82960400001)(7416002)(41300700001)(8990500004)(66476007)(52536014)(64756008)(66556008)(54906003)(76116006)(8676002)(5660300002)(4326008)(316002)(66446008)(8936002)(33656002)(82950400001)(478600001)(38070700005)(86362001)(122000001)(38100700002)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mmHhR76lHHV5oAUmvWArVDsEt4Xz/tlVsg7i3AHkMisfW1OJDosY1XrIOkaV?=
 =?us-ascii?Q?wml4Mb70Cfj/9NdKzL5XGNW/29qxbaSdz5MQFL/GZgoPXdGGALTT4JfqSy8W?=
 =?us-ascii?Q?wwPg91L9EX0Pxn14bEZLo4bAHg083ZNtm2we+8PhiMgbpVHdSxx3pRAqsuf9?=
 =?us-ascii?Q?s53tqZoYpssWKUduujAj5ALTk2We2qLPddVipOBfU98IdNjxLMtfw5yt6UxX?=
 =?us-ascii?Q?BPnuu03NRssSeor3PLDK/0hd/uUweRwt7XTPXp9Jp9dA4x4xRcuit+cjQMAT?=
 =?us-ascii?Q?51ElgwYIUVlohbACm0ReDi9dhIqtDsotZj8eIWkBB56LUD45CL5LQ7AQ6gG6?=
 =?us-ascii?Q?gdr2jHGqHkRkJyy96eonKgRGxvbQ+Zc06RbWd9v6eFtqRb6Z/YpYG2hGaZgO?=
 =?us-ascii?Q?a06P1xnXBOcxmUHJ2xYyeGOYOgnLc1WKIKW+q8KkIcuVd1pdE6Jly25JW7c3?=
 =?us-ascii?Q?Xbu8dT8nztkJFKRH1yXtECC5H88dcWM0vlStBI+oPXC0yBSj6Ub3P3VzHtIu?=
 =?us-ascii?Q?JS6SWbbYEQ98INhNfd1l97dpKYgOp3yWXivcRo4Fnnoeeg1EyWdJuoxUDGdA?=
 =?us-ascii?Q?bkYdj83bhB7u+2cbO5OW+1Ody9y1/7gcn+c+27V1q5AzyAYlZQf2dBs3S/Iu?=
 =?us-ascii?Q?IbhRBTqdBplgBXhmPSeV0gUU+oWRAs4C9RrjIP7peoo18TExm0tXUgqVR4nC?=
 =?us-ascii?Q?JhUxYDgodiHm20U/4pACmIgLA0IuEjIkSR4YaTKyTNVVgtnL1jJTAUGcC58Q?=
 =?us-ascii?Q?9JJHbWQJDk21Uzdxu1K0ou5s1Lz658P3Mu95lmVgeiTnNAub7sltjqAsnX/G?=
 =?us-ascii?Q?W8UyAu/Sd5jJrppk0HW+nakS4Xm3lnknksLtYf86roK6OL2Gs4hUyizmpJG4?=
 =?us-ascii?Q?2HW3XbcoJprQgbu1b7BGJfOCMu9VDYsHDdOUescIek0hIcelDVARqAjFmqcN?=
 =?us-ascii?Q?z98fzLd/zhjEKqyP+K7KiAEqdpZKI+ww1xVO8eZVqnfTcGLRaPgrRsYX2qS6?=
 =?us-ascii?Q?Wx05GZy0u7ahyi0BPJwA4qqr37hpBnFCnCujSdiLxsKkcHX2xp0brPEufhdS?=
 =?us-ascii?Q?AI9IB4Anp8qXqQh65CxQP/KyAgKp90258toLKx7b00al1WS5ddnMEwDAmv/d?=
 =?us-ascii?Q?oF6sdD9MbCFB6uhwIAgOVXRv2v8UteKPXzu8b7qXf+UVH/Ehb/W1QsfkwPZ+?=
 =?us-ascii?Q?LB3+29BL8TD39x562G5UM5nSPofeNIqjR0ffnPC9DXeoHczHsgLW/G3D66GI?=
 =?us-ascii?Q?u5mLHYGmyB/48R03hscTusD1SaQGH28Lg9anhQxUIlLHY461dNEnuthU6JkW?=
 =?us-ascii?Q?CXwa5T17JmEfxqAAh9ZpOqfY5TMYNBhWbKmfK8XVmVJp1wxnm1Wg9iUR6q37?=
 =?us-ascii?Q?oXhl1yzIEgQQCDFz+Sa42lgSU1GfmopMi/+jbYUrGGHqdu9qwuQeTN3VvGFd?=
 =?us-ascii?Q?RMuMPcdN1+oGMgxI6VI9ZridZtylPvxSmduPLhpwyUsYBYDbcc9vm1fM7x78?=
 =?us-ascii?Q?rlybl1Rvvzq9ATe5eM3kECJEr6HAMGXGP6RkcHST3M2eFNOPuzeKka7sZGM+?=
 =?us-ascii?Q?1ubLuKfzRTuoX7+hFxo2F+H2VDS7bbP9pgmnPCo+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e3b665-37fa-455e-f35e-08dbc5007312
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 17:36:32.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfFXTpDDJiWuyVs/+T9iFDrBnFqn1iDzw39IVYd1ts51/9swN+mjGmzi1iRY4u46RuR1DHXtBnYTYpw0O036Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4043
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 3, 2023 11:10 PM
> [...]
> On Tue, Oct 03, 2023 at 04:37:01PM -0700, Nuno Das Neves wrote:
> > On 9/30/2023 11:19 PM, Greg KH wrote:
> > > On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> > > > On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > > > > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > > > > +/* Define connection identifier type. */
> > > > > > +union hv_connection_id {
> > > > > > +   __u32 asu32;
> > > > > > +   struct {
> > > > > > +           __u32 id:24;
> > > > > > +           __u32 reserved:8;
> > > > > > +   } __packed u;

IMO the "__packed" is unnecessary.

> > > > > bitfields will not work properly in uapi .h files, please never d=
o that.
> > > >
> > > > Can you clarify a bit more why it wouldn't work? Endianess? Alignme=
nt?
> > >
> > > Yes to both.
> > >
> > > Did you all read the documentation for how to write a kernel api?  If
> > > not, please do so.  I think it mentions bitfields, but it not, it rea=
lly
> > > should as of course, this will not work properly with different endia=
n
> > > systems or many compilers.
> >
> > Yes, in
> https://docs.k/
> ernel.org%2Fdriver-
> api%2Fioctl.html&data=3D05%7C01%7Cdecui%40microsoft.com%7Ce404769e0f
> 85493f0aa108dbc4a08a27%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C
> 0%7C638319966071263290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&sdata=3DRiLNA5DRviWBQK6XXhxC4m77raSDBb%2F0BB6BDpFPUJY%3D
> &reserved=3D0 it says that it is
> > "better to avoid" bitfields.
> >
> > Unfortunately bitfields are used in the definition of the hypervisor
> > ABI. We import these definitions directly from the hypervisor code.
>
> So why do you feel you have to use this specific format for your
> user/kernel api?  That is not what is going to the hypervisor.

If it's hard to avoid bitfield here, maybe we can refer to the definition o=
f
struct iphdr in include/uapi/linux/ip.h

Thanks,
Dexuan
