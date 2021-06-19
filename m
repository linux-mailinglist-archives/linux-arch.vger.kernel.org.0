Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6B3AD69A
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 04:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhFSCQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSCQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 22:16:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8698C06175F
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 19:14:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k8so16406832lja.4
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 19:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlUr2dj/mPpBImS62lo8f1D6lIrU3rKWetXXOvmPDow=;
        b=NrfTthomeCk7Zy2BhRIdRjdjMXvqIUZUQIiC26wC3z0llHdFvgiwxg2Wv0E0XqyyFn
         ChuquI4lQJlE+oTwPNlnR03/BmN+VzWeTMj4n8Duf6yDqAgb+ks9bqfWkHL9UA4/4fyc
         b254IzqR73JuzFI8AM2B/IDFi0OM7X+hkh8W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlUr2dj/mPpBImS62lo8f1D6lIrU3rKWetXXOvmPDow=;
        b=S0sw7SiaICV/3giWTWxsU8oV5wKAcjIJmnPx7iVmaFdx1W6BkzgxNY2XPYSk68yI5f
         bb6VEBogNg+yrGeFqGCF/8epkkvcHkPCWnvhCiMaWhtCbqMF5tY/foETX3xDx03KGoGw
         GGH6blEBlIYqxBIg3BerwnwdfPLL9Y/Kq2Sjdmoxh4/zBpyoAsDMby9Vfy1qljUdgtVo
         um/WyasQ9A5aZCxzc4kwP3kNsZhfft5HOWn2VM0g7XkQwrurddYNAUJoumhJIPg3GyOs
         tF1pISK6wiW+Je3zAfb5TB1Aqa4w7m0BidMJ3G4XXz36sVgEgpmkfxKrov/nPK0qg5Hy
         sntQ==
X-Gm-Message-State: AOAM531k8Lm1MS0kgs3EQ/KhOtzFooHDo/lRpX+EO2vHS4CZFVPiC0Pw
        uM5OqJ5SJfQnUHOmG5bAFE6L9V6M4YC1quoW
X-Google-Smtp-Source: ABdhPJw2wjGVyZRKOzyIhzHwrJvGp4/Y5tLQZbVIZuAtaGjYI72bLpNdCgKFuqLSRMGL6fggtW1xWA==
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr5378407ljs.361.1624068855043;
        Fri, 18 Jun 2021 19:14:15 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id p15sm394502ljg.28.2021.06.18.19.14.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 19:14:14 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h15so1140024lfv.12
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 19:14:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr5376578lfv.41.1624068854147;
 Fri, 18 Jun 2021 19:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
 <91865b90-c597-6119-5e14-dfe521a33489@gmail.com> <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
 <2b2ba866-104c-afea-9c29-145e9d80c2d5@gmail.com> <CAHk-=wjFG7zfO7RXu8RUOkuRPE59-OuqzBFsH-Zk1ieSKYbrYA@mail.gmail.com>
In-Reply-To: <CAHk-=wjFG7zfO7RXu8RUOkuRPE59-OuqzBFsH-Zk1ieSKYbrYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 19:13:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJkOSXKTL8L9Pv1k0T5tfUmCogsSGfbBdU_3ekS0dW7w@mail.gmail.com>
Message-ID: <CAHk-=wgJkOSXKTL8L9Pv1k0T5tfUmCogsSGfbBdU_3ekS0dW7w@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry points
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: multipart/mixed; boundary="00000000000024960405c514ffcb"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--00000000000024960405c514ffcb
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 18, 2021 at 6:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The registers being zero at that point is actually expected, so that's
> not much of a hint. But yeah, clearly I got some stack initialization
> offset or something wrong there, and I don't know modern m68k nearly
> well enough to even guess where I screwed up.

Oh. I think I might have an idea.

In that ret_from_kernel_thread code, after it returns from thge kernel
thread, I did

        addql   #4,%sp
        RESTORE_SWITCH_STACK
        jra     ret_from_exception

where that "RESTORE_SWITCH_STACK" loads the user space registers from
the user-space switch stack.

BUT.

The switch stack also has that "retpc", and that one should just be popped.

So I think that code should read

        addql   #4,%sp
        RESTORE_SWITCH_STACK
        addql   #4,%sp
        jra     ret_from_exception

because we want to restore the switch stack registers (they'll all be
0) but we then want to get rid of retpc too before we jump to
ret_from_exception, which will do the RESTORE_ALL.

(The first 'addql' is to remove the argument we've pushed on the stack
earlier in ret_from_kernel_thread, the second addql is to remove
retpc).

 All the *normal* uses of RESTORE_SWITCH_STACK will just do "rts", but
that's because they were called from the shallower stack. The
ret_from_kernel_thread case is kind of special, because it had that
stack frame layout built up manually, rather than have a call to it.

In that sense, it's a bit more like the 'do_trace_entry/exit' code,
which builds that switch stack using

        subql   #4,%sp
        SAVE_SWITCH_STACK

and then undoes it using that same

        RESTORE_SWITCH_STACK
        addql   #4,%sp

sequence that I _should_ have done in ret_from_kernel_thread. (Also,
see ret_from_signal)

I've attached an updated patch just in case my incoherent ramblings
above didn't explain what I meant. It's the same as the previous
patch, it just has that one extra stack update there.

Does _this_ one perhaps work?

                 Linus

--00000000000024960405c514ffcb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kq34nhz80>
X-Attachment-Id: f_kq34nhz80

IGFyY2gvbTY4ay9rZXJuZWwvZW50cnkuUyAgIHwgMTEgKysrKysrKysrKysKIGFyY2gvbTY4ay9r
ZXJuZWwvcHJvY2Vzcy5jIHwgMTQgKysrKysrKysrLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL202OGsva2Vy
bmVsL2VudHJ5LlMgYi9hcmNoL202OGsva2VybmVsL2VudHJ5LlMKaW5kZXggOWRkNzZmYmI3YzZi
Li44OGZlMGUxYTM3OTMgMTAwNjQ0Ci0tLSBhL2FyY2gvbTY4ay9rZXJuZWwvZW50cnkuUworKysg
Yi9hcmNoL202OGsva2VybmVsL2VudHJ5LlMKQEAgLTExOSw2ICsxMTksMTUgQEAgRU5UUlkocmV0
X2Zyb21fZm9yaykKIAlhZGRxbAkjNCwlc3AKIAlqcmEJcmV0X2Zyb21fZXhjZXB0aW9uCiAKKwl8
IEEga2VybmVsIHRocmVhZCB3aWxsIGp1bXAgaGVyZSBkaXJlY3RseSBmcm9tIHJlc3VtZSwKKwl8
IHdpdGggdGhlIHN0YWNrIGNvbnRhaW5pbmcgdGhlIGZ1bGwgcmVnaXN0ZXIgc3RhdGUKKwl8IChw
dF9yZWdzIGFuZCBzd2l0Y2hfc3RhY2spLgorCXwKKwl8IFRoZSBhcmd1bWVudCB3aWxsIGJlIGlu
IGQ3LCBhbmQgdGhlIGtlcm5lbCBmdW5jdGlvbgorCXwgdG8gY2FsbCB3aWxsIGJlIGluIGEzLgor
CXwKKwl8IElmIHRoZSBrZXJuZWwgZnVuY3Rpb24gcmV0dXJucywgd2Ugd2FudCB0byByZXR1cm4K
Kwl8IHRvIHVzZXIgc3BhY2UgLSBpdCBoYXMgZG9uZSBhIGtlcm5lbF9leGVjdmUoKS4KIEVOVFJZ
KHJldF9mcm9tX2tlcm5lbF90aHJlYWQpCiAJfCBhMyBjb250YWlucyB0aGUga2VybmVsIHRocmVh
ZCBwYXlsb2FkLCBkNyAtIGl0cyBhcmd1bWVudAogCW1vdmVsCSVkMSwlc3BALQpAQCAtMTI2LDYg
KzEzNSw4IEBAIEVOVFJZKHJldF9mcm9tX2tlcm5lbF90aHJlYWQpCiAJbW92ZWwJJWQ3LCglc3Ap
CiAJanNyCSVhM0AKIAlhZGRxbAkjNCwlc3AKKwlSRVNUT1JFX1NXSVRDSF9TVEFDSworCWFkZHFs
CSM0LCVzcAogCWpyYQlyZXRfZnJvbV9leGNlcHRpb24KIAogI2lmIGRlZmluZWQoQ09ORklHX0NP
TERGSVJFKSB8fCAhZGVmaW5lZChDT05GSUdfTU1VKQpkaWZmIC0tZ2l0IGEvYXJjaC9tNjhrL2tl
cm5lbC9wcm9jZXNzLmMgYi9hcmNoL202OGsva2VybmVsL3Byb2Nlc3MuYwppbmRleCBkYTgzY2M4
M2U3OTEuLjA3MDVmMTQ4NzFhMyAxMDA2NDQKLS0tIGEvYXJjaC9tNjhrL2tlcm5lbC9wcm9jZXNz
LmMKKysrIGIvYXJjaC9tNjhrL2tlcm5lbC9wcm9jZXNzLmMKQEAgLTE1OCwxMyArMTU4LDE3IEBA
IGludCBjb3B5X3RocmVhZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCB1bnNpZ25lZCBsb25n
IHVzcCwgdW5zaWduZWQgbG9uZyBhcmcsCiAJcC0+dGhyZWFkLmZzID0gZ2V0X2ZzKCkuc2VnOwog
CiAJaWYgKHVubGlrZWx5KHAtPmZsYWdzICYgKFBGX0tUSFJFQUQgfCBQRl9JT19XT1JLRVIpKSkg
ewotCQkvKiBrZXJuZWwgdGhyZWFkICovCi0JCW1lbXNldChmcmFtZSwgMCwgc2l6ZW9mKHN0cnVj
dCBmb3JrX2ZyYW1lKSk7CisJCXN0cnVjdCBzd2l0Y2hfc3RhY2sgKmtzdHAgPSAmZnJhbWUtPnN3
IC0gMTsKKworCQkvKiBrZXJuZWwgdGhyZWFkIC0gYSBrZXJuZWwtc2lkZSBzd2l0Y2gtc3RhY2sg
YW5kIHRoZSBmdWxsIHVzZXIgZm9ya19mcmFtZSAqLworCQltZW1zZXQoa3N0cCwgMCwgc2l6ZW9m
KHN0cnVjdCBzd2l0Y2hfc3RhY2spICsgc2l6ZW9mKHN0cnVjdCBmb3JrX2ZyYW1lKSk7CisKIAkJ
ZnJhbWUtPnJlZ3Muc3IgPSBQU19TOwotCQlmcmFtZS0+c3cuYTMgPSB1c3A7IC8qIGZ1bmN0aW9u
ICovCi0JCWZyYW1lLT5zdy5kNyA9IGFyZzsKLQkJZnJhbWUtPnN3LnJldHBjID0gKHVuc2lnbmVk
IGxvbmcpcmV0X2Zyb21fa2VybmVsX3RocmVhZDsKKwkJa3N0cC0+YTMgPSB1c3A7IC8qIGZ1bmN0
aW9uICovCisJCWtzdHAtPmQ3ID0gYXJnOworCQlrc3RwLT5yZXRwYyA9ICh1bnNpZ25lZCBsb25n
KXJldF9mcm9tX2tlcm5lbF90aHJlYWQ7CiAJCXAtPnRocmVhZC51c3AgPSAwOworCQlwLT50aHJl
YWQua3NwID0gKHVuc2lnbmVkIGxvbmcpa3N0cDsKIAkJcmV0dXJuIDA7CiAJfQogCW1lbWNweShm
cmFtZSwgY29udGFpbmVyX29mKGN1cnJlbnRfcHRfcmVncygpLCBzdHJ1Y3QgZm9ya19mcmFtZSwg
cmVncyksCg==
--00000000000024960405c514ffcb--
