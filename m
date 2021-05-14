Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1B380A14
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhENNE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 09:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhENNE6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 09:04:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F07B461457;
        Fri, 14 May 2021 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620997427;
        bh=KjRucVq9b2NKDaj10nQp3ecBtpjWikZo5h6VILTp9TQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovF/DZ6vdNyVMSH9t0zjMiEagYR721FRrBVU2xZxXX/OUhYjI4DoeKwouVrElnjNo
         H2LSDPkvaHREyrn1HyHd22hBkz3doo6H4OkJrDEXpJxqK/vktxIuA+Y7acAYuukBaa
         8O0eESoVXTaqfbi08ympBP0C9YMyag7kUEqEptmhtLOP4nWQVjNY971q4Zvmp63YMt
         FApG43bQoRmB4kFdndQzCDNsl0JV6NwuAMLOJTgNrK92jp4knsyOUt4/jlG789UKl4
         nQaqjm0JUA5D0nUp8/StBDRTX5A//K7DIJJsrFgQEHzMgV0l+g4iKzmuREdaMda1QZ
         5UKkdWqvLttRg==
Received: by mail-wr1-f51.google.com with SMTP id n2so30044378wrm.0;
        Fri, 14 May 2021 06:03:46 -0700 (PDT)
X-Gm-Message-State: AOAM530KCJZ25nhLNBkcuOGsrukBadGFOwRVs7o/kskMcnBcQNwdUi+J
        h0h3Qwac+7v5/Xe/g6Jn0wrMUz57wfFV2BMBHOI=
X-Google-Smtp-Source: ABdhPJzlvCIkpR1F+kgydYHRKzdkFDddvZpYrU9rVtIDsh8sEqa4UTJsy0hLf91X5lxvVhxcxulzbSr4KB+n1tMKazY=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr60213997wrz.105.1620997425625;
 Fri, 14 May 2021 06:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-6-arnd@kernel.org>
 <20210514114813.GJ10366@gate.crashing.org>
In-Reply-To: <20210514114813.GJ10366@gate.crashing.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 15:02:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04OZzSwV0039GiA0x=Kmp_mUvNz_CEyVFo8NJHTv2smg@mail.gmail.com>
Message-ID: <CAK8P3a04OZzSwV0039GiA0x=Kmp_mUvNz_CEyVFo8NJHTv2smg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] powerpc: use linux/unaligned/le_struct.h on LE power7
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 14, 2021 at 1:48 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Fri, May 14, 2021 at 12:00:53PM +0200, Arnd Bergmann wrote:
> > Little-endian POWER7 kernels disable
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS because that is not supported on
> > the hardware, but the kernel still uses direct load/store for explicti
> > get_unaligned()/put_unaligned().
> >
> > I assume this is a mistake that leads to power7 having to trap and fix
> > up all these unaligned accesses at a noticeable performance cost.
> >
> > The fix is completely trivial, just remove the file and use the
> > generic version that gets it right.
>
> LE p7 isn't supported (it requires special firmware), and no one uses it
> anymore, also not for development.  It was used for powerpc64le-linux
> development before p8 was widely available.

Ok, thanks for the clarification.

Should we just remove the Kconfig option for it then as further cleanup?
Is there any other code such as alignment trap handling that could be
removed if LE POWER7 gets dropped?

      Arnd
