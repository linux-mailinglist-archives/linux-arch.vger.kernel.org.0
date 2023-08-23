Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A19784FA2
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 06:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjHWE21 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 00:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWE20 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 00:28:26 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020022.outbound.protection.outlook.com [52.101.61.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1908CE8;
        Tue, 22 Aug 2023 21:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2udUgsCh7Li3uImQxEDGv2mCyBADxf3Q3iP8gWF4IVO1zx+uuuz435RUsWGOlGT1DZWbHBnmabt9k6hSbQK0Ie+eJQCsMXE/QRPBIEj4oDtT+YakS1tsVDYqqBrbTOTapyK9RJHOHNyyfDi5jdZrjf+J0CFLNW0fM9r6FjDqdW5c9v8UJe0KMpS9j4je2r/ppWtA77zhFqs//SzMWrt7OEfjD6+vHGJI3+qnUrlGgNqsNAtnLXcSmcDw/5EHtz37JbIXF1Plptara2EitP83qD+AV5eK+4iQJIOBf14dijYyuf2DhD2fwRbH96DQEZmd/dBKtaYNavCZfBMKw7CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs92koqvvCSfr0p8P3e3xSohNt9LlW6s2JbxptmYFqA=;
 b=goGioNP74/yjdKY08QoRKpVX5JPq7KJIoF1AQ1qxpcBKjujDbct8snBfFx2rA+hZxW3TYeE0AQB20zkuozVjKTnCsiRmGGfcFhe9rHInEGQqNOuC0IgPug2zk1kpCI1kACLa6GQa0JayGduJ8JXb0ZdV6OuCW3CheyWwL3tqP3cWziqESOoN+PC3cAjD9hIUKioixE02WW67zSJXqgquYi8EhYtc83SNBvBhdOCz+7nI42+dnXZ33/c3FrTBaFMCLJvWMBj6ZJLa1SmlBUFeUkrCSQuYGPUiwlko4i2Vxy68ZzopyWCrPS58oU5VbkS8Nt2A/Bvzf3lrSZZwC4kpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs92koqvvCSfr0p8P3e3xSohNt9LlW6s2JbxptmYFqA=;
 b=ipu0iaGchbcgoAOcufNpkAEnF/xyMqONUVN52sY3f8U5jUtIptKT6eKzsuWePdp2pDqNYjvCZoNYe+P5ndgMklUthF+aIgWA7XBi6hQfYfuZ70GR63YQ69PS5P3GFszUSM7rD02Dz/Pq/yQ05wOyD+2lzXz3hMaxp+fRXmqQhVo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3736.namprd21.prod.outlook.com (2603:10b6:208:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Wed, 23 Aug
 2023 04:28:20 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Wed, 23 Aug 2023
 04:28:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Topic: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Index: AQHZ06TVJoWZTp5HxU++UB0kj/HGQ6/01qqQgAHUHnCAAKG5gA==
Date:   Wed, 23 Aug 2023 04:28:19 +0000
Message-ID: <SA1PR21MB133573B4C5E76CA472161DC9BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-7-decui@microsoft.com>
 <BYAPR21MB1688ED81A8A54A25A7A10C44D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB1335945301F8E8FBC2CA15B5BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335945301F8E8FBC2CA15B5BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cfb085e1-2e77-4201-87c1-f2506136f544;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T14:51:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3736:EE_
x-ms-office365-filtering-correlation-id: 58fbf64d-0278-49d7-e8d6-08dba3916131
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kF1oL/l0weDr50kVvlZJZAry53/LSh3e1G8SwJAnIzTtkPn/SNdsrVp7L1w8DLKnfXamoWwmWiaT37Qlk5jRba3rVgSCz10ihXyE3/TkDTY9sb4E0YppwY3M1JM+Nz8mPZ0bynNwD6S9W+yScgxwnX1a95s41aB890kupjR2j6vNtGOVRsfYm4zv0oVPt5lpJyrzKxc7Am5eTABoFFYMyKUN9eeag3Ma/RAGX3Yx8ppgUpnuL0YKcReSuwA0iox6Vy4kFv5JXQdGeXg3CWDQa64OfrgPsGlUGdgSss9gRXvL5pbxS8sdXLfp5HFGs0Enab9Y1WAUGdchrreC7SWv8nD2wHrn6t2b8E+N+Y+JZvFDvne5dcYU8hK9vk462bbR9oedHzgXkpRzNQw51B4l9D7acF5qzZaG94F/rVZ7567tu8dJFNbho8Bo0TWfRG6uWnn1ZmMejWzR8nmCvlxMhaLBUrsQp3ZNkb6ZvnGb5CYgeoOlzPBP+Wl0ucND1hBNLNI59T+Z9lXegU7HeTQlkCDRzTnstgr9MCjmfSPTwNmEsuxiFDAc0Mr9X+yjuUV673BdW+vy5wPh4Tz4RqnfQesUxwphjEoL5FM9p/Sgpu0Ue36k9/m7/HOdiAL8es0k9PeJqwmRRPDR6DLZTPhgsfF7Xa1ufVtkt43HOPj00sSIUqNzU1HjHjRfPB6fdwlGCjwMEUz5OhtDAU7t7zc94g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(12101799020)(71200400001)(7696005)(4326008)(6506007)(33656002)(82950400001)(55016003)(86362001)(38100700002)(82960400001)(38070700005)(9686003)(122000001)(921005)(2906002)(26005)(10290500003)(53546011)(2940100002)(478600001)(76116006)(5660300002)(66946007)(66446008)(52536014)(8676002)(66476007)(966005)(66556008)(41300700001)(8936002)(7416002)(7406005)(64756008)(110136005)(316002)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fVHqqr3x1NFCDsSGqcpltRA2nPFrm3WTy+I4aGbV2WUcTh2PNxR9Rq6JRkd1?=
 =?us-ascii?Q?z91+HiH2DgJO2RLQCuDDwZcFUe1lR0FwUJWdtTks9/4R5v0KyF1fpq6ar3PY?=
 =?us-ascii?Q?2gejS+b4Lc3Lq4d98lazyJV2x5DKwA8KncV+p0AFhzB0hWqNyfQwK18IQJNn?=
 =?us-ascii?Q?fhFnLlo4pvgt6lLURamzsJ8lZJ9nohdSA1l1RCWEgJ85nPnO0RwSz1YgObHb?=
 =?us-ascii?Q?RZ2vbCyBxBq2BuJ3uQ2ajt2+smJLhpMkJqKgvI/ODq7a3S1NWWt9FVaYszv2?=
 =?us-ascii?Q?BUfOue5TsqYRmapgqaHBw3Tsu+IXkz1W+mR2ZST1RwrN03yLIVe6NK9PEfGy?=
 =?us-ascii?Q?1/9kMw/uEveQdkeO3qLs/PSMJiao3Eo+vOcUusAj+mXk3Q9j+q+3oqfZ1fsD?=
 =?us-ascii?Q?QrEnB4W3T72UzSggLgChynqdKNJEfQCxcnSB/eqbL8bh+vEbeViLyJKiEVVV?=
 =?us-ascii?Q?D85Vvi56NyIIawwnMWYa6j3hfusCC4uvCwHo/sK4uBpD6jUb1K4wzmmRYszW?=
 =?us-ascii?Q?0tlRv/Vgy9C+d6OKA+0OoLiDdDCW4zxzUWwmu59lJl/hLM7IRTF0v4eiyhkf?=
 =?us-ascii?Q?RqhiqCG813IvH2gCcecVeoCaCU4RPyrh2FikABXwJcW3J21eHMMjpKKY2CIM?=
 =?us-ascii?Q?I+KReQnnwec04lGw9Q8/aiTIe6TGeERbv2i1JAghKS8QoP3HJzZN2C4pHn99?=
 =?us-ascii?Q?t+hz96KLg3Sbxt13G7wFiooNZnp61KAqUIbA/n1/tXaQ3cRSRhso1jN4kxws?=
 =?us-ascii?Q?Wa1x9TswDuafjktnOGnbWHA7d+ryv4zLdg3XYgIEox/3h8p7IURfMJjf3gY7?=
 =?us-ascii?Q?Yk2uewxE3aw9mHX9WHiw0m7TbavFWyfmdOtGAvdCecFKJvsNhz68rwxwg8N+?=
 =?us-ascii?Q?wS/1tTMHBaDDB0196hATHv0dfA+aG3D9KwOtY+e0hfZIi2cHoluXF3JmMxs4?=
 =?us-ascii?Q?zx57EpcoxUKoCOCjdrvQCUAYbnfvJ63CyrEhCTPX49MInL7lTtUEpbs6+3S2?=
 =?us-ascii?Q?0kbrK1GQmTz7URbL4veOWhbohHwN9Ip/wLwD8Y7/5/TBUtcDA/kyjpfEhtzM?=
 =?us-ascii?Q?xH0KR7OyKBuYLgD2416vs7O20QlFZia9ZdHdQa/TLS+XhmJUkvpjOaepi8GO?=
 =?us-ascii?Q?wpwpzD/rqNMAnK0h/KW5sJLsvLIVFEa8GcrpH2vJu+D+LndoQ5Dl1XLZ5TZ8?=
 =?us-ascii?Q?YOXoaccgdZ9P+DEijfMv3sLLbJptLxhkkCv/SLF7A8dLQx3EWRFhqRQgZxJX?=
 =?us-ascii?Q?ieSuhgZnHO4xz/K1goVHUXErlPShuQCwFGMREnF8Ggfc7+UrdE55+vcPHG7E?=
 =?us-ascii?Q?7V4UPggNhgO9uy85uPMQr8+5AT0JkQs/Gl+097iHaWLdUhuFaejGXW/gpyP4?=
 =?us-ascii?Q?qVzP4AGoRhjKsNCeYP5/HZPdbSAOJuryFEsJVHXrYOyMZXYhQtqd2sgnSl25?=
 =?us-ascii?Q?Jh8M1it/dVTytP+7tYK8vB1jFV0J53kQnPXeou8pxkt3+AQl8Yz6UIxq/Aqx?=
 =?us-ascii?Q?SzLQ+mMZzEris2/QOG2lcXBshwyj5cax/J3DIsG3oMznnTUMeEunF3gnbEFH?=
 =?us-ascii?Q?38AFtPW5dG3QHlsAqzwfGSDkQi0N/y2STE8SaCfu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fbf64d-0278-49d7-e8d6-08dba3916131
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 04:28:19.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2dt8s5vZ5epcSzuD0/Jiaz6VJhmYQzaWwm8/Q6NAgTDyN0fxPLUrNtgyfH5zi7TQlX9SBZdYkpDSE9xYjpM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui
> Sent: Tuesday, August 22, 2023 9:24 PM
> To: Michael Kelley (LINUX) <mikelley@microsoft.com>; ak@linux.intel.com;
>  [...]
> BTW, please refer to the link for the v3 version of this patch (WIP):

I forgot to share the link in my last email... Here it is:
https://github.com/dcui/tdx/commit/3e2a28d5cf1031679bf2e2ac37eb1fd02afc8d44

> [...]
> > > --- a/drivers/hv/connection.c
> > > +++ b/drivers/hv/connection.c
> > > @@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel
> > *channel)
> > >
> > >  	++channel->sig_events;
> > >
> > > -	if (hv_isolation_type_snp())
> > > +	if (hv_isolation_type_snp() && hyperv_paravisor_present)
> >
> > This code change seems to be more properly part of Patch 9 in the
> > series when hv_isolation_type_en_snp() goes away.
>=20
> The change here is part of the efforts to correctly support hypercalls fo=
r
> a TDX VM with the paravisor. Patch 9 is just a clean-up patch, which is
> not really required for a TDX VM (with or with the paravisor) to run on
> Hyper-V, so IMO it's better to keep the change here in this patch.
>=20
> BTW, please refer to the link for the v3 version of this patch (WIP):

https://github.com/dcui/tdx/commit/3e2a28d5cf1031679bf2e2ac37eb1fd02afc8d44
(the same link as the above one)=20
