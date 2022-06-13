Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E29549F38
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiFMUdm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiFMUdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 16:33:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2204.outbound.protection.outlook.com [52.100.166.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BC522F0;
        Mon, 13 Jun 2022 12:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXrIH/OSA16b80hUqhrCPzx9ooxqHICWOnzyJgRziq7m3YoykFExXzJTDCJOrheatzG4DTGPUzqBlAs0xAnuY0B/Xjwbzad/iIly5JouPOLaC4HI6lGNE4XkFAaGhzAtYLBTSzQpvimB+HvngjGNO3eZ06wIb3FWU8TRuZQkb1cQOhamLp4i77CwXh9cJbxJ9FehsAy4rP0kteh8Kuex8O6oueP6iw05c6Y8FQdf0bq3IdK2HsYimw825OmRwh6neIXDSWBWBh/qhYoXJsJUbk/lcMZsK3Zk+rYayAc8BpvOvx2VDAIrqAO6mv70Y5I80qA5jNJA3ZCMVF3tnvjilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejRHp+UcTOOouITaszW4Xrm66IuBZfWvbS1+dB+rQfw=;
 b=Gh1jpB78qVCtk0d6Eo9ifPxPfIlR7rrRqgqauYqa5Ps6fcZ8N6KjLWCM36rT7z69nlPcW8YkXsEAtQ7vDc3WUmK8suYPzDQgAIIiYWKGxi+P8fvcK8xzafYISsvVzAN43cST5zHOYgzlFe5AFOgWV4jxTGsiXbRdOc0k8rtYLNY5XUWqmZSwZRWL8opY5IZey6LS3Gm+gLCKniJj571cuLoT8Tx9x02PBqX+4VenER09nAM5iVjz7KrllM6L4k971ifjVV/X1x1zqldzhZIhLAjyLK6+Kbeuxsm5FkyBB+wnDH4+VgfacOQNRvhZ7hl7+r7ZHlTpZ5ZliENOwav4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejRHp+UcTOOouITaszW4Xrm66IuBZfWvbS1+dB+rQfw=;
 b=GN7f2JaCeyN018ZVg8mIF1IsJ0XiFtX+hl1IknUK6qH7KFCN4gTa9x1TUyVNT+DrZmbbDfa6497/96T9/OHJIg3QTuaBxDScN5x0TY6TyL3E9tO4UsN9C7BOYxZ3obiKYusMzp5m2nOyio7MHH/sqhIIFx4ddj/daXcNeHSSMA8=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6047.namprd05.prod.outlook.com (2603:10b6:208:c3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Mon, 13 Jun
 2022 19:23:14 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5353.011; Mon, 13 Jun 2022
 19:23:13 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>, Mel Gorman <mgorman@suse.de>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "ulli.kroll@googlemail.com" <ulli.kroll@googlemail.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "bcain@quicinc.com" <bcain@quicinc.com>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dalias@libc.org" <dalias@libc.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "richard@nod.at" <richard@nod.at>, X86 ML <x86@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Pv-drivers] [PATCH 29/36] cpuidle,        xenpv: Make more PARAVIRT_XXL
 noinstr clean
Thread-Topic: [Pv-drivers] [PATCH 29/36] cpuidle,       xenpv: Make more
 PARAVIRT_XXL noinstr clean
Thread-Index: AQHYf1aeUEK+VymBJkmsIscwW/p0J61Nt1yA
Date:   Mon, 13 Jun 2022 19:23:13 +0000
Message-ID: <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.759631860@infradead.org>
 <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
In-Reply-To: <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f126017-af19-49d5-1021-08da4d7228f3
x-ms-traffictypediagnostic: MN2PR05MB6047:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB6047A96E0623FE64DB9AF34BD0AB9@MN2PR05MB6047.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG9Qmh2QLg48H3QoHdFDMD33Qm4br7HZ6rWe+mY2Rs/khBykukk4y3HAkBNVFdnCKWzkLh16hjqi3itKqufl638zonHXMc76mrqm7zdQSfhNlNQmx/+nj98qEQC5ZtZ/wj6GhoO7fcmsYQ5BlTnJDPd/HgC483XvaBE0W1zvOaPP8kTfuaCwwblLPtVlzbtBxZf+YZDrsThHjkAJKjloZrc5/MvC1R7J2lG3QK7yLE3dfyT1oId8+WwG2W6V0Kw+0KCQ01hVIf8dLHrN9prdiDWNJVUgiPBOkodAOvQvh0iyRcCK5i51PbBB2/k65mbnIuWJBrmDz/2yKBX3z69yQrSE/k6H0mciMFYs/69epSYvu9GEKqMetk44wZmIYTcjpgp+Aq+C9lqjTyrHR+6r3IvSnPEQ/PTAc2CZfW+ZFrjqMkftgQrgjaGxh0DBYcaLJWc/0n6sBuiEfKzuEd0bqz7bPLOA4Y8vr3Bzld37stYJ9tsD634vk+EOWvztNJlbhuOiF9oK/nKhM3k+gDlmU4ZB39qQqylk9pZxOfW4U38QYgHPsmxpAII6sJSxVub9/E5GHy/MgW9tfBdUL08j/78Lrb6PO5DjIxKqAquBAtshUTr4ox3bCgtYJ0+wbFn/TftJEkBWXUIqlHpFJHipWCRbMiPcwwU4iyvsaaeEPA1D+1sOgyDjwJoSTZB53IiEBqLEoHxTvr2zEuCo7n9oHnPY2tPwrxUt3yS5aNmqNvsKant7oin1dTwLkPCbpTot
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(122000001)(6916009)(2906002)(6506007)(64756008)(6486002)(5660300002)(8936002)(66946007)(6512007)(53546011)(26005)(33656002)(36756003)(83380400001)(86362001)(38070700005)(66476007)(316002)(71200400001)(66446008)(4326008)(7336002)(66556008)(7276002)(54906003)(2616005)(7366002)(76116006)(508600001)(186003)(7416002)(7406005)(17680700008)(45980500001);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEx2OUZIYjJQL0VxSS9FVVh5TnRyaDBranZEZmVTYkIzVDNYNWh0VDU5bW1y?=
 =?utf-8?B?ZlgzaEowM01RSFBZTUxNcXJmR05PdmRxVkxjUUo5Sk9iVkU3czQwUEozTE9I?=
 =?utf-8?B?SWN6TFVyNWs1R3FLS1BVZFRTc2FTcllrTFBRcExmR0hGOWZzcW1VMEZQekhQ?=
 =?utf-8?B?NzkzSk42emxWS2tKNnM1WVRrZTgybTh2SDhhL21ySkRXMUg1MTF4UHhwQnps?=
 =?utf-8?B?SW1hWVo5ZDMzeVNwOGFNWFBqUTc1WFUzZjN3b0Rld09sejFDTk9FY1ZsclNu?=
 =?utf-8?B?bm5Cd0luVFJMOTVmUVliTHpaWU1YbFBHSnJkZ2lNWCtzQXgyaDgvb0JzZkZL?=
 =?utf-8?B?N1RtY01FellhZVR2VFAwTDJWWk5HYytScDR6RmdRbE5CYzRtU1ZENWZZNUQv?=
 =?utf-8?B?WUZqNk9hRTlXejZwV2ExWmpScWdqTGs5R29PckpSeE5UNGg4NDc3VFE4S255?=
 =?utf-8?B?cmJaay93OEo5SFBLZkIyMHI0U1Z3YmNyby8wbk9IekszeGF4UWV0cUluK3lr?=
 =?utf-8?B?NDVWK0MxNFoxUkNTM2Voc3FxeFBGdE94bDV3d1VGYW1EdVNZakd2cGMrcC9k?=
 =?utf-8?B?K25QdmJJTUhTSXNvYTdlSkpTOTBBbW1hdTBDZHBCSHdLWU9CQytkZkxtcyt2?=
 =?utf-8?B?bGQyc2YxODZCV01yMGxjN3dFdElSTmdNdnpwVFo0eVh5djR4bHRuRXJTdEIy?=
 =?utf-8?B?VzJvTkwwaFUvbWY0T3QyVHJWSU9yUDRhV09zdjhvR044dVl6dVV4WDdLMERH?=
 =?utf-8?B?T3RoL3hmT3JNUmt3OHhrWWtITDQyQWU5ZGhVNmUvRC9LUFV0anBWZXNrcWdk?=
 =?utf-8?B?YWtMQVNJREl0ckdkL1d0aVFiNzBxM0FSNW11M1lsdlN6SmpDc1lObU1ZSEpX?=
 =?utf-8?B?SzlSWUswQWJUTXlkRUJidFdZQURtL3VoUzQvRkFzb3pyaWdXOHhMQzBoOEYz?=
 =?utf-8?B?ZmlVY3p4QVNBRVNMR3BHNFlnNGF0VFplZW1LZkZkeVdlOE1weVFnZm5KQTky?=
 =?utf-8?B?WkNlOGhlaGo5Rk4vZlhIL0o4NU0rQ2xSK2VDQ0VrbW1CdVBQYVBnYWtQR2Rp?=
 =?utf-8?B?S1Iyby93d2ZtUWtYc1F3Yk1LUzE3Mk1VM2c1WmJPV21XNWNwdlRjSW9kczM2?=
 =?utf-8?B?WUJJaFkxd0pmUWt5c3VvYkNjUC9NZkhLZ0F3VmVsUzM1Qm1hN0FtZzlqbnpE?=
 =?utf-8?B?bDFmOURadS8xbG1DSC9GTTZTZ2NIN0hHZGx5ZHpnN1NtRFZ1S0NoTEh1MUlT?=
 =?utf-8?B?Wk9TemprV2c2cTQzcHlXaHF3bGdLbjF4OXNxMWdPY0dLSFJia0ZkTWxMdUhL?=
 =?utf-8?B?cXRjWVRLaGdhZWpWMlpnN1hwdlNDYnpwRnFVK253V1A2dVp5WWUwaExXaEc2?=
 =?utf-8?B?ZlpNTWpaY29VUjhNQ1piRTRsVGpCbzE2LzJDN2JpTlZEN3RXSmV0VXRLQjk0?=
 =?utf-8?B?WExVY05SQ3htbitQTGdqRWJtVTJnQzhSbmNnYUYvM1ZhV3UvNFgyWUxoeEZ4?=
 =?utf-8?B?dUN6cGgrZjh4VkcrYjg2TEU0MEtydlN2N0doTVdnbFZxMkthQnNNdXBlTlNT?=
 =?utf-8?B?MmlIVWtPVXFJWk84Sm1YbTdRdHBicXhwUXB2cFQySk9mSWk2V1hrTHhVQVVV?=
 =?utf-8?B?WW5mcVdPSTNLeHhZNXRyd1kzK0grdGNEbjB5MW9WRCtGQkVxWG1aL0ZDbzZJ?=
 =?utf-8?B?RzVNRWgyQ29iQTN4clh3dkJKWG02QWxIL1h1SUZUTUpiV2tFSG1XTVpPMkpa?=
 =?utf-8?B?dkMvODZBZFZtMEFuQ1o3Zi9UK0NRazJzSE9IQmRnbzMyS0xBTW9VUll5SFlF?=
 =?utf-8?B?WUlXOFUyR0svR2QvUmJOTlNTTzFveE5XMXpNMTZMS0V1NG1pMlluMlFVd05q?=
 =?utf-8?B?bnp2REZ0QlRHMVIwRXlhN1Z3QVREODN6OVJpNllHNXkxSDRwZk5aUS8zS1V6?=
 =?utf-8?B?RE84dmlHTEkyN3FqRy9UbGc2d0FMY0hnZkgrZlRyUmRuTG1IQk9lZEorbmww?=
 =?utf-8?B?YUFGczJjTVY3QTl1bFJ0NWxtOXFJV3h2UzV2OTM0ZW1EMkxqa2tKUTVsQ1ZR?=
 =?utf-8?B?U3FIdjhLUjdjN3VaNEliTU9ZL1VUR2Qyakk4bmE0MHgwYnNCcDNlSmRKZU1I?=
 =?utf-8?B?cndvc1RtQVR5b2xrbkI4TEpQWHhkMVFHRkxJMlRMNjFpMVBrSTEzTmtTNlFG?=
 =?utf-8?B?cnVQcmlLd1VMMkNFd0k4YUJTUzgwck9HWlVxd3dlL1gwZnBMQWZ6dVNKRmhF?=
 =?utf-8?B?ZzYrMXkxYy9FdDBKT2RpY0UvZC9yWTZ6UU4reDQ5alJwY3dvYzIwbThVTU1V?=
 =?utf-8?B?RGhKdWVmL2JjM1kxQXgzSGNDbXdrWk82MFhoRjdwanNnMVZIeENCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <342EB95D035E904BB3A2D5C393810F2D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f126017-af19-49d5-1021-08da4d7228f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 19:23:13.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMjx1KcJtUvjtNRexJ5MAHdBZ4v4OLNTsROICFkNXlOqc+7yT2GH0KrnUxW/fkEbqTS1GHk3VRFzVY9Z4RmShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6047
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gSnVuIDEzLCAyMDIyLCBhdCAxMTo0OCBBTSwgU3JpdmF0c2EgUy4gQmhhdCA8c3JpdmF0c2FA
Y3NhaWwubWl0LmVkdT4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiA2
LzgvMjIgNDoyNyBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiB2bWxpbnV4Lm86IHdhcm5p
bmc6IG9ianRvb2w6IGFjcGlfaWRsZV9lbnRlcl9zMmlkbGUrMHhkZTogY2FsbCB0byB3YmludmQo
KSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9i
anRvb2w6IGRlZmF1bHRfaWRsZSsweDQ6IGNhbGwgdG8gYXJjaF9zYWZlX2hhbHQoKSBsZWF2ZXMg
Lm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IHhl
bl9zYWZlX2hhbHQrMHhhOiBjYWxsIHRvIEhZUEVSVklTT1Jfc2NoZWRfb3AuY29uc3Rwcm9wLjAo
KSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFBl
dGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IFNyaXZhdHNhIFMuIEJoYXQgKFZNd2FyZSkgPHNyaXZhdHNhQGNzYWlsLm1pdC5lZHU+
DQo+IA0KPj4gDQo+PiAtc3RhdGljIGlubGluZSB2b2lkIHdiaW52ZCh2b2lkKQ0KPj4gK2V4dGVy
biBub2luc3RyIHZvaWQgcHZfbmF0aXZlX3diaW52ZCh2b2lkKTsNCj4+ICsNCj4+ICtzdGF0aWMg
X19hbHdheXNfaW5saW5lIHZvaWQgd2JpbnZkKHZvaWQpDQo+PiB7DQo+PiAgICAgIFBWT1BfQUxU
X1ZDQUxMMChjcHUud2JpbnZkLCAid2JpbnZkIiwgQUxUX05PVChYODZfRkVBVFVSRV9YRU5QVikp
Ow0KPj4gfQ0KDQpJIGd1ZXNzIGl0IGlzIHlldCBhbm90aGVyIGluc3RhbmNlIG9mIHdyb25nIGFj
Y291bnRpbmcgb2YgR0NDIGZvcg0KdGhlIGFzc2VtYmx5IGJsb2Nrc+KAmSB3ZWlnaHQuIEkgZ3Vl
c3MgaXQgaXMgbm90IGEgc29sdXRpb24gZm9yIG9sZGVyDQpHQ0NzLCBidXQgcHJlc3VtYWJseSBf
X19fUFZPUF9BTFRfQ0FMTCgpIGFuZCBmcmllbmRzIHNob3VsZCBoYXZlDQp1c2VkIGFzbV9pbmxp
bmUgb3Igc29tZSBuZXcg4oCcYXNtX3ZvbGF0aWxlX2lubGluZeKAnSB2YXJpYW50Lg0KDQo=
