Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F05B5902
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiILLKX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 07:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiILLKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 07:10:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6521251;
        Mon, 12 Sep 2022 04:10:20 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MR3gD08Pqz685ZP;
        Mon, 12 Sep 2022 19:06:00 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (7.191.162.219) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 12 Sep 2022 13:10:18 +0200
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 12:10:17 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2375.031;
 Mon, 12 Sep 2022 12:10:17 +0100
From:   Hernan Luis Ponce de Leon <hernanl.leon@huawei.com>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>
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
Thread-Index: AQFTHlbyPG8prHkfhsVi+5kWxbhPeQF4BTgfASiPsr8Ag2bPhQCWSQQGAdXuv7eutboz0IABoUKwgAAidwCAAGhxQIAA2vMAgAGe72CAABESUA==
Date:   Mon, 12 Sep 2022 11:10:17 +0000
Message-ID: <7ad2354bf993435b917f278d4199a6ff@huawei.com>
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
 <34735a476c3b4913985de3403a6216bd@huawei.com>
In-Reply-To: <34735a476c3b4913985de3403a6216bd@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.77]
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

PiBUaGVyZWZvcmUgdGhpcyBoYW5nIHNob3VsZCBiZSBvYnNlcnZhYmxlIG9uIGEgaHlwb3RoZXRp
Y2FsIExLTU0gcHJvY2Vzc29yDQo+IHdoaWNoIG1ha2VzIHVzZSBvZiBhbGwgdGhlIHJlbGF4ZWQg
bGliZXJ0eSB0aGUgTEtNTSBhbGxvd3MuIEhvd2V2ZXIgYWNjb3JkaW5nDQo+IHRvIHRoZSBhdXRo
b3JzIG9mIHRoYXQgcGFwZXIgKHdobyBhcmUgbXkgY29sbGVhZ3VlcyBidXQgSSBoYXZlbid0IGJl
ZW4gaW52b2x2ZWQNCj4gZGVlcGx5IGluIHRoYXQgd29yayksIG5vdCBldmVuIFBvd2VyK2djYyBh
bGxvdyB0aGlzIHJlb3JkZXJpbmcgdG8gaGFwcGVuLCBhbmQgaWYNCj4gdGhhdCdzIHRydWUgaXQg
aXMgcHJvYmFibHkgYmVjYXVzZSB0aGUgd21iIGlzIG1hcHBlZCB0byBsd3N5bmMgd2hpY2ggaXMg
ZnVsbHkNCj4gY3VtdWxhdGl2ZSBpbiBQb3dlciBidXQgbm90IGluIExLTU0uDQoNCkFsbCB0aGUg
Imlzc3VlcyIgd2UgbWVudGlvbiBpbiB0aGUgdGVjaG5pY2FsIHJlcG9ydCBhcmUgYWNjb3JkaW5n
IHRvIExLTU0uDQpBcyBzaG93biBieSAoKikgYmVsb3csIGFzIHNvb24gYXMgdGhlIGNvZGUgZ2V0
cyBjb21waWxlZCBhbmQgdmVyaWZpZWQgYWdhaW5zdCB0aGUgDQpjb3JyZXNwb25kaW5nIGhhcmR3
YXJlIG1lbW9yeSBtb2RlbCwgdGhlIGNvZGUgaXMgY29ycmVjdC4NCg0KSGVyZSBpcyBhIHNtYWxs
IHZhcmlhbnQgb2YgdGhlIGxpdG11cyB0ZXN0IEkgc2VudCBlYXJsaWVyIHdoZXJlIG5vdCBvbmx5
IHRoZSAicHJvYmxlbWF0aWMgDQpiZWhhdmlvciIgaXMgYWxsb3dlZCBieSBMS01NLCBidXQgd2hl
cmUgbGl2ZW5lc3MgaXMgYWN0dWFsbHkgdmlvbGF0ZWQuDQpUaGUgY29kZSBpcyB3cml0dGVuIGlu
IEMgKG1haW4gZnVuY3Rpb24gYW5kIGhlYWRlcnMgbWlzc2luZykgYW5kIGNhbm5vdCBiZSB1c2Vk
IGRpcmVjdGx5IA0Kd2l0aCBoZXJkNyAoc2luY2UgSSBhbSBub3Qgc3VyZSBpZiB0aGUgZW5kIG9m
IHRocmVhZF8zIGNhbiBiZSB3cml0dGVuIHVzaW5nIGhlcmQ3IHN5bnRheCkuDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KaW50IHksIHo7DQphdG9taWNfdCB4Ow0KDQp2b2lkICp0aHJlYWRfMSh2b2lkICp1
bnVzZWQpDQp7ICAgDQogICAgLy8gY2xlYXJfcGVuZGluZ19zZXRfbG9ja2VkDQogICAgaW50IHIw
ID0gYXRvbWljX2ZldGNoX2FkZCgyLCZ4KSA7DQp9DQoNCnZvaWQgKnRocmVhZF8yKHZvaWQgKnVu
dXNlZCkNCnsNCiAgICAvLyB0aGlzIHN0b3JlIGJyZWFrcyBsaXZlbmVzcw0KICAgIFdSSVRFX09O
Q0UoeSwgMSk7DQogICAgLy8gcXVldWVkX3NwaW5fdHJ5bG9jaw0KICAgIGludCByMCA9IGF0b21p
Y19yZWFkKCZ4KTsNCiAgICAvLyBiYXJyaWVyIGFmdGVyIHRoZSBpbml0aWFsaXNhdGlvbiBvZiBu
b2Rlcw0KICAgIHNtcF93bWIoKTsNCiAgICAvLyB4Y2hnX3RhaWwNCiAgICBpbnQgcjEgPSBhdG9t
aWNfY21weGNoZ19yZWxheGVkKCZ4LHIwLDQyKTsNCiAgICAvLyBsaW5rIG5vZGUgaW50byB0aGUg
d2FpdHF1ZXVlDQogICAgV1JJVEVfT05DRSh6LCAxKTsNCn0NCg0Kdm9pZCAqdGhyZWFkXzModm9p
ZCAqdW51c2VkKQ0Kew0KICAgIC8vIG5vZGUgaW5pdGlhbGlzYXRpb24NCiAgICBXUklURV9PTkNF
KHosIDIpOw0KICAgIC8vIHF1ZXVlZF9zcGluX3RyeWxvY2sNCiAgICBpbnQgcjAgPSBhdG9taWNf
cmVhZCgmeCk7DQogICAgLy8gYmFycmllciBhZnRlciB0aGUgaW5pdGlhbGlzYXRpb24gb2Ygbm9k
ZXMNCiAgICBzbXBfd21iKCk7DQogICAgLy8gaWYgd2UgcmVhZCB6PT0yIHdlIGV4cGVjdCB0byBy
ZWFkIHRoaXMgc3RvcmUNCiAgICBXUklURV9PTkNFKHksIDApOw0KICAgIC8vIHhjaGdfdGFpbA0K
ICAgIGludCByMSA9IGF0b21pY19jbXB4Y2hnX3JlbGF4ZWQoJngscjAsMjQpOw0KICAgIC8vIHNw
aW5sb29wDQogICAgd2hpbGUoUkVBRF9PTkNFKHkpID09IDEgJiYgKFJFQURfT05DRSh6KSA9PSAy
KSkge30NCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpMaXZlbmVzcyBpcyB2aW9sYXRlZCAoZm9sbG93
aW5nIFRoZW9yZW0gNS4zIG9mIHRoZSAiTWFraW5nIHdlYWsgbWVtb3J5IG1vZGVscyBmYWlyIiBw
YXBlcikgYmVjYXVzZSB0aGUgcmVhZHMgZnJvbSB0aGUgc3Bpbmxvb3AgDQpjYW4gZ2V0IHRoZWly
IHZhbHVlcyBmcm9tIHdyaXRlcyB3aGljaCBjb21lIGxhc3QgaW4gdGhlIGNvaGVyZW5jZSAvIG1v
ZGlmaWNhdGlvbiBvcmRlciwgYW5kIHRob3NlIHZhbHVlcyBkbyBub3Qgc3RvcCB0aGUgc3Bpbm5p
bmcuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KJCBqYXZhIC1qYXIgJERBVDNNX0hPTUUvZGFydGFnbmFu
L3RhcmdldC9kYXJ0YWduYW4tMy4xLjAuamFyIGNhdC9saW51eC1rZXJuZWwuY2F0IC0tdGFyZ2V0
PWxrbW0gLS1wcm9wZXJ0eT1saXZlbmVzcyBsaXZlbmVzcy5jDQouLi4NCkxpdmVuZXNzIHZpb2xh
dGlvbiBmb3VuZA0KRkFJTA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCigqKSBIb3dldmVyLCBpZiB0aGUg
Y29kZSBpcyBjb21waWxlZCAodGhpcyB0cmFuc2Zvcm1hdGlvbiBpcyBkb25lIGF1dG9tYXRpY2Fs
bHkgYW5kIGludGVybmFsbHkgYnkgdGhlIHRvb2wsIG5vdGljZSB0aGUgLS10YXJnZXQgb3B0aW9u
KSANCmFuZCB3ZSB1c2Ugc29tZSBoYXJkd2FyZSBtZW1vcnkgbW9kZWwsIHRoZSB0b29sIHNheXMg
dGhlIGNvZGUgaXMgY29ycmVjdA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiQgamF2YSAtamFyICREQVQz
TV9IT01FL2RhcnRhZ25hbi90YXJnZXQvZGFydGFnbmFuLTMuMS4wLmphciBjYXQvYWFyY2g2NC5j
YXQgLS10YXJnZXQ9YXJtOCAtLXByb3BlcnR5PWxpdmVuZXNzIGxpdmVuZXNzLmMNCi4uLg0KUEFT
Uw0KDQokIGphdmEgLWphciAkREFUM01fSE9NRS9kYXJ0YWduYW4vdGFyZ2V0L2RhcnRhZ25hbi0z
LjEuMC5qYXIgY2F0L3Bvd2VyLmNhdCAtLXRhcmdldD1wb3dlciAtLXByb3BlcnR5PWxpdmVuZXNz
IGxpdmVuZXNzLmMNCi4uLg0KUEFTUw0KDQokIGphdmEgLWphciAkREFUM01fSE9NRS9kYXJ0YWdu
YW4vdGFyZ2V0L2RhcnRhZ25hbi0zLjEuMC5qYXIgY2F0L3Jpc2N2LmNhdCAtLXRhcmdldD1yaXNj
diAtLXByb3BlcnR5PWxpdmVuZXNzIGxpdmVuZXNzLmMNCi4uLg0KUEFTUw0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQoNCkkgdGhpbmsgaXQgaXMgc29tZWhvdyBwb3NzaWJsZSB0byBzaG93IHRoZSBsaXZlbmVz
cyB2aW9sYXRpb24gdXNpbmcgaGVyZDcgYW5kIHRoZSBmb2xsb3dpbmcgdmFyaWFudCBvZiB0aGUg
Y29kZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkMgTGl2ZW5lc3MNCnsNCiAgYXRvbWljX3QgeCA9IEFU
T01JQ19JTklUKDApOw0KICBhdG9taWNfdCB5ID0gQVRPTUlDX0lOSVQoMCk7DQp9DQoNCg0KUDAo
YXRvbWljX3QgKngpIHsNCiAgLy8gY2xlYXJfcGVuZGluZ19zZXRfbG9ja2VkDQogIGludCByMCA9
IGF0b21pY19mZXRjaF9hZGQoMix4KSA7DQp9DQoNClAxKGF0b21pY190ICp4LCBpbnQgKnosIGlu
dCAqeSkgew0KICAvLyB0aGlzIHN0b3JlIGJyZWFrcyBsaXZlbmVzcw0KICBXUklURV9PTkNFKCp5
LCAxKTsNCiAgLy8gcXVldWVkX3NwaW5fdHJ5bG9jaw0KICBpbnQgcjAgPSBhdG9taWNfcmVhZCh4
KTsNCiAgLy8gYmFycmllciBhZnRlciB0aGUgaW5pdGlhbGlzYXRpb24gb2Ygbm9kZXMNCiAgc21w
X3dtYigpOw0KICAvLyB4Y2hnX3RhaWwNCiAgaW50IHIxID0gYXRvbWljX2NtcHhjaGdfcmVsYXhl
ZCh4LHIwLDQyKTsNCiAgLy8gbGluayBub2RlIGludG8gdGhlIHdhaXRxdWV1ZQ0KICBXUklURV9P
TkNFKCp6LCAxKTsNCn0NCg0KUDIoYXRvbWljX3QgKngsaW50ICp6LCBpbnQgKnkpIHsNCiAgLy8g
bm9kZSBpbml0aWFsaXNhdGlvbg0KICBXUklURV9PTkNFKCp6LCAyKTsNCiAgLy8gcXVldWVkX3Nw
aW5fdHJ5bG9jaw0KICBpbnQgcjAgPSBhdG9taWNfcmVhZCh4KTsNCiAgLy8gYmFycmllciBhZnRl
ciB0aGUgaW5pdGlhbGlzYXRpb24gb2Ygbm9kZXMNCiAgc21wX3dtYigpOw0KICAvLyBpZiB3ZSBy
ZWFkIHo9PTIgd2UgZXhwZWN0IHRvIHJlYWQgdGhpcyBzdG9yZQ0KICBXUklURV9PTkNFKCp5LCAw
KTsNCiAgLy8geGNoZ190YWlsDQogIGludCByMSA9IGF0b21pY19jbXB4Y2hnX3JlbGF4ZWQoeCxy
MCwyNCk7DQogIC8vIHNwaW5sb29wDQogIGludCByMiA9IFJFQURfT05DRSgqeSk7ICANCiAgaW50
IHIzID0gUkVBRF9PTkNFKCp6KTsgIA0KfQ0KDQpleGlzdHMgKHo9MiAvXCB5PTEgL1wgMjpyMj0x
IC9cIDI6cjM9MikNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpDb25kaXRpb24gIjI6cjM9MiIgZm9yY2Vz
IHRoZSBzcGlubG9vcCB0byByZWFkIGZyb20gdGhlIGZpcnN0IHdyaXRlIGluIFAyIGFuZCAiej0y
IiBmb3JjZXMgdGhpcyB3cml0ZSANCnRvIGJlIGxhc3QgaW4gdGhlIGNvaGVyZW5jZSBvcmRlci4g
Q29uZGl0aW9ucyAiMjpyMj0xIiBhbmQgInk9MSIgZm9yY2UgdGhlIHNhbWUgZm9yIHRoZSBvdGhl
ciByZWFkLg0KaGVyZDcgc2F5cyB0aGlzIGJlaGF2aW9yIGlzIGFsbG93ZWQgYnkgTEtNTSwgc2hv
d2luZyB0aGF0IGxpdmVuZXNzIGNhbiBiZSB2aW9sYXRlZC4NCg0KSW4gYWxsIHRoZSBleGFtcGxl
cyBhYm92ZSwgaWYgd2UgdXNlIG1iKCkgaW5zdGVhZCBvZiB3bWIoKSwgTEtNTSBkb2VzIG5vdCBh
Y2NlcHQNCnRoZSBiZWhhdmlvciBhbmQgdGh1cyBsaXZlbmVzcyBpcyBndWFyYW50ZWVkLg0KDQpI
ZXJuYW4NCg==
