Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B412139D39B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 05:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGDqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 23:46:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5981 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhFGDqr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 23:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623037497; x=1654573497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8sEmPhVEACBjThrz6egMfCViLKAL9SUA/FVi9bqrFfw=;
  b=IBT52hwN3byfSfJoaFtztlhpiO1zg7SoMNiUaiNN0Ch78UOG+sw5YL5M
   jRL7Brxof2RKu0fLiSzdFth0lZKTikGEvDqVgjrNrmPkjbZ7s3TD7cSoT
   7jTFBTA8P7yhdijx9Ihaz22Kk5bw1tyRA7u6k93RAdO6F2zW2rgro1w13
   I1LOOeY2c2jnnmVg62kvMrKYZddbFXGaznjzbuD+BU1YfmbUDecD+MQjD
   nuIXELGEADERP1CWQs3NLXgUF86D7lKl5btC2FLEY9nQBy7APZlYckGIo
   Uv44sd9yEz8/y0M3i4UtSANiCyquWrCldEnXHpMytBUZbXVYY21I153zi
   Q==;
IronPort-SDR: dPMj8d5BIQL3/kVdiD8pUjdlYSPIFK1X/gO4H336gyUFNNxeOssuAjsaprwymTpwpdwUtOOCG/
 0nn4+wnlaZK1MlEuZi5n5vfwVPg8Bw/6bvIcvRD0i99iwTjHFJiz0o+Rf2Jebv3ek37xbwIYKK
 mdANAC15iUCLgFDg9QRXtGB/DLfu8idmdB+m2QBu+HwRJu5NlYvFZkqbQrVW2FYKJ0m32f4+0T
 nOPhV5c+dmSISNXyeEprDpPBoB6OCD8549e630A8uOoRs8cCL61RY6A8oPmukb15OzkfiPWOba
 lsU=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; 
   d="scan'208";a="282397612"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 11:44:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+ehiRcOu3qrQPeah8S1gcUqqbFde6A8eMtmBoDODf73N04X0LMkreCwfhySI6wl35/msXElokO5IRfBVgAvXhmGPE04lAftxfY2SzGzucm3ZALGU4452+s0WXU6nN4a4YTTEX49o44zb1JpU7JYQM0rrNdWUTuBF3jFu/FhF2DIrwTya6gYHmyE/ZINuNYHGf7PiuA8bDskLsCJXjqRDvYcsVnYL9xjYdicC3L+O+fEQTlojbTPJ3+mqvdDJpWbP6VYJjqA7XEPEyCtkPO1+T30YF3swT5wN3Ln40uc64nBgkk4kPsODsUziHEhVFba9Ma24svJgLisWsip3k7QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djZgNoDc/WN+ZtnG5Qe9JWYfahxxEDOhYeEYojjX+hM=;
 b=hqgDJjo6w7SoFHcMWb/jUGxLIpcCtD1+5VPsbEhTwy7y83biJxn3IQ3myxzoMpTpWB/iqnVoJ90ZEbgVdHbn1CTAZA3B4o5ApU1sszME1L8nOvixq4fg0zy3S0a/UX3995CT1gmvAc8BVtE7JOzWrdKd0uPXze3w76NVzjB9uIFKCRX/A2+escpvmTaScK08qyIJHMIh10KO2cmW6UPsuhcs32tzTgD4PxLyK91uJIjw8SK/DhgCbwz0pUNz8xbw7rLpWDxs63sAvmGPzvN9KePuf+r02Gfa5//aTHjn73NpayES92KBCuqdGBEfEoH/UiLcUx/ODx6CEnYnMzeB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djZgNoDc/WN+ZtnG5Qe9JWYfahxxEDOhYeEYojjX+hM=;
 b=I7taxxDbRbthimab5J2dPxiORjcDs1ema8dSt48kqIu+baRtmcpAUo99LGIAfTbUNEBUvgz4r2q/9ovH688PDoAvgRKvGSUg79nRkFO378xzysKWUh2dJBxivN9IzUMm6xNwj0GJQ24cw+blXt99KG55QECHFKk4D8pr5pCUruA=
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 03:44:54 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%8]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 03:44:54 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     "guoren@kernel.org" <guoren@kernel.org>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "liush@allwinnertech.com" <liush@allwinnertech.com>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "wefu@redhat.com" <wefu@redhat.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: RE: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for
 Allwinner D1
Thread-Topic: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for
 Allwinner D1
Thread-Index: AQHXWrMMoTtxUkAv106ad5HVMnzpsqsH6J4Q
Date:   Mon, 7 Jun 2021 03:44:54 +0000
Message-ID: <CO6PR04MB7812C5A068EEDB4D5A2348458D389@CO6PR04MB7812.namprd04.prod.outlook.com>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.167.153.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a838c027-db26-4905-8fcf-08d929669d1a
x-ms-traffictypediagnostic: CO6PR04MB7843:
x-microsoft-antispam-prvs: <CO6PR04MB7843A12006A22805721AD3048D389@CO6PR04MB7843.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5O6IduNeVPDHhq7k7P3EdApPWIYIeubu4HMQGqSNspTWw4eMQ3jsdnL36SdvE2Lqu4PP9kWAATp5iA1g3j0jsmZdFjuQ8XZVRePrhcF4MPlAAmmMojXby4fkZpIw3LvfCqR24NKyNiiqSD8zEJIVqlIW1Dm//ylx2Vpp7wnablYOEiA5p/EkYqfzLVt9bcdHouKzjMKl0lHcqBJ3fCutahc3ypBb1dmYP3xFl99y7LXY2hmVRlrkdo8KlVuWDuXyWKo6cEdc5oEE3BNgWaZqD//iEW2XBKo/wdG7DpRxJ/lGd4x3qnkRy16I2N4UUbh/fUgRcrVypbiy31PmIzsWFEHqtT/GZEykVhQiIpUD21N9COP/lwCj0Ed8Wr3eDRgoT3e+Oy4gKau89tBBNk4L0YFo5feYthlrnNQXRW97Gypslm5e6O/7UCvqDoxSCcnM9z7NxaSxPtSvgfspVILP8FN5Aq1UGWQLGbnUFCP76BiKtJyJkiXGNWSFnO6uq2Jeq9jcen7e1KABTaPMKxeIRA3KUJiUPB4qn4mWYgBKMcOBGdac4pcp0ZcaKMVsYqRMPgn6EIN9nowfczpJhoZplf2fDDCTB0qbPTcmEg3n4hOCP5I1u8VsudSYTDMQv6hrdCjgxoFxnVjzPVnPE4hTpMc12T62x1vm1G+wqqdnIzcSMCdyfpZW7TK4qqmPywfQwzgHNd55Kgfu+er1P4D/nTMf2TQpSCAz7eL8Ws98CUq4FqUbARydtlWQ9IP6kT4WI/Noht+y2GcpB8itcL/AFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(186003)(26005)(6506007)(478600001)(53546011)(76116006)(7416002)(966005)(2906002)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(83380400001)(9686003)(54906003)(4326008)(122000001)(33656002)(52536014)(71200400001)(7696005)(8676002)(38100700002)(8936002)(55016002)(316002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lP0D+5LVu+h19wz8tEd8VkMLMo6JzuhcAizSTRkUZLs2CovQ6a6P3UEgL4hX?=
 =?us-ascii?Q?1i32Eys414mww9aICai+5socuX/d76K/B29wQbiJPO5QQ2FlEnHh5aKSoHvS?=
 =?us-ascii?Q?Mr8+Mfe2CZmgcvdlaqLeP2VE7LsO5clK9SiSvxEpbV9Tyt826cCRxCNFJJpL?=
 =?us-ascii?Q?2PJNT1Qekk+6B1Gd5ixppbwk4JHvWfInXHrjgR8VOcp2omfAi4vZOIKz6Ud2?=
 =?us-ascii?Q?agEJqvNmXQLGIf4NzEvIo0OStGW/iCtc89vHqfZK5JdNeQAnQTsu6xGpI9t2?=
 =?us-ascii?Q?rHxKRGdEVp1gaQkLV77+aj0ZNo1WZltH34XyxYl2EB0X1L9e2TTHgYCaia9e?=
 =?us-ascii?Q?PD2rzhMs4VXJ44n36CkKOmJ6MjKfzFsD0Kix/KtHJ52GWbNHbSpTiqfXdxRY?=
 =?us-ascii?Q?cbi5NugZZWTHPGhfjatgD0iLTK3suJRfQojI2Zi1kr7kcJ+hMm2/fVnBbULc?=
 =?us-ascii?Q?aDUlQcmVbQA4uWDco0tPwhslPsLu+v3u3DFz5JJMd+8C2dN/a3QlO3hyT5Gu?=
 =?us-ascii?Q?nDXzBMCnfEjaHBjB+gQXQRTp7yTFEQWTehLj2Rg62BY7W8XUKZvR49UQP8rn?=
 =?us-ascii?Q?+TR2PBOgW8dISbkX74MI98M4HzsCp/9U4QxCFf0ZXBb21ZZ4CZd0cZYrB97G?=
 =?us-ascii?Q?725+1MCrAeKw3y1G+Jq/1orinjogB9CDUV84IyL6JKlZUQrJw4id0TGSogS3?=
 =?us-ascii?Q?NQZSNkdk78Kb0+gWwedl0TXXeJs8EEPdjH++myVmOEB5dOIEwNNETMEqVS9E?=
 =?us-ascii?Q?zUcpfdMyrWBYGmmjADPJcMnDeZ28HvF6V3noUofrt3x6Cn/umzpvRpuDsr9H?=
 =?us-ascii?Q?g1hsliQR0Bi0mVJV7qPMp9594OsO2YPRH18SzWqovoNviyzD6w2+7aWNxgPE?=
 =?us-ascii?Q?aL/rTvrtPRakDCgWbZPCb+3gerWPtXF+wSY7pPBdbdwDtwytm5YzfC/DvAlh?=
 =?us-ascii?Q?0D3YEXYL0gfv2G/EVctIzF50Gwe+RWq+ny3Z/vQJibK4HlXITe46YRCXqyfW?=
 =?us-ascii?Q?7XrKZ+g+DBz9EhVMM98ydhDRlzuTpf6Z/cvHW2nMdxgv+jr4HQimkY97GqA3?=
 =?us-ascii?Q?l8IzrH/dB1qum3sSmh4nOWuSpjrauP4bFXaBaJZJgndxzv3oIH6Kogb7rxUt?=
 =?us-ascii?Q?ANKv2VRFzna1B0OOdGd0JkZtjlJ9RtOa6h22Yglqqf/8aU7rLqVryMAwN0Em?=
 =?us-ascii?Q?tRvMFzpYjlJkhEmQj/yYZ10uOZhIO5IYStRbp7u02i3noahvgiyijOJAq90w?=
 =?us-ascii?Q?EXvdpbULzyexdLM1esszDLssCItxMY/JydcNBu3X0YPaYi0RadU6T970bdRw?=
 =?us-ascii?Q?TxbgEMsff+hdf+GizHKBpzB7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a838c027-db26-4905-8fcf-08d929669d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:44:54.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X95vEJiaZuq9LBxgtzcCL1NhBVRagVKW7/KSKxz/MRJ0IZ95y5E7KKgXL6Hh0iDXSAm+p5ZxzGkUZUU7nh9zNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: guoren@kernel.org <guoren@kernel.org>
> Sent: 06 June 2021 14:34
> To: guoren@kernel.org; Anup Patel <Anup.Patel@wdc.com>;
> palmerdabbelt@google.com; arnd@arndb.de; wens@csie.org;
> maxime@cerno.tech; drew@beagleboard.org; liush@allwinnertech.com;
> lazyparser@gmail.com; wefu@redhat.com
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> arch@vger.kernel.org; linux-sunxi@lists.linux.dev; Guo Ren
> <guoren@linux.alibaba.com>
> Subject: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for
> Allwinner D1
>=20
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> vendors define the custom properties of memory regions in PTE.
>=20
> This patchset helps SOC vendors to support their own custom interconnect
> coherent solution with PTE attributes.
>=20
> For example, allwinner D1[1] uses T-HEAD C906 as main processor, C906 has
> two modes in MMU:
>  - Compatible mode, the same as the definitions in spec.
>  - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE which
>    not mentioned in spec.
>=20
> Allwinner D1 needs the enhanced mode to support the DMA type device with
> non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as custom
> attribute bits in PTE.
>=20
> The patchset contain 4 parts (asid, pgtable, cmo, soc) which have been te=
sted
> on D1:
>  - asid: T-HEAD C906 of D1 contains full asid hw facilities which has no
>    conflict with RISC-V spec, and hope these patches soon could be
>    approved.
>  - pgtable: Using a image-hdr to pass vendor specific information and
>    setup custom PTE attributes in a global struct variable during boot
>    stage. Also it needs define custom protection_map in linux/mm.
>  - cmo: We need deal with dma_sync & icache_sync & __vdso_icache_sync.
>    In this patchset, I just show you how T-HEAD C9xx work, and seems Atis=
h
>    is working for the DMA infrustructure, please let me know the idea.
>  - soc: Add allwinner gmac driver & dts & Kconfig for sunxi test.
>=20
> The patchset could work with linux-5.13-rc4, here is the steps for D1:
>  - Download linux-5.13-rc4 and apply the patchset
>  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- defconfig
>  - make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux- Image modules dtbs
>  - mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e 0x0020000=
0 -
> n Linux -d arch/riscv/boot/Image uImage
>  - Download newest opensbi [2], build with [3], and get fw_dynamic.bin
>  - Copy uImage, fw_dynamic.bin, allwinner-d1-nezha-kit.dtb into boot
>    partition of TF card.
>  - Plugin the TF card and power on D1.
>=20
> Link: https://linux-sunxi.org/D1 [1]
> Link: https://github.com/riscv/opensbi branch:master [2]
> Link: https://github.com/riscv/opensbi/blob/master/docs/platform/thead-
> c9xx.md [3]
>=20
> Changes since v1:
>  - Rebase on linux-5.13-rc4
>  - Support defconfig for different PTE attributes
>  - Support C906 icache_sync
>  - Add Allwinner D1 dts & Kconfig & gmac for testing
>  - Add asid optimization for D1 usage
>=20
> Guo Ren (10):
>   riscv: asid: Use global mappings for kernel pages
>   riscv: asid: Add ASID-based tlbflushing methods
>   riscv: asid: Optimize tlbflush coding convention
>   riscv: pgtable: Fixup _PAGE_CHG_MASK usage
>   riscv: pgtable: Add custom protection_map init
>   riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
>   riscv: cmo: Add dma-noncoherency support
>   riscv: cmo: Add vendor custom icache sync
>   riscv: soc: Initial DTS for Allwinner D1 NeZha board
>   riscv: soc: Add Allwinner SoC kconfig option

The series cover letter says DMA_COHERENT support but
it is doing lot of stuff not related to DMA.

Please keep the first three patches separate. They belong
to your ASID series.

I also dislike the fact that you are continuously sending
SBI DMA sync patches without any discussion on the
UnixPlatform mailing list for SBI spec changes.

Regards,
Anup

>=20
> liush (1):
>   riscv: soc: Allwinner D1 GMAC driver only for temp use
>=20
>  arch/riscv/Kconfig                                 |    9 +
>  arch/riscv/Kconfig.socs                            |   12 +
>  arch/riscv/boot/dts/Makefile                       |    1 +
>  arch/riscv/boot/dts/allwinner/Makefile             |    2 +
>  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |   29 +
>  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |  100 +
>  arch/riscv/configs/defconfig                       |    1 +
>  arch/riscv/include/asm/cacheflush.h                |   48 +-
>  arch/riscv/include/asm/mmu_context.h               |    2 +
>  arch/riscv/include/asm/pgtable-64.h                |    8 +-
>  arch/riscv/include/asm/pgtable-bits.h              |   20 +-
>  arch/riscv/include/asm/pgtable.h                   |   44 +-
>  arch/riscv/include/asm/sbi.h                       |   15 +
>  arch/riscv/include/asm/soc.h                       |    1 +
>  arch/riscv/include/asm/tlbflush.h                  |   22 +
>  arch/riscv/include/asm/vendorid_list.h             |    1 +
>  arch/riscv/kernel/sbi.c                            |   19 +
>  arch/riscv/kernel/soc.c                            |   22 +
>  arch/riscv/kernel/vdso/flush_icache.S              |   33 +-
>  arch/riscv/mm/Makefile                             |    1 +
>  arch/riscv/mm/cacheflush.c                         |    3 +-
>  arch/riscv/mm/context.c                            |    2 +-
>  arch/riscv/mm/dma-mapping.c                        |   53 +
>  arch/riscv/mm/init.c                               |   26 +
>  arch/riscv/mm/tlbflush.c                           |   57 +-
>  drivers/net/ethernet/Kconfig                       |    1 +
>  drivers/net/ethernet/Makefile                      |    1 +
>  drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
>  drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
>  drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
>  drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240
> ++++++++++++++++++++
>  drivers/net/ethernet/allwinnertmp/sunxi-gmac.h     |  258 +++
>  drivers/net/phy/realtek.c                          |    2 +-
>  mm/mmap.c                                          |    4 +
>  34 files changed, 3714 insertions(+), 37 deletions(-)  create mode 10064=
4
> arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-
> kit.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
>  create mode 100644 arch/riscv/mm/dma-mapping.c  create mode 100644
> drivers/net/ethernet/allwinnertmp/Kconfig
>  create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
>  create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h
>=20
> --
> 2.7.4

