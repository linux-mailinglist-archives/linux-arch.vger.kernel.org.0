Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF84035EE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347968AbhIHIQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 04:16:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45988 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234696AbhIHIQi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Sep 2021 04:16:38 -0400
Received: from [127.0.0.1] (unknown [125.69.44.212])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cx1OUKcThhJo0BAA--.2138S2;
        Wed, 08 Sep 2021 16:15:10 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Mailer: BlackBerry Email (10.3.3.3216)
Message-ID: <20210908081507.5783639.83425.10074@loongson.cn>
Date:   Wed, 08 Sep 2021 16:15:07 +0800
Subject: Re: [PATCH] MIPS: fix local_t operation on MIPS64
From:   =?utf-8?b?6buE5rKb?= <huangpei@loongson.cn>
In-Reply-To: <alpine.DEB.2.21.2109070317000.38640@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2109061827590.38640@angie.orcam.me.uk>
 <6113C299-3E26-4445-97FD-32690FD91C95@loongson.cn>
 <alpine.DEB.2.21.2109070317000.38640@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-CM-TRANSID: AQAAf9Cx1OUKcThhJo0BAA--.2138S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4kAFWDKrWxur15ZrW5KFg_yoW8tw43pr
        ZFvrZxXaykCr18Aw48uay8uryYqw1DJF47t3Z8Gw1rGFs5uryjva1jqw1S9r1agrsFka48
        AF9I9r9rurZ7ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFcxC0VAYjxAxZF0E
        w4CEw7xC0wACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7VUjdMaUUU
        UUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhhbmsgeW91LCBJIGdvdCBpdC4KCgoK5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv
5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw
5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul
5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw
5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h
5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu
5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CCwqAKCgpUaGlzwqBlbWFpbMKg
YW5kwqBpdHPCoGF0dGFjaG1lbnRzwqBjb250YWluwqBjb25maWRlbnRpYWwgaW5mb3JtYXRpb27C
oGZyb23CoExvb25nc29uwqBUZWNobm9sb2d5wqAswqB3aGljaMKgaXPCoGludGVuZGVkIG9ubHnC
oGZvcsKgdGhlwqBwZXJzb27CoG9ywqBlbnRpdHnCoHdob3NlwqBhZGRyZXNzwqBpc8KgbGlzdGVk
wqBhYm92ZS7CoEFueSB1c2XCoG9mwqB0aGXCoGluZm9ybWF0aW9uwqBjb250YWluZWTCoGhlcmVp
bsKgaW7CoGFuecKgd2F5wqAoaW5jbHVkaW5nLCBidXTCoG5vdMKgbGltaXRlZMKgdG8swqB0b3Rh
bMKgb3LCoHBhcnRpYWzCoGRpc2Nsb3N1cmUswqByZXByb2R1Y3Rpb27CoG9yIGRpc3NlbWluYXRp
b24pwqBiecKgcGVyc29uc8Kgb3RoZXLCoHRoYW7CoHRoZcKgaW50ZW5kZWTCoHJlY2lwaWVudChz
KSBpc8KgcHJvaGliaXRlZC7CoElmwqB5b3XCoHJlY2VpdmXCoHRoaXPCoGVtYWlswqBpbsKgZXJy
b3IswqBwbGVhc2XCoG5vdGlmecKgdGhlIHNlbmRlcsKgYnnCoHBob25lwqBvcsKgZW1haWzCoGlt
bWVkaWF0ZWx5wqBhbmTCoGRlbGV0ZcKgaXQuwqAKwqAgT3JpZ2luYWwgTWVzc2FnZSDCoApGcm9t
OiBNYWNpZWogVy4gUm96eWNraQpTZW50OiAyMDIx5bm0OeaciDfml6XmmJ/mnJ/kuowgMTg6MDAK
VG86IGxvb25nc29uCkNjOiBUaG9tYXMgQm9nZW5kb2VyZmVyOyBhbWJyb3NlaHVhQGdtYWlsLmNv
bTsgQmlibyBNYW87IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcmNoQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBKaWF4dW4gWWFuZzsgUGF1bCBCdXJ0b247
IExpIFh1ZWZlbmc7IFlhbmcgVGllemh1OyBHYW8gSnV4aW47IEh1YWNhaSBDaGVuOyBKaW55YW5n
IEhlOyBTdGV2ZW4gUm9zdGVkdDsgSmlzaGVuZyBaaGFuZzsgTWFzYW1pIEhpcmFtYXRzdQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBNSVBTOiBmaXggbG9jYWxfdCBvcGVyYXRpb24gb24gTUlQUzY0CgpP
biBUdWUsIDcgU2VwIDIwMjEsIGxvb25nc29uIHdyb3RlOgoKPiBQbGVhc2Ugc2hvdyBtZSB5b3Vy
IGNvZGUKClNlZSBjb21taXQgZTQ5NjQ1M2QzZTE1LiBZb3UgbWF5IGdldCBpbnNwaXJhdGlvbiBm
cm9tIDxhc20vc3RhY2t0cmFjZS5oPiAKdG9vLgoKPiBUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNo
bWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSAKPiBMb29uZ3NvbiBU
ZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRp
dHkgCj4gd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCAKPiBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90
IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgCj4gZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9u
IG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgCj4gaW50ZW5kZWQg
cmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4g
ZXJyb3IsIAo+IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1l
ZGlhdGVseSBhbmQgZGVsZXRlIGl0LgoKWW91ciBtZXNzYWdlIGhhcyBoaXQgcHVibGljIG1haWxp
bmcgbGlzdCBhcmNoaXZlcyBhbHJlYWR5IEknbSBhZnJhaWQuCgpNYWNpZWoK

