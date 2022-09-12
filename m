Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672AE5B57F9
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiILKNj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiILKNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 06:13:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E41D0E2;
        Mon, 12 Sep 2022 03:13:36 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MR2Tk6qdHz68735;
        Mon, 12 Sep 2022 18:12:42 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 12:13:33 +0200
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 11:13:33 +0100
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.031;
 Mon, 12 Sep 2022 11:13:33 +0100
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory
 Models"
Thread-Topic: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0IABoUKwgAAidwCAAGhxQIAA2vMAgAGe72A=
Date:   Mon, 12 Sep 2022 10:13:33 +0000
Message-ID: <34735a476c3b4913985de3403a6216bd@huawei.com>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu> <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
 <674d0fda790d4650899e2fcf43894053@huawei.com>
 <b7e32a603fdc4883b87c733f5681c6d9@huawei.com>
 <YxynQmEL6e194Wuw@rowland.harvard.edu>
 <e8b6b7222a894984b4d66cdcc6435efe@huawei.com>
 <CAEXW_YQPSi7RyA=Cz5S753uw4SqBp2v+7CqqE3LN9VQ48q40Zg@mail.gmail.com>
In-Reply-To: <CAEXW_YQPSi7RyA=Cz5S753uw4SqBp2v+7CqqE3LN9VQ48q40Zg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.157.136]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgSm9lbCwNCg0KPiBJIHdvbmRlciBpZiB0aGlzIHNvcnQgb2YgbGl2ZW5lc3MgZ3VhcmFudGVl
IChvciBsYWNrIHRoZXJlb2YpIGlzIHJlYWxseSBhIHByb2JsZW0gaW4gcHJhY3RpY2UsIHdoZXJl
IHdyaXRlcyB3aWxsIGV2ZW50dWFsbHkgcHJvcGFnYXRlIGV2ZW4gdGhvdWdoIHRoZXkgbWF5IG5v
dCBmb3IgYSBiaXQuIElzIGl0IHBvc3NpYmxlIHRvIHdyaXRlIGEgbGl2ZW5lc3MgdGVzdCBjYXNl
IG9uIGFueSBoYXJkd2FyZSwgb3IgaXMgdGhpcyBtb3JlIGluIHRoZSByZWFsbXMgb2YgdGhlb3J5
Pw0KRWl0aGVyIHdheSwgcXVpdGUgaW50cmlndWluZyENCg0KQXMgSSB0cmllZCB0byBleHBsYWlu
IGJlZm9yZSwgdGhpcyBwcm9ibGVtIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggc3RvcmVzIHByb3Bh
Z2F0aW5nIHdpdGhpbiBhIGdpdmVuIHRpbWUgdG8gYW5vdGhlciBjb3JlLiBSYXRoZXIgaXQgaXMg
ZHVlIHRvIHR3byBzdG9yZXMgdG8gdGhlIHNhbWUgbG9jYXRpb24gaGFwcGVuaW5nIGluIGEgc3Vy
cHJpc2luZyBvcmRlci4gSS5lLiwgYm90aCBzdG9yZXMgcHJvcGFnYXRlIHF1aWNrbHkgdG8gb3Ro
ZXIgY29yZXMsIGJ1dCBpbiBhIHN1cnByaXNpbmcgY29oZXJlbmNlIG9yZGVyLkFuZCBpZiBhIHdt
YiBpbiB0aGUgY29kZSBpcyByZXBsYWNlZCBieSBhbiBtYiwgdGhlbiB0aGlzIGNvIHdpbGwgY3Jl
YXRlIGEgcGIgY3ljbGUgYW5kIGJlY29tZSBmb3JiaWRkZW4uDQoNClRoZXJlZm9yZSB0aGlzIGhh
bmcgc2hvdWxkIGJlIG9ic2VydmFibGUgb24gYSBoeXBvdGhldGljYWwgTEtNTSBwcm9jZXNzb3Ig
d2hpY2ggbWFrZXMgdXNlIG9mIGFsbCB0aGUgcmVsYXhlZCBsaWJlcnR5IHRoZSBMS01NIGFsbG93
cy4gSG93ZXZlciBhY2NvcmRpbmcgdG8gdGhlIGF1dGhvcnMgb2YgdGhhdCBwYXBlciAod2hvIGFy
ZSBteSBjb2xsZWFndWVzIGJ1dCBJIGhhdmVuJ3QgYmVlbiBpbnZvbHZlZCBkZWVwbHkgaW4gdGhh
dCB3b3JrKSwgbm90IGV2ZW4gUG93ZXIrZ2NjIGFsbG93IHRoaXMgcmVvcmRlcmluZyB0byBoYXBw
ZW4sIGFuZCBpZiB0aGF0J3MgdHJ1ZSBpdCBpcyBwcm9iYWJseSBiZWNhdXNlIHRoZSB3bWIgaXMg
bWFwcGVkIHRvIGx3c3luYyB3aGljaCBpcyBmdWxseSBjdW11bGF0aXZlIGluIFBvd2VyIGJ1dCBu
b3QgaW4gTEtNTS4NCg0KQmVzdCB3aXNoZXMgYW5kIGhvcGUgdGhpcyBjbGVhcnMgaXQgdXAsIGpv
bmFzDQo=
