Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17260704F1A
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjEPNUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjEPNUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 09:20:02 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2D1BCA;
        Tue, 16 May 2023 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1684243201;
        bh=a92cidYbVH3PAyYIBQAv4MUktH/S/qe5ZnVaVfKoqjY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q+FsdWJND9mF31sYnRWQP1qnL6UrElh7TtH4Op6E3TMQA2NiKPEssFsp7rLaIktxz
         30JsYL5v/gOF8LL6fWlVwUj976xcqXcafkLBsex/Zmiefdi+pCcZDeDx7krqSdw4+f
         FTXJoL9ReyZZZs25xxmIi6tM0m9j6qQGbtyHJBoM=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A938B663D4;
        Tue, 16 May 2023 09:19:58 -0400 (EDT)
Message-ID: <2ce668fc3384691cf08d70e36c25e754aab5042a.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Support dbar with different hints
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jun Yi <yijun@loongson.cn>
Date:   Tue, 16 May 2023 21:19:56 +0800
In-Reply-To: <20230516124536.535343-1-chenhuacai@loongson.cn>
References: <20230516124536.535343-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTE2IGF0IDIwOjQ1ICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKPiBU
cmFkaXRpb25hbGx5LCBMb29uZ0FyY2ggdXNlcyAiZGJhciAwIiAoZnVsbCBjb21wbGV0aW9uIGJh
cnJpZXIpIGZvcgo+IGV2ZXJ5dGhpbmcuIEJ1dCB0aGUgZnVsbCBjb21wbGV0aW9uIGJhcnJpZXIg
aXMgYSBwZXJmb3JtYW5jZSBraWxsZXIsIHNvCj4gTG9vbmdzb24tM0E2MDAwIGFuZCBuZXdlciBw
cm9jZXNzb3JzIGludHJvZHVjZSBkaWZmZXJlbnQgaGludHM6Cj4gCj4gQml0NDogb3JkZXJpbmcg
b3IgY29tcGxldGlvbiAoMDogY29tcGxldGlvbiwgMTogb3JkZXJpbmcpCj4gQml0MzogYmFycmll
ciBmb3IgcHJldmlvdXMgcmVhZCAoMDogdHJ1ZSwgMTogZmFsc2UpCj4gQml0MjogYmFycmllciBm
b3IgcHJldmlvdXMgd3JpdGUgKDA6IHRydWUsIDE6IGZhbHNlKQo+IEJpdDE6IGJhcnJpZXIgZm9y
IHN1Y2NlZWRpbmcgcmVhZCAoMDogdHJ1ZSwgMTogZmFsc2UpCj4gQml0MDogYmFycmllciBmb3Ig
c3VjY2VkZGluZyB3cml0ZSAoMDogdHJ1ZSwgMTogZmFsc2UpCj4gCj4gSGludCAweDcwMDogYmFy
cmllciBmb3IgInJlYWQgYWZ0ZXIgcmVhZCIgZnJvbSB0aGUgc2FtZSBhZGRyZXNzLCB3aGljaAo+
IGlzIG5lZWRlZCBieSBMTC1TQyBsb29wcy4KCkdyZWF0ISAgSSBndWVzcyBYdWVydWkgd291bGQg
YWRkIHRoaXMgaW50byBoaXMgd2Vla2x5IG5ld3MgOikuCgpJIGRvbid0IHJlYWxseSB1bmRlcnN0
YW5kIHRoZXNlIEMrKy1tZW1vcnktbW9kZWwtbGlrZSBjb25jZXB0cyBzbyBJJ2xsCm5vdCByZXZp
ZXcgdGhlICJvcndydyIgcGFydHMsIGJ1dC4uLgoKLyogc25pcCAqLwoKPiBkaWZmIC0tZ2l0IGEv
YXJjaC9sb29uZ2FyY2gvbW0vdGxiZXguUyBiL2FyY2gvbG9vbmdhcmNoL21tL3RsYmV4LlMKPiBp
bmRleCAyNDRlMmY1YWVlZTUuLjI0MGNlZDU1NTg2ZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25n
YXJjaC9tbS90bGJleC5TCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvbW0vdGxiZXguUwo+IEBAIC0x
ODQsNyArMTg0LDcgQEAgdGxiX2h1Z2VfdXBkYXRlX2xvYWQ6Cj4gwqDCoMKgwqDCoMKgwqDCoGVy
dG4KPiDCoAo+IMKgbm9wYWdlX3RsYl9sb2FkOgo+IC3CoMKgwqDCoMKgwqDCoGRiYXLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAwCj4gK8KgwqDCoMKgwqDCoMKgZGJhcsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDB4NzAwCgpUaGVyZSBpcyBubyBMTC9TQyBsb29wIGhlcmUuICBJIGd1ZXNzIHRoaXMg
c2hhcmVzIGEgc2FtZSBpbnRlcm5hbCB1YXJjaApsb2dpYyBhcyB0aGUgTEwvU0MgbG9vcCwgYnV0
IHRoZXJlIHNob3VsZCBiZSBhIGNsYXJpZmljYXRpb24gZm9yIDB4NzAwCmluIHRoZSBjb21taXQg
bWVzc2FnZS4KCj4gwqDCoMKgwqDCoMKgwqDCoGNzcnJkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJh
LCBFWENFUFRJT05fS1MyCj4gwqDCoMKgwqDCoMKgwqDCoGxhX2Fic8KgwqDCoMKgwqDCoMKgwqDC
oMKgdDAsIHRsYl9kb19wYWdlX2ZhdWx0XzAKPiDCoMKgwqDCoMKgwqDCoMKganLCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdDAKPiBAQCAtMzMzLDcgKzMzMyw3IEBAIHRsYl9odWdlX3VwZGF0
ZV9zdG9yZToKPiDCoMKgwqDCoMKgwqDCoMKgZXJ0bgo+IMKgCj4gwqBub3BhZ2VfdGxiX3N0b3Jl
Ogo+IC3CoMKgwqDCoMKgwqDCoGRiYXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAwCj4gK8KgwqDC
oMKgwqDCoMKgZGJhcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4NzAwCj4gwqDCoMKgwqDCoMKg
wqDCoGNzcnJkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhLCBFWENFUFRJT05fS1MyCj4gwqDCoMKg
wqDCoMKgwqDCoGxhX2Fic8KgwqDCoMKgwqDCoMKgwqDCoMKgdDAsIHRsYl9kb19wYWdlX2ZhdWx0
XzEKPiDCoMKgwqDCoMKgwqDCoMKganLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdDAKPiBA
QCAtNDgwLDcgKzQ4MCw3IEBAIHRsYl9odWdlX3VwZGF0ZV9tb2RpZnk6Cj4gwqDCoMKgwqDCoMKg
wqDCoGVydG4KPiDCoAo+IMKgbm9wYWdlX3RsYl9tb2RpZnk6Cj4gLcKgwqDCoMKgwqDCoMKgZGJh
csKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDAKPiArwqDCoMKgwqDCoMKgwqBkYmFywqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgMHg3MDAKPiDCoMKgwqDCoMKgwqDCoMKgY3NycmTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmEsIEVYQ0VQVElPTl9LUzIKPiDCoMKgwqDCoMKgwqDCoMKgbGFfYWJzwqDCoMKg
wqDCoMKgwqDCoMKgwqB0MCwgdGxiX2RvX3BhZ2VfZmF1bHRfMQo+IMKgwqDCoMKgwqDCoMKgwqBq
csKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0MAoKLS0gClhpIFJ1b3lhbyA8eHJ5MTExQHhy
eTExMS5zaXRlPgpTY2hvb2wgb2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xvZ3ksIFhp
ZGlhbiBVbml2ZXJzaXR5Cg==

