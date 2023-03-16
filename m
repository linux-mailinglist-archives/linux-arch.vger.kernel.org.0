Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABBD6BD936
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCPTa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCPTa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 15:30:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD2E1CA6
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 12:30:52 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y5so3233244ybu.3
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678995051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQinqcAul9N1/k6Qm0xi6TTExDZScG0p56fu1+mj3E8=;
        b=aZUr5Hc3SSnInpRHn4QQapVy8DLcSf4/Fsji81ynnnbmxFUbqyycyen3xS68rzw2cJ
         csdHHzPzn1pP4Rqhq8/jlqA8dQLTAnyjBWcvBZHm6/pvneaCtKF11X0NKVPFJ6Lwuk5o
         72RVceBABLTBI+tJn+l9lpq3yxow6PgeoozRTUpTU2xzCTSQilljxyWqtox7dKLQwmVh
         Mt7eATOZlaYVhW8nPozAkwkhKitbs3qSfS0zDDfCSHkn4bHon39z2LN2WrpJHFl7bH+u
         01CLGuTfkqCSiQaPZ34ZVbtLD9fLHpC87CEEjOYCcl/1TmRK/ccg1mJnufuIL2N997aO
         uUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQinqcAul9N1/k6Qm0xi6TTExDZScG0p56fu1+mj3E8=;
        b=nwGRSxU61VUdTtYi1i4Mrw0B80YD/qin9e+fZ3fsIhLX5/ADdST0DVc+z3M9hlA5Lh
         6QPOLBO4/6MOrh+NmPKSz3BbPNe0+8qfk5s2CXgp9/gKkI31sG4ydZPrJ79mXgL0V7aF
         fFV3C0zfbzrHIZgE0IsbjoX6qUGPbDUgbtLRAF+oWTQ+AQuCo0d8E1RjSgWCkN107+JJ
         03nQIPoZLJCluMCIqVdgS85dUaqYWdJf3VtAqpvDUE1peXzMa/bwlI9lPkVoNZTguvVp
         +KM/CoYyVlgbleDsnaVnCio1Bm8gM7503hGMUy62fhrkKEkwGhKVitdpyQghL3UPB1Sg
         dZhg==
X-Gm-Message-State: AO0yUKW6aKrJREKjER4os8ta3wg6pRSoCkBzySqafcyhWSstqqd+NAi2
        gPmGXFfL6TgOvAbmHFZzVwMLy4a8idvtFJqPFnUmUA==
X-Google-Smtp-Source: AK7set8XMy0ufUxFXEARzyZfU02oLy+VwPbPQAYSeIVhzA2hlPaXVJJxn8QbOjY2tiSVxh7zXiHiE5Y10vOoOFYvORc=
X-Received: by 2002:a25:f507:0:b0:b3b:6576:b22b with SMTP id
 a7-20020a25f507000000b00b3b6576b22bmr10524766ybe.12.1678995051579; Thu, 16
 Mar 2023 12:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com> <ZADbP7HvyPHuwUY9@arm.com>
 <20230309185511.GA1964069@debug.ba.rivosinc.com> <ZBAf/QI42hcVQ4Uq@kernel.org>
In-Reply-To: <ZBAf/QI42hcVQ4Uq@kernel.org>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 16 Mar 2023 12:30:40 -0700
Message-ID: <CAKC1njTP2WAnkh3vaNGGaeOCa_uArNAatVOXxie+chR2mhA89w@mail.gmail.com>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, nd@arm.com, al.grant@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 12:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> Hi,
>
> On Thu, Mar 09, 2023 at 10:55:11AM -0800, Deepak Gupta wrote:
> > On Thu, Mar 02, 2023 at 05:22:07PM +0000, Szabolcs Nagy wrote:
> > > The 02/27/2023 14:29, Rick Edgecombe wrote:
> > > > Previously, a new PROT_SHADOW_STACK was attempted,
> > > ...
> > > > So rather than repurpose two existing syscalls (mmap, madvise) that=
 don't
> > > > quite fit, just implement a new map_shadow_stack syscall to allow
> > > > userspace to map and setup new shadow stacks in one step. While uco=
ntext
> > > > is the primary motivator, userspace may have other unforeseen reaso=
ns to
> > > > setup it's own shadow stacks using the WRSS instruction. Towards th=
is
> > > > provide a flag so that stacks can be optionally setup securely for =
the
> > > > common case of ucontext without enabling WRSS. Or potentially have =
the
> > > > kernel set up the shadow stack in some new way.
> > > ...
> > > > The following example demonstrates how to create a new shadow stack=
 with
> > > > map_shadow_stack:
> > > > void *shstk =3D map_shadow_stack(addr, stack_size, SHADOW_STACK_SET=
_TOKEN);
> > >
> > > i think
> > >
> > > mmap(addr, size, PROT_READ, MAP_ANON|MAP_SHADOW_STACK, -1, 0);
> > >
> > > could do the same with less disruption to users (new syscalls
> > > are harder to deal with than new flags). it would do the
> > > guard page and initial token setup too (there is no flag for
> > > it but could be squeezed in).
> >
> > Discussion on this topic in v6
> > https://lore.kernel.org/all/20230223000340.GB945966@debug.ba.rivosinc.c=
om/
> >
> > Again I know earlier CET patches had protection flag and somehow due to=
 pushback
> > on mailing list, it was adopted to go for special syscall because no on=
e else
> > had shadow stack.
> >
> > Seeing a response from Szabolcs, I am assuming arm4 would also want to =
follow
> > using mmap to manufacture shadow stack. For reference RFC patches for r=
isc-v shadow stack,
> > use a new protection flag =3D PROT_SHADOWSTACK.
> > https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.co=
m/
> >
> > I know earlier discussion had been that we let this go and do a re-fact=
or later as other
> > arch support trickle in. But as I thought more on this and I think it m=
ay just be
> > messy from user mode point of view as well to have cognition of two dif=
ferent ways of
> > creating shadow stack. One would be special syscall (in current libc) a=
nd another `mmap`
> > (whenever future re-factor happens)
> >
> > If it's not too late, it would be more wise to take `mmap`
> > approach rather than special `syscall` approach.
>
> I disagree.
>
> Having shadow stack flags for mmap() adds unnecessary complexity to the
> core-mm, while having a dedicated syscall hides all the details in the
> architecture specific code.

Again reiterating it would've made sense if only x86 had a shadow stack.
aarch64 announced support for guarded stack. risc-v spec is in
development to support shadow stack.

So there will be shadow stack related flow in these arches.

>
> Another reason to use a dedicated system call allows for better
> extensibility if/when we'd need to update the way shadow stack VMA is
> created.

I see two valid points here
    - Shadow stack doesn't need conversion into different memory types
(which is usually the case for address ranges created by mmap)
      So there is a static page permissions on shadow stack which is
not mutable.

    - Future feature addition (if there is one needed) at the time of
shadow stack creation
      It would avoid future tax on mmap

I'll think more about this.

>
> As for the userspace convenience, it is anyway required to add special
> code for creating the shadow stack and it wouldn't matter if that code
> would use mmap(NEW_FLAG) or map_shadow_stack().

Yes *strictly* from userspace convenience, it doesn't matter which option.

>
> > > most of the mmap features need not be available (EINVAL) when
> > > MAP_SHADOW_STACK is specified.
> > >
> > > the main drawback is running out of mmap flags so extension
> > > is limited. (but the new syscall has limitations too).
>
> --
> Sincerely yours,
> Mike.
