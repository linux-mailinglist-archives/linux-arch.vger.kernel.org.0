Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BB78EFB3
	for <lists+linux-arch@lfdr.de>; Thu, 31 Aug 2023 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbjHaOlv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 10:41:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDBCED;
        Thu, 31 Aug 2023 07:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmdb2P9xK7anB0VcVgHrjBXNQyyiIJfHJ/f+pX3I445pQwvTpxy8zXTXBbvNfgOtst4n+8yywCCu2i9pOw6vfCRzMOhGUsicchDTFWcRN4SKpoRe9lrIL8S72VOFeaTxjom3Ab1h9SKLbnecCJ/A+NxR8oK66Q5ZeITh23WVI6J2b2WdOwyO8cEOekaEdEmw4CxpLF9LWf2vmk63g65MX32Alcv29sJ9B2vcLt3iXZQsLSxzi7oMzBLTC8GywTVA5KaDzBA4P+FPWtY+F44RR7vObR/iEqRUypiBnUYuBJW21Nrc3CJy9SW9FJ27pGlP+rBJSAwIv6JMvr7kCYUKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHcgeIXPodfBdJrsLIgMvIIMpu15yCaKTRVJBIMEJt0=;
 b=Gz54hkVC92XtYNEJir4tXquUIoGCwzRhECWFCvSTp/Y+yl4n+wlsEpQfzvqsaKJKp+xkJCHE9Zmf0qK5wbT68sRmTtwkwCxRfpf3fQPFv2cNylkbgu7TUUIhNmcNAN2xHQU6Cb+GmjJEgWVUtixg23INkH2WAR9r0Lp4iow1e04Gv9l1HcpbUeWjTjp45JixelFdmw1gnAG+42eRO84FimbHsHRVJJH26pbPo5nsEBfL+oS3GH7C3vwJHd/5hUyjgLff5O3ALoTjlkMuc1Iu1rhl3helu4PEQgjCbRKA3EojieMpTLCp9a9ZwOz5owYscIZbRsZec5i7SKabF7Qmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHcgeIXPodfBdJrsLIgMvIIMpu15yCaKTRVJBIMEJt0=;
 b=RtXBpV8OR5Gp+CrRlJk4FG9/kDU99efi41jnJN3ejwbbKe2UjL6hIpOLb9aaHsSaWPVpsLCdk8dWlZv7zDbCBxZ+7hAjmbsvplH+2BFIBplbvU6f5QiOKxRTv5ZfoHVDdH0llX8zlb2njKq44n9/pP5cXqOjjpLHANLHZEHxl6fjn42Rvawuf7rokkPDUytmK0AhjlUktIirz1xRy3Mm9QojofGmnZDthRCoMZvaRJWuCpo8NKx6ZdrsSLxzZxdH7hWBh4Vi9zIiAemYs2V8eO9zp7gZxHWUuYa/v7Qv5ogBDPXQdRjH37+o5JRRdiKNynuNif37OTQz33cs3s3bpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 14:41:38 +0000
Received: from DU0PR04MB9564.eurprd04.prod.outlook.com
 ([fe80::a818:c656:57a0:cc6b]) by DU0PR04MB9564.eurprd04.prod.outlook.com
 ([fe80::a818:c656:57a0:cc6b%5]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:41:38 +0000
Message-ID: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
Date:   Thu, 31 Aug 2023 16:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.com>
Subject: Framebuffer mmap on PowerPC
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ki0otvOR4MKCyWJxn2IUhSK5"
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To DU0PR04MB9564.eurprd04.prod.outlook.com
 (2603:10a6:10:316::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9564:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 521a387f-9099-4fd5-8e07-08dbaa3061fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mlvqv+7m851y8t9lDAhyRr35nrOUlQclOMswSsXURxfaDpAiJVad2So9ExEcKFiIvcC+c5ACSPcyHsgJRAuBi8CQqGhHfnTW+vIz4fT7LVvX5AFDZsnF2C7U6Q1qfBvY1ReaDdsBATJbosMhbK6DV0ADfg593EBhGmoqmTGmo7AMn9sMcwhgiZ5Tt7FVg6hbEXCZHj6548CFhNP8LbSKNMmMN45GmBIkKXwVcRUFmK1txzqlMJHSN441sEPPDyZnQd9/C/zWpTYfsvwtlH0STwnT5W6myV10ke6YwjK54LIcBaGpi34KswsiJrfRhDEQvWdSwo1sE55z4sSwCyF7F+7jzuU4r71WCpIiQvi7/DClTn8FPAEalDFaA+IUx/5q1Gv9O5OTANQm/0zg7gDugDNJle8fR7XmGbbB1kVd/F/YKbSJN6lSS4i5Ond0NjVu1a73LwaplI+EOGYaHFn+4gTpHmdwj5sVu2a4kcLNRmjXbAKsCChDY65BJJd7NCoLZB2zyHwuwMoRhBstII/XaFZ7zShImM45VgAVDkzCkYYkYsKWc8X2zJ/0wuaKox/72SB4GReRRGiqXzmryVwbyMfbyZFWpJrTqnqhCjXqlwGn/vJoPlNrKx2+0NTN9Qf1DF3h+A5y1E1mH4tKiMLn4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9564.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(3480700007)(36756003)(21480400003)(86362001)(235185007)(41300700001)(31696002)(6666004)(6512007)(31686004)(83380400001)(2616005)(6486002)(6506007)(33964004)(38100700002)(8676002)(5660300002)(4326008)(8936002)(54906003)(316002)(66946007)(66476007)(66556008)(110136005)(966005)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U215czFLUFFXbXAyVGJMMTlZczVTWW1rREYzakN1OHUrOGxUblFwc0xXcSt5?=
 =?utf-8?B?NHN1OTRhZmhSQ0FlcU54WDQzcEkxSUJrbVRLRmd1NitNRSt1UjAxVWlQUkwr?=
 =?utf-8?B?U1Z3eGZtUkRHdU9wcGtKWW1DQlJpcXhjNitaajhMRkFBOEFyeGRUeHJkKy8w?=
 =?utf-8?B?Ty8zNGRFYkdNZGkvdms1cDVoamswa21paERhdEZLVjNDSWkrRWoxOEgyQ3lv?=
 =?utf-8?B?SlhJR1JpeThwUnJEK0xTNCtHTEh1Y2ZpaXA0eWxPV0cwR2JBZlFJRWNDQ1d4?=
 =?utf-8?B?UncwWTduUjFjOFJGd2pwaVlqYURBbzluZW55N1k4Mzkrd2pXblNYUTlnc1lr?=
 =?utf-8?B?clQ5ejR0cHFGWGRueTZXcEsxWHRMTzFrMjU4dlJSVkJ3aVpMQXVIbUlsSUNM?=
 =?utf-8?B?N1AwNGtTaXMrcW96a1c5N1dDZ2dhbUl3QkdEMVFsY0RlM0t4T2M4YnhrZGVy?=
 =?utf-8?B?ekFWVVd3eVpyMWhXRGNxQ2VxRWFmOFllaXFaeEN1SENhWFpOcHl6bkZMQSs3?=
 =?utf-8?B?N29OKzAycmFpeFhocHRsYk9nSGVYZUJ0NGMyYXNzS1BNbk5sWWFGS2NFWGtv?=
 =?utf-8?B?ODhzTURzUFl1bktYM2xtT1d2ZUp6Ky9lWWhOTzZsV0FZMGNPOWxaUmx0cmFh?=
 =?utf-8?B?WG5sdWhyb0NpZXNrcnJxTFQ1WHJLM2ljZndwSHFITmJoNm8xT3huL3A5N0c2?=
 =?utf-8?B?Ty9oK2poN2lPOFhzYmRncUtDZjF5dXR3UWF2ZER1cEN5Vmw3aHJxbGlsV1Yx?=
 =?utf-8?B?N1h4MGxjRWZmekpvR2o4MEpnMzZLUGdtdGtaTC9RL20wQ2NBZWRycXcwTWJs?=
 =?utf-8?B?QXhSbFY2SlVsSSsyaGRDRTFqREpIOXlhL3NVMFN1QzdZVUR6cVJOTnQzZEVR?=
 =?utf-8?B?RmhqZ3pOVGlJTzhPaHZxa3A3dHJtSmFIMVRqUlhOSUxwbGo0emxObHV6eTRN?=
 =?utf-8?B?NGhvcU5ELzZpdG00UytPMFFiNCsxbnc1TkpJbU53dkhieWxJYVVDNUUvNTBI?=
 =?utf-8?B?OURrV1g0SHRGQldiVFNzbWNGSzlJcmE3K0tLS2RmNmpzcWNWVmxWTHBsQlln?=
 =?utf-8?B?cjBybnBLRzlHK21uZjJmY3RNcFN2Vy93elBmSTF5bVJ0T3d1RGtmdGN0aktN?=
 =?utf-8?B?dkhjc3lLVTRDM2cxQzNrd1RTMS9TeDZ2SWx5VHRCQ3pEMmNhb3NhcXQxSFhF?=
 =?utf-8?B?V0c3YVlZN3U4TC8ybW5aNU1nN3oxTk44NXhRcWdENEhSc3FzMThZWkgzUnJz?=
 =?utf-8?B?em56bm5pdXJHdGVFNEduUitzY3VHZnVRbENyNGd1M2o0dGp4QmozWWozNEdC?=
 =?utf-8?B?TzFhZnlENWhBbGIrREF3RzlibHJKejNkbHJXaUZVYVBLM3ZnTnlwdDlsQU1h?=
 =?utf-8?B?QlVXNzNSVHBrTkM1TXczS24vT3JjcVFaQXYyZTV5K3psSzM1SitYaVdIYzVi?=
 =?utf-8?B?cUVnUGVDaG5ZOTFFdm1WSUZrQVREaWI0Z1ZYQUhGVUx4cWZaWVQvY0RIcy9T?=
 =?utf-8?B?d0hyOEF3MlcvM3MybFdBMjYrckp6ZE02YjBZdHc5TWh1Q3hyVkx2dW45SFhR?=
 =?utf-8?B?VUVvMk04ZVFxT3hZV04xcHpFRGpadHlKQ2ttVjdMUlNTVzFUcEp1cUhITXBr?=
 =?utf-8?B?R1JvZ3pzdmorNUVrY2VQaWxQQThIZTZQcllhaGtVNFk1RHVqTjdhR0FSbEhD?=
 =?utf-8?B?ck5vdndvWlBYaDJ0L0FsVFM3RTJJVlRvdExqcWtvM0tXVUNSdTNhRmtmV2Fo?=
 =?utf-8?B?aGk0N0c5WW5pamhsVnRUNkM0bkZ3Y2liSEE1MitTY3NWblc3dlFFT3F5aWhj?=
 =?utf-8?B?SlV4QnNLbXZHaVpPOFc5K1dXZkptOVUyOFA2UXlaaFF5SUVDb0RNRnRCUG9D?=
 =?utf-8?B?RXFmRTUydDJOUVJuWjMzdlM1amcrOU1hOUwzRE1YMjlWZVNsM0NEbm0reGht?=
 =?utf-8?B?dnBtd000NmNDQnR4eU5hMzdjNWxkV3hvM3p5TTYwb2NYQVIvanpsUUlRMmxz?=
 =?utf-8?B?VllBODNJaWJOVlJRZVBPeThiWDRBRXRmNnk1TTBIS2VLNUpobzRTYUlicFM2?=
 =?utf-8?B?MGE1bThFS2VqK0x0UHI3dGZUSHZJd1ZnV3pyWFlTWDJwdnFNd1BBcDJvQjNr?=
 =?utf-8?B?a0gwY0x1TkRSL0x3bWI3M1hTZU5yQU9vaUdsN1h0aUpXN1YxaDFNRW5CUXV2?=
 =?utf-8?Q?yGU837wio0hRSt94tuTZ4J94zcCot0OoEhj7hp8IZal+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521a387f-9099-4fd5-8e07-08dbaa3061fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9564.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:41:38.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwmUpEuy7LxpjyK93PIKToX00PvmF8MQ9ooAFGKMn6ZYwxuIVUafRwLeCHo1kio6gYQctZycpebt0ubELzN3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------Ki0otvOR4MKCyWJxn2IUhSK5
Content-Type: multipart/mixed; boundary="------------J8aUUf6ZzyqnANOsu26S8YC7";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Message-ID: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
Subject: Framebuffer mmap on PowerPC

--------------J8aUUf6ZzyqnANOsu26S8YC7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCnRoZXJlJ3MgYSBwZXItYXJjaGl0ZWN0dXJlIGZ1bmN0aW9uIGNhbGxlZCBmYl9w
Z3Byb3RlY3QoKSB0aGF0IHNldHMgDQpWTUEncyB2bV9wYWdlX3Byb3QgZm9yIG1tYXBlZCBm
cmFtZWJ1ZmZlcnMuIE1vc3QgYXJjaGl0ZWN0dXJlcyB1c2UgYSANCnNpbXBsZSBpbXBsZW1l
bnRhdGlvbiBiYXNlZCBvbiBwZ3Byb3Rfd3JpdGVjb21pbmUoKSBbMV0gb3IgDQpwZ3Byb3Rf
bm9uY2FjaGVkKCkuIFsyXQ0KDQpPbiBQUEMgdGhpcyBmdW5jdGlvbiB1c2VzIHBoeXNfbWVt
X2FjY2Vzc19wcm90KCkgYW5kIHRoZXJlZm9yZSByZXF1aXJlcyANCnRoZSBtbWFwIGNhbGwn
cyBmaWxlIHN0cnVjdC4gWzNdIFJlbW92aW5nIHRoZSBmaWxlIGFyZ3VtZW50IHdvdWxkIGhl
bHAgDQp3aXRoIHNpbXBsaWZ5aW5nIHRoZSBjYWxsZXIgb2YgZmJfcGdwcm90ZWN0KCkuIFs0
XQ0KDQpXaHkgaXMgdGhlIGZpbGUgZXZlbiByZXF1aXJlZCBvbiBQUEM/DQoNCklzIGl0IHBv
c3NpYmxlIHRvIHJlcGxhY2UgcGh5c19tZW1fYWNjZXNzX3Byb3QoKSB3aXRoIHNvbWV0aGlu
ZyBzaW1wbGVyIA0KdGhhdCBkb2VzIG5vdCB1c2UgdGhlIGZpbGUgc3RydWN0Pw0KDQpCZXN0
IHJlZ2FyZHMNClRob21hcw0KDQoNClsxXSANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y2LjUvc291cmNlL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaCNMMTkNClsyXSAN
Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUvc291cmNlL2FyY2gvbWlw
cy9pbmNsdWRlL2FzbS9mYi5oI0wxMQ0KWzNdIA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuNS9zb3VyY2UvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgjTDEy
DQpbNF0gDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni41L3NvdXJjZS9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyNMMTI5OQ0KDQoNCi0tIA0KVGhvbWFz
IFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVy
bmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1j
RG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------J8aUUf6ZzyqnANOsu26S8YC7--

--------------Ki0otvOR4MKCyWJxn2IUhSK5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmTwpp8FAwAAAAAACgkQlh/E3EQov+Dk
WRAAr+FS9Ricev/pES/ATyLqLhod7iYPojEgIeU9hd4hAZgy1BWqulbDZFQzszDwuFtp9SNuFqVX
6A0QdjOf5tXNCqPi1+L3DjzR0eWOCKq9HfzP/WADPs8xmDse0UrbbhjHjMT+VnS25bdUt87d1RKa
m0LA+TeIx1dYT5pg6eIiG8fZU72iKEwIX+m6GTgK/1Df+2w1xk71kj2zGtr5u6/H4Pu+xBLGCIb2
DRuCp/JMDquSOtM1IzvofUyCGOWzmbJvEl3TagRVHSsvLwiU6aii3hunocLQVK+BEB30d74jqKLs
j1U9Un5hR9c855TwI4CH3zAGbVJiA4oK7sGtYUgFm+kRwei+uS9DnRHozNx6OKZ/ugn/zRspNdWF
uD5yBO901GOh4W7nlpbNDJKvgdZi7P09jnzOSDIky8PjBel9XBGwPnLSyzVYjA2SF5ciUm7MNaDA
UBHowvpdQ/qGS1erU4nKFPm3Mm5jEQSM4F6xCUJCy1+TfqVYNGBgwWcR9XC0y0gU9lKhvzfxH5VZ
lu9qbmbv+E4QXt7OjdlBVC2ZK7ApXleb9DYUCGffN4f2Lc1BZzxM0Q9+V7sBeA0/L6pfTtca6J2k
gx/q0SSxnEx8DMgwAp0vaNLESHwumscemMORuJY4AsqEkheY++/oMgPn1ysij7zE9sbShccoWpQK
rrA=
=a6RX
-----END PGP SIGNATURE-----

--------------Ki0otvOR4MKCyWJxn2IUhSK5--
