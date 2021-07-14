Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72973C8AFE
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGNSiD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 14:38:03 -0400
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:37967
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhGNSiD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jul 2021 14:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exe+U80WiDLESHlPTpu5Mh9w24oQ/MFhbWQMsJz1M1+2MSlyK9YNWE1qb/9/6vqkEMGjjXXUWeWJIYSabbgV8jpmadAjvkMzwFTUGsoxg3+dTZK5VMtyQRXR05wI4bPFU/hajyVgl4Qx755+PZmxXAKp3LvnNKDJWtY4YBT+3FkkDdwYyDPlxd2kU4xbibs5kahx3MSzjivpmwAxNJba2W9bj/VNrG5rQDLejHvdQ8+WLZYeSq4X4C+ZPeDQYzeJIyUnFuYi10bz8gJ7s2uHt7JXvtDuLpY4Sc1x7VJzFmRDpjoOCx/bu+Z8PwBUtV5lkwAtV/jrXBJDeiyF+NIe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtFTw4/3OS6kFFlSBZViTlQn82jDewwJQKsTMdHxMfk=;
 b=ZLM1GxyrrNS8RKD61MqeqkTHKdNHRV5cU84uOelmwnNaeRSniHVqwXKefJ2+hRgYJ7LHPce9PATceeToikuEJSz5+vSKUiff4l3GEzMupuSOsh7nusylV3J2eCeyH//5wWI/C77JOODZ8CAstDHoIKqhWKgivepviUbRu00PAXO2QDFcyvq87/4cf+B33ErC4iV/uUwm7BqLy9fPysuleSkeGc9H8p/+BNywvXgsGJMrDsOROiPkWkz+7ytTCPMHZW22F794cs8hHJoVeLz5t2tvkLu/9zET1h50ZHRUIvkbzZqh1ynaU4meLucNxcTU/nO+bUV1TdPpGqo6y6713Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtFTw4/3OS6kFFlSBZViTlQn82jDewwJQKsTMdHxMfk=;
 b=g8xX+bjGq80NdfClK/09rElKlRh2FL19YXIR4Tr/fTgP2lnZ+A2uDp5TuFglYB96W3WGNFz+Pp+AKFGbV1ThEFchVvOSywMNdrCtK6quleRtXB2WYun4et/27hKKcH8c7KOw2efAtTtUqpRmF8mFPjqEzYTPJGLrvIgYanT3UFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1061.namprd21.prod.outlook.com (2603:10b6:4:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Wed, 14 Jul
 2021 18:35:08 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%6]) with mapi id 15.20.4352.008; Wed, 14 Jul 2021
 18:35:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH v2 0/3] Additional refactoring of Hyper-V arch specific code
Date:   Wed, 14 Jul 2021 11:34:44 -0700
Message-Id: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.16) by MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 18:35:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956f60e2-111c-43a7-d593-08d946f61b27
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1061392811EA328A34F4DFABD7139@DM5PR2101MB1061.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w2vhVTwsp99cPVc8GtHYsu51IXLLVmLM4Gf+gBtmLZArQNPdACrw49rsj5ZBDjhgCgZygeAekbmvhEAjoRu/2L+PYr93g/0oAy+upbBnLfKsvgXJ/TLP2hV6Js2HkJcnztr3TebZGMMDfmjMq8zJd3Yk0aLrsfHNW+fCni6HoR8vI+Y0QU9yFw3jXinJUYUII+C7LZg1NgNVKpGWpYqkF48cQLrsdOUx+60heU+TMwUwJrmIIuc8G6wjGPiKTQnX/nzT1/7Za1a+pc4DWR3dCVy/EdfUDtJ7U5jU2k4YPsoQu8kIV3035cwcmVBBolyCHwP35wPEQVvRGA1QYKwAVMIRAhDUsJRHFz4zvkVSTjPq4pcza8XOgxPyrB2ZdMT3dlxL6tBUx7TUgrjxMazgTYlSA3ypefAu8hcFiR08qmdvdw8W/bnmq02R3spOFzYQU45feZq36xQqeRUog6bc10cZ2VVde5Wb9YjVVSa/jwh+e7ygmHJlGh41j2EhtpYjE8cQ9sc8Pk6szOLEcx8TgL/VSdqweQiG8VrlnBOz7SY2wK3mG36Ln71i9q8pnf/j21yYcuAASE8yUIWb9mnJbdhDddYfZHakTx2HJXG9cDfV+P575khVtjiB+QzWWbfR/GDQJ2WfTNnctX+m6EUkndZxKLNHoUJbUT5KLR1p/nq6r5XDrLlPCKdfkQnEtJLMgaNN9+3QmXlfoEFHqfw8DCSBxNezzsyottTSBD5tMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(38350700002)(36756003)(6666004)(66476007)(316002)(10290500003)(26005)(921005)(38100700002)(5660300002)(82960400001)(6486002)(7696005)(66556008)(82950400001)(2616005)(956004)(4326008)(8676002)(86362001)(186003)(52116002)(2906002)(8936002)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pNeG7rYMZx2+QJ0ThuFF2hCD+js7AxtybOLFDhARpS2a2vK56whubEH5yIMg?=
 =?us-ascii?Q?P+odTcapJ4VsGOMGdOJEIpFPDps2yZpNftuKSKnxo/UVapDWYDPKrhk8pspG?=
 =?us-ascii?Q?Y1MIvsSsNpMIomS+tDC4sQaIXBrHXSQW+5aholYPZEl7hw3bdihtUe74flHS?=
 =?us-ascii?Q?mXc7Wb7mWcQuZlrw3u1FMSpzO1n9alTjqSjo2d9vhRei3SfhkmXA7ZQGI1sI?=
 =?us-ascii?Q?a3h95+Tzlxy7oZDEnCPat/8nc3e1lpkRp1AxzpxbrfF6YKdZqKpLTCzMl3+j?=
 =?us-ascii?Q?C2zkz82tBSYktMftCrvt5RIcRxj0cXh4v1ckwVrYaLg5AA4tVBbHH2cVhHbp?=
 =?us-ascii?Q?uIx1Cs6mrwpjwtEn5uPlgu5KQD21iZGrjGX/kVlG8OhVBDjs7oPoNI5bduYO?=
 =?us-ascii?Q?apQOuVf6TX60cUTIdOCsXTskvKO2SySXKKG2/eBOst7FgMbCDJbTYlcGOZte?=
 =?us-ascii?Q?R9ooGy9JAgJC3LpljegBuWfFBGM9by5dleSmCXSosBNAwU+NSbx086u7gYjg?=
 =?us-ascii?Q?2NztuJVx/fw0sBVXYlM2ZU8+s70a8AlyL6aMK258grogp05Cit5+4os/YMtu?=
 =?us-ascii?Q?51TjjjuvQ+t01myhv/sYjb7x9EjuCQ0iHPNVvOX5xSbZPqQWJafW4RHsK+hW?=
 =?us-ascii?Q?zwfg+dbVOvh2Vs/78HRkO2JiShcH/4pdPHuXsUfe8pe8blO6k1U30XHsZykj?=
 =?us-ascii?Q?nEOrx0fJhkLm9VoHvfL4o0snTKLu10aRdZssFGWLHj2+EDwDEt5fQ8vXjBDF?=
 =?us-ascii?Q?lp1P9D858wKOKj2T8id0SMpH4icMktbvKfyiJnJRqnNsfuo4wIHYGJXuP5qF?=
 =?us-ascii?Q?FvaXobxFq5El+fs70zJyivgMiMb2bNDk2VTwGLg4qXXnOND8nSQEQ07JcyB5?=
 =?us-ascii?Q?7Zx8YGRlMeA+ETN64/fARlKt0Vo9nW0kXJoYc2/o0aUemAG2pyf87gwrG1o5?=
 =?us-ascii?Q?cEsebCwkcFGMQeHw0Dtbg7lp5VGJgBuprH6wjRHdButFEnYY+UmFeM41lRgv?=
 =?us-ascii?Q?3yzZ5vhwf6981IOmTfg7L0KIigAmbjNNq/qRGXIbr6us2vowvnrWqt1Wce3t?=
 =?us-ascii?Q?2V08aDdlzVW46BH3LLnLE/RBTQkwr1FyvtwZhOq6i69+nvAEnILPlFQ9rx2j?=
 =?us-ascii?Q?D2EPemfApXFdUMEkkootB4ttsv2cTTJ67Ipvo0A0Q3QTihk+zFyxvPoLKS3Q?=
 =?us-ascii?Q?W6iIEXuYs8jVNwqukybJtQCWEd1P707UDCoHo5wOqUfYk+ghFLrj6GX5pnWH?=
 =?us-ascii?Q?Dw0sVbdXU2qXVJ5X8kz17L6e7d7KQ4sQcaMfKaWuQZn0leA/plNr4QxH8l/Z?=
 =?us-ascii?Q?3B8V6RhRvQE+H7iOSisohdmq?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956f60e2-111c-43a7-d593-08d946f61b27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 18:35:08.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9VzqD71sbKYKeNowyREw8lZH3lv0pgL6NkcTmgXhkB3SYTSfaOHEeKhlScITxJLvgYMydVsd4BEYuKyqijVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set moves additional Hyper-V code under arch/x86 into
arch-neutral hv_common.c where it can be shared by x86 and
and ARM64 implementations.  The move reduces the overall lines
of code across both architectures, and removes code under
arch/ that isn't really architecture-specific.

The code is moved into hv_common.c because it must be
built-in to the kernel image, and not be part of a module.

No functional changes are intended.

---
Changes in v2:
* Fixed problem when building with CONFIG_HYPERV=n
  (reported by kernel test robot <lkp@intel.com>)


Michael Kelley (3):
  Drivers: hv: Make portions of Hyper-V init code be arch neutral
  Drivers: hv: Add arch independent default functions for some Hyper-V
    handlers
  Drivers: hv: Move Hyper-V misc functionality to arch-neutral code

 arch/x86/hyperv/hv_init.c       | 101 +++-----------------
 arch/x86/include/asm/mshyperv.h |   4 -
 arch/x86/kernel/cpu/mshyperv.c  |  20 ----
 drivers/hv/hv_common.c          | 205 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  10 ++
 5 files changed, 226 insertions(+), 114 deletions(-)

-- 
1.8.3.1

