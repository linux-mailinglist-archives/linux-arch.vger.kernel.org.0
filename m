Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275FD1E583F
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1HLx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HLw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 03:11:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E1C05BD1E;
        Thu, 28 May 2020 00:11:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so5675130ejr.9;
        Thu, 28 May 2020 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=16DIrmRA1E1JnL9soIzFZEu2gqgGZH7RX+KOOjHexd0=;
        b=Hk98kg66914RxtIc5J3bFwPiLx5SZgO2Jetwyp4qg3R43GKFn1BNXce3HpdBLRTjir
         2oYUFHOhUsf5Oe9YC4tUUohIG1SYyrZOr9GMlowRq0RcQ16KKpkdKalPLHuarT6WNXUw
         NfZALsBj3b1EP7xmtg9cNa9hO3Ucq7gI5uObgeA+WFJRE53QOLNIlLF6MFbDDtD//h30
         ixCyF03HF+6KXHFU4VgoKviVd3E0RQPkMssEFp+1SQwDyxa/J8j9gH7uAqqIrxIg5+fZ
         +aKZEem2DQT/Z9aJpIWb83OId/FloBL8f7m/KBiDnUFt8KAShZWDlvhpGzfDP0VfwYHq
         663g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=16DIrmRA1E1JnL9soIzFZEu2gqgGZH7RX+KOOjHexd0=;
        b=hTV89YiVHpyjcTr6h70rM9cgv6UlJykAwrQOiZo/7fvk3o7RHFf5xHU1D/lXIugnjr
         iN23l5IdNp8WBlljCZoV0Lwfg/Bt1L+RD07+WR+c8qNzPtYOVT/oHsw4dbmu8+A4g3A2
         0x5kbUlgj1IuPQTwAgfY4HUpJikIUjeX6Nl8B2aEs0pz9yLGndgUorm4ck4rjUgAqt8x
         Z367rYZUfu4n3zEmT6r5el1KFELmn8oLGXmDyjme1qCDz3AJ6W+5p2Id5aQPUiCxkO/3
         aO3jTtGnIXXDTAVBcp3e+Ses7/cY7kDu9FIwh/Q2MR+lqjsWKMhDjP616z4HbQaCOdMl
         oXZw==
X-Gm-Message-State: AOAM530Ms+QYRqnlyecEHWhFr/KalezIUB3AdFYKsAjsg+f95JHGbA+O
        Db4sn55+as5P9nH+lTj/qwoU5bTNHC4SIq6pdYk=
X-Google-Smtp-Source: ABdhPJzq9SmQSN0CtkdmJ2bqv3wLw2c+pM+QFBXLaM0M7eNHWJLkA9cXACQ1aCEEF/5xwXliqATOMilfHMSFjb9kpGs=
X-Received: by 2002:a17:906:51b:: with SMTP id j27mr1639266eja.246.1590649910884;
 Thu, 28 May 2020 00:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 28 May 2020 09:11:40 +0200
Message-ID: <CAKgNAkhHzrNHjpRAKo_cU7+0-OGP9eyvmdA=AD3OgvVDq8vjcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] prctl.2 man page updates for Linux 5.6
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave

On Wed, 27 May 2020 at 23:17, Dave Martin <Dave.Martin@arm.com> wrote:
>
> A bunch of updates to the prctl(2) man page to fill in missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> fixes).
>
> Patches from the v1 series [1] that have been applied or rejected
> already have been dropped.
>
> People not Cc'd on the whole series can find the whole series at
> https://lore.kernel.org/linux-man/ .
>
> Patches:
>
>  * Patch 1 is a new (but trivial) formatting fix, unrelated to the new
>    prctls.

Applied.

>  * Patches 2-3 relate to the speculation control prctls.  These are
>    unmodified from v1, but need review.

Applied, and pushed (since there were no review comments from last version).

>  * Patches 4-5 relate to the arm64 prctls from v1, with reviewer
>    feedback incorporated.  (See notes in the patches.)

I'll hold off on these patches, to see if review comments come in.

>  * Patch 6 is *draft* wording for the arm64 address tagging prctls.
>    The semantics of address tagging is particularly slippery, so
>    this needs discussion before merging.

Okay -- I'll hold off with that patch too.

Cheers,

Michael

> [1] https://lore.kernel.org/linux-man/29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com/T/#t
>
>
> Dave Martin (6):
>   prctl.2: ffix use literal hyphens when referencing kernel docs
>   prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
>   prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
>   prctl.2: Add SVE prctls (arm64)
>   prctl.2: Add PR_PAC_RESET_KEYS (arm64)
>   prctl.2: Add tagged address ABI control prctls (arm64)
>
>  man2/prctl.2 | 444 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 435 insertions(+), 9 deletions(-)
>
> --
> 2.1.4
>


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
