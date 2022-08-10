Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8547F58F3D3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiHJVbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 17:30:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6648E33A17;
        Wed, 10 Aug 2022 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660167058; x=1691703058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1peyvjiEsf9ZFyiZPMpRTR9IoM1PbiZJSmkAB8bb560=;
  b=khVtMzwRxMO0W9D4t3RJ362o6E555HIqUw5RBJ1iDrAdDqupJe0puwiX
   /Se3jpmUqkwgqd+bZdH7PN/F8c1aJMlcX13M3SxnVVCYL9MsSzZ9UTela
   f14lwUW14IHc0M/IAWAaogsym0iC5hIguTaXoUQ+G799mdFuZi5hlgHrE
   8kakjcFDg5ZcAtgEFMZnID6RIq2La7du4cgsAENpohOF2jTkN8W7p7Wd5
   5iGeYZNP3cM/h7uvqnX/in1Db/2ZwV9OO4fB06G/bhn/H1bPEIt/XkePX
   B4L8DE6pyzFXs4vd81NTPTB/Z08qXKYHe3zS6bGUCy4rg4JmURy+UZ8Vo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="278138391"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="278138391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="633941931"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2022 14:30:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 14:30:57 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 14:30:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 14:30:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 10 Aug 2022 14:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbgtAX+g6ivFvagX27W9ooLF4r+edDVVKeLKSOBmXwfamDjZtBfg107zcMXHd/Gjy7HOweodRkYsBqg0XV+46Sl4XdOsSHH/IyDq6lp/19X7xBG9t9UVo/2YVsjtAu5rpyCyoStd6y7veFgwbNRfcEVsvxXgQLe+ZLD/IXwdSCYrg+AWkXwI+2WD7JD9soyKYadvjxDUtkXjqL4h6oM6jzDe9KxaibT0smjOLB4Wcr2EDYi6uEZ5VNW1yvX/KynVomxiVXJi/bcncde5Gn5q6Nay6KqKbb1zaEvl/3OPwnkrISfhhmgvClWCGjFLgjDaMby7JxAzFR3Jj+BiIWnKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IFlZymuEqdtvBGIkbSDLTwPinBVAS2M3TbevIxWlhg=;
 b=d3jrnMymlx8AQaYxYcJI6PZrNEZxXqNDwgQ80MNUhLhKPNIGg7VRpD/mtApLK1ZY39TjCV9+vWLvKopfD45qqNQPnSgdxNTEU+SptGgKOvIHa49tz1y8Pzvp4mBQ+Jzzk/ju99SdM9ZpVB706DbLL4I48NGVkCPgJaJn23MUPD2+HWsFrMFZa3GFTaXiImP7krk5f7m4ta9AteOWq68jkr3VUz4cjxWyW1V1Z+4pYWa7W0YrBSahYH1uuPi3WlkxZrG9Cq7DA7dg6Q61kxjN5uV2hHFU55fG0Qf5Grkmbomx5MvT35qjbD/wqMMjWXX63uis4APJXBGfLxDnrBcxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR11MB1872.namprd11.prod.outlook.com
 (2603:10b6:300:110::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 21:30:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.022; Wed, 10 Aug 2022
 21:30:54 +0000
Date:   Wed, 10 Aug 2022 14:30:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <a.manzanares@samsung.com>, <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 10/15] x86: add an arch helper function to invalidate
 all cache for nvdimm
Message-ID: <62f4238b5ce8a_3ce6829447@dwillia2-xfh.jf.intel.com.notmuch>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220810211337.ha27cl24splm4wjh@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220810211337.ha27cl24splm4wjh@offworld>
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ccc7e5-c8f2-4dfe-7bcf-08da7b179ae7
X-MS-TrafficTypeDiagnostic: MWHPR11MB1872:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrru1JdwCBZ+iZLlJRSakSdmfPmnLg5YBdgCUPDNTpZszag8QvdqX3/vLlSW9dL+UKUCHZyq9/HODFZDyMTviHy1pIcZQC9SwgLITxjngu8yS8aj7cpwK/Vd/ZsiCWhpB4CXug5T+RW7P+WblvuT0fqIpBtDUsBBnfcUuS585b6SnT6ZDY3NAcQ6iC4//cQnz3uGY0lZCqlLjZC0079v3jz6NQpUCeHOC8A755Cj+P4xCEt7JPH+f0F72uCZuBrgjrmQZgjVeOpDsk5X8mB0dhIEJvrHxMC6XWZmcpsHIXnxnkUJm3U4TSdSeu4H3NC0gz3v660j1ohgm32fp4d88IjCdbbibKFajPNliw7ThaGAxkfHv8MOY9aULU6Q1rz1plNyIEJnrIjMNvW+8KVIvI9xdxFc1IHGaooL9m5zUxkbi89FXbscHn02eUolmAkFphXFj4+M5yLXAFgxOeZw+bnihgFnN2xRY5YQlK404Ocr3mPS4hH9XMryq5tl/wMBLrKgRdGO7kf9u9fcm4i//r2t/3QDKZeZD7ukqQ14+FEpOaxiZjVzP/7feYk+BwAJ1TJXkyTRlJv934MjHK/3CmzmaYpOjIghokuy5q5GmvwonSTjNldNAPf9q47m6hHF8XU4dNoGu7tKMkx4XKR6pQVm4/PpHT7hxr2ZF3U8xkCMI2tKgvNTos6bWFPmsjtf68ZK1asHTtx3hXcm1GkpFjY/zVTU8XcPdpo31bpd43nO3pRhm6A4T9guI3ekDxLH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(376002)(136003)(83380400001)(186003)(82960400001)(4326008)(8676002)(66556008)(66476007)(316002)(5660300002)(54906003)(66946007)(8936002)(7416002)(110136005)(478600001)(6506007)(9686003)(6512007)(6666004)(6486002)(86362001)(26005)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75Y9GBH2Nyj3/3XCxRp5uQ3yZ6x1smG97hmKk68dq4bcdfa/ZxlNgpdIj2AS?=
 =?us-ascii?Q?bf6+BouDbudobafJKy4cHXrPyErZ1jVd3Aku8LtZ60FuKcK/OT5jQga4HsRB?=
 =?us-ascii?Q?7ZY9iSu108P01D/bCNASlw5UsSsX4fCqdJsCrgEUt4iDEmgkC6912a/YVsPP?=
 =?us-ascii?Q?Lpz2DGTvw3LKtphBgixX5cbRmd3rcIA7L/DOMweSXxIFIvhmcpdaOKset1BN?=
 =?us-ascii?Q?vNPs2mrHreoY3iiO9grL3kR6Acb/Vq6bCzVlwfWvcLKKkzgNVEIuz40nqysp?=
 =?us-ascii?Q?Kbxc5wZ4zs3ZPX7Rx01zem6dUhqwCzJHiv23WT3TMJMmwVPzAfnhzgVFpeKf?=
 =?us-ascii?Q?P6QaNJjB0XEFG8djGnWvlQmc3eNBSlJxSPChxRdoAVlCZE9p4oA0DE30W9i0?=
 =?us-ascii?Q?pRL8jAIxyAIv7i8CR5qDQPy5F3R1DzoSoqqpjZQpbYMblUgjzQJ/34YlRdPL?=
 =?us-ascii?Q?38MzmaPr5dUXmmSBoM1CJhiHgsa7bDnL/PsGHVYL5ctgpKe15OX0n4mkeo/4?=
 =?us-ascii?Q?S6CadBt7mrogMPsbDSjLtOuXJD8U8WLxyIHASn7iHALMh2RQELs2EM7fY/De?=
 =?us-ascii?Q?yUjEVsofQ28YpPoVXg9inpJHzj9i+2wkRL0ZwbSXCOEUzoTIOEFwk92mE9UM?=
 =?us-ascii?Q?vLljf0nEA2F4Qd+4YCmcskEqy0ymvM6tNwbqM379AARh6toHgOzVAEgJyAFy?=
 =?us-ascii?Q?ZMKSjT18Ucu6EdTHCLB81YMZPyhR2QXGrxwHx//XkZIE0ZDklM/4g6obO7Lp?=
 =?us-ascii?Q?xLheDfDgI6njFQ1ecXeNDmxeYESRU/nIagXRkgVMtI0ZmYk5G5u9M/MaHVfA?=
 =?us-ascii?Q?Bj498Gm8ie7nPWWlm7x47SZkve7v+3VHNEGIJubQU99KRQl6mncX3xHj8WoM?=
 =?us-ascii?Q?uExSwuFuvlFeiTX7BMIcJKALTf1ahPcLpOdzgUuHYW1VNosQOEB5TKJglB0w?=
 =?us-ascii?Q?S6h+Ss08xhBfbE8xrZxnprRsWaPtoN9qOcSKf1EYcaYQO7+jCVXuyU9r3R8i?=
 =?us-ascii?Q?1i9x9kji6RhTvdnmb2CUZHsCpoHgh2kzuxaunPDQ57s6FSc2tZQEYOzxz/0n?=
 =?us-ascii?Q?3mxcZStm7zuMr1ewmeXziSK3+fuxZs4TPz6ZPu1yx3b+/vmreLOYdbx1vpyI?=
 =?us-ascii?Q?6aP+7NJHA4BNU4XOMcRl360z/MYP/Ye/31HJpZjfFvY6y1KmU1HaE8NKjbfq?=
 =?us-ascii?Q?I7OPKp9K4RENN6CDylWFsPjjx/Rgfx/DAoHpCJFPMOrGCdWdGyJx4PXdsWyO?=
 =?us-ascii?Q?PR1l9TvwiWrhue+UBNFkEH7xvpXs2SwTJMBd1tnIaGZDaxBHM9tsVVJZU4iD?=
 =?us-ascii?Q?SI33CmZdgnj4adImGdiFKZKTmKteoq8aeK1G61hIFlQc7JC7tyhsTxOJCeOR?=
 =?us-ascii?Q?bm4IHDrjr4aWVtTaJRkKK6qvYUqDiFca0O4arjwjhduuWQttgYhynifxoQT1?=
 =?us-ascii?Q?h1IhpIbfHr6Gp1cln6K0OcqaOvNe26/MI3aQcIre2wkMSPX1gGofCpuaVCNB?=
 =?us-ascii?Q?Lfcva5cAS097wfFDV9Vd5UGIscOu3xMI+UcbsHCAfZWYoiunQzez7EPKrAWK?=
 =?us-ascii?Q?YJMWrOgITN6KQ00owLkHsEZFL/PzD/oknR10qov7zdetztAZKy8LMeLOIWjT?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ccc7e5-c8f2-4dfe-7bcf-08da7b179ae7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 21:30:54.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOdRR0o5cNyx2s/Or3uHFXjAhfWy8H1QO6KSOvdqW15JE52HrhKvdLe7QvoKnOKtCnMfG2DuDMkLSmI0ndijuk/2uL5zfwNn2ZVEHZg0edI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 10 Aug 2022, Dan Williams wrote:
> 
> >I expect the interface would not be in the "flush_cache_" namespace
> >since those functions are explicitly for virtually tagged caches that
> >need maintenance on TLB operations that change the VA to PA association.
> >In this case the cache needs maintenance because the data at the PA
> >changes. That also means that putting it in the "nvdimm_" namespace is
> >also wrong because there are provisions in the CXL spec where volatile
> >memory ranges can also change contents at a given PA, for example caches
> >might need to be invalidated if software resets the device, but not the
> >platform.
> >
> >Something like:
> >
> >    region_cache_flush(resource_size_t base, resource_size_t n, bool nowait)
> >
> >...where internally that function can decide if it can rely on an
> >instruction like wbinvd, use set / way based flushing (if set / way
> >maintenance can be made to work which sounds like no for arm64), or map
> >into VA space and loop. If it needs to fall back to that VA-based loop
> >it might be the case that the caller would want to just fail the
> >security op rather than suffer the loop latency.
> 
> Yep, I was actually prototyping something similar, but want to still
> reuse cacheflush.h machinery and just introduce cache_flush_region()
> or whatever name, which returns any error. So all the logic would
> just be per-arch, where x86 will do the wbinv and return 0, and arm64
> can just do -EINVAL until VA-based is no longer the only way.

cache_flush_region() works for me, but I wonder if there should be a
cache_flush_region_capable() call to shut off dependent code early
rather than discovering it at runtime? For example, even archs like x86,
that have wbinvd, have scenarios where wbinvd is prohibited, or painful.
TDX, and virtualization in general, comes to mind.
