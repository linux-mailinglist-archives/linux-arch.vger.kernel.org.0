Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE766D088A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjC3Onc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 10:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3Onb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 10:43:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06C7681;
        Thu, 30 Mar 2023 07:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juJZ+DuKZdqeL01nxk/FHomCwi0SFN9SI0x90sJPjRs870B1+BCyx5Cs9Z3f5/n63ZG/9p0eCZHrG2zl7PlnhyRJps/gfv9jmwhpfdyLBzs737QlKlR41ohxVxVeMcAAHJ4e2QsRYGZPDLqrdk7oeBRhFtOVUGd5yCYN/9SejU9RvKIoQkwgnKXTtvu1d6BZXsId3G2/yeoWq2gNPOEi1hVIS7zXrdzLlZVeZgEgDuEhEPsHxheIQr1ez9JYMzoOhKi/xQM4cMg9GMcuqU+g3GPjXvqo5RvRIXhLiO7q3VUgWiHrp/pk5dcxyRXKD5kl1ZEKnkqgA9eGKkEHHitQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IJRRn3WAZQNmy48v0HM+97aESGbaHWFWFM1c1tho0s=;
 b=Ogkutnm4Hecp2UP+5HZ0Ohpu1IJsmpncNtXkMBMeKLZUxfQEVxPfSINtbnnbGH05M2YTsk0X7d7CdtZdtaIodukbwqRRhHdzcAmHOzVHhNI0leYisEM4BnXXjRdt+ZijfBi72DkMh08nwXmnRzCv+ku1+pevNpXqL9F9C/Y5saemyXAgJgEETmT7V9MyjjI7Ha5ZCsGQ30MX3sukuUhFBSg17C/kaUBOWDPZ9a6I5nXSaPDrsJJ3oMaEtgQURl0yEoW8SzdG4r/cyXwEvu/fcoTf48vZxp3lLLiv5d6D2ORo3233Z2PJgCpLjk/cozGZRaurUwEqQlk+a5Qvel4z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IJRRn3WAZQNmy48v0HM+97aESGbaHWFWFM1c1tho0s=;
 b=NCOpNr80lN9JimIa+VYnZP/aQQb25G/3rkrc2HPMHBX3cFIjmD5wIczgdBGFrhJ1a9KeTWa4iUPG24fS4xBZ145Y9V+2cDgx1q/Zc8jT0DJpuOhAqIElxZt/vq03RwlL4UDx6twp3RD7zijzw6Oi6UxyAOpY7mRa9mCSPP8YVFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB3745.namprd17.prod.outlook.com (2603:10b6:a03:233::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 14:43:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 14:43:26 +0000
Date:   Thu, 30 Mar 2023 00:18:36 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <ZCUNnBsVA0A+PgPT@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <ZCRl2ZDsNK2nKAfy@arm.com>
 <ZCO/vNYlGdwthZX2@memverge.com>
 <ZCWXE04nLZ4pXEtM@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCWXE04nLZ4pXEtM@arm.com>
X-ClientProxiedBy: SJ0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: 927494d3-dd01-4170-45be-08db312d1ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+tlh7YhETlhs8h+8tGVi/db4a8MCiOHMb5DN69ka1AC/6DsNXqyI8XZCeZT+SvsuKZLwK7C078DFqjbNzsRmZVooiVm5m7zU/tL7SJtV8w7XMkxFg58WAxYaLpOCRAkQSUYoQQNE7dSrAbElMViZrTjqA4ePGkiVSJ7cJhciorsNgrHcu03m7CFUfdg4z/Nsw0XBZ1MAwfLvfDVVbJHOhr2IYQkhNiyXg7Etr4Gzga+4QmqkOuT7328qcHeKlZjZY3Nwh9z2U+/pFHC7jZQMz7ssq8pmUKmrTnWNBFRExBO0p5gIN8uNRRHbKSh8hOpz3WQz72VpGtxbYvu5W/ENQmK219zGaUmqqd+razPxxjAHO0rhgEoLa2Sm4CcwIXDZs+wpC3IXHHjfXknS1dHsrxZDKSpUdhm+epWyQnLgE6kteScYKieIzbWUht0f6St02GNRebFlCDlJ3Pzm1yHtD3nGDiCYSAr8kpwkO+qiq1a845q5snBFTtnRDpFITmQZEMvaVBkk4CvioOug0pTom9jR+YF9ezH0by7xe+/Bettdcy8OypkAVi8k0e2b3QC6GklRpE1GleDSax1wuCdEvAkwCVXpRdlxAxA1yFnVqHlyWTNf+yzQzvGqhyJ00zP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(376002)(346002)(396003)(366004)(451199021)(8936002)(186003)(44832011)(36756003)(6486002)(966005)(7416002)(6666004)(5660300002)(316002)(66556008)(66946007)(4326008)(2906002)(478600001)(66476007)(86362001)(6916009)(8676002)(38100700002)(26005)(6506007)(6512007)(83380400001)(41300700001)(2616005)(41533002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TNCcr/CseGyKgtjQm7HNpx6KnBYxl5TfKFm8k2rU87ob4jiN/UzAf7GVwWL0?=
 =?us-ascii?Q?CNVPBFYVhZ7aN7viNtxR5lBttlGV9l1WYcPIHTD0nOb5b9ghFzRmk+XMeinU?=
 =?us-ascii?Q?CVLwCRN3N9jd1pPJZPAfL+QSDe/WRa5j9SJgD2HqJUF+y68XU0IJ5OtYhdv4?=
 =?us-ascii?Q?PdfavT0HI2AtodwtCpgwTf7BK2dxwXrLW+63YctPNr4agtnSCJomyxvDdMdX?=
 =?us-ascii?Q?wQN8pgy4uiaBJStRh+pXIgswY0/C5hY95ZhRoalE7V8xV6L/NVRejJJuwZSx?=
 =?us-ascii?Q?s6BNm5lFKDZT8I+mRgIjDBqqYYggJB1vGdFeoWC0LXZTJo0/dMA7yIosQfwT?=
 =?us-ascii?Q?NvZHTk4Kp9zu+j6bOwYIFZpFnOZU3gUQfkWRmGsQDF+FTfVwe6DU5ZjacUm9?=
 =?us-ascii?Q?dpCLME8GVJz7L10OKUrafKDKxjPFI6rDz6Ic9OPLhmtkmPKVMcMb5SBVSAnx?=
 =?us-ascii?Q?17R3cuL26xe1Cbaz10vzcqa/YSEAsOQMbDMkDaj4cM0L2y6RUmHW03q441/9?=
 =?us-ascii?Q?XGPMRfI2B+RDRGxen8h7sFTGjMYnDKZC30SdmvVMHZ51iMr5esm20jMJrNBx?=
 =?us-ascii?Q?0M9IXTxFeFOFSVTaLJqAV8lFzR/8q8ZSdD6T+nRlpXuNwOJJfwQWWBEjcN+G?=
 =?us-ascii?Q?vrHG/gCkadrgxBdZL0FWLfdRPwfdu9w+shmgr7cuc367kQdEbIaEwl8TdAl/?=
 =?us-ascii?Q?pu3eQFAB3g6Tu0kSOcZap1Rlvye1DGXWv2IsafFIEFUakJke93joYwBxMbWw?=
 =?us-ascii?Q?3nZpmNCKkPvcnWxWKQuSTvdIvwcByaAKUQClAdWZnlveySA/0YDMX77oYOZl?=
 =?us-ascii?Q?WLTJGVDrKm96zc7jpYiKmygJ93bRsCnTW8qHz+NU1gtqnMq5w73pTyh7XUd2?=
 =?us-ascii?Q?6nJeBWtlrQ9C52Rzl9zU2j+dauOeAAihPsBZvVuic3hkp5YaE6A3WrO5qavF?=
 =?us-ascii?Q?3EDvAdAqHNo8vuC3kROGFcaN7k6P5cErxwTA8jktUnjzt2SPEUQHH8Ft8T8p?=
 =?us-ascii?Q?K8ik8WKAszmmoymOYYOYJl3Nr8WUVHe2ZMMfLGqwCdqiKzv7TwiVdV33cYWt?=
 =?us-ascii?Q?M4i1LWCANpHAV/9Pgp24Zy0Ex3lB8I3nXKTZrSOFKq3yZE/VrX9BqgTKK8O6?=
 =?us-ascii?Q?ua67t4FD/Vq2Gud3vTuIJDv/9+JJBBsWltaDxQd74YsLwud4KFJMxvxPfV6z?=
 =?us-ascii?Q?giJjMI6uJ1GHShr5mi28VEYCK5kgGMMSr42PUxUIeiDyYV03UnyhKk7FC2KE?=
 =?us-ascii?Q?XxhE5UZG11U8UN5g3wHRdocjD5s3tYbVD+OTGvRUYqIbnCuGpA0UiTo6qFWo?=
 =?us-ascii?Q?8Ye3s1In0Kca1aoQajbCaFNB8+MLzbfXMafEqnc+texyH+PyLNoM5gGcFTYs?=
 =?us-ascii?Q?+ps9eM7GJcZXbD2U6EXYNXps8S+cxN7RefjYW//Io456ifcDHnhn9GgK6NTU?=
 =?us-ascii?Q?S3DMNC0SuQA6ikIbkm5iUM++cPZk5v185J3M8tq2Tejg2Ovt8Oo50f9Y/Bll?=
 =?us-ascii?Q?xSy2zBgj4KSv0y2noKvXORlVKoAId37oXTBW0L0TNnekqEQldRFiJ+B+yvt2?=
 =?us-ascii?Q?FfmkkaFjRlhaJCqe/1L7PQ3SYjjjKTi6BhkaFMJic3Dfe00xlhArXrUDxWDS?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927494d3-dd01-4170-45be-08db312d1ec7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:43:26.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9shVjNX9KdBDsNeJwhe5pUfbVwTy2OatBSIp8OtNgtSsxLNkY3ZkSEsGL4V6J+BGV7DqBQErGCLze7pbvemB2QRubnTiNYovZpEk1vS4Dok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3745
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 30, 2023 at 03:05:07PM +0100, Catalin Marinas wrote:
> 
> Ah, thanks for the pointer.
> 
> For ptrace(), we live with this relaxation as there's no easy way to
> check. Take __access_remote_vm() for example, it ends up in
> get_user_pages_remote() -> ... -> __get_user_pages() which just untags
> the address. Even if it would want to do this conditionally, the tag
> pointer is enabled per thread (and inherited) but the GUP API only takes
> the mm.
> 
> While we could improve it as ptrace() can tell which thread it is
> tracing, I don't think it's worth the effort. On arm64, top-byte-ignore
> was enabled from the start for in-user accesses but not at the syscall
> level. We wanted to avoid breaking some use-cases with untagging all
> user pointers, hence the explicit opt-in to catch some issues (glibc did
> have a problem with brk() ignoring the top byte -
> https://bugzilla.redhat.com/show_bug.cgi?id=1797052).
> 
> So yeah, this access_ok() in a few places is a best effort to catch some
> potential ABI regressions like the one above and also as a way to force
> the old ABI (mostly) via sysctl. But we do have places like GUP where we
> don't have the thread information (only the mm), so we just
> indiscriminately untag the pointer.
> 
> Note that there is no security risk for the access itself. The Arm
> architecture selects the user vs kernel address spaces based on bit 55
> rather than 63. Untagging a pointer sign-extends bit 55.
> 
> > I did not have a sufficient answer for this so I went down this path.
> > 
> > It does seem simpler to simply untag the address, however it didn't seem
> > like a good solution to simply leave an identified bad edge case.
> > 
> > with access_ok(untagged_addr(addr), ...) it breaks down like this:
> > 
> > (tracer,tracee) : result 
> > 
> > tag,tag     : untagged - (correct)
> > tag,untag   : untagged - incorrect as this would have been an impossible
> >               state to reach through the standard prctl interface.  Will
> > 	      lead to a SIGSEGV in the tracee upon next syscall
> 
> Well, even without untagging the pointer, the tracer can set a random
> address that passes access_ok() but still faults in the tracee. It's the
> tracer that should ensure the pointer is valid in the context of the
> tracee.
> 
> Now, even if the selector pointer is tagged, the accesses still work
> fine (top-byte-ignore) unless MTE is enabled in the tracee and the tag
> should match the region's colour. But, again, that's no different from a
> debugger changing pointer variables in the debugged process, they should
> be valid and it's not for the kernel to sanitise them.
> 
> > untag,tag   : untagged - (correct)
> > untag,untag : no-op - (correct), tagged address will fail to set
> > 
> > Basically if the tracer is a tagged process while the tracee is not, it
> > would become possible to set the tracee's selector to a tagged pointer.
> 
> Yes, but does it matter? You'd trust the tracer to work correctly. There
> are multiple ways it can break the tracee here even if access_ok()
> worked as intended.
> 
> > It's beyond me to say whether or not this situation is "ok" and "the
> > user's fault", but it does feel like an addressable problem.
> 
> To me, the situation looks fine. While it's addressable, we have other
> places where the tag is ignored on the ptrace() path, so I don't think
> it's worth the effort.
> 
> -- 
> Catalin

Thank you for the extensive breakdown.  Given this, it seems like I
should just revert to untagging the pointer and drop the access_ok
extensions.

I'll add a comment at the untag site that discusses this interaction.

Thanks!
Gregory
