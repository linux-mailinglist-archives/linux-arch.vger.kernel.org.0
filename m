Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023142BEFD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhJMLg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 13 Oct 2021 07:36:56 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhJMLgz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 07:36:55 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7zJj-1mnOSf2Yxn-0151eV; Wed, 13 Oct 2021 13:34:50 +0200
Received: by mail-wr1-f43.google.com with SMTP id m22so7456196wrb.0;
        Wed, 13 Oct 2021 04:34:50 -0700 (PDT)
X-Gm-Message-State: AOAM530JJTnCoKXLzarJsfmUUmoC+kyDEkbwMGqLyNRbKq/H2oBVjcA+
        mhT90RL6MaXQYKdsC0j2Mzqa9n7Iac0Z6xMPc6A=
X-Google-Smtp-Source: ABdhPJz/tQxa5v4qhwFE3sQu9avl5eu7/EDdEmltQMqmVp+Zjg8+ZW0kGehN4p6hG6cHdJWighfCnt4BmNvUupzN+ls=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr38988320wrc.71.1634124890085;
 Wed, 13 Oct 2021 04:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <c215b244a19a07327ec81bf99f3c5f89c68af7b4.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130002.A7C0A86@keescook> <c2904a2e-c112-f2bc-04a0-52b08b46c1ce@csgroup.eu>
In-Reply-To: <c2904a2e-c112-f2bc-04a0-52b08b46c1ce@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Oct 2021 13:34:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0G8zOD-DJVOxWWwHgGUWQC2yxgMMKYrBQTgVLAicC7pw@mail.gmail.com>
Message-ID: <CAK8P3a0G8zOD-DJVOxWWwHgGUWQC2yxgMMKYrBQTgVLAicC7pw@mail.gmail.com>
Subject: Re: [PATCH v1 06/10] asm-generic: Refactor dereference_[kernel]_function_descriptor()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:aKXdFfQHHJqa+PGJd0D0CX4GFyeR8Gs2iyTgOMSiqKrrS5DRfiG
 h1gsuMfiWWdOlkpHquK5Qmb3cl+a+79dUuZ0YE10HlcmyzTDdeY9V8vEW0zhYKirbm/FPoa
 vTPHLU2iGWRwCJP4NneTP4mcVH6iEWDchEqQVY8EjB1oQY/RlcAIGgXJM3fdz5gCIUmTOD2
 DgZoHBJ/HonekaByWqDxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mpUpj2+QhgA=:5zFFMUKPYHCBOM9HzxsjX0
 4ra+DlLJPIeAxBP4Ofuch9YCuO8j3PJ175e/jrXzlIeF3IJPo6miW1KwiXvo1Aj0Min2s5htD
 y5jRo41flZUbI7dqj+c/c310D+o2nlgQfiPQ+PEXbog25A1FW6ZaNT2wrsBZlBKRED9ji4xrs
 7gK/7+m1QRFq5rWUA6t9Mfk0CbKLyXBwoGhkPXb7cewHkmr6wkCbGNY30K/kSmbL6JhzrEAJf
 ezIgqRFmPvVqRGGKbX9+xZrPgSHifDLmPzk9Nc4RV8oy0XKx9PCtqA+FzEM1IW4KkFxYzW3oS
 DNWRWVRC65I+Cn2nQCUONwU4II6V7zDHU5n26r1K4lxlhdrbBgMDE8FjbEdOFVCKRpWltRbUa
 7CIFLJ46wmfHpSaxtJ0UX1orNU7pP9orF82mzPBPhCDHlQaY/PYMJDqp3olvTvj55buTQxmmA
 ZXpoNaDQ7qntFF2yHu91Fr4tjYV/v3Z56BsYLKgu9Aaapr2nm47xafc5mPKA2/J5TPySHoHF9
 dH4xkphaH2+VJ0to/FtYk4SmBKv4zPZOusKW0X07I1w9t3iikj2QudIK6lgkSqzfnB7MjK00E
 UIfeoQgm65BfUYDnaLQBtZynM7tdQx9Ql/cMnXkIeC8AGrfed1dwHUhy4sCh89z84A076iKi5
 QGdJMw9yyT37j9L95vWqEvEK2J7b+SDweRXrHgtdsNRi4luRdmz/w5AryzicjoGT2C3MWu2S1
 r13c2HlNpMAb1eHdYRRo8Kqt8qIgmS4yplcrHLF3JOmnkWp7Ea6szXivrFB1syWgtoxoTalEF
 zn5/nNM5jzSElRztbFDQsUrQNen91J3NrnhsZ8W5kPaDGegQFt2d6UXcj0Bscik7zXXVlyRao
 pcRCyKhh0lEnA//ie7pQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 1:20 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 13/10/2021 à 09:02, Kees Cook a écrit :
> > On Mon, Oct 11, 2021 at 05:25:33PM +0200, Christophe Leroy wrote:
> >> dereference_function_descriptor() and
> >> dereference_kernel_function_descriptor() are identical on the
> >> three architectures implementing them.
> >>
> >> Make it common.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   arch/ia64/include/asm/sections.h    | 19 -------------------
> >>   arch/parisc/include/asm/sections.h  |  9 ---------
> >>   arch/parisc/kernel/process.c        | 21 ---------------------
> >>   arch/powerpc/include/asm/sections.h | 23 -----------------------
> >>   include/asm-generic/sections.h      | 18 ++++++++++++++++++
> >>   5 files changed, 18 insertions(+), 72 deletions(-)
> >
> > A diffstat to love. :)
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Unless somebody minds, I will make them out of line as
> suggested by Helge in he's comment to patch 4.
>
> Allthough there is no spectacular size reduction, the functions
> are not worth being inlined as they are not used in critical pathes.

Sounds good to me.

      Arnd
