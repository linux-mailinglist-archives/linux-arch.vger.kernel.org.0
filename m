Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2F94904
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHSPsb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 11:48:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41409 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfHSPsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 11:48:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so1387890pfz.8
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZA8BuBvs/hbur5A2af1dfs7zv3Ei9mj0dJpknoIQZUk=;
        b=PZ0HD3Y2zeoBC2zq5xuE6l3mXjwan01XY4nhIVdOCwkGN+nwuKAXafYOLL1EcyeH6L
         guxT7lPZIguUFZz8+wh65JBURxJpLGAkfzG8A4uKNyblf1WUlIar4sSkLUZlLedc7l8b
         Kkifxp4sdWxzXyg1r6oIp0pGHz3JRXUbvzxL88zaZDD3rbw9QZOH2O8jylbRgCyFULyn
         wKS2Wl26+PuJ2MiEsDh0j3wJSSTGRF9csTjf/IM4s15buWx2GvmeIyTAk5en+TK7/LRz
         2LEWmnUgk8vMJCOoTOgvmeVN8Uy8gvIfiQNNMQg5e614Buy5U209kXTc52yI4yRoRBcD
         ip6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZA8BuBvs/hbur5A2af1dfs7zv3Ei9mj0dJpknoIQZUk=;
        b=MiEh3Z+WOXbBfjZopw0VX4eK7fUhrLQkSWWzryvPdvXfAIln0agAfDRA0MSKlkqLiZ
         IM1d/8FlPX09ran1idF7tPAt5h1bm0nbsOqUTcrDBW4AcY6dFriXsEK7UL0zkhdrQXya
         Iz8YcqwVt1z3h3M55fCc7IA9Xz9+r9JHexFCP283Ql9gW7LMaLaNJ3l1gakizSblNkpG
         SIiu/WI93JqYDL9MpQMpL/o4ARE2YXc5utp8N1TcObxma970NIavLmuTCnDZrTmhibyx
         0qzEfd2HnCF0s1rTFMlQor6G2yVYRc0cMm0iIodY8iF1YH0ysW+1d5kKhT9i9Jst2hN8
         S2vQ==
X-Gm-Message-State: APjAAAXgyLY9+h0i7l/B+2L/M6lMc2lapg6Irubh81kvDJMz89rlKLDr
        slvuPdbhMrklDsgixrLoQjtssU+juaxfwv1sghYS3A==
X-Google-Smtp-Source: APXvYqwo1Y//ODybWVzSFI9UN2sBOGCtICrz2FP1xF+itsQOS80vSVdDi/mfEKruFfUtKA1F2Hx+OmLOBRNDL+KKy/0=
X-Received: by 2002:a63:c442:: with SMTP id m2mr72019pgg.286.1566229708817;
 Mon, 19 Aug 2019 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815154403.16473-1-catalin.marinas@arm.com> <20190815154403.16473-6-catalin.marinas@arm.com>
In-Reply-To: <20190815154403.16473-6-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 17:48:17 +0200
Message-ID: <CAAeHK+xxsMkt=pU+ChfMYLQU4TqeL0c-f4PdN_KLG7sq6yKX2w@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] arm64: Relax Documentation/arm64/tagged-pointers.rst
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> (EL0) to perform memory accesses through 64-bit pointers with a non-zero
> top byte. However, such pointers were not allowed at the user-kernel
> syscall ABI boundary.
>
> With the Tagged Address ABI patchset, it is now possible to pass tagged
> pointers to the syscalls. Relax the requirements described in
> tagged-pointers.rst to be compliant with the behaviours guaranteed by
> the AArch64 Tagged Address ABI.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  Documentation/arm64/tagged-pointers.rst | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> index 2acdec3ebbeb..fd5306019e91 100644
> --- a/Documentation/arm64/tagged-pointers.rst
> +++ b/Documentation/arm64/tagged-pointers.rst
> @@ -20,7 +20,9 @@ Passing tagged addresses to the kernel
>  --------------------------------------
>
>  All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +an address tag of 0x00, unless the application enables the AArch64
> +Tagged Address ABI explicitly
> +(Documentation/arm64/tagged-address-abi.rst).
>
>  This includes, but is not limited to, addresses found in:
>
> @@ -33,13 +35,15 @@ This includes, but is not limited to, addresses found in:
>   - the frame pointer (x29) and frame records, e.g. when interpreting
>     them to generate a backtrace or call graph.
>
> -Using non-zero address tags in any of these locations may result in an
> -error code being returned, a (fatal) signal being raised, or other modes
> -of failure.
> +Using non-zero address tags in any of these locations when the
> +userspace application did not enable the AArch64 Tagged Address ABI may
> +result in an error code being returned, a (fatal) signal being raised,
> +or other modes of failure.
>
> -For these reasons, passing non-zero address tags to the kernel via
> -system calls is forbidden, and using a non-zero address tag for sp is
> -strongly discouraged.
> +For these reasons, when the AArch64 Tagged Address ABI is disabled,
> +passing non-zero address tags to the kernel via system calls is
> +forbidden, and using a non-zero address tag for sp is strongly
> +discouraged.
>
>  Programs maintaining a frame pointer and frame records that use non-zero
>  address tags may suffer impaired or inaccurate debug and profiling
> @@ -59,6 +63,11 @@ be preserved.
>  The architecture prevents the use of a tagged PC, so the upper byte will
>  be set to a sign-extension of bit 55 on exception return.
>
> +This behaviour is maintained when the AArch64 Tagged Address ABI is
> +enabled. In addition, with the exceptions above, the kernel will
> +preserve any non-zero tags passed by the user via syscalls and stored in
> +kernel data structures (e.g. set_robust_list(), sigaltstack()).
> +
>
>  Other considerations
>  --------------------
