Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19125283D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHZHPA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 03:15:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZHO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 03:14:59 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mk0a0-1kvBwf1TTs-00kRea; Wed, 26 Aug 2020 09:14:57 +0200
Received: by mail-qt1-f179.google.com with SMTP id 92so718948qtb.6;
        Wed, 26 Aug 2020 00:14:56 -0700 (PDT)
X-Gm-Message-State: AOAM532NZ91CydDDFgF41edtRYot+cE0wnTAgd3Y3/XaQn75w/CnIHtT
        twhhN+OsckwUc6veJjV+2eqjMFd0Yt9uKLRZqQ8=
X-Google-Smtp-Source: ABdhPJwLuGjkmlnft754xbUklzGWtHhgTglHwx7onxQfpdw4FEOyMnyaABTTrq89Agj1YnTZDmfbHPSjkpJNT1I0q7s=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr12988809qtq.7.1598426095918;
 Wed, 26 Aug 2020 00:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-6-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1hDBVembCd+6=ENUWYFz=72JBTFMrKYZ2aFd+_Q04F+g@mail.gmail.com> <MW2PR2101MB105201EF9EB186AA9BF31A74D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB105201EF9EB186AA9BF31A74D7570@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Aug 2020 09:14:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0bCf7Fe5Ex=AHUM49UuvNk0KEpXJ3jgWmULa2eDOWBKA@mail.gmail.com>
Message-ID: <CAK8P3a0bCf7Fe5Ex=AHUM49UuvNk0KEpXJ3jgWmULa2eDOWBKA@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] arm64: hyperv: Add interrupt handlers for VMbus
 and stimer
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CfQNSp9K2Sdd2RppPCh70mApHLnySRUQtQTPs+NNnr5FwrxVCng
 AGs3F+IWIItB3FT7rCqPXYb5XyGGoFDhSK+bnnEr60dbVKDCRHARjKlBpi9MGbX9vXdpJbU
 azeTOu7yxAaAs+27q0YE9uN75kTAtAWNeCuEW0hI9gtCn99zyIo1UbdlbrW44jnbuGDBVXK
 MznMJZzDDYN2Qs5DfuJng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xO0XMxW3dlA=:vjc8OvsMhX2drfQa3Dri8w
 oq47fIAjowurvD4ZZkt++2rnBezU79/Rzrl2CPXjVZ3RvhKchD4luPVKF0RsuCsaVJ6LQva0q
 FMy/z3NyQyst0i9tHN/MfHjMpU9mf1VBQTa7RmkhfUXTQpMuo1uP7j7itn3rCJE7ixmqjoSBy
 SNAGr8zxtJBQoorgvrwsjYaX0FVytV6ZQBlETXDbi3+qvQKDg+gYXlulRd9niBZ+pn5rlRgG0
 wLjz8LpwEjE1UqKkJX8X9sVaHsSURyNOe78N+KO7fwZjTY/o9UJSzHMZlYovb/eNEBE5LveLp
 +/n+C8IrI4FUR9Da86VkJSRKqTXynBnI1Rd6nLJ6Y6iJjbSFL3FssDtesh8y3osxThKWsiESz
 O5NpdHIhQx8YrMovHWylmbB/Iizpaj51h+RTcmYFNFcO4dwZ97+oRTTAKx80+kTPqMtueaqqa
 a4joAYmuzbQ9/0ZTfbEHecvdeXYS0Qs7k/ejk9em39qknATRFaEK4wfFvRoHUYVEpHby/p/Eq
 zNnYZ7z1KGc2Ti9bJCG6UFLhwQa0VvtYi4A/1qkwDECB3MjvpGKjmSwSbHztJVYnIk9sNQxXm
 Kzw5m5i40W0U8wwsHJUm3a1Q20GNdof1knYfMX77zXRJ4GMtaC2dUSnhaEFej7+YLdOrsEDK0
 +AbCRXHPoN/phSj6191B5V+/jUIxsXPmeD5SyMl4/l17XfjJYWw9KGZglpFmqTdf6JsDD4v1x
 YF9JL2OX7YX0nrJCDXmpF7mJVdihvVHe6fVmAFhTAJCbAO/ew/KCOtQ8Rh1vF5vmTzrxNfOyR
 5OIftf6uZV5xVzlzAgOG5KJ5w8zn9McySso6Gi1tWQSTXJyaykpM+Gie0fGL2fKLPQ1HlJC
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 12:04 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, August 24, 2020 11:54 AM

> >
> > I'm not sure what the correct solution should be, but what I'd try to
> > do here is to move every function that just considers the platform
> > rather than the architecture somewhere into drivers/hv where it
> > can be linked into the same modules as the existing files when
> > building for arm64, while trying to keep architecture specific code
> > in the header file where it can be included from those modules.
>
> OK.  The concept of separating platform from architecture makes
> sense to me.  The original separation of the Hyper-V code into
> architecture independent portions and x86-specific portions could
> use some tweaking now that we're dealing with n=2 architectures.  With
> that tweaking, I can reduce the amount of Hyper-V code under arch/x86
> and under arch/arm64.
>
> On the flip side, the Hyper-V implementation on x86 and ARM64 has
> differences that are semi-related to the architecture.  For example, on
> x86 Hyper-V uses synthetic MSRs for a lot of guest-hypervisor setup, while
> hypercalls are required on ARM64.  So I'm assuming those differences
> will end up in code under arch/x86 and arch/arm64.

Yes, that absolutely makes sense.

> Arguably, I could introduce a level of indirection (such as
> CONFIG_HYPERV_USE_MSRS vs.
> CONFIG_HYPERV_USE_HYPERCALLS) to distinguish the two behaviors.
> The selection would be tied to the architecture, and then code in
> drivers/hv can #ifdef the two cases.  But I wonder if getting code out of
> arch/x86 and arch/arm64 is worth that additional messiness.

No, I think that would take it a little too far, and conflicts with the
generic rule that code under drivers/* should be written to be portable
even if can only run on a particular target platform.

> Looking at the Xen code in drivers/xen, it looks like a lot of the Xen functionality
> is implemented in hypercalls that can be consistent across architectures,
> though I was a bit surprised to see a dozen or so instances of #ifdef CONFIG_X86.
> Xen also #ifdefs on PV vs. PVHVM, which may handle some architecture
> differences implicitly.  But I'm assuming that doing #ifdef <architecture>
> in the Hyper-V code in order to reduce code under arch/x86 or arch/arm64
> is not the right way to go.

In general that is true, adding a lot of #ifdefs makes code less readable and
harder to test. OTOH there are cases where a single #ifdef can be useful when
it avoids adding a larger amount of complexity elsewhere. Many subsystems
try to restrict the #ifdef checks to header files while keeping the
drivers/* code
free of them.

       Arnd
