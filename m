Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF098636957
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiKWSzd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiKWSz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 13:55:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022025.outbound.protection.outlook.com [52.101.53.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86C88F80;
        Wed, 23 Nov 2022 10:55:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeDczRl4D590lu6woPGXxPwOosQb538syOUh/HHfeMprRZe4ivEHPaK4AEfWDDxvm05MFGecqF2c6PcUnE8Yx23qVHrGFXxIUGQoulaO129cp7c7P0/KbUfmd+yDGJvn+taDU5xj5WGY4qDvrchS6s38OHt+H8omNcIQpYZArNiko4M9xM/gJG7sAETEB+TUZUcK900H+8MloDhzc1undUzTyVUs+tGFhgFx3/38AKR3BRIOAO2axS1ikOA2jB5OausBXaboL679hKEoD+6Aes0E2uVMbReTJ2uXbZnFMKWtNKW/1UM25RaHEmyLtZuf1J5qaroLJwshC9Wlvg3CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QLHRfqKD0vVqeM6S2f5ehUu59W1SXGPOPjQ81oGWxU=;
 b=ErGA4BeDf2+FD4qKm+w8DuVfa/bvXz4IbymbSApRb2nJpIiIQNqopAG6Kr1XiUVZoc29erzSV/Ywhx9e5dZe2NsBB7miwfA/NAt35e2WA4pVvSPfXbFYIkoZqdT+BSwMO2piqY6U0/IM5/OEgd1HLkwcyWPJR/SXrAJn6MR9zc7BdAss1Yq7+n31dYvjEVaRwK3kDF+FFxuEj7Sh9pUf0oBmf+8IFnjou/n7DNmkMhngfyu7b+hb0GxyNEDZdZQzkTEtmiwFXPgN4vyNCznbWJ1FQZL5VaLR8ETg+2n/Aw9697L2e531qtgxcA8SCEpYb+sHx0CD2iOnzADcvby3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QLHRfqKD0vVqeM6S2f5ehUu59W1SXGPOPjQ81oGWxU=;
 b=Hpsa+2hEv20ZB7/hsgYdj7gir5KM8auZr2vL1dSrlgYcn3jtj/6H2Bd/+TuxiBqKYXADiFkfcprCw8NHiXXCMclDEBYXwVPrqeXn0otdbV7XoPwPDe1rRKtD4FPMRDtSq2vTUvOcSUoxC8FkHUF3xUUuoQH0mWaaAHZ51MQ3zP4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1991.namprd21.prod.outlook.com (2603:10b6:510:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.4; Wed, 23 Nov
 2022 18:55:19 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 18:55:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Dave Hansen <dave.hansen@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Thread-Topic: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on
 Hyper-V
Thread-Index: AQHY/elAG0JYcbbfGkmNBxJJMMwuJ65LuIUwgADeyYCAAEbnMA==
Date:   Wed, 23 Nov 2022 18:55:18 +0000
Message-ID: <SA1PR21MB1335EEEC1DE4CB42F6477A5EBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144043.ne34k5xw7dahzscq@box.shutemov.name>
In-Reply-To: <20221123144043.ne34k5xw7dahzscq@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9781b948-f20b-4377-b29d-f930da102b44;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T18:54:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1991:EE_
x-ms-office365-filtering-correlation-id: a2c5291e-cae7-45d6-e7b7-08dacd8443f7
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqNHMpTYiV6ApN5jQpiXtIfbBx/NBPRiL1RJTvJ/Grxin1WCmLqxFz+O5rHs9GOBQsl3/DAeKoAy7bbSdl+WOKWoWGalNtc8n2a+THXMO9Xxq++QCamGvXH3LpZJLwZQsr60i5lIyBXwEJSjisrmz/0littoeInWswtqAkVJuS+WKBMkYrJrwlVYqCyLMaENYJo/gORijS7EFlIYthbJk9Z+gNTCwMP0oB5GYYZ/X6uPbPtPgkJ/QzgNLztsT0Trn0FhTxWblGFKwwxJr0n6Fxp8VwygSlmgHgLneKWbPmvR+DkryXRvq04XyzoHGktxTOnoywhUzibRd3sdRKY6AycgBgwUbz0KOxyS7zEIa+wV47ou6ybrXoauM0Y/jhqdx4L+VW0FJzSIAx096QvdbSQScW/A1uACno6q7AzP7Fa+n7yOtQJ9kCLjKrvKeFSH4lz/bwMkl/UwAY26xhDLnN1uVPdk9nht8X8CUbXVaRRGbGY2HGySxe3O94lznoDn7vFtRlVV+jKQbh5kTGhJD22oE8L8QOtlCfdkc7L7JWKO8UyNjf8BgZTlSBwblVnkF67SwRtYrG46vobpy8Uyj/CZxe9/mgDffkUtxkczVF2LIiyzokDt0HXVj3iroNbd8XmG8TRPy8KEv+t/GW1WTgYF7CNeCHim/s3pJ1ose06N73MMVmyhTWerSCSoUsNiFJ97m/958tPIvi9lwE75pf4tmATH/fhRnEyqzpBytw7xsxrFR4WHR6XAZGiry4dT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(41300700001)(5660300002)(7416002)(2906002)(38070700005)(26005)(8936002)(9686003)(52536014)(38100700002)(10290500003)(6506007)(82960400001)(82950400001)(7696005)(122000001)(55016003)(558084003)(316002)(33656002)(71200400001)(6916009)(54906003)(66446008)(4326008)(8676002)(66476007)(8990500004)(66556008)(64756008)(86362001)(186003)(66946007)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3m5B19/hg25Pyb34kD12kc45fJunqYI24Wa94749uXjCuh0WGwVsFr13HTCi?=
 =?us-ascii?Q?DsKEaMz6zIgRayjXQHtJo6uMjmA2zPW/Z7DakVuv5imt2vLUsyvnyPs5VVS4?=
 =?us-ascii?Q?gdFcMdFN79jopNN+MklFHNu8Z9nUUBPvX8NZWRV6FyOh4JIXlK0Ehx4RRi4x?=
 =?us-ascii?Q?a2eEgGtL0FALX1gZCDUI8/m/cUH3FPqYB6UL3yqe1+5UyMS2SAoqRX6Kn4l0?=
 =?us-ascii?Q?RWyHIUDgryxEpoVM6HKvCOkFFcoyVq+IQP4xpMJIKninCiGBQCuUdDXYlwvQ?=
 =?us-ascii?Q?cxgm75/3A51vr0YIn6acH+BInGxI30tLOe2bwgOgosenVjSsWCci605FDOws?=
 =?us-ascii?Q?HfTOBNtOTE2WZJUgIPiQGncaqXsh5boQthF4zQ4ukJzNkHQm2ceFatxExTLF?=
 =?us-ascii?Q?wprkqY+CIR5zsxERNYXUlyuIY3KHCnh4ygwIMUxc6xZWukiSK9l39Yf5bQ7Q?=
 =?us-ascii?Q?CTDMIcdydqQVxrLYykasdl0yd/J9P8QqMyAGPFhnB1D8/rcIoFIEXouGkB5C?=
 =?us-ascii?Q?cgcjZ6R7V9LqZw/YIvhMEIh3dQ6Uz9fh02P5d4bwmwC2o0dLbfQHE5EfRoTz?=
 =?us-ascii?Q?bTHVbw+HfXzPdEn3KsNygnz9AG0xh6CsrWWG1OTiy4mXZIeCui+E3G2b6AV4?=
 =?us-ascii?Q?WQVOVv/t+VOZflYV9bZsC52nEJExv5a1UhlLaM3vIJEoUGj0fZh/91g4kRpJ?=
 =?us-ascii?Q?D6J7l78AVtZe7pTh8E563uWXrwJ2CJSCrcIduRrVmt8p+LArAxbT1ll8L046?=
 =?us-ascii?Q?JTmqnlQVj9mzEERH0+hoQ4eCx7iWgSieqUgdkokW7kwqOSBYzhfITIJILpmA?=
 =?us-ascii?Q?in0dPV4Qn4Kd832kbN6FEKskgqV0zStoqlNGeOLuiOc6czDqamlWatNn+mYp?=
 =?us-ascii?Q?e+DklA64+B3Q+YKxO2DiRxbh4NUx34XqZEhsHtXWJ8eM3gTJoRDrWo91VkQR?=
 =?us-ascii?Q?F2iwLicwF2oKQS2JXusDd0/hEInPTECWQObsr2HiUU84tX3Nnh5lEetEbZFq?=
 =?us-ascii?Q?eDYV8gNFje0YL7C3iGfGgO6qtEO72vHXmq845zgh2fqEIH0CHoS/MKmnJD1C?=
 =?us-ascii?Q?DR2hnAIiCk83MzMv+pahaazNx69g6ds1yVI4D+AlLNZzzeE1RLoVBtx+GHdm?=
 =?us-ascii?Q?CK3bh6osSVl+dIOxYrXUcnN/etaJy85kzd9FmfasFX4zA90mMHjIBi238/q8?=
 =?us-ascii?Q?ccZXXcnvuS5kX5f5k5h/2WNrxTH+AUGXzxDG/05e8Vf9tCPnHDq+RPBG4Mt+?=
 =?us-ascii?Q?V/xeKDFKXqrXOi8iehmdln05mGM3Li6rWKeb3Ikdb7kOc4l++MPMEDeIW+We?=
 =?us-ascii?Q?T93CS1osDjAO7K7p+pz+xJsnkKl7IN6o1k1OKNCQp3qv7X1Qo5KxSY35SR/+?=
 =?us-ascii?Q?o+6zGK/zH+cALei71eZeWeefwQrxrWT+43Qqjlo6BYwUZnx6DaHLxThCXV+l?=
 =?us-ascii?Q?XK37L2ZIzzIhanVMK3bKLoyunIfaFgM+8vZIS/tA1sQyqTk1s4HLGvDrDfS+?=
 =?us-ascii?Q?RSuVp3/kYZYRlpKDYRR6yESq68d48BRStTUTA+frbJlfZC/2RRHV0RX2uj3F?=
 =?us-ascii?Q?62Zbt924p7eNQx76xO8MFVL2BkgNuil6T5oCROpj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c5291e-cae7-45d6-e7b7-08dacd8443f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:55:18.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD1SIYedjDZAjFRa5wQKwaUiFtLuVjj5YAcKQQXn24SdWJokkE9W1weq048614NO1LlAdaDuMCJv6hyRBBwP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1991
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Wednesday, November 23, 2022 6:41 AM
> [...]
> I have plan to expand __tdx_hypercall() to cover more registers.
> See the patch below.

Great! Thank you!

> Is it enough for you?
Yes.
