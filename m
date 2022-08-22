Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053959C54D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiHVRqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiHVRqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 13:46:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9816E45057
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:46:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w19so22733895ejc.7
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YETYSBdZGbHL0Tg4tG/TWQHUhawdSjZCU30HLw/bqZQ=;
        b=fulab83oMTsxW7dccBev0p+7W/JBtblNus6/b6WUjgoN5VyafMscsPXwGVYeMsounJ
         lEFO63eSxG8frytNPBzG4RgXoD/rrgVP5ESe2yR8VUYSaht5/TKg5qfWl14CgWTAO4iC
         giT/EN094TdnbvBlJOLD83hL2ktihC1451bGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YETYSBdZGbHL0Tg4tG/TWQHUhawdSjZCU30HLw/bqZQ=;
        b=v/bLS7PIheSXBBrAJd6liOBWWmaTVxOmBB7vv1M63WOW1hxqzgAMNIU0M+X0rXcLHo
         4KtyvUsRRn6fZ5c5zG7lSkT+6kufMOWN5CbjV6a9DN3Z1eBbNTMsliD4vENB7z+24b63
         Dz0l8J3MaWJOEHre7j6zhxhG+u0ZwFnI75MmmRt5N6BJvhjPp7C3pnf7dsbDCV47i+NU
         0pCMIP1jvjBd+mvDp5Gpb8JG23W93atMeJVtaHOEov91978w/ZkvEI4lUbE6o2pAGYOI
         mxOAJZnUd+G6z9kj2R+LSPxr+81lS1eTOmCxEjmCMMznRrRcTdIoaeC8EPT/h7JydHYW
         CH/g==
X-Gm-Message-State: ACgBeo340DgA+lgHCADhrA7ybv2SXdqiWW3/OT1kFyE782qMGfS48VaK
        tnzQ9ob91O9g8xum1RV25Aq6zKoN7gSle1WcgZY=
X-Google-Smtp-Source: AA6agR4c6q1IJoDwTsmV8C3Yu9VnpuXlsriPZ+KHl335S+5wupwicOlTJMd7kUXWddSPvJsOVwicEw==
X-Received: by 2002:a17:907:7349:b0:73d:9279:b18b with SMTP id dq9-20020a170907734900b0073d9279b18bmr1091271ejc.140.1661190373751;
        Mon, 22 Aug 2022 10:46:13 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906171500b0072b342ad997sm6452414eje.199.2022.08.22.10.46.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:46:13 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id d16so8855787wrr.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2022 10:46:13 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr11599499wrn.193.1661189974089; Mon, 22
 Aug 2022 10:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 10:39:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
Message-ID: <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004fa1b205e6d7ee0b"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000004fa1b205e6d7ee0b
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 22, 2022 at 10:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So why don't we just create a "test_bit_acquire()" and be done with
> it? We literally created clear_bit_unlock() for the opposite reason,
> and your comments about the new barrier hack even point to it.

Here's a patch that is

 (a) almost entirely untested (I checked that one single case builds
and seems to generate the expected code)

 (b) needs some more loving

but seems to superficially work.

At a minimum this needs to be split into two (so the bitop and the
wait_on_bit parts split up), and that whole placement of
<asm/barrier.h> and generic_bit_test_acquire() need at least some
thinking about, but on the whole it seems reasonable.

For example, it would make more sense to have this in
<asm-generic/bitops/lock.h>, but not all architectures include that,
and some do their own version. I didn't want to mess with
architecture-specific headers, so this illogically just uses
generic-non-atomic.h.

Maybe just put it in <linux/bitops.h> directly?

So I'm not at all claiming that this is a great patch. It definitely
needs more work, and a lot more testing.

But I think this is at least the right _direction_ to take here.

And yes, I think it also would have been better if
"clear_bit_unlock()" would have been called "clear_bit_release()", and
we'd have more consistent naming with our ordered atomics. But it's
probably not worth changing.

               Linus

--0000000000004fa1b205e6d7ee0b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l751lwl30>
X-Attachment-Id: f_l751lwl30

IGluY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2dlbmVyaWMtbm9uLWF0b21pYy5oIHwgOSArKysr
KysrKysKIGluY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL25vbi1hdG9taWMuaCAgICAgICAgIHwg
MSArCiBpbmNsdWRlL2xpbnV4L2JpdG9wcy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIg
Ky0KIGluY2x1ZGUvbGludXgvd2FpdF9iaXQuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgOCAr
KysrLS0tLQoga2VybmVsL3NjaGVkL3dhaXRfYml0LmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAyICstCiA1IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9iaXRvcHMvZ2VuZXJpYy1ub24tYXRv
bWljLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9nZW5lcmljLW5vbi1hdG9taWMuaApp
bmRleCAzZDVlYmQyNDY1MmIuLmY1NmEyNTJkYjllOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20t
Z2VuZXJpYy9iaXRvcHMvZ2VuZXJpYy1ub24tYXRvbWljLmgKKysrIGIvaW5jbHVkZS9hc20tZ2Vu
ZXJpYy9iaXRvcHMvZ2VuZXJpYy1ub24tYXRvbWljLmgKQEAgLTQsNiArNCw3IEBACiAjZGVmaW5l
IF9fQVNNX0dFTkVSSUNfQklUT1BTX0dFTkVSSUNfTk9OX0FUT01JQ19ICiAKICNpbmNsdWRlIDxs
aW51eC9iaXRzLmg+CisjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KIAogI2lmbmRlZiBfTElOVVhf
QklUT1BTX0gKICNlcnJvciBvbmx5IDxsaW51eC9iaXRvcHMuaD4gY2FuIGJlIGluY2x1ZGVkIGRp
cmVjdGx5CkBAIC0xNTgsNCArMTU5LDEyIEBAIGNvbnN0X3Rlc3RfYml0KHVuc2lnbmVkIGxvbmcg
bnIsIGNvbnN0IHZvbGF0aWxlIHVuc2lnbmVkIGxvbmcgKmFkZHIpCiAJcmV0dXJuICEhKHZhbCAm
IG1hc2spOwogfQogCitzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wKK2dlbmVyaWNfdGVzdF9i
aXRfYWNxdWlyZSh1bnNpZ25lZCBsb25nIG5yLCBjb25zdCB2b2xhdGlsZSB1bnNpZ25lZCBsb25n
ICphZGRyKQoreworCXVuc2lnbmVkIGxvbmcgbWFzayA9IEJJVF9NQVNLKG5yKTsKKwl1bnNpZ25l
ZCBsb25nICpwID0gKCh1bnNpZ25lZCBsb25nICopYWRkcikgKyBCSVRfV09SRChucik7CisJcmV0
dXJuIHNtcF9sb2FkX2FjcXVpcmUocCkgJiBtYXNrOworfQorCiAjZW5kaWYgLyogX19BU01fR0VO
RVJJQ19CSVRPUFNfR0VORVJJQ19OT05fQVRPTUlDX0ggKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
YXNtLWdlbmVyaWMvYml0b3BzL25vbi1hdG9taWMuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0
b3BzL25vbi1hdG9taWMuaAppbmRleCA1YzM3Y2VkMzQzYWUuLjcxZjhkNTRhNTE5NSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9iaXRvcHMvbm9uLWF0b21pYy5oCisrKyBiL2luY2x1
ZGUvYXNtLWdlbmVyaWMvYml0b3BzL25vbi1hdG9taWMuaApAQCAtMTMsNiArMTMsNyBAQAogI2Rl
ZmluZSBhcmNoX19fdGVzdF9hbmRfY2hhbmdlX2JpdCBnZW5lcmljX19fdGVzdF9hbmRfY2hhbmdl
X2JpdAogCiAjZGVmaW5lIGFyY2hfdGVzdF9iaXQgZ2VuZXJpY190ZXN0X2JpdAorI2RlZmluZSBh
cmNoX3Rlc3RfYml0X2FjcXVpcmUgZ2VuZXJpY190ZXN0X2JpdF9hY3F1aXJlCiAKICNpbmNsdWRl
IDxhc20tZ2VuZXJpYy9iaXRvcHMvbm9uLWluc3RydW1lbnRlZC1ub24tYXRvbWljLmg+CiAKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYml0b3BzLmggYi9pbmNsdWRlL2xpbnV4L2JpdG9wcy5o
CmluZGV4IGNmOWJmNjUwMzlmMi4uMjJhZGY3NGQ1YzI1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L2JpdG9wcy5oCisrKyBiL2luY2x1ZGUvbGludXgvYml0b3BzLmgKQEAgLTU5LDcgKzU5LDcg
QEAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgX19zd19od2VpZ2h0NjQoX191NjQgdyk7CiAjZGVmaW5l
IF9fdGVzdF9hbmRfY2xlYXJfYml0KG5yLCBhZGRyKQliaXRvcChfX190ZXN0X2FuZF9jbGVhcl9i
aXQsIG5yLCBhZGRyKQogI2RlZmluZSBfX3Rlc3RfYW5kX2NoYW5nZV9iaXQobnIsIGFkZHIpCWJp
dG9wKF9fX3Rlc3RfYW5kX2NoYW5nZV9iaXQsIG5yLCBhZGRyKQogI2RlZmluZSB0ZXN0X2JpdChu
ciwgYWRkcikJCWJpdG9wKF90ZXN0X2JpdCwgbnIsIGFkZHIpCi0KKyNkZWZpbmUgdGVzdF9iaXRf
YWNxdWlyZShuciwgYWRkcikJZ2VuZXJpY190ZXN0X2JpdF9hY3F1aXJlKG5yLCBhZGRyKQogLyoK
ICAqIEluY2x1ZGUgdGhpcyBoZXJlIGJlY2F1c2Ugc29tZSBhcmNoaXRlY3R1cmVzIG5lZWQgZ2Vu
ZXJpY19mZnMvZmxzIGluCiAgKiBzY29wZQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC93YWl0
X2JpdC5oIGIvaW5jbHVkZS9saW51eC93YWl0X2JpdC5oCmluZGV4IDdkZWMzNmFlY2JkOS4uNzcy
NWI3NTc5Yjc4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3dhaXRfYml0LmgKKysrIGIvaW5j
bHVkZS9saW51eC93YWl0X2JpdC5oCkBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50
CiB3YWl0X29uX2JpdCh1bnNpZ25lZCBsb25nICp3b3JkLCBpbnQgYml0LCB1bnNpZ25lZCBtb2Rl
KQogewogCW1pZ2h0X3NsZWVwKCk7Ci0JaWYgKCF0ZXN0X2JpdChiaXQsIHdvcmQpKQorCWlmICgh
dGVzdF9iaXRfYWNxdWlyZShiaXQsIHdvcmQpKQogCQlyZXR1cm4gMDsKIAlyZXR1cm4gb3V0X29m
X2xpbmVfd2FpdF9vbl9iaXQod29yZCwgYml0LAogCQkJCSAgICAgICBiaXRfd2FpdCwKQEAgLTk2
LDcgKzk2LDcgQEAgc3RhdGljIGlubGluZSBpbnQKIHdhaXRfb25fYml0X2lvKHVuc2lnbmVkIGxv
bmcgKndvcmQsIGludCBiaXQsIHVuc2lnbmVkIG1vZGUpCiB7CiAJbWlnaHRfc2xlZXAoKTsKLQlp
ZiAoIXRlc3RfYml0KGJpdCwgd29yZCkpCisJaWYgKCF0ZXN0X2JpdF9hY3F1aXJlKGJpdCwgd29y
ZCkpCiAJCXJldHVybiAwOwogCXJldHVybiBvdXRfb2ZfbGluZV93YWl0X29uX2JpdCh3b3JkLCBi
aXQsCiAJCQkJICAgICAgIGJpdF93YWl0X2lvLApAQCAtMTIzLDcgKzEyMyw3IEBAIHdhaXRfb25f
Yml0X3RpbWVvdXQodW5zaWduZWQgbG9uZyAqd29yZCwgaW50IGJpdCwgdW5zaWduZWQgbW9kZSwK
IAkJICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCkKIHsKIAltaWdodF9zbGVlcCgpOwotCWlmICgh
dGVzdF9iaXQoYml0LCB3b3JkKSkKKwlpZiAoIXRlc3RfYml0X2FjcXVpcmUoYml0LCB3b3JkKSkK
IAkJcmV0dXJuIDA7CiAJcmV0dXJuIG91dF9vZl9saW5lX3dhaXRfb25fYml0X3RpbWVvdXQod29y
ZCwgYml0LAogCQkJCQkgICAgICAgYml0X3dhaXRfdGltZW91dCwKQEAgLTE1MSw3ICsxNTEsNyBA
QCB3YWl0X29uX2JpdF9hY3Rpb24odW5zaWduZWQgbG9uZyAqd29yZCwgaW50IGJpdCwgd2FpdF9i
aXRfYWN0aW9uX2YgKmFjdGlvbiwKIAkJICAgdW5zaWduZWQgbW9kZSkKIHsKIAltaWdodF9zbGVl
cCgpOwotCWlmICghdGVzdF9iaXQoYml0LCB3b3JkKSkKKwlpZiAoIXRlc3RfYml0X2FjcXVpcmUo
Yml0LCB3b3JkKSkKIAkJcmV0dXJuIDA7CiAJcmV0dXJuIG91dF9vZl9saW5lX3dhaXRfb25fYml0
KHdvcmQsIGJpdCwgYWN0aW9uLCBtb2RlKTsKIH0KZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC93
YWl0X2JpdC5jIGIva2VybmVsL3NjaGVkL3dhaXRfYml0LmMKaW5kZXggZDQ3ODhmODEwYjU1Li4w
YjFjZDk4NWRjMjcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC93YWl0X2JpdC5jCisrKyBiL2tl
cm5lbC9zY2hlZC93YWl0X2JpdC5jCkBAIC00Nyw3ICs0Nyw3IEBAIF9fd2FpdF9vbl9iaXQoc3Ry
dWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgc3RydWN0IHdhaXRfYml0X3F1ZXVlX2VudHJ5
ICp3YnFfCiAJCXByZXBhcmVfdG9fd2FpdCh3cV9oZWFkLCAmd2JxX2VudHJ5LT53cV9lbnRyeSwg
bW9kZSk7CiAJCWlmICh0ZXN0X2JpdCh3YnFfZW50cnktPmtleS5iaXRfbnIsIHdicV9lbnRyeS0+
a2V5LmZsYWdzKSkKIAkJCXJldCA9ICgqYWN0aW9uKSgmd2JxX2VudHJ5LT5rZXksIG1vZGUpOwot
CX0gd2hpbGUgKHRlc3RfYml0KHdicV9lbnRyeS0+a2V5LmJpdF9uciwgd2JxX2VudHJ5LT5rZXku
ZmxhZ3MpICYmICFyZXQpOworCX0gd2hpbGUgKHRlc3RfYml0X2FjcXVpcmUod2JxX2VudHJ5LT5r
ZXkuYml0X25yLCB3YnFfZW50cnktPmtleS5mbGFncykgJiYgIXJldCk7CiAKIAlmaW5pc2hfd2Fp
dCh3cV9oZWFkLCAmd2JxX2VudHJ5LT53cV9lbnRyeSk7CiAK
--0000000000004fa1b205e6d7ee0b--
