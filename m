Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD97287C94
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgJHTjb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJHTjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 15:39:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90971C0613D2
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 12:39:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQbl1-001pSU-OB; Thu, 08 Oct 2020 21:39:19 +0200
Message-ID: <38aee48aceda961fa7418b42f3f2055b8799cf9b.camel@sipsolutions.net>
Subject: Re: [RFC v7 11/21] um: nommu: kernel thread support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Date:   Thu, 08 Oct 2020 21:39:18 +0200
In-Reply-To: <CAMoF9u3n-FyumX0S7vbjN-e+fWNe6k8aLeR-_BVJa7sR7qcFHg@mail.gmail.com> (sfid-20201008_205441_262054_E9F47409)
References: <cover.1601960644.git.thehajime@gmail.com>
         <ff2087f4983a2b93abef0a4ad31c1309f71ea52d.1601960644.git.thehajime@gmail.com>
         <295bff3f6ddc941dbf3933e8e310ad641da3ce01.camel@sipsolutions.net>
         <CAMoF9u3n-FyumX0S7vbjN-e+fWNe6k8aLeR-_BVJa7sR7qcFHg@mail.gmail.com>
         (sfid-20201008_205441_262054_E9F47409)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-10-08 at 21:54 +0300, Octavian Purdila wrote:
> On Wed, Oct 7, 2020 at 9:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > nommu mode does not support user processes
> > 
> > I find this really confusing. I'm not sure why you ended up calling this
> > "nommu mode", but there *are* (still) (other) nommu arches, and they
> > *do* support userspace processes.
> > 
> > Isn't this really just "LKL mode" or something like that?
> > 
> 
> This is a very good point, while some other patches make sense in the
> nommu mode, this one does not - it is rather needed because of the
> "library mode".
> 
> Not sure what we can do other than creating a new "library mode" in
> addition to the "nommu mode". Any suggestions?

Well there's no "nommu mode" in UML other than what you're doing here,
so as I said on some other patch, it sort of makes sense to have "LKL ==
NOMMU", but the equation doesn't make sense everywhere, since it's not
fundamentally NOMMU that drives the need for things (like here no
userspace, elsewhere the ifdefs, etc.), but LKL-mode.

So I don't think it would be *in addition* to "nommu mode" since such a
thing doesn't exist on UML (only on other architectures), but mostly be
a rename of "nommu mode" to "lkl mode" or so?

Don't really have any other suggestions, or maybe I'm not understanding
your question right.

> > IOW, why isn't this just
> > 
> > void lkl_sem_free(struct lkl_sem *sem);
> > void lkl_sem_up(struct lkl_sem *sem);
> > ...
> > 
> > and then posix-host.c just includes the header file and implements those
> > functions?
> > 
> > I don't see any reason for this to be allowed to have multiple variants
> > linked and then picking them at runtime?
> > 
> 
> We could try that and see how it goes. This was baked liked this long
> time ago, when we wanted to support Windows and there was no proper
> support for weak functions in mingw for PE/COFF (it still not
> supported but at least we do have a few patches that fix that).

You've required weak functions elsewhere, but in this case you don't
even need them since you don't need things to link without an
implementation? At least I don't see why you'd want to be able to link a
binary that doesn't have an implementation of the ops required to run?

> > Yeah, what? That's an incomprehensible piece of code. At least add
> > comments, if it _really_ is necessary?
> > 
> 
> Yeah, sorry about that. We missed adding a bunch of comments in the
> commit message. It got this complicated because of optimizations to
> avoid context switching between the native thread running the
> application and the kernel thread running the system call or interrupt
> handler.
> 
> Maybe we should revert to the initial simpler implementation for now
> and add it later?

Perhaps? Not really sure. Could the optimisations be added in steps so
they're something that can be explained/followed? If not, well, perhaps
to ease review for now it'd make sense to start simpler, but I guess
eventually it'd still want some better explanation of what's going on.

johannes

