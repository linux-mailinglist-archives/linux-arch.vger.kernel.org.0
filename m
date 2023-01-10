Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54A663993
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 07:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjAJG4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 01:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbjAJGzy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 01:55:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465362A0;
        Mon,  9 Jan 2023 22:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673333750; x=1704869750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hmfhjsQlj7udYi6d+7bjeWvlM1wFc+RS7Mf6Hj9PsLQ=;
  b=CXbYL+yGiib+nukvQLi7jq6A6fWXmKnXf5OhAmWUamRtDcvPd+pI9M8p
   r4llIbKNndhH8dy1b1guNoy12bP6hyvfbrsUbMIFe66zvL4uG/HclOQGH
   mNkJjFZkAeiSUZDzveF8DstUEIsj3Y1z9RuRfrZZbMBa8j1lNeC9ZlJ6c
   yTLolIkI0pKUGROxYxj0wJsnhOhEQNG/23lUDBruk88lvEJD1eE85yZnb
   mNDau1NExcdH3oM1rzCNWOjqe8USoWVX5P2wRROqkbIMj91W776XyKEQl
   Gc4e6+h9/uw2F7s6j/kaxv5Eszx+Y9hh+p1sjwjPwsFabFsdEOhABXaOS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321778083"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321778083"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="650270038"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="650270038"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2023 22:55:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 22:55:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 22:55:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 22:55:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 22:55:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9zME3Nut8uVO6edv6rzuMJKGzcIum6yGlL2+9KEi+BPIoj24aY52PaAGWTw8MnRE3o+pwfH+pEI/OHO1EBxGIL86R7fd7E/ADlbyeMVyqW1SV0VuzEBJ1MXCUYsUeHDi4sv/m2aJUfa5qAvp+gh5Mfu1zMqwuY/FBCIb7x5pkQmak32k6HNEsNtcUgPbw6Ql9ufnU4TsIbZ4YBFkTrRoNnLz8b6I1y8Kq/Yll2rshv5f94uHAiSJ5cxWJdoy0gMOnoUjbNXs/HqHFhX//UNSJUj5XLWe8/Y2Y1AyonVBavDfbP65pqW9c1FZZIzC8IVluUOJnVm1XCPyj9821HgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnI0r66BeG3It/Dhen49KHYI3Sx0Ca/xILD5O28lqsM=;
 b=CgpBjZzw6gvXKW16syIr0DkrYWfK9dCB8UOVq8NfT/2bpyrF6fiAKY2y3jXKNoVKsHpCxlJUP/CF/V9B0UG7tXL4aGWcqFfgUapihpApD/UcjRbclxHenXbmmQWtU0tjW4Ml7rq3RQXIJi6E0LXREu6jSS/hlGR3ybg1ZaoBGM8YLMZWSp5C34VsEMsEMwOCAcMH02wLERlUIQwY0zYCnxXTDadpdNtNxhz4wVOCDrU8o4LgiV9LWhDPLQxaeyBBTGRQm+z1whvAv940MNQDXt685+6sTI3AZQurV+1bLrYf/qJn9FftB42dRQmeN14qho4evofYLQg2GWu6qW4esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB4834.namprd11.prod.outlook.com
 (2603:10b6:303:90::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 06:55:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 06:55:40 +0000
Date:   Mon, 9 Jan 2023 22:55:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Ilya Leoshkevich" <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
Message-ID: <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
 <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7z99mf1M5edxV4A@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7z99mf1M5edxV4A@kroah.com>
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: f05eecbb-8672-4d8b-23f1-08daf2d7af72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nh++SFBKeftvQ2/FnnWi7mpR1bpkJgcEejVvLIJ7mcqDbX3UuPNlrsR17QRWwA2HMEDg92QSB2QlXZBrcbP/hoSacqxzzm9xYsKw3Thbsf/TLF465WKnoBBsH42Z9i7JyzPe1fxltlN9MjzIZCw65oU6tllMX4a11X/f7l8w06Q1VOqL0dWyiTpxgLKbNhx9I30/YvdNCVdb1ewoD7WUMC1vwxob7yLRGC9Ij8sQaTMlwmrrJXTlapW0LkcxEaz7V9Pa3ki/cYEkbNBtu34TSCOYfVNOMf25WpwC74z1/Elouszc14K/XkpV0jLbmk24FPdkafcsiUJ2hpVLgxilIcDXdrw6Gpnf2ZVwf1Gq1KeriCbuJxE5PCIPQ6H1ptoZbHLrLaHZ80a3SXs/fAu2XXCbsk5VmYQ6/IOZe723gAo2Ha5k7ymuzeodXxw8X75hAjBAaL4mApAe3WwQ60Pzt/lZJU+H233qZd9CKio2Xe6/6shdNOT0mLe55H3ydfHMo09aDc5q8fVdfk3EU7tapylzfclVLuF4pi9ieKzUSb2z9hsvUgsRy9KvHlV5vGklueS34UX9EAZgQKXCy8Iot7XqV8tapWJKMgFJuvafy9c/h1bLukYLeJ3+P/YAaS5wbVf9ycjvL/tuMD9DN729fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(8936002)(2906002)(7406005)(5660300002)(41300700001)(7416002)(4326008)(8676002)(66556008)(316002)(66946007)(66476007)(54906003)(110136005)(26005)(9686003)(6512007)(38100700002)(86362001)(186003)(83380400001)(82960400001)(478600001)(6506007)(6486002)(53546011)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLeFWFhn3OlEz8eeCdKwFfSLgjocwh0KyLNzKsKhLSSW/CyMEg2fU4uI2JwN?=
 =?us-ascii?Q?UpS74KEyFOptuwkLjoESuzx/Wr0cgMjvZiqAyI7zayj5f1Ua3p/YRCyERzHx?=
 =?us-ascii?Q?K17cyQcX9OTLd+uxxYBjH1kdw0rwB2A84qCgStz6e63HuHchVDzZZU/FBfNG?=
 =?us-ascii?Q?8+46B6doq6rlpz+f1qA0cnRlsWkKWVq/JH7CR1xUfR90wEVBOOVGRLcNNgle?=
 =?us-ascii?Q?nL+sh6IRxxS1Tl5KAtI4hqVWbqqr1lwwz76AsAUy0ynpiqWpjd46ASko5dOT?=
 =?us-ascii?Q?aFrIj5cKWjH6G5JhMqIZzpEV18+8lC1fdJ0cyTpQ0RNF+gaZtjb6Mon2HrvM?=
 =?us-ascii?Q?IG1YLrfjkXKH8DNosGmZukPLFICvkOy+6VfKRn6k21hTICbBn5+KYDuXbxpa?=
 =?us-ascii?Q?vS6PNYSeezZkXczzwA2Rk2lWyTng9mh8XwQ7axkNjd+0bKHXSCegKxVtWcRR?=
 =?us-ascii?Q?HRTP/Xf/W4/g1ukwOaxzpYKnM7cuc9BWhxEZK6qFrkbFhcNu7hja+dNT/6rQ?=
 =?us-ascii?Q?B9NvHu9sPHX//aqVIV2Sst2GhUs6wEpDup1AeVPA5ljwcfuxqqChUp6IcKnF?=
 =?us-ascii?Q?eH3VplxQsw8GNFy3+rl1BxpG8TTByO6T34LjxTqibuGwkdV6M9kDBsRYt26W?=
 =?us-ascii?Q?Ml4lw4B99Og3Q6tB2DnABvmSBadJHSBp9WTIqEHvPGmOU+oJWpVXOYVMVYOL?=
 =?us-ascii?Q?W/qwPdqMsY5PBNnYXX3TFF2DfM/LRVI1AQwkr2PtGRYqNCmR2sM4BxkbdrOG?=
 =?us-ascii?Q?ulY0kwUEuXtciyPNolDlkQ81aR9pmjqvK2CXsnLI2QjdMHUUr77F+CMR+BYK?=
 =?us-ascii?Q?U4fhNf3qCiaPM6Ip3omqrOdgOX0o8BWrA6qDo6b5+wGvguswCqM2aTs0zwhD?=
 =?us-ascii?Q?X0Z3uNrl0arhLMh8+GUkPzYQwYDWzraH4pHEvjFSoOXcods3VmlP4nZmONN3?=
 =?us-ascii?Q?BXI1EEp0NirCmejoI5ekz+ObAemd1xTz1xiopXrJ3uodyqtuPfd4ZtMZeEEn?=
 =?us-ascii?Q?aXLuZspEx+5GH6qZ3x7dIlV+MhU4dbGkwy7mROyjY+GLH41UvxJZMUe2Om6y?=
 =?us-ascii?Q?CfGpZflae5AVlyrR+D3vlYD6j1LinG+QYdBunv1073xiZjz/+kTYlRgwZWjT?=
 =?us-ascii?Q?U1tFTwRIpN3AN+Xw1HFbdkjMGJzTk9oS/tcStrvDU+S6f0r0zCUNlhaHqvSp?=
 =?us-ascii?Q?mL1ZKnzvkAMiGncscjui3Ic43/JiHbvEJodTjCcwO4ZlLHBZbhIwyNFsLEfc?=
 =?us-ascii?Q?eqznAvABD7o71DcU/m1FzafdvCmauXK58J18vyxDvmWjfllqFqMdYIyWrxWr?=
 =?us-ascii?Q?o9tgUTTvb7ZuhZKStxzYN4FCb+24QU7UQ/b+qHQpgPEIhKFC7hmf9gdzaX/A?=
 =?us-ascii?Q?Wfl2018IXoNK0TmazpZXPWJh6H0JkbcMME/O4Yi47UTkhv5E/NbDEUG9x2BI?=
 =?us-ascii?Q?yolVRVhnibTNbQj+QuuWb2Y41lCIZ6Y4GbOR07HZqhXCXWTpVY53hbZVd1C6?=
 =?us-ascii?Q?ZwPG0p83Kb6qRqZ1OGwYz5wzJW48WlVdt0U0Aux96Ch9c8wvvgWueCIwekOS?=
 =?us-ascii?Q?ojVn8ostYP0RXVMYm4bpzp5hF+bFUy+U5YUyzmJr3hoFfmWT++BNb3vbnOSe?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f05eecbb-8672-4d8b-23f1-08daf2d7af72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 06:55:40.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtuDJa5a91CsPNClp9Lq5uQQf0lbI8cxoifLNJgmyR+Vist7ywkIub+uL46qYUdpe7Z8FukZPpZVY8b4GerqayZ17v6mW4KiQyAxL+BH69g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greg Kroah-Hartman wrote:
> On Mon, Jan 09, 2023 at 02:06:36PM -0800, Dan Williams wrote:
> > Alexander Potapenko wrote:
> > > On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Alexander Potapenko wrote:
> > > > > (+ Dan Williams)
> > > > > (resending with patch context included)
> > > > >
> > > > > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
> > > > > >
> > > > > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
> > > > > > >
> > > > > > > KMSAN adds extra metadata fields to struct page, so it does not fit into
> > > > > > > 64 bytes anymore.
> > > > > >
> > > > > > Does this somehow cause extra space being used in all kernel configs?
> > > > > > If not, it would be good to note this in the commit message.
> > > > > >
> > > > > I actually couldn't verify this on QEMU, because the driver never got loaded.
> > > > > Looks like this increases the amount of memory used by the nvdimm
> > > > > driver in all kernel configs that enable it (including those that
> > > > > don't use KMSAN), but I am not sure how much is that.
> > > > >
> > > > > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?
> > > >
> > > > Apologies I missed this several months ago. The answer is that this
> > > > causes everyone creating PMEM namespaces on v6.1+ to lose double the
> > > > capacity of their namespace even when not using KMSAN which is too
> > > > wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev:
> > > > increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced with
> > > > something like:
> > > >
> > > > diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> > > > index 79d93126453d..5693869b720b 100644
> > > > --- a/drivers/nvdimm/Kconfig
> > > > +++ b/drivers/nvdimm/Kconfig
> > > > @@ -63,6 +63,7 @@ config NVDIMM_PFN
> > > >         bool "PFN: Map persistent (device) memory"
> > > >         default LIBNVDIMM
> > > >         depends on ZONE_DEVICE
> > > > +       depends on !KMSAN
> > > >         select ND_CLAIM
> > > >         help
> > > >           Map persistent memory, i.e. advertise it to the memory
> > > >
> > > >
> > > > ...otherwise, what was the rationale for increasing this value? Were you
> > > > actually trying to use KMSAN for DAX pages?
> > > 
> > > I was just building the kernel with nvdimm driver and KMSAN enabled.
> > > Because KMSAN adds extra data to every struct page, it immediately hit
> > > the following assert:
> > > 
> > > drivers/nvdimm/pfn_devs.c:796:3: error: call to
> > > __compiletime_assert_330 declared with 'error' attribute: BUILD_BUG_ON
> > > fE
> > >                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
> > > 
> > > The comment before MAX_STRUCT_PAGE_SIZE declaration says "max struct
> > > page size independent of kernel config", but maybe we can afford
> > > making it dependent on CONFIG_KMSAN (and possibly other config options
> > > that increase struct page size)?
> > > 
> > > I don't mind disabling the driver under KMSAN, but having an extra
> > > ifdef to keep KMSAN support sounds reasonable, WDYT?
> > 
> > How about a module parameter to opt-in to the increased permanent
> > capacity loss?
> 
> Please no, this isn't the 1990's, we should never force users to keep
> track of new module parameters that you then have to support for
> forever.

Fair enough, premature enabling. If someone really wants this they can
find this thread in the archives and ask for another solution like
compile time override.

> 
> 
> > 
> > -- >8 --
> > >From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Thu, 5 Jan 2023 13:27:34 -0800
> > Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
> > 
> > Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> > 
> > ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> > potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
> > doubles the amount of capacity stolen from user addressable capacity for
> > everyone, regardless of whether they are using the debug option. Revert
> > that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> > allow for debug scenarios to proceed with creating debug sized page maps
> > with a new 'libnvdimm.page_struct_override' module parameter.
> > 
> > Note that this only applies to cases where the page map is permanent,
> > i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
> > create-namespace" terms). For the "--map=mem" case, since the allocation
> > is ephemeral for the lifespan of the namespace, there are no explicit
> > restriction. However, the implicit restriction, of having enough
> > available "System RAM" to store the page map for the typically large
> > pmem, still applies.
> > 
> > Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> > Cc: <stable@vger.kernel.org>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > ---
> >  drivers/nvdimm/nd.h       |  2 +-
> >  drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++-------------
> >  2 files changed, 31 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index 85ca5b4da3cf..ec5219680092 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
> >  		struct nd_namespace_common *ndns);
> >  #if IS_ENABLED(CONFIG_ND_CLAIM)
> >  /* max struct page size independent of kernel config */
> > -#define MAX_STRUCT_PAGE_SIZE 128
> > +#define MAX_STRUCT_PAGE_SIZE 64
> >  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
> >  #else
> >  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > index 61af072ac98f..978d63559c0e 100644
> > --- a/drivers/nvdimm/pfn_devs.c
> > +++ b/drivers/nvdimm/pfn_devs.c
> > @@ -13,6 +13,11 @@
> >  #include "pfn.h"
> >  #include "nd.h"
> >  
> > +static bool page_struct_override;
> > +module_param(page_struct_override, bool, 0644);
> > +MODULE_PARM_DESC(page_struct_override,
> > +		 "Force namespace creation in the presence of mm-debug.");
> 
> I can't figure out from this description what this is for so perhaps it
> should be either removed and made dynamic (if you know you want to debug
> the mm core, why not turn it on then?) or made more obvious what is
> happening?

I'll kill it and update the KMSAN Documentation that KMSAN has
interactions with the NVDIMM subsystem that may cause some namespaces to
fail to enable. That Documentation needs to be a part of this patch
regardless as that would be the default behavior of this module
parameter.

Unfortunately, it can not be dynamically enabled because the size of
'struct page' is unfortunately recorded in the metadata of the device.
Recall this is for supporting platform configurations where the capacity
of the persistent memory exceeds or consumes too much of System RAM.
Consider 4TB of PMEM consumes 64GB of space just for 'struct page'. So,
NVDIMM subsystem has a mode to store that page array in a reservation on
the PMEM device itself.

KMSAN mandates either that all namespaces all the time reserve the extra
capacity, or that those namespace cannot be mapped while KMSAN is
enabled.
