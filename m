Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61176A6E96
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCAOjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 09:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCAOjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 09:39:41 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8DC17D;
        Wed,  1 Mar 2023 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNs6fVo4ZHzdRfCBdEySdsHlPlfN9VH0Vwjyk2X5S0Q=;
 b=MCizelb+1Ddeuhvx1fX7PLxYo0lyGNCJSsHJJbiV04Z8ujVjkz9ChCxV0Jscwts1ILu8k8KZlFt6AHTQqHYirSrCz5Ywh68+SlMXs6UAv+lQB5+Ia0Fhscx035Nd7MyRQOx51iuaNnSaF4kSqJKiuT0FRW77dHgReSJtOf+5j80=
Received: from AS9PR06CA0054.eurprd06.prod.outlook.com (2603:10a6:20b:463::14)
 by GVXPR08MB7776.eurprd08.prod.outlook.com (2603:10a6:150:5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 14:39:08 +0000
Received: from AM7EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::82) by AS9PR06CA0054.outlook.office365.com
 (2603:10a6:20b:463::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Wed, 1 Mar 2023 14:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT020.mail.protection.outlook.com (100.127.140.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 14:39:07 +0000
Received: ("Tessian outbound f2a8d6d66d12:v135"); Wed, 01 Mar 2023 14:39:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5be87fd4441e352b
X-CR-MTA-TID: 64aa7808
Received: from 22f55ed123fb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9A40068D-263B-4F3F-9D53-FFD66E4AA87B.1;
        Wed, 01 Mar 2023 14:38:59 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 22f55ed123fb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 01 Mar 2023 14:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT7Q01YnF0/7cKvdDTlf9WsfINCdetpcwbsyupnag6V0UBGu5gFJmYR0RUjgdjDUHucz1LGdqp7FbZTxYAX4ad9swdniSKufLzfs3gzCkrHXPQKx5sWAwqzz6DHslyS7dz1W5+afW/7UJAwAmDJnlClE9WQWxd2V/DN7XyBw8oSRrAqeaA83lY8NKwjPk+otUPwUxU4BSxTN8QbmLMtAAJfH3t6Gp0iiGUQXYEvYslHDWOClDYyrCdEUZZuuvJVzAoxh+UBtgWrOPJNMOfVXAGgSQoLSq/eum4TIMBNIxV1nwwK3eFjgHTb49Dj5vwIqCV3aLoUq+HHj6nQV1A1NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNs6fVo4ZHzdRfCBdEySdsHlPlfN9VH0Vwjyk2X5S0Q=;
 b=N+nGidwZ4aeyegpEgDSTlkzD5EVfZPi4dp91n/y7jUIdOIuGknzmHpwaBu6RDa2kV7/cshVOGK6+mBlLIpKjzhSrQZhqApLqr3QcRdac8xaEbSIRxPn/Npi5MKzNdqOQvq3Fj2ItwkQvaJ/6wPpAU5jSIjgPot79lDwKZGpAYG4MXUThqMScKJGPRU2yopFl8xUdvwzrlY+ALxZTmDIr3dCr+XFt00zi8v6+A3KA0dqAjyltCT4XFBwOsvlS0HOyDIVuDr7hw+uRbkXmUIW2ArvRerHRWBNbTP2e04IkErJWkDZPXVYSY5OnEsMEUZJNXTRI35zrhhU4l9OcH6wjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNs6fVo4ZHzdRfCBdEySdsHlPlfN9VH0Vwjyk2X5S0Q=;
 b=MCizelb+1Ddeuhvx1fX7PLxYo0lyGNCJSsHJJbiV04Z8ujVjkz9ChCxV0Jscwts1ILu8k8KZlFt6AHTQqHYirSrCz5Ywh68+SlMXs6UAv+lQB5+Ia0Fhscx035Nd7MyRQOx51iuaNnSaF4kSqJKiuT0FRW77dHgReSJtOf+5j80=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU0PR08MB9727.eurprd08.prod.outlook.com (2603:10a6:10:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Wed, 1 Mar
 2023 14:38:53 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 14:38:53 +0000
Date:   Wed, 1 Mar 2023 14:38:26 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        Mark Brown <broonie@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, nd@arm.com
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <Y/9jYvXUzWdsW+oU@arm.com>
References: <20230227222957.24501-2-rick.p.edgecombe@intel.com>
 <Y/9fdYQ8Cd0GI+8C@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/9fdYQ8Cd0GI+8C@arm.com>
X-ClientProxiedBy: SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::22) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DU0PR08MB9727:EE_|AM7EUR03FT020:EE_|GVXPR08MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: cf48c2f4-7f78-491c-1a58-08db1a62b6d6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vPP/o139YbdelF+ifIrsX6tzGpdTtny+7Mhf7o/yT+NeP2f2S1qqgEMom4MfKs4ubgu9su7a3z6jCjepCPdVp3/Ze6uT8mR8ighWq0z+soRa/1qmPymuzMk6AkCvQle9vNZTCzRf0pqQjplfeQI3OKD4lkk7ArO3WxqvxZoClTkyejAZ7nT6Za3ypcnhoQ4ZCMa2RbQ6b7aZs2kkpdyg0k5rG3dUAr3NECcE62eIhsZDsmfsIbK/4bg1gmPXhg2Tlyx2+XYlwd+kBQG4zj+xucCmwmOAEiGB++bZOQsCydpMefRaf2vf6Suu49/7YLjXKsozqUKSA6vDhZiKV5sY1kiuwGGbbzNYqX3jIrNPbCmANMk1u07+NaIonh57oN3qN6iS22Pr/dHrfZL99dVbyBFNqacltoON1LWPQR71zzkoeHDdoBTsZsM2Y8I1SoTGSwT+WnXXlppjsD0royck61nvBfSAuuf4gE0uqxK2d5Ia/1eaFK5+WrhUs/2C3NfFc/UzZ1WH9RYSBXWwtfv5hLi+fMO9d7zYkWKhP8VKFwvXnUkIv6ZcxddGN1eAdbkGeNo8E4A3XjEUIOo1Kn7tyM+e97UHH9nfz/Ak8HR2IGxuWvHjzR2hllx2MDCcB3ci1h72QLlGJpmLObH27dCDNZ0up8wx2tnt0eTUEpHrcyV7TI/W5Q64CxhwwQCYKom7
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(8676002)(83380400001)(6666004)(36756003)(8936002)(38100700002)(478600001)(5660300002)(7416002)(921005)(7406005)(186003)(26005)(316002)(66476007)(6506007)(6512007)(86362001)(6486002)(66556008)(4744005)(4326008)(44832011)(66946007)(2906002)(110136005)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9727
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b071bdb9-710c-4c94-a1c8-08db1a62ae28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hzu1lDPtp/gXlmYVKE9F5nnhrfViEYRPk/95oAeffDz/423k0kpJo3aIG83dwUg75d1rHAcb/M1iuKq+uf1U/11fOSrF1Z+yTK9/MsyOt+Vam3IcxdVO3hv7MtmRQkNM5L9SCESdqDsNo6RPboeulxZpkWLp9Zc1WpPM/FLIQDH+pb/CgLwfbGlzA0W1PnA9uLTcuhdkKu8i5qWLfow60DO2N8g9IScyOARt8rWFJ8Vjhpt7SCnszSVP7BGIfxAPY5+Lfs6NhBm6sRHSej1e+M8yPGwpfFVuffywFc47PiYQ7xOMujBxZ1Qw0F0OTnCe7fFZTNm0lbjE1mksYBZ08hB5mACPbldA8NeMcgD0EweD5pBjAVp5IRKvHemSLZQGQWxUWJgE7LiB5Ceq10hNBFQRVDWsg4gPw95QomdtIi987XgqB42JjI0Ln70P8/j3TJUeKDY0DiVa+xcoUAr8DYt6HKD/UBf1zL06zAJ9MQK6MqYU0Ju7hK3sX2y3ygZb+LqRzeeEVTkpFbViEbK9UkSsiS6uFsJRM82whwzDHgILuMiufLbAQLyf3PkWDfuhjQpxer/qsY7NXmJaFxkGKWcUgWcysBToILfDqts31+sgrZH2BzIbvg5l1pqnb/rJTTUkYZbsSIbWbraAtkkM6cLEYMamzjS5LhnaLC9HdUn/FQg8B3miJvxzxYXmTLhZ15oWupjzUaoat3nl16T+FT/3sx7zcLjWsSEvVhR2Cqo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(450100002)(316002)(83380400001)(110136005)(36756003)(40480700001)(82740400003)(4326008)(70206006)(4744005)(36860700001)(81166007)(8676002)(40460700003)(70586007)(47076005)(336012)(41300700001)(6486002)(478600001)(6512007)(26005)(6506007)(6666004)(8936002)(186003)(5660300002)(2616005)(2906002)(86362001)(44832011)(356005)(921005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:39:07.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf48c2f4-7f78-491c-1a58-08db1a62b6d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7776
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/01/2023 14:21, Szabolcs Nagy wrote:
>...
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

sorry,
ignore this.


