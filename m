Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F66EB6C2
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDVCTb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVCTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:19:30 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401761FFE;
        Fri, 21 Apr 2023 19:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2gKLX1XmzsHvL5ogo1wtToK5tWFVwIOZHzVHA0NeCggRonTiSYDai2ePEFrHmoNwGfRmLwMJ/WK67uRmRucpfrHaiHGuu1X169xfARL+hRWjxrgIOiZ9Pmx4/si5bOZ+yCbDPGhs1sBfSA81WEXOAZOwRP/Q/gC/LvN9cfgNADIVom4VeF2Z7Siioy9aLpHlC5nkammsKSpswMmWkVlwZdsksfHjN/nAQtRohHKITVBFmy5Md78ig06XVQHk94TXJ8uLI+LvJljxw1JHCjphar5l6osFJVyPWuhQyH9GpaAEvqdlR9uY8r36TAxwqz/dkMB5CQ8d3IgNpW53hgM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv6dsCt8BNpqWOhT8a6MVEWwcGFEr/By5pc/AiD+EJ0=;
 b=AVOtMs/Wuipd/EqohlkboDAwNeAHWHXzF5uQLAI0I8bu7vSYh7f38047Ewd0IQvM09OKWMGSn6Yb4eNs5KU3I7CA+jzW2KN0k6SUI+PQ70DjW//9WGD9gpC2ad+HHUeQOmcIec4njT2uoVtDY+RhtM2vfve/A7TU16w6fL2o+YbgQj+u1naadFaCe5IVSl+LcxvDEe39Ajl0aP3NJ+Lt1eCWAbDyL7BY+cHRnJTcquRMJ191sBYbLicWRkmo3pVW3HtBnQfmsuZ/Hq63/jE1uNqfW7oQ5Q4NArAIE/5Dq8PDsbJ+wsOqME3lENDWmKp3iYDA+GdKiGFnYY8TUwUKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv6dsCt8BNpqWOhT8a6MVEWwcGFEr/By5pc/AiD+EJ0=;
 b=EtsUjXJkVovNt1co2MtOzHjiDxVoyZ4gvmx6+1MiG4ttg/MLSU1BiIweMLhy54d0n4sRhYaW6tDV+0mY5HeA8Xv3MpxN8wTRuXPDzQ7d9AeTfVpQNepmr8h1hojkPD9tIgpnU3WwbwrPk37Sck9oa9k2na4IA4NvYwEOswkUTDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:26 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 0/6] Support TDX guests on Hyper-V
Date:   Fri, 21 Apr 2023 19:17:29 -0700
Message-Id: <20230422021735.27698-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:8::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM6PR21MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: d6da60c1-c570-4268-d815-08db42d7fd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0y8JqzXRi5F9ShYSj52F9T5z3brwFDbZ4DysBk0Cl5Svws1p1GMeZAbeejck2PpFGiEpA6/U/Y8qsG3OOhRgADG+QU4slncVOvZMEzAsuzPxj8Z9tQMakROqRgKVt1k3viVJ5iG/C1bE9ij2Pwd/gCLeFekKtqrPN1OgL/0JBo5EDixGnExAq2P95sUza0LlpSI/AbEDqnZMBs5oaAOzkn6+sUJWs9pmBYVgsCYiuBwnWf+rreeLG6ghC2vWqEiSqQhrxiXK2twypmQaXXfVN35q3zCI3Um1cz/MyeFH6ItQ0GtHFfRJS18Dul4UHCKOxDMrQnI7itKRpKT81p4IEP64wIgzy3gph9BRNYZgleZYqFfLJXS0nspF1TmFpFMWG0HZSXESjXI8DEYYUvfhic4FdVIIWX9HcKEK1n9NkBwfj2zFThsfpkQGnZ/QV75iWc9nu5OQiC1Bez/MRfgxu0V4ibbHmgV/n2KNMg6cwHhAqoKbhBnU1PYCp2SdITJ4vUMRyxCasq22/D55CLRwuBvYHO73vD12auuGEOsfjh/KhaUKaSizQhdewe2kGMsdSJ2Fn7RPM0VTjO5moc4wuD6UFrY+8N2etfrAPKTLcB/T3KrI+5pSREfMhfViPSiuQ+K7DhCze6oJB5Wjp3IFl6NWHhvAYBVcQwGna9UiZiIKlQZipB1hBJkYhb7iP9Xp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(83380400001)(2616005)(86362001)(107886003)(6512007)(6506007)(1076003)(36756003)(52116002)(966005)(478600001)(6486002)(66476007)(4326008)(66946007)(41300700001)(82950400001)(82960400001)(921005)(66556008)(316002)(786003)(6636002)(8936002)(8676002)(38100700002)(10290500003)(7416002)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UK572fRQEsJT/Uh8yINRy6JnKfeEkN+SG2hAN9WRIZglVpDOhLu3MT9Eig4r?=
 =?us-ascii?Q?oYstdOg5+ecXW7uQDzl7FPb21CSYv+8FgZ471AEFMIHxrxWvrxgHRmuBFMhp?=
 =?us-ascii?Q?7G4+WO3h5tkIZrul9zEsnHd6RdS/O/dh7cmlTrLLB8HD3TBRIHoDhKVP3fmj?=
 =?us-ascii?Q?wXKhxs8PhShsLGi1iwrlpG/Eg7iRxiY0eoHGYo90vPUY0Tenr+Rfs6D+B0Aa?=
 =?us-ascii?Q?QOyurd/WMBYxAyU1QwGFlE2sWENMWBqI377L32tpWyqctyWQbunk60p/PtR2?=
 =?us-ascii?Q?753rMu8omgTEawtguno0EV4UEW5ZCYU6t9WJoMrq75TMfeCqDLEMIxgLinDI?=
 =?us-ascii?Q?Cv9nc5A0PwdInXjqR5vTRdiKIFcIdrnjWcaFXHkeO4HSpbUjOo8jxEbcUW3x?=
 =?us-ascii?Q?PVUcvJbeQuBkbXsQ+7YTn5bV+wBTsjlrLm62925BNH+ueeJQFa+E4s13hm2S?=
 =?us-ascii?Q?VLQO1JlZzcNvMAQ15HTNDNNQ0YMm9yewlSMCanQf/SgjxYMLSD4KmkR6/5bq?=
 =?us-ascii?Q?WaXtA1TIsWpXYp2J79xejqeV/QYvNewyaGtDms0Ntze8doddiN3hgM6lM9kB?=
 =?us-ascii?Q?A4hA+neRfsomE98RoToFCak754FdSOiSj5PWPn9lTxW5mea+860fWEzhNDe8?=
 =?us-ascii?Q?8y28lv4FKMefA6gZ40o0ZCwdtykw74dcg+1uN8lW/z+5Xs27JkZ0xXiyMJ6s?=
 =?us-ascii?Q?fbVJ/EjYujs+x4ZDrvBQ6Yg37DpYwsZj2MP99+mSQXqZChEYFZODTzBWejZX?=
 =?us-ascii?Q?lYN07iMahb7WcqXvZYp7grmfyLEgMzI9xVKTKvif6Wogmp0NpzzAvnJ5PsJh?=
 =?us-ascii?Q?M7XHvxyLbzOKnwtHXk8OI7J3Wek9CoK8KQ/2ZtmVXXXOcfMMiHhxEDFferkK?=
 =?us-ascii?Q?XyIGEcbkKqfOLdL88vJYaVlutN0qCC/NYYHZrSwL35KIcNwxReFAVNu/sLn7?=
 =?us-ascii?Q?kKhvlXRpPmQL0XU1BxMgg3JQJV2gj+TU2K3ScIkDryop/G18SQ8wD4Vi1i24?=
 =?us-ascii?Q?BGPoYBn3oy7c04102gvoSpfjFnuw4ldqghLIZg2SOKBtPLOnZqrpWu7ZHDHY?=
 =?us-ascii?Q?xb+VU4kae/gAiVLdWp7xqYg1LPkaDocYbYiEIfo7Peute/+yoDpzDpWdYtBd?=
 =?us-ascii?Q?sD9XVKZQVmenX0nMBDoolu47QzfWZ2cX2C6a6wHgksT20l2mjBXSkhmUJ2yO?=
 =?us-ascii?Q?F7FjQsjzbpfaCVjDJFRrlk8LG2XpsNhXtYUHL+QS0WZIAQgpr2Y8Oo2h4jZF?=
 =?us-ascii?Q?P7k2JBk9Elu1v5iRIMFbzPhQb+ECUncfA4wrSdsq6bSgzcOHMstHuui3596J?=
 =?us-ascii?Q?e7kLoDOJENcY9RULSnBEqnoSFgrkZKuDP3YQrm39Ygbkniqc38KTKrM1LRBq?=
 =?us-ascii?Q?ieBNPaHKPdmLZflf/Pv2EHTHUlAo4cTt7TnTzf8gMwr1hBJrBvXLWdPcVdPo?=
 =?us-ascii?Q?UOwhRNWK60juhkMbjuyrcXSZlltQf/dE01NdWrloTTWGWhw3I5N1pBOXUiwl?=
 =?us-ascii?Q?kdUhDFg9P+p9T21xKaRn2aJ8x1jUIUbY5u/CrzviNAlLan3QA8GI+t+TywQh?=
 =?us-ascii?Q?5/SVcdJzEQJvGefQ4N1lIgo8Nm6E9C6mHgiRXG7Jnv4SlbfN/jbvonNe3i4n?=
 =?us-ascii?Q?vsNf2OgkhEZriZIP0nhz4F9N+fUHOFI5TZzCXEEH0hKZ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da60c1-c570-4268-d815-08db42d7fd9d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:25.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J28DJxTQzJzthKCPT473qFI4SN4Z/JssQUUSZd0H2Z5dRYDSIAQsizEXqVjXzP4sHsFGzcnxj8R4ycl0ziV29w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review.

This v5 patchset is based on Michael Kelley's v7 DDA patchset:
https://github.com/kelleymh/linux/commits/v7
Some of Michael's patches are in tip.git, and the others are in Hyper-V tree.

This v5 patchset addressed the comments from Kirill and and Michael:
1. Added Michael's Reviewed-by to all the 6 patches except for patch 5.
2. Added Kirill's Signed-off-by to patch 2.
3. Improved the error handling in hv_synic_alloc() and hv_synic_free().

Please see each patch's log message for the changes.

@x86 maintainers: Can you please take patch 1 and 2? They can apply
cleanly to the tip.git tree's branch x86/tdx.

@Michael Kelley: Can you please review patch 5?

@Wei Liu: Patch 3, 4, 5, 6 need to go through the Hyper-V tree's
hyperv-next branch because they're based on Michael Kelley's DDA
patches. The 4 patches can apply cleanly to hyperv-next.

If you want to view the patches on github, it is in this branch:
https://github.com/dcui/tdx/commits/decui/michaelv7dda/tdx/v5

FYI, v1-v4 are here:
https://lwn.net/ml/linux-kernel/20221121195151.21812-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20221207003325.21503-7-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230206192419.24525-1-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230408204759.14902-6-decui@microsoft.com/

Thanks,
Dexuan

Dexuan Cui (6):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for TDX guests
  Drivers: hv: vmbus: Support TDX guests
  x86/hyperv: Fix serial console interrupts for TDX guests

 arch/x86/coco/tdx/tdx.c            | 122 ++++++++++++++++++++++-------
 arch/x86/hyperv/hv_apic.c          |   6 +-
 arch/x86/hyperv/hv_init.c          |  27 ++++++-
 arch/x86/hyperv/ivm.c              |  20 +++++
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  20 +++++
 arch/x86/kernel/cpu/mshyperv.c     |  43 ++++++++++
 drivers/hv/hv.c                    |  54 ++++++++++++-
 drivers/hv/hv_common.c             |  30 +++++++
 include/asm-generic/mshyperv.h     |   1 +
 10 files changed, 289 insertions(+), 37 deletions(-)

-- 
2.25.1

