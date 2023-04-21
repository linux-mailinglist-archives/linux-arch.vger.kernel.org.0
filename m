Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C76EA235
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjDUDOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjDUDOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 23:14:35 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86326EAB;
        Thu, 20 Apr 2023 20:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP3/t/iKfllxFeACZv/ikf8VuwEOO/fxRGOtHDSx+A/PMNUw/fzn5SA/PeGoeVhcnwyuotPYETROn/f9JL2s+9YnmVFsAgs6OfLmWWnn26jkF6bM17E2wJ0tqTBYXcGc7ZTIXNHn+2yZjOlUfQdbAyiE/oC5Ny/iEesX9/37fN/KgHEgWgDBT/za0FEp3Hj+AbxeMPK5KlJOstHDTb+FIgVEE79qY1MQe0VHilwA5MCteTQ4UhBmPtRi1alF9riCZS/m30mXMoiGy0q1X7DETAFi9Lq2IRPiRsFApAt4CjuWE7z9wcL2fRM9BeQd9xuCpV4NMCxE1c1taT2nwZOjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2SBPneWues9d05WwluuhzDUzQDan108lkZfr+c18x4=;
 b=BBXvnrDh3UGS5s0B/kUKhyPGECRknX8KQX+AgqxfJoR9JmepHEGZhF3IN4LAHOxHVuIFQKt5UAwL9qlZLdlpLMzBL1E8WYTNvEpb1FdnrQ/Nj5tDs0RLEtBJYxkmjzwe9G4hL0xEFRnoO/Qb32AzR5tah5eOnzFx7Dk6hDpkR9J1gCE0tHh3GzTxoU8an7Ct5rEbFmE4XIVcxvULtj89DpoE/4KN47MRYwyM8MfW0ysd7ZvtX0IUemDquALyZNM8snkguEt1z+Q/zaA5pG+sUZWki6YfAm5xM6atl5sJXr/pHmkmSl57rVC+ld3gLDx9Sit83DpazVv9JRjSlNB6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2SBPneWues9d05WwluuhzDUzQDan108lkZfr+c18x4=;
 b=QuGjscALLyodptKXlMGv0E9cZTPXvBGimE2ZRMEZdcnqlNm2qtDsNKENqp+IulQR2W3RwrtMSURpLJI8nDCoeyikBzW5lFzAZqZcpvUVjM0vKkjSU8JVfJ6WMbDvYTWsK/+Psda4OpvXRiu0dJmNYXnfvyy6036uLKC8+s2uzcE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3220.namprd21.prod.outlook.com (2603:10b6:8:78::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.9; Fri, 21 Apr 2023 03:14:22 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 03:14:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v4 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZalue3UMXRGWETEqXBMcyUuN3aa8mTWdQgAGCRICADVoYsA==
Date:   Fri, 21 Apr 2023 03:14:22 +0000
Message-ID: <SA1PR21MB1335E13C6E6507A3CED4C1DFBF609@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-3-decui@microsoft.com>
 <BYAPR21MB16885F59B6F5594F31AE957AD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230412151937.pxfyralfichwzyv6@box>
In-Reply-To: <20230412151937.pxfyralfichwzyv6@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=95e7810c-d5c3-48a8-88a1-8f3e3575fab1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-21T03:13:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3220:EE_
x-ms-office365-filtering-correlation-id: 0a2dc758-ed56-427e-153d-08db42168134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0wvo+SuifFOvIe+jkNf3IntycLwKZ+DkB7yoo4u+b7Axp287NhdaNOT65FvJ+Vf08u8rWTIC/gUuE6v2HS+tIoSFJwINneiAz/OVFrWvvJSgcxnCpvAqpEG7o35Fvz0AbfOfD7RXSEODOD8bqJ+rjoFGXtFIhBFj6xRuZH43jJafDHu3r3CwgEtiTna2oTZBg5lB2GdEBtSIy+j+R3WsaZbpOR3DUtFy7cVnh1QFPw48VXFPA5J5IXk+0jmFFjIS4x6OSMPhS3AwmwtZuLklSOTIAcn8I8OiDzqUENQAyOrNl7GxnyvIBgA/4Ai0q+JPHb4/ISTBQBcoSQ4wapehPaE11wwzCx0hWHJ06gMUegcT294eaMcG0+SVwuHa+SeF3BiAO8HqTXO+6iCHOk7GI7Nu/ahLsBvN+7fj7VGQqMn5Pu71vAYMxSMjVPjvM2bYaS5OcIS3jgDjiazELPGqX8bA35WZTYRsQPhtGiBx6yV3Htz1ALyTGllnhInnk3KeMOJb8upSDKGu2En90mscj8R2uvuRPCtFmIWN+WpS3dxLspGMJcR4xij5hwYOrWbB34O7KAIyymLhsncNYlnXlAn0Dmq/CE8mMwKt8NReoqiQBf9KVGDDliH9Nq3HBy6Pu5bCKP4ob+eQYXFGjhBh+XbGfNCKpm52sYqxgbWZfA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(33656002)(186003)(38100700002)(107886003)(558084003)(82950400001)(71200400001)(82960400001)(110136005)(478600001)(86362001)(122000001)(54906003)(7696005)(9686003)(6506007)(26005)(4326008)(6636002)(316002)(786003)(66476007)(66946007)(76116006)(64756008)(66556008)(66446008)(10290500003)(41300700001)(8936002)(8676002)(8990500004)(38070700005)(5660300002)(52536014)(7416002)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/Z/xJHhQ/azkXmTdomFRO5UYsU4XzS8fe6F9iTbQxsokSbydQ9J+xW603uy?=
 =?us-ascii?Q?sFKrGX5u3Dyyp1lXwUjG9ieP3HTgOChb9A2A31FYbjh0f+pbgb/i6MxjO5jq?=
 =?us-ascii?Q?od54c9hk1prrNy2arHs1PZNsjJnwgLJsl9REwVF6pkBMewQ0ABugMAFe4ByX?=
 =?us-ascii?Q?OmeWtXtyqRpYEeCz6PSmSaQpnvd0K2qqdg+J0wUOzscl6cpiKLv5cLyMrde4?=
 =?us-ascii?Q?AqOfFM/BdXpdM92QjT6LTPMd3yEnFkRMTr+sI7Of99Xy4+xBpctUsvSVi2M/?=
 =?us-ascii?Q?T+OKM1RpLpPcLkpWv6osXxhUIESjYtpSk7YWklRLpOk0weaWs1bYTAcxloUD?=
 =?us-ascii?Q?Fpl3DVTRSaTZkeoK+Xuq6dca17caRQmEgCI/x+rX5Spm76p7Fg1NX/36WTAg?=
 =?us-ascii?Q?8ftuZyM1AecdAq6ryctIr9AdHwTTxuzaCjS5F2KCyzk4G3/qewUoN010ge0w?=
 =?us-ascii?Q?dKXOsMzP1Lk6YMvj48pzcaWl1oLG4yqt+4ekzpJpib+nr7kha+CvlTlLt/wp?=
 =?us-ascii?Q?1PbYo91n6h1i4QPggb7+VzOCltVnBfccTsNbgt+EcX1FV2rolmh66l/uhxPQ?=
 =?us-ascii?Q?y68DU2iwXkuIOM0T5doxl5tPimEtUIot8uGS+kVjdwH/NSjFBO8Vs1GRLom1?=
 =?us-ascii?Q?KSaXqtnQR3kHRnM9dP1EYVitZlAJN7Spzok0H2kTC5Bzu27I9FQEaJMVu2rl?=
 =?us-ascii?Q?A+E9leMKLrGx4E5rM3Pxt6/rcnWClKLK68FETxvHE2KnAcGvvfdur2DWXDGB?=
 =?us-ascii?Q?kklJL4+/5R1oPnLqSF+OjAfcBQOZC1oebv/KNDC5HvKxoeibIPZoJXa9lRu0?=
 =?us-ascii?Q?M5BqzyzS6pr50nse56dU3Yz65VUvOySGYBkodek9JrMUfZsy6W7kNNZSU880?=
 =?us-ascii?Q?2AAY8XcYmrT2QF0g9hMyEhLiB18LGg81K5zmlUgNZetQzPC7+P1aLsbdUZGU?=
 =?us-ascii?Q?qZWYAKWeepiYXbexJSy4gKqvtMtltIOC/Py/lvpebN4ZZGGcGPt2gjrrpj4h?=
 =?us-ascii?Q?XWLBSu9lBvmemA0BPiW0STVQXDnZcvF6cQ1P54P2rHmXh/a62nGrCdQJBebQ?=
 =?us-ascii?Q?/XvUlN04VvpFoLpQfiSnxTLuBP12YR/04IkWHmGOj7suNuQwi9+JjAKEoZWD?=
 =?us-ascii?Q?pNiQBB4mq0Ddz8wMuNLZSMn+w5v+1+XSon+7V41NSKRn7ux3K6F/1egowq4K?=
 =?us-ascii?Q?SPJ/4g0ue1sxv9pd17/mNHI7QEkTR356AxRooLX/DIs3kQBb6mHrBMGvGeFu?=
 =?us-ascii?Q?mLVAWtK9k/2O0qXmc0A0p0odeZXf9jawSvE/HgtsYaECxl5RmA3YbDTZxxrJ?=
 =?us-ascii?Q?G7/trktTCel0lhvYCSw/WyQgt3WV79EEIaCKMuMtnPyY6k0IxCzZl5L4WeST?=
 =?us-ascii?Q?+49cZFkWnLMg9iI4Lvd0tjU78naYoIat0Ag1/0YUEki6A6NpVsBd0E8DLtBy?=
 =?us-ascii?Q?+rdqtq1TqN4h3M/Znw5xftUG6T/PgdmhbS2qWDQs7fqPo76OggErltoEDwkV?=
 =?us-ascii?Q?vSF07cbkLa2IBcru5PYgqWqFPerBZaPsxNZYQh2jk2d5vt/6ew3JUmCt0ziy?=
 =?us-ascii?Q?Asd8msRy6Xycbkk0Mg/mkDiSytA8nTmZdoGWcWt8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2dc758-ed56-427e-153d-08db42168134
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 03:14:22.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bWSxIqg4Zk0tBcTQrImc3bYGiELLbi6I5CbEq76/VNRPRTpn6XUshlxwgTq2lJvs2x/L07NZz/1SqUls0qy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com>
> Sent: Wednesday, April 12, 2023 8:20 AM
> ...
> > > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>=20
> Co-developed-by requires[1] Signed-off-by. You can use mine, if you want.

Thanks, Kirill. I'll add your Signed-off-by in v5.
