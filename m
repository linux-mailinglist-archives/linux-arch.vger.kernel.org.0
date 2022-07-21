Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A257D651
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 23:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiGUVyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiGUVyy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 17:54:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3538F507;
        Thu, 21 Jul 2022 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658440493; x=1689976493;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vayH7psUUqf7Kw2A3Gbc7sjfvDd5uK5Mu3GlBISpSew=;
  b=a6NWgS+TM/0v/PRAjSoTEox2XRmF/mbZlVvdeycFXn8+lQmqWmPW4RCN
   38lPAbzzEyTtD+JDp4A3ES9DyehynD+6b5kfm9rbeWIczHpMht4JQtlKN
   7g3T0oNAbr4zM0xl84PmJ05W8bg9Ip+WdaL2S4tNSx0ax7J6CtCqSk7E7
   x2zdsBwFdYMGCTAk3/G8otI0stJZfWOuTTRCCLoC77e8VCv7qX1t/+Jho
   mZB1udLpWv0S95PAvEqx5cMkRBD3t2fxojSxnOBWsA4y5HFK9RZDR4JTS
   n7fG74o9eWn95PqHmhvC0O0UDtkyo66Mzk7ERkozSFY8mv+yx5y8OksuE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="285942319"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="285942319"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 14:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="573921955"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 14:54:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 14:54:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 14:54:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 14:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbbxFq2mHfQanp6m1FBEElE0USkbb5RGIqJPTBSXXpWltynD8Btpow9TnpPasenLnrrnSMJJu7pITxMZl+1pNwIx7OR/TTplcfq85T5Y4zb/dcjPpsxAeN/HQHLhRd+XAmnL8QmYoTZq0oqeSf/s27Dl9544OV0pHG3qCoOOljB3oxo5mHwWF06TV6lyBjeYVQKh+j6UehYrhOyiavDrZNvE8U4z8q1fWliagfPFySq8IqWoTqiIEHfWQoctJSbv7QEoA+a2UNDEhye0KXNKnivHHeTZ8uLGSatXOLgLIv/o5VGGsseBJ3OS9A5vuebQg4IO1Xu+JdIFGbiMGdIdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3MCQ1M3f2MpNwVgFinXB4/RTXcH32UWtF+xXfNFjb0=;
 b=KGS3PWAxm3luw/reTaeneIlKA3At60DQ1pvznu+kfX25yswENWMeSltWdw7ZdXzByj/IFl34OnJhlcHF4VA6As9zM+I1irZRG1qlJEE5TfFqS1yn9lGU8LOb2G+vItCxR5v02GfexyNqwYl4Pgk5C/ofdwJyOUk+wEL0Ma/Y4s1+ySCCEEgpWajgpvRUPJNDjVuALxA88UU7hI9/9sORgHxg39MzaXPdGpq3QAbK+G9B+5m9rzS2NIOV+834HIf6EbYmZs76JiaqqtEiQDbrp2Kkc/7ATmCEtpzKnyayOcA/cLclVnQd//+myordD2NSF+devhzY/qkMv8+2PZnACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB6094.namprd11.prod.outlook.com
 (2603:10b6:8:ab::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 21:54:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Thu, 21 Jul
 2022 21:54:49 +0000
Date:   Thu, 21 Jul 2022 14:54:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <loongarch@lists.linux.dev>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: Re: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Message-ID: <62d9cb2579602_1f553629442@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220704112526.2492342-4-chenhuacai@loongson.cn>
 <20220705092937.GA552@willie-the-truck>
 <CAAhV-H5r8HDaxt8fkO97in5-eH8X9gokVNervmUWn6km4S0e-w@mail.gmail.com>
 <20220706161736.GC3204@willie-the-truck>
 <CAAhV-H7uY_KiLJRRjj4+8mewcWbuhvC=zDp5VAs03=BLdSMKLw@mail.gmail.com>
 <CAAhV-H6EziBQ=3SveRvaPxHfbsGpmYrhVHfuBkpLJXn-t-uTZA@mail.gmail.com>
 <4216f48f-fdf1-ec1e-b963-6f7fe6ba0f63@redhat.com>
 <CAAhV-H5chctqBLayAJZOker_Li1db2NTcT9qwMCUYK44tBHVSg@mail.gmail.com>
 <20220721095527.GB17088@willie-the-truck>
 <CAAhV-H5LednXDPzPm80f9N-MfcT1B+SThO+ngNHS1365dGxk4A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5LednXDPzPm80f9N-MfcT1B+SThO+ngNHS1365dGxk4A@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ecbeb4-aae4-46c1-98cc-08da6b63a225
X-MS-TrafficTypeDiagnostic: DM4PR11MB6094:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63rjPDj2uVgHWcsinCAyxe4KdmvsmYD2GakQKLpHClXd+KXdBPuQi1EMLbLmKxEL4Hm0Oj3EytzcJ/f1sd0hXu5aFNJHVs9VCdMMg5IFevvt1wGbQA+omE582qX5yn18Eqd0s70CXhcYvvxhZctWcrqTC22HpcAce59vJc7+ynWWcAzg1QjekCHMoK/zplsaw5BzhIdVRQFF5Kje8nFH2uK7Gb1vCn5TYuml02xfIUfBhlg38bxaBtTkUw9nbKFmscWQIcSmsx4rWwadRh/3rc4qF4UzZGyh1VTMIMvbkesso6xN5vR2SV3IdLnYZ8GWbxyDszxjT+ddgUtv0koO6yAbLLHSykHpi71873XId2+mFK3AW80mfuBegRB1/jUuhDRtFXeGIgzHNSxHu97WLA5Aj5/xtFrKTcMd6gCPpRiksO8Z0lwgVUnIXm7hGACUEA5o4cCk77HLaqZm6DoEskthfbx3FmesGJ70qfWkx95AGd+SLXE3qy+pvmekZBWrMZp8P92jjp2PkT74xO9xATMykyqls31hNG5SEL8LZ5Kh3ZB019qtD92Ti6wY/SkTMxEaYLgFyAVOmwPvEztOOs9UdlTE3X8cYAucuwvtHt1U6qLoDtv/x/mK1kK6LShYZdmV+hBs8fvMd/bZMb41svfWQTBjBRzGBQAsj0jxg1wkMtUGAgNEY2jznvICPdu1LAEmSlT61JZQQhOA+LzNYqBQC80yrLmYGAWi0uF8EBzStVXqJ5goWQoEh+elZto0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(39860400002)(376002)(83380400001)(82960400001)(38100700002)(186003)(8936002)(7416002)(5660300002)(6512007)(6666004)(6486002)(9686003)(2906002)(478600001)(26005)(53546011)(6506007)(54906003)(316002)(4326008)(66476007)(41300700001)(86362001)(66946007)(110136005)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rCnJeLiDl0Ca8C0GFfxxbi/fLvewthsQ82aTWtQCbC15KbBKzuN50VArK8Cf?=
 =?us-ascii?Q?RE/6aYccU7Cc/wWFajmhVGDIvWIJCGQIaJ1BDhlLnmSrDHu5hu4f4ReyUeCO?=
 =?us-ascii?Q?lbFb+7BxAN3bieEer+n9aG3zPxDjxNiYqDs0yKmj7XYWQBT3u9pJCKiskpFI?=
 =?us-ascii?Q?fhG+2RJ7xrAQhl4fPAAwCgIjc3EEwDUBUdXavWi1R1DafZXGI2TmhpG4eOmR?=
 =?us-ascii?Q?0pzDGMhJhCHgCbuiad1EyaWpLJ/jE85W1dMHVhWl3DzFVd4uBPZYVTqv7S8x?=
 =?us-ascii?Q?lJ3zh3NV9peKMu1Tdpk4UpJj0i9kMcPZ7hS50Cheb9wFl4YkdSVNkgq8u8gh?=
 =?us-ascii?Q?reJc9MNSJnn/lqbFA3M2+Lm653eOcK9xtRafzVdQ7+SyzdfJwgD5W+LVp3NF?=
 =?us-ascii?Q?X/mVIfKDz6VqRMnIND36SQFu9nh3iTzWRCIV3+cSGLs0qxPimmqlYTcLC3ex?=
 =?us-ascii?Q?5FtU4wcH/oy13/JYxGC1BaioQOTkURtu7vAm0Z/CYVp5Ooq+HnPQFcaQfPd1?=
 =?us-ascii?Q?7IP00oYTL/Xj+NSmZhVar60N/lt8JSO3ry8AsUv1JpB3uvFfcCzMupkkno0V?=
 =?us-ascii?Q?nhXhnJUYdnaEamZFFGVl7qJbQwBRqShPE1R6Qh8g8Andk6ARVMrc76IO6oI9?=
 =?us-ascii?Q?i5tCpX9hUed+7JGTRgj6stzLmag/hRFm+KjuEEqvmRdDFAHfKjdgDlqYgspI?=
 =?us-ascii?Q?jdCXInrzOOYQG8g/gLPbrSjU4bo3k9d2x4EuS/iYfFtjyL4wZXRxzToTV0MN?=
 =?us-ascii?Q?XXLQ7u9FhtPvafweQ3x+KphPsdHCwl1m3Y8h+MOG1u9HmHo4R13zXa3Nct56?=
 =?us-ascii?Q?wvyO2t0mLlwOq4cxEEMtjg+8Wvcki2PocM8VT2jAuQyk3gE3x/SolkAnNREC?=
 =?us-ascii?Q?0gzxqqX8BPNESP/cu/mH05+oHcHIg1pOFliVzfC8eTQaZyKWeFKaNNG8uIjb?=
 =?us-ascii?Q?XMCvBig9yGa5lFndrkWT4Sgdp0zrDIBfz0azdJfLVkJHlB+6YWRst/mBkY6I?=
 =?us-ascii?Q?2cSi8imIvZDG3YZqMwUUy/baNVPepLvGZoNO63U960ZOvrzgLQARblQiqv4H?=
 =?us-ascii?Q?Ysr6rvGENb9myO9uRv35a3oMsbcjoaGsWM6iH1uhKhucJuGHy/sIeP+xTwcI?=
 =?us-ascii?Q?suwllDieJgT8fiMoELw4uzVYHRLV0/0JcuBoGR73cwSqpNZWgaLDW5e696r7?=
 =?us-ascii?Q?pmL+KP7zG6EBFygZgpLxUb2gXPWfipZ7/JVcbkkFY+lajI1RmMOcqp16jWYr?=
 =?us-ascii?Q?Uuty/HhHt943FbUoOd17bbsBiJL9e6TfSt4sK88nwOq3vOd/YH5j1Ys/G6R1?=
 =?us-ascii?Q?Egv+1QzvAZLEpdgO2WIy+slJyvZA9hKVl12GB/zvSOYQ2rJkyMVqBYnf9E+4?=
 =?us-ascii?Q?6Wt3jjSSZEz/nIn0WS77x1NdSBXXiMSCz1+KauhcbK9p/TswNtd0G0I7dmXc?=
 =?us-ascii?Q?Vo0S1xWlQPTb6ejxYaEBYP1B7RXG8fNYpIIt/HLhJrWw01APqShBxG5k2l2r?=
 =?us-ascii?Q?6b/TGFq+426K2UUF7jqjHsLsAD2yfFBFdTCEcygoP458xFJaV1Y7J1Mn2zqA?=
 =?us-ascii?Q?XddQ4F3fCkVLtdNND0QKf+TY+H1ZEvhe5KzC/F+7yyqj7g/XNmqdsxvaNtuD?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ecbeb4-aae4-46c1-98cc-08da6b63a225
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 21:54:49.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSENEHHWf47BomNAoyfom+mihJqIqKruskYjzbC5teHq/nNiSFrG3DFt5r6xYCS4gzIx40wg/gesA87u/SyPkAh63fzop0aEkHjLhBt5/l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Huacai Chen wrote:
> Hi, Will,
> 
> On Thu, Jul 21, 2022 at 5:55 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jul 21, 2022 at 10:08:10AM +0800, Huacai Chen wrote:
> > > On Wed, Jul 20, 2022 at 5:34 PM David Hildenbrand <david@redhat.com> wrote:
> > > > On 14.07.22 14:34, Huacai Chen wrote:
> > > > > On Fri, Jul 8, 2022 at 5:47 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > >> On Thu, Jul 7, 2022 at 12:17 AM Will Deacon <will@kernel.org> wrote:
> > > > >>> On Tue, Jul 05, 2022 at 09:07:59PM +0800, Huacai Chen wrote:
> > > > >>>> On Tue, Jul 5, 2022 at 5:29 PM Will Deacon <will@kernel.org> wrote:
> > > > >>>>> On Mon, Jul 04, 2022 at 07:25:25PM +0800, Huacai Chen wrote:
> > > > >>>>>> +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > > > >>>>>> +                                      int node, struct vmem_altmap *altmap)
> > > > >>>>>> +{
> > > > >>>>>> +     unsigned long addr;
> > > > >>>>>> +     unsigned long next;
> > > > >>>>>> +     pgd_t *pgd;
> > > > >>>>>> +     p4d_t *p4d;
> > > > >>>>>> +     pud_t *pud;
> > > > >>>>>> +     pmd_t *pmd;
> > > > >>>>>> +
> > > > >>>>>> +     for (addr = start; addr < end; addr = next) {
> > > > >>>>>> +             next = pmd_addr_end(addr, end);
> > > > >>>>>> +
> > > > >>>>>> +             pgd = vmemmap_pgd_populate(addr, node);
> > > > >>>>>> +             if (!pgd)
> > > > >>>>>> +                     return -ENOMEM;
> > > > >>>>>> +
> > > > >>>>>> +             p4d = vmemmap_p4d_populate(pgd, addr, node);
> > > > >>>>>> +             if (!p4d)
> > > > >>>>>> +                     return -ENOMEM;
> > > > >>>>>> +
> > > > >>>>>> +             pud = vmemmap_pud_populate(p4d, addr, node);
> > > > >>>>>> +             if (!pud)
> > > > >>>>>> +                     return -ENOMEM;
> > > > >>>>>> +
> > > > >>>>>> +             pmd = pmd_offset(pud, addr);
> > > > >>>>>> +             if (pmd_none(READ_ONCE(*pmd))) {
> > > > >>>>>> +                     void *p;
> > > > >>>>>> +
> > > > >>>>>> +                     p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> > > > >>>>>> +                     if (p) {
> > > > >>>>>> +                             vmemmap_set_pmd(pmd, p, node, addr, next);
> > > > >>>>>> +                             continue;
> > > > >>>>>> +                     } else if (altmap)
> > > > >>>>>> +                             return -ENOMEM; /* no fallback */
> > > > >>>>>
> > > > >>>>> Why do you return -ENOMEM if 'altmap' here? That seems to be different to
> > > > >>>>> what we currently have on arm64 and it's not clear to me why we're happy
> > > > >>>>> with an altmap for the pmd case, but not for the pte case.
> > > > >>>> The generic version is the same as X86. It seems that ARM64 always
> > > > >>>> fallback whether there is an altmap, but X86 only fallback in the no
> > > > >>>> altmap case. I don't know the reason of X86, can Dan Williams give
> > > > >>>> some explaination?
> > > > >>>
> > > > >>> Right, I think we need to understand the new behaviour here before we adopt
> > > > >>> it on arm64.
> > > > >> Hi, Dan,
> > > > >> Could you please tell us the reason? Thanks.
> > > > >>
> > > > >> And Sudarshan,
> > > > >> You are the author of adding a fallback mechanism to ARM64,  do you
> > > > >> know why ARM64 is different from X86 (only fallback in no altmap
> > > > >> case)?
> > > >
> > > > I think that's a purely theoretical issue: I assume that in any case we
> > > > care about, the altmap should be reasonably sized and aligned such that
> > > > this will always succeed.
> > > >
> > > > To me it even sounds like the best idea to *consistently* fail if there
> > > > is no more space in the altmap, even if we'd have to fallback to PTE
> > > > (again, highly unlikely that this is relevant in practice). Could
> > > > indicate an altmap-size configuration issue.
> > >
> > > Does David's explanation make things clear? Moreover, I think Dan's
> > > dedicated comments "no fallback" implies that his design is carefully
> > > considered. So I think the generic version using the X86 logic is just
> > > OK.
> >
> > I think the comment isn't worth the metaphorical paper that it's written
> > on! If you can bulk it up a bit based on David's reasoning, then that would
> > help. But yes, I'm happy with the code now, thanks both.
> OK, I will add a detailed comment here.

Apologies for coming late to the party here, original ping came while I
was on vacation and I only just now noticed the direct questions. All
resolved now or is a question still pending?
