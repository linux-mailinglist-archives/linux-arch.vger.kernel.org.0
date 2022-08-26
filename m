Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CA5A304C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 22:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiHZUEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 16:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiHZUD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 16:03:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA267E97F4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:03:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so3337186edd.13
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ed72M6gjKE1csszbQngdfXNo2kUyihpXGg0Y+QCiXXY=;
        b=H54MhldHSwtdnVky1AK6bpcbibCENOFdm+UhkM4ltpNCKAt6u/QAx3LEqyHiSzh1XU
         9vYu4kmVcZNk/QUlsaspK/GCHVCedHWEEnZ1gd9kc7wTTJGkQkw9G4rCIQl+tl9rC0/c
         XWJAzpA7GZ4JCzxTG0Hr5X9Rm0a+4i126WPj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ed72M6gjKE1csszbQngdfXNo2kUyihpXGg0Y+QCiXXY=;
        b=YmLgNeuaKo1xJHAaBf8o+ta4CCgW/Scpq+93qeBr0P/JajUUKB0PGp2uiXAdP9S0jG
         HBC6XsWZ9O6EQdLuOmlfjG5+0mGhgdFDS8MfcAhX4pb5owZF5OsPy1yFjoFRa54yK9Ox
         h/BEyHH+NXuqoOflsSHknKNPxvc4ohHZoo/OKuLQvx/48185BE5SDiSd8PHODhQir9P+
         CjNRCstH4EtGyT7jFygGEpuIBBascLVIXD+fpjUfv2OTOQDY+hT0UrRHeBaIJ6zIF4vL
         ALbYDkr0ruXTZEWz2c00ftrNNZl/yc45VthHssD9RwR7Gm6pFW8m5y1OsFnYQNnL7wrf
         mF6Q==
X-Gm-Message-State: ACgBeo2+JAlcgOUnVEZdgbpEhLBcopbgUkmyF92j56cfDndWiGDtxNxh
        zfHvo2F4gYEPNpKtUGxJ94tW3LhN0Thmm9sJeSo=
X-Google-Smtp-Source: AA6agR6w58DZiRT415h1kKMAFDlGJuDkGubmW9dNbimfnHMhhDJ9KHljqEPCS8Qq8xoPF+tkvOGQYA==
X-Received: by 2002:a05:6402:190d:b0:447:ed22:4d0d with SMTP id e13-20020a056402190d00b00447ed224d0dmr3353436edz.309.1661544236121;
        Fri, 26 Aug 2022 13:03:56 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id s17-20020a50ab11000000b0043d1a9f6e4asm1806590edc.9.2022.08.26.13.03.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 13:03:54 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id d5so1376964wms.5
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:03:53 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr624015wme.8.1661544233102; Fri, 26 Aug
 2022 13:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
In-Reply-To: <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 13:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
Message-ID: <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
Subject: Re: [PATCH v3] wait_on_bit: add an acquire memory barrier
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cb216505e72a6970"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--000000000000cb216505e72a6970
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 26, 2022 at 12:23 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
>     include/asm-generic/bitops/non-instrumented-non-atomic.h:15:33:
> error: implicit declaration of function 'arch_test_bit_acquire'; did
> you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
>

Ahh. m68k isn't using any of the generic bitops headers.

*Most* architectures have that

   #include <asm-generic/bitops/non-atomic.h>

and get it that way, but while it's common, it's most definitely not universal:

  [torvalds@ryzen linux]$ git grep -L bitops/non-atomic.h
arch/*/include/asm/bitops.h
  arch/alpha/include/asm/bitops.h
  arch/hexagon/include/asm/bitops.h
  arch/ia64/include/asm/bitops.h
  arch/m68k/include/asm/bitops.h
  arch/s390/include/asm/bitops.h
  arch/sparc/include/asm/bitops.h
  arch/x86/include/asm/bitops.h

and of that list only x86 has the new arch_test_bit_acquire().

So I assume it's not just m68k, but also alpha, hexagon, ia64, s390
and sparc that have this issue (unless they maybe have some other path
that includes the gerneric ones, I didn't check).

This was actually why my original suggested patch used the
'generic-non-atomic.h' header for it, because that is actually
included regardless of any architecture headers directly from
<linux/bitops.h>.

And it never triggered for me that Mikulas' updated patch then had
this arch_test_bit_acquire() issue.

Something like the attached patch *MAY* fix it, but I really haven't
thought about it a lot, and it's pretty ugly. Maybe it would be better
to just add the

   #define arch_test_bit_acquire generic_test_bit_acquire

to the affected <asm/bitops.h> files instead, and then let those
architectures decide on their own that maybe they want to use their
own test_bit() function because it is _already_ an acquire one.

Mikulas?

Geert - any opinions on that "maybe the arch should just do that
#define itself"? I don't think it actually matters for m68k, you end
up with pretty much the same thing anyway, because
"smp_load_acquire()" is just a load anyway..

                 Linus

--000000000000cb216505e72a6970
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l7awiwdo0>
X-Attachment-Id: f_l7awiwdo0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5oIHwgMSArCiBpbmNsdWRlL2xpbnV4L2JpdG9w
cy5oICAgICAgICB8IDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iaXRvcHMuaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2JpdG9wcy5oCmluZGV4IDBmZTlkZTU4YWYzMS4uYjgyMDA2MTM4YzYwIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iaXRvcHMuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9iaXRvcHMuaApAQCAtMjQ2LDYgKzI0Niw3IEBAIGFyY2hfdGVzdF9iaXRfYWNxdWlyZSh1
bnNpZ25lZCBsb25nIG5yLCBjb25zdCB2b2xhdGlsZSB1bnNpZ25lZCBsb25nICphZGRyKQogCXJl
dHVybiBfX2J1aWx0aW5fY29uc3RhbnRfcChucikgPyBjb25zdGFudF90ZXN0X2JpdF9hY3F1aXJl
KG5yLCBhZGRyKSA6CiAJCQkJCSAgdmFyaWFibGVfdGVzdF9iaXQobnIsIGFkZHIpOwogfQorI2Rl
ZmluZSBhcmNoX3Rlc3RfYml0X2FjcXVpcmUgYXJjaF90ZXN0X2JpdF9hY3F1aXJlCiAKIC8qKgog
ICogX19mZnMgLSBmaW5kIGZpcnN0IHNldCBiaXQgaW4gd29yZApkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9iaXRvcHMuaCBiL2luY2x1ZGUvbGludXgvYml0b3BzLmgKaW5kZXggM2I4OWM2NGJj
ZmQ4Li5hMDQ2YjljNDVmZGIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYml0b3BzLmgKKysr
IGIvaW5jbHVkZS9saW51eC9iaXRvcHMuaApAQCAtNjcsNiArNjcsMTAgQEAgZXh0ZXJuIHVuc2ln
bmVkIGxvbmcgX19zd19od2VpZ2h0NjQoX191NjQgdyk7CiAgKi8KICNpbmNsdWRlIDxhc20vYml0
b3BzLmg+CiAKKyNpZm5kZWYgYXJjaF90ZXN0X2JpdF9hY3F1aXJlCisjZGVmaW5lIGFyY2hfdGVz
dF9iaXRfYWNxdWlyZSBnZW5lcmljX3Rlc3RfYml0X2FjcXVpcmUKKyNlbmRpZgorCiAvKiBDaGVj
ayB0aGF0IHRoZSBiaXRvcHMgcHJvdG90eXBlcyBhcmUgc2FuZSAqLwogI2RlZmluZSBfX2NoZWNr
X2JpdG9wX3ByKG5hbWUpCQkJCQkJXAogCXN0YXRpY19hc3NlcnQoX19zYW1lX3R5cGUoYXJjaF8j
I25hbWUsIGdlbmVyaWNfIyNuYW1lKSAmJglcCg==
--000000000000cb216505e72a6970--
