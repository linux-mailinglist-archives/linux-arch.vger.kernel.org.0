Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4483D3BBA48
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 11:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhGEJka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 05:40:30 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:43899
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230262AbhGEJk3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Jul 2021 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGu+Wgrr7fTiNWJGdQK4CPFAp1VS2nacHmCoiJpSFVU=;
 b=JtITY0I04uPKAksqcL+YGqfyRcHzvtO21RTFEChwAwm3uZjuHE1dnpRoV2MnUMQTm2U9aRtDiZCdWpgWz7xZQCrZvGMk6BSAlUdST6ax+DlEB9COksbaqe+HkNbqbzZ64MdAjnlTWaSZ+ISymdGrIEJzd1BE986UGw6r28V/PBk=
Received: from AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28)
 by AM4PR08MB2849.eurprd08.prod.outlook.com (2603:10a6:205:5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 09:37:47 +0000
Received: from VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:207:7:cafe::f1) by AM3PR07CA0118.outlook.office365.com
 (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend
 Transport; Mon, 5 Jul 2021 09:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT017.mail.protection.outlook.com (10.152.18.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 09:37:47 +0000
Received: ("Tessian outbound 80741586f868:v97"); Mon, 05 Jul 2021 09:37:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: eb09c4d84db3cfcf
X-CR-MTA-TID: 64aa7808
Received: from 2bbe664f9182.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AFC73072-F32A-4A16-A8C1-35F1EC587D2F.1;
        Mon, 05 Jul 2021 09:37:04 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2bbe664f9182.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Jul 2021 09:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsRQ57pz7smkRXZJsUQBkkjCfVl5By5GGW/LVniBc5IJPTc0UDvOvfVpyIGsyffL6jS/BXPo2uZ2vtZ4KArGrK3abJAo+a+Mpyx4r5lIItIlMlAnlon03H4Ntl33MqFLq4wpAQ7l9QBkd45mX3xuDRo8iGGidRgWjnl1mZc5Lg3StY28MLTl0O5wyOLp6hwOrm3qeEYXlcRx6uaUMQfpxcIooJdNXHeB5/CbH2rjmDcTAsZVZ1h7f1gW1zqHqoQoTrYOtIYgbHPHX+reakdCvD03TTjfXc9zxYLWG/yB782JKfTSWv7t+xQ57rAyf3QQ88mT3t3qxcLpE3Npx1o8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGu+Wgrr7fTiNWJGdQK4CPFAp1VS2nacHmCoiJpSFVU=;
 b=n8850A0L1jaKGAq6h5ras9uSgtSDcbW+uomIl9KKXGfVq+LQcfO2spRM3rE3YA+JrWwIGOBKghlPjhXARZ8qLS663Z34BXWcvaS/LOd3rQidVsHEey9N3S2OuUacxR7qS3es/+lNDV4LSJcB5C/0pzoqfYK7B0zN5+OZqHPwzE7/ycU+fXRd+0ghPiQ+2bBIp8uxWAal82bKZNa0TMUPl7b3c3QruYE1RR/Rw5KU8JrbyaPFHT89CVn6bBVosSEhKr27JSlDiyqupoCtq5E3puDwLp5u2GXSshUmCXk28X7x462ofTv+53s6/zrA/qPMUHnC8fi9dFkUFTF/eoapsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGu+Wgrr7fTiNWJGdQK4CPFAp1VS2nacHmCoiJpSFVU=;
 b=JtITY0I04uPKAksqcL+YGqfyRcHzvtO21RTFEChwAwm3uZjuHE1dnpRoV2MnUMQTm2U9aRtDiZCdWpgWz7xZQCrZvGMk6BSAlUdST6ax+DlEB9COksbaqe+HkNbqbzZ64MdAjnlTWaSZ+ISymdGrIEJzd1BE986UGw6r28V/PBk=
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PA4PR08MB6189.eurprd08.prod.outlook.com (2603:10a6:102:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 09:36:59 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::ac83:9f8b:1a5:2c33]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::ac83:9f8b:1a5:2c33%5]) with mapi id 15.20.4287.027; Mon, 5 Jul 2021
 09:36:59 +0000
Date:   Mon, 5 Jul 2021 10:36:56 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        bobo.shaobowang@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails
 to properly handle 64-bit syscalls when executing as 32-bit application on
 ARM (#131)
Message-ID: <20210705093656.GJ14854@arm.com>
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com>
 <YN9V/qM0mxIYXt3h@yury-ThinkPad>
 <87zgv4y3wd.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgv4y3wd.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::24) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 09:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a82ec9-c9f0-4a0c-3133-08d93f988ca7
X-MS-TrafficTypeDiagnostic: PA4PR08MB6189:|AM4PR08MB2849:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB28494A90156E552AAB5C4C6BED1C9@AM4PR08MB2849.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WTtbaNILuwVuMsUo48s37ZXswqLYBZPEOtBfVt5CevzlfY1n3eoChrh8tHoNY+ZfP/ROpy5umFBR9/kVWksDdBJvDC7rzbIHxRB+BdA+d9Ttki1ouGoqwP99AOD+LM/FNViBTKcQbT1fDT3s4KjNaJ3yxhcd2w/1nZUEsR8DrOJHbAOnXIs8ryMRjvEObhF71zNAdGUsCjG52ChzfpxS0Um6ApNDBl7xWeEyEcQ4/7SPTuDKvMxkyqg7QrbMEkHFkYEwm0N0rr2Q5asCdpejOjPccL1a/Tb959cz13qcm+ZjgxHrU9S0DzOU+nLhiVyZut0D6LbNaXlghVG6yDQna+/dKsm9/893XmLWyRVKVHcddVtpE39pgNRCUZkutOSC6NghyBvLdKWEOYGyNjpKqkRrmhfmI+yFXN8DYOXoAsgzsbaamFOTQjo8i8McPKqP5wO9LvuiRpSrYdz2XAqTGoCituxuusndhvnAdLgob9IlIYW9lKWIPLvmDv/Yq+l9+gUbcfBZI//tfaRKv6dNYsR5ndEzygFSBGsDrdUrTGoTja6ACQRumxuTc4pCMzEBB5R8SGNCqvrxGFDmJdRKJVRJYGx3Ze/2y/B0byDp3hhwT3FFKc8lih2i/BVUalWLtVDMVmRUec7Cp/n8ZdFeqHdJyifyCrXY/0VzC7Ynz/BQD3oi2eTqenmuX7puQPXZk1A5EUW2pXRmcHN3udzdMA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39850400004)(136003)(7406005)(7416002)(55016002)(86362001)(66946007)(66476007)(66556008)(1076003)(38100700002)(38350700002)(54906003)(4326008)(2906002)(316002)(4744005)(44832011)(8886007)(6916009)(52116002)(26005)(956004)(5660300002)(36756003)(33656002)(8936002)(16526019)(186003)(8676002)(2616005)(7696005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlPUWR4SFh6dTg1ajAyMFlTMzl6c0F6Rkw1QUdpa1VPSy9mUnBZTEpWTW03?=
 =?utf-8?B?S2dpb2lTK2dFaFBWQWtLeDFXT2Y3U0NGNWtxS0d1d3lvcVZKVDg4ai9TeWtD?=
 =?utf-8?B?WUp1Z1Z4SUFFMEtxcU1BVHE2N0pBTGp4UTRCK3lsZE0yTm5KeTIyRWVRWUZy?=
 =?utf-8?B?djBoQ2FkSDhMVEJRM0JwZjFUYlgxbkt6bG4zUkp1WWQraEt6NWtIY252K2V1?=
 =?utf-8?B?dm9lM2M2TXVpTlFubkc0UjRLeFFGUVBuWFdBbjA0REhUK3FIWUYwRjJtZTdq?=
 =?utf-8?B?WGEwaWMwMUZmUFJPSXhWamN5Q2s4Z3dGNFNpSlNVbkJQNnRZSHhHTVFLUUI5?=
 =?utf-8?B?UEVILzRqa3ZxbEFuRE5NdllLeUt6c0Jaa0huWmY3dHhMWmd6Y2k2cG1iNjhL?=
 =?utf-8?B?Y2RGeVhPTm92Mm1UU1hqOVQzWlJrMDUyZ2tueU9ScXg0dUc0M3FORmZJVHBD?=
 =?utf-8?B?dzdOb3RFZzhmeTVTd1VYZXhFdCtBSzVJS2dZQ01RUzhxdGsxdWl3L2hyL0Vr?=
 =?utf-8?B?TE4wemZhWlBvSUowRVprcnNGSnNhNWp3amtIdnVHM2JXaWlZTHJhVnpQa1E1?=
 =?utf-8?B?ejE0eE8yUG9XWHFBeGpodjNGVUdkKzZNd2RiWU94cW9TOFRuOEFQYlhVK3dQ?=
 =?utf-8?B?OUxmcGQ3MFBrTzBxSTJUeFlIejdRN2E5NkNCQlZXUHFXQVEzdXVYbExHamUx?=
 =?utf-8?B?bkw2a3FvU3Q3cXBNV041QmhzUlhGTDA0VDljazRxUUxwZkFaamxuT2wxQnRs?=
 =?utf-8?B?RDU5U2grYy9uU0JDd0NtVHRGb0FRZitCRmovZEVFcWRvbHhOVitWcGhFcjhD?=
 =?utf-8?B?cGNCMHJTSHJ4N2dvdDRrQVhUb3VyYjhQazNWajJha3lyS1ozUVJJZTRmL3Zj?=
 =?utf-8?B?SjBjbUJ0NmE1NnBXdTQvclZsSG5veDlqTjJsNWxWWXdjKzJoQTNqTTdCcE1U?=
 =?utf-8?B?TzVzTE5hcEczd3lJSHc3MG56dXloWlJCR0lFaTkrK2VMbi9oM0FKeElWV0Fw?=
 =?utf-8?B?SXBlOUdjcDlwa0pVbnpqN3JsVFFTOTliSnhtMjlSQmR3WU82RUgxdnZKT3JT?=
 =?utf-8?B?dkRYeXlrYmRsdmdtUnRhRlpjcWdNWUgzd0g5RktVMlRYVG9yOENuWlRsVmJJ?=
 =?utf-8?B?WXZrSkxiOENlclB4ZnlNb2Fwdnd4Q3J3SUhnay9oTXdJMnpNanF2QlRzbFcx?=
 =?utf-8?B?UHFmdmpEc2Q0dDRDcktzNm9YYk8vWElvUERUQ1BVMEdVWWRrV05nZ2lhYU4w?=
 =?utf-8?B?cjdkZjJ6a0pXQ2x2SFhEM3ZMS0pzbDh6aWg3bDQwQ1AvM1NsblRtRGZYVEFI?=
 =?utf-8?B?TFJLQm1NeWRPUGthYUVYdUNKZGhuT3VKazE3cE5CSkRkQXI1dHY1NVdaWHZW?=
 =?utf-8?B?NURGdWhDTWR2K2h1SWhKSjQvWkR2cVB6WkpKZzhvUC93Wmh2dWp2SklBUFRY?=
 =?utf-8?B?TENrcnBBL2RDSFZUQ0p3Z3puNnlNTGV3d213ZXhGQnRaaWFVaTRlVktVby9R?=
 =?utf-8?B?dGl0Z2JVTitsVDIyNURKT0ZWRTkzcGYvUTlOemhqTjBzdDlOMnR0WXdndk8y?=
 =?utf-8?B?NUx0YzFtbjJWNjVpL01ScjB4dXJFajdQWXJXUUxjZlpkNlBIaXFjNXNzR3c5?=
 =?utf-8?B?a1RuOFdoakRuQ0hwdVNwenFMQWI5bEdJY01Vemk3OElIR1VlanVjemVjQ3Z1?=
 =?utf-8?B?czgvTENJZlU1OFhFc2dIVVFmYTlqV2liSXNhRVY3NDFSNk5DRU9DNk1JMXpH?=
 =?utf-8?Q?MhjBKbAa+/UyH17kG86+ajJy3ej96H5ze+uWBaV?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6189
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4542ff81-d470-4aa2-6807-08d93f986f94
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVbxDlY2+JKGbdnKhk7U9yCpwKeYjmzshgW9N21ClaAnOdSRe6FSFlM7pP5WK0f5Fz84AmZW1rAIrONlttL6uftW0wD2jtv0tPbkWTQuEs/8URr53URfGyDjhC4v5DwY63EbrmaAy+tI76bf9vDr3TB5d2OGvCIM9HNUn/qYLvAl4FLWuHZI6N6ZI7KThAmnMN7xDy+BR/BOZuOlJMM7tnPBSaY6prQnqsUIUB8JATnPN3nOWT8xMm7HKuxCBuUe57NbzkQ2VsVYKgoZcfMnYK+mSOQCvBW7nRJmW4fjS/UYG6nDEQkqTLBx6ifbOc2bu4RvkPCMlXSyatnZ8tq2fif2MGwTONmiJFEjpsni+aV3VuKdTy7vWj/u2ClZWy7rhp18pgLU+zg+pm4iXfhxNhpgLVC7Q0geAgfOx884Ibnivxz5wKCeffGXW9iuK22SJPU5BtcgkWbxZu8JEQevhRgwdJs1cO6S3MkJGu/Z/HqQCugjRspnM7mBTP6PrQjc4bxjMNYP96eG04z1SypHrQlRpg7SpStEg7ZLPrQKlnGlTVTVwzxIXNhwXsoCNZAUTCAUCOkVUfTv9ql8HbYWpb03XbK20sBYOHz3ZRLGkHK1yd/69oxZRHbXzGUAAmJ6Ncj4u20fftw6VfLBnkHSsMc1QH0YdI+LT54JFuAr9m3vNZTJUuZJ14KlbZR8Zw/MzKp8CzAEB6bxcrHg6FhcHg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(46966006)(36840700001)(1076003)(8676002)(450100002)(47076005)(8936002)(54906003)(336012)(2906002)(316002)(8886007)(81166007)(33656002)(186003)(16526019)(26005)(36756003)(82310400003)(356005)(36860700001)(4744005)(70586007)(107886003)(7696005)(55016002)(82740400003)(44832011)(86362001)(70206006)(5660300002)(4326008)(956004)(6862004)(2616005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 09:37:47.4561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a82ec9-c9f0-4a0c-3133-08d93f988ca7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2849
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/02/2021 20:19, Florian Weimer wrote:
> * Yury Norov:
> > At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> > actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
> > on ilp32 every 4-6 month. Is that enough for you to reconsider
> > including the project into the mainline?
> 
> I believe that glibc has the infrastructure now to integrate an ILP32
> port fairly cleanly, although given that it would be first
> post-libpthread work, it would have to absorb some of the cleanup work
> for such a configuration.

time64 would require syscall abi design changes.
(that's likely an abi break compared to what the
listed users do)
