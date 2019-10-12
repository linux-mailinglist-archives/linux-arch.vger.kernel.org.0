Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18B1D4EF3
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2019 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfJLKVN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Oct 2019 06:21:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:50579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJLKVM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 12 Oct 2019 06:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570875346;
        bh=9yiK8dnG219CaruOwHyidlZwNGKUyzDo3y7vSy6Xm+w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SSmm4n4E1YOoH8/09Mupot5T4KQ1hfoUjsgffqCF3wlIgLO86ZFn73VjpMVF2ad67
         nsPAGCMbilg9NTSfZgyWmhCPlAntHDrrseTJc2bjHAz3mp1mbTK1+HQn+QjI2MB9f3
         EgR/79TeswaxeCGF7GoWy4DHgFPIU/nG7jBtXKGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1if2Xb0z9l-00MHaq; Sat, 12
 Oct 2019 12:15:46 +0200
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <20191003163606.iqzcxvghaw7hdqb5@willie-the-truck>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <35643c7e-94e9-e410-543b-a7de17b59a32@gmx.net>
Date:   Sat, 12 Oct 2019 12:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003163606.iqzcxvghaw7hdqb5@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:iNPi0emfRc2oUZROqqK4veOxMGlI1mxOV8QIg+mTL89EDO4EH7+
 2lPiQqrhfyLQf3Vg7Nx2BonaDOVup6w6ynu05PFl4ZaypAEedCbmvWH/e0gaOPDqtB12rE0
 scCifOpESngb1/ghKnIoQ7qmU2S/fCwI+DV8bqUvbiMV16JH+HdFb3Y8KCPac6jdrjFKUTi
 aEhBSH51ecKaJn9oRDSDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k56ojK+HK+c=:YYXDWCMArLbvl8rkdSZUww
 WtwdjpbVTUDvlbauF1Ko5ax54EYeXpCCRe8EnFxoqi4CTf1qr3s9HOHCefpTHbVM0U3e0u9Bf
 N/NU9bWQRQ9Y2UXYRMIQWjxyQ8lufkwLXFY0Qctmgki1Ny/vq0yIkxShaVTfG5e+nI2qWflu6
 vwYRgpEKmaimaVFsxMpU8TyicQ/76uEZGrzrjUjWZXC4wHZd3gFhy8eP1kw4EntelfFhfq/1n
 br/iee9F1orhdfett6o5Wv1THxAGooETIiP8G1rym12bxQpwHRD3XfOaapM9sM8S2Id20oGTB
 16XCzYlTDA0vXtOZMVE3HKhRF8S5JREWpQTkii7T8SSb4kncgMmniLrN+LNyztdgB5cPOutnK
 NRFOjCNMugrVZKsC3cjeIxYbnu50uDMd2EA+29aIxP8uDQLvOc1i7Gahk7Pe8+bEMCAUtIN7T
 buSOb4UUr1O4Uo+3iTcwaAJw7b+ZZOyP+c4MTFAn4+CFQnoVvlsoHWUV/1BnxhwECaM6zKMyJ
 QdN1KdC2HvTuuqHjDB2DcobfuZhIi9yYdLkEyDTtLz6s2gSzGHpkOkq/5ujaxORmoh2fdDX26
 2r4EsIpiDOc2Iyshkh7vxzM+doOmvkJAU+rEptQ7a7uFbN88t6Y8oQdgn/6nsLH+C72mhs4Iu
 lAW6wbo7lx2KqHKNP3TDcHKjP3KSbtLr5wMoxu95lXC8MbpMSPSoUJN1CgtDc7HESOO7pRTB2
 xRMiVKOyUuQqmkL3kTE/DJa/sP28g3rOUwa8v2PJuvuh+wnMGM3jwzVjsvprZ9qUhqiSBq8YD
 0wsVe1v9qbssm3fBWgmeyf1Ese1dW5YmweRvd3XPGDqFj3goRik6QC7/VPuutzfbDIYEkU4xy
 nmAbeZ7FwSsECvwW9H0NBm7Ik6wM9/ZtMLDBiCKASznS/KIT97qAbWoZv3WVKU9GoccNd89tH
 1zESTaBj0UB+WRJZdxZfqHbTlD8z68iiimkgUUUyj4DPFZEzWTcT6Nefjvra8PKVCAh0ypU+T
 xfoLP/ysPrnL69qkVBK0D1FkMVqLgB8RZIDRN4j0wXdjS3oLj0Nh6+psRA9NW/XUBoo7f8k54
 DLECtGLWTFBTDUgqSNYwbgK22G+x6jrPmzxVEWl3shvusvQ3p+wLgEoE7Q9N40xJo4Z5FBv/5
 Lx/jJBMkpP8cGQEkXNjIHNI0XvRCSzAGA37GVTeeoQ/lu3OZ0sfm38qQsIBPAuUpdtv6H8bNF
 EGNi1EQC/OJXevzquoGPEByZ7wqgOXccV+P2DmJibaBVDBof5bLfdIP8dsfE=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Am 03.10.19 um 18:36 schrieb Will Deacon:
> On Wed, Oct 02, 2019 at 01:39:40PM -0700, Linus Torvalds wrote:
>> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> Then use the C preprocessor to force the inlining.  I'm sorry it's not
>>>> as pretty as static inline functions.
>>> Which makes us lose the baby^H^H^H^Htype checking performed
>>> on function parameters, requiring to add more ugly checks.
>> I'm 100% agreed on this.
>>
>> If the inline change is being pushed by people who say "you should
>> have used macros instead if you wanted inlining", then I will just
>> revert that stupid commit that is causing problems.
>>
>> No, the preprocessor is not the answer.
>>
>> That said, code that relies on inlining for _correctness_ should use
>> "__always_inline" and possibly even have a comment about why.
>>
>> But I am considering just undoing commit 9012d011660e ("compiler:
>> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
>> advantages are questionable, and when the advantages are balanced
>> against actual regressions and the arguments are "use macros", that
>> just shows how badly thought out this was.
> It's clear that opinions are divided on this issue, but you can add
> an enthusiastic:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> if you go ahead with the revert. I'm all for allowing the compiler to
> make its own inlining decisions, but not when the potential for
> miscompilation isn't fully understood and the proposed alternatives turn
> the source into an unreadable mess. Perhaps we can do something different
> for 5.5 (arch opt-in? clang only? invert the logic? work to move functions
> over to __always_inline /before/ flipping the CONFIG option? ...?)

what's the status on this?

In need to prepare my pull requests for 5.5 and all recent kernelci
targets (including linux-next) with bcm2835_defconfig are still broken.

Stefan

>
> Will
