Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A431B2E11
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDURQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 13:16:33 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35891 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDURQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 13:16:32 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03LHG71K010304;
        Wed, 22 Apr 2020 02:16:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03LHG71K010304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587489368;
        bh=IgiQbLhvCUBxKqCE7UmgItuuumLvDvmzuHEcHVbFEls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b+4jMCsdznJH3vStPiwldLMLImsvoNID/TZJ4ZFMyTMEP4+p3Zojs1KVC6s6osaOa
         jgCTojoWZyBpRgB00jnYkYgUqLFd3eYXmDTCaA8zvpRFgxWHmYle50Tjd7cVoyF1ZL
         K8OfH6LtuaFZZPeKEvD66txezcDZUJQDfHlmgA5sJHSbLlr8S1/EmMx76SSrtoVd1E
         D6NXs4T070S44lUHc/3Yam6KCJUTWh42R5QW04fVbFcV+3fimKTei4LrhhIhRB9A8o
         m4rhf9fWLteVB0ALzaJasD9Tow+rG6WP2kNKIkkfxZcNOubjUdbMJUTM4kQVWb50o5
         Vais8fcJfiJvQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id s11so1739046vsq.13;
        Tue, 21 Apr 2020 10:16:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuZy66DO9JIJoycSu5o/t0YmU4frwD5yx4WQNsMM0GpDuPQYooCM
        R2ia2shuwrAt0A1bG5xfxkG+lPD2gExMrgLQzEA=
X-Google-Smtp-Source: APiQypLWGcgZN/cwb3DeBbd+IQr1tghqqhn39cN/PdMUqLN0wUc8AwEk1OsH6BtXM0UpG2aei8p+sOnayGJuIAeHkZ4=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr13571780vso.215.1587489366486;
 Tue, 21 Apr 2020 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-2-will@kernel.org>
In-Reply-To: <20200421151537.19241-2-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 02:15:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyFAusdcsvZxOjB7vAtj7G2w6b-bWd7dJjXUoEKm=LcA@mail.gmail.com>
Message-ID: <CAK7LNATyFAusdcsvZxOjB7vAtj7G2w6b-bWd7dJjXUoEKm=LcA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 12:15 AM Will Deacon <will@kernel.org> wrote:
>
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also know to have codegen

"know" -> "known"


> issues which can lead to silent miscompilation:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> Raise the minimum GCC version for kernel build to 4.8 and remove some
> tautological Kconfig dependencies as a consequence.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>


Maybe you can also clean up mm/migrate.c
because GCC_VERSION >= 40700 is always met.
It is up to you if you want to send v5.

Please replace CC with
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Thank you!

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---


-- 
Best Regards
Masahiro Yamada
