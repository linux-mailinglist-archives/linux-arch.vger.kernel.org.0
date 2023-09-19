Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0767A686D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjISP54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjISP5z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 11:57:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29297AC;
        Tue, 19 Sep 2023 08:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqeXH+mzrf2iafS9ejlEkPpJ0xTv0hgnQDupx9r9Jq14tDa8d59GdoK3hz2OzqyWDV9vJ+Ko07kcRHT7LQecAn4wJSiX8FzySep8Ki+OAslmdujW+adtLigTldimAUFt/oV5Mi4cZguXKHP3jIEAxxEWUCIxR1/kYXPdnSrnZa4ipasa5XnHTjRapu5N1D/dutW2yVjRM+999piI/7I6x7qUZRLKC7NTIIVTyHZt54sc06FOsLOkBWXxfRHSg8cThvml0MC+C/We3ko54UK+1NTr+jPhSBLCAVjBFGzLvb1Fbhx3iUhpkb4jF5uMtnecbA+w06igrWhLNXhuhEs/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbH6tPn/vPDdhaBvxg8RiAZqdUNviWBk/UVhRkyHdDc=;
 b=Xp5qDhlHssQizLtAEO/s5E8rSA4bP8NrJ7+1b/WyPum9FwQqSNG0J+ZuXtWjJpQ3+Ll3ImdjiaCgzxHINXwpKOm6yWn7S8PCQGY6acX7he+DRhocOzEq6AsLdk6rGBJwX5C4kZT5EL+Cdl00GUvH4Dp2oU5x2g9VmcbCcp985efjY2WZ8Rmw3SwrLrZ1MvryYz0JBjLFJN3gkhN691WbpK3NzXCuOxNY+v3bApaD7wmvBww256P18bcmoY1FpCZ/k2rm8vlxegMzwU9y/Eb7weWBkUAmV1i4eL9ksxDSuNHi1MKVPqpBoT1jp6hG4BfTxg1vD61Zb3YQTg7TC0y3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbH6tPn/vPDdhaBvxg8RiAZqdUNviWBk/UVhRkyHdDc=;
 b=Tia56GVp5hvqoOlXlec/UcR9sHdi0veMPYug2C8Q8fMorP9pp/zwLV1DlS7SKBvVdFFzNwgie1Vx2pYU68hBFZ/ZbVnWi1zNq0CuVdKI+Bl9o2L37LaVbpEJkjF3Ll+CZ9FuupEqevXRx0UYR7pAvTP4Vaj2qRLj9BkgdwS1yT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6522.namprd17.prod.outlook.com (2603:10b6:a03:4d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:57:42 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:57:42 +0000
Date:   Tue, 19 Sep 2023 11:57:34 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZQnE7i7tYOPnrL3w@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <877conxbhw.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877conxbhw.ffs@tglx>
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: e1712260-8337-4309-d44e-08dbb9292838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTwNc3znxnhs6mak6yi49dSy7LKNO3k+DzaWGfJMPvrfh8CaO8XTO6oj3rFuxmL2+C4zU5OQRUPl94vIYepb7oWgGlCY3n47RWHGEoC8/NXzMYGyGmTjsrye7NpOnh+13ReugkPmfgpsVzOq2t2hIca6q90URoBV9u3Ss+0xciuPTKhwZ6C4MVzmXPj+/mhk9BdSCTwPTd//6+9Ve6Kwe1xCmoJCbVY2tLucDy6ZUOUJdMjq80QNCDAnrE1vhWGoPpvUTw6A3Cn2Rh3rne2lOQmYN7d7k4GqLvgswT08pIt9tl/pVtCNHkXTkPvjb0W2u0HSnlBzzBAzGHQAnimcnpF7r06SFNgpI4C39mkI02IGhnlhAQMwX+Bo0KyjnC7Mjfln4ICffxyzrG5VXB+IGm6VbH8ajzO5WBDbLVMniQZl+98sC71xA6BKVhANxrXvuQkJrqlJMSZaV11mRxUFBjGOdICGfIBLbGMWzlyIssF7XP8WCq+UWcgyzAAkSxKS7d9DW66ds9UqyFF0GJxGEQvcsRM1ewCW0jpeGIzdeTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39850400004)(451199024)(186009)(1800799009)(44832011)(4326008)(5660300002)(8676002)(6486002)(6506007)(8936002)(316002)(7416002)(41300700001)(66556008)(6916009)(66946007)(66476007)(478600001)(966005)(6666004)(2906002)(6512007)(26005)(83380400001)(2616005)(36756003)(38100700002)(66899024)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JPwpC6lstxOOSf32lyotMa7LTvjyJb+igCkO6HXVkjEoNi6kJ54vu/WwJEEl?=
 =?us-ascii?Q?R47lKA8BDSe2JqoGx3mTULW35qdy19Svcp7H7i37r6Nm0VVUN/32b6rYg2x/?=
 =?us-ascii?Q?snXM0pLNxE18Jp5+hc9+WYXA8YtdDNq1BbPEx32D38X/0KTlhWuX28skq8cb?=
 =?us-ascii?Q?n+P8WEfCSgOTnWth+u7egqVLWCN6pqgvgXK73O51x7OC3Fa86S+EnoSDOG3O?=
 =?us-ascii?Q?rTMc86P3FatV7IdxYZ4OsybrwZMNLwWlcWjMKzEpCEN8FlENIZvFyol9Ok95?=
 =?us-ascii?Q?0Vm5e1jCrPJZ3MAwiW06CDxaPjl6nyXhtSD/3BUDKnN7zBfgVsKIz5qtj4yU?=
 =?us-ascii?Q?BaTD0vN5WMvukP/iEcBI+X2rmyr6Yy9SLtQ/5KNq7+QKUkt2jY0amy8VmsMo?=
 =?us-ascii?Q?t8KAxHnTP7Y7stJ6Kcc+EaBZeDbFwnqXUVPjEP0AlK0xnODEWaCMomDg4eA0?=
 =?us-ascii?Q?eDn3egKVFEc++PnnhXiRE8/wvRvCk8gLCQ1EEXLP3tzAsAAmXvkO1TJN2heN?=
 =?us-ascii?Q?TeEir6bulze2q4fLPXw4fMTBTFe5X2DEQ6gpfDsGm2rxTJwIqON+Fs9jFw+K?=
 =?us-ascii?Q?p+eUIT1a04A5f6NLOVol6qpVL6W7pUfA32Tr1iClyr98r1KSE497Q4m4AruF?=
 =?us-ascii?Q?rDDg9jGvW+Ymvc3EzgD7LA1XNDbMI1xk3TlkWueR9/cTHDndk7MvXe2PdiYD?=
 =?us-ascii?Q?d5Fy8DskNj3v4J3E9RFoALbeEXpTmn1JmLODZRy2Zos2rwGH55E1dHmRDd2D?=
 =?us-ascii?Q?18lUR+HYG/EmuqEj5ROzhkvm0uq1ceCvjb3utl5DgH7XVFrx0lB/8tfpUZag?=
 =?us-ascii?Q?jsm09RBVu05FNSH24vtol6a3W4BKHhiTPiYYH3C3fgx7Hothtzp+XrjFMbq0?=
 =?us-ascii?Q?OiMEz4ssxZzAS/+QnFtiqtKqh2PMHU7b806QgFUh4WgCKTW/27Aq9PLNiss5?=
 =?us-ascii?Q?dmfhEvLdPudLwqppfBBJ62yTj39flrERMhd72IsSL81TXdFjm8MU2v1UWv7R?=
 =?us-ascii?Q?CMfDkq19XUyGNJhbZBsNULzPfO8mj1rXIL/sDohA4fhfFH7Z3sJ1+bXu5yfX?=
 =?us-ascii?Q?Q32FAYXhTK0P4unpGGBfcvu8BPGMNP8kdXB48s7JT24K5zI9UiEjfN62nmm1?=
 =?us-ascii?Q?xHFYRmXGelHHnvBGY9h6/zwZ2ZmkBWfSuCgOngrN5IIMRohOLmO1gczPMoax?=
 =?us-ascii?Q?uef+IY1po4Z001NrWJFMmYN9yaFwYSyVlPDPiHfM5CAzks7el9oeAvPEv4sy?=
 =?us-ascii?Q?pZlWOzUlhAjuJaF57G88XgSXSwBwA8oaXxpsScQByjJMsSaIfE8FLmn5kDSY?=
 =?us-ascii?Q?whcqUB7RShcTJomLLo03QXmDBRZ28sha69jDepGQt46glfUPeMpgmK3bXW8v?=
 =?us-ascii?Q?GzMaYblwbn01LW9h53x66BMHlL+oj57GyE91ZnE8zjD6gbBEXN/RaunX+fLp?=
 =?us-ascii?Q?9yE5V+5sAnFNe03HXL6VTF6VpaoEdxtjrjmyawrrazqHXyLa1CPAp78O9SJE?=
 =?us-ascii?Q?tBDl+SfPc7ilGTKJA5qk+nzC2qd/FsMKHyBmESC7UJBGiNK5SZLLBxDzN34i?=
 =?us-ascii?Q?fbjJMFSphMrG9CGRqINNml7kTv1YLwTfHP0bVuxpEc8HKzpx/n88uqA5XwYd?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1712260-8337-4309-d44e-08dbb9292838
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:57:42.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di0FeeRc/UupUgcBKZTf0IZ4y40bHaxujCDI4vYJI0onnB760mWQta69CtHMqeulE3ACzBWFr6dyBsvt8NuFWhdoU35t0ewJ+kjfGy9/k7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 02:17:15AM +0200, Thomas Gleixner wrote:
> On Thu, Sep 07 2023 at 03:54, Gregory Price wrote:
> > Similar to the move_pages system call, instead of taking a pid and
> > list of virtual addresses, this system call takes a list of physical
> > addresses.
> 
> Silly question. Where are these physical addresses coming from?
> 
> In my naive understanding user space deals with virtual addresses for a
> reason.
> 
> Exposing access to physical addresses is definitely helpful to write
> more powerful exploits, so what are the restriction applied to this?
> 

There are a variety of sources from which userspace can acquire physical
addresses, most require SYS_CAP_ADMIN.

I should probably add this list explicitly to the RFC for clarification:

1) /proc/pid/pagemap: can be used to do page table translation.
     This is only really useful for testing, and it requires
     CAP_SYS_ADMIN.

2) X86:  IBS (AMD) and PEBS (Intel) can be configured to return
     physical, virtual, or both physical and virtual adressing.
     This requires CAP_SYS_ADMIN.

3) zoneinfo:  /proc/zoneinfo exposes the start PFN of zones. Not largely
     useful in this context, but noteably it does expose a PFN does not
     require privilege.

4) /sys/kernel/mm/page_idle:  A way to query whether a PFN is idle.
     One tiering strategy can be to use idle information to move
     less-used pages to "lower tiers" of memory.

     With page_idle, you can query page_idle migrate based on PFN,
     without the need to know which process it belongs to.  Obviously
     migrations must still respect memcg restrictions, which is why
     iterating through each mapping VMA is required.

     https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html

5) CXL (Proposed): a CXL memory device on the PCIe bus may provide
     hot/cold information about its memory.  If a heatmap is provided,
     for example, it would have to be a device address (0-based) or a
     physical address (some base defined by the kernel and programmed
     into device decoders such that it can convert them to 0-based).

     This is presently being proposed but has not been agreed upon yet.


> > +	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
> > +		return -EINVAL;
> > +
> > +	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
> > +		return -EPERM;
> 
> According to this logic here MPOL_MF_MOVE is unrestricted, right?
> 
> But how is an unpriviledged process knowing which physical address the
> pages have? Confused....
> 

Someone else pointed this out as well, I should have a SYS_CAP_ADMIN
check here that i neglected to add, I have a v2 of the RFC with a test
and fixes, and I am working on a sample man page.

This entire syscall should require SYS_CAP_ADMIN, though there may be an
argument for CAP_SYS_NICE.  I personally am of the opinion that ADMIN is
the right choice, because you're right that operations on physical
addresses are a major security issue.

> > +	/* All tasks mapping each page is checked in phys_page_migratable */
> > +	nodes_setall(target_nodes);
> 
> How is the comment related to nodes_setall() and why is nodes_setall()
> unconditional when target_nodes is only used in the @nodes != NULL case?
> 

Yeah this comment is confusing.  This is a bit of a wart that comes from
trying to re-use the existing do_pages_move to ensure correctness, and
I really should have added this information directly in the comments.

The relevant code is here:

static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
                         unsigned long nr_pages,
                         const void __user * __user *pages,
                         const int __user *nodes,
                         int __user *status, int flags)
{
...
	err = -EACCES;
	if (!node_isset(node, task_nodes))
		goto out_flush;
...
	if (mm)
		err = add_virt_page_for_migration(mm, p, current_node, &pagelist,
					     flags & MPOL_MF_MOVE_ALL);
	else
		err = add_phys_page_for_migration(p, current_node, &pagelist,
				flags & MPOL_MF_MOVE_ALL);


do_pages_move was originally written to check that the memcg contained
the node as a valid destination for the entire request. This nodemask
is aquired from find_mm_struct in a call to cpuset_mems_allowed(task).

e.g. if memcg.valid_nodes=0,1 and you attempt a move_pages(task, 2), then
the entire syscall will error out with -EACCES.

The first chunk above checks this condition.

The second chunk (add_virt/phys...), these calls check that individual
pages are actually migratable, and if so removes them from the LRU and
places them onto the list of pages to migrate in-bulk at a later time.

In the physical addressing path, there is no pid/task provided by the
user, because physical addresses are not associated directly with task.
We must look up each VMA, and each owner of that VMA, and validate
the intersection of the allowed nodes defined by that set contain the
requested node.

This is implemented here:

static int add_phys_page_for_migration(const void __user *p, int node,
                                       struct list_head *pagelist,
                                       bool migrate_all)
...
        pfn = ((unsigned long)p) >> PAGE_SHIFT;
        page = pfn_to_online_page(pfn);
        if (!page || PageTail(page))
                return -ENOENT;

        folio = phys_migrate_get_folio(page);
        if (folio) {
                rmap_walk(folio, &rwc); <---- per-vma walk
                folio_put(folio);
        }


static bool phys_page_migratable(struct folio *folio,
                                 struct vm_area_struct *vma,
                                 unsigned long address,
                                 void *arg)
{
        struct rmap_page_ctxt *ctxt = (struct rmap_page_ctxt *)arg;
        struct task_struct *owner = vma->vm_mm->owner;
        nodemask_t task_nodes = cpuset_mems_allowed(owner);
... the actual node check here ...
        ctxt->node_allowed &= node_isset(ctxt->node, task_nodes);



I will add some better comments that lay this out.

~Gregory



