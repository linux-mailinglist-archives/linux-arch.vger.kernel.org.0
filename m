Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033AE7DFAC0
	for <lists+linux-arch@lfdr.de>; Thu,  2 Nov 2023 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjKBTQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Nov 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKBTQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Nov 2023 15:16:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F3188;
        Thu,  2 Nov 2023 12:15:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so17709521fa.2;
        Thu, 02 Nov 2023 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698952556; x=1699557356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3MeH+a0DrC/4MSfqzgybKcXcv9B3ln9THEIkzaMlLc=;
        b=LBKcJpqq4HqpL1OD4n0uKn/XE/zkB4gAlGzUshlRnOsEotVRdHxRtMN+Zbnzrc3cE0
         Z6SODboX1vrnCKzxymR3+OXf8u3qihETy4NIHiK4A17KG3UwpRuhVkVYCnvlXRAnbhi6
         20fEcwybHg8/nEu25KSVh+nB4GnZ410wumTGB7q0L1r9l+pdzGV9p83QitG+EluqcCeq
         99Ppv0LHwpfc0TJxjLRgYbOdbgomp7rWyP+finHvDBFSoPK+43PntYf1B1VUubAKKYuu
         uUxFqncS/2v5JuMLmjuM7K+1x7dUE43Dw0nLVtlQ2QvNNUaMqzBo+Np3xRPObXly88Rr
         3bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952556; x=1699557356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3MeH+a0DrC/4MSfqzgybKcXcv9B3ln9THEIkzaMlLc=;
        b=CIBKyPaoCXxR5WFqofdHx5Cg8bpycCA477QZypXDSVuKhzSskzsgSaH5fGYdTXGSoY
         TgE4hL4LC6yFXzffJVQI17LC0kYMGWo8tcKPW1k42F6FDWtKqM58HxDX0HPEoCDnShYM
         KBeYyIuqERDPoZrVOXf8MpcqvA61Ue58rfTLsNhmpu4XYPeV7faywTBkBXw4KroLGkZA
         tRK0YlFgXRvSCxUQydNSofCwUZvUZdgIet/gktYYVRS3TS40qhpp0969xM9xIVIq5ZKU
         lxbstquB7lM01nRBZEAcDOM4TWXsz6OfqnkFJHKSmJTGLoEBRBtAO7MnOZXGl1tS1L7k
         N8GA==
X-Gm-Message-State: AOJu0YwZ0M6TEmzcCtrdsoRfn+G3Vvwn+JcAHxOf9eqqwfjhvTX/x539
        EZUANQ/KgXNIYkGUZQwZfpNStaFi3yRaqZp1c02SqulXRW29SQ==
X-Google-Smtp-Source: AGHT+IFpEYbUfIIxmIhqgepfP9vlAQtzFsfkmTg0+mNG7stwit/X1FZkFc6mvCXyE9emOv9er43aPxkLkU18S6DZzKc=
X-Received: by 2002:a2e:8548:0:b0:2c0:a0c:be7 with SMTP id u8-20020a2e8548000000b002c00a0c0be7mr14741680ljj.8.1698952555187;
 Thu, 02 Nov 2023 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <340fc037-c18f-417f-8aaa-9cf88c9052f4@app.fastmail.com>
 <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de> <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
In-Reply-To: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
From:   =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
Date:   Thu, 2 Nov 2023 20:15:43 +0100
Message-ID: <CAHtyXDekSghk0wOwNz7_PG9xC+9+-wr4VTYN-uMVShh9UcxE3w@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for v6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Scheiner <frank.scheiner@web.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

=C4=8Dt 2. 11. 2023 v 18:29 odes=C3=ADlatel Linus Torvalds
<torvalds@linux-foundation.org> napsal:
>
> Well, I'd have personally been willing to resurrect it, but I was told
> several times that other projects were basically just waiting for the
> kernel support to die.
>

That's understandable, thank you for clarifying that. I was wondering
why Itanium and not Alpha, PA-RISC etc., this seems to give a clue to
that.

>
> The thing is, nobody doing new kernel code wants to deal with itanium,
> so relegating it to the same situation that i386 support was ("it
> still works in old kernels") doesn't seem to be a huge issue for the
> people who actually want to use those machines.
>
> That said, I'd be willing to resurrect itanium support, even though I
> personally despise the architecture with a passion for being
> fundamentally based on faulty design premises, and an implementation
> based on politics rather than good technical design.
>
> But only if it turns out to actually have some long-term active
> interest (ie I'd compare it to the situation with m68k etc - clearly
> dead architectures that we still support despite them being not
> relevant - because some people care and they don't cause pain).
>
> So I'd be willing to come back to the "can we resurrect it"
> discussion, but not immediately - more along the lines of a "look,
> we've been maintaining it out of tree for a year, the other
> infrastructure is still alive, there is no impact on the rest of the
> kernel, can we please try again"?

I agree with Adrian, that sounds very reasonable to me. If we want
Itanium to stay in kernel and it is a burden to other developers, it
is fair that we take the burden on us for the time being even if it
means overhead from maintaning an out-of-tree patch. For reference, I
already created a fork:
https://github.com/lenticularis39/linux-ia64/tree/master-revert-ia64-remova=
l
and will try to maintain it building and working.

Also, I will see whether it is feasible to maintain it out-of-tree in
the following months, and if I manage to do so, I will have a much
better argument on why I should maintain it in-tree than my previous
"Hi, I heard you are deleting Itanium. I have only one unrelated
two-line commit in the kernel but I have a machine and will try to
maintain it, please don't remove it" post
(https://lore.kernel.org/linux-ia64/CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFe=
Dpyjv7_PHNXw@mail.gmail.com/).
As I'm also a maintainer of the T2 SDE distribution, I will keep
building and testing it as part of it (there is even an enthusiast in
our community who runs Itanium Linux daily for some tasks).

I will revisit the topic here in case the effort succeeds for a longer
amount of time.

Tomas
