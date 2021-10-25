Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980943A80A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhJYXS1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhJYXS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 19:18:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37882C061745
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:16:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w23so11318299lje.7
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N57vRJe+Hp19ptzSp75ybyre1XzyfFA16SmQOsxj3tA=;
        b=UgKxLMhT870ySRwwioSjbGbqOTOBYQ47GNWCxDiXZMwTTJf9VDBTR8W+864dN8KcsO
         Z6fdPCVuLRfJK898kYlNziu6kubhhOKZSFSL88QzpLnCMRPDxMXRPb5TuftXYw1AbTu/
         dNmRTderTGCnZEoMbOtKWZ1IZbBj7mM1zoEus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N57vRJe+Hp19ptzSp75ybyre1XzyfFA16SmQOsxj3tA=;
        b=Nj0y0fc8RrCdJHimLiU9b9G7R4jiiQNnyKWFbpbnr0NWEOxfauXRKARjs9RY7x3Oa8
         o8MpcsBHFTttwOCNC5YBfey2uF/XUOdmCuV+oUZycUZuLaOPIGsPxLrG7HVZICYWawu5
         YXbXPNNNvKopOO5xgcMbP655u3sq444WYM/puuf4qJbNkXX9fyef9o5Iew4GwhIcOii+
         aujM1Ej26241GYP657DooekJp/KXOVOSDiwp2saYb5yanNlLoIATb2yh6cPV0QZZUCGD
         zj8C5QKVRFzzHP5+OeqZyXJJMxLBx5AEzya1hHnU2ppHXlqS31wITWfhFvSsTO9VvPLj
         vGqQ==
X-Gm-Message-State: AOAM530AD7Ok5g4yhaHbQYT7eu2hc7Fw5onT1WUsqP1srb2l3n6Tq7PH
        ip2parT0Yg3bBj1ocvBbsIXMKrUpKYnjykMp
X-Google-Smtp-Source: ABdhPJyJolMiH/82pKdBm4WUCewbdoMWUWujNL2I1ycGyUKjAUIKII0iL+qCK/elrtxnzWwhN7tJVQ==
X-Received: by 2002:a2e:87da:: with SMTP id v26mr21852871ljj.187.1635203762117;
        Mon, 25 Oct 2021 16:16:02 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w28sm1845275ljm.31.2021.10.25.16.16.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:16:01 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id o26so16340083ljj.2
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 16:16:00 -0700 (PDT)
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr21991313ljf.95.1635203760541;
 Mon, 25 Oct 2021 16:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-13-ebiederm@xmission.com>
 <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com> <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
In-Reply-To: <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 16:15:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Message-ID: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 25, 2021 at 3:41 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I'm rather nervous about all this, and I'm also nervous about the
> existing code.  A quick skim is finding plenty of code paths that assume
> force_sigsegv (or a do_exit that this series touches) are genuinely
> unrecoverable.

I was going to say "what are you talking about", because clearly Eric
kept it all fatal.

But then looked at that patch a bit more before I claimed you were wrong.

And yeah, Eric's force_fatal_sig() is completely broken.

It claims to force a fatal signal, but doesn't actually do that at
all, and is completely misnamed.

It just uses "force_sig_info_to_task()", which still allows user space
to catch signals - so it's not "fatal" in the least. It only punches
through SIG_IGN and blocked signals.

So yeah, that's broken.

I do still think that that could the behavior we possibly want for
that "can't write updated vm86 state back" situation, but for
something that is called "fatal", it really needs to be fatal.

            Linus
