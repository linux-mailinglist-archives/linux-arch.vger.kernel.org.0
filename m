Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29051667C
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352156AbiEARMO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiEARMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 13:12:13 -0400
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1F4D9FC;
        Sun,  1 May 2022 10:08:47 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id DA17C66572;
        Sun,  1 May 2022 13:08:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1651424927;
        bh=XYISo4h8KCnyxTuDi0BN/dzHxVCfbkmceDgjCj19MXU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=2OmCnLlIrXPnbgEiKmC7P7cHlUkobbFyTBLHl+wu/u+DEWBBfiV3w0gRMZM2/jF7s
         0ojeh6h642czjkUxRRFDgLSEPbxTENJTwAluOfhO+fKY6Zfy94K7AtC8LGMhQ+eBK6
         r82alvKa8iTgV5e9bWWyvCUhvEIXIP74fzTgNDL9t/aaABP4GnfzIMTHsIkZUQW+rO
         CGWFBFYBpGmiSYPJ6re0kYZhl/I8V5Wb/UTSFimi9nf9GznCjdr5+JibvWHel+ZHLi
         yvcopxHXTMtghfJgPKaHZ+AXx3w2hZQzQgqHBXdEM4wyEdVkKlivmnlI9c2v0sK8Cp
         GIHAYm+9NZ46A==
Message-ID: <2a534c89b3c905a34f947fb2739d58c9373bb915.camel@mengyan1223.wang>
Subject: Re: [PATCH V9 10/24] LoongArch: Add exception/interrupt handling
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Mon, 02 May 2022 01:08:41 +0800
In-Reply-To: <4dd26d88b807c967dbbc81a7b2e5f4084d9603d7.camel@mengyan1223.wang>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
         <20220430090518.3127980-11-chenhuacai@loongson.cn>
         <4dd26d88b807c967dbbc81a7b2e5f4084d9603d7.camel@mengyan1223.wang>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTAyIGF0IDAwOjI3ICswODAwLCBYaSBSdW95YW8gd3JvdGU6Cj4gT24g
U2F0LCAyMDIyLTA0LTMwIGF0IDE3OjA1ICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKPiA+ICtz
dHJ1Y3QgYWNwaV9tYWR0X2xpb19waWM7Cj4gPiArc3RydWN0IGFjcGlfbWFkdF9laW9fcGljOwo+
ID4gK3N0cnVjdCBhY3BpX21hZHRfaHRfcGljOwo+ID4gK3N0cnVjdCBhY3BpX21hZHRfYmlvX3Bp
YzsKPiA+ICtzdHJ1Y3QgYWNwaV9tYWR0X21zaV9waWM7Cj4gPiArc3RydWN0IGFjcGlfbWFkdF9s
cGNfcGljOwo+IAo+IFdoZXJlIGFyZSB0aG9zZSBkZWZpbmVkP8KgIEkgY2FuJ3QgZmluZCB0aGVt
IGFuZCB0aGUgY29tcGlsYXRpb24gZmFpbHMKPiB3aXRoOgo+IAo+IGFyY2gvbG9vbmdhcmNoL2tl
cm5lbC9pcnEuYzogSW4gZnVuY3Rpb24g4oCYZmluZF9wY2hfcGlj4oCZOgo+IGFyY2gvbG9vbmdh
cmNoL2tlcm5lbC9pcnEuYzo0ODozMjogZXJyb3I6IGludmFsaWQgdXNlIG9mIHVuZGVmaW5lZAo+
IHR5cGUg4oCYc3RydWN0IGFjcGlfbWFkdF9iaW9fcGlj4oCZCj4gwqDCoCA0OCB8wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQgPSBpcnFfY2ZnLT5nc2lfYmFzZTsKPiDCoMKg
wqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBefgo+IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9pcnEuYzo0OTozMjogZXJy
b3I6IGludmFsaWQgdXNlIG9mIHVuZGVmaW5lZAo+IHR5cGUg4oCYc3RydWN0IGFjcGlfbWFkdF9i
aW9fcGlj4oCZCj4gwqDCoCA0OSB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5k
wqDCoCA9IGlycV9jZmctPmdzaV9iYXNlICsgaXJxX2NmZy0+c2l6ZTsKPiDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBefgo+IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9pcnEuYzo0OTo1MjogZXJyb3I6IGludmFs
aWQgdXNlIG9mIHVuZGVmaW5lZAo+IHR5cGUg4oCYc3RydWN0IGFjcGlfbWFkdF9iaW9fcGlj4oCZ
Cj4gwqDCoCA0OSB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5kwqDCoCA9IGly
cV9jZmctPmdzaV9iYXNlICsgaXJxX2NmZy0+c2l6ZTsKPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn4KCkFscmlnaHQsIG15IGJhZC4u
LiBJIGRpZG4ndCByZWFsaXplIHRoZSBMb29uZ0FyY2ggcGF0Y2hlcyBhcmUgc3BsaXR0ZWQKaW50
byBtdWx0aXBsZSBzZXJpZXMgZm9yIG11bHRpcGxlIGxpc3RzLiAgQnV0IGlzIHRoaXMgdGhlIFNP
UCBvZiBrZXJuZWwKcGF0Y2ggcmV2aWV3aW5nPyAgV291bGQgaXQgYmUgZWFzaWVyIHRvIGp1c3Qg
c2VuZCBvbmUgc2VyaWVzIGFuZCBDQyBhbGwKcmVsZXZlbnQgbGlzdHM/CgotLSAKWGkgUnVveWFv
IDx4cnkxMTFAbWVuZ3lhbjEyMjMud2FuZz4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFu
ZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQo=

