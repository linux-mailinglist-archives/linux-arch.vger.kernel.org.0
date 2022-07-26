Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599FD581086
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jul 2022 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiGZJ5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiGZJ5K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 05:57:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CAB2F032;
        Tue, 26 Jul 2022 02:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtL8J5y5Aasq4TxBqLwum4ef/SB/S5Uysk5hq/Zs+rMtRvYQC4bWB67k+yh4VrkmoFcguGHU93M3MDi6rTrR/JNzqY+oRd9JZPUDMuGBOVK4Pr36hiSsbfD5YjDxPM0sLcyQ8HFWlMTcN5ynaIvvi/sJIi9B1BspTWFcwueaYMjpWVMy+C+PwduBuk4Io73Vi0nXENKzvRsY3JHsZpDlmRPe2UZbXZceStINeeprSJPgHhslAHrKONKrCJgNf9rSQh9SB/LyJPLWLbcrnyzeRT38AYHczWUltoh2ApUdvkGqAD8/cotP9FWPDlKCnWKnFCyRNbHB/Hxz1PKP2DitIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJYeIaNluNlb95rtoIbwopKXqjHRtrKGQgf6RUU2lZI=;
 b=jNJGHbGfgqzSgrR6MgOpebXFLRC6m0WTVChBPMxQdE839UxGBYoQEEJ5BMNSIJUWznSgv2VKCtzTuHqvxynH2iMonDcBLRUWlKJygQ5y+QqzVq5vttU1A4KIoVKmn9LO3+XerU8T+yaqcVfkWBGOCPAWFeTv4xAMV7SIOe06faNT2zu8VF/tUdIeEBmSb2/Ze+Wha9N5Q7m5ACslYQFvJqRv+8hwPi/EvofhNVEbA/xLr5WfIm0bY0rH4VEZ39NMbVZveYVbs2Orqb+VdvUdyMHqeGO6mWFOSykvlVX0zHiWgS4t59hVR1Kc5DMBn3MThCfgkGn5nxgsRXEGleGdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJYeIaNluNlb95rtoIbwopKXqjHRtrKGQgf6RUU2lZI=;
 b=mFQ6nrrDJCP7XAWh/cXUFi0jz/VengfyHAAxOaxAVd4+3Wvd614OYtXv3BCSHxTgHuMVcCsXS/F05W0CSy9jkJMiahyN1j3/MYPuYpL3assd+UYkvvHrEJC4EENMLSHpdjTOksvpZFKc49LveZyFDaobCKmyJtVPnsq7rfSvn4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 09:57:05 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247%4]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:57:04 +0000
Date:   Tue, 26 Jul 2022 15:26:19 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 14/36] cpuidle: Fix rcu_idle_*() usage
Message-ID: <Yt+6Q759LWHOIxfF@BLR-5CG11610CF.amd.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.808451191@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144516.808451191@infradead.org>
X-ClientProxiedBy: PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::29) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b218a5f-7771-4aee-c946-08da6eed317e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rGd7TycVvllbrb5kpBgMBVy2g15TZH+MP69t8HeeLVf0o1ZuzZ7vx/Yiy+G4MTz0OBKXgFqqj2tklx7X+WILsnQUn05Arjqta3+XfgWeyTp4x4iptVBnQdtMWuJVWEif3B9XbQJ6zZetDTYoAS9l37gjsWGmajO3gqnvKKO78f+dQDbEh4fmqV5miM8aegf/IUcFpYVXCdcG49MqWFsDsKdzV1uz9xjY5t7tn1XbAUAgtRFmNAOiDVSnSDCOFjK4vPPjlD5jRW8nQ4yrq5P2LqJyGUU6ZF1/wAkJOgkCDtWwVDIGUZGHQhFNw91smlPTQw1CKhcO4XN5xT277O0WUAcKFjF5qreSTjXWZu99hN4Z07f0D12lFX20HO4omelf/ZfeiR8E0pPDaszR+hgsN5T2JuV35b1yUDy4XOHwFdiqUfya02Ua7ryYOv7sdyjegQzmAEVcXN+xbihmpGhGEz8GgYI7dV/9pEHbpQuM+Td84aBqrGGfBxA8wljxgWfJcBOMAYZTzEIveWg9XVUpg7YvfNjZU/yDaiTWdma5rQY92ZO5uICxwrG5DJDuXPVy7kpcRpQT134LYLRowyq3JL12hb37nC9NW8TEufHBHoroc313Rp83bcJjRMxOrmBQLWSOTFk5dUENZomuwyon9O9K+ExvObPR/ZgRMuP5AVvY+Yu4EFkLu9qfDGh6BHvghnDaqU3xvjP/oxNxIYpQOSRTAIUS+k/q0YHn3+23OCZYI3EpgPkfjP5k4PhjR5Ul56uCWNXmlqaw9PjEi/W2tnqx6ntTvV2iYdiWzJLVWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(66946007)(41300700001)(6512007)(7336002)(478600001)(7406005)(2906002)(86362001)(6916009)(6486002)(6666004)(4326008)(26005)(316002)(54906003)(8676002)(6506007)(38100700002)(83380400001)(186003)(7416002)(66556008)(30864003)(5660300002)(66476007)(8936002)(7366002)(7276002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ez6DpKtdjPI+4H9OKkgE4Sd2xev8ToN1DfN6Bjmqv930WQL7QVV6TAdOm0ET?=
 =?us-ascii?Q?gnVLt55R0kfKFprsPYY8qeFWfDN1FK0eqHLTFAVCxlajQHBTshP5Ql+9wGrd?=
 =?us-ascii?Q?nWjAUEiEWKFckfD7OmTVW0KPhSdIZOPWo7RIRM59yK2SUUhysUapgXWGeTMa?=
 =?us-ascii?Q?bzRQqhC4WxCqr4vszqjbW4vRtBGIKovWM7tsxIULINXKIiemN4Hq7MI5RlcG?=
 =?us-ascii?Q?zbdXR6kE06PBcg4qEfBu1LgF7Ntn4+gyQJJ7H+qNfX8MvT6yCHr21P5oqPEy?=
 =?us-ascii?Q?VjpWPgJ6cr1czug8K8EscG3xva+PeRxFJgNoP2CdFOJZCOAQKg1t51DSv8Rl?=
 =?us-ascii?Q?/7IIrSTaPe3uM4Miigq+C4ewleS0OzlhdddrC1KPeSIctpYwS/b5UqjpFIt6?=
 =?us-ascii?Q?h2ipV2HN5HCuOkAACK5x1zlNyAQwp0qychRhZlRb7F5Hl6JwXkkdO7f5lm4h?=
 =?us-ascii?Q?OSjGjAskz2/t8npAmSgk9ElthoOQZQl9UHN4G2V1XggxXujNRI/CdwW/cu9f?=
 =?us-ascii?Q?CUTgyxMMh4UIgcj1B/WL5wUGNK06pa4cTaQz6OOuXrIaPQgPkognkIh/sbdR?=
 =?us-ascii?Q?1gAoCvZLv9sY9A4+Ne81LoLh/2wv1Q5/en2lJsWChpKuZht0jA6mGXmlqgyF?=
 =?us-ascii?Q?3Ue5It2C1bv5EF3QhM2hSZGzyDoz0KHVgjyLQEE9k0CYcdub4T1uHitzEhdX?=
 =?us-ascii?Q?6c/OHCErCh1bZty/G5dT5ObLEDoPqOZXDEcHhy1i1GH2Op/4E9yhD2vYZRL3?=
 =?us-ascii?Q?cjfTwK3SZl2M5Qq9o5eQd9SvEKGVrFjmKAvzMtx+dJj3N3VfxSPxVGFZlXIk?=
 =?us-ascii?Q?8eeg/sfUMI7gEcnsN0wrEHKlV8XdD6sHMYoMKq49FDR5tcEPrRafVH0pqvIK?=
 =?us-ascii?Q?qDCSZsGDpu2aoxx5t8TKLVeu/dUJiaVydXCCeGwxPphu3zmC4OqeC3ju8W66?=
 =?us-ascii?Q?1zEFcUzxm77d0fDbO+EP1HZgQnnctk7PKjM5A2PFDIrOuZKL10npR9IOHGrA?=
 =?us-ascii?Q?IBUymi0CR3LcNnBdJXVyjWO23/T/eOsdX0oHlxJ/09pyKiNnhh9M8055RNAj?=
 =?us-ascii?Q?ztYW2nU5CFqxdnA8E0F+YgkH+pQluU6cKhDNrhaZsLLlX4FoG4Dj/b1CKn2S?=
 =?us-ascii?Q?memz/H0lb4PJmJ+j5Bl31I05hgQzIUIqykJM9+fCRIzjzYciYNk4wbG9ZGZB?=
 =?us-ascii?Q?GlcFj4f7BpKF/c9Vq/LGcgBdtKFohLue9fFx1k56H3Yuh/MzNw8EgcT6g8ca?=
 =?us-ascii?Q?hZ4JLU2wV1EiBlG4PtsrMU5mb3XD7iDErGdxEVyZizYXYjVN4gqgmnExNJ+x?=
 =?us-ascii?Q?utreHOCHCx98Hlsm3Li0Zh1LXfx49/Q2gU9d7n4vdX9e5sDgOocLVTl5Stp1?=
 =?us-ascii?Q?2gl0Dos7bDgm2W9FUvAsIcgBzIner3eiNxeyW//rccZZFbj4G/m4k/BdIR7I?=
 =?us-ascii?Q?Z9pByYKWiO49WroUKpL2YlXHNLqKxTHDLRKZFK9QxbUKDT+aAa1l26Sg9qkz?=
 =?us-ascii?Q?/vxOuwblhzhI857GyijZCYm+WTJuAFm5YZTNLw/iHmvQjdq+49lSTo9Ixf9l?=
 =?us-ascii?Q?bdO0EFhuSm3I3OzNu1kjV8mcwsxTfPC+3n+DFbxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b218a5f-7771-4aee-c946-08da6eed317e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:57:04.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SMKvEfRPtPiSRMM1M8dJmKDlP4yxlf6olkte9hw0IvAyuTX3j4zSZfu5E0/uNDvQ8s98+yjS30fLi2uWIFKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 08, 2022 at 04:27:37PM +0200, Peter Zijlstra wrote:
> The whole disable-RCU, enable-IRQS dance is very intricate since
> changing IRQ state is traced, which depends on RCU.
> 
> Add two helpers for the cpuidle case that mirror the entry code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c    |    4 +--
>  arch/arm/mach-imx/cpuidle-imx6sx.c   |    4 +--
>  arch/arm/mach-omap2/cpuidle34xx.c    |    4 +--
>  arch/arm/mach-omap2/cpuidle44xx.c    |    8 +++---
>  drivers/acpi/processor_idle.c        |   18 ++++++++------
>  drivers/cpuidle/cpuidle-big_little.c |    4 +--
>  drivers/cpuidle/cpuidle-mvebu-v7.c   |    4 +--
>  drivers/cpuidle/cpuidle-psci.c       |    4 +--
>  drivers/cpuidle/cpuidle-riscv-sbi.c  |    4 +--
>  drivers/cpuidle/cpuidle-tegra.c      |    8 +++---
>  drivers/cpuidle/cpuidle.c            |   11 ++++----
>  include/linux/cpuidle.h              |   37 +++++++++++++++++++++++++---
>  kernel/sched/idle.c                  |   45 ++++++++++-------------------------
>  kernel/time/tick-broadcast.c         |    6 +++-
>  14 files changed, 90 insertions(+), 71 deletions(-)
> 
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -24,9 +24,9 @@ static int imx6q_enter_wait(struct cpuid
>  		imx6_set_lpm(WAIT_UNCLOCKED);
>  	raw_spin_unlock(&cpuidle_lock);
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  	cpu_do_idle();
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	raw_spin_lock(&cpuidle_lock);
>  	if (num_idle_cpus-- == num_online_cpus())
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -47,9 +47,9 @@ static int imx6sx_enter_wait(struct cpui
>  		cpu_pm_enter();
>  		cpu_cluster_pm_enter();
>  
> -		rcu_idle_enter();
> +		cpuidle_rcu_enter();
>  		cpu_suspend(0, imx6sx_idle_finish);
> -		rcu_idle_exit();
> +		cpuidle_rcu_exit();
>  
>  		cpu_cluster_pm_exit();
>  		cpu_pm_exit();
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -133,9 +133,9 @@ static int omap3_enter_idle(struct cpuid
>  	}
>  
>  	/* Execute ARM wfi */
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  	omap_sram_idle();
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	/*
>  	 * Call idle CPU PM enter notifier chain to restore
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -105,9 +105,9 @@ static int omap_enter_idle_smp(struct cp
>  	}
>  	raw_spin_unlock_irqrestore(&mpu_lock, flag);
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	raw_spin_lock_irqsave(&mpu_lock, flag);
>  	if (cx->mpu_state_vote == num_online_cpus())
> @@ -186,10 +186,10 @@ static int omap_enter_idle_coupled(struc
>  		}
>  	}
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
>  	cpu_done[dev->cpu] = true;
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	/* Wakeup CPU1 only if it is not offlined */
>  	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -607,7 +607,7 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
>   * @cx: Target state context
>   * @index: index of target state
>   */
> -static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
> +static noinstr int acpi_idle_enter_bm(struct cpuidle_driver *drv,
>  			       struct acpi_processor *pr,
>  			       struct acpi_processor_cx *cx,
>  			       int index)
> @@ -626,6 +626,8 @@ static int acpi_idle_enter_bm(struct cpu
>  	 */
>  	bool dis_bm = pr->flags.bm_control;
>  
> +	instrumentation_begin();
> +
>  	/* If we can skip BM, demote to a safe state. */
>  	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
>  		dis_bm = false;
> @@ -647,11 +649,11 @@ static int acpi_idle_enter_bm(struct cpu
>  		raw_spin_unlock(&c3_lock);
>  	}
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  
>  	acpi_idle_do_entry(cx);
>  
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	/* Re-enable bus master arbitration */
>  	if (dis_bm) {
> @@ -661,11 +663,13 @@ static int acpi_idle_enter_bm(struct cpu
>  		raw_spin_unlock(&c3_lock);
>  	}
>  
> +	instrumentation_end();
> +
>  	return index;
>  }
>  
> -static int acpi_idle_enter(struct cpuidle_device *dev,
> -			   struct cpuidle_driver *drv, int index)
> +static noinstr int acpi_idle_enter(struct cpuidle_device *dev,
> +				   struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>  	struct acpi_processor *pr;
> @@ -693,8 +697,8 @@ static int acpi_idle_enter(struct cpuidl
>  	return index;
>  }
>  
> -static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> -				  struct cpuidle_driver *drv, int index)
> +static noinstr int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> +					  struct cpuidle_driver *drv, int index)
>  {
>  	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>  
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -126,13 +126,13 @@ static int bl_enter_powerdown(struct cpu
>  				struct cpuidle_driver *drv, int idx)
>  {
>  	cpu_pm_enter();
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  
>  	cpu_suspend(0, bl_powerdown_finisher);
>  
>  	/* signals the MCPM core that CPU is out of low power state */
>  	mcpm_cpu_powered_up();
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	cpu_pm_exit();
>  
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -36,9 +36,9 @@ static int mvebu_v7_enter_idle(struct cp
>  	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
>  		deepidle = true;
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  	ret = mvebu_v7_cpu_suspend(deepidle);
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	cpu_pm_exit();
>  
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -74,7 +74,7 @@ static int __psci_enter_domain_idle_stat
>  	else
>  		pm_runtime_put_sync_suspend(pd_dev);
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  
>  	state = psci_get_domain_state();
>  	if (!state)
> @@ -82,7 +82,7 @@ static int __psci_enter_domain_idle_stat
>  
>  	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
>  
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	if (s2idle)
>  		dev_pm_genpd_resume(pd_dev);
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -121,7 +121,7 @@ static int __sbi_enter_domain_idle_state
>  	else
>  		pm_runtime_put_sync_suspend(pd_dev);
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  
>  	if (sbi_is_domain_state_available())
>  		state = sbi_get_domain_state();
> @@ -130,7 +130,7 @@ static int __sbi_enter_domain_idle_state
>  
>  	ret = sbi_suspend(state) ? -1 : idx;
>  
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	if (s2idle)
>  		dev_pm_genpd_resume(pd_dev);
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -183,7 +183,7 @@ static int tegra_cpuidle_state_enter(str
>  	tegra_pm_set_cpu_in_lp2();
>  	cpu_pm_enter();
>  
> -	rcu_idle_enter();
> +	cpuidle_rcu_enter();
>  
>  	switch (index) {
>  	case TEGRA_C7:
> @@ -199,7 +199,7 @@ static int tegra_cpuidle_state_enter(str
>  		break;
>  	}
>  
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  
>  	cpu_pm_exit();
>  	tegra_pm_clear_cpu_in_lp2();
> @@ -240,10 +240,10 @@ static int tegra_cpuidle_enter(struct cp
>  
>  	if (index == TEGRA_C1) {
>  		if (do_rcu)
> -			rcu_idle_enter();
> +			cpuidle_rcu_enter();
>  		ret = arm_cpuidle_simple_enter(dev, drv, index);
>  		if (do_rcu)
> -			rcu_idle_exit();
> +			cpuidle_rcu_exit();
>  	} else
>  		ret = tegra_cpuidle_state_enter(dev, index, cpu);
>  
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -13,6 +13,7 @@
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/idle.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_qos.h>
>  #include <linux/cpu.h>
> @@ -150,12 +151,12 @@ static void enter_s2idle_proper(struct c
>  	 */
>  	stop_critical_timings();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_enter();
> +		cpuidle_rcu_enter();
>  	target_state->enter_s2idle(dev, drv, index);
>  	if (WARN_ON_ONCE(!irqs_disabled()))
> -		local_irq_disable();
> +		raw_local_irq_disable();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_exit();
> +		cpuidle_rcu_exit();
>  	tick_unfreeze();
>  	start_critical_timings();
>  
> @@ -233,14 +234,14 @@ int cpuidle_enter_state(struct cpuidle_d
>  
>  	stop_critical_timings();
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_enter();
> +		cpuidle_rcu_enter();
>  
>  	entered_state = target_state->enter(dev, drv, index);
>  	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
>  		raw_local_irq_disable();
>  
>  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> -		rcu_idle_exit();
> +		cpuidle_rcu_exit();
>  	start_critical_timings();
>  
>  	sched_clock_idle_wakeup_event();
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -115,6 +115,35 @@ struct cpuidle_device {
>  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>  DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>  
> +static __always_inline void cpuidle_rcu_enter(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +	/*
> +	 * Idle is allowed to (temporary) enable IRQs. It
> +	 * will return with IRQs disabled.
> +	 *
> +	 * Trace IRQs enable here, then switch off RCU, and have
> +	 * arch_cpu_idle() use raw_local_irq_enable(). Note that
> +	 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
> +	 * last -- this is very similar to the entry code.
> +	 */
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare();
> +	instrumentation_end();
> +	rcu_idle_enter();
> +	lockdep_hardirqs_on(_THIS_IP_);
> +}
> +
> +static __always_inline void cpuidle_rcu_exit(void)
> +{
> +	/*
> +	 * Carefully undo the above.
> +	 */
> +	lockdep_hardirqs_off(_THIS_IP_);
> +	rcu_idle_exit();
> +	instrumentation_begin();
> +}
> +
>  /****************************
>   * CPUIDLE DRIVER INTERFACE *
>   ****************************/
> @@ -282,18 +311,18 @@ extern s64 cpuidle_governor_latency_req(
>  	int __ret = 0;							\
>  									\
>  	if (!idx) {							\
> -		rcu_idle_enter();					\
> +		cpuidle_rcu_enter();					\
>  		cpu_do_idle();						\
> -		rcu_idle_exit();					\
> +		cpuidle_rcu_exit();					\
>  		return idx;						\
>  	}								\
>  									\
>  	if (!is_retention)						\
>  		__ret =  cpu_pm_enter();				\
>  	if (!__ret) {							\
> -		rcu_idle_enter();					\
> +		cpuidle_rcu_enter();					\
>  		__ret = low_level_idle_enter(state);			\
> -		rcu_idle_exit();					\
> +		cpuidle_rcu_exit();					\
>  		if (!is_retention)					\
>  			cpu_pm_exit();					\
>  	}								\
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -51,18 +51,22 @@ __setup("hlt", cpu_idle_nopoll_setup);
>  
>  static noinline int __cpuidle cpu_idle_poll(void)
>  {
> +	instrumentation_begin();
>  	trace_cpu_idle(0, smp_processor_id());
>  	stop_critical_timings();
> -	rcu_idle_enter();
> -	local_irq_enable();
> +	cpuidle_rcu_enter();
>  
> +	raw_local_irq_enable();
>  	while (!tif_need_resched() &&
>  	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
>  		cpu_relax();
> +	raw_local_irq_disable();
>  
> -	rcu_idle_exit();
> +	cpuidle_rcu_exit();
>  	start_critical_timings();
>  	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +	local_irq_enable();
> +	instrumentation_end();
>  
>  	return 1;
>  }
> @@ -85,44 +89,21 @@ void __weak arch_cpu_idle(void)
>   */
>  void __cpuidle default_idle_call(void)
>  {
> -	if (current_clr_polling_and_test()) {
> -		local_irq_enable();
> -	} else {
> -
> +	instrumentation_begin();
> +	if (!current_clr_polling_and_test()) {
>  		trace_cpu_idle(1, smp_processor_id());
>  		stop_critical_timings();
>  
> -		/*
> -		 * arch_cpu_idle() is supposed to enable IRQs, however
> -		 * we can't do that because of RCU and tracing.
> -		 *
> -		 * Trace IRQs enable here, then switch off RCU, and have
> -		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
> -		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
> -		 * last -- this is very similar to the entry code.
> -		 */
> -		trace_hardirqs_on_prepare();
> -		lockdep_hardirqs_on_prepare();
> -		rcu_idle_enter();
> -		lockdep_hardirqs_on(_THIS_IP_);
> -
> +		cpuidle_rcu_enter();
>  		arch_cpu_idle();
> -
> -		/*
> -		 * OK, so IRQs are enabled here, but RCU needs them disabled to
> -		 * turn itself back on.. funny thing is that disabling IRQs
> -		 * will cause tracing, which needs RCU. Jump through hoops to
> -		 * make it 'work'.
> -		 */
>  		raw_local_irq_disable();
> -		lockdep_hardirqs_off(_THIS_IP_);
> -		rcu_idle_exit();
> -		lockdep_hardirqs_on(_THIS_IP_);
> -		raw_local_irq_enable();
> +		cpuidle_rcu_exit();
>  
>  		start_critical_timings();
>  		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>  	}
> +	local_irq_enable();
> +	instrumentation_end();
>  }
>  
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -622,9 +622,13 @@ struct cpumask *tick_get_broadcast_onesh
>   * to avoid a deep idle transition as we are about to get the
>   * broadcast IPI right away.
>   */
> -int tick_check_broadcast_expired(void)
> +noinstr int tick_check_broadcast_expired(void)
>  {
> +#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
> +	return arch_test_bit(smp_processor_id(), cpumask_bits(tick_broadcast_force_mask));
> +#else
>  	return cpumask_test_cpu(smp_processor_id(), tick_broadcast_force_mask);
> +#endif
>  }
>  
>  /*
> 
> 
