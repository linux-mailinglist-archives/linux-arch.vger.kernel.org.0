Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A609E255E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 23:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391325AbfJWVbF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 17:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732284AbfJWVbF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 17:31:05 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4B32173B
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571866264;
        bh=bq0xL50hpqaPXcNSOUfqCHdzo65lRDo//Gm6bz69RZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xOoTNiJgTEkXxLm3Zw2wUubiwXf7K9pRiSbAs/YuGr7DsOZgVtWHy0apBBVtfFUef
         CbVcE0oAPQLm8UTtG4o1EXrWYK7DWsHtRzkrwXnODgaWsmUu9IhJsmcaPP/DQim6Ls
         GjdkAqyd+IeYC5RkbSD7pRoJdzmof04wqvgo5QS8=
Received: by mail-wr1-f41.google.com with SMTP id w18so23119623wrt.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 14:31:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWrWQ8muQz2AM5t3olhIAlCy8ZyPjox1uq9hdiio8wYJgW/bgoY
        zprP1GwP5ndck8YSw0r+3AML5TpM7W/wwDDeCptAdQ==
X-Google-Smtp-Source: APXvYqxciiabhK1TgUrj4Tvuz0nMo9AovfxcBOd5U1U4aZECW+yDd2p8KX8bdYpf//9QdzEBqYuaRFnrVK7lMJnSpFM=
X-Received: by 2002:adf:f342:: with SMTP id e2mr721058wrp.61.1571866262651;
 Wed, 23 Oct 2019 14:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de>
In-Reply-To: <20191023123118.386844979@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 14:30:51 -0700
X-Gmail-Original-Message-ID: <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
Message-ID: <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: multipart/mixed; boundary="00000000000038b2b005959aa2c3"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--00000000000038b2b005959aa2c3
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Interrupt state tracing can be safely done in C code. The few stack
> operations in assembly do not need to be covered.
>
> Remove the now pointless indirection via .Lsyscall_32_done and jump to
> swapgs_restore_regs_and_return_to_usermode directly.

This doesn't look right.

>  #define SYSCALL_EXIT_WORK_FLAGS                                \
> @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
>  {
>         struct thread_info *ti;
>
> +       /* User to kernel transition disabled interrupts. */
> +       trace_hardirqs_off();
> +

So you just traced IRQs off, but...

>         enter_from_user_mode();
>         local_irq_enable();

Now they're on and traced on again?

I also don't see how your patch handles the fastpath case.

How about the attached patch instead?

--00000000000038b2b005959aa2c3
Content-Type: text/x-patch; charset="US-ASCII"; name="irqtrace.patch"
Content-Disposition: attachment; filename="irqtrace.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k23sk6dd0>
X-Attachment-Id: f_k23sk6dd0

Y29tbWl0IGUxNTRhZjBkN2ZmMmQ2MDVmMTU1ZjVhY2EwNTllM2U4MzVlNDI2ZDQKQXV0aG9yOiBB
bmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4KRGF0ZTogICBGcmkgQXVnIDIgMTA6MzA6
NDQgMjAxOSAtMDcwMAoKICAgIHg4Ni9lbnRyeTogTW92ZSBleGl0LXRvLXVzZXJtb2RlIGlycWZs
YWcgdHJhY2luZyB0byBwcmVwYXJlX2V4aXRfdG9fdXNlcm1vZGUoKQogICAgCiAgICBwcmVwYXJl
X2V4aXRfdG9fdXNlcm1vZGUoKSBjYW4gZWFzaWx5IGhhbmRsZSBpcnFmbGFnIHRyYWNpbmcuICBN
b3ZlCiAgICB0aGUgbG9naWMgdGhlcmUgYW5kIHJlbW92ZSBpdCBmcm9tIHRoZSBlbnRyeSBhc20u
CiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3Jn
PgoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jIGIvYXJjaC94ODYvZW50cnkv
Y29tbW9uLmMKaW5kZXggY2M0OTM4MGVmOGFiLi5mNGNlMGNmMmZiNzQgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2VudHJ5L2NvbW1vbi5jCisrKyBiL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jCkBAIC0y
MTcsNiArMjE3LDEzIEBAIF9fdmlzaWJsZSBpbmxpbmUgdm9pZCBwcmVwYXJlX2V4aXRfdG9fdXNl
cm1vZGUoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAKIAl1c2VyX2VudGVyX2lycW9mZigpOwogCisJ
LyoKKwkgKiBUaGUgYWN0dWFsIHJldHVybiB0byB1c2VybW9kZSB3aWxsIGFsbW9zdCBjZXJ0YWlu
bHkgdHVybiBJUlFzIG9uLgorCSAqIFRyYWNlIGl0IGhlcmUgdG8gc2ltcGxpZnkgdGhlIGFzbSBj
b2RlLgorCSAqLworCWlmIChsaWtlbHkocmVncy0+ZmxhZ3MgJiBYODZfRUZMQUdTX0lGKSkKKwkJ
dHJhY2VfaGFyZGlycXNfb24oKTsKKwogCW1kc191c2VyX2NsZWFyX2NwdV9idWZmZXJzKCk7CiB9
CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzMyLlMgYi9hcmNoL3g4Ni9lbnRy
eS9lbnRyeV8zMi5TCmluZGV4IGY4M2NhNWFhOGI3Ny4uYzcwM2MyOWJlYmIxIDEwMDY0NAotLS0g
YS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV8zMi5TCisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzMy
LlMKQEAgLTEwNjIsNyArMTA2Miw2IEBAIEVOVFJZKGVudHJ5X0lOVDgwXzMyKQogCVNUQUNLTEVB
S19FUkFTRQogCiByZXN0b3JlX2FsbDoKLQlUUkFDRV9JUlFTX0lSRVQKIAlTV0lUQ0hfVE9fRU5U
UllfU1RBQ0sKIC5McmVzdG9yZV9hbGxfbm90cmFjZToKIAlDSEVDS19BTkRfQVBQTFlfRVNQRklY
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TIGIvYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUwppbmRleCAzYWJhZTgwZDQ5MDIuLjA1NjQxOWEwZTc2ZiAxMDA2NDQKLS0tIGEv
YXJjaC94ODYvZW50cnkvZW50cnlfNjQuUworKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5T
CkBAIC0xNzIsOCArMTcyLDYgQEAgR0xPQkFMKGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFt
ZSkKIAltb3ZxCSVyc3AsICVyc2kKIAljYWxsCWRvX3N5c2NhbGxfNjQJCS8qIHJldHVybnMgd2l0
aCBJUlFzIGRpc2FibGVkICovCiAKLQlUUkFDRV9JUlFTX0lSRVRRCQkvKiB3ZSdyZSBhYm91dCB0
byBjaGFuZ2UgSUYgKi8KLQogCS8qCiAJICogVHJ5IHRvIHVzZSBTWVNSRVQgaW5zdGVhZCBvZiBJ
UkVUIGlmIHdlJ3JlIHJldHVybmluZyB0bwogCSAqIGEgY29tcGxldGVseSBjbGVhbiA2NC1iaXQg
dXNlcnNwYWNlIGNvbnRleHQuICBJZiB3ZSdyZSBub3QsCkBAIC02MTcsNyArNjE1LDYgQEAgcmV0
X2Zyb21faW50cjoKIC5McmV0aW50X3VzZXI6CiAJbW92CSVyc3AsJXJkaQogCWNhbGwJcHJlcGFy
ZV9leGl0X3RvX3VzZXJtb2RlCi0JVFJBQ0VfSVJRU19JUkVUUQogCiBHTE9CQUwoc3dhcGdzX3Jl
c3RvcmVfcmVnc19hbmRfcmV0dXJuX3RvX3VzZXJtb2RlKQogI2lmZGVmIENPTkZJR19ERUJVR19F
TlRSWQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjRfY29tcGF0LlMgYi9hcmNo
L3g4Ni9lbnRyeS9lbnRyeV82NF9jb21wYXQuUwppbmRleCA0MzVkZjYzN2YzOTIuLjM1MDJmMzhi
ZGUwMSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjRfY29tcGF0LlMKKysrIGIv
YXJjaC94ODYvZW50cnkvZW50cnlfNjRfY29tcGF0LlMKQEAgLTI1NCw3ICsyNTQsNiBAQCBzeXNy
ZXQzMl9mcm9tX3N5c3RlbV9jYWxsOgogCSAqIHN0YWNrLiBTbyBsZXQncyBlcmFzZSB0aGUgdGhy
ZWFkIHN0YWNrIHJpZ2h0IG5vdy4KIAkgKi8KIAlTVEFDS0xFQUtfRVJBU0UKLQlUUkFDRV9JUlFT
X09OCQkJLyogVXNlciBtb2RlIHRyYWNlcyBhcyBJUlFzIG9uLiAqLwogCW1vdnEJUkJYKCVyc3Ap
LCAlcmJ4CQkvKiBwdF9yZWdzLT5yYnggKi8KIAltb3ZxCVJCUCglcnNwKSwgJXJicAkJLyogcHRf
cmVncy0+cmJwICovCiAJbW92cQlFRkxBR1MoJXJzcCksICVyMTEJLyogcHRfcmVncy0+ZmxhZ3Mg
KGluIHIxMSkgKi8KQEAgLTM5Niw2ICszOTUsNSBAQCBFTlRSWShlbnRyeV9JTlQ4MF9jb21wYXQp
CiAuTHN5c2NhbGxfMzJfZG9uZToKIAogCS8qIEdvIGJhY2sgdG8gdXNlciBtb2RlLiAqLwotCVRS
QUNFX0lSUVNfT04KIAlqbXAJc3dhcGdzX3Jlc3RvcmVfcmVnc19hbmRfcmV0dXJuX3RvX3VzZXJt
b2RlCiBFTkQoZW50cnlfSU5UODBfY29tcGF0KQo=
--00000000000038b2b005959aa2c3--
