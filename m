Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA72B4B89
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgKPQoS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 11:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbgKPQoR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Nov 2020 11:44:17 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F59620E65;
        Mon, 16 Nov 2020 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545057;
        bh=yTrjFuAFKEPr9WXf5xuld1Qh5lzQFn9zg5l6OTYrWDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hhlvp98N6Y3zPHsB3OMhCFT1OIkTLJWhoLxSsVIpfbXOEQN1DT3+73+LRAYCQMPvi
         RyEGr3IruZKcarP8LLcekaGl/rjQSYjdN8QuVwT4w3xUgwbd97MkLViqRM86lXtbsi
         d8Gynz+6/9mH3Gax6dntcJxXVcPdspJHyRUf2UaY=
Received: by mail-oo1-f52.google.com with SMTP id l20so4044905oot.3;
        Mon, 16 Nov 2020 08:44:17 -0800 (PST)
X-Gm-Message-State: AOAM5307bwApZRdv5e5k1m123Ne+udn4UI5amdXFuaxGGYA1jhzU7T9+
        gmLoxOHXU/s/9IB3IEw0451hzR8SV/draBKjTGQ=
X-Google-Smtp-Source: ABdhPJzcI0iU/kQZ6feELKQXs2iwC3Ud05OCSxkBb+ndz5nnaCz+I4BxAgPXoeidAIuJVCuFG/jhuPtisEOx6ED7VdM=
X-Received: by 2002:a4a:7055:: with SMTP id b21mr175385oof.66.1605545056474;
 Mon, 16 Nov 2020 08:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20201112215657.GA4539@charmander> <20201116162311.GA15585@infradead.org>
In-Reply-To: <20201116162311.GA15585@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 16 Nov 2020 17:44:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2JyaGj2GJXYac-hURK1Z54D6cnU4qYZmV3L4pVLifBLA@mail.gmail.com>
Message-ID: <CAK8P3a2JyaGj2GJXYac-hURK1Z54D6cnU4qYZmV3L4pVLifBLA@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Fix file comments for syscalls implemented in kernel/sys.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tal Zussman <tz2294@columbia.edu>, Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 16, 2020 at 5:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Nov 12, 2020 at 04:56:57PM -0500, Tal Zussman wrote:
> > The relevant syscalls were previously moved from kernel/timer.c to kernel/sys.c,
> > but the comments weren't updated to reflect this change.
> >
> > Fixing these comments messes up the alphabetical ordering of syscalls by
> > filename. This could be fixed by merging the two groups of kernel/sys.c syscalls,
> > but that would require reordering the syscalls and renumbering them to maintain
> > the numerical order in unistd.h.
>
> Lots of overly long lines in your commit log.
>
> As for the patch itself:  IMHO we should just remove the comments
> about the files as that information is completely irrelevant.

I noticed I already applied the patch last week to the asm-generic cleanups
branch, but forgot to send out the email about it.

I do agree the file names are rather useless, and I would apply a follow-up
patch to completely remove them as well. My real plan was to remove
the file itself and replace it with the parsable syscall.tbl format that we
use for all non-generic architectures, but I haven't gotten around to updating
the patch that Firoz Khan did a long time ago.

      arnd
