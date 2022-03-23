Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901C44E55AF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiCWPzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiCWPzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 11:55:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7B13CE7;
        Wed, 23 Mar 2022 08:53:31 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MeTHG-1o7Ua61NkC-00aTAf; Wed, 23 Mar 2022 16:53:30 +0100
Received: by mail-wr1-f53.google.com with SMTP id t11so2749847wrm.5;
        Wed, 23 Mar 2022 08:53:30 -0700 (PDT)
X-Gm-Message-State: AOAM5334oCF9WPbqFjyvGyT5bM2RvS9gxZiCZU8mBPszgoCoFqsSLljL
        WI1dBUCQWQoP0/tgc1oC4jNGdvLdD+d81V41e20=
X-Google-Smtp-Source: ABdhPJwn2dk8wgYkeruvYA1iK2eNqfiEFWQUa6CXrBRFhlq1Swt9ujl43cMfPmB/Ci0z6qBzdxo5W+1Rz1oAMI22UqM=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr427762wrg.219.1648050809881; Wed, 23
 Mar 2022 08:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk> <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk> <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
In-Reply-To: <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Mar 2022 16:53:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
Message-ID: <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:COZgfK1VxxiYxTAoPRbuJEh3HPsg9nlpIoaJsVwet2BB8O9NTmy
 iC93M+wKS2KMGMbkvuC9ZqftbfZ91qtQzpd0C6grskgXTRGuH97YA17PK69pdYMG0zDCjBK
 tSU4jdMmxG4qaWrEdlv95bALHrFOJNK1h3llpTqV2+uupE5GS1NmS9BK39WCZpoU5g+TFm3
 dbDhGy/uOsNZu0vOibDAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ycrPdCsTbgI=:LXth86oMI97+avK5cluOCx
 I5HuEfEjfKrmaYc/pC5XZFWDAF9C17WIULmWQN9FPNXNfSlnGPmc7TAgZjsYUHnZ3dzYjmKCr
 G1vlX7Lg1XOZnL9ICKLL3vV4eYDfIDB3lCSYC1rT2xbMcVbiOnQDLbq8TUp42qMslsjlQhRdy
 L7xkXgStU3cfTb3dWq8CbJOV+yXtBf2StXHvFyEpB3gKw+nPGHoqAACJTpapKFEkr95F+4dHP
 G8T/1G9bkxaYGG/jM/UKMXf9iMLcCOZGEC1/SrFirYvUqrdX+NY4x2z1chplub7sGzpdCIr8N
 bkZcUUPjXzv4IwIjmG2XqczDZSkONyAGCyKVNYR7CiY2PTdLdi/c21APj7kEmnr9IW4VGORu3
 kYvA4xLEfjKoaVhFQ4LROrEWOiYpruKP8EkSDpy1j0meJ5Xjrfjy1Yl/PmedfPVeVx5H55zNK
 Y9pS3H6rQ/urqx+eR1RtU/TKeG+D+6EJBr8kDLrBaWw2gpCZO4kouaWPIaAhdhKS/zjb3cu2w
 ew0igcL4xBSO5GN4+VPiFLEPnFT9FZxtF9UX7kBZA0YV2xFOSkN3GmNLYwYGdugSjNYe3K+N5
 3Uvjy/idCaXMMBbExf7srXCqoG0XYeyuHYv9Y0xLlNIDao0TsY0zcfGaTBaUX/M5/KHe1mpbA
 q1IQPbMpkn9fgNF0EMMBcWa09CLx2d0qGRHsnKzETWYLcnp7xQPF/YFE3qUKzEB/hDmN7/4XI
 x25/fWB21MdFIrF7hd1ecUjwDyoew1LQlFmcOhbrj/uuuczLF6QOiP/1ylJRu0Yu7mI36wGaP
 iXH+XsRDMFwaQ6Pjt4hAaKzxo/wCxVHWUGhB7Av+X+jr/S4IGw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 23, 2022 at 3:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/23/22 05:10, Mark Brown wrote:
> > On Tue, Mar 22, 2022 at 02:54:20PM -0700, Guenter Roeck wrote:
> > Kind of academic given that Jason seems to have a handle on what the
> > issues are but for KernelCI it's variations on mach-virt, plus
> > versatile-pb.  There's a physical cubietruck as well, and BeagleBone
> > Blacks among others.  My best guess would be systems with low RAM are
> > somehow more prone to issues.
>
> I don't think it is entirely academic. versatile-pb fails for me;
> if it doesn't fail at KernelCI, I'd like to understand why - not to
> fix it in my test environment, but to make sure that I _don't_ fix it.
> After all, it _is_ a regression. Even if that regression is triggered
> by bad (for a given definition of "bad") userspace code, it is still
> a regression.

Maybe kernelci has a virtio-rng device assigned to the machine
and you don't? That would clearly avoid the issue here.

        Arnd
