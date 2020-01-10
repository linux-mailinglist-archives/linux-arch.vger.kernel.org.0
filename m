Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12A137677
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 19:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgAJSys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 13:54:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46183 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgAJSys (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 13:54:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so2226008lfl.13
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1vUATzUBpIGtELb+vItTo1wkE0Sy8cpDXXVV9tUxg4=;
        b=Asi+Td2STF/mUZRXQIv70X1R92yzc9QNkF0hyVHvxy/vDF3BWUUgKG+s5bhHF8lXm1
         pmZ9SkxNAja2H57ghybZjnyXwh47Lcye5VyMq5jcdrYG12Nfwt5EvKEWCQIqZHBmZpkZ
         bLFLUI7/QsOh+k0bjEkN1VWI8BcVEG5fhLMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1vUATzUBpIGtELb+vItTo1wkE0Sy8cpDXXVV9tUxg4=;
        b=VH0KOUSP9W9Mw8iXNJAcqnimxrGCfYIcQZ+kz2e7X5njjDHf5+bWxvZcJAe7ot5YJt
         EPSFEPC3pJfBdiQWPaGOdnZq3kJDZtBVzZLSOZdJpVakNno+NFbddj/RHjW/SqPrwB6S
         jBIjyN8BqaYMWdR8+gdO+z3gX/l0mMAnEun/SBvVHx1LBxsIA/RAqfGRwqAWCpZQAdGC
         PxRsbWmb25ex6O86u+GsnMuKf778qIN3FEY/lNxjD5hErhEdUlsKHJ4OupfSygpgOktF
         Dp4+s0mJKBNuCwtZwCcG2donK7ShnzV7TqH28wSjaMTJopN5DuiE8SZag0l/zHMQDxBT
         Y/Lw==
X-Gm-Message-State: APjAAAVuMSbzasfn6cQYB/PVPPNZ14Dfc6WpRWGBdQOes5v33fSh+C4Q
        iAGZCA2z5WO8SEMeAb0z4N2I1AOzG/4=
X-Google-Smtp-Source: APXvYqx6K3IjHGMaa4MHu5U0D664TIcD6gGXE+SjW2Jfw2CeqD/udi2ju646vwbBNOlC6ELaiqpVYA==
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr3264073lfp.75.1578682485572;
        Fri, 10 Jan 2020 10:54:45 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z14sm1390217ljm.86.2020.01.10.10.54.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 10:54:44 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y4so3166353ljj.9
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 10:54:43 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr3531333ljo.41.1578682483466;
 Fri, 10 Jan 2020 10:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
In-Reply-To: <20200110165636.28035-7-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 10:54:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
Message-ID: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="000000000000a42d9d059bcda82d"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000a42d9d059bcda82d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 10, 2020 at 8:56 AM Will Deacon <will@kernel.org> wrote:
>
> +/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
> +#define __unqual_scalar_typeof(x) typeof(                                      \

Ugh. My eyes. That's horrendous.

I can't see any better alternatives, but it does make me go "Eww".

Well, I do see one possible alternative: just re-write the bitop
implementations in terms of "atomic_long_t", and just avoid the issue
entirely.

IOW, do something like the attached (but fleshed out and tested - this
patch has not seen a compiler, much less any thought at all).

                   Linus

--000000000000a42d9d059bcda82d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k58is1210>
X-Attachment-Id: f_k58is1210

IGluY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaCB8IDEyICsrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9sb2NrLmggYi9pbmNsdWRlL2FzbS1nZW5lcmlj
L2JpdG9wcy9sb2NrLmgKaW5kZXggM2FlMDIxMzY4ZjQ4Li4wNzFkOGJmZDg2ZTUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaAorKysgYi9pbmNsdWRlL2FzbS1n
ZW5lcmljL2JpdG9wcy9sb2NrLmgKQEAgLTYsNiArNiwxMiBAQAogI2luY2x1ZGUgPGxpbnV4L2Nv
bXBpbGVyLmg+CiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KIAorLyogRHJvcCB0aGUgdm9sYXRp
bGUsIHdlIHdpbGwgYmUgZG9pbmcgUkVBRF9PTkNFIGJ5IGhhbmQgKi8KK3N0YXRpYyBpbmxpbmUg
YXRvbWljX2xvbmdfdCAqYXRvbWljX2xvbmdfYml0X3dvcmQodW5zaWduZWQgaW50IG5yLCB2b2xh
dGlsZSB1bnNpZ25lZCBsb25nICpwKQoreworCXJldHVybiBCSVRfV09SRChucikgKyAoYXRvbWlj
X2xvbmdfdCAqKXA7Cit9CisKIC8qKgogICogdGVzdF9hbmRfc2V0X2JpdF9sb2NrIC0gU2V0IGEg
Yml0IGFuZCByZXR1cm4gaXRzIG9sZCB2YWx1ZSwgZm9yIGxvY2sKICAqIEBucjogQml0IHRvIHNl
dApAQCAtMjAsMTIgKzI2LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYW5kX3NldF9iaXRf
bG9jayh1bnNpZ25lZCBpbnQgbnIsCiB7CiAJbG9uZyBvbGQ7CiAJdW5zaWduZWQgbG9uZyBtYXNr
ID0gQklUX01BU0sobnIpOworCWF0b21pY19sb25nX3QgKmxvYyA9IGF0b21pY19sb25nX2JpdF93
b3JkKG5yLCBwKTsKIAotCXAgKz0gQklUX1dPUkQobnIpOwotCWlmIChSRUFEX09OQ0UoKnApICYg
bWFzaykKKwlpZiAoYXRvbWljX3JlYWQobG9jKSAmIG1hc2spCiAJCXJldHVybiAxOwogCi0Jb2xk
ID0gYXRvbWljX2xvbmdfZmV0Y2hfb3JfYWNxdWlyZShtYXNrLCAoYXRvbWljX2xvbmdfdCAqKXAp
OworCW9sZCA9IGF0b21pY19sb25nX2ZldGNoX29yX2FjcXVpcmUobWFzaywgbG9jKTsKIAlyZXR1
cm4gISEob2xkICYgbWFzayk7CiB9CiAK
--000000000000a42d9d059bcda82d--
