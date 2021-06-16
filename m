Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615E53AA5F0
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhFPVKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhFPVKb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 17:10:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F13C06175F
        for <linux-arch@vger.kernel.org>; Wed, 16 Jun 2021 14:08:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id n17so5776084ljg.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Jun 2021 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEgFwvG0aEYffAJwnwi/wSvP3mnzTq32F9Igb0VeJKo=;
        b=czhMl45rFwdrs0pcekybM2QQZCWZb/gXfUU/tObs7oUmAfWaFzGqU3ncQtuzzBoGEp
         6TNZuZHFOTzoLk3Kk4ftLDU0XygKDGA3j5horD9drSGEElyEC2cdjMrMkbWUZqNsOMEo
         d36CyJJhlk3IB7sj2YK9ivIRzIE0TuPNJ1Ugs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEgFwvG0aEYffAJwnwi/wSvP3mnzTq32F9Igb0VeJKo=;
        b=fITfnrs3oUNlpDBe7K4BGGhiJHDkJSw981K8ya6iNBUnat7G6XqaXNZ4UEeL9+hdKY
         c4QwXwgwMVCBQEBHpwE1/r101ZW93KZQ+HWYxVOz52byHs9ac7+D4ZNRkUpyMkuv95BO
         0G2nfOSNuI3fbdSbH2n2VXQP3DLR5TGf3TXrErz+jYgWJzqVV43yqlaFyrRHIFkCtlnH
         3B+lxvJdc2nAtZIqx2j6r2n2Cqdy/pZuKC7BOe4BVH8HKVmRLdbXRUxD/89dyBfn+gDj
         eQEqA044otqciZQJqB++q1CIRsEef0q0tyjC8L9kX6dQ9iotxCAshNsnifGeszBONr1B
         OXuw==
X-Gm-Message-State: AOAM532vVMsZlcjYYXj23MuCRXoCm4/bMpE/eNGYKD6mTuOTN6BnMgFo
        hneNKxvMo+xTGYVFOPe8tuLUR7adjocG4D1BvGc=
X-Google-Smtp-Source: ABdhPJwIiMMkb9DmHqbDSfYl9IhGbl1uPutxcg+MqB4CCs6ELhj4qrct8cePh6USJTm1YyTr8tbW7A==
X-Received: by 2002:a2e:87d6:: with SMTP id v22mr1622254ljj.50.1623877699966;
        Wed, 16 Jun 2021 14:08:19 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x4sm360796lfd.96.2021.06.16.14.08.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 14:08:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id x14so5723496ljp.7
        for <linux-arch@vger.kernel.org>; Wed, 16 Jun 2021 14:08:18 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1503699ljh.507.1623877698306;
 Wed, 16 Jun 2021 14:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133> <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133> <87k0mtek4n.fsf_-_@disp2133>
 <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
 <CAHk-=whvNaYffE8Eaa4-jjYbF_r1u1sh5LF5zXFhdEP8hxySMQ@mail.gmail.com> <878s398r4g.fsf@disp2133>
In-Reply-To: <878s398r4g.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jun 2021 14:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwqjetFoyPLehd0_qGbtmKHjibayFrdKC=g3FWYKzu4Q@mail.gmail.com>
Message-ID: <CAHk-=whwqjetFoyPLehd0_qGbtmKHjibayFrdKC=g3FWYKzu4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 1:57 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Do you know if struct switch_stack or pt_regs is ever exposeed to
> usespace?  They are both defined in arch/alpha/include/uapi/asm/ptrace.h
> which makes me think userspace must see those definitions somewhere.

Yeah, that uapi location is a bit unfortunate. It means that user
space _could_ have seen it.

Which probably means that some user space uses it. Not for any kernel
interfaces (the alpha ptrace register offsets are actually sane, and
we have that "regoff[]" array to find them) - but I could see some odd
program having decided to use the kernel pt_regs and switch_stack
structures for their own reasons.

Annoying. Because we don't really expose it as-is in any way, afaik.
Only incidentally - and by mistake - in a uapi header file.

Maybe a flag in thread_info->status (or even a new 32-bit field
entirely in thread_info) is the way to go like Al says.

            Linus
