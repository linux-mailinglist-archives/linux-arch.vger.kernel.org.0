Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39A6980CA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBOQXS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBOQXR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 11:23:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E332CFB;
        Wed, 15 Feb 2023 08:23:14 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FG6XYh002568;
        Wed, 15 Feb 2023 16:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=nq4LfOIYnP6y4Mzr5hYSqCcQe/XMKu/f/2+ilkqPWCY=;
 b=OzMzwqYC+zjggbw3CU7ofbYDf1qfZ0hBRa1uB70UVEUizQMucHiwadR+MBXS0EvHI9uj
 ZavnW6+J6+iVBsu1YUIqUtaZ39rvtys8R0zYRPyJqPaZz2eVTrgJ1bNKt4Sz3s69T3Kx
 UtVDRqUwfe9nmNamNTBClb9Fh0gmAP5+yz//BVZNV6fGGVSIPZa1evawqw7kLMh1p3uy
 LSBnk+nGrgRT51/hUqXx5ozRmbtkb7g+P9ggxZoNOZ93nDcOZFUqEN3wiw1dn871p7Y0
 1b+STNSSxMXzcpTiFecOOqdxKS8v4Swwha6C99FyYNM92aSM62DkwvYi1nj4AQaKmFq2 Mw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkmfx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 16:23:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPiM/z5peXeoqEG8sEtazzkm1/KNYFuPZRREohC/2NyhsuWtOadhJgBLOcU/jFSwyCmIghYICnAOYj+4vNehG6CcNz2mvhH1eJqabYGMEM9Aqf/bUoTeuDCzp6Hp+9dpZw6cywKRuY3Cag5dL0zkS7Ac+xha9wcjXKuTP9dTdvZg95w519Vu5RuZ61YwfidxskSrTxRHE9KsZADE3GK8jNodVzwmga5Prmb+tGgmRXNTzBSna7m9INiAEJ3E8HmFQBkiwoEoz3AfUh6DOqTkHDfjt5S30QLfjef2VUTm1L57R1KIjmylR/n4ls0ArtQRe2MeUnQwDfHGERm6nIMweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq4LfOIYnP6y4Mzr5hYSqCcQe/XMKu/f/2+ilkqPWCY=;
 b=hBiCm030gYOnH3hHiBMIIvzKGlRUOhNC4DW+wOeIoNUmSHv6AJTqceV7ZfxlqCT+Rtzs20t2vK3qaxVPOo+lXoRbaEFwpR53spWiPuUpV2yDkrPeh52EZNFeQhblWlEaJC+NWSNHr55Hp95apPP7bicO+hghhDyICSNIhtmz1M0xWnSAMUaWV/mdIQWOs9I3uAbYzWMTBhYc3rUe3+l9O+QtZqOwnjXVAAnHfMdb24pec9KLl90foxv2Ge2bnjWgYG16YYErJfDQputE47Wr3iCMLG5m4mN3mNwNNwVJWT45L3PjfVNKOlcG9JDld1MGzwoe8AwBYwfXilmSId4KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by SJ0PR02MB7438.namprd02.prod.outlook.com (2603:10b6:a03:294::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 16:22:56 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::3b23:f0f1:e8fd:7fc0]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::3b23:f0f1:e8fd:7fc0%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 16:22:56 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 12/7] hexagon: Implement the new page table range API
Thread-Topic: [PATCH 12/7] hexagon: Implement the new page table range API
Thread-Index: AQHZQNEv4MMnrFr2C0a7EbrpwuuzQq7QMcsQ
Date:   Wed, 15 Feb 2023 16:22:56 +0000
Message-ID: <SN6PR02MB4205EC14C2B3D85CCFFFF2C6B8A39@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-4-willy@infradead.org>
In-Reply-To: <20230215000446.1655635-4-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|SJ0PR02MB7438:EE_
x-ms-office365-filtering-correlation-id: 3fa3c5f9-f8f0-410c-255a-08db0f70e5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2+h9ae8XgcSSjK2XRQvcpLlZqbbR+J9UucgKfZh0QaELrPcndvIBH2AoVrFV7ewbw2pVZwTgxK2mZfplRzY79oE0LX/BDhixEUUAtQl5gWFzVrT0E/gyD7fpSG9u+hBULenVy/4LfjESltGSwb87TGb0ylzGY6NjfgB6WVp75GZXtV3kxKGris1RBDjxUzROfI76T7NKFFJAkICA7FCGSBkb9eJqzLnIr6iAUPO9G9pJi++S1epqVbbJyedSDFTYoIMn92hYghmG7sX/tdkvL2Le5ACDeIgLh67mgj/RQvE3J+L7upR2/dCJYWhhFuS8aR0qrQ99Efr4wjORBFHdbfGGKc+HMg63sIWafNvYIo7z42am0MZ8ORn9qe56WdsnEdy98FHymFZ5KDUJRZSpKUUfpNmPQzViJeQKYBjFF3ztcggJObb74pHjw8FWgKUF7Kei5A5UGlf58wRcAWjEJBqarKyvFRX00eqq72wFWa7HZzBM2s7ox5FcylmXgP+5NqjWmR2WFLkAe6VxJ3RUwp+uJfsDU1OpLivbYQZAzehEPDelakuCfdnDH4tL++MMKKNWmfvnGzSzkstiHn6XU9cm7ZJ9FPgMOTERnlQXt+p2V08ajNnQ3Ge9nRyevB6hohQfHUd5tfrlkjGVEOiy1fe+xmK0XRroie9YAYDIx96gK755E9mm5l10UkE6kz3GA7FdKMPGAFGS2Hs6+PPEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(33656002)(83380400001)(110136005)(55016003)(478600001)(71200400001)(7696005)(6506007)(26005)(9686003)(186003)(38100700002)(41300700001)(5660300002)(86362001)(52536014)(38070700005)(8936002)(316002)(8676002)(66446008)(64756008)(2906002)(66946007)(66476007)(66556008)(76116006)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aOniKsl0UHmAJwkcQwZQQtBNX6+z+IW+EQzEwdU/YqOIYKZ8KDf/GzNwD0AO?=
 =?us-ascii?Q?WilVPzPeVfckr8yErmodDpq9O0s1QBQeDPrqVfLtwggOPkubGle5I2fw4DSZ?=
 =?us-ascii?Q?FPcGB72LDPNb43oYYwQqjdv2W7XMiBLwWJqwmMA96d7eTQqeI2GT3wYYQRxS?=
 =?us-ascii?Q?6yJuSgvxV9EAJ1MrdfZccMW3ff/XQ5VE2kn241S1UdJBSrPvYkfo2iSU043Y?=
 =?us-ascii?Q?hOaS3VS9i8ZSFIHyn5/q/TINqfgqyVhc1QB02gLRu1LKKtwPJxo12WUQ6wAd?=
 =?us-ascii?Q?q5pgMYT8dwF4oVeVcEFJWuf+dZaK/SAXF62ytE+4S+n16CPOcZTPKV/kgDpv?=
 =?us-ascii?Q?AheG1c51fUT+0KaIKnRXUV2Pijk18AUY/4Ei0IL0DVYdaiucAneqiPv0JrtZ?=
 =?us-ascii?Q?E6lkAAXCEB1ewPpq0zfoBIDAbsTFI4jg7HQnvzGnL1D9TYxm1rnZMRTQH4x7?=
 =?us-ascii?Q?2RKXELeGn3y/sWovxyu7mK+yhZSVd3yLwyvuTAhSj71FHZj2iULvYv1Qu0QF?=
 =?us-ascii?Q?B022Fa1KeTB9uh9nOZ/7uqGRv4SLmChfIjEpABanUwRcb2sGfbOJLfLA5DOh?=
 =?us-ascii?Q?YZVvMjIafuZuJSU8YR3Urh/du1Yzu8YgeC7bsqhY0Z665Xq/UPrqNN2rrYOf?=
 =?us-ascii?Q?lyhRZzPESf1E0dm3jyKu6dUwV7/tA8s2XF63M/0YlacvwvHOOp0Rnru+pNdF?=
 =?us-ascii?Q?cxBWHD9A3NJgd4ovcryKYPTbAIxTx5Zq1xghia+npPwKNpbhD2OJNg4WVOoY?=
 =?us-ascii?Q?uC7dqzvLrrGhWKUBKG2jud6l6BOWl1AIhrYNgCOKQWRgeZEwjMzCMCwUSPsN?=
 =?us-ascii?Q?VfJ0RDNaygQnNYNIRJEZnifct5B/erLBNiklzzg0OCi9Yo5+SZfzXMYRkS4G?=
 =?us-ascii?Q?cj44OkQHW2uwOiRzFbFI44kZD/W/Wt1RlHtMK4pdnkI0tMz4KYsS67Az707p?=
 =?us-ascii?Q?hYWzLLXr0PHc9UHfz3rm4zf2baO2scDzwWoXN0ZpxVoOh7Jg/SukuclKhSn5?=
 =?us-ascii?Q?N/Y2NNtBQ2yJ6tdJxm/vPVS3b+rHA7eJZE0PWRK5vy03tfq0Hlg5Wov60SH0?=
 =?us-ascii?Q?2I7rEYjzEP35EvVx+atKv2ZgRUT9aOGR0ukE1bQq/l7DUKiEe8WKbYKHcW7d?=
 =?us-ascii?Q?0gc2DiVq3M7JJiUPj5wEq0UrEyQYFiAY/FUOy329SM6kl7pZwnfmcoUHJV08?=
 =?us-ascii?Q?8Dbu0CUwWHDSYcHnuY3ykpa7wPaV0Kg6jEXRCG0buJrXwTJtIgiYzgwi8eEI?=
 =?us-ascii?Q?6RbIfkSxwGJRZeTXFkKWIS+GernDKrMXvgO3OfMlYcBs8H72DD8mv4eKi0g2?=
 =?us-ascii?Q?8nmlYw9GamJ5XpULWHg72MihyjvfAhx5/OQPdVCj1EpcCWnpgF7kBJz+c7Kp?=
 =?us-ascii?Q?vv2vgSCo0X55kbfWzL6n0/YyVjHQJejYhVDChBHK4p8n5AUNnt8kiDDsAPzK?=
 =?us-ascii?Q?ZrSBjmf+fzCdHQd46BA9GhR5IsLSyLEjTwb5zMBom2p+y1dbLk+ch/NpV/ee?=
 =?us-ascii?Q?Pw1cGcHJhAHsfRdX2k6tYBstOGd40mNpyiFQ/HFviqHegfkLnBcEXjJHV7v1?=
 =?us-ascii?Q?v5sWwLK1Wuq5EXljuNQTwR/i9Pg9k3uwvFrupmEW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K0NO3BRJlWojMALuxjik2MbemflAUeXTle/hrq6kbWeM8EPSa7XtcYLvNkvQbnFtImPHvd8isFhfbeW0fHi7CPBTYOWJoF/xyWDEskmsDx7sqqSpz5z5M9TMZXCLkCNClfL+Gx3aIft2JI7TKF3UYxCeJEkwrLhq07y7W/vBQMziJ6jP0Y2fOl2na4HbOFD/1iDeCq8uL/eO/79HpXf+cjqKJ5Nb6p3XUsyE+CXV1daKfPieihcTzfK3+LysOmTuBFVofsr2cFQif4yjqHpwVsVBqPd0tWsdxhTy/ZeXTPn4XBxJgutlAgM8zdZuvtpBQMNb281KHUW3y5Y9mbn5KEtlfvB5ZQY+gpUXxc8jtiI54GJjTFI3xeTxe/8JQR2sgty/CSd53AaIhXux6uBTDzeqqJ4Z5f2ipEJ8mcNw/GjcrxObMS/QIBeTV49cm9dugKHvyv2mT1+rzQl9os6842URLLQ65EHp/3kvjSVJ7ZRpJSg8czMNn8p/6JVUtc7Xl96m4WmYPWhpY0fNBNDXUmM/Ao/2JOunBBn/OvfKzJ8LCUpUKVtELUn91jrflGE0AGpl8sun3jnqZ0xfbHbGk1JFp/MC3OBh/N0Ov6hxNDrMthWJx9SqXwDt+Rd/znxVPd4So4TfLXFiow5TKjGPwGBN/FgSq7j/CycqId4BLrJ36tU1bkzw6Qz5E4h3BwG9fff1cdyd0b29shVLoTndS1a/bLblpVN0necAsTx5Okj81QgVBvIbeTVK0/vvGPtjAGDFjGegy+XNgY2XVxLiixlsM0jF06QEEqBLQBwW0qWazIMl5pf4s6L8wcfjftNkuk4BfgiXlho+Gu5q70cyLw==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa3c5f9-f8f0-410c-255a-08db0f70e5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 16:22:56.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +13xuU7NC0k9kaP5gz6W7zOBDOCTFDk3NekHiTWXBjnWUC3Q0s2qJqRDeAqYZVa4H8+Do6HLzd1Xg82t+JX1zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7438
X-Proofpoint-GUID: OVvXd8l7xCPzQ8vhm1pERRtkwTXLH14n
X-Proofpoint-ORIG-GUID: OVvXd8l7xCPzQ8vhm1pERRtkwTXLH14n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=848 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
...
>=20
> Add set_ptes() and update_mmu_cache_range().
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/hexagon/include/asm/cacheflush.h |  7 +++++--
>  arch/hexagon/include/asm/pgtable.h    | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/hexagon/include/asm/cacheflush.h
> b/arch/hexagon/include/asm/cacheflush.h
> index 6eff0730e6ef..63ca314ede89 100644
> --- a/arch/hexagon/include/asm/cacheflush.h
> +++ b/arch/hexagon/include/asm/cacheflush.h
> @@ -58,12 +58,15 @@ extern void flush_cache_all_hexagon(void);
>   * clean the cache when the PTE is set.
>   *
>   */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -                                       unsigned long address, pte_t *pte=
p)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +               unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>         /*  generic_ptrace_pokedata doesn't wind up here, does it?  */
>  }
>=20
> +#define update_mmu_cache(vma, addr, ptep) \
> +       update_mmu_cache_range(vma, addr, ptep, 1)
> +
>  void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
>                        unsigned long vaddr, void *dst, void *src, int len=
);
>  #define copy_to_user_page copy_to_user_page
> diff --git a/arch/hexagon/include/asm/pgtable.h
> b/arch/hexagon/include/asm/pgtable.h
> index 59393613d086..f58f1d920769 100644
> --- a/arch/hexagon/include/asm/pgtable.h
> +++ b/arch/hexagon/include/asm/pgtable.h
> @@ -346,12 +346,24 @@ static inline int pte_exec(pte_t pte)
>  #define set_pmd(pmdptr, pmdval) (*(pmdptr) =3D (pmdval))
>=20
>  /*
> - * set_pte_at - update page table and do whatever magic may be
> + * set_ptes - update page table and do whatever magic may be
>   * necessary to make the underlying hardware/firmware take note.
>   *
>   * VM may require a virtual instruction to alert the MMU.
>   */
> -#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +               pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +       for (;;) {
> +               set_pte(ptep, pte);
> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               pte_val(pte) +=3D PAGE_SIZE;
> +       }
> +}
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>=20
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> --
> 2.39.1

Acked-by: Brian Cain <bcain@quicinc.com>
