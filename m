Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE18D5B9FB3
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIOQfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIOQfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 12:35:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F30186CA;
        Thu, 15 Sep 2022 09:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxKVOK5FtWMoH0VQUfETk2izEbcrJt62SY5hu7OEDxH3Ke8excQ5eRsAAwAKCeK2DMBJ9FwjNiANDujqwj2ui0IGSUjeVLsBLeLpJUJSjgZqPjL6moJGYMVGXPwSE+VwyERaeNKTwKRE2sUsb01VTu3P/ixpiZ+ahtr1vAuxLyOyIg5jNrAcgvhGAB5W6Fdf0fcThJFiYc+2Is4QYjOjVFBBNfeWWJiD0IjlPwdS4fzFm3m8dW7RRJuSm4m5MZX5oifIyngNFBb7wjwpWaUnZd4bZ82JuUsIExCg8tHIPuZfFWchzBn1zZ6FHjCUIu12rriX0T1J/+8roe/mIzc9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+hQpRDVFU/i2xddiSZxaHnXLTgqfE6fAghgk8Gwi1Y=;
 b=QAHSCYdfezOkE20xbmvEVrv5JRrErquFlO5PvXOlW9zw44QOGyVVLivhmmmFcZuG4UunzT2e009EgaHQsdYHlXWw7fwP+nW/Fh867h/0MesHL7TXIpFEmB3UOPHbZFNXVmCeVH6uHKFVsH2rPaoUvhKSb6N5PgWuto0Sjmfra6t6LMlgcO4i5VWr4i+x9pAeUu4NLuBOSnNdLCTt+Tq+tXFJlFgzpUBWRtOCRXpdnszh7tQatCB0D1rmQ+GMQ3J1yupkzRtP4gVoF9tTG66mgk8Cx+KjZw7MTHC0UMS5Pz98JObngMlMTg7UcMITsd9Dtk/SSwf5/WqiC+j8eDwqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+hQpRDVFU/i2xddiSZxaHnXLTgqfE6fAghgk8Gwi1Y=;
 b=UwwmOl3KMW1QzAwO4JODexLnZ5cpjlJx+Tlps3ae735F3zDyKVSvqxXgkS8e2oAk0S7bphjbUqyx9vJ/agG45O8lqnguUsTBPzHOJdT5G9qg4dBY8LteDv7HftfWv99BOrkESHF0uQ61symt1guGNGGsH4iaE7iAVEKEda0/hzS+LStAv7zsZZxln53YuBqwsRFhh5RLGb+3wu9sXx0PP3d3aDLulhIe0h7rEpZFcJF0oYn9bAysbVsqQ/wWnFc4LA1uWx+IkM9HZ2iiBDvLejw2FK4T+dzwRIZJtCrFo6P6MEolZds3Cgspp9aBNFUSQt/QcBn1pNbPz1UdTK9jnw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 16:35:18 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 16:35:17 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Topic: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Index: AQHYyMA9YvMyHkwA3EyvMDv7VnmV1K3gbnaAgAAIXgCAACPnAIAAECbg
Date:   Thu, 15 Sep 2022 16:35:17 +0000
Message-ID: <PH0PR12MB548113D13F9E9CE4D5206514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
 <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
In-Reply-To: <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5392:EE_
x-ms-office365-filtering-correlation-id: 77bd6103-cd77-4884-0193-08da973845f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gz/Q5hO797dCnUJvAoPsi5eVdHO0TEYs5r+/JyRzq1eeAR9TXFETJ9H1hlHbDZK4bkmndmcpoPphynmONpZ1Pr0RvuXlT6W5/onUVDXpUk5ogMGuKM/hnvKs9n7rTFQ2XruHq4GUazFDaFdfXfChDebcwmiW/+UZFzg2hBV163zeaV3W6IDzJQ1uJGio3DK/SVrHPAhjn6t/t+x+6Vd1bDMSnbRhKYAw3Tn4K/BYrm4UBo2g8tXxe/n7vfsgqsTneNtj0mZv5KfI3THEJQHZ+I1Oh2E+ulkSHeaDywMri3fWZ5cA4eeQdqk1At/Bq1Po8oo71LLZU59gBrADoPA1Sppx8qKLxwdBcnFyjqG544EwB5eTJS6fnRnDLpemTtrm6As8HmZqq2Um+LT/zBvqZPBr0kN8gC2ZKfgThz0N3S+HR8Go4mw+j0yQSVOh7jQD+D/Jlm6UM0JXRUFbUNP++lmoULz2k84a4l1nioUYJ98jkj3/f3hJIkZREme5KQBXI2wNS2Emi2ELm3fyy6nuBoYdnjEMjNhhzqAMhnSMUEPRqJOjpf6Jd4H42UgBqnSjbQkPqJMAIrJA4EwHx8qc7tPfErvGbGpM/6hdna7IWC08XjER3wjubaA/BFXQQoSQKyUmrlDv+rgeY1wwiyi7zN2IEHtvYGcVPtOgMwtDdzkajNLUA76spCzUpBntf+oZhRA3FD4TWmFdRAytRuuzkNLjD239WOEtfnRYueh+OQrbFP8CLdC/TZLmBInW6AdJ3wA1WEkzzgIcivHyEEY9rpUrvWzwdjj+iaHGp6SIVYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(8936002)(52536014)(86362001)(7416002)(5660300002)(921005)(6506007)(55016003)(66476007)(66556008)(64756008)(83380400001)(66946007)(38070700005)(66446008)(2906002)(41300700001)(122000001)(71200400001)(186003)(110136005)(8676002)(76116006)(33656002)(478600001)(9686003)(316002)(7696005)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yCz/79xIIZbHCV/VVMMpa0pmbq4+ZcEhCtsI+hBEBGWrHrO+T5RILsr2A8Jk?=
 =?us-ascii?Q?aiKLnD/sSKujaphPf6K68h8NdknEfriyf+d+zraM0HWh4hLRjQeURjc3mS4e?=
 =?us-ascii?Q?EQfhbfwkmyADSodUERkAc0ID97KYazbnAOok4lvWEPiWOINHvMJT8ze1conF?=
 =?us-ascii?Q?/qJWjBNE4/HhlTmibxCphopaZY3gOlrpFURmj8pd/kN9tZA3DocKnKkM6ekV?=
 =?us-ascii?Q?EZnsMFb4TBTJAfNYkDwxW76iK/xwNJFXePJO+Yjigyj8FDyW5XVIyE0K+FpV?=
 =?us-ascii?Q?oMR8LQJWGXlGF3TnKJ5GYas4gDgK1utELUMtms0EZnTUsXWOjGpt6lVMp9lE?=
 =?us-ascii?Q?YXtBuscQzP0Rsxol6DyhfCw6vPMjO25rhlmT8gmpJ3iCBHjfocUVhTzXEhW6?=
 =?us-ascii?Q?Un1gKhlH6OxDKi9OPpJEp1CpEsFVVgaNViQDdSBhydC3ewowclSnW77s0cAr?=
 =?us-ascii?Q?pTF0SohlKI3jiAU3nE7ySzPg0MZPVyvddltQUMV9UbBlmyBeHFkTJ1zGxQX7?=
 =?us-ascii?Q?KRt3guQHmmERpvJx0YGLqkfjwob7wJgZmvyNfA/anPKeAU5r4JQa8SoqcIT+?=
 =?us-ascii?Q?53dOyxV7LqJSlnmzuQwEu9f2Wpn9qnPLMvETqAwPjERuPolT+kneQlEP47Ev?=
 =?us-ascii?Q?H3UgCvj8d/1buXJ1Z3Nz36+ZDBnwW0Cg7K0QIwSJESdw3LVqDCaBeVC480r1?=
 =?us-ascii?Q?n7e3GmM1Q2+/NpHoDehCBc/BBo8q18WgxP69BV3UeZJ+h9+nX5veETs3/CFT?=
 =?us-ascii?Q?PjHXe4HP9OOeB9vTq6a4IFpY7rL5cz1cE0g+sl83va5qbwa0edH3tuilEmNz?=
 =?us-ascii?Q?kxg26ofwa/f8uEd9N+ReRojx9BS8xBI+xTleyj8FQNCAzVZB0hFMOPCusfkr?=
 =?us-ascii?Q?Ylw1jMW03kKL6yQ7Fp1z4e+Du1Iq6Ea6oefE7Kkq8oDi3dtejY2IApTK9ch9?=
 =?us-ascii?Q?g3/ynVSGl3moyhkW0H3lHgFpuqR5asm1YYSQlGRb/CboKG4MUHyTQYwi6+n2?=
 =?us-ascii?Q?yznU8jX0CH+u+nBeoLehHf4y0O6JjWDzWoIBCKLxDL6yxkqlP/szFoo2je7+?=
 =?us-ascii?Q?vjpDFvubDqvFvPAWb1MkLflu7FXGqDhqXAJ159/m2vt4M006qUbmtEJfimRE?=
 =?us-ascii?Q?HW/ttEN/5TA82rqEPVEpIUJri02N0roppacBM+lLZFQsnH3hle9dAnYirbmR?=
 =?us-ascii?Q?qbsJ84uHz7AUxD+VMitZToOi1OCZPdkPvZLvn9oWn00KNgvHBoMg1TEcgmvR?=
 =?us-ascii?Q?69KLT7zNXVDxwXexCx9bUDE9U8yfWNOJ24foO4yAbsUiswESWHDeno80Fc+c?=
 =?us-ascii?Q?tRJDKqU5UaP5mfyXj+ss1EL/047HSbzVe31xiU6AoNF81LXQl+g+uqKJSb7z?=
 =?us-ascii?Q?BKusJHXceybzeYgTrco6XltDwXKxlhs36dAb80jcs6DiEty0mZUIrmYa9zWe?=
 =?us-ascii?Q?i+l808O+Xx5Mint1weh7qYYVJKT7QbHxI8ii4J7DimU+/09pOERIb45CgXms?=
 =?us-ascii?Q?tboC4f8vEtnN7RgsfE7F/gWk6397pH5AMWKVnl4sOJnP7vWISikBzSM9hwzb?=
 =?us-ascii?Q?RCoJhpxsJ62u3fvmUhs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd6103-cd77-4884-0193-08da973845f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 16:35:17.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YApZwM09TixFOQSYNY6eORD6qqSaJxdpNU/M5LJZwAgeLt/VvJQdKrps/euwTOTMp2ppVo1d531ERm2Rl8ej2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Thursday, September 15, 2022 11:16 AM
>=20
> On Thu, Sep 15, 2022, at 4:18 PM, Parav Pandit wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> Sent: Thursday, September 15, 2022 8:38 AM
> >>
> >> On Thu, Sep 15, 2022, at 7:01 AM, Parav Pandit wrote:
> >> > The cited commit [1] describes that when using writel(), explcit
> >> > wmb() is not needed. However, it should have said that dma_wmb() is
> >> > not needed.
> >>
> >> Are you sure? As I understand it, the dma_wmb() only serializes a set
> >> of memory accesses, but does not serialized against an MMIO access,
> >> which depending on the CPU architecture may require a different type o=
f
> barrier.
> >>
> >> E.g. on arm, writel() uses __iowmb(), which like wmb() is defined as
> >> "dsb(x); arm_heavy_mb();", while dma_wmb() is a "dmb(oshst)".
> >
> > You are right, on arm heavy barrier dsb() is needed, while on arm64,
> > dmb(oshst) is sufficient.
> >
> > So more accurate documentation is to say that 'when using writel() a
> > prior IO barrier is not needed ...'
> >
> > How about that?
>=20
> That's probably fine, not sure if it's worth changing.
>
I think it is worth because current documentation, indirectly (or incorrect=
ly) indicate that=20
"writel() does wmb() internally, so those drivers, who has difficulty in us=
ing writel() can do, wmb() + raw write".
And I sort of see above pattern in two drivers, and it is not good.
It ends up doing dsb(st) on arm64, while needed barrier is only dmb(oshst).

So to fix those two drivers, it is better to first avoid wmb() documentatio=
n reference when referring to writel().

 > > It started with my cleanup efforts to two drivers [1] and [2] that had
> > difficulty in using writel() on 32-bit system, and it ended up open
> > coding writel() as wmb() + mlx5_write64().
> >
> > I am cleaning up the repetitive pattern of, wmb();
> > mlx5_write64()
> >
> > Before I fix drivers, I thought to improve the documentation that I
> > can follow. :)
>=20
> Right, that is definitely a good idea.
>=20
> I see that there is more going on with that function, at least the loop i=
n
> post_send_nop() probably just wants to use __iowrite64_copy(), but that
> also has no barrier in it, while changing mlx5_write64() to use iowrite64=
be()
> or similar would of course add excessive barriers inside of the loop.

True. All other conversion seems possible.
For post_send_nop(), __iowmb() needs to be exposed, which is not available =
today and it is only one-off user,
I am inclined to keep post_send_nop()  as-is, but want to improve/correct r=
est of the callers in these two drivers.
