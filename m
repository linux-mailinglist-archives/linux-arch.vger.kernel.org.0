Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED363C0ED
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiK2NWJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 08:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiK2NVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 08:21:40 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2074.outbound.protection.outlook.com [40.92.52.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738756573;
        Tue, 29 Nov 2022 05:21:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pearl6HtDHGRuUhp0Mcej4QZUdoSOuS0zdISN3GVOxnJfQYY9GUQhuYKNC7pf0uRReJTiqmdLrf9qlUGCgiifJalffvS0GOXxzjX9ymKAowCJF9yel4Os580Py5pJWSPtB/vCgUCTqF1kP1KWObcEpsM6QJu4cjqnXb9X847StrLMbznwxjaaz4n/8WcST0e+1MGw2d0xA7F75ZYQdGwUovf4oQVgklXFZljm41hxZGwrmatq4l351kyIH4/oxVViIMWnu1Q0Z1p5wvcuSMPw1riSYA2OEliCdvJFe1qgGt+CrU2/vxC2FHwNIn6A7C4E9T+ArXzn7Jc6QVFElcRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcHlZyHMmM1LeDIZrUe7hjj/IcsPstLhyYv1534gfn8=;
 b=U4fHos3t/cxMrn+BwpEwIzSt79eZ2YvmMukZmFIQqTJGCNaVX3/yICOo5csX4qMneDUPaF9kF70wIAJL6a3Nl61VR7+9Rord2slS483SNShY8X4T13axaPokxPm90Uq3xtGcbI6wS4GuL+D52Xw9C6BOmNXm99KW2jq65SLa/WWc/hNT+X3BmBCA4QkoVP/EmFnFAbqvTqsvwlF50BilNZRb6WyyhYqBdRRl8K42N3rTcV/mGPEs85rH0YqNMxqY8EFZ5RSwPtOgdmnIiv4xiLUtkp6gTkeqEeVVsU79MSEY14olxKf9PrkCkH24opaMCB/BRKGBgeJIsA1VCMb9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcHlZyHMmM1LeDIZrUe7hjj/IcsPstLhyYv1534gfn8=;
 b=mTMBxSF9fYKW9maWTQYjRxyo5zN7obgq56dl9XWrOhortjF0/Iws601nwn6LsZNLCykcS7pZCK/qX7vz8N+XmoOL6A64xqVXSCc4D6/YudEHJSkyE+3aiFL69qQrhl6x8AF9ni55Y9N9CxIwP1T7DwBwxVANPAC+xvAVstlbjeIeOhOtb44PTBnl3m3cWYNRW3ZzPRLjNff1v304oBLosjnoMikYOFQli5n+G0tO7AIu1SAiUYtoi1LlYn6S8TeH15vYoLYbJE8LayVlNq4aSHfLq6tFgZao7ok6kmUhefP92c2CCBsNcP9YXz6/NN/g9St/iG9/DNxhHYYrmvcMqA==
Received: from SL2PR01MB2812.apcprd01.prod.exchangelabs.com
 (2603:1096:100:52::18) by KL1PR01MB5229.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Tue, 29 Nov
 2022 13:21:31 +0000
Received: from SL2PR01MB2812.apcprd01.prod.exchangelabs.com
 ([fe80::993a:e6a2:ccfc:8cdd]) by SL2PR01MB2812.apcprd01.prod.exchangelabs.com
 ([fe80::993a:e6a2:ccfc:8cdd%4]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 13:21:31 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Fixed a typo in atomic_t.txt
Date:   Tue, 29 Nov 2022 18:50:59 +0530
Message-ID: <SL2PR01MB281219C24708CE54EC1FC610F8129@SL2PR01MB2812.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yO4CLxu9Re5qYr6vmjXpx5ZZJhnW9V9SLlz4ihzXMVZl+z4BluHUGlF/glsfLNsO]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To SL2PR01MB2812.apcprd01.prod.exchangelabs.com
 (2603:1096:100:52::18)
X-Microsoft-Original-Message-ID: <20221129132059.7027-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB2812:EE_|KL1PR01MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7474d57d-6c13-44c4-7ac6-08dad20ca072
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHAufLPWJ3RR4Mwqsa4c4EXMKTl0NUoaxM2EBaxcDDMXj/CcsZDifjSH9Mu6UYAweNWV1pHaVsoP8l4yuOis1erljAr85XeXduws50Sury7xK1bn/kpbGB36dPId4sGHy/Lplx0zZ2JGxECN95J2jJ7BDctjUwRMMQeaZOMWuF8at9SF1d4EFXIjMP6opyreKiWoFfYOATYrT6nuA3EOO/sZMtelcMTw5vdQL04Qv69RfP/aKZdEaf7qDfJdO1ZWWpv5sx0kboK0zxD8STwtc76gkLxSlRAZ1C03jNW1ZseL68WF9EYFfuc3JTz9m5LbTI5UFPv8qIB9aw/4HfH6YagJDpWCF9dIeBap6338V027Gm60/nYfv4MXYdxIlXu9/w2iVs6WE9/QntWU/y3B4LL1uBN7AY3G2qNwJq2wI/vOGeG1AQem96iLE0HbcQzwbBzp9cRmQGVz3ncs20QeHztvh4ZCD8ged42vTHRMRjUcCTIFIXw47tfm2hBgiwJrnUlOZKjIt/9vMxUb64nGjbbwAEowVZLfmYj2SDTcmfZXjNg7difSM6l7KfoeYX/aerrdM6tVuoDPD1GFMtaJ927x7ZRz2xNB8RpBh9d9azQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xRPI0Zd6X8/kxwPlLjYq2ZHXS88bcZg6kmYHaSxLARA/G9tct3Ehh3K3zMOt?=
 =?us-ascii?Q?v+nSC5dl/XTLZp7lRQHl0mKSQdqF+qoAERXrJUvjyTzilUCUze2d0LdXGbW6?=
 =?us-ascii?Q?S8YDh6gytz6vseMcOTZ7+subaWJWxhpHYc5rfl/jHLKTMQnXFNQoyogOCNGd?=
 =?us-ascii?Q?ZcZDrAkvVY+mSFJzdb3kSbjPrUSLWdhvMaukMoM2CK1PhqDAv2m3wXoUYoIO?=
 =?us-ascii?Q?HNOemxzxGym2odtyHKQEHR/q3u5pEgZJC//QWfwNSvYPLpbwo1HWDlOGpY03?=
 =?us-ascii?Q?cPoZaDkppx+ZHyxQL23GXg219SV1bImZOa/R3HkivMb7e/k4ThJJUHWjaz3c?=
 =?us-ascii?Q?GTi+9t8kJ16u35iBjrFXyQg3clvaVqz6psv909zaqedOCDgieJtyc+c9rW2E?=
 =?us-ascii?Q?9Cwym7KCYJW86HISN0CMUBVa+xMkkrjusiBDERHWZBgKFeb706iTIi4LT4AQ?=
 =?us-ascii?Q?y9F35XQ2nHmWB5uQBbeegyErjdH0+hVUVW/PpRVnHIvaSWOXUkeHp7ipVB89?=
 =?us-ascii?Q?EUHPa2aFP5IufyLRFShDfHv6iswb12M6uE6q9QN5EOViAePflLvMC4jS7pWY?=
 =?us-ascii?Q?csiclaBbtDlq6Tj3HzRL1g21H0e5QbPJDG654R5e5Thl5LVinf/mgUh7oqes?=
 =?us-ascii?Q?XXQSe6iJs6AWllrqo9imE+KaS7TrD+AhaYooEGsSKEVVZP9v2Yg961hwyxPp?=
 =?us-ascii?Q?CcY6ozBn9kTokCOsf2EpzneOH+d/tx/lhd1+SXmi81PZn93VQ9MeGXRRxQ8R?=
 =?us-ascii?Q?NbtQuDMQTag27HpUE0CE3BCO4YFZlFGt4IRkcXRFUPq45mm/xe4JnATnZQGs?=
 =?us-ascii?Q?KqofE+mpEsRdCrAdVF8YNaIoItmjdliDAR1eFJDxlg5NKqfxE4oMGLYZ/Ib9?=
 =?us-ascii?Q?uQeoMFHKY8XPJ1odByg8x7hYUsj4Ka9enuuAO9k7kcOS3oy9I0yuohbGMUIn?=
 =?us-ascii?Q?O61GPj6aAY7vnC64XQk0Csz8EPw4JrKId00cY68Nkgtfh5S7Ww414YOTC79I?=
 =?us-ascii?Q?5g9B8AybLqLIkqMEqj1F8b6fTWCeE2Jk3yAPY2IGmCgsWIaeYjyo0LpXeqom?=
 =?us-ascii?Q?HaKv6+Yz3g4cdMgB/y048DGkhIM/1k2jZ5LlROt+Rm4xXQa1f3v2+qU0whwI?=
 =?us-ascii?Q?mhsHgIkMV+WuVdpktYy8O1SY7FYSlNNKBU1f8bSBG/WfbWyCgkLah0o4PSlR?=
 =?us-ascii?Q?1xnFIOHHsDFJ4abhKlj7FZLUeuMy0bHOIJQw2aF/e7vHkei5bbSrW+FRtbuk?=
 =?us-ascii?Q?58R9CgbYSDDR6xLAmN77OUl04cKx6rHssHkmdQ04xR0K1O5IP5HMJOY+BS0J?=
 =?us-ascii?Q?H2P7xh4Oasoa8PvHmOwfoAyXVCEC/zTJXV37/kegN0I+eg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7474d57d-6c13-44c4-7ac6-08dad20ca072
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB2812.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 13:21:30.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fixed a typo in the word 'architecture'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 Documentation/atomic_t.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0f1ffa03db09..d7adc6d543db 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -324,7 +324,7 @@ atomic operations.
 
 Specifically 'simple' cmpxchg() loops are expected to not starve one another
 indefinitely. However, this is not evident on LL/SC architectures, because
-while an LL/SC architecure 'can/should/must' provide forward progress
+while an LL/SC architecture 'can/should/must' provide forward progress
 guarantees between competing LL/SC sections, such a guarantee does not
 transfer to cmpxchg() implemented using LL/SC. Consider:
 
-- 
2.38.1

