Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43206010F2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJQOUZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 10:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJQOUY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 10:20:24 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6950075;
        Mon, 17 Oct 2022 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1666016418;
        bh=Bsn3Ibp0V3HyTiAgkJBIKJfAxItjnDlTT+O4Mf3CoEM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BYwcSMhRTQRLJIJddtiHpdLb8+tyik5xy+8aIhhI8Au2ggOlIo5AqFOhiccuLViRM
         1vClsfPPLJJrT8ZGw19kxUY7V5A89bPwDbmh1VChhaYFvZzwYmi6tMXr3YL00QRspF
         fge7XAFyW68NUFfN/cEHpWhEuocaWzrHtb3CxIc0=
Received: from [IPv6:240e:358:1124:a900:dc73:854d:832e:3] (unknown [IPv6:240e:358:1124:a900:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 15469661C1;
        Mon, 17 Oct 2022 10:20:09 -0400 (EDT)
Message-ID: <b31086df86febba62f76ff9ec775b7a6e16c1933.camel@xry111.site>
Subject: Re: [PATCH V3] LoongArch: Add unaligned access support
From:   Xi Ruoyao <xry111@xry111.site>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Huacai Chen' <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Oct 2022 22:19:59 +0800
In-Reply-To: <39ea2a6fee654b68974ef38237a61e80@AcuMS.aculab.com>
References: <20221017125209.2639531-1-chenhuacai@loongson.cn>
         <39ea2a6fee654b68974ef38237a61e80@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTE3IGF0IDEzOjExICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6Cj4g
RnJvbTogSHVhY2FpIENoZW4KPiA+IFNlbnQ6IDE3IE9jdG9iZXIgMjAyMiAxMzo1Mgo+ID4gCj4g
PiBMb29uZ3Nvbi0yIHNlcmllcyAoTG9vbmdzb24tMks1MDAsIExvb25nc29uLTJLMTAwMCkgZG9u
J3Qgc3VwcG9ydAo+ID4gdW5hbGlnbmVkIGFjY2VzcyBpbiBoYXJkd2FyZSwgd2hpbGUgTG9vbmdz
b24tMyBzZXJpZXMgKExvb25nc29uLTNBNTAwMCwKPiA+IExvb25nc29uLTNDNTAwMCkgYXJlIGNv
bmZpZ3VyYWJsZSB3aGV0aGVyIHN1cHBvcnQgdW5hbGlnbmVkIGFjY2VzcyBpbgo+ID4gaGFyZHdh
cmUuIFRoaXMgcGF0Y2ggYWRkIHVuYWxpZ25lZCBhY2Nlc3MgZW11bGF0aW9uIGZvciB0aG9zZSBM
b29uZ0FyY2gKPiA+IHByb2Nlc3NvcnMgd2l0aG91dCBoYXJkd2FyZSBzdXBwb3J0Lgo+ID4gCj4g
Li4uLi4KPiA+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoaW5zbi5yZWcyaTEyX2Zvcm1hdC5v
cGNvZGUgPT0gZnN0ZF9vcCB8fAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlu
c24ucmVnM19mb3JtYXQub3Bjb2RlID09IGZzdHhkX29wKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgdmFsdWUgPSByZWFkX2ZwcihpbnNuLnJlZzJpMTJfZm9ybWF0LnJkKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgPSB1bmFsaWduZWRfd3JpdGUo
YWRkciwgdmFsdWUsIDgpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXMpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdv
dG8gZmF1bHQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2UgaWYgKGluc24ucmVnMmkxMl9mb3Jt
YXQub3Bjb2RlID09IGZzdHNfb3AgfHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpbnNuLnJlZzNfZm9ybWF0Lm9wY29kZSA9PSBmc3R4c19vcCkgewo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHZhbHVlID0gcmVhZF9mcHIoaW5zbi5yZWcyaTEyX2Zvcm1hdC5y
ZCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVzID0gdW5hbGlnbmVkX3dy
aXRlKGFkZHIsIHZhbHVlLCA0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAocmVzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBnb3RvIGZhdWx0Owo+IAo+IEFyZSB0aG9zZSByaWdodD8KPiBTaG91bGRuJ3Qgc29tZXRoaW5n
IGJlIGNvbnZlcnRpbmcgZnJvbSAnZG91YmxlJyB0bwo+ICdmbG9hdCcgaW4gdGhlcmU/Cj4gQW5k
IGdlbmVyYXRpbmcgU0lHRlBFICg/KSBpZiB0aGUgZXhwb25lbnQgaXMgb3V0IG9mIHJhbmdlLgoK
VG8gbWUgaXQgbG9va3MgcmlnaHQuCgpUaGUgc2VtYW50aWMgb2YgRlNULlMgZG9lcyBub3QgaW5j
bHVkZSBjb252ZXJzaW9uLiAgSXQganVzdCBzdG9yZXMgdGhlCmxvd2VyIDMyIGJpdHMgb2YgYSBm
bG9hdGluZy1wb2ludCByZWdpc3RlciBpbnRvIHRoZSBtZW1vcnkuICBJZiBzb21lb25lCmF0dGVt
cHRzIHRvIHVzZSBGU1QuUyB0byBjb252ZXJ0IGEgZG91YmxlIGludG8gYSBmbG9hdCwgaXQncyBh
CnByb2dyYW1taW5nIGVycm9yLgoKLS0gClhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPgpT
Y2hvb2wgb2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xvZ3ksIFhpZGlhbiBVbml2ZXJz
aXR5Cg==

