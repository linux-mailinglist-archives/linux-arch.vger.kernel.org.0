Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0212790E13
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjICVF7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjICVF6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 17:05:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE29103
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 14:05:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50078e52537so1384721e87.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693775153; x=1694379953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EHR5mCR9mOyqzmNVz+ud7DpNJ1Cvz9ROqmt0ghyIa7U=;
        b=A7ldmkKCbr1ArTCw/QInAQN0g9ezmKQnUhl7fzlXm6oyIqD/kxQ9iLPb6YG4Zvs20q
         JC6/a2AmeLnhsRqABlBJlH3Hssy2jT7ks9xhFVvSe9dKSV/t7GyQ4IZ+yi5bY3wmC8iN
         /7pkYlZtTYK/rroKZSdsrNJXluRiisVlGD7K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693775153; x=1694379953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHR5mCR9mOyqzmNVz+ud7DpNJ1Cvz9ROqmt0ghyIa7U=;
        b=Ftyp5M+D2RrFbjCICQjDzurNOLElGmKQncjtVRBM9o9k/3rzFPgxX97+SkAuwShslN
         aHAEo0cq0tuT8Z7ojmPGIXiCkz44HxkuJvabvrs6AP4U7Jk/atrqbNwLZn7IwK5nc9pU
         Tao6AHnyFbZo3xwDaEcTedRefyf+AQMq0HUmmGzTmoRn6br6esj1jnOaPXCYk/2ZGi9a
         2OBYhYBmPWg5QMQJGUK7Ssb+RsFkGYZSZL6wtdUss0cvObqg8uE4tLslN9oW8tXJ9+HZ
         bIfcmMhj80wj0G0xaNPJrlVF+LqXpo68QeMR2h42DOwE4nIFFAeU/JXF/Qpzvc5rW94r
         u8cQ==
X-Gm-Message-State: AOJu0YxFLngBpOUVb9St0AYNz+4QW+mwGjPchQcK1/cvS+QVpTRKtF8f
        VOpaP9+caGRfHpbn382EOgKrAyzFkq9/2TtVMFUhvbDb
X-Google-Smtp-Source: AGHT+IEaG6UJimna9kUh9/5agl95jxp8aTAcz8wQ96fjkdIHpaHudKiG9Mp1AVTkNwDaU20H2xr5Xg==
X-Received: by 2002:a05:6512:443:b0:4fb:772a:af12 with SMTP id y3-20020a056512044300b004fb772aaf12mr4487901lfk.21.1693775153284;
        Sun, 03 Sep 2023 14:05:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g9-20020a19ac09000000b0050083e47b9bsm1398907lfc.103.2023.09.03.14.05.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 14:05:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500cefc3644so1382371e87.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 14:05:51 -0700 (PDT)
X-Received: by 2002:a05:6512:3d9e:b0:500:c128:66d4 with SMTP id
 k30-20020a0565123d9e00b00500c12866d4mr6837740lfv.67.1693775151524; Sun, 03
 Sep 2023 14:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com> <20230903204858.lv7i3kqvw6eamhgz@f>
In-Reply-To: <20230903204858.lv7i3kqvw6eamhgz@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 14:05:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
Message-ID: <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: multipart/mixed; boundary="0000000000003d367906047ac2bc"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000003d367906047ac2bc
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Sept 2023 at 13:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> "real fstat" is syscall(5, fd, &sb).
>
> Sapphire Rapids, will-it-scale, ops/s
>
> stock fstat     5088199
> patched fstat   7625244 (+49%)
> real fstat      8540383 (+67% / +12%)
>
> It dodges lockref et al, but it does not dodge SMAP which accounts for
> the difference.

Side note, since I was looking at this, I hacked up a quick way for
architectures to do their own optimized cp_new_stat() that avoids the
double-buffering.

Sadly it *is* architecture-specific due to padding and
architecture-specific field sizes (and thus EOVERFLOW rules), but it
is what it is.

I don't know how much it matters, but it might make a difference. And
'stat()' is most certainly worth optimizing for, even if glibc has
made our life more difficult.

Want to try out another entirely untested patch? Attached.

                Linus

--0000000000003d367906047ac2bc
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lm3xz9av0>
X-Attachment-Id: f_lm3xz9av0

IGFyY2gveDg2L2tlcm5lbC9zeXNfeDg2XzY0LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogZnMvc3RhdC5jICAgICAgICAgICAgICAgICAgICB8ICAy
ICstCiBpbmNsdWRlL2xpbnV4L3N0YXQuaCAgICAgICAgIHwgIDIgKysKIDMgZmlsZXMgY2hhbmdl
ZCwgNDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9zeXNfeDg2XzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvc3lzX3g4Nl82NC5jCmluZGV4
IGM3ODNhZWIzN2RjZS4uZmNhNjQ3ZjYxYmMxIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
c3lzX3g4Nl82NC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9zeXNfeDg2XzY0LmMKQEAgLTIyLDYg
KzIyLDUwIEBACiAjaW5jbHVkZSA8YXNtL2VsZi5oPgogI2luY2x1ZGUgPGFzbS9pYTMyLmg+CiAK
K2ludCBjcF9uZXdfc3RhdChzdHJ1Y3Qga3N0YXQgKnN0YXQsIHN0cnVjdCBzdGF0IF9fdXNlciAq
dWJ1ZikKK3sKKwl0eXBlb2YodWJ1Zi0+c3RfdWlkKSB1aWQ7CisJdHlwZW9mKHVidWYtPnN0X2dp
ZCkgZ2lkOworCXR5cGVvZih1YnVmLT5zdF9kZXYpIGRldiA9IG5ld19lbmNvZGVfZGV2KHN0YXQt
PmRldik7CisJdHlwZW9mKHVidWYtPnN0X3JkZXYpIHJkZXYgPSBuZXdfZW5jb2RlX2RldihzdGF0
LT5yZGV2KTsKKworCVNFVF9VSUQodWlkLCBmcm9tX2t1aWRfbXVuZ2VkKGN1cnJlbnRfdXNlcl9u
cygpLCBzdGF0LT51aWQpKTsKKwlTRVRfR0lEKGdpZCwgZnJvbV9rZ2lkX211bmdlZChjdXJyZW50
X3VzZXJfbnMoKSwgc3RhdC0+Z2lkKSk7CisKKwlpZiAoIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2lu
KHVidWYsIHNpemVvZihzdHJ1Y3Qgc3RhdCkpKQorCQlyZXR1cm4gLUVGQVVMVDsKKworCXVuc2Fm
ZV9wdXRfdXNlcihkZXYsCQkJJnVidWYtPnN0X2RldiwJCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91
c2VyKHN0YXQtPmlubywJCSZ1YnVmLT5zdF9pbm8sCQlFZmF1bHQpOworCXVuc2FmZV9wdXRfdXNl
cihzdGF0LT5ubGluaywJCSZ1YnVmLT5zdF9ubGluaywJRWZhdWx0KTsKKworCXVuc2FmZV9wdXRf
dXNlcihzdGF0LT5tb2RlLAkJJnVidWYtPnN0X21vZGUsCQlFZmF1bHQpOworCXVuc2FmZV9wdXRf
dXNlcih1aWQsCQkJJnVidWYtPnN0X3VpZCwJCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91c2VyKGdp
ZCwJCQkmdWJ1Zi0+c3RfZ2lkLAkJRWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIoMCwJCQkmdWJ1
Zi0+X19wYWQwLAkJRWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIocmRldiwJCQkmdWJ1Zi0+c3Rf
cmRldiwJCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91c2VyKHN0YXQtPnNpemUsCQkmdWJ1Zi0+c3Rf
c2l6ZSwJCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91c2VyKHN0YXQtPmJsa3NpemUsCQkmdWJ1Zi0+
c3RfYmxrc2l6ZSwJRWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIoc3RhdC0+YmxvY2tzLAkJJnVi
dWYtPnN0X2Jsb2NrcywJRWZhdWx0KTsKKworCXVuc2FmZV9wdXRfdXNlcihzdGF0LT5hdGltZS50
dl9zZWMsCSZ1YnVmLT5zdF9hdGltZSwJRWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIoc3RhdC0+
YXRpbWUudHZfbnNlYywJJnVidWYtPnN0X2F0aW1lX25zZWMsCUVmYXVsdCk7CisJdW5zYWZlX3B1
dF91c2VyKHN0YXQtPm10aW1lLnR2X3NlYywJJnVidWYtPnN0X210aW1lLAlFZmF1bHQpOworCXVu
c2FmZV9wdXRfdXNlcihzdGF0LT5tdGltZS50dl9uc2VjLAkmdWJ1Zi0+c3RfbXRpbWVfbnNlYywJ
RWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIoc3RhdC0+Y3RpbWUudHZfc2VjLAkmdWJ1Zi0+c3Rf
Y3RpbWUsCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91c2VyKHN0YXQtPmN0aW1lLnR2X25zZWMsCSZ1
YnVmLT5zdF9jdGltZV9uc2VjLAlFZmF1bHQpOworCXVuc2FmZV9wdXRfdXNlcigwLAkJCSZ1YnVm
LT5fX3VudXNlZFswXSwJRWZhdWx0KTsKKwl1bnNhZmVfcHV0X3VzZXIoMCwJCQkmdWJ1Zi0+X191
bnVzZWRbMV0sCUVmYXVsdCk7CisJdW5zYWZlX3B1dF91c2VyKDAsCQkJJnVidWYtPl9fdW51c2Vk
WzJdLAlFZmF1bHQpOworCisJdXNlcl93cml0ZV9hY2Nlc3NfZW5kKCk7CisJcmV0dXJuIDA7CisK
K0VmYXVsdDoKKwl1c2VyX3dyaXRlX2FjY2Vzc19lbmQoKTsKKwlyZXR1cm4gLUVGQVVMVDsKK30K
KwogLyoKICAqIEFsaWduIGEgdmlydHVhbCBhZGRyZXNzIHRvIGF2b2lkIGFsaWFzaW5nIGluIHRo
ZSBJJCBvbiBBTUQgRjE1aC4KICAqLwpkaWZmIC0tZ2l0IGEvZnMvc3RhdC5jIGIvZnMvc3RhdC5j
CmluZGV4IGUxODdkYzc5YTMxMy4uNzgyYWQ2NDZlZDI3IDEwMDY0NAotLS0gYS9mcy9zdGF0LmMK
KysrIGIvZnMvc3RhdC5jCkBAIC00MTUsNyArNDE1LDcgQEAgU1lTQ0FMTF9ERUZJTkUyKGZzdGF0
LCB1bnNpZ25lZCBpbnQsIGZkLCBzdHJ1Y3QgX19vbGRfa2VybmVsX3N0YXQgX191c2VyICosIHN0
YXQKICMgIGRlZmluZSBJTklUX1NUUlVDVF9TVEFUX1BBRERJTkcoc3QpIG1lbXNldCgmc3QsIDAs
IHNpemVvZihzdCkpCiAjZW5kaWYKIAotc3RhdGljIGludCBjcF9uZXdfc3RhdChzdHJ1Y3Qga3N0
YXQgKnN0YXQsIHN0cnVjdCBzdGF0IF9fdXNlciAqc3RhdGJ1ZikKK2ludCBfX3dlYWsgY3BfbmV3
X3N0YXQoc3RydWN0IGtzdGF0ICpzdGF0LCBzdHJ1Y3Qgc3RhdCBfX3VzZXIgKnN0YXRidWYpCiB7
CiAJc3RydWN0IHN0YXQgdG1wOwogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N0YXQuaCBi
L2luY2x1ZGUvbGludXgvc3RhdC5oCmluZGV4IDUyMTUwNTcwZDM3YS4uZjYxOTlhYTNlMWNiIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3N0YXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N0YXQu
aApAQCAtNjMsNCArNjMsNiBAQCBzdHJ1Y3Qga3N0YXQgewogLyogZmlsZSBhdHRyaWJ1dGUgdmFs
dWVzICovCiAjZGVmaW5lIFNUQVRYX0FUVFJfQ0hBTkdFX01PTk9UT05JQwkweDgwMDAwMDAwMDAw
MDAwMDBVTEwgLyogdmVyc2lvbiBtb25vdG9uaWNhbGx5IGluY3JlYXNlcyAqLwogCitpbnQgY3Bf
bmV3X3N0YXQoc3RydWN0IGtzdGF0ICpzdGF0LCBzdHJ1Y3Qgc3RhdCBfX3VzZXIgKnVidWYpOwor
CiAjZW5kaWYK
--0000000000003d367906047ac2bc--
