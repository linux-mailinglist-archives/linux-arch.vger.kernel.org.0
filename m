Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9ED644C52
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 20:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLFTPc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLFTPa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 14:15:30 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584F4093F
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 11:15:29 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id r15so11109785qvm.6
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 11:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vnGWoKHFGdZxHMe2dZN8RBXvrycHdsx4LKGoPPTB4Iw=;
        b=hklI08rfbO3som41CfZAYKfsT3DKY7Ra5mQdalinR/hIgnXgZ7M2uQuZomwbBxuoSO
         9kwfm/ODxhwIInV5EzbWrr91LoRHJlHyF7vuQRiY5BYryFnMKGCw56Eh1c84zYS3TDZE
         oqLibvXUF0gudWLjrQLb0v7l8OWmqTYXIDWUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnGWoKHFGdZxHMe2dZN8RBXvrycHdsx4LKGoPPTB4Iw=;
        b=IGwaGCGIK8lhVRUL/sVNNH9acZ62vAB+a0z0hKTR4543mwgRk6SowXN9/r+uKX2p+e
         RYLFbtKu0ZJPFQvHLplMdAdS62lXR6l4eWufZXm+yXtiyKkj9Otmbfk+My6Thy7Uu+3N
         +IpWLqTeU7Cp9HDfRp8Ag/TztVlc8NCA3jGv37gagKW55U1uzoGA6DHg0MhbEQe4ZwfY
         ve9zgUU2PpJuvwlDKEmxh8tEAZrVJx9EifrJ8Q5En7i9kNy0wDYmqpW23BUzWRwhqv6p
         il5nvGA0oOC9DKXgcsYwlL6Oup1UoLB20dSh2ENe7pjQKC5tCEgNduePxkhm5xhNGuIu
         YvFw==
X-Gm-Message-State: ANoB5pkotFLAOjmznEFtBUt8uDfnpAl6C6DSnY4eMWqVmSXF5eXnnONy
        IaO+DVq57qaZH/nAZ9PBFUrLXfgzcFz2quVA
X-Google-Smtp-Source: AA0mqf4G614EMcUgQLH+KepnRYgXQtmzeP3A/N471Md1EzGJzm4vD9gryu/7Qbvc6yzSCW5BbcRboA==
X-Received: by 2002:a05:6214:440a:b0:4c7:1b68:66c2 with SMTP id oj10-20020a056214440a00b004c71b6866c2mr28641555qvb.46.1670354127774;
        Tue, 06 Dec 2022 11:15:27 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a6ebde4799sm14823292qkp.90.2022.12.06.11.15.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 11:15:26 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id j13so6764347qka.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 11:15:25 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr78661848qkd.697.1670354125497; Tue, 06
 Dec 2022 11:15:25 -0800 (PST)
MIME-Version: 1.0
References: <202212051534.852804af-yujie.liu@intel.com> <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
 <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
In-Reply-To: <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Dec 2022 11:15:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com>
Message-ID: <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 5df397dec7: will-it-scale.per_thread_ops
 -53.3% regression
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="0000000000004cfd6505ef2da0b7"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000004cfd6505ef2da0b7
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 10:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about this a while, but I think I'll have a patch for you
> to test once I've dealt with a couple more pull requests.

So here's a trial balloon for you to try if you can see if this mostly
fixes the regression..

It still limits batching (because unlike the full "gather pages until
you have to flush", this is all batched under the page table lock. But
it limits it a bit less, in that it will use a second active batch if
it only used the initial on-stack one (which is called "local", which
is not a great name in this context, but whatever).

This _should_ mean that that benchmark will now batch ~512 pages
instead of just 8.

Which should be pretty much what it effectively used to do before too,
because the dirty shared page case has always caused that
"force_flush" thing, so it will have always stopped to flush every
page directory.

(But we still have that extra rmap flushing limit because there could
have been _previous_ buffered page pointers that weren't dirty shared
pages, and we don't want to have to deal with that pain, and might
have to exit early in order to avoid it)

I can imagine cleaner ways to do this, but they would involve having
to remember which batch we started having dirty pages in, which is
more bookkeeping pain than I really think it's worth.

Does this fix the regression?

             Linus

--0000000000004cfd6505ef2da0b7
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lbclpeas0>
X-Attachment-Id: f_lbclpeas0

IG1tL21tdV9nYXRoZXIuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL21tL21tdV9nYXRoZXIuYyBiL21tL21tdV9nYXRoZXIuYwppbmRleCA4MjQ3NTUz
YTY5YzIuLjJiOTNjZjZhYzlhZSAxMDA2NDQKLS0tIGEvbW0vbW11X2dhdGhlci5jCisrKyBiL21t
L21tdV9nYXRoZXIuYwpAQCAtMTksOCArMTksOCBAQCBzdGF0aWMgYm9vbCB0bGJfbmV4dF9iYXRj
aChzdHJ1Y3QgbW11X2dhdGhlciAqdGxiKQogewogCXN0cnVjdCBtbXVfZ2F0aGVyX2JhdGNoICpi
YXRjaDsKIAotCS8qIE5vIG1vcmUgYmF0Y2hpbmcgaWYgd2UgaGF2ZSBkZWxheWVkIHJtYXBzIHBl
bmRpbmcgKi8KLQlpZiAodGxiLT5kZWxheWVkX3JtYXApCisJLyogTGltaXQgYmF0Y2hpbmcgaWYg
d2UgaGF2ZSBkZWxheWVkIHJtYXBzIHBlbmRpbmcgKi8KKwlpZiAodGxiLT5kZWxheWVkX3JtYXAg
JiYgdGxiLT5hY3RpdmUgIT0gJnRsYi0+bG9jYWwpCiAJCXJldHVybiBmYWxzZTsKIAogCWJhdGNo
ID0gdGxiLT5hY3RpdmU7CkBAIC00OCwzMSArNDgsMzUgQEAgc3RhdGljIGJvb2wgdGxiX25leHRf
YmF0Y2goc3RydWN0IG1tdV9nYXRoZXIgKnRsYikKIH0KIAogI2lmZGVmIENPTkZJR19TTVAKK3N0
YXRpYyB2b2lkIHRsYl9mbHVzaF9ybWFwX2JhdGNoKHN0cnVjdCBtbXVfZ2F0aGVyX2JhdGNoICpi
YXRjaCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCit7CisJZm9yIChpbnQgaSA9IDA7IGkg
PCBiYXRjaC0+bnI7IGkrKykgeworCQlzdHJ1Y3QgZW5jb2RlZF9wYWdlICplbmMgPSBiYXRjaC0+
ZW5jb2RlZF9wYWdlc1tpXTsKKworCQlpZiAoZW5jb2RlZF9wYWdlX2ZsYWdzKGVuYykpIHsKKwkJ
CXN0cnVjdCBwYWdlICpwYWdlID0gZW5jb2RlZF9wYWdlX3B0cihlbmMpOworCQkJcGFnZV9yZW1v
dmVfcm1hcChwYWdlLCB2bWEsIGZhbHNlKTsKKwkJfQorCX0KK30KKwogLyoqCiAgKiB0bGJfZmx1
c2hfcm1hcHMgLSBkbyBwZW5kaW5nIHJtYXAgcmVtb3ZhbHMgYWZ0ZXIgd2UgaGF2ZSBmbHVzaGVk
IHRoZSBUTEIKICAqIEB0bGI6IHRoZSBjdXJyZW50IG1tdV9nYXRoZXIKICAqCiAgKiBOb3RlIHRo
YXQgYmVjYXVzZSBvZiBob3cgdGxiX25leHRfYmF0Y2goKSBhYm92ZSB3b3Jrcywgd2Ugd2lsbAot
ICogbmV2ZXIgc3RhcnQgbmV3IGJhdGNoZXMgd2l0aCBwZW5kaW5nIGRlbGF5ZWQgcm1hcHMsIHNv
IHdlIG9ubHkKLSAqIG5lZWQgdG8gd2FsayB0aHJvdWdoIHRoZSBjdXJyZW50IGFjdGl2ZSBiYXRj
aC4KKyAqIG5ldmVyIHN0YXJ0IG11bHRpcGxlIG5ldyBiYXRjaGVzIHdpdGggcGVuZGluZyBkZWxh
eWVkIHJtYXBzLCBzbworICogd2Ugb25seSBuZWVkIHRvIHdhbGsgdGhyb3VnaCB0aGUgY3VycmVu
dCBhY3RpdmUgYmF0Y2ggYW5kIHRoZQorICogb3JpZ2luYWwgbG9jYWwgb25lLgogICovCiB2b2lk
IHRsYl9mbHVzaF9ybWFwcyhzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSkKIHsKLQlzdHJ1Y3QgbW11X2dhdGhlcl9iYXRjaCAqYmF0Y2g7Ci0KIAlpZiAo
IXRsYi0+ZGVsYXllZF9ybWFwKQogCQlyZXR1cm47CiAKLQliYXRjaCA9IHRsYi0+YWN0aXZlOwot
CWZvciAoaW50IGkgPSAwOyBpIDwgYmF0Y2gtPm5yOyBpKyspIHsKLQkJc3RydWN0IGVuY29kZWRf
cGFnZSAqZW5jID0gYmF0Y2gtPmVuY29kZWRfcGFnZXNbaV07Ci0KLQkJaWYgKGVuY29kZWRfcGFn
ZV9mbGFncyhlbmMpKSB7Ci0JCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IGVuY29kZWRfcGFnZV9wdHIo
ZW5jKTsKLQkJCXBhZ2VfcmVtb3ZlX3JtYXAocGFnZSwgdm1hLCBmYWxzZSk7Ci0JCX0KLQl9Ci0K
Kwl0bGJfZmx1c2hfcm1hcF9iYXRjaCgmdGxiLT5sb2NhbCwgdm1hKTsKKwlpZiAodGxiLT5hY3Rp
dmUgIT0gJnRsYi0+bG9jYWwpCisJCXRsYl9mbHVzaF9ybWFwX2JhdGNoKHRsYi0+YWN0aXZlLCB2
bWEpOwogCXRsYi0+ZGVsYXllZF9ybWFwID0gMDsKIH0KICNlbmRpZgo=
--0000000000004cfd6505ef2da0b7--
