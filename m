Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526777BC071
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjJFUhG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJFUhE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 16:37:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037CCBD;
        Fri,  6 Oct 2023 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624623; x=1728160623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=okMWSP0XerKBjVMhRWRlJNtJdItVBh/FgLWQngU5No0=;
  b=PAWLVaEtXepcKfRsx0lbsgIdZGHjsVONabV0zTmYOOzx3mjHnP8Hq3yV
   YgPWbuwKwiESnA/vMyMAOC9B1G47jSKrww/Ma3gy9p/LQe3zjyNFpRnls
   1c5EKCdlkg9PostfWo19iWTKOFd0ugmLUQpRKnKCg2uQxeDwqt5RPXo92
   9law70ZOZ7kdFN9vSy/+52ZdqTRhppvL3Cf8OqZhor4+3Dm3g1wNm7iOT
   aK7BBzuM8MX7o3jvLaDBHCmnaBhsfzn1Lo8M0MguWUH3LDEAyUC1El515
   i+CWCRb3YzwPmQtvpAcrU6bBOgYI09kmFhUqGuDy0ryPlRTfHZSDdkRHa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387706256"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387706256"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781772917"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781772917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 13:37:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:37:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 13:37:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 13:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp2+ig6ks44wUK6VKF5cIAebfUD+Radkga+8GNpkOhiFb9k2VQwwouet+73C1mS2KlV1A5A3ZOW+tuhsw5/lumCeePeCNl9G7oMeUChBPxP1yfT+C34MavuA0qV7YwGghE4n6okFYfAE5uuGFILB8Yq/HmSTAw6Dz9TYMKWd9LXW3BQtkBvXxtWQ9GdVcG2w7YUnEEJKUKsnBVTz2SliVJ6MazRjGq3klasGQUMQnx1Y7WcNKcSgJWBodEv86YIW6YgzkAZDWQqPeA1Ntn2AYCZpjqhdrMmtqP7wok4pdGh2Kji2cwKFLTXKEdqdJTLX9pBX0ls0AUUj4EkqTSNhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMj1No8rfb83Q72/19A0QEX6fZPIpjc6zqVTJktrzcs=;
 b=hY0j3aRqkIKSDDvmzAhTVrbz1tF6Uyb4WaQTuHg8pfren1JZHo5ikAjaYGwkBeSGKaQVaDqsbjRX8wPk+NBG2bGLnFN9d5ECoJqNSkUZGY1LAxk1OhgAAwT9lMcULKl3sgJ5xxDgff+F9aY6FyfB/BUJAVxZ+wKLgeyUSG5pvZz55p6ICvYCpkJLQTWMAenE+w3UNYJF9yhATLBK4dQsFqfSfL4QIGdrJHr6Q11LqRkW4PQjNyiDHWpAsIGmICvsjLkN5bqro/Iwg9W5S2Cdhs+cxbXbbGDxKpo0BnSLW70el49kcYLeI4HqNVSBOMGROYVZqGH082AJGivLtDpnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 6 Oct
 2023 20:36:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 20:36:54 +0000
Message-ID: <4d22540c-f38a-e22f-2cea-0c74fc6556bf@intel.com>
Date:   Fri, 6 Oct 2023 13:36:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "Deepak Gupta" <debug@rivosinc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sergei Trofimovich <slyich@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
 <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
 <231994b0-ca11-4347-8d93-ce66fdbe3d25@app.fastmail.com>
 <622b95d8-f8ad-5bd4-0145-d6aed2e3c07d@intel.com>
 <3bd9a85c6f10279af6372cf17064978ad38c18b3.camel@intel.com>
 <5d397fe4-a520-4336-b966-29bc5b798236@app.fastmail.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <5d397fe4-a520-4336-b966-29bc5b798236@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 35470dd8-3566-4c8f-cb35-08dbc6abfa77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UX+RHO0bwVCi77k3SyyhGikY6BIr6AyVfaSn4yw7O4qMPzTZxd2U7KtZx0cSzei2+OjyMRLfYIzkGNVJ4UITmvEJp+ycfu1pYMRMjQPy2GhXcvz5T8ZJgfSqCx8FolC8JYz3ZPiGeTdyDjIFExSdVGRvDIH9KSIonaNm+l+PIeUj/rFrugR4IEylzvKxpDk1eEMZE3E++qV0xPxtY6epg42fhXJTI6k9lgFxcQXXEP/MV2voxZfwK3/Nqr92RnNmAncTEd5OeBXohluf4xso8cQ0f113f2DaWiWbjTaUFLBbihyrVOwg61nIoIqT1HQfjmkfnmTxWCUXlrO4tLxr5ELxugfIJiS8/x833kjbmy1HsyMezjLyyjAKQA6RxyepjKkkvwYvl5mujs84fQQn19N0rNYF/q/5RB75udIMPizcm5N1W/Ix7guzqjIgL4TCkzLsuGTOQqMSp48VQ1+5y+cTEJRDf8eXaFz3gg2VrjhI8L11Yese/O4hSM1+HjU1g+pdgprUR4hF6JDnsIdiSvLtOPksoH+g4M895lWOmXOCSe0aT2gFnspImtGeKfm5DtUmk3cGEZN4nVb7aRqBH3Ljl6R8gVZI/vxcBubk/8snjb9NilhW8MCiKw1TYKpTtPW8IT/jDK1DdQlSa+nQXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(6512007)(53546011)(6506007)(6666004)(26005)(6486002)(478600001)(41300700001)(4744005)(44832011)(4326008)(66946007)(7416002)(66556008)(66476007)(54906003)(110136005)(316002)(5660300002)(2906002)(8936002)(7366002)(8676002)(31686004)(38100700002)(7406005)(82960400001)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkg0NmFyd0VzbEQ4T3pUTFVVUVZFM29uM0xiaVhwY3MwTXNMbS9uemo5Wnha?=
 =?utf-8?B?SzJmS2o4Mkl4VmRBbDdIK2dzb2xYampnOUgybkV1VGM2L1dKWmZRRWlzcXpP?=
 =?utf-8?B?RVlNdFg0S0g3eXF6QWJ5ZVc1WnNDUHg5OHJmMW1zT2krNWZkQ0lqWUQ5REwz?=
 =?utf-8?B?YnFKL2JxSnllZU9tUlVJTDAxMFlMdytKQUMvZHlmTnFNWURQSDJYUi9pekxP?=
 =?utf-8?B?SjJIZUpFN3cxR0VYWjBNa29zSXQ0VjlkQlFiNld3Mk9Pc1Y3Wi9tMzl6TlQ4?=
 =?utf-8?B?bVFhYm9CQUNmdDd1c21wbkk1MGwvRlJzVkQ1REJpdEZEeUxQWTlhYkltQzhT?=
 =?utf-8?B?SktQcDljNEZPaVhRdDFPMmp1L1V2N09VcmdyWHJHMFJtOEtaVTUwRExFekRj?=
 =?utf-8?B?VE1NRkRvbUFQVGRyYWJtdEhZbXNKNGM1V1gzZzdoMFp0TEZOcjBNMElmVGdV?=
 =?utf-8?B?eW9jUWFVb0NuOTRpZVVZRmpFODJqREtYTUs1TWgyeXV3d2lReTBiREFqVE5o?=
 =?utf-8?B?OWVMMG1oNUJQQlpSUUE2SldnMnNjbFhvaDNENjh6UnlhRmdscmdBcDB1TXBw?=
 =?utf-8?B?MURxVWpVbXRHQnVvMllST0diSG1KeHJmNkNIcDRaMXI0TFM3b1U3dmQ3TzJI?=
 =?utf-8?B?Z25kbXl3dk0rTFp0aEc2WVNGeDRRMUVOOC9HeEFlYThza1ZMWXBValIzb0li?=
 =?utf-8?B?eTN2Zy8wakpvYkdhd0xmTzVrb2VqWEFZd3MvWlRMWndMVThyQS9ZU2VqRGZh?=
 =?utf-8?B?SlNLbGNJMzJieVBHbXNYZnk4YVB4cllmSjYvczlBdlVRdVpWdzl5VnIyNTNG?=
 =?utf-8?B?TGROdFRqdmN1OFlvRkNuaWR1NXBSODJsSEdKdFFwa2g4Tit2QkpGWGdXM1M2?=
 =?utf-8?B?Tjdkd1pZTmVYVEhZODFrSDBtd0dHWG9weTdjZ3BrcDV6dWJtamZaalh0dEta?=
 =?utf-8?B?UmFHRXpnVmZSMEZ5b1VxNFVDOUJCMURIeXN3bTFaUGlIRC95TzRKNjZvWUpX?=
 =?utf-8?B?YXhZWEJYTjl2WFRXN3N2WmFRZU9KanNybjNHTEhEZHFTdXloUmlIc2pkZlh1?=
 =?utf-8?B?dzk3Z083MW1hSDJrKytWVURyYTZmdUpuaXFSQzN4OHIrUWpqczltakhETm5L?=
 =?utf-8?B?ME92MElJZG1qZ1JnNGlMSXk5WUVibGZBRmdJa2pnRHFRbUh1R0RPMTE3bFZL?=
 =?utf-8?B?WE90bmgzLyt5eUJLQXU4SHliTm15bVNiUDJjdkhIVTBhQ3BuajNKMTRxUzZq?=
 =?utf-8?B?VnMxMWcwUEdmQVF4cVZ6bUducjkrY1J5WU05bUorL3hhQjRnRUxwc0NJcU9j?=
 =?utf-8?B?bEdFMEpnd3hIcEVEUE43d0tpV2JQWlhXdjQ2V0lZcHBrcU9qU2VvNnNmb1Z2?=
 =?utf-8?B?TVdkVnk3QzJXME03NkJNUldwejhNV0lIN0JYVEwwTUdKOWxoWmhKRE8vR0Fx?=
 =?utf-8?B?UkR2NCtQK0lpNTluTXY4eWlFcWVpZ0ozbWQ1SmNNMVhaSnZhQk1nTXphYlpK?=
 =?utf-8?B?SlZQdFB1cEFNWWJDWU1rT0JwUmVlakZ2cWlFVGpuWXY2bFpYMm85K3R6cW54?=
 =?utf-8?B?cXdJT1JaZitxUkU4UXdyWWh3cGlZN1VkUEZMQjJwY1JNaW95ZE96aDBrZW1p?=
 =?utf-8?B?MmE0UXJDWnJ5Mnd0M0xFWHpFeDArNE5udk4zbXVCZFJWUXRzWEpKM3hJM3dw?=
 =?utf-8?B?TE91dk1CR1hkc2xnZm1MSXA3VWtqeGdRb2xRRjRaWkZ4UkhsRzErK2RnNjgx?=
 =?utf-8?B?RG5VTHJSUWlmY3NyekRITi9RNmFSUEhuU3RDMjZPNmF6V0V4NjBCTElQMHlU?=
 =?utf-8?B?UlRkdUlueGZmWHp4a3RTUW02NVZsN05YNmZxZVFUUXVwRFRGZitLalkzK0RN?=
 =?utf-8?B?KzBha2s4SVFrVjh0V0VSOFp3RUR4MFlyajljK0VkamxmWFo1NWRkejMzNlZl?=
 =?utf-8?B?YXlNUWQ5dDZ2ZmdiQkdZSGNHUDI1d2llWDFoTWxPTlZDRTR6MTdrZVZSTmRO?=
 =?utf-8?B?cGh6dEJLUXZjeFJZeENrR2czK0o1N3JrMENxWWFrSkhRTHQrYjd5UnZDYWtx?=
 =?utf-8?B?M2RCckFFbDRUVVNTNzY0aDRCeStqZzZFcVBhdDB5azNEeVErNDFGSUxZQXQ5?=
 =?utf-8?Q?oAdI0dOI7q5xoXMJtJg41zCaC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35470dd8-3566-4c8f-cb35-08dbc6abfa77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 20:36:54.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFT1uXEWS6hM3h1Wg1HQzuGmQoxCuvzk5nmpl46x8hFfSoFEUbDAffFgig4cp5sbD/SqWXXXsZkWWifJ4nHpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/6/2023 1:29 PM, Arnd Bergmann wrote:
> On Fri, Oct 6, 2023, at 22:01, Edgecombe, Rick P wrote:
>> Hi Arnd,
>>
>> It doesn't look like anyone is pouncing on the syscall number in linux-
>> next currently. It might be nice to have this patch go through linux-
>> next since it touches so many architectures. And it sounds like x86
>> folk are ok with this, so if you could pick it up for 6.7 that would be
>> great. Thanks!
> 
> Ok, I picked it up now, should be in linux-next starting next week.
> 

Great, thanks Arnd and Rick!

Sohil


