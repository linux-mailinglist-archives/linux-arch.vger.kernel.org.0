Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AED646245
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 21:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLGUSO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 15:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiLGUSM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 15:18:12 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C17B4DD
        for <linux-arch@vger.kernel.org>; Wed,  7 Dec 2022 12:18:11 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d13so13459212qvj.8
        for <linux-arch@vger.kernel.org>; Wed, 07 Dec 2022 12:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R6C5DcFpFc2RC/VN4Pp8i/xOJBHO01e8lvht5r7K61c=;
        b=FVHzc1Nzcubhpitnmdjp31Lnub/ZhDvqu9e/uatKzf2uR4QTQImhxX19EuI9u12moV
         SnND9+i/xO3Qs9svwwOYGev/SiK9WlLtlv/fDmvMgO/bb4HlkDg395wk4qtdCI8kt3No
         9SaHu15MEcqNpryN1CLzU0EmFES2C5ah8pCWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6C5DcFpFc2RC/VN4Pp8i/xOJBHO01e8lvht5r7K61c=;
        b=VCmcD7WG5POpt/ganr4v3HUeX+I4UtsRB2mhEmutyz/CIONTNLO4PNl4w/d46RlPUc
         md7v/XlzWPA6VjBjSxP8AwyPLNzhimAw8AxZfpH2NWK986k25jhk5wpse6r0ksaeZO4b
         1+hCqZOgZcle/y+k8elbjca/Ul7wfLJJ3AtAnLC7pjkfj9MmVR8ftwF6NB2ECwIj+Xrh
         ioDCXHVfTZyOcWtgD8GR9KYxSZqemp+42wStJ/6iej3tx0AI9q8s+9DXWqgGxBlacfFg
         ZSwN0AwmheJoRNIWiQ0cbgm5lBZF7l0xVEZOvZbMJJNx66dzWKqocO6VNeZmo8sVyL0q
         oGog==
X-Gm-Message-State: ANoB5pntho3bVvBbXABOs8ouGNLhe/OhGE+XNpSn5KzZupEj29gaAY5j
        r9n8lbptdrmbVTzHjqp2lQUBjhqxBTw8vnwc
X-Google-Smtp-Source: AA0mqf4wr5olPYnb3t+PBWGLxofBzNeoz0ipJfO1mxkdI9oAutQ6JrgNICq9eK+O9gFat5Fs8NckDg==
X-Received: by 2002:a05:6214:3513:b0:4c7:8c96:f474 with SMTP id nk19-20020a056214351300b004c78c96f474mr4758393qvb.131.1670444290305;
        Wed, 07 Dec 2022 12:18:10 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b006fa16fe93bbsm17523580qkb.15.2022.12.07.12.18.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 12:18:06 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id fu10so8644694qtb.0
        for <linux-arch@vger.kernel.org>; Wed, 07 Dec 2022 12:18:04 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr15651002qtq.180.1670444283686; Wed, 07
 Dec 2022 12:18:03 -0800 (PST)
MIME-Version: 1.0
References: <202212051534.852804af-yujie.liu@intel.com> <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
 <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
 <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com> <878rjj22mz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878rjj22mz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Dec 2022 12:17:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkL5aM1fR7kYUmhHQHBcMUc-bDoFP7EwYjTxy64DGtvw@mail.gmail.com>
Message-ID: <CAHk-=whkL5aM1fR7kYUmhHQHBcMUc-bDoFP7EwYjTxy64DGtvw@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 5df397dec7: will-it-scale.per_thread_ops
 -53.3% regression
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="00000000000025d1ff05ef429ef6"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--00000000000025d1ff05ef429ef6
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 9:41 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> I have tested the patch, it does fix the regression

Thanks.

Andrew, here's the patch with a proper commit message. Note that my
commit message contains the SHA1 of the original patch both in the
explanation and in a "Fixes:" line, which I think is fine for the
"mm-stable" branch that the original patch is in.

But if you end up rebasing that mm-stable branch, then I'd ask you to
either remove/update those commit hashes, or just fold this fix into
the original one. Ok?

             Linus

--00000000000025d1ff05ef429ef6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-mmu_gather-allow-more-than-one-batch-of-delayed-r.patch"
Content-Disposition: attachment; 
	filename="0001-mm-mmu_gather-allow-more-than-one-batch-of-delayed-r.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lbe3dmb70>
X-Attachment-Id: f_lbe3dmb70

RnJvbSBkNjYwNWUyN2M5ZDlmZDU3ZjY3NzJkZTEyZjU0MDY1NTlmY2VkNmI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgNiBEZWMgMjAyMiAxMToxNTowOSAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tOiBtbXVfZ2F0aGVyOiBhbGxvdyBtb3JlIHRoYW4gb25lIGJhdGNoIG9mIGRlbGF5
ZWQgcm1hcHMKCkNvbW1pdCA1ZGYzOTdkZWM3YzQgKCJtbTogZGVsYXkgcGFnZV9yZW1vdmVfcm1h
cCgpIHVudGlsIGFmdGVyIHRoZSBUTEIKaGFzIGJlZW4gZmx1c2hlZCIpIGxpbWl0ZWQgdGhlIHBh
Z2UgYmF0Y2hpbmcgZm9yIHRoZSBtbXUgZ2F0aGVyCm9wZXJhdGlvbiB3aGVuIGEgZGlydHkgc2hh
cmVkIHBhZ2UgbmVlZGVkIHRvIGRlbGF5IHJtYXAgcmVtb3ZhbCB1bnRpbAphZnRlciB0aGUgVExC
IGhhZCBiZWVuIGZsdXNoZWQuCgpJdCBkaWQgc28gYmVjYXVzZSBpdCBuZWVkcyB0byB3YWxrIHRo
YXQgYXJyYXkgb2YgcGFnZXMgd2hpbGUgc3RpbGwKaG9sZGluZyB0aGUgcGFnZSB0YWJsZSBsb2Nr
LCBhbmQgb3VyIG1tdV9nYXRoZXIgaW5mcmFzdHJ1Y3R1cmUgYWxsb3dzCmZvciBiYXRjaGluZyBx
dWl0ZSBhIGxvdCBvZiBwYWdlcy4gIFdlIG1heSBoYXZlIHRob3VzYW5kcyBvbiBwYWdlcwpxdWV1
ZWQgdXAgZm9yIGZyZWVpbmcsIGFuZCB3ZSB3YW50ZWQgdG8gd2FsayBvbmx5IHRoZSBsYXN0IGJh
dGNoIGlmIHdlCnRoZW4gYWRkZWQgYSBkaXJ0eSBwYWdlIHRvIHRoZSBxdWV1ZS4KCkhvd2V2ZXIs
IHdoZW4gSSBsaW1pdGVkIGl0IHRvIG9uZSBiYXRjaCwgSSBkaWRuJ3QgdGhpbmsgb2YgdGhlCmRl
Z2VuZXJhdGUgY2FzZSBvZiB0aGUgc3BlY2lhbCBmaXJzdCBiYXRjaCB0aGF0IGlzIGVtYmVkZGVk
IG9uLXN0YWNrIGluCnRoZSBtbXVfZ2F0aGVyIHN0cnVjdHVyZSAoY2FsbGVkICJsb2NhbCIpIGFu
ZCB0aGF0IG9ubHkgaGFzIGVpZ2h0CmVudHJpZXMuCgpTbyB3aXRoIHRoZSByaWdodCBwYXR0ZXJu
LCB0aGF0ICJsaW1pdCBkZWxheWVkIHJtYXAgdG8ganVzdCBvbmUgYmF0Y2giCndpbGwgdHJpZ2dl
ciBvdmVyIGFuZCBvdmVyIGluIHRoYXQgZmlyc3Qgc21hbGwgYmF0Y2gsIGFuZCB3ZSdsbCB3YXN0
ZSBhCmxvdCBvZiB0aW1lIGZsdXNoaW5nIFRMQidzIGV2ZXJ5IGVpZ2h0IHBhZ2VzLgoKQW5kIHRo
b3NlIHJpZ2h0IHBhdHRlcm5zIGFyZSB0cml2aWFsbHkgdHJpZ2dlcmVkIGJ5IGp1c3QgaGF2aW5n
IGEgc2hhcmVkCm1hcHBpbmdzIHdpdGggbG90cyBvZiBhZGphY2VudCBkaXJ0eSBwYWdlcy4gIExp
a2UgdGhlICdwYWdlX2ZhdWx0MycKc3VidGVzdCBvZiB0aGUgJ3dpbGwtaXQtc2NhbGUnIGJlbmNo
bWFyaywgdGhhdCBqdXN0IG1hcHMgYSBzaGFyZWQgYXJlYSwKZGlydGllcyBhbGwgcGFnZXMsIGFu
ZCB1bm1hcHMgaXQuICBSaW5zZSBhbmQgcmVwZWF0LgoKV2Ugc3RpbGwgd2FudCB0byBsaW1pdCB0
aGUgYmF0Y2hpbmcsIGJ1dCB0byBmaXggdGhpcyAoZWFzaWx5IHRyaWdnZXJlZCkKZGVnZW5lcmF0
ZSBjYXNlLCBqdXN0IGV4cGFuZCB0aGUgIm9ubHkgb25lIGJhdGNoIiBsb2dpYyB0byBpbnN0ZWFk
IGJlCiJvbmx5IG9uZSBiYXRjaCB0aGF0IGlzbid0IHRoZSBzcGVjaWFsIGZpcnN0IG9uLXN0YWNr
ICgnbG9jYWwnKSBiYXRjaCIuCgpUaGF0IHdheSwgd2hlbiB3ZSBuZWVkIHRvIGZsdXNoIHRoZSBk
ZWxheWVkIHJtYXBzLCB3ZSBjYW4gc3RpbGwgbGltaXQKb3VyIHdhbGsgdG8ganVzdCB0aGUgbGFz
dCBiYXRjaCAtIGFuZCB0aGF0IGZpcnN0IHNtYWxsIG9uZS4KCkZpeGVzOiA1ZGYzOTdkZWM3YzQg
KCJtbTogZGVsYXkgcGFnZV9yZW1vdmVfcm1hcCgpIHVudGlsIGFmdGVyIHRoZSBUTEIgaGFzIGJl
ZW4gZmx1c2hlZCIpClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8eXVqaWUubGl1QGlu
dGVsLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjIxMjA1MTUz
NC44NTI4MDRhZi15dWppZS5saXVAaW50ZWwuY29tClRlc3RlZC1ieTogSHVhbmcsIFlpbmcgPHlp
bmcuaHVhbmdAaW50ZWwuY29tPgpUZXN0ZWQtYnk6IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xl
LmNvbT4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5k
YXRpb24ub3JnPgotLS0KIG1tL21tdV9nYXRoZXIuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21tdV9nYXRoZXIuYyBiL21tL21tdV9nYXRoZXIu
YwppbmRleCA4MjQ3NTUzYTY5YzIuLjJiOTNjZjZhYzlhZSAxMDA2NDQKLS0tIGEvbW0vbW11X2dh
dGhlci5jCisrKyBiL21tL21tdV9nYXRoZXIuYwpAQCAtMTksOCArMTksOCBAQCBzdGF0aWMgYm9v
bCB0bGJfbmV4dF9iYXRjaChzdHJ1Y3QgbW11X2dhdGhlciAqdGxiKQogewogCXN0cnVjdCBtbXVf
Z2F0aGVyX2JhdGNoICpiYXRjaDsKIAotCS8qIE5vIG1vcmUgYmF0Y2hpbmcgaWYgd2UgaGF2ZSBk
ZWxheWVkIHJtYXBzIHBlbmRpbmcgKi8KLQlpZiAodGxiLT5kZWxheWVkX3JtYXApCisJLyogTGlt
aXQgYmF0Y2hpbmcgaWYgd2UgaGF2ZSBkZWxheWVkIHJtYXBzIHBlbmRpbmcgKi8KKwlpZiAodGxi
LT5kZWxheWVkX3JtYXAgJiYgdGxiLT5hY3RpdmUgIT0gJnRsYi0+bG9jYWwpCiAJCXJldHVybiBm
YWxzZTsKIAogCWJhdGNoID0gdGxiLT5hY3RpdmU7CkBAIC00OCwzMSArNDgsMzUgQEAgc3RhdGlj
IGJvb2wgdGxiX25leHRfYmF0Y2goc3RydWN0IG1tdV9nYXRoZXIgKnRsYikKIH0KIAogI2lmZGVm
IENPTkZJR19TTVAKK3N0YXRpYyB2b2lkIHRsYl9mbHVzaF9ybWFwX2JhdGNoKHN0cnVjdCBtbXVf
Z2F0aGVyX2JhdGNoICpiYXRjaCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCit7CisJZm9y
IChpbnQgaSA9IDA7IGkgPCBiYXRjaC0+bnI7IGkrKykgeworCQlzdHJ1Y3QgZW5jb2RlZF9wYWdl
ICplbmMgPSBiYXRjaC0+ZW5jb2RlZF9wYWdlc1tpXTsKKworCQlpZiAoZW5jb2RlZF9wYWdlX2Zs
YWdzKGVuYykpIHsKKwkJCXN0cnVjdCBwYWdlICpwYWdlID0gZW5jb2RlZF9wYWdlX3B0cihlbmMp
OworCQkJcGFnZV9yZW1vdmVfcm1hcChwYWdlLCB2bWEsIGZhbHNlKTsKKwkJfQorCX0KK30KKwog
LyoqCiAgKiB0bGJfZmx1c2hfcm1hcHMgLSBkbyBwZW5kaW5nIHJtYXAgcmVtb3ZhbHMgYWZ0ZXIg
d2UgaGF2ZSBmbHVzaGVkIHRoZSBUTEIKICAqIEB0bGI6IHRoZSBjdXJyZW50IG1tdV9nYXRoZXIK
ICAqCiAgKiBOb3RlIHRoYXQgYmVjYXVzZSBvZiBob3cgdGxiX25leHRfYmF0Y2goKSBhYm92ZSB3
b3Jrcywgd2Ugd2lsbAotICogbmV2ZXIgc3RhcnQgbmV3IGJhdGNoZXMgd2l0aCBwZW5kaW5nIGRl
bGF5ZWQgcm1hcHMsIHNvIHdlIG9ubHkKLSAqIG5lZWQgdG8gd2FsayB0aHJvdWdoIHRoZSBjdXJy
ZW50IGFjdGl2ZSBiYXRjaC4KKyAqIG5ldmVyIHN0YXJ0IG11bHRpcGxlIG5ldyBiYXRjaGVzIHdp
dGggcGVuZGluZyBkZWxheWVkIHJtYXBzLCBzbworICogd2Ugb25seSBuZWVkIHRvIHdhbGsgdGhy
b3VnaCB0aGUgY3VycmVudCBhY3RpdmUgYmF0Y2ggYW5kIHRoZQorICogb3JpZ2luYWwgbG9jYWwg
b25lLgogICovCiB2b2lkIHRsYl9mbHVzaF9ybWFwcyhzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIHsKLQlzdHJ1Y3QgbW11X2dhdGhlcl9iYXRjaCAq
YmF0Y2g7Ci0KIAlpZiAoIXRsYi0+ZGVsYXllZF9ybWFwKQogCQlyZXR1cm47CiAKLQliYXRjaCA9
IHRsYi0+YWN0aXZlOwotCWZvciAoaW50IGkgPSAwOyBpIDwgYmF0Y2gtPm5yOyBpKyspIHsKLQkJ
c3RydWN0IGVuY29kZWRfcGFnZSAqZW5jID0gYmF0Y2gtPmVuY29kZWRfcGFnZXNbaV07Ci0KLQkJ
aWYgKGVuY29kZWRfcGFnZV9mbGFncyhlbmMpKSB7Ci0JCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IGVu
Y29kZWRfcGFnZV9wdHIoZW5jKTsKLQkJCXBhZ2VfcmVtb3ZlX3JtYXAocGFnZSwgdm1hLCBmYWxz
ZSk7Ci0JCX0KLQl9Ci0KKwl0bGJfZmx1c2hfcm1hcF9iYXRjaCgmdGxiLT5sb2NhbCwgdm1hKTsK
KwlpZiAodGxiLT5hY3RpdmUgIT0gJnRsYi0+bG9jYWwpCisJCXRsYl9mbHVzaF9ybWFwX2JhdGNo
KHRsYi0+YWN0aXZlLCB2bWEpOwogCXRsYi0+ZGVsYXllZF9ybWFwID0gMDsKIH0KICNlbmRpZgot
LSAKMi4zOC4xLjI4NC5nZmQ5NDY4ZDc4NwoK
--00000000000025d1ff05ef429ef6--
