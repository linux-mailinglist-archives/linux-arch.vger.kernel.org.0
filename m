Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A315E2EF0A3
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAHK1v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 05:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbhAHK1v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 05:27:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC78723877;
        Fri,  8 Jan 2021 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610101630;
        bh=4OgbnSvctVLhU/7LubturoyjeIVJZ4jbeiL8igHvkv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sfZJeqfeGBDFQXQ9SkIg8MtPvhLG59xXRIHo/zLn61VrjCdOnPdkIsaj6MKTr7Ww8
         80tc/f0ZOLp/WzpN3zVWD3L21lzZ6z7Pb9njQYQNP6/q+BoqPTMsZFpJOiDaowmumQ
         FbonDANwKYtqspXPEVIu8L/jewm1oEfPf3yRHDlNaCX6TiQHqv8xVVizC3lAh8KaRs
         tcw9OHJEJHOxMgVjfwPM+8I8OS0jynCeawq/RU8ycHi310aE0mTu8sbffviKn7Y+pi
         zXHW4k7vUn3JWsbt59F70lxGhUqcqO2nrGkZLlzsDFQK1MLMWnkc+/sCDf4FMWT7fV
         Mm3AYeHyQOoIg==
Received: by mail-ot1-f50.google.com with SMTP id w3so9164935otp.13;
        Fri, 08 Jan 2021 02:27:10 -0800 (PST)
X-Gm-Message-State: AOAM530YRFmS3aOQ9TCVGYPhAYRifje97BalAWHNigbEufmVIBKNqSLW
        lTS8jMOcmF3ciwMGWQUuZEMR9MuKIS83VfV/4yk=
X-Google-Smtp-Source: ABdhPJyEOf9MPXLMKRT+nHHByN1XcNgFAvSzmuOqF972OUTjEWOI/6qYPa3pH1zZ9MXtSXWEQyjPaCEiZt2K5iOwlhE=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr2071633otr.210.1610101629962;
 Fri, 08 Jan 2021 02:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20210108092024.4034860-1-arnd@kernel.org> <20210108093258.GB4031@willie-the-truck>
In-Reply-To: <20210108093258.GB4031@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Jan 2021 11:26:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
Message-ID: <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com>
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 8, 2021 at 10:33 AM Will Deacon <will@kernel.org> wrote:
> On Fri, Jan 08, 2021 at 10:19:56AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > With UBSAN enabled and building with clang, there are occasionally
> > warnings like
> >
> > WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> > The function arch_atomic64_or() references
> > the variable __initdata numa_nodes_parsed.
> > This is often because arch_atomic64_or lacks a __initdata
> > annotation or the annotation of numa_nodes_parsed is wrong.
> >
> > for functions that end up not being inlined as intended but operating
> > on __initdata variables. Mark these as __always_inline, along with
> > the corresponding asm-generic wrappers.
>
> Hmm, I don't fully grok this. Why does it matter if a non '__init' function
> is called with a pointer to some '__initdata'? Or is the reference coming
> from somewhere else? (where?).

There are (at least) three ways for gcc to deal with a 'static inline'
function:

a) fully inline it as the __always_inline attribute does
b) not inline it at all, treating it as a regular static function
c) create a specialized version with different calling conventions

In this case, clang goes with option c when it notices that all
callers pass the same constant pointer. This means we have a
synthetic

static noinline long arch_atomic64_or(long i)
{
        return __lse_ll_sc_body(atomic64_fetch_or, i, &numa_nodes_parsed);
}

which is a few bytes shorter than option b as it saves a load in the
caller. This function definition however violates the kernel's rules
for section references, as the synthetic version is not marked __init.

      Arnd
