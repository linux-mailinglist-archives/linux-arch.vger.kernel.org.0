Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602E57E8F6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGVVjZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiGVVjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 17:39:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB0B878A
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 14:39:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so8186148wrm.0
        for <linux-arch@vger.kernel.org>; Fri, 22 Jul 2022 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FxcKHw+KeNRqCkk5qROt/9GMubXJxUVMHKA1De+QJz8=;
        b=P4rzv0+8JfcWUKy1JivKJYMUetypR5ZiNXPA/6TSTJ0YOhLtsMWwVXnQAHjl5ygmW9
         dSBVgFFBSsuonWbdOk8Ky+8qccZi6wfbk6zGgOEGk0PVttqaVNlAyBadARwj1Y//JgTT
         wL6bVCh2M0D2piZA9vHUlRbbhnt5btt+pxUjCwafnt83Hj6JsO3UAIXiah1okFR8mkjn
         XW3LXj5OrIDz9y0dGYXXNmg2sdZwG8rkxjOyqFkSkwPRULwu5FrrylKP4IeJIMyTOz30
         OH0e6tl4+7ksBnlFP1VAGBJQezXleYMqd17bvJr97uuUoAOxjo7DEfiyq52KAf/qLNWt
         Shew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FxcKHw+KeNRqCkk5qROt/9GMubXJxUVMHKA1De+QJz8=;
        b=SNv2EcuwqBtMEU2k1xBadMJXTZsmD2kWFwHNq5sN/7Cqbsq9D/r4epe4dpo2Evf9b1
         6R8SLEvJ9Go37qtYdnBoHvBDe7iNoxjV3GRJCQ+I0QfKE2XfjCOHB9jRhRRzmLFCR/gK
         1Z50A05tzewHsfpfguTrS2CfIpcv9pAGBZDxRX27C/r7tGGRsETf/BtlfDOY/AWqgNNA
         tJF8cGVX13vrkuZjEG4GfMY4i6VHyX1vIZS0PP1qWsJ20uTjA9itmX0Ymxh9ezLs40VI
         6t8YUiHk5L5v+YpPq6gabNkF5v13u/sd5NWm1NquzhvZnG53FB9sRnf/yuKMyIJTC5kd
         UNow==
X-Gm-Message-State: AJIora/pWjdaUI+6f1LyHrBjA2RLzzhoTJLG31QyXEcaGewBfm0qUNGM
        n13q0pDBxUzqcyCAeA5ewSEu/pNlz0qdpg==
X-Google-Smtp-Source: AGRyM1tPVIVZfV6qM8vhMpTbxX0oe2mvWjKidKhJrKbIkCzM/uzQTakUQbNW/CotdHpNthpStjOk6Q==
X-Received: by 2002:a5d:6285:0:b0:21e:6554:5e31 with SMTP id k5-20020a5d6285000000b0021e65545e31mr1109911wru.21.1658525959500;
        Fri, 22 Jul 2022 14:39:19 -0700 (PDT)
Received: from smtpclient.apple (global-5-142.n-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b003a2d6c623f3sm10104785wmb.19.2022.07.22.14.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:39:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
Date:   Fri, 22 Jul 2022 22:39:18 +0100
Cc:     Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41B9AC54-DCFE-4055-B950-265B3CBDD842@jrtc27.com>
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
 <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
 <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22 Jul 2022, at 20:55, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Fri, Jul 22, 2022 at 6:36 PM Rob Herring <robh@kernel.org> wrote:
>> On Fri, Jul 22, 2022 at 9:27 AM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>>=20
>> =46rom fu740:
>>                       ranges =3D <0x81000000  0x0 0x60080000  0x0
>> 0x60080000 0x0 0x10000>,      /* I/O */
> ...
>> So again, how does one get a 0 address handed out when that's not =
even
>> a valid region according to DT? Is there some legacy stuff that
>> ignores the bridge windows?
>=20
> The PCI-side port number 0x60080000 gets turned into Linux I/O =
resource 0,
> which I think is what __pci_assign_resource operates on.
>=20
> The other question is why the platform would want to configure the
> PCI bus to have a PCI I/O space window of size 0x10000 at the address
> it's mapped into, rather than putting it at address zero. Is this a =
hardware
> bug, a bootloader bug, or just badly set up in the DT?
>=20
> Putting the PCI address of the I/O space window at port 0 is usually
> better because it works with PCI devices and drivers that assume that
> port numbers are below 0xfffff, and makes the PCI port number match
> the Linux port number.

Possibly related is the (harmless) warning spew seen during boot on
FreeBSD. The bridge, and all downstream ones, reset to having I/O
window 0x0-0xfff and memory/prefetch window 0x0-0xfffff (which FreeBSD
tries to allocate, fails because that=E2=80=99s outside the valid ranges =
above,
so it then just paves over with a sane fresh config). Linux resets the
controller on probe so this is the initial state when enumerating, and
perhaps that=E2=80=99s not handled so gracefully as on FreeBSD (which =
also
resets in device_attach, the second half of what Linux calls probe)?

Jess

