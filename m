Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12EC287C96
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJHTkz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 15:40:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6FC0613D2
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 12:40:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQbmL-001pV8-Ix; Thu, 08 Oct 2020 21:40:41 +0200
Message-ID: <43b15253faaaa96f5b874adbaf227d9927b00969.camel@sipsolutions.net>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application
 API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Date:   Thu, 08 Oct 2020 21:40:40 +0200
In-Reply-To: <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com> (sfid-20201008_210323_970294_4B316DB6)
References: <cover.1601960644.git.thehajime@gmail.com>
         <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
         <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
         <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com>
         (sfid-20201008_210323_970294_4B316DB6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-10-08 at 22:03 +0300, Octavian Purdila wrote:
> On Wed, Oct 7, 2020 at 10:05 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> > > @@ -0,0 +1,287 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > That doesn't really make sense - if you use LKL you're linking Linux, so
> > you can't use this "WITH Linux-syscall-note"?
> > 
> > > +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> > > +#define __UM_NOMMU_UAPI_SYSCALLS_H
> > 
> > [snip]
> > 
> > This file really worries me, it includes half the world and (re)defines
> > the other half ... How is this ever going to be maintained?
> > 
> 
> There are not that many definitions here, just the ones that were
> never defined in uapi headers. And, AFAIK, new code that exposes
> structures and data types should always go  into uapi headers and not
> directly in glibc, etc. So once we fix the old stuff, it should be
> fine?

Yeah, not really sure. Not all of this is really old stuff, e.g. keyring
things were here I noticed.

But since it's userspace API I guess the changes of it breaking are
fairly small anyway, so maybe I just shouldn't worry about it :)

johannes

