Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417BD31D725
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBQJy0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 04:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhBQJyX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 04:54:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4828464E4D;
        Wed, 17 Feb 2021 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613555622;
        bh=CgXcHKRXVYWgDN5c1aovy77k1sIjrNo4aZnzk8WhiT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YKaji88WGO9BFl3vOG1I0wjGNtd0di4z0oQep8ecPaJ0JMt3gtebwTUr8WiCFnunA
         awpjd/8BgZ23ziJZEGsgxbafjglafDR0f4WjxvtuI+lOsBP7zS8/PSslihD/MXF3nt
         m5D/rVSMcoE/7Cmm/ejwsRHTV4G6Uzig7STAT6xWaY8mCzjmIHKSfSlqKaFFpRRJTN
         P9yVicllYajRvchbzuc0w5o4tEsHyepCsOPhXPWqgeRcATeSLHKsytfjCeMLdA7qDc
         Cf7mxGjoOM8Qg6xuorf2fZNAFqC+IBJ+iG9KrVYyRp9VwC9xIj2/uF32EvM1c9e688
         Cb3XnJ7cfjtqg==
Received: by mail-ot1-f49.google.com with SMTP id b8so6882113oti.7;
        Wed, 17 Feb 2021 01:53:42 -0800 (PST)
X-Gm-Message-State: AOAM532ZVLcOwJUCxrxhVJ74m27hQ8Z4Pl+lLJq5GlMgvu4XqatFzTlr
        T2shY7SbhHyDHSqURFypdiFL3l7z6RZ/mcX9/l8=
X-Google-Smtp-Source: ABdhPJyAwX1ht2yJsPiM0RRWhFBxpQtYScwps8LtrDmJX+rnOJQC3FM2JzdKQsLVQ5QzdSqBazft+Kpaw/9EAQU5iG0=
X-Received: by 2002:a05:6830:13ce:: with SMTP id e14mr16736073otq.108.1613555621320;
 Wed, 17 Feb 2021 01:53:41 -0800 (PST)
MIME-Version: 1.0
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org> <20210217094205.GA3570@willie-the-truck>
In-Reply-To: <20210217094205.GA3570@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Feb 2021 10:53:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG_qj0A5r+rRnGdcwjomqJUSQPw6aNYyPbSVA8Fr=RjyA@mail.gmail.com>
Message-ID: <CAMj1kXG_qj0A5r+rRnGdcwjomqJUSQPw6aNYyPbSVA8Fr=RjyA@mail.gmail.com>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate page
To:     Will Deacon <will@kernel.org>
Cc:     Preeti Nagar <pnagar@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, casey@schaufler-ca.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>, ojeda@kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        nmardana@codeaurora.org, rkavati@codeaurora.org,
        vsekhar@codeaurora.org, mreichar@codeaurora.org, johan@kernel.org,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 17 Feb 2021 at 10:42, Will Deacon <will@kernel.org> wrote:
>
> [Please include arm64 and kvm folks for threads involving the stage-2 MMU]
>
> On Tue, Feb 16, 2021 at 03:47:52PM +0530, Preeti Nagar wrote:
> > The changes introduce a new security feature, RunTime Integrity Check
> > (RTIC), designed to protect Linux Kernel at runtime. The motivation
> > behind these changes is:
> > 1. The system protection offered by Security Enhancements(SE) for
> > Android relies on the assumption of kernel integrity. If the kernel
> > itself is compromised (by a perhaps as yet unknown future vulnerability),
> > SE for Android security mechanisms could potentially be disabled and
> > rendered ineffective.
> > 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
> > checks to each stage of the boot-up process, to assert the authenticity
> > of all secure software images that the device executes.  However, due to
> > various vulnerabilities in SW modules, the integrity of the system can be
> > compromised at any time after device boot-up, leading to un-authorized
> > SW executing.
> >
> > The feature's idea is to move some sensitive kernel structures to a
> > separate page and monitor further any unauthorized changes to these,
> > from higher Exception Levels using stage 2 MMU. Moving these to a
> > different page will help avoid getting page faults from un-related data.
> > The mechanism we have been working on removes the write permissions for
> > HLOS in the stage 2 page tables for the regions to be monitored, such
> > that any modification attempts to these will lead to faults being
> > generated and handled by handlers. If the protected assets are moved to
> > a separate page, faults will be generated corresponding to change attempts
> > to these assets only. If not moved to a separate page, write attempts to
> > un-related data present on the monitored pages will also be generated.
> >
> > Using this feature, some sensitive variables of the kernel which are
> > initialized after init or are updated rarely can also be protected from
> > simple overwrites and attacks trying to modify these.
>
> Although I really like the idea of using stage-2 to protect the kernel, I
> think the approach you outline here is deeply flawed. Identifying "sensitive
> variables" of the kernel to protect is subjective and doesn't scale.
> Furthermore, the triaging of what constitues a valid access is notably
> absent from your description and is assumedly implemented in an opaque blob
> at EL2.
>
> I think a better approach would be along the lines of:
>
>   1. Introduce the protection at stage-1 (like we already have for mapping
>      e.g. the kernel text R/O)
>
>   2. Implement the handlers in the kernel, so the heuristics are clear.
>
>   3. Extend this to involve KVM, so that the host can manage its own
>      stage-2 to firm-up the stage-1 protections.
>

Agree here. Making an arbitrary set of data structures r/o behind the
OS's back doesn't seem like an easy thing to maintain or reason about,
especially if this r/o-ness is only enforced on a tiny subset of
devices. If something needs to be writable only at boot, we have
__ro_after_init, and having hypervisor assisted enforcement of /that/
might be a worthwhile thing to consider, including perhaps ways to do
controlled patching of this region at runtime.

> I also think we should avoid tying this to specific data structures.
> Rather, we should introduce a mechanism to make arbitrary data read-only.
>
> I've CC'd Ard and Marc, as I think they've both been thinking about this
> sort of thing recently as well.
>
> Will
