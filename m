Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173604A9056
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 22:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354774AbiBCV67 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 16:58:59 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:46400
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233926AbiBCV66 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 16:58:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbBzR78cEUoeWUSIVvnGlYJhZBEf8Br7SR0xK/po4/FdT3OcgOMhDPKqogLQCWaeqoAgUCqnrk9XpkOAZXtaAPbZNu5Ea57YX33p/ldeNyE3SyhcyiOB7qh+GPNPDarGhMCY/gvNoyQY7MXM9VqEIh5sNMvj8chD1y9UC5LsY/wFGnt1sBceLw/v5W51wlMlpUVCcAhgp/ZZDYJjR0zS+iKMHGvnxl35qbCu1RSaQXywwmvteVHOPwRkp7iezs7ZA/WtsFZFNVxplL5pQOmZEyrMndgGwgok4tXpiR4X/bw1EEuRfFbkFWangnx6LgUxoyEUFvC3IWITEmFVY7Rx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jziT6wmOpBBDQif0xLp3utrJ/TfNxOIWx7Op1pA0l3U=;
 b=kryazPU8HTE69CzPsC1DBHTGY1FW8XldLqYrfHvt68Nq3ad2kqgZi24gyYEezB3asKn29ooi6dPIYGuJRCYlPzZqEUbkfS8yuv8SMcatsPKGkqPlkULtPzS9j6h+MMaUiU49LQ9YRWGbvmMf/v2oXlH8QCZkM2cIxU1wwTqYAYN9ebo0eTM/djhAT3+fb2Kx6xGEkgpLDhuUZxgFJ+l99kf9HZSEyLaBE4gGsLQ8hSuNEes9dFQH+yshcCc+jY0O/QkvPZzS2dq8koCozf6SDoAHnNQnrv1bwQDGnF8slFURPQyDXMBFTRSvpxBjpn7265vx1+2CyYcIdNFb0nNGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jziT6wmOpBBDQif0xLp3utrJ/TfNxOIWx7Op1pA0l3U=;
 b=PuBHdpdLloXqMnCiDY6Xnjftq2slVR4sHbtt/3i88+oPChM0xwK8FrihZvq1cvdl3ZnULakblBE1315Flrv6j2c0aWL6sb4uZci2h7g+c9lzT7bpDRc9OsWbznpvdLsCysLQHQY/Z6eu0x3hgabLsEKhA6kor5X2A6kl9MzmBhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20)
 by CH2PR12MB3975.namprd12.prod.outlook.com (2603:10b6:610:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 21:58:56 +0000
Received: from MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd]) by MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::146a:ebef:a503:c2bd%8]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:58:55 +0000
Date:   Thu, 3 Feb 2022 15:58:49 -0600
From:   John Allen <john.allen@amd.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        joao.moreira@intel.com, kcc@google.com, eranian@google.com
Subject: Re: [PATCH 35/35] x86/cpufeatures: Limit shadow stack to Intel CPUs
Message-ID: <YfxQGRV6axGQ8bBC@dell9853host>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-36-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130211838.8382-36-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: CH0PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:610:75::25) To MWHPR12MB1471.namprd12.prod.outlook.com
 (2603:10b6:301:e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb985889-4754-413e-28b1-08d9e7605f66
X-MS-TrafficTypeDiagnostic: CH2PR12MB3975:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3975CE08B09A0459F91CCC509A289@CH2PR12MB3975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DceDWWUVvPMwEvLbcq/dn2+nVCYsATUgq9OFcmUnVdB474e7iZnkzmlGPKaSJgbMPNRSAsWmJfoWKMXLxdi5uy2yP0FBDMGoWBKpgHbFrn2GvzliK1b+W1kmuQieFh1ZuwnbRWhg3mgQ0JT5ELkq/OLYz8G9muSOZTE7wzLueX4YWtIOpZ9MACX41u3QO9mZ3MTKMjESlMzWunD/inoKIpHC+Qt3lXJeCuHrQkAX0CS9rKIf7+hoImp+OAfYGOBsNfArhDQuWEjxlYyOS0VOolIzGMsiybt72RsXvAOkG7DzMc6ctboty2W+h2Msg+fKN89QwAl6OoU/3pz4dVmaqmpQc6e1jjza9JxaaIRCvtbSAjURMu1SwgxvA98BDUYRa+ZnD3I6afLeDxXVsjHI3x3TvFbrbdNwQnSvRxwkhWN/cZdL7KIqjzmRQtI3+yLcbxYK2ym4TXjlShzOXt8s8QbGHClGDk7+9PFjdDf9Z3V1JtI44DUxjBPaPzZq+ZCcrmrRPJxKpVO4Sj/OXzXgLbEHrZt77eFDUC9E8PAtPr5GyHxxQqd0et0vVowBQqW2alroFAJ5IKvDrly72961vAqV+N4GLBmeScUBX6HIVllgHQImvpTF6KDBnsKSK/ul5eNZ4t9ueeTmLD1NsKoKWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1471.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(186003)(26005)(4326008)(8676002)(66946007)(66556008)(66476007)(8936002)(54906003)(6916009)(7416002)(316002)(6506007)(6512007)(6486002)(9686003)(508600001)(5660300002)(4744005)(7406005)(2906002)(86362001)(44832011)(38100700002)(6666004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKOaS0TWeDZO2pXpK3GBYER5GC0/hqugsHEoChedNqZpXrE5noi8WaepLpwL?=
 =?us-ascii?Q?9k96c/Z68T2FSLPbm2Vu1X7vFpbt9uD2saBusY92H2SxgyNOQdLkYXRod+hf?=
 =?us-ascii?Q?LX8PqBLGVl14fmU+rckP+Pj6g7PIM90MtZfKVkyJyp+ZgsRerTyqVRdg89sM?=
 =?us-ascii?Q?Dl2kdMr6cljCKRiV6QjmvXCtQnKDGpX7cpayyeHSlRYXORTnbDfkBYTwGNMZ?=
 =?us-ascii?Q?plQpTRGxyIJgZYkNtxZ9VDjhRo668Ua1E9kg5Epw/lMcCJL1Iou6Hzek3EZq?=
 =?us-ascii?Q?HvQUGh878OVy+w8u9bjjrCJqu9ufh+U91Se+TBFdCqGjQF557fP+tJbR4eBM?=
 =?us-ascii?Q?OjnSNFA904BZkREUuET3wGAk+SdVCmwo8RtOFtogws7sjOyvxa9yzfKhwa/N?=
 =?us-ascii?Q?2OwKb1ORyRTtZCx7u0EhVoFdX228bMpff44BNnzpTSNOBwZsvhww41/vN5EZ?=
 =?us-ascii?Q?UHfZAY48MnnIKA6KAAgzOkN0sVnmAOI4v2TByiHfSdUrB3zOVJYtuzs9lVVO?=
 =?us-ascii?Q?Xuy4ANzlM/VNhyxBXKvmV+d1ErDWQ9WhNjF7i95HIqjpwMAYHmyuOT1lf/K4?=
 =?us-ascii?Q?mKJ5h9sTfZagTiG/VVuJ3ykNbNQAJI5hqjf7aputMydko0NraGrA4hBO93+p?=
 =?us-ascii?Q?esGHjQ9iAHIq5l5rMZwL1tK1BczEYMPbIm9PSVGp/bWjMht3jVg4F7DsFNty?=
 =?us-ascii?Q?rLkRHytjpTVwNYEVC5wQsdbKXO/CwPwwRxkYS4X11PmanTpBv6wEA1K91sn2?=
 =?us-ascii?Q?bk0SK8WKcfWKw2Bf0b+KHf72e7DT3jZ6aO7XAcBGFQ7X6HqokgpyuVOhYiAC?=
 =?us-ascii?Q?c4a3SBQGTRmenDJnGhCRSqhjK1PPmzkCRWmrxcOrz5hcyvibYb6qZx/uwCHr?=
 =?us-ascii?Q?RlQM4wSZO5u6dq6ZfxMHVY2cABZu2RoOeXH9tAo0h4ju7eAxKIH9VGhIhBhQ?=
 =?us-ascii?Q?OnOMDwaZ53aXIz14GBrRBEXebz33YecRO/Cl/SyMUvTmZoeoz8wfcuhmAqAq?=
 =?us-ascii?Q?LUOfbVvFK4h4xJPupfG7N6OUGWrmAHmt8F1N1h9VNYRyE26NMqU/J6rKOXix?=
 =?us-ascii?Q?QGVrBM+v0+4s5C6rugiDg/HbGG2C01AH9+4QioejYJBB7HL33Yihv7j58nOx?=
 =?us-ascii?Q?Jjiu9wD9/ueJmRvAR2DQ2Im/EMG5jjlOavKf0zlYqgnrUfDaspsB9cTBw5Nf?=
 =?us-ascii?Q?TVWDjBc2Qw7W42iWJOvgdV67uYaKk+Nd5nhNXhBaP7xVYJeJIeVAavO4/AXG?=
 =?us-ascii?Q?CqG+aGxlevZOxa8HEh7YmDdzxeI9SWr5zG+wRZU/5IuG7L3QOzetWi7GnPIS?=
 =?us-ascii?Q?yon0vIyeAa4NiC2KlJP2+Vx8paLppo39IoMUyEpRew4/rLDQYCjm1ZZR2zu4?=
 =?us-ascii?Q?DFPAGARPK+j+7Ij1h3eLbLK+MFC7u76DRFVCb88OzSVF70TXXJ2G+wHNLveB?=
 =?us-ascii?Q?CmA/Q7TQUm3Xkb//wHyoeh+OEqZTxEjL81+eTSWMszrSFP4dcaHB9mMAgyHD?=
 =?us-ascii?Q?NGWmwhT3sT6P3ABOBRajTSZ8rrZtzBsSSiAWYqi0fzYyi2YKn12BIS8+sPSE?=
 =?us-ascii?Q?O/sApPefx2rhkAYzwpemJ0voDSeBQsAM1m8xYvEYshr8bA8tR2kzOc9eNj8t?=
 =?us-ascii?Q?uCW1v6xMohJmvg+cvT5koAw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb985889-4754-413e-28b1-08d9e7605f66
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:58:55.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xsz2IialusX/xXA/qdcCUgWdB3DNYUIt136b57IEcEWBTX5nXBRVirZ8mNh3mLk6HaQJ4aoKGDNebY7DjSGC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3975
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 01:18:38PM -0800, Rick Edgecombe wrote:
> Shadow stack is supported on newer AMD processors, but the kernel
> implementation has not been tested on them. Prevent basic issues from
> showing up for normal users by disabling shadow stack on all CPUs except
> Intel until it has been tested. At which point the limitation should be
> removed.

Hi Rick,

I have been testing Yu-Cheng's patchsets on AMD hardware and I am
working on testing this version now. How are you testing this new
series? I can partially test by calling the prctl enable for shadow
stack directly from a program, but I'm not sure how useful that's going
to be without the glibc support. Do you have a public repo with the
necessary glibc changes to enable shadow stack early?

Thanks,
John
