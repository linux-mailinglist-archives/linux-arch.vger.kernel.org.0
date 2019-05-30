Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65772EA54
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfE3BqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 21:46:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21818 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 21:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559180784; x=1590716784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2skhv6t5NmmyBNwMEVbEZL06uEBMBA1e770aw93H7UI=;
  b=KETqi6vN4QgjQAvAhl358zfHF0DMEYT9jjV0FZxzvobmr2+1Ks86yLPS
   N/Hcm/vA6m6pKNBDXHncedMq7+zUbGIxOG5BhokVtEJQahk5kWjES4Ybv
   bFEN2h4tz6w0CgUImr/PwEBfTGPzlhDFSad1pjNOdCYQD3vP05yn5Yn4m
   CVyY6JzsGr/T1rC7WVP+LHQ7FIv9bQclyDit5fdBlbIt4zD0tLdrEc1NH
   +Hrx3sqqZTSW/k6fbNCcM5oZlGJXrNWzQ/bwTL66Ulj+dMvj+mqJdx11h
   HhqcG9C+3UR0POPMGMxp4hxA3z0XuK4UU5wmZZmlQ4XyeHihGkZV5FBzA
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,529,1549900800"; 
   d="scan'208";a="110619213"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 09:46:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7MIDSLLRHZN8g/hqgsc3mHYe47dtQgBx6ElUsahmn8=;
 b=tKh1K7ia5shq7jdb3vDCrHhFcRw89MB73YdWIMs92w4zFJRikRSgkJOApz2zm5/AR4P9YCWcGftKj48o8jbpmXj+MzGDXGcfTMK20SIgYAASHBDPaaz+l1aornYs6hvB/cwhhz8Bj4uXty9MYCK7BpDlmSimqEfwBcEUuk7QvCM=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4136.namprd04.prod.outlook.com (20.176.250.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 30 May 2019 01:46:18 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::e15b:4e75:ab6c:8e1a]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::e15b:4e75:ab6c:8e1a%6]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 01:46:18 +0000
From:   Maciej Rozycki <macro@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Thread-Topic: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Thread-Index: AQHVFocqnLOMqr+xHUalN8wTyDzDBqaC5dyA
Date:   Thu, 30 May 2019 01:46:18 +0000
Message-ID: <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
References: <20190412143538.11780-1-hch@lst.de>
In-Reply-To: <20190412143538.11780-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=macro@wdc.com; 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4808cbc-7abb-42ad-1456-08d6e4a09bf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4136;
x-ms-traffictypediagnostic: BYAPR04MB4136:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB41360FB6925C1EBD8D670235B7180@BYAPR04MB4136.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:60;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(66946007)(71190400001)(76116006)(6436002)(73956011)(66446008)(26005)(64756008)(7736002)(91956017)(9686003)(6512007)(3846002)(6116002)(305945005)(66556008)(53936002)(71200400001)(256004)(14444005)(6486002)(11346002)(446003)(5660300002)(186003)(316002)(476003)(486006)(66066001)(102836004)(6506007)(478600001)(4326008)(14454004)(2906002)(54906003)(76176011)(74826001)(99286004)(68736007)(86362001)(6916009)(229853002)(8936002)(8676002)(81166006)(81156014)(25786009)(66476007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4136;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7WI4NCkTRLDjV1io87Vxpu8SbNAkGuyAYX2zEruiT4OBwtR3YKHUq6/k7LCZsPwA9vqOjjpPr7T3d/4Wd86hNTMNyILb4WHZh6PKPikqo0qSs2cn6xxxgtqXyYXFp9xkNu+6lFG41VGCUv52BgSOi8gRaGUA+8sFMhse9W4lK+w+G7yx0c4lHq9RrDrO0Emed1Zmp0IemUE3AvlBXVAFxSP0xjnx/+ztZfzQtrgqOv37peNJ4NREwyYd6z40bA1GEBr5fn4yfVsuIKIybA9S4F2G/HB1y6dXcCThO1aKX0xhQO42iAhEz4cuyl7tI237elmMi4lQWN7OOEzDanGdt6uWsSNgqltcUHlV+TtCd+7geKcPomNRNUSffjTyycQjuR68SByp+shzwX0IRV8cJoWUhZEBk+G3da/HYmsp6Kg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A88CFBB7AEBF874388829DAF30C86426@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4808cbc-7abb-42ad-1456-08d6e4a09bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 01:46:18.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: macro@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4136
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 12 Apr 2019, Christoph Hellwig wrote:

> diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/lin=
ux/byteorder/big_endian.h
> index 2199adc6a6c2..34a5864526d2 100644
> --- a/include/uapi/linux/byteorder/big_endian.h
> +++ b/include/uapi/linux/byteorder/big_endian.h
> @@ -2,6 +2,10 @@
>  #ifndef _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
>  #define _UAPI_LINUX_BYTEORDER_BIG_ENDIAN_H
> =20
> +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=3D __ORDER_BIG_ENDIAN__
> +#error "Unsupported endianess, check your toolchain"

 Typo here: s/endianess/endianness/.

> diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/=
linux/byteorder/little_endian.h
> index 601c904fd5cd..0cdf3583e19f 100644
> --- a/include/uapi/linux/byteorder/little_endian.h
> +++ b/include/uapi/linux/byteorder/little_endian.h
> @@ -2,6 +2,10 @@
>  #ifndef _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
>  #define _UAPI_LINUX_BYTEORDER_LITTLE_ENDIAN_H
> =20
> +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ !=3D  __ORDER_LITTLE_ENDIA=
N__
> +#error "Unsupported endianess, check your toolchain"

 Likewise.

  Maciej=
