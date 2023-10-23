Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9342C7D3CA4
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjJWQdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjJWQdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 12:33:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25400100;
        Mon, 23 Oct 2023 09:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJcGDGNdmaDHOjqoFTRTonBC07eoYmXDTUxqbxOfN/Ny4n5oKE2U2SxF0SuOfFopmPDQukAistv7w+Jle438iQu74NOWWAE15C06u+rki/w+gwPu1iR9NZRQIQlPgQwJR9cXWHca0UYLOCfc1TWBuYMM/MkdcB8qRVY5gDOEUrSvIV7V3uximLD92uyzXILxYhSWxLSdQo6IYAYJ+UYthzqZzvR+P3iSYNBqbIpyK+nsNmfWh76mRBZl8yVx7AvPEpYxg65caAbVn0a0s6UIJ0Xy6q7CBKlZKql0XT5eVSLFyfkEKtdv9jS7lhHmB6nJ0Du8B0eMLBK8hzcOEYjCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OUB9wknXdkR7ciL8uJwlqnE9yZgR5g02/vXj6Rd4qM=;
 b=O6PJwBl7yXkKgQeFp8unJ3AvkbKENfBuDaAKTp5ZOAl2CvIHsuRFW6bU/SbyAa8/2PQqO3L0faf6+hpCwQYfS9FFqVwChp1JiRmMxeLbL2hd9cOx3yfqVEsRhuRPNyykOAYvXW83kfu7Ha53n4TGXvUnNq3HRU9YYyG0FhACAnKFtFKTOi0YkMzb74Fn3Q/GskSN1DSeb/q973i5pBGgVbzt7v7coOZX0onas1lex0txASGzRxwqsC79X9faDY/IobOu1woFipYsOgnEQwVWeqeRFXDapCtZDh5DSudGclCTfSvFERTki++MDJ9/FfZT4PQ87eXJvau+dlDyW4+i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OUB9wknXdkR7ciL8uJwlqnE9yZgR5g02/vXj6Rd4qM=;
 b=H4CLRVsMe2Tso4vt7/yUlx4b3JxNIOva9FHbnenn/P0OdN+u9Y1FOcdH7DbkvLc7jVqnn4Fmsi+bSb9PXc2iKYBI8eATmX9Hi7RU0jzp6YkTa3+42WFwYud2QLWyzMthAJ5udjECzHyn8RjjdSof0ykGI4JAoafH23ze+pa5UaL9k8VdJArAVRJTk9z50x1KPcNKSWAnUMcRKldUrjcZAObnAEXWyQBzIdYvziC+RRCUAJ2cc2YDNuegijCKCOl82sSEIOYXOf5CuzjwVCGJVZziiHI9+hBqF83DyaxgrbT635L8Vzd+EjI23QFtiG7RpDCikCoIJKy3c9u+M22CPQ==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PR3PR10MB4080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:33:14 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f2dd:e643:57ea:d746]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f2dd:e643:57ea:d746%3]) with mapi id 15.20.6863.043; Mon, 23 Oct 2023
 16:33:13 +0000
From:   "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "minda.chen@starfivetech.com" <minda.chen@starfivetech.com>
Subject: Re: [PATCH RT 0/3] riscv: add PREEMPT_RT support
Thread-Topic: [PATCH RT 0/3] riscv: add PREEMPT_RT support
Thread-Index: AQHZg11nkW8+OA+Drk6cLF4zRi8UF7BYln8A
Date:   Mon, 23 Oct 2023 16:33:13 +0000
Message-ID: <a37fc706-78cd-4721-9af3-aabb610f49b1@siemens.com>
References: <20230510162406.1955-1-jszhang@kernel.org>
In-Reply-To: <20230510162406.1955-1-jszhang@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|PR3PR10MB4080:EE_
x-ms-office365-filtering-correlation-id: f73a725a-0225-486a-d397-08dbd3e5c0bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMY0clfcgw9r3/bvtQDB60L52z8ObWnHv6kqGpZrKBe2LaV30Ofj/9IzZ/k9ifJI6VYVrO62tz3mFkrzejb+EubYhotT0dXH99B9CKrEu0zOIYoY/740ChsEx24RVC7Ydngpp4q+OEVMAxd+qIdiLm3iyKeu+0cl/jKPXYJ+d5p9lH8AWc4s2ghq9XYvSBKczFlJx1PJVUT3kT1Z2RFSPbB77qpfeOfLtNZG0iQl1ATZvWklSoCXJJKllN8uiw3fkupxMjOLEOuozwCM8LPmwv72fZwbSFWlgf5846adYCRAHvpK9BM7ZNrZ0X+bJlmbaTTjB3hEGLhxsqA/or33B7YhAx3lTRWeR1TXyD7lYHoKH9KVhng4ESlZuX0GeMt0hS83B4mGAiPHLFAS4E/5w4ExcW/b0wL+i0Zd9esWLeXhmajiGzOpH+Hpxb8ymSgUmsfq8Sz57K5EAWE8BvSGYEIRTjhqRkF7StmykuHeXyTcOjinR3fRAQMCAjsA3fbXyoC0V5W+yyN91jSgN5f5j42kUHw2yYYBlgXhXOWk/1qHzf3teV5sWQGiG9w+71tcWySibIRIM+vnen8Q0bWWS0yAZriYJwKx2t/FIulwDaQutC9w2mopdd/2GzNMlIQ9mDkoc5rp0KhfjMszVVoqsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(8676002)(82960400001)(966005)(6486002)(7416002)(99936003)(4326008)(86362001)(5660300002)(38100700002)(122000001)(36756003)(2906002)(41300700001)(31696002)(8936002)(110136005)(91956017)(66946007)(76116006)(54906003)(66556008)(66476007)(316002)(66446008)(64756008)(31686004)(6506007)(53546011)(71200400001)(38070700009)(2616005)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWYzcUI0dVlYb3ZhSzlaWTNKTGROV2FwM2FEbmZQS09jRk91dkxKZVQ1Q1V0?=
 =?utf-8?B?WS9GUmlZeEczYWQvSUtPZm10WTk1QzZTcjlGY25LTjRWbmoxM01NbVAwVDlm?=
 =?utf-8?B?MzV1eGhiRGdRZlhtQW4vM2cvbUpzU2VkNGIvdEVlODg2ZFB4L2xxQVZYakI4?=
 =?utf-8?B?cGRhT3VsUVpHME1aR0tJSzJ1ellWQ1g1akJXdFFTL3JYTzEwbUZPTktsRG0x?=
 =?utf-8?B?dVo1T2hEbkFGWkdGazFMT0RFOTBJZWRwWUZPcFpQN1g1ZmdaR1g1a3FzanZy?=
 =?utf-8?B?ckZOMnUvQ2lHSFJEb2VCdC85VWVRUklNRkRjTGQrMGU2MTAxVGJQM3gzdlBU?=
 =?utf-8?B?OGE3QWJhL2k1ZmR0MSs1M21iYmp2NmxTMmo0WFZMK1BvR0RmK0k5bVB2K08v?=
 =?utf-8?B?MnZNZzh3SEFBdllOSDl3dHlMRFRnN3dqd0toOWNzY3RnS0svaTloVmlZU0li?=
 =?utf-8?B?eFJoTE5OQmpDVFBaaGhFUElCenFyS3pTVTh3NkRjNlVLZkpyaU03bzkzU2gw?=
 =?utf-8?B?ZGNGNFUrTjdxZnRzMmVIVUJrZ3ltNlc3cnczVUw2eEhJR2JZRkRISDY5RVdM?=
 =?utf-8?B?ckRHUnpicTVxMW5sVDZYSXphdHM1a0psbVNHY29keTdPc1pXL0tUQkw1cEZV?=
 =?utf-8?B?N0lWWk04YUpTUitTWDdTLy9UYTVnU2I2ZVcrVzNMc0ROaVN3ZjhTZkR5dkgy?=
 =?utf-8?B?QjNjSEpGdHQwMkJPZVg5bFh1WkhUTVRwZjVGU3pxMllyVWQ4SlFXdzd5QWpw?=
 =?utf-8?B?YmIrbUNWaFVSM3VMbXZXVEpvM0JVUSs4WXN2NEtPWVc4NThaWTJGUUVIMCtN?=
 =?utf-8?B?M0tQTTNnbjRzU2VuaFUzbHBxRDFvMW0wUjhxcFEvcUh5b0JzRE82alNNTTJE?=
 =?utf-8?B?VUlja3owT1AyQ3k5RDd3WWhXaTltN0N0TlRKUEtqb0x0dE1RbkE0a25OWThT?=
 =?utf-8?B?dEh2MkRpaW9MVmp1Wm1XZEkyTHJCU1FzdjIwUytSQ0xsbzAyRTlEOEdCcU1n?=
 =?utf-8?B?TDNyUkFCMHVEdlkyME5zdGFxS2VKazkxQ2NQc1BhRDFFbnhIQkM0U1o5WXBI?=
 =?utf-8?B?Y2FuSDNuWlJBdTlxVWpNZTd3bHNiWXcxSzN2NkxCYm95VzFZYkRtc0R6SGVq?=
 =?utf-8?B?WGVqQ0xkeVlUeVRVeWlFMUZxQUZ2blJ3QUZyTVg2WEZyU083MWUyUnVkQ0dU?=
 =?utf-8?B?dlZzaWlsL0YxRCtMcms5WHRnVUtDcm9RRlRZYUJkOWFxWUQyOThxU2lxOEN6?=
 =?utf-8?B?WE9nT3Y0L1YrMzR4SUxOZjQzUStHODBVNzNDcHVlQWRaODYvZ1ZlckVBR1g4?=
 =?utf-8?B?MWxOZ2tMdEhHUmV2NDArS3RtWmNZVUFoRFZxbEREeXRlVHlDSE96VGhFU0JP?=
 =?utf-8?B?L2JDSkgyWFExRjdpYncwYXZWcUd1S1RCb1dmbExQbEdqMmdQNEZ3STVJYW1j?=
 =?utf-8?B?YzZ5ZDNYdkdpWWJ4a0E2SUxzWlhyYVJYbTRmV2JHTmQrWXc4UnZOZ2FNRWI2?=
 =?utf-8?B?bVNQY3lEblVOTlFoRzV4bVFqMWZhMFRsUXdyWERYMTRSRUJxbnFJNDdXSGdo?=
 =?utf-8?B?cDA0Z2dHTXJGRTJ0aTByekxGbDIzSHZBaDlMVXRnY3hWSkpneTVSbWRKcUNU?=
 =?utf-8?B?ZmhxUTlBUE85SGZiYUdDcFUvMmJQUEpzc3M5YjlGMHhCRHBIbjd3eTRFOXVX?=
 =?utf-8?B?SnJFVTNHbWMzSGtucVBpYytXa3NkbjNWNUw2bXRaektGK0hUY2xFaFlPWEtR?=
 =?utf-8?B?WFh0cnpiQS8vejlpSXdJYzZxSTgzWnZ4MVlzL296U2JiT3crL0hTTkFvWE9r?=
 =?utf-8?B?aFB2ZWYvblF1cjhaL1pjZGtSTVhSbW96dmlGczJ5VkJBY0hzN1ZkclVVN0lu?=
 =?utf-8?B?S1JzdGlXM2gxNFRkTUxpamd0aVI3M3A1dTd6bExrSm1mMFVqcGhndHduUEcx?=
 =?utf-8?B?UUlEMjgyR1dpNnBKVUgxV1pheWx0OUx3bFJRdHU1NDJxTWJhSEJmZ0VTN1Bv?=
 =?utf-8?B?cDFkOXNyMSt4UXJETFVkTlJERFRyTWY5UG1PUktMUlFRdkkyVjZIS0hDT0R2?=
 =?utf-8?B?M2doZ09iOGkrdU91YXVKa1Bsc1JZRFVaLzVmb3o2V1FOc05lUFhRdjhzNGVJ?=
 =?utf-8?B?OUs4TGhpSFdCSkVvL2VCa2hxaHZXcklOTHNYcEk2bHFTVVJSbFZrZko1VGlZ?=
 =?utf-8?B?dHJaWU03SS9xMHYvUHZySXUvMUFROU1NUVh5ZXN6Ung3QmRHM1lkalhGa2Vt?=
 =?utf-8?B?aTRGYjI3WnNjalVGV3JGYVhHa0hRPT0=?=
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060401080308020507070108"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f73a725a-0225-486a-d397-08dbd3e5c0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:33:13.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laiNW6BrzdHZ5YI5CJJEdv1ve7vJTWv+kAV8n8rimiG7iCsh44an8xpgMUHEcCtuCTCtJvMOcA0fovOThIbVr8pSfwnqWCyIaL3I2pG6PvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------ms060401080308020507070108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.05.23 18:24, Jisheng Zhang wrote:
> This series is to add PREEMPT_RT support to riscv. Compared with last
> try[1], there are two major changes:
> 
> 1. riscv has been converted to Generic Entry. And riscv uses
> asm-generic/preeempt.h, so we need to patch asm-generic's preeempt to
> enable lazy preempt support for riscv. This is what patch1 does.
> However, it duplicates the preempt_lazy_count() defintion, I'm sure
> there must be an elegant solution. Neverless, it doesn't impact the
> riscv PREEMPT_RT support itself.
> 
> 2. three preparation patches(patch1/2/3 in [1]) has been merged in
> mainline.
> 
> I back-ported the lastest linux-6.3.y-rt patches to the lastest Linus tree,
> then cook this series.
> 
> Link: https://lore.kernel.org/linux-riscv/20220831175920.2806-1-jszhang@kernel.org/

Any news on this series? Are there any open tasks blocking this?
I am willing to help, but do not see what's missing to get this merged.

> Jisheng Zhang (3):
>    asm-generic/preempt: also check preempt_lazy_count for
>      should_resched() etc.
>    riscv: add lazy preempt support
>    riscv: Allow to enable RT
> 
>   arch/riscv/Kconfig                   | 2 ++
>   arch/riscv/include/asm/thread_info.h | 5 ++++-
>   arch/riscv/kernel/asm-offsets.c      | 1 +
>   include/asm-generic/preempt.h        | 8 +++++++-
>   4 files changed, 14 insertions(+), 2 deletions(-)
> 


--------------ms060401080308020507070108
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
I6cwggd9MIIFZaADAgECAhBAfUgRDppgj3QkouV/nMYgMA0GCSqGSIb3DQEBCwUAMGwxCzAJ
BgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUT
CFpaWlpaWkQzMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIwMjEwHhcN
MjExMjA4MDg1ODQyWhcNMjQxMjA4MDg1ODQyWjCBsDELMAkGA1UEBhMCREUxDzANBgNVBAgT
BkJheWVybjEQMA4GA1UEChMHU2llbWVuczErMCkGCSqGSIb3DQEJARYcdG9iaWFzLnNjaGFm
Zm5lckBzaWVtZW5zLmNvbTERMA8GA1UEBRMIWjAwNEVLNU0xDzANBgNVBCoTBlRvYmlhczES
MBAGA1UEBBMJU2NoYWZmbmVyMRkwFwYDVQQDExBTY2hhZmZuZXIgVG9iaWFzMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgy2jh7mgGYYr56XKwJ52r7qkfV+CAwK19KA6AgsN
iRonJGz5tZE8UIJROMuB+YvSXmmowEE5sP/JFj6f1hgsnNzaJBo5u5uy8gzIuOaTmdyoebRm
4H3XbH2xBcg9kNb6FuaMF7ZaOX85kOh9OBmJESlq7wiwgsIbo0AYKiSz3WewwIyUPnSl8pMu
ILnAQe+3zWZc7XwNWbj1SpOS1piR+yN4m1AuThoPNFFkrKzwpyDaPinX4DuXfSy58skpsgYG
XU/hvaDfAlgLmyBfHRELKh4EHPa2tMUzKZtuUStEalvFTb8ORw3zZ03X6CtgFB7EqolD8TsF
J0Yu308hAT+F/QIDAQABo4IC1DCCAtAwgfcGCCsGAQUFBwEBBIHqMIHnMDIGCCsGAQUFBzAC
hiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkQzLmNydDBBBggrBgEFBQcwAoY1
bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWkQzLEw9UEtJP2NBQ2VydGlmaWNhdGUw
SQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpEMyxvPVRydXN0
Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMu
Y29tMEYGA1UdIAQ/MD0wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUFBwIBFhxodHRwczov
L3d3dy5zaWVtZW5zLmNvbS9wa2kvMAwGA1UdEwEB/wQCMAAwOAYDVR0lBDEwLwYIKwYBBQUH
AwQGCisGAQQBgjcKAwQGCysGAQQBgjcKAwQBBgorBgEEAYI3QwEBMCcGA1UdEQQgMB6BHHRv
Ymlhcy5zY2hhZmZuZXJAc2llbWVucy5jb20wgcoGA1UdHwSBwjCBvzCBvKCBuaCBtoYmaHR0
cDovL2NoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpEMy5jcmyGQWxkYXA6Ly9jbC5zaWVtZW5z
Lm5ldC9DTj1aWlpaWlpEMyxMPVBLST9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0hklsZGFw
Oi8vY2wuc2llbWVucy5jb20vQ049WlpaWlpaRDMsbz1UcnVzdGNlbnRlcj9jZXJ0aWZpY2F0
ZVJldm9jYXRpb25MaXN0MB8GA1UdIwQYMBaAFAjc/sgRnPU7rsjfK0NFR/Y2TNqlMA4GA1Ud
DwEB/wQEAwIEMDAdBgNVHQ4EFgQUF9W9BihNcquGyrRQ+QvmPOM3l6MwDQYJKoZIhvcNAQEL
BQADggIBAHzdv94SCuhfUlRjAGJFyg16wU//73ROa8jvm39paCGeuLLGWnhYaOz4i/r0i7Eg
Aa9AcfhhtweIg1/TdETZ7nr8De/BqnBCVy2MFgwgFQwCHBGIEYkZPKP+eG85LDnUmYoH7b1l
hdsm1lQRNM6n4l+Vi0Twl+KjtfSkctbMgVleWuRnXOHU2MZ+qVR1VMe5UgP30c3NLM3tl5+p
3nDHMFezlkSA7/BB/Jbr/U4NJJO1evnKVPr8B0ekesK0IFpMIcDKrynAmTDB67+2NF3amg4+
DgDk+M/b2nfC0GuBGz++uN5371/Ce36XeD5gXs0XLIsZR1JByCY2xLPQ22buXet4v/O4NYiK
qlNFz7iTIO7Sq0LTnmNDephWwTbz5KN2DizNXfD/dD/BgXtNpKsVFbsRuuwnxzJgdEh7N6k1
QdrpBjtgLFRBjGw7WiJVPyy8KRbel9f6jpsyrwIH0zZrBp6b3FAW/YaRBE3403OS9gvltoqQ
0UNGBeOsBvLgSsD82RLcRCM030p7SxNK0EyjRUjFDUdncICYcQFLyYvRIgxoaRWLJZP5PNaP
UQ6Re/3HqgafGkPc/u9t9RIPaLTg35cShWt0ZZiGk3SevvibSgRyENKXfs0WMVPQvetWQEmm
rAzPwscWbcALPprjD0BKjWk/UDiy6j6q9T+EEsKHna36MIIHnTCCBYWgAwIBAgIQXnZZ1fai
T1IoP0lctdAZszANBgkqhkiG9w0BAQsFADBtMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5
ZXJuMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwhaWlpaWlpEMjEoMCYGA1UEAwwfU2ll
bWVucyBJc3N1aW5nIENBIEVFIEF1dGggMjAyMTAeFw0yMTEyMDgwODU4MzlaFw0yNDEyMDgw
ODU4MzlaMIGwMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMRAwDgYDVQQKEwdTaWVt
ZW5zMSswKQYJKoZIhvcNAQkBFhx0b2JpYXMuc2NoYWZmbmVyQHNpZW1lbnMuY29tMREwDwYD
VQQFEwhaMDA0RUs1TTEPMA0GA1UEKhMGVG9iaWFzMRIwEAYDVQQEEwlTY2hhZmZuZXIxGTAX
BgNVBAMTEFNjaGFmZm5lciBUb2JpYXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDelnIZgkUE9UbIz9zfdu0YOjbGMoRU4dRzoOoEJZy3TLp0+6mC2ExxU8d+dFd7wR/MYQf1
cErlXEvzbNVc5Bjgr7bKYA4wzzDS1kP7jjFq+vhO/kBSPLIrf9RA4bHWL3KspAK/MkiZXUsn
40+GdCW4QPEK4nDo7j2qqJ63yGBYfJT2tQagsBregtl9J6PdOG4OROqYuGJTE/YeWKuH5/q2
ixy+tVA/eMgJH3yedUaUVNE9dgcyW4INtCFvrn7qsuB3KQVHGVOGd/455LDgx+2vckI2i590
2puT8HsS3K98c02f7xTPQn0jj3yuBlarg6LoxVu4IoB8+kixr3SIZyKnAgMBAAGjggLzMIIC
7zCB9wYIKwYBBQUHAQEEgeowgecwMgYIKwYBBQUHMAKGJmh0dHA6Ly9haC5zaWVtZW5zLmNv
bS9wa2k/WlpaWlpaRDIuY3J0MEEGCCsGAQUFBzAChjVsZGFwOi8vYWwuc2llbWVucy5uZXQv
Q049WlpaWlpaRDIsTD1QS0k/Y0FDZXJ0aWZpY2F0ZTBJBggrBgEFBQcwAoY9bGRhcDovL2Fs
LnNpZW1lbnMuY29tL0NOPVpaWlpaWkQyLG89VHJ1c3RjZW50ZXI/Y0FDZXJ0aWZpY2F0ZTAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2llbWVucy5jb20wRgYDVR0gBD8wPTA7Bg0rBgEE
AaFpBwICAwEBMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnNpZW1lbnMuY29tL3BraS8w
DAYDVR0TAQH/BAIwADApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcU
AgIwVQYDVR0RBE4wTKAsBgorBgEEAYI3FAIDoB4MHHRvYmlhcy5zY2hhZmZuZXJAc2llbWVu
cy5jb22BHHRvYmlhcy5zY2hhZmZuZXJAc2llbWVucy5jb20wgcoGA1UdHwSBwjCBvzCBvKCB
uaCBtoYmaHR0cDovL2NoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpEMi5jcmyGQWxkYXA6Ly9j
bC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpEMixMPVBLST9jZXJ0aWZpY2F0ZVJldm9jYXRpb25M
aXN0hklsZGFwOi8vY2wuc2llbWVucy5jb20vQ049WlpaWlpaRDIsbz1UcnVzdGNlbnRlcj9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MB8GA1UdIwQYMBaAFNwsp5JBrkGaF+zG5TA968Ig
ZojdMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQU6EE+Ii7dvy6mI0qF4bfDJEiB6G4wDQYJ
KoZIhvcNAQELBQADggIBADpByupPG/2YAm/e/YZ1gY5BloV1ThfmmgmeoqQjuy+C9/n3gcuN
TRWoMJqBjCTcWN93Zuau5J7asyZMdaSUdoYjhvXwp9EoM8uiUvhFrlaCzqFKg2qvzqt4PAe5
KmtnMViXoJOqR9JHCHRNgbnxYKPKVeA+pHTsIrSLGhh3DVAGomx/3ftt7iFsV1AEVuhKeTee
7ng4iApCn5v3cHVaj3uOZpBuE+MlYUI/gR9G9uD1h8iY95U/OTf76CqBD/CJF//yIBV7Ez7x
CFMnM+TrlBhZnXvBEms7c4nfRjZ2OsU9vdnjJUf3sH/iMIessOUn3eEOqPdsoRLu4aZbd1Dw
SComZE0ZDhHjt5duU92ij/oiqm5BFtQcGXBG9gCMwFw90QnKdqe21eGo5m+cGmxDk9DWaK+j
H+VJr75+/MwHKK/tMKH56WMx/UhLk1MnMLSDX6pOvBbJhfCs0jh0qKxeHEvoJFRyZeOArtnY
gfWfINdufgBIM8cWvkCHSsZSv6j3Rn1WOus5bOTnNIDANYXMhadAb912Ckb5lTK/tCfBcW1Y
sscChUAetBwLPhsYRtAzPieje6Jyk0HSop2VelQDs1/9hCOPBp18GH4OYK9ce0oTg3westUG
U1AJR6DYFhT2Pqj4peLEKCuaw+jblfbjx4WhM4MNcM4NiRVgGTvUhK0CMIIJwDCCB6igAwIB
AgIQQ1uU9mjzEStWsfImiC/9KTANBgkqhkiG9w0BAQsFADBGMQswCQYDVQQGEwJERTEQMA4G
A1UECgwHU2llbWVuczElMCMGA1UEAwwcU2llbWVucyBJbnRlcm1lZGlhdGUgQ0EgMjAyMTAe
Fw0yMTA1MzExMjEzMTVaFw0yNTA3MjgxMjE4MzZaMG0xCzAJBgNVBAYTAkRFMQ8wDQYDVQQI
DAZCYXllcm4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWkQyMSgwJgYDVQQD
DB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDIxMIICIjANBgkqhkiG9w0BAQEFAAOC
Ag8AMIICCgKCAgEAoN2V4m2CmJcicWfCTqrjSltk2RvIxy4qQE4m/kWceGp1OD4bOj+tnhlb
KfF4dyJbRRs30k1oyyfwQoPJNpMBnXz4I8VIux0NgN1nclsWlqX/mviKnxXYflgIrX8ZbPBw
OF4CEv8JQEstPE+968UxD/yx6kHbLtvTbiGeJib2+uRhejgkCG5NHf4dskRH0fs2z0DXHfdm
/gt0RiPY1L9pQpMmtoBLXv5k5qHrzwJIyeSRQcwFrIPRPnQMVMzT8iIm38XfrKfnujEZl6QQ
UeN9/gmTBgLGyUshRyz4JbRZLOC2ZPixYjd9C5JBOUEx7tOKlmu68LoRUratGfTJV5Y18H6H
KIJpWIwsEYGEC4JxN/aXP0y3bgE7ArL2CJsYxel96N0kj+5ebYoh1FwMWzVx0C4AKbP2FPBT
/98ziutBDNnmVeM1trv096igO4dkXjfXehRcCGywWEbeoQ4CcyrULyV2b94C2wGQzP0wuxcS
1gI0W8v+3Q43nKUD0uOMkeiZmy5YVzE1qL4/HGN6N+Fs0pZXyz3Vdpft/C9DbrrUnermVXIC
RUy6M6m7k9JjAmBdnZB8ZDEQ5K1Zm+/SlNPPT+2pEfmckMs57ZJQN8qEcpBbWHGXxlGxbWAT
Ew9fR4Wvv4J5QYLFxfcamBLzsR1o/uQgzDYpZ2OtewA9+PXMFEMCAwEAAaOCBIEwggR9MCkG
A1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAjAfBgNVHSMEGDAWgBSO
RwWcV31gYMtIzPeiYE7S6wC6YjCB+AYIKwYBBQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxk
YXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpEMCxMPVBLST9jQUNlcnRpZmljYXRlMDIG
CCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkQwLmNydDBKBggr
BgEFBQcwAoY+bGRhcDovL2FsLnNpZW1lbnMuY29tL3VpZD1aWlpaWlpEMCxvPVRydXN0Y2Vu
dGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29t
MIICJQYDVR0gBIICHDCCAhgwNgYIKwYBBAGhaQcwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93
d3cuc2llbWVucy5jb20vcGtpLzA7Bg0rBgEEAaFpBwICAwEBMCowKAYIKwYBBQUHAgEWHGh0
dHBzOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOwYNKwYBBAGhaQcCAgMBAjAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMDsGDSsGAQQBoWkHAgIDAgEwKjAo
BggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzA7Bg0rBgEEAaFpBwIC
AwICMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOwYNKwYB
BAGhaQcCAgQBATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MDsGDSsGAQQBoWkHAgIEAQIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2llbWVucy5j
b20vcGtpLzA4BgorBgEEAaFpBwIFMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnNpZW1l
bnMuY29tL3BraS8wNgYIKwYBBAGhaWMwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2ll
bWVucy5jb20vcGtpLzCBxwYDVR0fBIG/MIG8MIG5oIG2oIGzhj9sZGFwOi8vY2wuc2llbWVu
cy5uZXQvQ049WlpaWlpaRDAsTD1QS0k/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3SGJmh0dHA6
Ly9jaC5zaWVtZW5zLmNvbS9wa2k/WlpaWlpaRDAuY3JshkhsZGFwOi8vY2wuc2llbWVucy5j
b20vdWlkPVpaWlpaWkQwLG89VHJ1c3RjZW50ZXI/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3Qw
HQYDVR0OBBYEFNwsp5JBrkGaF+zG5TA968IgZojdMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMB
Af8ECDAGAQH/AgEAMA0GCSqGSIb3DQEBCwUAA4ICAQCQRFKtczqyiCVjEe1JurXTyY/SrPDQ
2VKSQHMFgQbyY/qPL8HJ4PhSVIKvVTxTu4hehv/kPXga2mFgsuJhbGnwfkHH+z3oGHUt8MHk
5LvFpuKF52hfJOIKUclbR8ptJRggB6F4LlFyREKyPleh4CTE/qMKoj5rgYtjm/7OEI1MjeYG
+XGI8ZfjVvtu5FY9PhYQQkrGFV0jdXCAucdW7iL8py5VlzhXSjklHGgpxbY4kprcYQjAIojL
6Xxm/6MqKSEMgH52V3/FQ07ZbBNvvbXbfpPF6IUkGfZHhnu7wSjXfulSV4ZETFxCo6McJxHk
6XAGNtr/k08yyb8VAh9/4ZHNlXmqek7rGYYSArLmCdDSwQVCGQ+QnRSbLU6Z+tp9xFkWLgLs
99VN9rHKxHa6DYI5AI0wjbyp+3+zu0k4YjF2D1PAS6kuFaevC6OhxAw0VB0NEdgyyIKotbVg
jPPOr+yCrjWJMrJmPDuhN32VGsaEgJDgseyvjf/9EJFq6jInibqRi6z3Mw/sD8UrHrUSwc4q
ONR6jLvRAtTbF36ChCkU7c88gDwLE7IvlJcmI3dC44Qpk0PPIS/43h7pwUQ/seqZBTrGXLI8
lEs7NQd+5ORtptnjDFeS6ylh2vlQmNiGn1asdw5lqUMsdGTYASPASbK64GNChYjpYtJPcXDn
ugZiezCCCr0wggiloAMCAQICBD++phowDQYJKoZIhvcNAQELBQAwgZkxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5z
MREwDwYDVQQFEwhaWlpaWlpBMTEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxIjAg
BgNVBAMMGVNpZW1lbnMgUm9vdCBDQSBWMy4wIDIwMTYwHhcNMjEwNTI4MTIxODM2WhcNMjUw
NzI4MTIxODM2WjBGMQswCQYDVQQGEwJERTEQMA4GA1UECgwHU2llbWVuczElMCMGA1UEAwwc
U2llbWVucyBJbnRlcm1lZGlhdGUgQ0EgMjAyMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCC
AgoCggIBANHuP2snBfLKaC2v/ftqGNAN70QkDi/HLP9M7f5xJqcGf42aJYLCx7TYAacdEl1E
+GS2B3LO3nhiD4FI0RFc6CUf0sNUlBBrJp29DEDqKl0CxmsZWRvPHwnvsxNn94VNIRRikD7x
PnW0BdlrhcGhiXDpzv6KP6BPR7I7alLlHdMLAdwXmo6OxYLvazY5WkPVhLGI3qhxi4RHySjO
N+ofObDeFL1utwHtAbD2r4ScLFjro2ln2JNcieXOVR7+q5oewglzYI2fYYwtfy0lwCOu2WVi
3C+D/zeYPJ4HowFGSJDRBlADghAiECtxFOrIcnk8091HLkvgDYeQFMBe0BbWBZ8gPRIhqxgc
63YKKnBmk9o01s9r5aiEoz11E3/wRbWLQgdUZw7nzj5kjCRejP3C1EK4l+1DtOy3o5zZvMFy
avMSUMKGBKrjrOMRX9KCBZHm/jS9MIxZLHudfNvbLHg1KqA3dZPVGBX0X2Qz0xJrM4YOBN02
R7daa+YiSFsfzfs+XEBHpCZuPwY0kydAqB6jN/xkQ0puUe2SU03WKIwmovbq3RH+llCm/w0S
e27XgJT8BMX0Srlj/LHv47+Lk3XftFXTPN9YLJTnYYoyQZA5WWidVYBfdBqTthQaQ4ThKPeY
NOcJzUjimg4c/nqE5b19oDkfJ97KsSW3gIKH/oNkVpPRAgMBAAGjggVdMIIFWTCB+AYIKwYB
BQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpa
WlpBMSxMPVBLST9jQUNlcnRpZmljYXRlMDIGCCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVu
cy5jb20vcGtpP1paWlpaWkExLmNydDBKBggrBgEFBQcwAoY+bGRhcDovL2FsLnNpZW1lbnMu
Y29tL3VpZD1aWlpaWlpBMSxvPVRydXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUH
MAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29tMB8GA1UdIwQYMBaAFHBtoFDsqdAsZ50ZFf79
BHM1w+LUMBIGA1UdEwEB/wQIMAYBAf8CAQEwggLcBgNVHSAEggLTMIICzzA2BggrBgEEAaFp
BzAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMDsGDSsGAQQB
oWkHAgIDAQEwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzA7
Bg0rBgEEAaFpBwICAwECMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnNpZW1lbnMuY29t
L3BraS8wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5zaWVt
ZW5zLmNvbS9wa2kvMDsGDSsGAQQBoWkHAgIDAgEwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93
d3cuc2llbWVucy5jb20vcGtpLzA7Bg0rBgEEAaFpBwICAwICMCowKAYIKwYBBQUHAgEWHGh0
dHBzOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOwYNKwYBBAGhaQcCAgMCAzAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMDsGDSsGAQQBoWkHAgIEAQEwKjAo
BggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzA7Bg0rBgEEAaFpBwIC
BAECMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOwYNKwYB
BAGhaQcCAgQBAzAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MDgGCisGAQQBoWkHAgUwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cuc2llbWVucy5jb20v
cGtpLzA2BggrBgEEAaFpYzAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNv
bS9wa2kvMIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9D
Tj1aWlpaWlpBMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNp
ZW1lbnMuY29tL3BraT9aWlpaWlpBMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9
WlpaWlpaQTEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDBOBgNVHSUE
RzBFBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQGCysGAQQB
gjcKAwQBBgorBgEEAYI3QwEBMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUjkcFnFd9YGDL
SMz3omBO0usAumIwDQYJKoZIhvcNAQELBQADggIBACSjsZwsU6vJMpG8z9G/AQYqhiO9Zi39
M4mIXLpd+bcaeM1lr7prUPTzRWJRrAGlDLgTAc0Mr28f2uSJr+Hzby3TNPgqiVU4KGtJClJi
OEh0YJxOAYhdDBUb0UpAoUTKujxkf9T1Gd8MWwtBDmci11nF5efyiPzex7UPSKBr6jLOz0KY
jSouzv1DZ373EvaH1VvJ4qUclt1lE1BkYS+HMhT9Vr/NDyh71Ifco/DHA9FuU6CqeZVJ8HQN
eX7xmq6m+05QAf3QnwJG/zpXcy6BALVpRdTUQ7U5WKF4O2bmZeZl8jRwpWMEIny8NMwNfx4K
1XSISVjVpqwaVA/qAj175lHnj7MbiajNF+DlWIlrYkYF/coEGHs4qdDO4xnL1dfUfvAQLhqA
Okzh4pWjw1Ie9Q//WPfuuWtwvIKszu4+0NO5HZ+Jw4v680R7ONbN6V/A1/HEo7a2ZQTtCeLE
LMvmQQ3GYasXMiEsPX04ilKPAfF4dMLM/sSgkFiGORXv8mo8/2lFWHPSiVaczEqxh7KEPd+4
KPGeG6OzMt59db49smodQZPunqcu3H/STNWj2w+S37JTyKQ3/O8n1Fpzq0VMirs2/ax0RD7B
swAJe/X6YizMB5BYcsYEkohRSIICwvBifCWZSED6AU5gc6OgBKhjOynA3L0Xy2KUI//bQ0aW
VQpMMYIDsjCCA64CAQEwgYEwbTELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjEQMA4G
A1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaRDIxKDAmBgNVBAMMH1NpZW1lbnMgSXNz
dWluZyBDQSBFRSBBdXRoIDIwMjECEF52WdX2ok9SKD9JXLXQGbMwDQYJYIZIAWUDBAIBBQCg
ggIBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAyMzE2
MzMxMlowLwYJKoZIhvcNAQkEMSIEIFYKupZD7uhAqG5jUXbLJXZfhzpyFguMmDV5n5D113jM
MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwIC
ASgwgZEGCSsGAQQBgjcQBDGBgzCBgDBsMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJu
MRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwhaWlpaWlpEMzEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIxAhBAfUgRDppgj3QkouV/nMYgMIGTBgsqhkiG9w0B
CRACCzGBg6CBgDBsMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMRAwDgYDVQQKDAdT
aWVtZW5zMREwDwYDVQQFEwhaWlpaWlpEMzEnMCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENB
IEVFIEVuYyAyMDIxAhBAfUgRDppgj3QkouV/nMYgMA0GCSqGSIb3DQEBAQUABIIBAIbkjdGg
aDDbN97ayHjZrwv3pS4VJMYDyCQKab6wndko25suahN1iqGSPowg5R+fg2a+qHwz/UuMNNR/
l5waPY/z/bLaJQYfSvygz5q8le4tMMy6svRSegHNPEqEDH7tNNrPHdbzis4fZlcJY3OYxydH
Lm/VQOGNYYmV6beDl+/j3ZOF+F1gjiND85/WztZbRQiReKONvip6epZkHYeeiUWzgjaGJmct
I7U8/cgpnFNCWiopS9/9BvMejTrVxduBlzZiccQgCuAlE5A2XnmYkYsdmj7IzDvG2jfQambm
1+CNzM4KoYsKM4SSjv+mMzGJwk679zhCASxg8tTfzMlkYVUAAAAAAAA=

--------------ms060401080308020507070108--
