Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F34AA310
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 23:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348725AbiBDWVZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Feb 2022 17:21:25 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:57994
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344064AbiBDWVY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Feb 2022 17:21:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN0Sg/6O7oik+9Qmte078i6/u4+rNWL+6z9Nz1PEzgcqC+okxyLNNunPHKUUVYvhyvFyv4FZvp4REy1yWukLOG3FbPuisAzEYhWPAyEuro7TFuGZlfMf5ehdOcmGZ1COcebBTc/bxTigYZu37eGD0NVgQYUvue7Ld6qwB1ET9b98NemWoRg09voCVkrLB1CJ7vuzVG53oPl2wPv23+JIWSqcksavFT0hhSC89bWQMPeGAgxn4Dp+X1vpOltvIguhEU/UFn2yFKxvD391VYduwPeROV7gSBy0vdIZDUEFcZ0Qw2McTsk1jBA6cyXpBJ+lD9EiX7ZeJMd8TTw35dbslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8N7pPiEOYRxkCjIursxBhs7hjv/9thhRfMGGVGI0SQ=;
 b=d3PBtFGKL+6HZ5aWgRkyKRGD+bUGFz88LvaTVVwRWrko+8oob6nkH5MfIaCpjgeu27iJmpe7S6PvcjUJylG8twspteVjZzaCI7i2DS4iv2yyQbO9V1N7/L99lpnodTqkAfvmO38I4s5/lIrYvPB4aIDDBU3f3ozjvgErk15Nh7lOuHRCVT6pwc0NiQbvAjInhZxft92AK6b6MuoDRWhTAXYX8k/V6Ec8v/zPhlMjkjIee/ns8X6diIyQfBnoOjIdTV6nzleWViMF4lQjnvr+nEddSa+JmxykNzf0x141CSe9eQgGvKaZmQfW9NDdJRPX4GLfKVI8WPTjlmL7/pUjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8N7pPiEOYRxkCjIursxBhs7hjv/9thhRfMGGVGI0SQ=;
 b=kfUDl2QDTbnRuk4IPBwnbp8OvWkOOwUVGjt/6sJHQPWEGjknPlGxpsQc2U6ORsWEDF6NwL6koBd6cN+ZR4YKmxCLJQWbkpRmmMPrchLUk6UR1WelBTZqDKey2iYJHopzuzgazdLwcobuStx8L2QHl/yCysrdoRidkdZvkqqO+RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 22:21:23 +0000
Received: from MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd]) by MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd%8]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 22:21:23 +0000
Date:   Fri, 4 Feb 2022 16:21:08 -0600
From:   John Allen <john.allen@amd.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, Kostya Serebryany <kcc@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 35/35] x86/cpufeatures: Limit shadow stack to Intel CPUs
Message-ID: <Yf2m1ETkcRpk3v+u@dell9853host>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-36-rick.p.edgecombe@intel.com>
 <YfxQGRV6axGQ8bBC@dell9853host>
 <CAMe9rOqwby=p3w7L7kgDUhZPzLksYEZcyKLbWOafEYaazWgyBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOqwby=p3w7L7kgDUhZPzLksYEZcyKLbWOafEYaazWgyBg@mail.gmail.com>
X-ClientProxiedBy: CH2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:610:4d::16) To MWHPR12MB1471.namprd12.prod.outlook.com
 (2603:10b6:301:e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efcc7f32-aefe-43af-06ac-08d9e82cacd7
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54816AF79D82330DE868A0FA9A299@PH0PR12MB5481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbg9kaq7R6OiuLciuzua3Hr3erEyxTSyoLUZZvbY0OWwMHDX+IluepMgcvLV1c+3O2yLfmkmyOM0YrSslPxhht0BzDHr+JnLM90n4neQBWdLrv1BtR0StuabJNpSyMB5v9Z3Flr7XCjAS7Fivfaj63JuKNiqgvWbGYxpmNwkxczTn8vwE26/hw7rIhour1Eg3kZREdcKfg//P6mDH0CWZLIYamBxE6VQH95TytBoeioemjGxkxttkGiKcIxYwzMoXHPMdIzCz+gEYgKBIRtWrcQdNB5Et0jOAk463yBc3BmvZ7UqnNx+KtvI7kfwrtcYHkXJz/Tkb1Tlq1ztQDK+GdQNC5ENKdV2Da8NowacgFkWVDdlQA3hdgy4dHcZjhNDq5X8U8LgIgEv8LKhUqFPcvT2isR4g0nqXXvdJk1cBGcaCyYqMrLnbv3gWvRT/Dd2e8uXSxCxvK1Iud4AnuFxqOS2a5R9l75d6hPAgOZbf6C8OfAUZ89u39x3+ykHS35iMygg4Ksx8shZ+yrkPAoBRmLjxqin7BXfDrcb79ZosjuyKYkV/MfpxfTLNxxMtNkc+juPTKYsjcFs0WJHbMaKxFy948QPCpBWpcq5Z6M+PPMcW1xiL474oXye5dHcgDaN78JbxSF2RNHHmX9Jl5XICeV+9QWljkgefz+DmRojZX1Y7PfZzIHg6ggh8LcrhF9M+8xonJxHXtW+1SotZND37GZE/UIkID/1QQdzVZ6vTvYx2dGNhFY4UOd+YNqm3UFHXlWsEUVwBeqK0fM8elA5BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1471.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(2906002)(44832011)(53546011)(54906003)(5660300002)(33716001)(38100700002)(6916009)(186003)(83380400001)(26005)(508600001)(66946007)(8936002)(316002)(6666004)(86362001)(6512007)(9686003)(6506007)(66556008)(6486002)(66476007)(966005)(4326008)(7416002)(7406005)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EfYcgfhB/dJ1658uvgvBx4ulncrwkdZBnMxBuUdRXUdfgmZQ2KQD3BwDMsDG?=
 =?us-ascii?Q?CTqk0XEKXbGEgsLPNkuXshylB7ETJ25utecq0QPkviAxzdAlEtQg1Exsx5qv?=
 =?us-ascii?Q?WW7kl12xgR/aIx04S74FIJXj7VtwrxeZ4I1hZAF2A5mkSEdiNPotgSK26Mf6?=
 =?us-ascii?Q?O0fAjkt3TtUi5Z1bGyOGzK8oRxPS+oCAw80PG2Kcc6376MJRXYYG7NcpYZaR?=
 =?us-ascii?Q?G3/SGT5SiLEWGzkHu7c3jiX7obyKP7xNwLlHX2q5N5WGmT+wGTNNKmsu1XVC?=
 =?us-ascii?Q?p9SeN8f1T7YNXxNc714rSffbRk2/bnJOoxNBb8lUV4t3K+vS6R26+CarJ1TM?=
 =?us-ascii?Q?K7p2IHHI2W76i7JXyqsl0x/320wgXJwqPsxRDcHSliOvWNWt0wb0KUshJLpm?=
 =?us-ascii?Q?rSwfSxeyRUIh2X4181rnQz2TJSrjtwlE+C52Lorp3jl3cYrivCeZ3uAMUgdq?=
 =?us-ascii?Q?TDISh13uMzjv5ura0mz3jjnNwQ5yIlfr1TUCEXft+j9KSiUwWKzYj8i17u0Y?=
 =?us-ascii?Q?5MN1FRLD/R3dhhxh5fwQa5RUCcEvgYEhNdPqFWLQmf/uqCbBG+p4cfQ92RWM?=
 =?us-ascii?Q?f5qDEpVbsbBI+0Rp3/wF849YlvEfAtht4ona0Ibnp6FNPkkIAM10Y513yf4h?=
 =?us-ascii?Q?Ere9Mv3BjUe85B+3fcaH7PwPbc74Aq44tvo77lmNCdvXUwlY7kIHiYRCijMX?=
 =?us-ascii?Q?A7qN+OSSH6cOHz0k3+SVLCqEA7mEHnjYkMeOOLXtuFqcfbOTF+m4XEuCG5+O?=
 =?us-ascii?Q?WAGZUaiF2t7lPhXxTqvUm0Oh8zdP2Ax+SNISfB6BmdKL8k+OyjIzLEOkiyf/?=
 =?us-ascii?Q?KQrfKhz8KCrnpOEBaT/xaFy3dCpBjmoUsLbxPwgCKeb3RrKT6ytaYtteYJ1u?=
 =?us-ascii?Q?Do64EuRTcYtmYmq2zLm/jO5Vz/e2n1ljBCnO2t5oFODTRZ27f6HcJY3cSxE4?=
 =?us-ascii?Q?q8f+c3Iuqz+gcu59O1LW5fxCqhNjFTB2RqTwYdJ+x8eGJMY7OJVr15IEkbeb?=
 =?us-ascii?Q?1lmcPqz4BMUpN+X2uirwc+D5OlfIRN1bSXoeNm4EMN68zLh5s1mELhS31Eu2?=
 =?us-ascii?Q?p/PxSqSTvhWEuNNUhmc47fYJUK/pIxV7QC8fvIY1Xz5W+XM0odIB5opYc8RN?=
 =?us-ascii?Q?vWX17ubKyiNkqs+kVklCi4dflRUEM49qOs50wan9Weshl5cKldxFobKPD3n1?=
 =?us-ascii?Q?2zD501Oa0Xg24jKH2/c3Q24KHh1LrSXV9CTcdKzyjFcHKTjci9+dScGC7+7L?=
 =?us-ascii?Q?JsErdEjx+XXYo/25pApQjQIVjF9897uxLN9Wd2L2pTELZzo1xO4Ktt23B9bs?=
 =?us-ascii?Q?6kM1tZZEqn4U4evBliem0pFt7cnTXFMJ3nq39/6m7G03d7iD96eq+G8PchnE?=
 =?us-ascii?Q?6NvIUtdcuT/ya4N+/VB4PfcSi+nmWoWkMO2YJoKCZ8FeK52KqWrkhVI93o0X?=
 =?us-ascii?Q?k5uSWu8kjrBZXjs/sm5ONYENAE7tvBVSSRJd9mI4xdx6IMRTEBmSViPKd/+U?=
 =?us-ascii?Q?idPzZya9ypwresjdBAicKOdgbqH8D4mtSrlfFqvmYQYGNcePFVtSyXejW8Y1?=
 =?us-ascii?Q?lFXbNSC4OHN6T1jHaHHMFyU1WVlxVhMzNDR2WYWcJaLTZq0AEgkjSQWlnDwr?=
 =?us-ascii?Q?oAh5lb0Ngg3JBomAQLLAf5M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcc7f32-aefe-43af-06ac-08d9e82cacd7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 22:21:22.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FefgeVvj9iUIp+spUVYPGzD5ROXKR/P8fPqndBuGRF8O97SS/2EECoZTnLqmft4W+rd0BGagHv7TiBx0YgJfPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 03, 2022 at 02:23:43PM -0800, H.J. Lu wrote:
> On Thu, Feb 3, 2022 at 1:58 PM John Allen <john.allen@amd.com> wrote:
> >
> > On Sun, Jan 30, 2022 at 01:18:38PM -0800, Rick Edgecombe wrote:
> > > Shadow stack is supported on newer AMD processors, but the kernel
> > > implementation has not been tested on them. Prevent basic issues from
> > > showing up for normal users by disabling shadow stack on all CPUs except
> > > Intel until it has been tested. At which point the limitation should be
> > > removed.
> >
> > Hi Rick,
> >
> > I have been testing Yu-Cheng's patchsets on AMD hardware and I am
> > working on testing this version now. How are you testing this new
> > series? I can partially test by calling the prctl enable for shadow
> > stack directly from a program, but I'm not sure how useful that's going
> > to be without the glibc support. Do you have a public repo with the
> > necessary glibc changes to enable shadow stack early?
> >
> 
> The glibc CET branch is at
> 
> https://gitlab.com/x86-glibc/glibc/-/commits/users/hjl/cet/master

Thanks, I ran some smoke tests with the updated glibc and it's looking
good so far. Additionally, I ran the new kselftest and it passed.

Thanks,
John

> 
> -- 
> H.J.
