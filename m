Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9AB492628
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiARMz6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 07:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiARMz6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2022 07:55:58 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C72C061574
        for <linux-arch@vger.kernel.org>; Tue, 18 Jan 2022 04:55:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h23so13885090pgk.11
        for <linux-arch@vger.kernel.org>; Tue, 18 Jan 2022 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hNhXZA5+gowIUg/TCF0bWEAltSYx0IpHpX6BM2FGyA=;
        b=LR/FMzc2017XQgd2GEQHJP+ixx/SzD1/mV230Rsk2z6fb83Q1fOpVJZ1VRapxM9c5Q
         lk+HQEmgB+BysdozzjlQ26kc6FtI0PsbwhMNfQ5dQN3FbCDkTk4gUbo2YIzm7OWTbhU/
         MDkozlvY6DCA6iD6tUkumdNFLQFNeQlQ9/2f6HqENq25panJlUQEXxAwjJYN1CHx8KIw
         +f8/DOaNo+/EUuEjCscUWWAN2JlOk4SReLXvledSNN1YXu/XmWoQYB+m+cXuivWSlOiT
         hmyiGHhGVEzLX1H/0HiOgOQn6TOUKc8SSAQHr+n8E0oZi/nI+G7UG4z0kk5ql6i/HY5Q
         95Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hNhXZA5+gowIUg/TCF0bWEAltSYx0IpHpX6BM2FGyA=;
        b=lNS6Kq3b2qeuxS3R3+odNohPKWRAl2d/g44EQKG4Klhm7VJH9ThRCueeU3sM1DSkHF
         Bv6GNpdWBQiejXgEfNqaiTBxXOJHwpC2XGiOK13NoOZAXGHZ9dfMYn/orDui49IKnpeY
         LK6CAeBNGOr1j2aJb2s1TR1STVR6yD1IFaxp9t3x8Ti191HkKox3ZlWPOaQ1poO6jImE
         JfeE1zl4GCQbJoZIFX5wtYEBStZjzbKO0/YJjQRvfbtiX6rPdY1kvt0+e4lVKEdoSFLH
         2lsAnhXU/rxPSBLEVeMYhRfERNGUN2ZlvAOuktq2tXHLizjgd7hwQFH+MZy6KQB/ud0q
         1H5w==
X-Gm-Message-State: AOAM530jB37JsZMzTt+d/ar/G5weFiJ+jOBaMRtcTAsCNZLPQHHEA8gW
        kJiCFWEtG3CtlNFt59lAUK9qftuS1esxPt+OmE0=
X-Google-Smtp-Source: ABdhPJz+OYijyklInJ82gnAdPX5DHjvhR2QrfrN7RuDnJY/PqiDw/jSALB9OPjCLQOBw/o5hciY44JoBECkNxHmGb14=
X-Received: by 2002:a63:b24e:: with SMTP id t14mr23265462pgo.381.1642510557302;
 Tue, 18 Jan 2022 04:55:57 -0800 (PST)
MIME-Version: 1.0
References: <YdSEkt72V1oeVx5E@sirena.org.uk> <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com> <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com> <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com> <YeWtRk0H30q38eM8@arm.com> <20ae043b-a013-068d-2d83-16e63f5b4989@linaro.org>
 <CAMe9rOo5zWO1BwZGhqGdWuCjsq86YUo4ptqXkFVNSwXbU+ZS-Q@mail.gmail.com> <20220118112211.GD3294453@arm.com>
In-Reply-To: <20220118112211.GD3294453@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 18 Jan 2022 04:55:21 -0800
Message-ID: <CAMe9rOoY5itEcPQs+ejX=aowkEA8ZSYwJzS7ZqEnSMnaneq6hg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 18, 2022 at 3:22 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 01/17/2022 11:01, H.J. Lu via Libc-alpha wrote:
> > We are taking a different approach for CET enabling.   CET will be
> > changed to be enabled from user space:
> >
> > https://gitlab.com/x86-glibc/glibc/-/tree/users/hjl/cet/enable
> >
> > and the CET kernel no longer enables CET automatically:
> >
> > https://github.com/hjl-tools/linux/tree/hjl/cet%2F5.16.0-v4
>
> we considered userspace handling of BTI in static exe
> and ld.so too. at the time we wanted the protection to
> be on whenever BTI marked code is executed, so it has
> to be enabled at program entry.
>
> i no longer think that the entry code protection is very
> important, but delaying mprotect for static exe does
> not fix our mprotect(*|PROT_EXEC) problem with systemd.
>
> i also don't immediately see where you deal with shadow
> stack allocation for the main stack if it is userspace
> enabled, i expected that to require kernel assistance
> if you want the main stack protected all the way up.

We enable shadow stack in user space as soon as possible:

https://gitlab.com/x86-glibc/glibc/-/commit/211abce607a9f6e4cd1cadefb87561413dd8fae9

-- 
H.J.
