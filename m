Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3221234E5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLQSc5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 13:32:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44128 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQSc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2019 13:32:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so4296342lje.11
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYDXouQoU3y/R3fqSOF776cIghXwAxtEEUBgvo6xNr8=;
        b=POj9QNWZ+2oG1d0wJ+AGe0JzUEl4bf+yTk0aMMoMg7V/xuJUZKcexLj2AQ+FpK+mEh
         uOHM4ohY6YsLwl+ZUWno3ckqZcQXxs/dBSemQ87no/iOewhJAGNEbllh8ouSQ6OrUwPg
         94y/v1tYI4aJP83wAxK3Q/Q5sG85HJcVEDDcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYDXouQoU3y/R3fqSOF776cIghXwAxtEEUBgvo6xNr8=;
        b=WiLlrZU5VmTO4OwyNPvKSLMKRpXBOYwnVtV8Uwqe4P5hz3l6ftMa7cJtbhGgGom9bb
         SWCwTYOOm9gRqoGR8vbtSCb0NGCztz+RLCWt9FiySCWO4r9VLEoNejnMxXIsTJoNReKG
         w+/sMlen5IowOvC/CUeWzwzoM0hXHhGiAfe2lwAlg8ri0BUvY0Armf9o1GLBJHQpoeO0
         Etb/36M1w5HDDXIzz7Vvz+C9rLB6Pez3QrAwHBHikw9CR6I67EuEinr2MImM143tw7QI
         ea/p7LU+m4kAum9kDSksuncDu02d1en3BBjInN+CTmMt+SN2U4JRKD8Nd/52T3YRsKLZ
         b5AA==
X-Gm-Message-State: APjAAAXMq6OafKF3/OPl0NSuOOTqQuiFdd0coeNGjOs7sZmXzwujr/Kf
        E4rinzvT34BeFKI6L8wuhvtGYL4L2a0=
X-Google-Smtp-Source: APXvYqzouTGL4GNTmZifFkfoKzVBAtF+6vzwsmbAuEp0rIs4VVtT0z1mIockByoxyai5/hVheHyeKQ==
X-Received: by 2002:a2e:6e10:: with SMTP id j16mr4293436ljc.202.1576607574376;
        Tue, 17 Dec 2019 10:32:54 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q27sm13195751ljc.65.2019.12.17.10.32.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:32:53 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id u1so1218793ljk.7
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:32:53 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4321859ljj.148.1576607573020;
 Tue, 17 Dec 2019 10:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck> <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 10:32:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
Message-ID: <CAHk-=wjNLxSZZs+A0tyb-MnJ2YU-sqTAfy0-X+9vxjXfs_O4zA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: multipart/mixed; boundary="0000000000005752d20599ea8ef5"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000005752d20599ea8ef5
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about it.

How about we just get rid of the union entirely, and just use
'unsigned long' or 'unsigned long long' depending on the size.

Something like the attached patch - it still requires that it be an
arithmetic type, but now because of the final cast.

But it might still be a cast to a volatile type, of course. Then the
result will be volatile, but at least now READ_ONCE() won't be taking
the address of a volatile variable on the stack - does that at least
fix some of the horrible code generation. Hmm?

This is untested, because I obviously still have the cases of
structures (page table entries) being accessed once..

              Linus

--0000000000005752d20599ea8ef5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k4a7eqn90>
X-Attachment-Id: f_k4a7eqn90

IGluY2x1ZGUvbGludXgvY29tcGlsZXIuaCB8IDMzICsrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaCBiL2luY2x1ZGUvbGludXgv
Y29tcGlsZXIuaAppbmRleCA1ZTg4ZTdlMzNhYmUuLjhiNDI4MjE5NGYxNiAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9saW51eC9jb21waWxlci5oCisrKyBiL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaApA
QCAtMTc5LDE4ICsxNzksMTggQEAgdm9pZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRy
YWNlX2xpa2VseV9kYXRhICpmLCBpbnQgdmFsLAogCiAjaW5jbHVkZSA8dWFwaS9saW51eC90eXBl
cy5oPgogCi0jZGVmaW5lIF9fUkVBRF9PTkNFX1NJWkUJCQkJCQlcCi0oewkJCQkJCQkJCVwKLQlz
d2l0Y2ggKHNpemUpIHsJCQkJCQkJXAotCWNhc2UgMTogKihfX3U4ICopcmVzID0gKih2b2xhdGls
ZSBfX3U4ICopcDsgYnJlYWs7CQlcCi0JY2FzZSAyOiAqKF9fdTE2ICopcmVzID0gKih2b2xhdGls
ZSBfX3UxNiAqKXA7IGJyZWFrOwkJXAotCWNhc2UgNDogKihfX3UzMiAqKXJlcyA9ICoodm9sYXRp
bGUgX191MzIgKilwOyBicmVhazsJCVwKLQljYXNlIDg6ICooX191NjQgKilyZXMgPSAqKHZvbGF0
aWxlIF9fdTY0ICopcDsgYnJlYWs7CQlcCi0JZGVmYXVsdDoJCQkJCQkJXAotCQliYXJyaWVyKCk7
CQkJCQkJXAotCQlfX2J1aWx0aW5fbWVtY3B5KCh2b2lkICopcmVzLCAoY29uc3Qgdm9pZCAqKXAs
IHNpemUpOwlcCi0JCWJhcnJpZXIoKTsJCQkJCQlcCi0JfQkJCQkJCQkJXAorLyogInVuc2lnbmVk
IGxvbmciIG9yICJ1bnNpZ25lZCBsb25nIGxvbmciIC0gbWFrZSBpdCBmaXQgaW4gYSByZWdpc3Rl
ciBpZiBwb3NzaWJsZSAqLworI2RlZmluZSBfX1JFQURfT05DRV9UWVBFKHNpemUpIFwKKwlfX3R5
cGVvZl9fKF9fYnVpbHRpbl9jaG9vc2VfZXhwcihzaXplID4gc2l6ZW9mKDBVTCksIDBVTEwsIDBV
TCkpCisKKyNkZWZpbmUgX19SRUFEX09OQ0VfU0laRQkJCQkJCQlcCisoewkJCQkJCQkJCQlcCisJ
c3dpdGNoIChzaXplKSB7CQkJCQkJCQlcCisJY2FzZSAxOiAqKHVuc2lnbmVkIGxvbmcgKilyZXMg
PSAqKHZvbGF0aWxlIF9fdTggKilwOyBicmVhazsJCVwKKwljYXNlIDI6ICoodW5zaWduZWQgbG9u
ZyAqKXJlcyA9ICoodm9sYXRpbGUgX191MTYgKilwOyBicmVhazsJCVwKKwljYXNlIDQ6ICoodW5z
aWduZWQgbG9uZyAqKXJlcyA9ICoodm9sYXRpbGUgX191MzIgKilwOyBicmVhazsJCVwKKwljYXNl
IDg6ICoodW5zaWduZWQgbG9uZyBsb25nICopcmVzID0gKih2b2xhdGlsZSBfX3U2NCAqKXA7IGJy
ZWFrOwlcCisJfQkJCQkJCQkJCVwKIH0pCiAKIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUKQEAgLTI1
OCwxMyArMjU4LDE0IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX3dyaXRlX29uY2Vf
c2l6ZSh2b2xhdGlsZSB2b2lkICpwLCB2b2lkICpyZXMsIGludCBzCiAKICNkZWZpbmUgX19SRUFE
X09OQ0UoeCwgY2hlY2spCQkJCQkJXAogKHsJCQkJCQkJCQlcCi0JdW5pb24geyB0eXBlb2YoeCkg
X192YWw7IGNoYXIgX19jWzFdOyB9IF9fdTsJCQlcCisJX19SRUFEX09OQ0VfVFlQRShzaXplb2Yo
eCkpIF9fdTsJCQkJXAorCWNvbXBpbGV0aW1lX2Fzc2VydChzaXplb2YoeCkgPD0gc2l6ZW9mKF9f
dSksICJSRUFEX09OQ0UgdHlwZSIpOwlcCiAJaWYgKGNoZWNrKQkJCQkJCQlcCi0JCV9fcmVhZF9v
bmNlX3NpemUoJih4KSwgX191Ll9fYywgc2l6ZW9mKHgpKTsJCVwKKwkJX19yZWFkX29uY2Vfc2l6
ZSgmKHgpLCAmX191LCBzaXplb2YoeCkpOwkJXAogCWVsc2UJCQkJCQkJCVwKLQkJX19yZWFkX29u
Y2Vfc2l6ZV9ub2NoZWNrKCYoeCksIF9fdS5fX2MsIHNpemVvZih4KSk7CVwKKwkJX19yZWFkX29u
Y2Vfc2l6ZV9ub2NoZWNrKCYoeCksICZfX3UsIHNpemVvZih4KSk7CVwKIAlzbXBfcmVhZF9iYXJy
aWVyX2RlcGVuZHMoKTsgLyogRW5mb3JjZSBkZXBlbmRlbmN5IG9yZGVyaW5nIGZyb20geCAqLyBc
Ci0JX191Ll9fdmFsOwkJCQkJCQlcCisJKF9fdHlwZW9mX18oeCkpX191OwkJCQkJCVwKIH0pCiAj
ZGVmaW5lIFJFQURfT05DRSh4KSBfX1JFQURfT05DRSh4LCAxKQogCg==
--0000000000005752d20599ea8ef5--
