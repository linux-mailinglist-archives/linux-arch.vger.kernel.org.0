Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5079B325
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 01:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjIKVF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbjIKRqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 13:46:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD758CC;
        Mon, 11 Sep 2023 10:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlzEEo1SQQUNINSRaM0wyBO3v3NIGHpCoAnwMjrFRJctvXb4NyAYS+237YzEyDd5uStb9d85n2RpXwMdTqeGtnA3kM45L7PCGS3wGqssyNgCMISMWBWbe09oiSFq1hNcOZDETIQm06eo6GUW2k+PkrHr28TXGg965TTZ33HaWr1EQiX64zNm5Xcj84ti6KYKE7KULu9OidRgbZIcR/aA69b8oIYoNfWL5gg6Nqnk/0JbaLfcdfi7FQV5AGM3S6dWF7v2115C7kYnI/gNZ0UgmNIkkPzofCngpmpSrNvdjZ2vxE+XNpda6rCjzmolPfTxiU6FjKBLjUoaAI6vE438KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGg8/0LRoGgDU8yG4pUYzvvsPREN8d2mnBUWNiTEbQY=;
 b=P7sw0hfDBr9DpPUKwuan59jbRykdMVwBJ0uCI9IsbRK+3YFrOnw5ZQnWgOKSXtt53m3KYVgdd1iMFv7f/RcqU4hEdqpTvpZjkjpXnGkpNVaSNkW/hv0HmK+JSXuOjph5GQWcU8sxZAaWtiAVPPNgczLHL4/yoSPXOXWYHDE8CYMrLJKW9snI1MWCryOvy/0EnA85NkuSnwnrj+lqZ6NvAbGkIkzgcIG3d0xRlyzgW2HmnjHxqen8unuMiUwCocNpMZy7PZwNsgqSIG8aYOe+NP6j/kXjG+h7OGc7dQt+YyLAzCa13i+DdTVUt7pDh648gl2ETYc+zP202P4owzskxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGg8/0LRoGgDU8yG4pUYzvvsPREN8d2mnBUWNiTEbQY=;
 b=Nsnh4gJhjhMyaVCv700fyfw05D+RXIpdOzn1nX44NgCQjzFI9/EEju+3cQFu9l4+Vu2yRwj+9Y8kEgYxf+78kOJugRlMxQRXh9YlUHoWOprZ8R3234okeffIUptZrluWjbzbI2YARpBZr40t5QW4MvdcGyE5vNh2cgIa2XTanWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6695.namprd17.prod.outlook.com (2603:10b6:208:3d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Mon, 11 Sep
 2023 17:46:05 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Mon, 11 Sep 2023
 17:46:04 +0000
Date:   Sun, 10 Sep 2023 11:01:35 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZP3aT5/x72/q8JEP@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
 <ZPrRcJCjRBvJ9c3N@memverge.com>
 <2fe03345-01a2-4cfe-9648-ae088493d1af@app.fastmail.com>
 <ZP28D8dZXz3+4s9v@memverge.com>
 <e80f9c6f-d194-41c7-bdb5-e6a78751f543@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80f9c6f-d194-41c7-bdb5-e6a78751f543@app.fastmail.com>
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: f915167e-137d-4ce2-8b64-08dbb2eef855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uwk4y4q2ZzJl3PuAzD6CvsBbBD0DTW02neicBzXYfVTFqslV5/wwrRsEv7U4AtlNCjtIMPV3Qyp8kuDvy8f8XHpOKAPQSXTrep2UdjK/bNl8+QxggVxEOfYP19rxQyOKyswTXCXJHSVeyD0OUls0yUFgQtlhRT5FlKCJ4BF4voB8TPoChHOR1LLzGZoxxiM9u4IelWS81xLXmyLYVLvypYVUnG5wyFd9eZS88Ixb4Ofja5f5j+jBsbLJTEsDTvm8iQF8+bv1A7XU6aKTFO+b+cEAwmjrb4oUOJ89a7YXyo+y9wBQDkPLa9hu/Brrfix9zOafnnTUFshmxy6rQQa012BXGoPFjmMLJwmwUIerx4AhjxvhlJOaR5YFOzyEUVypa5v1ZS+NvqQavmQtgnO4tbZZ/gYFnzTOQaS97Eml+E2SuI4bivR0MdSg3mKSSA0NlwCBgU9n9ouo0Q4Rz5s/1s7k+xszhfATjEBWb2MhD3qw5JXSXZa8/UJs3VGP2inm/jyfPYne4dkDA7JkG9/brlqTuIMe2GQ/QlQu6tBccu2YOOz6846eA2bKVPiOJ0rG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39850400004)(376002)(346002)(186009)(451199024)(1800799009)(41300700001)(6916009)(316002)(7416002)(26005)(8936002)(66556008)(44832011)(2906002)(8676002)(66946007)(4326008)(66476007)(54906003)(5660300002)(478600001)(6666004)(6486002)(6506007)(6512007)(36756003)(2616005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w83mbD8gWSREUDNn67MVgoYj51YWwpIvn4Ogkrs8wD9lBwAny+S7Ej4/zdqu?=
 =?us-ascii?Q?HQZOQWU89tODNjuqC6+v3uvBjIbuhrTnR+1FdMjHSQgK3B5fML5OXbqaZqtQ?=
 =?us-ascii?Q?c2PCfxP23S580guv0lOvRxxaPXlvIA+S6q1wZlFCzn/h+oqZQ32tt3WzpHJy?=
 =?us-ascii?Q?ejrpDYmRn1p2qG3jrbABxsRHyFfKb7MVPgB2E916SSjBSGCbKZNrWLt+KMNi?=
 =?us-ascii?Q?fT7grD9/p2NYuEdr+GjIgmyViy96WyH16KMtwqoGjX0Var9TEvwl1Csp36hP?=
 =?us-ascii?Q?CCtl4osXbLUrCWo85MhyMrbm/onYrfcHQz9MYuCOEwnaq/G/jinVLQXCj+KD?=
 =?us-ascii?Q?2VcxentT4O4S00QQoqdmHJkN1Sn48gEC8d0Ks0jCQ14zMFVsLxLONuSgs+KH?=
 =?us-ascii?Q?QuDA3qN1riXyZmjZ8JzEDa0I1ijqM599/ds8h8SrBisiOw7A59LzULtK/8ON?=
 =?us-ascii?Q?61Dmt3ojgigtx+3DRnGj5B6Lj6AOA5udNXwl4BTHRZm+TIFkHXuP61Iqc+t1?=
 =?us-ascii?Q?tkyfrG5g5isEGC9znYYgZUCmKGQGS6JpCe7nSEXckMcb8D7Pdowg80VOS5xw?=
 =?us-ascii?Q?IrLBqtGO0aq59Ev4rN0VYRLDLxmfb4JmXVR/Z2oVBjsSs4WYwchNRgTdz0B5?=
 =?us-ascii?Q?EEx6KnliD3ZvWO1tdr3YS9YOgFO0gdSqCP0qpahDToYuqNi3W5A2lsieNaoh?=
 =?us-ascii?Q?gOOnVPXLdgvrd9cFyKnXGRt16M5whKwAH+W35GOE6fDxpNRV8YwnFoxbxSUh?=
 =?us-ascii?Q?BFQksh3jE3+3s42eEYJ6LyAoTxnf7hNO70qSxN0K2KzDkTz50p/Hg6uFHiXv?=
 =?us-ascii?Q?9Fc14pq6+1mJ5LAdTvxZVNNgpxKYzzAkXYjigpNeN+ZQwIpPI5dn2O7cATVs?=
 =?us-ascii?Q?wgNHgAIL0kE39iebtaeyl4UuMPxrTpoLrVKvMrGAEbPkArtPwli7SjCIgIiv?=
 =?us-ascii?Q?FiqzHbWe6G/yqRSV+kIgAFtcROE7iuCrm1ZyvRsH94MQ/u7Ig8X47PJ2WqSp?=
 =?us-ascii?Q?qscTZpUQi9Wv6zfokojzxbdBu46enwkpPCuRn6S7mhZ2kEVttCDMSsblQPg+?=
 =?us-ascii?Q?ZBza/4aML/LTyV4/VOZAMCQCaY7JRlNkNK+gQXjirp+2fdjZL1szuGNcl5v+?=
 =?us-ascii?Q?P7CZKSPwX+5DqcgkP5WCzz1Zw0rgA1GCzRTiCyIc9TFm7ZCvaRBM0FUAABIZ?=
 =?us-ascii?Q?JGiuagAujAdn/j83zyBzF1EjsKwuZ+ESa2s9v6iWYYzkmyiEOeknHYk75dLU?=
 =?us-ascii?Q?50N3nx32YfCXgv/Th44XtOle1sZFm98+YOVTJscnpMhZ6wCNBhvmi2aIYxc4?=
 =?us-ascii?Q?EeN5K8doHk3dWnwHasCT6ygmnJ/7jAHO8GRTnZVFAG8YJq0JypwH23rbfw8S?=
 =?us-ascii?Q?HODQU823+UTLl52ywL8zuWg+7xNFW9hw+JT4UQGvVCwnh8Bo4n2nA6XmpQ9i?=
 =?us-ascii?Q?Wped8qOf0/2f0InpXw6JspxnImXcVvhNbQ/eYj2g0STQCikQZyHrpG+UaNYe?=
 =?us-ascii?Q?S8T1uO/JeQrIdibhbSj4JKygR4jYmiZa1IMyJCki1qJvK6eqXXeMyd5DRfj8?=
 =?us-ascii?Q?CgDkAbF0YQo5uPEVYoYCVkCPGZU9rLgK7uCEBHcsp5kTgRe22FF7c/TxrzBy?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f915167e-137d-4ce2-8b64-08dbb2eef855
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:46:04.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDvtOR4VIM5dBTql48CgO7Kko5sbdD6/MdI0iCvBIRF2LL1V37/DOhDwDOogAkSLKsdXYfZicILnn89MmB+NHVs58s95thdYFFkmkPgGjtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6695
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 07:26:45PM +0200, Arnd Bergmann wrote:
> On Sun, Sep 10, 2023, at 14:52, Gregory Price wrote:
> > I'll clean up the current implementation for what I have on a v2 of an
> > RFC, and then look at adding some pull-ahead patches to fix both
> > move_pages and move_phys_pages for compat processes.  Might take me a
> > bit, I've only done compat work once before and I remember it being
> > annoying to get right.
> 
> I think what you want is roughly this (untested):
> 
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2159,6 +2159,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>                          const int __user *nodes,
>                          int __user *status, int flags)
>  {
> +       struct compat_uptr_t __user *compat_pages = (void __user *)pages;
>         int current_node = NUMA_NO_NODE;
>         LIST_HEAD(pagelist);
>         int start, i;
> @@ -2171,8 +2172,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>                 int node;
>  
>                 err = -EFAULT;
> -               if (get_user(p, pages + i))
> -                       goto out_flush;
> +               if (in_compat_syscall() {
> +                       compat_uptr_t cp;
> +
> +                       if (get_user(cp, compat_pages + i))
> +                               goto out_flush;
> +
> +                       p = compat_ptr(cp);
> +               } else {
> +                       if (get_user(p, pages + i))
> +                               goto out_flush;
> +               }
>                 if (get_user(node, nodes + i))
>                         goto out_flush;
>  
> alternatively you could use the get_compat_pages_array()
> helper that is already used in the do_pages_stat()
> function.
> 

Appreciated, i'll give it a hack before i submit V2.

Just to be clear, it sounds like you want move_pages to be converted
from (const __user * __user *pages) to (const __u64 __user *pages) as
well, correct?  That seems like a fairly trivial change.

> 
> >
> > This only requires plumbing new 2 flags through do_pages_move, and no
> > new user-exposed types or information.
> >
> > Is there an ick-factor with the idea of adding the following?
> >
> > MPOL_MF_PHYS_ADDR : Treat page migration addresses as physical
> > MPOL_MF_PFN : Treat page migration addresses as PFNs
> 
> I would strongly prefer supporting only one of the two, and
> a 64-bit physical address seems like the logical choice here.
> 
> I agree that this doesn't introduce any additional risk for rowhammer
> attacks, but it seems slightly more logical to me to use CAP_SYS_ADMIN
> if that is what the other interfaces use that handle physical addresses
> and may leak address information.
> 
>      Arnd

Fair enough, I'll swap to ADMIN and limit to phys_addr.

I suppose I could add /sys/kernel/mm/page_size accessible only by root
for the same purpose, so that PFNs from idle and such can be useful.

I don't know of another way for userland to determine the shift.

~Gregory
