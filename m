Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897C532AAF
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiEXMte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiEXMtd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 08:49:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1049A205F6;
        Tue, 24 May 2022 05:49:30 -0700 (PDT)
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Tue, 24 May 2022
 20:48:49 +0800 (GMT+08:00)
X-Originating-IP: [123.113.115.138]
Date:   Tue, 24 May 2022 20:48:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2O6LaF?= <lichao@loongson.cn>
To:     "Huacai Chen" <chenhuacai@gmail.com>
Cc:     "Xi Ruoyao" <xry111@xry111.site>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <CAAhV-H4BHUTshe2w-KnJ3hLveaFWRJihyDwnOnAbSYWDV_18LA@mail.gmail.com>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn>
 <14f922495a09898017e4db3baed5b434acadac12.camel@xry111.site>
 <CAAhV-H4BHUTshe2w-KnJ3hLveaFWRJihyDwnOnAbSYWDV_18LA@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: xi5Sa2Zvb3Rlcl90eHQ9NDAyMDo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7254fade.54d5.180f61ce0ca.Coremail.lichao@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf9CxP+Yx1IxiMScAAA--.132W
X-CM-SenderInfo: xolfxt3r6o00pqjv00gofq/1tbiAQAQCF3QvPbgHAAAsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgUnVveWFvLAoKSSBnb3QgYSBtZXNzYWdlIGZyb20gSHVhY2FpIHRoYXQgeW91IHdhbnQgdG8g
Z2V0IHRoZSBmaXJtd2FyZSB0aGF0IGNhbiBib290IHRoaXMga2VybmVsLCBzbyB3aGF0IGtpbmQg
b2YgbWFjaGluZSBkbyB5b3UgaGF2ZT8gQ2FuIHlvdSBwcm92aWRlIGluZm9ybWF0aW9uIG9uIFNN
QklPUyB0eXBlMCwgdHlwZTEgYW5kIHR5cGUyIG9mIHRoZSBtYWNoaW5lIGF0IGhhbmQ/IEkgdGhp
bmsgaXQgd291bGQgYmUgYmV0dGVyIGlmIHlvdSBjb3VsZCBwcm92aWQgdGhlIGltYWdlIG9mIG1h
Y2hpbmUgYW5kIG1vdGhlcmJvYXJkLgoKUmVmZXJyaW5nIHRvIEh1YWNhaSwgd2UgYXJlIGdvaW5n
IGNyZWF0ZSBhIHdlYnBhZ2Ugb24gdGhlIEdpdGh1YiB0aGF0IGNhbiBwcm92aWRlIHRoZSBmaXJt
d2FyZSB3aGljaCBjYW4gYm9vdCB0aGUgbmV3IGludGVyZmFjZSBrZXJuZWxzLCB3ZSB3aWxsIHBy
b3ZpZGUgYXMgbWFueSBraW5kcyBvZiBtYWNoaW5lIGZpcm13YXJlIGFzIHBvc3NpYmxlLCBpbmNs
dWRpbmcgcWVtdSBmaXJtd2FyZS4gSSBiZWxldmUgaXQgd2lsbCBzZWUgeW91IHNvb24uIDopCgpU
aGFua3MsCkNoYW8KCiZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7IOWPkeS7tuS6ujog
Ikh1YWNhaSBDaGVuIiA8Y2hlbmh1YWNhaUBnbWFpbC5jb20+CiZndDsg5Y+R6YCB5pe26Ze0OiAy
MDIyLTA1LTI0IDE4OjU5OjUwICjmmJ/mnJ/kuowpCiZndDsg5pS25Lu25Lq6OiAiWGkgUnVveWFv
IiA8eHJ5MTExQHhyeTExMS5zaXRlPiwgbGljaGFvQGxvb25nc29uLmNuCiZndDsg5oqE6YCBOiAi
SHVhY2FpIENoZW4iIDxjaGVuaHVhY2FpQGxvb25nc29uLmNuPiwgIkFybmQgQmVyZ21hbm4iIDxh
cm5kQGFybmRiLmRlPiwgIkFuZHkgTHV0b21pcnNraSIgPGx1dG9Aa2VybmVsLm9yZz4sICJUaG9t
YXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9uaXguZGU+LCAiUGV0ZXIgWmlqbHN0cmEiIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4sICJBbmRyZXcgTW9ydG9uIiA8YWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZz4sICJEYXZpZCBBaXJsaWUiIDxhaXJsaWVkQGxpbnV4LmllPiwgIkpvbmF0aGFuIENvcmJl
dCIgPGNvcmJldEBsd24ubmV0PiwgIkxpbnVzIFRvcnZhbGRzIiA8dG9ydmFsZHNAbGludXgtZm91
bmRhdGlvbi5vcmc+LCBsaW51eC1hcmNoIDxsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZz4sICJv
cGVuIGxpc3Q6RE9DVU1FTlRBVElPTiIgPGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc+LCBMS01M
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgIlh1ZWZlbmcgTGkiIDxsaXh1ZWZlbmdA
bG9vbmdzb24uY24+LCAiWWFudGVuZyBTaSIgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4sICJHdW8g
UmVuIiA8Z3VvcmVuQGtlcm5lbC5vcmc+LCAiWHVlcnVpIFdhbmciIDxrZXJuZWxAeGVuMG4ubmFt
ZT4sICJKaWF4dW4gWWFuZyIgPGppYXh1bi55YW5nQGZseWdvYXQuY29tPiwgIlN0ZXBoZW4gUm90
aHdlbGwiIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4sIGxpbnV4LWVmaSA8bGludXgtZWZpQHZnZXIu
a2VybmVsLm9yZz4sICJBcmQgQmllc2hldXZlbCIgPGFyZGJAa2VybmVsLm9yZz4KJmd0OyDkuLvp
opg6IFJlOiBbUEFUQ0ggVjExIDA5LzIyXSBMb29uZ0FyY2g6IEFkZCBib290IGFuZCBzZXR1cCBy
b3V0aW5lcwomZ3Q7IAomZ3Q7IEhpLCBSdW95YW8sCiZndDsgCiZndDsgT24gVHVlLCBNYXkgMjQs
IDIwMjIgYXQgNDoyNyBQTSBYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4gd3JvdGU6CiZn
dDsgJmd0OwomZ3Q7ICZndDsgT24gV2VkLCAyMDIyLTA1LTE4IGF0IDE3OjI2ICswODAwLCBIdWFj
YWkgQ2hlbiB3cm90ZToKJmd0OyAmZ3Q7ICZndDsgQ3VycmVudGx5IGFuIGV4aXN0aW5nIGludGVy
ZmFjZSBiZXR3ZWVuIHRoZSBrZXJuZWwgYW5kIHRoZSBib290bG9hZGVyCiZndDsgJmd0OyAmZ3Q7
IGlzICBpbXBsZW1lbnRlZC4gS2VybmVsIGdldHMgMiB2YWx1ZXMgZnJvbSB0aGUgYm9vdGxvYWRl
ciwgcGFzc2VkIGluCiZndDsgJmd0OyAmZ3Q7IHJlZ2lzdGVycyBhMCBhbmQgYTE7IGEwIGlzIGFu
ICJFRkkgYm9vdCBmbGFnIiBkaXN0aW5ndWlzaGluZyBVRUZJIGFuZAomZ3Q7ICZndDsgJmd0OyBu
b24tVUVGSSBmaXJtd2FyZSwgd2hpbGUgYTEgaXMgYSBwb2ludGVyIHRvIGFuIEZEVCB3aXRoIHN5
c3RhYmxlLAomZ3Q7ICZndDsgJmd0OyBtZW1tYXAsIGNtZGxpbmUgYW5kIGluaXRyZCBpbmZvcm1h
dGlvbi4KJmd0OyAmZ3Q7CiZndDsgJmd0OyBJZiBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHks
IHdlIGNhbjoKJmd0OyAmZ3Q7CiZndDsgJmd0OyAtIHNldCBhMCB0byAwCiZndDsgJmd0OyAtIHNl
dCBhMSBhIHBvaW50ZXIgKHZpcnR1YWwgYWRkcmVzcyBvciBwaHlzaWNhbCBhZGRyZXNzPykgdG8g
dGhlIEZEVAomZ3Q7ICZndDsgd2l0aCB0aGVzZSBpbmZvcm1hdGlvbgomZ3Q7ICZndDsKJmd0OyAm
Z3Q7IGluIHRoZSBib290bG9hZGVyIGJlZm9yZSBpbnZva2luZyB0aGUga2VybmVsLCB0aGVuIGl0
IHdpbGwgYmUgcG9zc2libGUKJmd0OyAmZ3Q7IHRvIGJvb3QgdGhpcyBrZXJuZWwgdy9vIGZpcm13
YXJlIHVwZGF0ZT8KJmd0OyBVbmZvcnR1bmF0ZWx5LCB0aGVyZSBpcyBubyByZWxlYXNlZCBmaXJt
d2FyZSBmb3IgeW91IHNpbmNlIHdlIHJlY2VudGx5CiZndDsgY2hhbmdlZCB0aGUgaW50ZXJmYWNl
IGFnYWluIGFuZCBhZ2Fpbi4gOigKJmd0OyBZb3UgY2FuIGNvbnRhY3Qgd2l0aCBMaSBDaGFvIChs
aWNoYW9AbG9vbmdzb24uY24pLCBJIHRoaW5rIGhlIGNhbgomZ3Q7IHByb3ZpZGUgaGVscCBhcyBt
dWNoIGFzIHBvc3NpYmxlIChhdCBsZWFzdCBwcm92aWRlIHRlbXBvcmFyeSBmaXJtd2FyZXMKJmd0
OyBmb3IgZGV2ZWxvcGVycykuCiZndDsgV2Ugd2lsbCBhbHNvIHByb3ZpZGUgcWVtdS1zeXN0ZW0g
YW5kIHZpcnR1YWwgbWFjaGluZSdzIGZpcm13YXJlIGFzCiZndDsgc29vbiBhcyBwb3NzaWJsZS4K
Jmd0OyAKJmd0OyBIdWFjYWkKJmd0OyAKJmd0OyAmZ3Q7CiZndDsgJmd0OyBJJ2QgcHJlZmVyIHRv
IHJlY2VpdmUgYSBmaXJtd2FyZSB1cGRhdGUgYW55d2F5LCBidXQgd2UgbmVlZCBhbgomZ3Q7ICZn
dDsgYWx0ZXJuYXRpdmUgaWYgc29tZSB2ZW5kb3IganVzdCBzYXkgIm5vIHdheSwgb3VyIGN1c3Rv
bWl6ZWQgZGlzdHJvIHdvcmtzCiZndDsgJmd0OyBmaW5lIGFuZCB5b3Ugc2hvdWxkIHVzZSBpdCIu
ICAoSSdtIG5vdCBhY2N1c2luZyBMb29uZ0FyY2g6IHN1Y2ggYW5ub3lpbmcKJmd0OyAmZ3Q7IGJl
aGF2aW9yIGlzIGNvbW1vbiBhbW9uZyB2ZW5kb3JzIG9mIGFsbCBhcmNoaXRlY3R1cmVzLCBhbmQg
ZXZlbiB3b3JzZQomZ3Q7ICZndDsgd2l0aCB4ODYgYmVjYXVzZSB0aGV5IG9mdGVuIHNheSAianVz
dCB1c2UgV2luZG9nZSIuKQomZ3Q7ICZndDsgLS0KJmd0OyAmZ3Q7IFhpIFJ1b3lhbyA8eHJ5MTEx
QHhyeTExMS5zaXRlPgomZ3Q7ICZndDsgU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBU
ZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQo8L3hyeTExMUB4cnkxMTEuc2l0ZT48L3hyeTEx
MUB4cnkxMTEuc2l0ZT48L2FyZGJAa2VybmVsLm9yZz48L2xpbnV4LWVmaUB2Z2VyLmtlcm5lbC5v
cmc+PC9zZnJAY2FuYi5hdXVnLm9yZy5hdT48L2ppYXh1bi55YW5nQGZseWdvYXQuY29tPjwva2Vy
bmVsQHhlbjBuLm5hbWU+PC9ndW9yZW5Aa2VybmVsLm9yZz48L3NpeWFudGVuZ0Bsb29uZ3Nvbi5j
bj48L2xpeHVlZmVuZ0Bsb29uZ3Nvbi5jbj48L2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
PC9saW51eC1kb2NAdmdlci5rZXJuZWwub3JnPjwvbGludXgtYXJjaEB2Z2VyLmtlcm5lbC5vcmc+
PC90b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz48L2NvcmJldEBsd24ubmV0PjwvYWlybGll
ZEBsaW51eC5pZT48L2FrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+PC9wZXRlcnpAaW5mcmFkZWFk
Lm9yZz48L3RnbHhAbGludXRyb25peC5kZT48L2x1dG9Aa2VybmVsLm9yZz48L2FybmRAYXJuZGIu
ZGU+PC9jaGVuaHVhY2FpQGxvb25nc29uLmNuPjwveHJ5MTExQHhyeTExMS5zaXRlPjwvY2hlbmh1
YWNhaUBnbWFpbC5jb20+DQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reen
keeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4
reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9
leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmc
suOAgeWkjeWItuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OA
guWmguaenOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumA
muefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiANClRoaXMgZW1haWwgYW5kIGl0cyBh
dHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIExvb25nc29u
IFRlY2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGlt
aXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24gb3IgZGlz
c2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQo
cykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBk
ZWxldGUgaXQuIA==
