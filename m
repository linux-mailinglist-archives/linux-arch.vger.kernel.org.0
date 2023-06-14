Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08DB72FB7A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbjFNKoa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbjFNKo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 06:44:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B0A7;
        Wed, 14 Jun 2023 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/5UwTO8mM/d+PdsZUsumhkIs0XTVLCwx093A6dBYHU=;
 b=dtk60092f3Q3mq8drhtv5IlC+HeN55Mvf5PGObalphbMarb2qmYLP/iDC7SggxQi4Ix5uFFdAxduwohpCFPdro39tnbTlqu9nlSqXJd2d9BOY/pxca1R0KNKuN+yxmvFgCRqQ5Oh+Bhk3vsocasjHbYABRM6blLjCWEw35WRnDU=
Received: from DB6PR0501CA0021.eurprd05.prod.outlook.com (2603:10a6:4:8f::31)
 by DB9PR08MB7606.eurprd08.prod.outlook.com (2603:10a6:10:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 10:44:21 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::5) by DB6PR0501CA0021.outlook.office365.com
 (2603:10a6:4:8f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Wed, 14 Jun 2023 10:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 10:44:21 +0000
Received: ("Tessian outbound 5154e9d36775:v136"); Wed, 14 Jun 2023 10:44:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1dc45ff334746820
X-CR-MTA-TID: 64aa7808
Received: from 13db08e3c4a2.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9FBAE6A4-A7BD-4E52-B7B6-966261D9A778.1;
        Wed, 14 Jun 2023 10:44:13 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 13db08e3c4a2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Jun 2023 10:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL+riDka354UYhkSiThf62DdLAg8sVAoJ+TQ7snGhrf5xOrsuGv8C9bNp0ImG11vGPOQNHA9eQpHfw4SGcDe4FI4Z2dtSXQIl2LBM1yaMO1AQl38wuf0k1PzGjuhk00YKZgB48i7rXacKzliGjHM/pm5XDdbWswesa36Ojl/Y6fd5zxQ8gnnuO3zl5vhQl9KmHKXjE/fuVp3gtvOvh+UEHq5sSxoRQvCf916cLBs88EsHHAqJC6+ZrAHezFs3zsPlukxSo12fPKKeaFDpnvYyDGnT/5imva9mwFX+GVeO7x9v0CxAK3ZJ1183XFFprk1zRwhdcrNufsS47neyzSf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/5UwTO8mM/d+PdsZUsumhkIs0XTVLCwx093A6dBYHU=;
 b=kclBUNUE4LWcNxqN1hkmkDFn2TLnMNmI/bhOlDHqtADwR3i1zWk3gnM7buA7VoNNLhEANfg4w+mTQZHN5zu48TEDdQWOzpyCWRdbuKoB8RfEN6ws8YCRZulsbekzv8PNj8ebChipSTjBR4GwnoW/4IqOl/nl23RNUKGhqDcrrElAnyR+6Z9kw2suI6W/+Q6UX+A0DE0QQ9PRKgEu2iT1noSEjTG5AEQonmRttIqzESNmDjZfU2mwCltzAoR6aeS29baFxM22UTFvYXEnJdDmYXZgVlOa4X0OgkxORHlodWiTVKgCTa++/tn4JoKTyUt+UPylhvQvYaT4/ik3aotnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/5UwTO8mM/d+PdsZUsumhkIs0XTVLCwx093A6dBYHU=;
 b=dtk60092f3Q3mq8drhtv5IlC+HeN55Mvf5PGObalphbMarb2qmYLP/iDC7SggxQi4Ix5uFFdAxduwohpCFPdro39tnbTlqu9nlSqXJd2d9BOY/pxca1R0KNKuN+yxmvFgCRqQ5Oh+Bhk3vsocasjHbYABRM6blLjCWEw35WRnDU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS2PR08MB10373.eurprd08.prod.outlook.com (2603:10a6:20b:546::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 10:44:08 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 10:44:08 +0000
Date:   Wed, 14 Jun 2023 11:43:53 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZImZ6eUxf5DdLYpe@arm.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
 <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
 <87y1knh729.fsf@oldenburg.str.redhat.com>
 <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS2PR08MB10373:EE_|DBAEUR03FT051:EE_|DB9PR08MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a14c2c-e7ea-4c71-65f1-08db6cc45007
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m7Km5Ok4ZIP+nSTvDnKfIOEXa9sklQ8wp99SMVV4nN0vVgRlqhHA71G8VOmbHkuoaljlRRjXBnfaqr6+9Bex6Q9hGgi0oiBdxyGLoG3utQTfeu5o/88HaQNl5G0pXZ7SeiTQb1yu86tQNNo1Nefs6KxkrAg+hHid5VUieC10Ev12uT2C8pJuBLnoWFvM5zpAGQ5J6AJE8EJ5qgjU+rIjb77QzD5aUHEAy/HEZnIBJA70QrhDknfT+yauFLXhDUH220Wq6qJnaglFluEXK5piMaPhU6qrs+Sk9S77OmnBnymOdHcYE3WYuMU1QopQIdZ1Aw8UrRwnF+CNtL0+jHS6ChlkKUbFEnkyMqvYiW0vsMnRsZJBMOx2YQR3K1/xDCGY+G72KXFB7gNZVrFFIkkzwELLn7ZgW52TZJPnadS5qjipvyc2vghFVXhXcDskeyO3M40SCW+iv+Bc4J0g6NzNBS87Fa2ddFc/1MXePT5p43mMke2M0es02xFX6VnPvcmfE9ipkJ5cvtlKD+ad9rF21slhTKU63sAXI3ZHoMQ3Exo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(36756003)(86362001)(66946007)(66556008)(54906003)(4326008)(110136005)(966005)(66476007)(478600001)(6666004)(316002)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(7416002)(7406005)(2616005)(38100700002)(6506007)(26005)(186003)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10373
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d3f22545-4d88-4662-2456-08db6cc447d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MO6ftLcw+m9cdBgCY24cuUmd2JIQVsfevfrdu4RKnQnml4sxyNw8MK39gg+LmGEeKc+HsD3hzSlB5teWbamzCVuxk8fFlMfejqj3zcJtwYFLxIgaY/gLSvN7GLJiLoS6YfHu1qONNtlpHWOo3BQZjAy/NlRJzPbIEFsPGAxnG9+jPeI2gEoqvELAF2HvkrT66mia3K8khxwwvBZh0ODgTmflCy4wkXHs4hVobIoZ438bsw93OCWYY/Dh+ijIfdch+a/a9zQJl/wwN7rQo3Tx9Mgk/MLoKIeImiZK7g7lu/kFO/HUe/zSlMBQYabrjE0vSyDLXJVg/1EOP9m+Lq4+phhA44Qom7y+4z4vfUWV72TJ3BITuOVmRtIROMudTbYf0DzDaKz6fwhl/yfIJp36kTaXE6Fv0nxoCKHhJmgIzB2NqpUrWP6dcA6ulpjozsURi7g4Pgbo6aeVpQwoWRSD0YNIBOwR/APdB5VHaiaWiFBgo2l+zz5OL3OYx08s5gmXq6kjibJ2yHaKWWzEQ5J4BIuoqiEZ6C+xOwWD6DSHqxhjkAYKZTjTdRxSiYQ1G9a6/6UB+HLKKpouOPrh5fU8EsHHmGtfDpeTn4+q8eAwfuaSZA9RgT5zGTtO4NwrhQKzCFN8jBVriFa80sFtYhE64G4R28Z6Udv+C+xhflHKXrg5UbeKN6WZ/ghOHfLJaorqWRtpuqqnMH2cNrUCjhEvsisI0IWpWjo/cAlia5ODiaM=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(47076005)(450100002)(478600001)(4326008)(110136005)(54906003)(70586007)(966005)(6666004)(316002)(107886003)(70206006)(6486002)(356005)(8676002)(5660300002)(82310400005)(8936002)(40480700001)(2906002)(41300700001)(2616005)(82740400003)(186003)(26005)(81166007)(83380400001)(6512007)(6506007)(36860700001)(336012)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:44:21.4796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a14c2c-e7ea-4c71-65f1-08db6cc45007
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7606
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/13/2023 19:57, Edgecombe, Rick P wrote:
> On Tue, 2023-06-13 at 18:57 +0100, Mark Brown wrote:
> > > > > For my part, the thing I would really like to see unified as
> > > > > much > > as
> > > > > possible is at the app developer's interface (glibc/gcc). The
> > > > > idea
> > > > > would be to make it easy for app developers to know if their
> > > > > app
> > > > > supports shadow stack. There will probably be some differences,
> > > > > but > > it
> > > > > would be great if there was mostly the same behavior and a
> > > > > small > > list
> > > > > of differences. I'm thinking about the behavior of longjmp(),
> > > > > swapcontext(), etc.
> > >
> > > Yes, very much so.  sigaltcontext() too.
>
> For alt shadow stack's, this is what I came up with:
> https://lore.kernel.org/lkml/20220929222936.14584-40-rick.p.edgecombe@int=
el.com/
>
> Unfortunately it can't work automatically with sigaltstack(). Since it
> has to be a new thing anyway, it's been left for the future. I guess
> that might have a better chance of being cross arch.

i dont think you can add sigaltshstk later.

libgcc already has unwinder code for shstk and that cannot handle
discontinous shadow stack. (may affect longjmp too depending on
how it is implemented)

we can change the unwinder now to know how to switch shstk when
it unwinds the signal frame and backport that to systems that
want to support shstk. or we can introduce a new elf marking
scheme just for sigaltshstk when it is added so incompatibility
can be detected. or we simply not support unwinding with
sigaltshstk which would make it pretty much useless in practice.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
