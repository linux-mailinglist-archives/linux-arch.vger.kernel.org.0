Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496887377CC
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFTXFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 19:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFTXFO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 19:05:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA20CD;
        Tue, 20 Jun 2023 16:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAsqsJZKEBx38D1P5a7N1Jr3Rbd4OczRiaO89yYo9WPjer3aJHQG/2F2lA5FjQKCisiK4oPu8LHQuEnEVill/d8/Yo1NsGh3+YisL+t55VevPgvMiW933XI46Wp32QWAVUKk/ZHTQQVdb+ltWYn7ypHG2qfeJaD9djIUUqP0QY0QkJXf8t7GyawAJGdGqSBTHHz1ASQ0dg4XjUcmuwFCDBN6Uro8+k9f5bJ8TbZHZNutcWMUDSta1wffvwH6yPeRw+yOpY74HVjbZSKm9k+LI7OHRLw1hnvARfRhvLQ9NorPel8k3uXbHTtXwy7xY3rT4mR3NDunydAczqZdP1LYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltTIiBtZe5keN/2eRCeT5n726rQ4ogdJ3lncN2+uErk=;
 b=fcShjhjxkC7z2voYps6ZEdhCmACMsHBTr7lVigip++2wFKMK4WRmTBsEuPswBqiBpHGnXkIo4dv5ZN+1ZViXzqmrt+s40TWOmWp5kpBt5nQf2ake9dgABmCWWslWK34Yu1arNIaL/elBy9l22iyeT2We8aAeR9/xQuYiOc5xPz9uhoo6icyFy/nhl+v55xB5Ic8e2eChQu+Nzeo/SJlw1BhrX5r5gussacUU1Xo/gWFyj74ntecvf5sPdszA+Y+1Gz0xlJigLO6oqwR3NavBMForHMKXB+rP46h42KCk76sz5bTs2JCxN1vfqq8/11uFUyssSlV7cbqcosPz3ucBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltTIiBtZe5keN/2eRCeT5n726rQ4ogdJ3lncN2+uErk=;
 b=QlGuaa3Qx7T1/sBNlW/z3ccnCwjn/R1SShPsOeCqw4kB5ojYj5pPLBiAkHc0PKwg209K+9Fxl6ilpmMV18URVAeC5u9+Os/y1rDR2dcxrej0URZf0CtriqhjJI7vGFWn0vFCjCBS1k3a/16ldDjXUJvcQ2x3EzFgz/MSiU0DiEmwGq2FemrFz74ERGE0l3qZNL6eyQPSU2eTCraX7zcfbwGCkCJUAqt0CLVrEko/134SAirS55HhAEoeREwIN/pe3w/PA0sGx26Y4OvpPUjZxfBoQojIo1hQ5ZgiQ5aZnrQftdnMcwnBU1hl0vibL0jSfKtZ3JjEwzP4yejLH5os6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 23:05:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 23:05:10 +0000
Date:   Tue, 20 Jun 2023 20:05:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Message-ID: <ZJIwpO68kc3zMB/c@nvidia.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
 <ZIxXw9ERkYv+ipdd@nvidia.com>
 <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: af9c6ca0-8ecf-460c-f580-08db71e2cc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo9DFPA5oeloN7xGzm07ngwHI/ma6YfGkq+TcV/QsCbfwAqOIODlMtDRpQMrh9zEQGtQ+2oQjjkwlnQQXb62Omc/6I0UdBVTBTu4yVDlxRDExk5c7ph1JGMXJ6FivilmsF3weqmwT35SXe88V+T9l3YeJOLlj1iD4jz9FKaWiw81SokUYq8CyJc3EcFLZWJ+817+fFWNAZKDZbMeB0MbbPN01Fa2jQdMcozgtJnFDAzGODsS/4Xq5NvRmbmDEeqL0prbZBATb+eHL1tq6OyrHKD5mjkzk/PLCnudynSetLxSv7fh42hsTTAn8xRomjD3I+IHbBg40gYrkVwiLBNxIATmy1rOtcKuM7IYdc3g7Dsj8/1S8SMpEpz/KzRGvcJxLN9NlSwhtRNMb2iz5Bnm5culwdwSeNnQMIZEaYi/WIbdbl6bvJTbKs0aM+6IxYPhMrHAKKJSe2N1U8PawFmLWg8TeXGDZWqZ880mbBnQyC+kSHnKZqjicg5mgZMLA9JHln0s/h7EsX7oOtKe8QzimYF4prgC4F2eLGnsvche018B1Q5yuJ9cUdiAkZkUFxA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6486002)(478600001)(83380400001)(186003)(6512007)(6506007)(53546011)(2616005)(36756003)(26005)(86362001)(38100700002)(8676002)(5660300002)(8936002)(316002)(2906002)(41300700001)(4326008)(6916009)(66476007)(66556008)(66946007)(7416002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBzSlhoQzNXeWJjSzROZjl0OWxseUdGajZVK3Y5RjZWWUE1b1dLRjNzeThw?=
 =?utf-8?B?MG1pZ3Q1NDFLU0RNVnFCeDdHWEdkUVl6UVZqVUIrUmpXY0E3SndpQ2tPNHBC?=
 =?utf-8?B?NUhzdDRua2dUd3FMVGsybEx1eUs1TmMrY1o0MFUwcVptQ0xRTEdTdmRMRm01?=
 =?utf-8?B?K1IxRXdwQmxUTno0QlMvejF4MGRWM2xHdGhSN3U3WDZrQXFpdEY5Rk5TQWpy?=
 =?utf-8?B?aHZTSHNrdnlJRVczWXZ3a0F5TGFrSGV3L1o0ZURpRDlnSXdJWDhUMTk5YlRa?=
 =?utf-8?B?WjNRa3U1eWlWSU1lNmpRSDEvYmVOTU1kdXFCQ0t0cDk4am9SemxEMU0xTllm?=
 =?utf-8?B?RUxnVzRJellGRXFoSFVlQzJPR0xVSEdCc3UrRmZvL2RwUWVwd2xhNlhxTFg3?=
 =?utf-8?B?R0ZNRFV5bjBhbXRldXFXUks4Q1JYQUJuQms1WHBFT29sOFkwbUVtbktNbkpU?=
 =?utf-8?B?cEVRU2xBaHlHSnExcEd3VWNQNmZRU2diSEs4OGRJaFJhdmw5dVh3ZlRCRlJD?=
 =?utf-8?B?eXNtZDdOQzJOTXdrZHJWeVNGWkJPVStNU0x0NGFMTDVGZlJ4QUhWaXVsSjMr?=
 =?utf-8?B?dFZIMVNrMEtYOSthOEl3QTZsVEE4U0lTdVI4T0FhNXVFbjc5MXZaQ3p2WTg1?=
 =?utf-8?B?UG5EcWdIRHIxWDdXOVBTQkdoUVhuaEluZnRMVDJmOHZ6a1lrbFAxYWkyN0k4?=
 =?utf-8?B?V1VCSVRIV29rVTBISjdrSnY2WmNRZ2x2Y2N6cHpBdlo3SWJxbVZpd2pEVXl6?=
 =?utf-8?B?U2ZtTWFkU3RGSU1MUTBMU3FWeEVJbVVuLzhFLzBzZ3NxZzBITXFhNDUvdGNY?=
 =?utf-8?B?OUg3RkMvL2xQSEt2Z1lIcVVVd0F1UnFaNmFtdVplR2dEdTFiS3lWbVdMQU13?=
 =?utf-8?B?eDFCaHhhNFkvajVRUGp1MnRYY0JYVDVyc1VabVBwWmVld3R6UWQ3bXpIRUU2?=
 =?utf-8?B?Ti9qQ005c3Q4YWVhZnRhZ2F6S1ZZK0hYUDcvUkltRlFPcVZNanVXZDdFTHcr?=
 =?utf-8?B?aFA0ZGczT2wvbUJFUW1QRFhjWnhkeVlEN3dwVWVsUG91eHVRZ1dEenN4WEdi?=
 =?utf-8?B?VHhhMmJMbXJCelMzMkN5TTM2ZTRaU21aWUE3YzFRR2gwa21ocUpManlKc1JJ?=
 =?utf-8?B?RzVZc1Fpb3QwN3lWMCs3c2d6cll3ODM1RFBLWmZ1Q1dXckhnc3FFdCtVVWhu?=
 =?utf-8?B?THZlM0xHYzU1KzNOZ2pBNlpjd0JudmZYV2RXYkY0R2RvN0lYTUczL2hyaWtR?=
 =?utf-8?B?UElsQWFoMTJEbHZ1aVJFQmdKNW45cW9VcklKME5XMEVCWHJoZWhGSURXU0ND?=
 =?utf-8?B?Qy95OXlabjhMSW4zSi9WbXFjWkRSWlJ2ZjVxT05GQkhlOW9IV0ZZNHppM3Z5?=
 =?utf-8?B?MDJ6WlovU3BxcnFwZU03TXNKNHcrVzErQTNKZFY4UnB2c2UzWE80bWJxZDMr?=
 =?utf-8?B?V21Ocjd4YTVrbDJQeTh4a2hDdzA3cVdQMWRFamF4TUsrLy95M3dQSDZmVlBa?=
 =?utf-8?B?VEo2RHhwaWZreDRBdkJ6Ryt3WExIbzZXOTB6MHhLcXMweFY5UkwxcGdQcGt5?=
 =?utf-8?B?SzRVUUF4eDdrcUVvRWNNVjZsRllEK3dqaUlTL0lNRW5hd2pHcFRCUHdITGJG?=
 =?utf-8?B?WEkvSHVXdEpjNVYyMHo3WVhCbWloUlJCRjUrdllmeExOTkJNSGpTaWc4RE1S?=
 =?utf-8?B?RGZ1aGlCY1I3RlZhT1JpNFlNM0x5bU0rMHNZa0pzS3NBZThSQUs4bW80cFc4?=
 =?utf-8?B?VzFkaXNmS2VGaVhaTFV4WWZqcWk5RHhoV0JEcFJ4MUdnQTZLQ2I0T29vWkhZ?=
 =?utf-8?B?Ym9GdFdQZFZpanJpSlA5c21Ra1lBVnl6SXRRdFgvQk94NENwaERTcWo5aDJZ?=
 =?utf-8?B?cUhMVmFJUkZmRUpWNUdFWHUxaXhobXRMbHVWbVFLL2pQazRuaXRvcUM4Nmlm?=
 =?utf-8?B?N2ZCTE9OSjBhbjJmb24zT09qQzNjTzFVM05xbU42S3NLWlJxTmorU1BHSXh6?=
 =?utf-8?B?SnNJY2Q0WjVucEQ5bTZlTGw4WERsdHlXZEJkRGwvbEx5K0VEeG0xdUJCcXBS?=
 =?utf-8?B?WFgxSTRneE4xWlhQc0hwbmpuMktPclkzYkViYm0zQVU2VXQxZk43VUI1c28r?=
 =?utf-8?Q?9vgoPf+W0tynJua4GrNJ45e8y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9c6ca0-8ecf-460c-f580-08db71e2cc0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 23:05:10.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+LKfZovjZy61f+HGv7RJ64nxAoBBBqUKUgPMSNcpJkcIbEmsgeezoq6nuoAuxkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 20, 2023 at 01:01:39PM -0700, Vishal Moola wrote:
> On Fri, Jun 16, 2023 at 5:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote:
> > > Currently, page table information is stored within struct page. As part
> > > of simplifying struct page, create struct ptdesc for page table
> > > information.
> > >
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index c5a51481bbb9..330de96ebfd6 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
> > >  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> > >  #endif /* CONFIG_MMU */
> > >
> > > +
> > > +/**
> > > + * struct ptdesc - Memory descriptor for page tables.
> > > + * @__page_flags: Same as page flags. Unused for page tables.
> > > + * @pt_list: List of used page tables. Used for s390 and x86.
> > > + * @_pt_pad_1: Padding that aliases with page's compound head.
> > > + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> > > + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
> > > + * @pt_mm: Used for x86 pgds.
> > > + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> > > + * @ptl: Lock for the page table.
> > > + *
> > > + * This struct overlays struct page for now. Do not modify without a good
> > > + * understanding of the issues.
> > > + */
> > > +struct ptdesc {
> > > +     unsigned long __page_flags;
> > > +
> > > +     union {
> > > +             struct list_head pt_list;
> > > +             struct {
> > > +                     unsigned long _pt_pad_1;
> > > +                     pgtable_t pmd_huge_pte;
> > > +             };
> > > +     };
> > > +     unsigned long _pt_s390_gaddr;
> > > +
> > > +     union {
> > > +             struct mm_struct *pt_mm;
> > > +             atomic_t pt_frag_refcount;
> > > +     };
> > > +
> > > +#if ALLOC_SPLIT_PTLOCKS
> > > +     spinlock_t *ptl;
> > > +#else
> > > +     spinlock_t ptl;
> > > +#endif
> > > +};
> >
> > I think you should include the memcg here too? It needs to be valid
> > for a ptdesc, even if we don't currently deref it through the ptdesc
> > type.
> 
> Yes, thanks for catching that! I'll add it to v5.
> 
> > Also, do you see a way to someday put a 'struct rcu_head' into here?
> 
> Eventually, when they're being dynamically allocated independent of
> struct page. Although at that point I'm not sure if we'll need one.

Sooner than dynamic struct page?

Probably it can overlap pt_list in alot of arches?

Jason
